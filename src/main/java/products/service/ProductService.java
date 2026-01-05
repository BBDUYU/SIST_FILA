package products.service;

import java.sql.Connection;
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
            
            // 1. 파라미터 받기
            String productId = request.getParameter("product_id");
            
            if(productId == null || productId.isEmpty()) {
                request.setAttribute("errorMsg", "잘못된 접근입니다 (상품 ID 없음).");
                return;
            }

            // 2. DB 조회
            ProductsDTO dto = pDao.getProduct(conn, productId);
            List<ProductsOptionDTO> options = pDao.getProductOptions(conn, productId);
            
            if (dto == null) {
                request.setAttribute("errorMsg", "존재하지 않는 상품입니다.");
                return;
            }
            
            // 3. 할인가 계산
            int finalPrice = dto.getPrice();
            if(dto.getDiscount_rate() > 0) {
                finalPrice = dto.getPrice() * (100 - dto.getDiscount_rate()) / 100;
            }
            
            // 4. 옵션 분리 (색상/사이즈)
            ProductsOptionDTO colorOption = null;
            ProductsOptionDTO sizeOption = null;
            
            if(options != null) {
                for(ProductsOptionDTO opt : options) {
                    if(opt.getGroupName().contains("색상") || opt.getGroupName().contains("Color")) {
                        colorOption = opt;
                    } 
                    else if(opt.getGroupName().contains("사이즈") || opt.getGroupName().contains("Size")) {
                        sizeOption = opt;
                    }
                }
            }
            
            // ------------------------------------------------------------------
            // [수정 포인트] 상품 태그(스포츠/라이프스타일) DB에서 가져오기
            // ------------------------------------------------------------------
            // (숫자 2는 DB의 OPTION_MASTERS 테이블에서 '스포츠/스타일' 분류 ID라고 가정함)
            String styleTag = pDao.getProductTag(conn, productId, 2);
            
            if (styleTag == null) {
                styleTag = "라이프스타일"; 
            }
            
            // 5. 결과 저장 (JSP로 보냄)
            request.setAttribute("product", dto);        
            request.setAttribute("finalPrice", finalPrice);
            request.setAttribute("colorOption", colorOption); 
            request.setAttribute("sizeOption", sizeOption);
            request.setAttribute("styleTag", styleTag); 

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBConn.close();
        }
    }
}