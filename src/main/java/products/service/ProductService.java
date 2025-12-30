package products.service;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.util.DBConn; // DB 연결 클래스
import categories.CategoriesDAO;
import categories.CategoriesDTO;
import products.ProductsDAO;
import products.ProductsDTO;
import products.ProductsOptionDTO;

public class ProductService {

    // 싱글톤 패턴
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
            
            // 2. 현재 카테고리 정보 가져오기
            CategoriesDTO currentCategory = null;
            if (cateId > 0) {
                currentCategory = cDao.selectCategory(conn, cateId);
            }

            // 3. ★ 제목 표시용 로직 (WOMEN > 의류)
            String mainTitle = "WOMEN"; // 기본값 (나중에 동적으로 바꾸려면 depth1 찾기 로직 필요)
            String subTitle = "전체";   // 화면에 크게 나올 이름 (예: 의류)
            int sidebarParentId = 0;    // 사이드바 목록을 뽑을 기준 ID

            if (currentCategory != null) {
                if (currentCategory.getDepth() == 1) {
                    // 1차(WOMEN)을 누른 경우 -> 사이드바는 WOMEN의 하위(의류, 신발..)
                    mainTitle = currentCategory.getName();
                    subTitle = "전체"; 
                    sidebarParentId = cateId;
                } 
                else if (currentCategory.getDepth() == 2) {
                    // 2차(의류)를 누른 경우 -> 제목은 '의류', 사이드바는 '의류'의 하위(패딩, 티셔츠..)
                    subTitle = currentCategory.getName();
                    sidebarParentId = cateId;
                    
                    // (심화) 부모(WOMEN) 이름 찾고 싶으면 여기서 cDao.selectCategory(currentCategory.getParent_id()) 하면 됨
                } 
                else if (currentCategory.getDepth() == 3) {
                    // 3차(패딩)을 누른 경우 -> ★ 제목은 부모인 '의류'로 나와야 함!
                    CategoriesDTO parent = cDao.selectCategory(conn, currentCategory.getParent_id());
                    subTitle = parent.getName(); // '의류'가 됨
                    sidebarParentId = parent.getCategory_id(); // 사이드바도 '의류'의 형제들로 유지
                }
            }

            // 4. 사이드바 목록 조회 (선택된 2차 카테고리의 하위 메뉴들)
            List<CategoriesDTO> sidebarList = null;
            Map<Integer, Integer> countMap = new HashMap<>(); // 개수 담을 바구니 (import java.util.Map, HashMap 필요)

            if(sidebarParentId > 0) {
                 sidebarList = cDao.selectChildCategories(conn, sidebarParentId);
                 
                 // ★ 사이드바 메뉴 하나하나 돌면서 상품 개수 세오기
                 if(sidebarList != null) {
                     for(CategoriesDTO cate : sidebarList) {
                         int cnt = pDao.getProductCount(conn, cate.getCategory_id());
                         countMap.put(cate.getCategory_id(), cnt); // 바구니에 (ID, 개수) 저장
                     }
                 }
            }
            
            // 5. 상품 리스트 조회
            List<ProductsDTO> list = null;
            if (cateId == 0) {
                list = pDao.selectAllProducts(conn);
            } else {
                list = pDao.selectProductsByCategory(conn, cateId);
            }
            
            // 6. JSP로 보낼 데이터 담기
            request.setAttribute("productList", list);
            request.setAttribute("sidebarList", sidebarList);
            
            request.setAttribute("mainTitle", mainTitle);
            request.setAttribute("subTitle", subTitle);
            request.setAttribute("currentCateId", cateId);

            // "전체" 버튼 활성화 여부 판단용
            request.setAttribute("sidebarParentId", sidebarParentId); 

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBConn.close();
        }
    }

    // 상세페이지용 서비스 (상품정보 + 옵션정보 가져오기)
    public void getProductDetail(HttpServletRequest request) {
        Connection conn = null;
        try {
            conn = DBConn.getConnection();
            ProductsDAO pDao = ProductsDAO.getInstance();
            
            // 1. 파라미터 받기
            String productId = request.getParameter("product_id");
            
            // 2. 상품 정보 가져오기
            ProductsDTO dto = pDao.getProduct(conn, productId);
            
            // 3. 옵션 정보 가져오기 (필요하다면)
            List<ProductsOptionDTO> options = pDao.getProductOptions(conn, productId);
            
            // 4. request에 담기
            request.setAttribute("dto", dto);         // JSP에서 ${dto.name} 이렇게 씀
            request.setAttribute("options", options); // 옵션 리스트
            
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBConn.close();
        }
    }
    
    
}