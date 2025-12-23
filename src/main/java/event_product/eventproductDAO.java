package event_product;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.util.JdbcUtil;

public class eventproductDAO {
    
    private static eventproductDAO instance = new eventproductDAO();
    public static eventproductDAO getInstance() { return instance; }
    private eventproductDAO() {}


    public ArrayList<eventproductDTO> selectRecommendKeywords(Connection conn) throws SQLException {
        ArrayList<eventproductDTO> list = new ArrayList<>();
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            // 1. 이벤트 이름 (IS_ACTIVE가 1인 것: 1, 2, 5번 조회됨)
            String sqlEvent = "SELECT EVENT_NAME, SLUG, EVENT_ID FROM EVENT " +
                              "WHERE IS_ACTIVE = 1 " + 
                              "ORDER BY EVENT_ID DESC";
            
            pstmt = conn.prepareStatement(sqlEvent);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                list.add(eventproductDTO.builder()
                        .event_name(rs.getString("EVENT_NAME"))
                        .slug(rs.getString("SLUG"))
                        .event_id(rs.getInt("EVENT_ID"))
                        .build());
            }
            JdbcUtil.close(rs);

            // 2. 이벤트 상품 이름 (조인 성공 시 'FILA 레이 트레이서' 등 조회됨)
            // STATUS 조건을 빼거나 실제 존재하는 'SALE', 'NEW' 등으로 수정
            String sqlProduct = "SELECT p.NAME, p.PRODUCT_ID FROM EVENT_PRODUCT ep " +
                                "JOIN PRODUCTS p ON ep.PRODUCT_ID = p.PRODUCT_ID " +
                                "WHERE p.STATUS IN ('SALE', 'NEW') " + // 데이터에 맞춰 수정
                                "AND ROWNUM <= 5";
            
            pstmt = conn.prepareStatement(sqlProduct);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                list.add(eventproductDTO.builder()
                        .name(rs.getString("NAME"))
                        .product_id(rs.getString("PRODUCT_ID"))
                        .build());
            }
        } finally {
            JdbcUtil.close(rs);
            JdbcUtil.close(pstmt);
        }
        return list;
    }

 
    // 추천상품용
    public ArrayList<eventproductDTO> selectRecommendProducts(Connection conn) throws SQLException {
        ArrayList<eventproductDTO> list = new ArrayList<>();
        
        // 이벤트 제품 테이블과 상품 테이블을 조인하여 상위 12개 추출
     // eventproductDAO.java 수정
        String sql = "SELECT * FROM ( " +
                     "  SELECT p.PRODUCT_ID, p.NAME, p.PRICE, p.DISCOUNT_RATE " +
                     "  FROM EVENT_PRODUCT ep " +
                     "  JOIN PRODUCTS p ON ep.PRODUCT_ID = p.PRODUCT_ID " +
                     "  WHERE p.STATUS IN ('SALE', 'NEW') " + 
                     "  ORDER BY p.CREATED_AT DESC " +
                     ") WHERE ROWNUM <= 12";

        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                list.add(eventproductDTO.builder()
                        .product_id(rs.getString("PRODUCT_ID"))
                        .name(rs.getString("NAME"))
                        .price(rs.getInt("PRICE"))
                        .discount_rate(rs.getInt("DISCOUNT_RATE"))
                        .build());
            }
        } finally {
            JdbcUtil.close(rs);
            JdbcUtil.close(pstmt);
        }
        return list;
    }
}