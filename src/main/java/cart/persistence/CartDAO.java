package cart.persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import cart.domain.CartItemDTO;

public class CartDAO {

  private Connection conn;

  public CartDAO(Connection conn) {
    this.conn = conn;
  }

  public List<CartItemDTO> selectAll() throws Exception {

    String sql =
      "SELECT "
    + "    ci.cart_item_id, "
    + "    ci.user_number, "
    + "    ci.product_id, "
    + "    p.name AS product_name, "
    + "    p.price AS origin_unit_price, "
    + "    NVL(p.discount_rate, 0) AS discount_rate, "
    + "    ROUND(p.price * (100 - NVL(p.discount_rate,0)) / 100) AS sale_unit_price, "
    + "    ci.quantity, "
    + "    (ROUND(p.price * (100 - NVL(p.discount_rate,0)) / 100) * ci.quantity) AS line_amount, "
    + "    mpi.image_url AS main_image_url "
    + "FROM cart_items ci "
    + "JOIN products p ON p.product_id = ci.product_id "
    + "LEFT JOIN ( "
    + "    SELECT product_id, image_url "
    + "    FROM ( "
    + "        SELECT pi.product_id, pi.image_url, "
    + "               ROW_NUMBER() OVER ( "
    + "                   PARTITION BY pi.product_id "
    + "                   ORDER BY NVL(pi.sort_order, 999) ASC, pi.product_image_id ASC "
    + "               ) AS rn "
    + "        FROM product_image pi "
    + "        WHERE pi.is_main = 1 "
    + "    ) "
    + "    WHERE rn = 1 "
    + ") mpi ON mpi.product_id = p.product_id "
    + "ORDER BY ci.added_at DESC";

    PreparedStatement pstmt = null;
    ResultSet rs = null;

    List<CartItemDTO> list = new ArrayList<>();

    try {
      pstmt = conn.prepareStatement(sql);
      rs = pstmt.executeQuery();

      while (rs.next()) {
        CartItemDTO dto = new CartItemDTO();

        dto.setCartItemId(rs.getInt("cart_item_id"));
        dto.setUserNumber(rs.getInt("user_number"));
        dto.setProductId(rs.getInt("product_id"));
        dto.setProductName(rs.getString("product_name"));
        dto.setOriginUnitPrice(rs.getInt("origin_unit_price"));
        dto.setDiscountRate(rs.getInt("discount_rate"));
        dto.setSaleUnitPrice(rs.getInt("sale_unit_price"));
        dto.setQuantity(rs.getInt("quantity"));
        dto.setLineAmount(rs.getInt("line_amount"));
        dto.setMainImageUrl(rs.getString("main_image_url"));

        list.add(dto);
      }

    } finally {
      if (rs != null) rs.close();
      if (pstmt != null) pstmt.close();
    }

    return list;
  }
}