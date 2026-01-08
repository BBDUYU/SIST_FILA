package review;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ReviewDTO {
    
    private int review_id;    
    private String product_id;
    
    private int user_number;  
    // private String writer; 

    private String content;   
    private int rating;       
    private String review_img;
    private Date regdate; 
    
    public List<ReviewDTO> selectList(String productId) {
        List<ReviewDTO> list = new ArrayList<>();
        String sql = "SELECT * FROM review WHERE product_id = ? ORDER BY reg_date DESC"; // 최신순
        
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, productId);
            rs = pstmt.executeQuery();
            
            while (rs.next()) {
                ReviewDTO dto = new ReviewDTO();
                dto.setProduct_id(rs.getString("product_id"));
                dto.setContent(rs.getString("content"));
                dto.setRating(rs.getInt("rating"));
                dto.setReview_img(rs.getString("review_img")); // 이미지 경로 필수로 담기!
                dto.setRegdate(rs.getDate("reg_date"));
                // 작성자 이름 등 필요한 정보 세팅
                list.add(dto);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { rs.close(); } catch (Exception e) {}
            try { pstmt.close(); } catch (Exception e) {}
            // 학원 코드 흐름상 conn은 여기서 닫지 않습니다.
        }
        return list;
    }
    
}