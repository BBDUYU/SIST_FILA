package order.command;

import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.util.ConnectionProvider;
import com.util.JdbcUtil;

import admin.domain.UserInfoDTO;
import cart.persistence.CartDAO;
import command.CommandHandler;
import member.MemberDTO;
import net.sf.json.JSONObject;
import order.domain.OrderDTO;
import order.domain.OrderItemDTO;
import order.service.OrderService;
import products.ProductsDAO;
import products.ProductsDTO;

public class OrderHandler implements CommandHandler {

    @Override
    public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {
        // 1. 세션에서 로그인한 유저 정보 가져오기
        HttpSession session = request.getSession(); 
        MemberDTO authUser = (MemberDTO) session.getAttribute("auth"); 
        
        if (authUser == null) {
            if (request.getMethod().equalsIgnoreCase("GET")) {
                // "redirect:..." 문자열을 반환하지 말고 직접 sendRedirect를 사용하세요.
                response.sendRedirect(request.getContextPath() + "/member/login.htm");
                return null; // DispatcherServlet이 포워딩 시도를 하지 않도록 null 반환
            } else {
                response.setContentType("application/json; charset=UTF-8");
                response.getWriter().print("{\"status\":\"error\", \"message\":\"로그인이 필요합니다.\"}");
                return null;
            }
        }

        // 3. 로그인 성공 시 변수 할당
        int userNumber = authUser.getUserNumber();
        System.out.println(">>> OrderHandler 진입 성공! 유저번호: " + userNumber);

        if (request.getMethod().equalsIgnoreCase("GET")) {
            String productId = request.getParameter("productId");
            String quantity = request.getParameter("quantity");
            String combinationId = request.getParameter("combinationId");
            String cartItemIds = request.getParameter("cartItemIds");

            Connection conn = null;
            try {
                conn = ConnectionProvider.getConnection();
                List<OrderItemDTO> orderItems = new ArrayList<>();
                
                // 상품 정보 조회 로직 (기존 유지)
                if (productId != null && !productId.isEmpty()) {
                    ProductsDAO productsDao = ProductsDAO.getInstance();
                    ProductsDTO product = productsDao.getProduct(conn, productId);
                    if (product != null) {
                        int originPrice = product.getPrice();
                        int salePrice = originPrice * (100 - product.getDiscount_rate()) / 100;
                        orderItems.add(OrderItemDTO.builder()
                            .productId(productId).productName(product.getName())
                            .quantity(Integer.parseInt(quantity)).combinationId(Integer.parseInt(combinationId))
                            .originalPrice(originPrice).price(salePrice).build());
                        request.setAttribute("isDirect", true);
                    }
                } else if (cartItemIds != null && !cartItemIds.isEmpty()) {
                    CartDAO cartDao = CartDAO.getInstance();
                    orderItems = cartDao.selectSelectedCartItems(conn, cartItemIds);
                    request.setAttribute("cartItemIds", cartItemIds);
                }

                if (orderItems.isEmpty()) return "/pay/cart.htm";

                UserInfoDTO userDetail = new UserInfoDTO();
                
                // 포인트 조회 (이제 userNumber 변수를 인식합니다)
                int myPoint = 0;
                String pointSql = "SELECT NVL(SUM(CASE WHEN POINT_TYPE = '적립' THEN AMOUNT ELSE -AMOUNT END), 0) FROM USERPOINTS WHERE USER_NUMBER = ?";
                try (PreparedStatement pstmt = conn.prepareStatement(pointSql)) {
                    pstmt.setInt(1, userNumber);
                    try (ResultSet rs = pstmt.executeQuery()) {
                        if (rs.next()) myPoint = rs.getInt(1);
                    }
                }
                userDetail.setBalance(myPoint);

                // 쿠폰 조회 (이제 userNumber 변수를 인식합니다)
                List<UserInfoDTO> couponList = new ArrayList<>();
                String couponSql = "SELECT uc.USER_COUPON_ID, c.NAME, c.DISCOUNT_TYPE, c.DISCOUNT_VALUE " +
                                   "FROM USER_COUPON uc JOIN COUPON c ON uc.COUPON_ID = c.COUPON_ID " +
                                   "WHERE uc.USER_NUMBER = ? AND uc.IS_USED = 0 AND uc.EXPIRE_DATE >= SYSDATE";
                try (PreparedStatement pstmt = conn.prepareStatement(couponSql)) {
                    pstmt.setInt(1, userNumber);
                    try (ResultSet rs = pstmt.executeQuery()) {
                        while (rs.next()) {
                            UserInfoDTO cp = new UserInfoDTO();
                            cp.setUsercouponid(rs.getInt("USER_COUPON_ID"));
                            cp.setCoupon_name(rs.getString("NAME"));
                            cp.setDiscount_type(rs.getString("DISCOUNT_TYPE"));
                            cp.setPrice(rs.getInt("DISCOUNT_VALUE"));
                            couponList.add(cp);
                        }
                    }
                }
                userDetail.setCouponList(couponList);

                int totalOriginalPrice = 0;
                int totalSalePrice = 0;
                for(OrderItemDTO item : orderItems) {
                    totalOriginalPrice += (item.getOriginalPrice() * item.getQuantity());
                    totalSalePrice += (item.getPrice() * item.getQuantity());
                }

                request.setAttribute("orderItems", orderItems);
                request.setAttribute("totalOriginalPrice", totalOriginalPrice);
                request.setAttribute("totalSalePrice", totalSalePrice);
                request.setAttribute("user", userDetail);

            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                JdbcUtil.close(conn);
            }
            return "/view/order/order_pay.jsp";
        }

        else { // POST 처리
            response.setContentType("application/json; charset=UTF-8");
            PrintWriter out = response.getWriter();
            JSONObject jsonResponse = new JSONObject();

            try (Connection conn = ConnectionProvider.getConnection()) {
                // 파라미터 체크 및 파싱
                String addrIdStr = request.getParameter("address_id");
                int addressId = (addrIdStr != null) ? Integer.parseInt(addrIdStr) : 0;
                int totalAmount = Integer.parseInt(request.getParameter("OrderTotalPrice"));
                String deliveryMethod = request.getParameter("deliveryOption");
                String deliveryRequest = request.getParameter("OrderContents");
                String paymentMethod = request.getParameter("gopaymethod");
                String cartItemIds = request.getParameter("cartItemIds");
                
                int usedPoint = 0;
                String usemileStr = request.getParameter("usemile");
                if(usemileStr != null && !usemileStr.isEmpty()) usedPoint = Integer.parseInt(usemileStr);

                // [수정] userNumber가 변수로 선언되어 에러가 나지 않습니다.
                OrderDTO order = OrderDTO.builder()
                        .userNumber(userNumber) 
                        .addressId(addressId)
                        .totalAmount(totalAmount)
                        .deliveryMethod("1".equals(deliveryMethod) ? "오늘도착" : "일반배송")
                        .deliveryRequest(deliveryRequest)
                        .paymentMethod(paymentMethod)
                        .usedPoint(usedPoint)
                        .build();

                CartDAO cartDao = CartDAO.getInstance();
                List<OrderItemDTO> items = new ArrayList<>();
                
                if (cartItemIds != null && !cartItemIds.isEmpty()) {
                    items = cartDao.selectSelectedCartItems(conn, cartItemIds);
                } else {
                    // 바로구매 시 POST 파라미터 읽기
                    String pId = request.getParameter("productId");
                    String qtyStr = request.getParameter("quantity");
                    String cIdStr = request.getParameter("combinationId");
                    
                    if (pId != null && qtyStr != null) {
                        items.add(OrderItemDTO.builder()
                                .productId(pId)
                                .quantity(Integer.parseInt(qtyStr))
                                .combinationId(Integer.parseInt(cIdStr))
                                .build());
                    }
                }

                OrderService orderService = OrderService.getInstance();
                String orderId = orderService.processOrder(order, items);

                jsonResponse.put("status", "success");
                jsonResponse.put("redirect", request.getContextPath() + "/order/complete.htm?orderId=" + orderId);
                out.print(jsonResponse.toString());

            } catch (Exception e) {
                e.printStackTrace();
                jsonResponse.put("status", "error");
                jsonResponse.put("message", e.getMessage());
                out.print(jsonResponse.toString());
            }
            return null;
        }
    }
}