package mypage.qna;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.util.DBConn;
import categories.CategoriesDTO;

public class QnaDAOImpl implements QnaDAO {

    // 공통 close
    private void close(ResultSet rs, PreparedStatement pstmt) {
        try { if (rs != null) rs.close(); } catch (Exception ignored) {}
        try { if (pstmt != null) pstmt.close(); } catch (Exception ignored) {}
    }

    /* ===============================
     * 1) 내 문의 목록 조회
     * =============================== */
    @Override
    public List<QnaDTO> findByUser(long userNumber) {

        List<QnaDTO> list = new ArrayList<>();

        String sql =
            "SELECT i.INQUIRY_ID, i.USER_NUMBER, i.CATEGORY_ID, c.CATEGORY_NAME, " +
            "       i.TITLE, i.CONTENT, i.STATUS, i.REPLY_CONTENT, i.CREATED_AT " +
            "FROM INQUIRY i " +
            "JOIN INQUIRY_CATEGORY c ON i.CATEGORY_ID = c.CATEGORY_ID " +
            "WHERE i.USER_NUMBER = ? " +
            "ORDER BY i.CREATED_AT DESC";

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = DBConn.getConnection();      // ✅ conn은 DBConn이 관리(싱글톤이면 닫으면 안됨)
            pstmt = conn.prepareStatement(sql);
            pstmt.setLong(1, userNumber);

            rs = pstmt.executeQuery();

            while (rs.next()) {
                QnaDTO dto = new QnaDTO();
                dto.setInquiryId(rs.getLong("INQUIRY_ID"));
                dto.setUserNumber(rs.getLong("USER_NUMBER"));
                dto.setCategoryId(rs.getInt("CATEGORY_ID"));
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
        } finally {
            close(rs, pstmt);
        }

        return list;
    }

    /* ===============================
     * 2) 상태별 문의 조회 (DONE / WAIT)
     * =============================== */
    @Override
    public List<QnaDTO> findByUserAndStatus(long userNumber, String status) {

        // status가 ALL/빈값이면 전체로
        if (status == null || status.isBlank() || "ALL".equalsIgnoreCase(status)) {
            return findByUser(userNumber);
        }

        List<QnaDTO> list = new ArrayList<>();

        String sql =
            "SELECT i.INQUIRY_ID, i.USER_NUMBER, i.CATEGORY_ID, c.CATEGORY_NAME, " +
            "       i.TITLE, i.CONTENT, i.STATUS, i.REPLY_CONTENT, i.CREATED_AT " +
            "FROM INQUIRY i " +
            "JOIN INQUIRY_CATEGORY c ON i.CATEGORY_ID = c.CATEGORY_ID " +
            "WHERE i.USER_NUMBER = ? " +
            "  AND i.STATUS = ? " +
            "ORDER BY i.CREATED_AT DESC";

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = DBConn.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setLong(1, userNumber);
            pstmt.setString(2, status);

            rs = pstmt.executeQuery();

            while (rs.next()) {
                QnaDTO dto = new QnaDTO();
                dto.setInquiryId(rs.getLong("INQUIRY_ID"));
                dto.setUserNumber(rs.getLong("USER_NUMBER"));
                dto.setCategoryId(rs.getInt("CATEGORY_ID"));
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
        } finally {
            close(rs, pstmt);
        }

        return list;
    }

    /* ===============================
     * 3) 문의 카테고리 목록 (INQUIRY_CATEGORY)
     * =============================== */
    @Override
    public List<CategoriesDTO> findCategoryList() {
        List<CategoriesDTO> list = new ArrayList<>();

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
                CategoriesDTO dto = new CategoriesDTO();
                dto.setCategory_id(rs.getInt("CATEGORY_ID"));
                dto.setName(rs.getString("CATEGORY_NAME"));
                list.add(dto);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    @Override
    public int insert(QnaDTO dto) {

        String sql =
            "INSERT INTO INQUIRY ( " +
            "  INQUIRY_ID, USER_NUMBER, CATEGORY_ID, TITLE, CONTENT, STATUS, CREATED_AT " +
            ") VALUES ( " +
            "  SEQ_INQUIRY.NEXTVAL, ?, ?, ?, ?, 'WAIT', SYSDATE " +
            ")";

        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = DBConn.getConnection();
            pstmt = conn.prepareStatement(sql);

            pstmt.setLong(1, dto.getUserNumber());
            pstmt.setInt(2, dto.getCategoryId());
            pstmt.setString(3, dto.getTitle());
            pstmt.setString(4, dto.getContent());

            return pstmt.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        } finally {
            close(null, pstmt);
        }
    }
}
