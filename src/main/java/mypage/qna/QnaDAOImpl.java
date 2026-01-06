package mypage.qna;

import java.sql.*;
import java.util.*;
import com.util.DBConn;   // 네 프로젝트 DB 유틸 기준

public class QnaDAOImpl implements QnaDAO {

	@Override
	public List<QnaDTO> findByUserAndStatus(long userNumber, String status) {

	    List<QnaDTO> list = new ArrayList<>();

	    String sql =
	        "SELECT i.INQUIRY_ID, i.USER_NUMBER, c.CATEGORY_NAME, " +
	        "       i.TITLE, i.CONTENT, i.STATUS, " +
	        "       i.REPLY_CONTENT, i.CREATED_AT " +
	        "FROM INQUIRY i " +
	        "JOIN INQUIRY_CATEGORY c ON i.CATEGORY_ID = c.CATEGORY_ID " +
	        "WHERE i.USER_NUMBER = ? " +
	        "  AND i.STATUS = ? " +
	        "ORDER BY i.CREATED_AT DESC";

	    try (
	        Connection conn = DBConn.getConnection();
	        PreparedStatement pstmt = conn.prepareStatement(sql)
	    ) {
	        pstmt.setLong(1, userNumber);
	        pstmt.setString(2, status);

	        ResultSet rs = pstmt.executeQuery();

	        while (rs.next()) {
	            QnaDTO dto = new QnaDTO();
	            dto.setInquiryId(rs.getLong("INQUIRY_ID"));
	            dto.setUserNumber(rs.getLong("USER_NUMBER"));
	            dto.setCategoryName(rs.getString("CATEGORY_NAME"));
	            dto.setTitle(rs.getString("TITLE"));
	            dto.setContent(rs.getString("CONTENT"));
	            dto.setStatus(rs.getString("STATUS"));
	            dto.setReplyContent(rs.getString("REPLY_CONTENT"));
	            dto.setCreatedAt(rs.getTimestamp("CREATED_AT"));

	            list.add(dto);
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return list;
	}

	@Override
	public List<QnaDTO> findByUser(long userNumber) {
		// TODO Auto-generated method stub
		return null;
	}
	@Override
	public List<QnaDTO> selectCategoryList() {

	    List<QnaDTO> list = new ArrayList<>();

	    String sql =
	        "SELECT CATEGORY_ID, CATEGORY_NAME " +
	        "FROM INQUIRY_CATEGORY " +
	        "ORDER BY CATEGORY_ID";

	    try (
	        Connection conn = DBConn.getConnection();
	        PreparedStatement pstmt = conn.prepareStatement(sql);
	        ResultSet rs = pstmt.executeQuery()
	    ) {
	        while (rs.next()) {
	            QnaDTO dto = new QnaDTO();
	            dto.setCategoryId(rs.getInt("CATEGORY_ID"));
	            dto.setCategoryName(rs.getString("CATEGORY_NAME"));
	            list.add(dto);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return list;
	}

	@Override
	public List<QnaDTO> findCategoryList() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void insert(QnaDTO dto) {
		 String sql =
			        "INSERT INTO INQUIRY ( " +
			        "  INQUIRY_ID, USER_NUMBER, CATEGORY_ID, TITLE, CONTENT, STATUS, CREATED_AT " +
			        ") VALUES ( " +
			        "  SEQ_INQUIRY.NEXTVAL, ?, ?, ?, ?, 'WAIT', SYSDATE " +
			        ")";

			    try (
			        Connection conn = DBConn.getConnection();
			        PreparedStatement pstmt = conn.prepareStatement(sql)
			    ) {
			        pstmt.setLong(1, dto.getUserNumber());
			        pstmt.setInt(2, dto.getCategoryId());
			        pstmt.setString(3, dto.getTitle());
			        pstmt.setString(4, dto.getContent());

			        pstmt.executeUpdate();

			    } catch (Exception e) {
			        e.printStackTrace();
			    }
			}
}