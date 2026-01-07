package cart.command;

import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import cart.domain.CartItemDTO;
import cart.service.CartListService;
import command.CommandHandler;
import member.MemberDTO;

public class CartListHandler implements CommandHandler {
    private CartListService cartService = new CartListService();

    @Override
    public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String ids = request.getParameter("ids");
        String action = request.getParameter("action");

        // 1) 상세페이지에서 담기 눌렀을 때 (로그인한 사용자만)
        if ("add".equals(action)) {

            HttpSession session = request.getSession(false);
            MemberDTO auth = (session == null) ? null : (MemberDTO) session.getAttribute("auth");

            if (auth == null) {
                String returnUrl = request.getRequestURI();
                if (request.getQueryString() != null) {
                    returnUrl += "?" + request.getQueryString();
                }
                String encoded = URLEncoder.encode(returnUrl, StandardCharsets.UTF_8.name());

                response.sendRedirect(request.getContextPath() + "/login.htm?returnUrl=" + encoded);
                return null;
            }

            int userNumber = auth.getUserNumber();

            String pId   = request.getParameter("productId");
            String qtyStr = request.getParameter("quantity");
            String combiIdStr = request.getParameter("combinationId");
            int qty = (qtyStr != null) ? Integer.parseInt(qtyStr) : 1;
            int combinationId = (combiIdStr != null) ? Integer.parseInt(combiIdStr) : 0; // 숫자로 변환
            
            try {
                // ✅ 실제 장바구니 담기
                cartService.insertCart(pId, qty, userNumber, combinationId);

                // ✅ 성공 → 장바구니 페이지
                response.sendRedirect(request.getContextPath() + "/pay/cart.htm");
                return null;

            } catch (Exception e) {

                // 🔥 여기서 원인 다 나온다 (콘솔 꼭 확인)
                e.printStackTrace();

                // ❗ 사용자에게는 상세 숨기고 상품 상세로 되돌림
                response.sendRedirect(
                    request.getContextPath()
                    + "/product/product_detail.htm?product_id="
                    + URLEncoder.encode(pId, StandardCharsets.UTF_8.name())
                );
                return null;
            }
        }


        // 2) [선택/개별 삭제]
        if (ids != null && !ids.isEmpty()) {
            cartService.deleteItems(ids);
            response.sendRedirect(request.getContextPath() + "/pay/cart.htm");
            return null;
        }

	    // 3. [전체 삭제]
	    if ("clear".equals(action)) {
	        HttpSession session = request.getSession(false);
	        MemberDTO auth = (MemberDTO) session.getAttribute("auth");
	        int userNumber = auth.getUserNumber();
	
	        cartService.deleteAllItems(userNumber);
	
	        response.sendRedirect(request.getContextPath() + "/pay/cart.htm");
	        return null;
	    }


        // 4) [수량 변경] (이건 조회 전에 처리하는 게 맞음)
        if ("update".equals(action)) {
            int cartItemId = Integer.parseInt(request.getParameter("cartItemId"));
            int qty = Integer.parseInt(request.getParameter("quantity"));

            cartService.updateItem(cartItemId, qty);

            response.sendRedirect(request.getContextPath() + "/pay/cart.htm");
            return null;
        }

        // 5) [기본 조회]
        HttpSession session = request.getSession(false);
        MemberDTO auth = (session == null) ? null : (MemberDTO) session.getAttribute("auth");

        if (auth == null) {
            // 장바구니 페이지를 그냥 열려고 할 때도 로그인이 안 되어 있으면 로그인 페이지로 보냄
            response.sendRedirect(request.getContextPath() + "/login.htm");
            return null;
        }

        int userNumber = auth.getUserNumber();

        // ✅ 서비스에 userNumber를 넘겨서 '나의' 장바구니만 가져옵니다.
        List<CartItemDTO> cartList = cartService.selectAll(userNumber); 
        request.setAttribute("cartList", cartList);

        return "/view/pay/cart.jsp";
    }
}