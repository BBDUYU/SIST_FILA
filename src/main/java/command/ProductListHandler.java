package command;

import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import products.ProductsDTO;
import products.service.ProductService;
import service.MainService;

public class ProductListHandler implements CommandHandler {

    @Override
    public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {
        // 1. 서비스 객체 준비
        ProductService productService = ProductService.getInstance();
        
        // 2. 검색어 파라미터 확인
        String searchItem = request.getParameter("searchItem");
        
        // 3. 비즈니스 로직 수행
        if (searchItem != null && !searchItem.trim().isEmpty()) {
            // [A] 검색어가 있는 경우: 검색 전용 메서드만 실행
            List<ProductsDTO> productList = productService.searchProducts(searchItem);
            request.setAttribute("productList", productList);
            
            // 검색 결과 페이지를 위한 제목 설정
            request.setAttribute("mainTitle", "SEARCH");
            request.setAttribute("subTitle", "'" + searchItem + "' 검색 결과");
        } else {
            // [B] 검색어가 없는 경우: 기존 카테고리/전체보기 로직 수행
            // 이 메서드 내부에서 request.setAttribute("productList", ...) 등을 처리함
            productService.getProductList(request);
        }

        // 4. 인기 검색어 세션 갱신 (헤더용)
        try {
            Map<String, Object> mainData = MainService.getInstance().getMainData(null); 
            request.getSession().setAttribute("popularKeywords", mainData.get("popularKeywords"));
        } catch (Exception e) {
            // 메인 데이터 조회 실패 시 로그만 남기고 중단되지 않도록 처리
            e.printStackTrace();
        }
        
        // 5. 뷰 페이지(JSP) 경로 리턴 (경로가 /view/product/ 인지 /product/ 인지 다시 확인!)
        return "/view/product/list.jsp";
    }
}