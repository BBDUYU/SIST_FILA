package mypage;

import java.sql.Connection;
import java.util.List;

import com.util.ConnectionProvider;
import com.util.JdbcUtil;

import categories.CategoriesDTO;
import member.MemberDTO;
import mypage.qna.QnaDTO;
import mypage.qna.QnaDAO;
import mypage.qna.QnaDAOImpl;

public class QnaService {

    private static QnaService instance = new QnaService();
    public static QnaService getInstance() {
        return instance;
    }

    private QnaService() {}

    private QnaDAO dao = QnaDAOImpl.getInstance();

    /* ===============================
     * 1. 1:1 문의 목록 조회
     * =============================== */
    public List<QnaDTO> getQnaList(long userNumber) {
        try (Connection conn = ConnectionProvider.getConnection()) {
            return dao.selectByUser(conn, userNumber);
        } catch (Exception e) {
            throw new RuntimeException("QNA 목록 조회 실패", e);
        }
    }

    /* ===============================
     * 2. 상태별 문의 목록 조회
     * =============================== */
    public List<QnaDTO> getQnaListByStatus(long userNumber, String status) {
        try (Connection conn = ConnectionProvider.getConnection()) {
            return dao.selectByUserAndStatus(conn, userNumber, status);
        } catch (Exception e) {
            throw new RuntimeException("QNA 상태별 조회 실패", e);
        }
    }

    /* ===============================
     * 3. 문의 카테고리 목록
     * =============================== */
    public List<CategoriesDTO> getCategoryList() {
        try (Connection conn = ConnectionProvider.getConnection()) {
            return dao.selectCategoryList(conn);
        } catch (Exception e) {
            throw new RuntimeException("문의 카테고리 조회 실패", e);
        }
    }

    /* ===============================
     * 4. 문의 등록
     * =============================== */
    public void writeQna(MemberDTO loginUser, QnaDTO dto) {
        Connection conn = null;
        try {
            conn = ConnectionProvider.getConnection();
            conn.setAutoCommit(false);

            dto.setUser_number(loginUser.getUserNumber());
            dao.insertInquiry(conn, dto);

            conn.commit();
        } catch (Exception e) {
            JdbcUtil.rollback(conn);
            throw new RuntimeException("문의 등록 실패", e);
        } finally {
            JdbcUtil.close(conn);
        }
    }
}
