package review;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import com.util.DBConn; // DB 연결 유틸 경로는 본인 프로젝트에 맞게

public class ReviewDAOImpl implements ReviewDAO {

    private Connection conn = null;
    private PreparedStatement pstmt = null;

    public ReviewDAOImpl(Connection conn) {
        this.conn = conn;
    }

    @Override
    public int insert(ReviewDTO dto) throws SQLException {
    	String sql = "INSERT INTO review "
                + " (review_id, product_id, writer, content, rating, review_img, regdate) "
                + " VALUES ( (SELECT NVL(MAX(review_id),0)+1 FROM review), ?, ?, ?, ?, ?, SYSDATE)";

        int rowCount = 0;

        try {
            pstmt = conn.prepareStatement(sql);
            
            pstmt.setString(1, dto.getProduct_id());
            pstmt.setString(2, dto.getWriter());
            pstmt.setString(3, dto.getContent());
            pstmt.setInt(4, dto.getRating());
            pstmt.setString(5, dto.getReview_img());

            rowCount = pstmt.executeUpdate();

        } finally {
            if(pstmt != null) pstmt.close();
        }

        return rowCount;
    }
}