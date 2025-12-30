package command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import products.service.ProductService; // 서비스 가져오기

public class ProductListHandler implements CommandHandler {

    @Override
    public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {
        
        // 1. 서비스 객체 가져오기
        ProductService service = ProductService.getInstance();
        
        // 2. 서비스 실행 (DB에서 데이터 가져와서 request에 넣음)
        service.getProductList(request);
        
        // 3. 뷰 페이지(JSP) 경로 리턴
        return "/view/product/list.jsp";
    }
}