package mypage.qna;

import java.util.List;

public interface QnaDAO {

    // 특정 회원의 1:1 문의 목록 조회

    List<QnaDTO> findByUser(long userNumber);

    List<QnaDTO> findByUserAndStatus(long userNumber, String status);
    
    List<QnaDTO> selectCategoryList();

	List<QnaDTO> findCategoryList();
	
	void insert(QnaDTO dto);
}