package cart.command;

import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cart.domain.CartItemDTO;
import cart.service.CartListService;
import command.CommandHandler;

public class CartListHandler implements CommandHandler {

  private CartListService cartService = new CartListService();

  @Override
  public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {

    // ★ 더미데이터 전체 확인용: user_number 조건 없이 전부 가져오기
    List<CartItemDTO> cartList = cartService.selectAll();

    // ★ 실행 콘솔에서 데이터 확인(원하던 그거)
    System.out.println("cartList size = " + cartList.size());
    if (!cartList.isEmpty()) {
      System.out.println("first item productName = " + cartList.get(0).getProductName());
    }

    request.setAttribute("cartList", cartList);

    // 본인 cart.jsp 경로로 맞추세요
    return "/view/pay/cart.jsp";
  }
}