package member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import com.util.DBConn;

public class MyPageDAO {

    // 회원 상단 요약 정보 가져오기 (쿠폰, 포인트, 위시, 주문)
    public MyPageDTO getMyPageSummary(int userNumber) {
        MyPageDTO dto = new MyPageDTO();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        // 1. 쿠폰: 사용 안 했고(IS_USED=0), 날짜 안 지난 것
        // 2. 포인트: 가장 최근 적립/사용 내역의 잔액(BALANCE) 가져오기 (없으면 0)
        // 3. 위시리스트: 개수
        // 4. 주문내역: 개수
        String sql = " SELECT "
                   + "   (SELECT COUNT(*) FROM USER_COUPON WHERE USER_NUMBER = ? AND IS_USED = 0 AND EXPIRE_DATE >= TRUNC(SYSDATE)) AS C_CNT, "
                   + "   NVL((SELECT BALANCE FROM (SELECT BALANCE FROM POINTS WHERE USER_NUMBER = ? ORDER BY CREATED_AT DESC) WHERE ROWNUM = 1), 0) AS P_BAL, "
                   + "   (SELECT COUNT(*) FROM WISHLIST WHERE USER_NUMBER = ?) AS W_CNT, "
                   + "   (SELECT COUNT(*) FROM ORDERS WHERE USER_NUMBER = ?) AS O_CNT "
                   + " FROM DUAL ";

        try {
            conn = DBConn.getConnection();
            pstmt = conn.prepareStatement(sql);
            
            pstmt.setInt(1, userNumber);
            pstmt.setInt(2, userNumber);
            pstmt.setInt(3, userNumber);
            pstmt.setInt(4, userNumber);
            
            rs = pstmt.executeQuery();

            if (rs.next()) {
                dto.setCouponCount(rs.getInt("C_CNT"));
                dto.setPointBalance(rs.getInt("P_BAL"));
                dto.setWishlistCount(rs.getInt("W_CNT"));
                dto.setOrderCount(rs.getInt("O_CNT"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { if(rs != null) rs.close(); } catch(Exception e) {}
            try { if(pstmt != null) pstmt.close(); } catch(Exception e) {}
            DBConn.close();
        }
        return dto;
    }
}