package mypage.qna;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import categories.CategoriesDTO;
import mypage.qna.QnaDTO;

public class QnaDAOImpl implements QnaDAO {

    private static QnaDAOImpl dao = null;
    private QnaDAOImpl() {}
    public static QnaDAOImpl getInstance() {
        if (dao == null) dao = new QnaDAOImpl();
        return dao;
    }

    /* ===============================
     * 1. 내 문의 목록
     * =============================== */
    @Override
    public List<QnaDTO> selectByUser(Connection conn, long userNumber) {

        List<QnaDTO> list = new ArrayList<>();

        String sql =
            "SELECT i.INQUIRY_ID, i.USER_NUMBER, i.CATEGORY_ID, c.CATEGORY_NAME, " +
            "       i.TITLE, i.CONTENT, i.STATUS, i.REPLY_CONTENT, i.REPLY_AT, i.CREATED_AT " +
            "FROM INQUIRY i " +
            "JOIN INQUIRY_CATEGORY c ON i.CATEGORY_ID = c.CATEGORY_ID " +
            "WHERE i.USER_NUMBER = ? " +
            "ORDER BY i.CREATED_AT DESC";

        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setLong(1, userNumber);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    list.add(QnaDTO.builder()
                        .inquiry_id(rs.getLong("INQUIRY_ID"))
                        .user_number(rs.getLong("USER_NUMBER"))
                        .category_id(rs.getInt("CATEGORY_ID"))
                        .category_name(rs.getString("CATEGORY_NAME"))
                        .title(rs.getString("TITLE"))
                        .content(rs.getString("CONTENT"))
                        .status(rs.getString("STATUS"))
                        .reply_content(rs.getString("REPLY_CONTENT"))
                        .reply_at(rs.getTimestamp("REPLY_AT"))
                        .created_at(rs.getTimestamp("CREATED_AT"))
                        .build());
                }
            }
        } catch (Exception e) {
            throw new RuntimeException("QNA 목록 조회 에러", e);
        }

        return list;
    }

    /* ===============================
     * 2. 상태별 문의 목록
     * =============================== */
    @Override
    public List<QnaDTO> selectByUserAndStatus(Connection conn, long userNumber, String status) {

        if (status == null || status.isBlank() || "ALL".equalsIgnoreCase(status)) {
            return selectByUser(conn, userNumber);
        }

        List<QnaDTO> list = new ArrayList<>();

        String sql =
            "SELECT i.INQUIRY_ID, i.USER_NUMBER, i.CATEGORY_ID, c.CATEGORY_NAME, " +
            "       i.TITLE, i.CONTENT, i.STATUS, i.REPLY_CONTENT, i.REPLY_AT, i.CREATED_AT " +
            "FROM INQUIRY i " +
            "JOIN INQUIRY_CATEGORY c ON i.CATEGORY_ID = c.CATEGORY_ID " +
            "WHERE i.USER_NUMBER = ? AND i.STATUS = ? " +
            "ORDER BY i.CREATED_AT DESC";

        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setLong(1, userNumber);
            pstmt.setString(2, status);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    list.add(QnaDTO.builder()
                        .inquiry_id(rs.getLong("INQUIRY_ID"))
                        .user_number(rs.getLong("USER_NUMBER"))
                        .category_id(rs.getInt("CATEGORY_ID"))
                        .category_name(rs.getString("CATEGORY_NAME"))
                        .title(rs.getString("TITLE"))
                        .content(rs.getString("CONTENT"))
                        .status(rs.getString("STATUS"))
                        .reply_content(rs.getString("REPLY_CONTENT"))
                        .reply_at(rs.getTimestamp("REPLY_AT"))
                        .created_at(rs.getTimestamp("CREATED_AT"))
                        .build());
                }
            }
        } catch (Exception e) {
            throw new RuntimeException("QNA 상태별 조회 에러", e);
        }

        return list;
    }

    /* ===============================
     * 3. 문의 카테고리 목록
     * =============================== */
    @Override
    public List<CategoriesDTO> selectCategoryList(Connection conn) {

        List<CategoriesDTO> list = new ArrayList<>();

        String sql =
            "SELECT CATEGORY_ID, CATEGORY_NAME " +
            "FROM INQUIRY_CATEGORY " +
            "ORDER BY CATEGORY_ID";

        try (PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                list.add(CategoriesDTO.builder()
                    .category_id(rs.getInt("CATEGORY_ID"))
                    .name(rs.getString("CATEGORY_NAME"))
                    .build());
            }
        } catch (Exception e) {
            throw new RuntimeException("문의 카테고리 조회 에러", e);
        }

        return list;
    }

    /* ===============================
     * 4. 문의 등록
     * =============================== */
    @Override
    public int insertInquiry(Connection conn, QnaDTO dto) {

        String sql =
            "INSERT INTO INQUIRY ( " +
            " INQUIRY_ID, USER_NUMBER, CATEGORY_ID, TITLE, CONTENT, STATUS, CREATED_AT " +
            ") VALUES ( " +
            " SEQ_INQUIRY.NEXTVAL, ?, ?, ?, ?, 'WAIT', SYSDATE " +
            ")";

        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setLong(1, dto.getUser_number());
            pstmt.setInt(2, dto.getCategory_id());
            pstmt.setString(3, dto.getTitle());
            pstmt.setString(4, dto.getContent());

            return pstmt.executeUpdate();

        } catch (Exception e) {
            throw new RuntimeException("문의 등록 에러", e);
        }
    }
}
