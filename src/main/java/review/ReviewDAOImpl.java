package review;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ReviewDAOImpl implements ReviewDAO {

    private Connection conn;
    private PreparedStatement pstmt;
    private ResultSet rs;

    // 생성자
    public ReviewDAOImpl(Connection conn) {
        this.conn = conn;
    }

    // 1. 리뷰 등록 기능
    @Override
    public int insert(ReviewDTO dto) throws SQLException {
        String sql = "INSERT INTO review "
                   + " (review_id, product_id, user_number, content, rating, review_img, created_at) "
                   + " VALUES ( (SELECT NVL(MAX(review_id),0)+1 FROM review), ?, ?, ?, ?, ?, SYSDATE)";

        int result = 0;

        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, dto.getProduct_id());
            pstmt.setInt(2, dto.getUser_number()); // 작성자(숫자)
            pstmt.setString(3, dto.getContent());
            pstmt.setInt(4, dto.getRating());
            pstmt.setString(5, dto.getReview_img());

            result = pstmt.executeUpdate();
        } finally {
            if(pstmt != null) pstmt.close();
        }
        return result;
    }

    // 2. 리뷰 목록 조회 (필터링) 기능
    @Override
    public List<ReviewDTO> selectListByFilter(String productId, String[] ratingArr) {
        List<ReviewDTO> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder();

        // 기본 쿼리: 해당 상품의 리뷰, 최신순
        sql.append(" SELECT review_id, product_id, user_number, content, rating, review_img, created_at ");
        sql.append(" FROM review ");
        sql.append(" WHERE product_id = ? ");

        // 동적 쿼리: 별점 필터가 있는 경우 (예: 별점 5점, 4점만 보기)
        if (ratingArr != null && ratingArr.length > 0) {
            sql.append(" AND rating IN (");
            for (int i = 0; i < ratingArr.length; i++) {
                sql.append("?"); 
                if (i < ratingArr.length - 1) sql.append(", ");
            }
            sql.append(") ");
        }

        sql.append(" ORDER BY created_at DESC "); // DB컬럼명 created_at 기준 정렬

        try {
            pstmt = conn.prepareStatement(sql.toString());

            int pIndex = 1;
            pstmt.setString(pIndex++, productId);

            // 별점 배열 값을 물음표에 채워넣기
            if (ratingArr != null && ratingArr.length > 0) {
                for (String r : ratingArr) {
                    pstmt.setInt(pIndex++, Integer.parseInt(r));
                }
            }

            rs = pstmt.executeQuery();

            while (rs.next()) {
                ReviewDTO dto = new ReviewDTO();
                
                // DB 컬럼명 대소문자 주의 (보통 대문자로 인식됨)
                dto.setReview_id(rs.getInt("REVIEW_ID"));
                dto.setProduct_id(rs.getString("PRODUCT_ID"));
                dto.setUser_number(rs.getInt("USER_NUMBER")); // DTO에 user_number 필드 필수
                dto.setContent(rs.getString("CONTENT"));
                dto.setRating(rs.getInt("RATING"));
                dto.setReview_img(rs.getString("REVIEW_IMG"));
                dto.setRegdate(rs.getDate("CREATED_AT")); // DTO변수: regdate, DB컬럼: CREATED_AT

                list.add(dto);
            }

        } catch (Exception e) {
            System.out.println("> ReviewDAOImpl.selectListByFilter 에러");
            e.printStackTrace();
        } finally {
            if (rs != null) try { rs.close(); } catch (Exception e) {}
            if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}
            // conn은 여기서 닫지 않습니다 (Service나 Controller에서 관리)
        }

        return list;
    }
}