package mypage.qna;

import java.sql.Connection;
import java.util.List;

import mypage.qna.QnaDTO;
import categories.CategoriesDTO;

public interface QnaDAO {

    // 1. 내 문의 목록
    List<QnaDTO> selectByUser(Connection conn, long userNumber);

    // 2. 상태별 문의 목록
    List<QnaDTO> selectByUserAndStatus(Connection conn, long userNumber, String status);

    // 3. 문의 카테고리 목록
    List<CategoriesDTO> selectCategoryList(Connection conn);

    // 4. 문의 등록
    int insertInquiry(Connection conn, QnaDTO dto);
}
