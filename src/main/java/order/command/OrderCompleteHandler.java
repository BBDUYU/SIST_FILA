package order.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import command.CommandHandler;

public class OrderCompleteHandler implements CommandHandler {
    @Override
    public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {
        // 성공한 주문번호를 받아 JSP에 전달
        String orderId = request.getParameter("orderId");
        request.setAttribute("orderId", orderId);
        
        return "/view/order/order_complete.jsp";
    }
}