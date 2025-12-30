package command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import products.service.ProductService;

public class ProductDetailHandler implements CommandHandler {

    @Override
    public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {
        
        // 1. 서비스 불러서 상품 정보 가져오라고 시킴
        ProductService service = ProductService.getInstance();
        service.getProductDetail(request);
        
        // 2. JSP 파일명
        return "/view/product/product_detail.jsp"; 
    }
}