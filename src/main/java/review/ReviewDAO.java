package review;
import java.sql.SQLException;

public interface ReviewDAO {
    // 리뷰 작성
    int insert(ReviewDTO dto) throws SQLException;
    
    // (나중에 리스트 조회도 여기에 추가됨)
}