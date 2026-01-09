package command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import products.service.ProductService;

public class ProductDetailHandler implements CommandHandler {
	
    @Override
    public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {
        ProductService service = ProductService.getInstance();
        service.getProductDetail(request);
        return "/view/product/product_detail.jsp"; 
    }
}