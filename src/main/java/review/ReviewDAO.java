package review;

import java.sql.SQLException;
import java.util.List;

public interface ReviewDAO {

    // 1. 리뷰 등록
    public int insert(ReviewDTO dto) throws SQLException;

    // 2. 리뷰 목록 조회
    public List<ReviewDTO> selectListByFilter(String productId, String[] ratingArr) throws Exception;
    
}