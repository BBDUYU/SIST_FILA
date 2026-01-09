package mypage;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.util.JdbcUtil;

public class WishListDAO {

    // 싱글톤 패턴
    private static WishListDAO instance = new WishListDAO();
    public static WishListDAO getInstance() { return instance; }
    public WishListDAO() {}

    // -----------------------------------------------------------
    // 1. 유저 위시리스트 목록 조회 (상품명/가격/대표이미지/사이즈만)
    // -----------------------------------------------------------
    public List<WishListDTO> selectWishListByUser(Connection conn, int userNumber) throws SQLException {

        List<WishListDTO> list = new ArrayList<>();
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        String sql =
        	    "SELECT " +
        	    "  W.WISHLIST_ID, W.USER_NUMBER, W.PRODUCT_ID, W.CREATED_AT, " +
        	    "  P.NAME AS PRODUCT_NAME, P.PRICE, NVL(P.DISCOUNT_RATE,0) AS DISCOUNT_RATE, " +
        	    "  I.IMAGE_URL " +
        	    "FROM WISHLIST W " +
        	    "JOIN PRODUCTS P ON W.PRODUCT_ID = P.PRODUCT_ID " +
        	    "LEFT JOIN PRODUCT_IMAGE I ON P.PRODUCT_ID = I.PRODUCT_ID AND I.IS_MAIN = 1 " +
        	    "WHERE W.USER_NUMBER = ? " +
        	    "ORDER BY W.CREATED_AT DESC, W.WISHLIST_ID DESC";


        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, userNumber);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                list.add(makeDTO(rs));
            }
        } finally {
            JdbcUtil.close(rs);
            JdbcUtil.close(pstmt);
        }

        return list;
    }

    // -----------------------------------------------------------
    // [헬퍼] DTO 생성
    // -----------------------------------------------------------
    private WishListDTO makeDTO(ResultSet rs) throws SQLException {

        WishListDTO dto = new WishListDTO();

        // 1) WISHLIST 컬럼
        dto.setWishlist_id(rs.getInt("WISHLIST_ID"));
        dto.setUser_number(rs.getInt("USER_NUMBER"));
        dto.setProduct_id(rs.getString("PRODUCT_ID"));
        dto.setCreated_at(rs.getDate("CREATED_AT"));

        // 2) 조인 컬럼
        dto.setProduct_name(rs.getString("PRODUCT_NAME"));
        dto.setPrice(rs.getInt("PRICE"));
        dto.setDiscount_rate(rs.getInt("DISCOUNT_RATE"));

        String img = rs.getString("IMAGE_URL");
        if (img == null) img = "//filacdn.styleship.com/filaproduct2/data/productimages/a/1/FS261FT01X001_234.jpg";
        dto.setImage_url(img);


        return dto;
    }
}
