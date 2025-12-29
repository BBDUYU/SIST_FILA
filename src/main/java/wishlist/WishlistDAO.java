package wishlist;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import com.util.DBConn;

public class WishlistDAO {
    
    public WishlistDAO() {}

    public List<WishlistDTO> getWishlist(int userNumber) {
        List<WishlistDTO> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        System.out.println("🔍 [디버깅] 위시리스트 조회 시작! 유저번호: " + userNumber);
        
        String sql = " SELECT W.WISHLIST_ID, P.PRODUCT_ID, P.NAME, P.PRICE, P.DISCOUNT_RATE, I.IMAGE_URL, W.CREATED_AT, "
                   + "       ( "
                   + "           SELECT LISTAGG(V.VALUE_NAME, ', ') WITHIN GROUP (ORDER BY V.VALUE_NAME) "
                   + "           FROM PRODUCT_OPTION_GROUPS G "
                   + "           JOIN PRODUCT_OPTION_VALUES V ON G.OPTION_GROUP_ID = V.OPTION_GROUP_ID "
                   + "           WHERE G.PRODUCT_ID = P.PRODUCT_ID AND G.OPTION_NAME LIKE '%색상%' "
                   + "       ) AS COLORS "
                   + " FROM WISHLIST W "
                   + " JOIN PRODUCTS P ON W.PRODUCT_ID = P.PRODUCT_ID "
                   + " LEFT JOIN PRODUCT_IMAGE I ON P.PRODUCT_ID = I.PRODUCT_ID AND I.IS_MAIN = 1 "
                   + " WHERE W.USER_NUMBER = ? "
                   + " ORDER BY W.CREATED_AT DESC ";

        try {
            conn = DBConn.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, userNumber);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                WishlistDTO dto = new WishlistDTO();
                dto.setWishlist_id(rs.getInt("WISHLIST_ID"));
                dto.setProduct_id(rs.getString("PRODUCT_ID"));
                dto.setName(rs.getString("NAME"));
                dto.setPrice(rs.getInt("PRICE"));          // 정가
                dto.setDiscount_rate(rs.getInt("DISCOUNT_RATE")); // 할인율
                dto.setColor_options(rs.getString("COLORS"));     // 색상 정보
                dto.setCreated_at(rs.getDate("CREATED_AT"));
                
                String img = rs.getString("IMAGE_URL");
                if(img == null) img = "//filacdn.styleship.com/filaproduct2/data/productimages/a/1/FS261FT01X001_234.jpg";
                dto.setImage_url(img);

                list.add(dto);
                System.out.println("✅ 상품 발견: " + dto.getName());
            }
        } catch (Exception e) {
        	System.out.println("🔥 [에러] 위시리스트 SQL 에러 발생!");
            e.printStackTrace();
        } finally {
            try { if(rs != null) rs.close(); } catch(Exception e) {}
            try { if(pstmt != null) pstmt.close(); } catch(Exception e) {}
            DBConn.close();
        }
        return list;
    }
    
    // 삭제 메서드는 그대로 유지...
    public int deleteWishlist(int wishlistId) {
        // (이전 코드와 동일)
        int result = 0;
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = " DELETE FROM WISHLIST WHERE WISHLIST_ID = ? ";
        try {
            conn = DBConn.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, wishlistId);
            result = pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { if(pstmt != null) pstmt.close(); } catch(Exception e) {}
            DBConn.close();
        }
        return result;
    }
}