package order.service;

import java.sql.Connection;
import java.util.List;

import com.util.ConnectionProvider;
import com.util.JdbcUtil;

import order.domain.OrderDTO;
import order.domain.OrderItemDTO;
import order.persistence.OrderDAO;

public class OrderService {
    private OrderService() {}
    private static OrderService instance = new OrderService();
    public static OrderService getInstance() { return instance; }

    private OrderDAO orderDao = OrderDAO.getInstance();
    
    // 장바구니 비우기 등을 위해 필요 (기존에 만드신 DAO가 있다면 사용)
    // private CartListDAO cartDao = CartListDAO.getInstance();

    /**
     * [결제 프로세스 통합 관리]
     * @param order 주문 기본 정보 및 결제 수단
     * @param items 주문할 상품 리스트
     * @return 생성된 주문번호
     */
    public String processOrder(OrderDTO order, List<OrderItemDTO> items, String cartItemIds) {
        Connection conn = null;
        String generatedOrderId = null;

        try {
            conn = ConnectionProvider.getConnection();
            conn.setAutoCommit(false); // 🚩 트랜잭션 시작

            // 1. 주문번호 생성
            generatedOrderId = orderDao.generateOrderId(conn);
            order.setOrderId(generatedOrderId);

            // 2. ORDERS 테이블 저장
            orderDao.insertOrder(conn, order);

            // 3. ORDER_ITEMS 테이블 저장 (Batch 실행)
            for (OrderItemDTO item : items) {
                item.setOrderId(generatedOrderId); // 생성된 주문번호 매핑
            }
            orderDao.insertOrderItems(conn, items);
            for (OrderItemDTO item : items) {
                int stockResult = orderDao.updateDecreaseStock(conn, item.getCombinationId(), item.getQuantity());
                if (stockResult == 0) {
                    // 재고가 부족하거나 없으면 예외를 던져 Catch문으로 이동(롤백)시킴
                    throw new RuntimeException("상품[" + item.getCombinationId() + "]의 재고가 부족합니다.");
                }
            }
            // 4. PAYMENT 테이블 저장
            orderDao.insertPayment(conn, generatedOrderId, order.getTotalAmount(), order.getPaymentMethod());

         // 5. 포인트 사용 처리 (사용한 포인트가 0보다 크면)
         // OrderService.java 일부

            if (order.getUsedPoint() > 0) {
                // [CASE 1] 포인트 사용 시: 차감만 하고 '적립 로직'은 아예 실행 안 함
                orderDao.insertPointHistory(conn, order.getUserNumber(), generatedOrderId, order.getUsedPoint());
            } else {
                // [CASE 2] 포인트 미사용 시: 5% 적립 수행
                int rewardPoint = (int)(order.getTotalAmount() * 0.05);
                if (rewardPoint > 0) {
                    orderDao.insertOrderPoint(conn, order.getUserNumber(), rewardPoint, generatedOrderId);
                }
            }
            // 6. 쿠폰 사용 처리 (쿠폰을 선택했을 경우만)
            if (order.getUserCouponId() > 0) {
                orderDao.updateCouponUsed(conn, order.getUserCouponId());
            }
            
            // 7. 장바구니 비우기 (주문 완료된 상품들)
            if (cartItemIds != null && !cartItemIds.isEmpty()) {
                cart.persistence.CartDAO cartDao = cart.persistence.CartDAO.getInstance();
                cartDao.deleteCartItems(conn, cartItemIds, order.getUserNumber());
            }
            conn.commit(); // ✅ 모든 작업 성공 시 최종 확정
            System.out.println("✅ 주문 완료: " + generatedOrderId);

        } catch (Exception e) {
            JdbcUtil.rollback(conn); // ❌ 하나라도 실패 시 전체 롤백
            e.printStackTrace();
            throw new RuntimeException("주문 처리 중 오류 발생: " + e.getMessage());
        } finally {
            JdbcUtil.close(conn);
        }

        return generatedOrderId;
    }
}