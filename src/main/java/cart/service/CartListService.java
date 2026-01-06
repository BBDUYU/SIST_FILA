package cart.service;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import cart.domain.CartItemDTO;
import com.util.DBConn; 

public class CartListService {

    // [1] 장바구니 담기 (핸들러의 cartService.insertCart와 이름 일치시킴)
    public void insertCart(String productId, int quantity, int userNumber) throws Exception {
        String sql = "INSERT INTO CART_ITEMS (CART_ITEM_ID, USER_NUMBER, PRODUCT_ID, QUANTITY, ADDED_AT) "
                   + "VALUES ((SELECT nvl(max(CART_ITEM_ID), 0) + 1 FROM CART_ITEMS), ?, ?, ?, SYSDATE)";
        
        // try-with-resources: 작업 끝나면 자동으로 DB 연결을 닫아서 '접속 종료' 에러를 예방함
        try (Connection conn = DBConn.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, userNumber);
            pstmt.setString(2, productId);
            pstmt.setInt(3, quantity);
            pstmt.executeUpdate();
            
            if (!conn.getAutoCommit()) conn.commit();
        } catch (SQLException e) {
            System.err.println("장바구니 담기 중 에러: " + e.getMessage());
            throw e;
        }
    }

    // [2] 전체 조회 (selectAll)
    public List<CartItemDTO> selectAll() throws Exception {
        String sql = "SELECT ci.cart_item_id, ci.user_number, ci.product_id, p.name AS product_name, p.price AS origin_unit_price, NVL(p.discount_rate, 0) AS discount_rate, ROUND(p.price * (100 - NVL(p.discount_rate,0)) / 100) AS sale_unit_price, ci.quantity, (ROUND(p.price * (100 - NVL(p.discount_rate,0)) / 100) * ci.quantity) AS line_amount, mpi.image_url AS main_image_url FROM cart_items ci JOIN products p ON p.product_id = ci.product_id LEFT JOIN (SELECT product_id, image_url FROM (SELECT pi.product_id, pi.image_url, ROW_NUMBER() OVER (PARTITION BY pi.product_id ORDER BY NVL(pi.sort_order, 999) ASC, pi.product_image_id ASC) AS rn FROM product_image pi WHERE pi.is_main = 1) WHERE rn = 1) mpi ON mpi.product_id = p.product_id ORDER BY ci.added_at DESC";
        
        List<CartItemDTO> list = new ArrayList<>();
        try (Connection conn = DBConn.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            
            while (rs.next()) {
                CartItemDTO dto = new CartItemDTO();
                dto.setCartItemId(rs.getInt("cart_item_id"));
                dto.setUserNumber(rs.getInt("user_number"));
                dto.setProductId(rs.getString("product_id"));
                dto.setProductName(rs.getString("product_name"));
                dto.setOriginUnitPrice(rs.getInt("origin_unit_price"));
                dto.setDiscountRate(rs.getInt("discount_rate"));
                dto.setSaleUnitPrice(rs.getInt("sale_unit_price"));
                dto.setQuantity(rs.getInt("quantity"));
                dto.setLineAmount(rs.getInt("line_amount"));
                dto.setMainImageUrl(rs.getString("main_image_url"));
                list.add(dto);
            }
        }
        return list;
    }

    // [3] 선택 삭제 (deleteItems)
    public void deleteItems(String ids) throws Exception {
        if (ids == null || ids.trim().isEmpty()) return;
        String sql = "DELETE FROM cart_items WHERE cart_item_id IN (" + ids + ")";
        
        try (Connection conn = DBConn.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.executeUpdate();
            if (!conn.getAutoCommit()) conn.commit();
        }
    }

    // [4] 품절 삭제 (deleteSoldOutItems)
    public void deleteSoldOutItems() throws Exception {
        String sql = "DELETE FROM cart_items WHERE product_id IN (SELECT product_id FROM products WHERE stock <= 0)";
        try (Connection conn = DBConn.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.executeUpdate();
            if (!conn.getAutoCommit()) conn.commit();
        }
    }
}