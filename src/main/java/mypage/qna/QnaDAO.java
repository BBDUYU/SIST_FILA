package mypage.qna;

import java.util.List;
import categories.CategoriesDTO;

public interface QnaDAO {

    // 1️⃣ 특정 회원의 1:1 문의 목록
    List<QnaDTO> findByUser(long userNumber);

    // 2️⃣ 상태별 문의 목록
    List<QnaDTO> findByUserAndStatus(long userNumber, String status);

    // 3️⃣ 문의 카테고리 목록 (INQUIRY_CATEGORY)
    List<CategoriesDTO> findCategoryList();

    // 4️⃣ 문의 등록
    int insert(QnaDTO dto);
}
