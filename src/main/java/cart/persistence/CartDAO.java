package cart.persistence;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import cart.domain.CartItemDTO;

public class CartDAO {
    private Connection conn;
    public CartDAO(Connection conn) { this.conn = conn; }

    // [1] 전체 조회
    public List<CartItemDTO> selectAll() throws Exception {
        
    	String sql =
    			  "SELECT ci.cart_item_id, ci.user_number, ci.product_id, " +
    			  "       p.name AS product_name, p.price AS origin_unit_price, " +
    			  "       NVL(p.discount_rate, 0) AS discount_rate, " +
    			  "       ROUND(p.price * (100 - NVL(p.discount_rate,0)) / 100) AS sale_unit_price, " +
    			  "       ci.quantity, " +
    			  "       (ROUND(p.price * (100 - NVL(p.discount_rate,0)) / 100) * ci.quantity) AS line_amount, " +
    			  "       mpi.image_url AS main_image_url, " +
    			  "       CAST(NULL AS VARCHAR2(50)) AS size " +   // ✅ size 없으면 일단 NULL로
    			  "FROM cart_items ci ...";

    	
    	List<CartItemDTO> list = new ArrayList<>();
        
    	try (PreparedStatement pstmt = conn.prepareStatement(sql);
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
                dto.setSize(rs.getString("size"));
                dto.setQuantity(rs.getInt("quantity"));
                dto.setLineAmount(rs.getInt("line_amount"));
                dto.setMainImageUrl(rs.getString("main_image_url"));
                list.add(dto);
            }
        }
        return list;
    }

    // [2] 담기 (이름을 insertCart로 맞춤)
    public void insertCart(String productId, int quantity, int userNumber) throws Exception {
        String sql =
            "INSERT INTO CART_ITEMS (CART_ITEM_ID, USER_NUMBER, PRODUCT_ID, COMBINATION_ID, QUANTITY, ADDED_AT) " +
            "VALUES ((SELECT NVL(MAX(CART_ITEM_ID), 0) + 1 FROM CART_ITEMS), ?, ?, ?, ?, SYSDATE)";

        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, userNumber);
            pstmt.setString(2, productId);
            pstmt.setNull(3, Types.NUMERIC);
            pstmt.setInt(4, quantity);
            pstmt.executeUpdate();
        }
    }

    // [3] 선택 삭제
    public int deleteItems(String ids) throws Exception {
        String sql = "DELETE FROM cart_items WHERE cart_item_id IN (" + ids + ")";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            return pstmt.executeUpdate();
        }
    }

    // [4] 품절 삭제
    public int deleteSoldOutItems() throws Exception {
        String sql = "DELETE FROM cart_items WHERE product_id IN (SELECT product_id FROM products WHERE stock <= 0)";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            return pstmt.executeUpdate();
        }
    }
    
    // [5] 수량 변경
    public int updateQuantity(int cartItemId, int quantity) throws Exception {
        String sql = "UPDATE cart_items SET quantity = ? WHERE cart_item_id = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, quantity);
            pstmt.setInt(2, cartItemId);
            return pstmt.executeUpdate();
        }
    }
}