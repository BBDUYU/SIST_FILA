package products.service;

import java.io.File;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.util.DBConn; 
import categories.CategoriesDAO;
import categories.CategoriesDTO;
import products.ProductsDAO;
import products.ProductsDTO;
import products.ProductsOptionDTO;

public class ProductService {

    private static ProductService instance = null;
    private ProductService() {}
    public static ProductService getInstance() {
        if(instance == null) instance = new ProductService();
        return instance;
    }

    // ★ 핸들러가 호출할 핵심 메서드
    public void getProductList(HttpServletRequest request) {
        Connection conn = null;
        try {
            conn = DBConn.getConnection();
            ProductsDAO pDao = ProductsDAO.getInstance();
            CategoriesDAO cDao = CategoriesDAO.getInstance();
            
            // 1. 카테고리 ID 받기
            String cateParam = request.getParameter("category");
            int cateId = (cateParam != null) ? Integer.parseInt(cateParam) : 0;
            
            // 2. 제목(Title) 자동 완성 로직
            String mainTitle = ""; // 초기화
            String subTitle = "전체보기"; // 기본값
            
            if (cateId > 0) {
                CategoriesDTO curDto = cDao.selectCategory(conn, cateId);
                
                if (curDto != null) {
                    // [A] 대분류(Main Title) 구하기
                    CategoriesDTO parent = null; 
                    
                    if (curDto.getDepth() == 1) {
                        mainTitle = curDto.getName();
                    } else if (curDto.getDepth() == 2) {
                        parent = cDao.selectCategory(conn, curDto.getParent_id());
                        if (parent != null) mainTitle = parent.getName();
                    } else if (curDto.getDepth() == 3) {
                        parent = cDao.selectCategory(conn, curDto.getParent_id());
                        if (parent != null) {
                            CategoriesDTO grandParent = cDao.selectCategory(conn, parent.getParent_id());
                            if (grandParent != null) mainTitle = grandParent.getName();
                        }
                    }

                    // [B] 소분류(Sub Title) 구하기
                    if (curDto.getDepth() == 3) {
                        if (parent == null) parent = cDao.selectCategory(conn, curDto.getParent_id());

                        if (parent != null && parent.getName().equalsIgnoreCase("NewFeatured")) {
                            String myName = curDto.getName();
                            if (myName.equals("베스트")) subTitle = "BEST";
                            else if (myName.equals("세일")) subTitle = "SALE";
                            else subTitle = myName; 
                        } else {
                            if (parent != null) subTitle = parent.getName();
                        }
                        
                    } else if (curDto.getDepth() == 2) {
                        subTitle = curDto.getName();
                    }
                }
            }
            
            if (mainTitle.equals("")) mainTitle = "WOMEN";

            // 3. 왼쪽 사이드바 기준점 잡기
            int sidebarParentId = 0;
            CategoriesDTO currentCategory = null;
            
            if (cateId > 0) {
                currentCategory = cDao.selectCategory(conn, cateId);
                if (currentCategory != null) {
                    if (currentCategory.getDepth() == 1) {
                        sidebarParentId = cateId;
                    } else if (currentCategory.getDepth() == 2) {
                        sidebarParentId = cateId;
                    } else if (currentCategory.getDepth() == 3) {
                        CategoriesDTO parent = cDao.selectCategory(conn, currentCategory.getParent_id());
                        sidebarParentId = parent.getCategory_id();
                    }
                }
            }

            // 4. 사이드바 목록 조회
            List<CategoriesDTO> sidebarList = null;
            if (sidebarParentId > 0) {
                 sidebarList = cDao.selectChildCategories(conn, sidebarParentId);
            } else {
                 sidebarList = cDao.selectMainCategories(conn); 
            }
            
            if (sidebarList != null) {
                int totalCount = 0; // 전체 개수를 담을 변수
                for (CategoriesDTO side : sidebarList) {
                    int realCount = pDao.getProductCount(conn, side.getCategory_id());
                    side.setProduct_count(realCount);
                    
                    totalCount += realCount; // 각 카테고리의 개수를 더함
                }
                // 계산된 전체 합계를 JSP로 보냄
                request.setAttribute("totalSidebarCount", totalCount);
            }

            // 5. 상품 리스트 조회
            List<ProductsDTO> list = null;
            if (cateId == 0) {
                list = pDao.selectAllProducts(conn);
            } else {
                list = pDao.selectProductsByCategory(conn, cateId);
            }
            
            // 6. JSP 전송
            request.setAttribute("productList", list);
            request.setAttribute("sidebarList", sidebarList);
            request.setAttribute("mainTitle", mainTitle); 
            request.setAttribute("subTitle", subTitle);   
            request.setAttribute("currentCateId", cateId);
            request.setAttribute("sidebarParentId", sidebarParentId); 

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBConn.close();
        }
    }

    // 상세페이지
    public void getProductDetail(HttpServletRequest request) {
        Connection conn = null;
        try {
            conn = DBConn.getConnection();
            ProductsDAO pDao = ProductsDAO.getInstance();
            CategoriesDAO cDao = CategoriesDAO.getInstance();
            
            // 1. 파라미터 받기
            String productId = request.getParameter("product_id");
            if(productId == null || productId.isEmpty()) return;

            // 2. 기본 상품 정보 조회
            ProductsDTO dto = pDao.getProduct(conn, productId);
            
            // -----------------------------------------------------------
            // 3. 상품 정보가 있을 때만 모든 로직 실행 (Null 방지)
            // -----------------------------------------------------------
            if (dto != null) {
                productId = dto.getProduct_id();
                
                // [A] 이미지 파일 스캔 (C:\fila_upload\product\ID 폴더 기반)
                List<String> mainImages = new ArrayList<>();
                List<String> modelImages = new ArrayList<>();
                List<String> detailImages = new ArrayList<>();
                
                File dir = new File("C:\\fila_upload\\product\\" + productId);
                if (dir.exists() && dir.isDirectory()) {
                    File[] files = dir.listFiles();
                    if (files != null) {
                        for (File file : files) {
                            String name = file.getName();
                            if (name.contains("_main_")) mainImages.add(name);
                            else if (name.contains("_model_")) modelImages.add(name);
                            else if (name.contains("_detail_")) detailImages.add(name);
                        }
                    }
                }
                Collections.sort(mainImages);
                Collections.sort(modelImages);
                Collections.sort(detailImages);

                // [B] 사이즈 옵션 데이터 구성
                // 사이즈(500번대): VALUES와 MASTER를 조인해서 실제 사이즈 이름과 재고를 가져옴
                List<ProductsOptionDTO> sizeOptions = pDao.getProductOptions(conn, productId);
                
                // [C] 하단 추천 상품 (같은 카테고리 내 랜덤 12개)
                List<ProductsDTO> relatedList = pDao.selectProductsByCategory(conn, dto.getCategory_id());

                // [D] 대분류(Depth 1) 추적 및 genderTag (FEMALE/MALE) 설정
                CategoriesDTO curDto = cDao.selectCategory(conn, dto.getCategory_id());
                String genderTag = "FILA"; // 기본값
                if (curDto != null) {
                    String depth1Name = "";
                    if (curDto.getDepth() == 1) depth1Name = curDto.getName();
                    else if (curDto.getDepth() == 2) {
                        CategoriesDTO parent = cDao.selectCategory(conn, curDto.getParent_id());
                        if (parent != null) depth1Name = parent.getName();
                    } else if (curDto.getDepth() == 3) {
                        CategoriesDTO parent = cDao.selectCategory(conn, curDto.getParent_id());
                        if (parent != null) {
                            CategoriesDTO grandParent = cDao.selectCategory(conn, parent.getParent_id());
                            if (grandParent != null) depth1Name = grandParent.getName();
                        }
                    }
                    // 한글 대분류를 영문으로 변환
                    if ("여성".equals(depth1Name)) genderTag = "FEMALE";
                    else if ("남성".equals(depth1Name)) genderTag = "MALE";
                    else if (!depth1Name.isEmpty()) genderTag = depth1Name;
                }

                // [E] 할인가 계산
                int finalPrice = dto.getPrice();
                if(dto.getDiscount_rate() > 0) {
                    finalPrice = dto.getPrice() * (100 - dto.getDiscount_rate()) / 100;
                }

                // [F] 스타일 태그 (스포츠/라이프스타일 분류 정보)
                String styleTag = pDao.getProductTag(conn, productId, 2);
                if (styleTag == null) styleTag = "라이프스타일";

                // -----------------------------------------------------------
                // 4. JSP 전송 (Attribute 설정)
                // -----------------------------------------------------------
                request.setAttribute("product", dto);
                request.setAttribute("mainImages", mainImages);
                request.setAttribute("modelImages", modelImages);
                request.setAttribute("detailImages", detailImages);
                request.setAttribute("sizeOptions", sizeOptions);     // 사이즈 리스트
                request.setAttribute("relatedList", relatedList);     // 추천 상품
                request.setAttribute("finalPrice", finalPrice);
                request.setAttribute("styleTag", styleTag);
                request.setAttribute("genderTag", genderTag);
                
                // JSP의 <c:if test="${not empty sizeOption}"> 호환용
                if(sizeOptions != null && !sizeOptions.isEmpty()) {
                    request.setAttribute("sizeOption", "Y");
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBConn.close();
        }
    }
    
    
}