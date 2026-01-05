package inquiry;

import java.sql.*;
import java.util.*;
import com.util.DBConn;   // 네 프로젝트 DB 유틸 기준

public class InquiryDAOImpl implements InquiryDAO {

	@Override
	public List<InquiryDTO> findByUser(long userNumber) {
	    List<InquiryDTO> list = new ArrayList<>();

	    // 수정한 부분: i.REPLY -> i.REPLY_CONTENT
	    String sql =
	            "SELECT i.INQUIRY_ID, i.USER_NUMBER, c.CATEGORY_NAME, " +
	            "       i.TITLE, i.CONTENT, i.STATUS, " +
	            "       i.REPLY_CONTENT, i.CREATED_AT " +  // 여기를 수정했습니다.
	            "FROM INQUIRY i " +
	            "JOIN INQUIRY_CATEGORY c ON i.CATEGORY_ID = c.CATEGORY_ID " +
	            "WHERE i.USER_NUMBER = ? " +
	            "ORDER BY i.CREATED_AT DESC";

	    try (
	        Connection conn = DBConn.getConnection();
	        PreparedStatement pstmt = conn.prepareStatement(sql);
	    ) {
	        pstmt.setLong(1, userNumber);
	        ResultSet rs = pstmt.executeQuery();

	        while (rs.next()) {
	            InquiryDTO dto = new InquiryDTO();
	            dto.setInquiryId(rs.getLong("INQUIRY_ID"));
	            dto.setUserNumber(rs.getLong("USER_NUMBER"));
	            dto.setCategoryName(rs.getString("CATEGORY_NAME"));
	            dto.setTitle(rs.getString("TITLE"));
	            dto.setContent(rs.getString("CONTENT"));
	            dto.setStatus(rs.getString("STATUS"));
	            dto.setReplyContent(rs.getString("REPLY_CONTENT")); // DB 컬럼명과 일치
	            dto.setCreatedAt(rs.getTimestamp("CREATED_AT"));

	            list.add(dto);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return list;
	}
}
