package inquiry;

import java.util.List;

public interface InquiryDAO {

    // 특정 회원의 1:1 문의 목록 조회
    List<InquiryDTO> findByUser(long userNumber);

}
