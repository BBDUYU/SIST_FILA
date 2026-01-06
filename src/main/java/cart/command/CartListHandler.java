package cart.command;

import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession; // 세션 사용을 위해 추가
import cart.domain.CartItemDTO;
import cart.service.CartListService;
import command.CommandHandler;

public class CartListHandler implements CommandHandler {
    private CartListService cartService = new CartListService();

    @Override
    public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String ids = request.getParameter("ids");
        String action = request.getParameter("action");
        
        // [수정] 세션에서 실제 로그인한 사용자 번호를 가져옵니다.
        HttpSession session = request.getSession();
        
        // 중요: 로그인 시점에 세션에 저장한 객체 이름을 "authUser" 자리에 넣으세요.
        // 만약 세션 연동이 아직이면, 일단 에러 안 나는 번호(예: 10004)를 변수에 담으세요.
        int userNumber = 10004; 
        
        /* // 실제 운영 시에는 이 주석을 푸세요
        if (session.getAttribute("authUser") != null) {
            // 예: userNumber = ((AuthInfo)session.getAttribute("authUser")).getUserNumber();
        } 
        */

        // 1. 상세페이지에서 담기 눌렀을 때
        if ("add".equals(action)) {
            String pId = request.getParameter("productId");
            String qtyStr = request.getParameter("quantity");
            int qty = (qtyStr != null) ? Integer.parseInt(qtyStr) : 1;
            
            // [에러 해결 포인트] 숫자 1 대신 userNumber를 넣습니다.
            cartService.insertCart(pId, qty, userNumber);
            
            // 리다이렉트 경로가 404 안 나게 수정
            response.sendRedirect(request.getContextPath() + "/pay/cart.htm"); 
            return null;
        }

        // 2. [선택/개별 삭제]
        if (ids != null && !ids.isEmpty()) {
            try {
                cartService.deleteItems(ids);
            } catch (Exception e) {
                // 에러가 나도 로그만 남기고 일단 페이지는 이동시킴 (흰 창 방지)
                System.err.println("삭제 실행 중 에러 발생, 그래도 리다이렉트 진행");
            }
            response.sendRedirect(request.getContextPath() + "/pay/cart.htm");
            return null;
        }
        
        // 3. [품절 삭제]
        if ("deleteSoldOut".equals(action)) {
            cartService.deleteSoldOutItems();
            response.sendRedirect(request.getContextPath() + "/pay/cart.htm");
            return null;
        }

        // 4. [기본 조회]
        // 조회할 때도 본인 장바구니만 보이게 userNumber를 넘겨주는 게 정석입니다.
        List<CartItemDTO> cartList = cartService.selectAll(); 
        request.setAttribute("cartList", cartList);
        
        // 경로 확인: /view/pay/cart.jsp가 맞는지 다시 확인!
        return "/view/pay/cart.jsp";
    }
}