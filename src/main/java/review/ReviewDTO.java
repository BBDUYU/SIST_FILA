package review;

import java.util.Date;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ReviewDTO {
    
    private int review_id;          // 리뷰 고유 번호 (PK)
    private String product_id;      // 상품 번호 (FK) - 어떤 상품의 리뷰인지
    private String writer;          // 작성자 ID
    private String content;         // 리뷰 내용
    private int rating;             // 별점 (1~5)
    private String review_img;      // 리뷰 이미지 (선택)
    private Date regdate;           // 작성일
    
    // (참고) BoardDTO의 pwd, email, title, tag, readed는 리뷰에서 보통 안 쓰므로 뺐습니다.
}