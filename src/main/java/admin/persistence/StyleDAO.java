package admin.persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import admin.domain.StyleDTO;
import admin.domain.StyleImageDTO;
import admin.domain.StyleProductDTO;
import com.util.JdbcUtil; // 본인의 DB 연결 종료 유틸리티 확인

public class StyleDAO {
    private static StyleDAO instance = new StyleDAO();
    private StyleDAO() {}
    public static StyleDAO getInstance() { return instance; }

    // 1. 관리자 스타일 목록 조회 (대표 이미지 포함)
    public List<StyleDTO> selectStyleList(Connection conn) throws SQLException {
        String sql = "SELECT s.STYLE_ID, s.STYLE_NAME, s.USE_YN, si.IMAGE_URL AS MAIN_IMAGE " +
                     "FROM STYLE s " +
                     "LEFT JOIN STYLE_IMAGE si ON s.STYLE_ID = si.STYLE_ID AND si.IS_MAIN = 1 " +
                     "ORDER BY s.STYLE_ID DESC";
        
        List<StyleDTO> list = new ArrayList<>();
        try (PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            while (rs.next()) {
                StyleDTO dto = StyleDTO.builder()
                        .style_id(rs.getInt("STYLE_ID"))
                        .style_name(rs.getString("STYLE_NAME"))
                        .use_yn(rs.getInt("USE_YN"))
                        .main_image_url(rs.getString("MAIN_IMAGE"))
                        .build();
                list.add(dto);
            }
        }
        return list;
    }

    // 2. 새로운 스타일 마스터 등록 (시퀀스 사용)
 // StyleDAO.java
    public int insertStyle(Connection conn, StyleDTO dto) throws SQLException {
        // STYLE_ID를 반환받기 위해 두 번째 인자로 컬럼명을 명시합니다.
        String sql = "INSERT INTO STYLE (STYLE_ID, STYLE_NAME, DESCRIPTION, USE_YN) VALUES (SEQ_STYLE.NEXTVAL, ?, ?, ?)";
        try (PreparedStatement pstmt = conn.prepareStatement(sql, new String[]{"STYLE_ID"})) {
            pstmt.setString(1, dto.getStyle_name());
            pstmt.setString(2, dto.getDescription());
            pstmt.setInt(3, dto.getUse_yn());
            pstmt.executeUpdate();
            
            try (ResultSet rs = pstmt.getGeneratedKeys()) {
                if (rs.next()) return rs.getInt(1); // 생성된 시퀀스 ID 리턴
            }
        }
        return 0;
    }

    // 3. 스타일 화보 이미지 등록
    public int insertStyleImage(Connection conn, StyleImageDTO imgDto) throws SQLException {
        String sql = "INSERT INTO STYLE_IMAGE (STYLE_IMAGE_ID, STYLE_ID, IMAGE_URL, IS_MAIN, SORT_ORDER, ALT_TEXT) " +
                     "VALUES (SEQ_STYLE_IMAGE.NEXTVAL, ?, ?, ?, ?, ?)";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, imgDto.getStyle_id());
            pstmt.setString(2, imgDto.getImage_url());
            pstmt.setInt(3, imgDto.getIs_main());
            pstmt.setInt(4, imgDto.getSort_order());
            pstmt.setString(5, imgDto.getAlt_text());
            return pstmt.executeUpdate();
        }
    }

    // 4. 스타일-상품 매칭 정보 등록
    public int insertStyleProduct(Connection conn, StyleProductDTO prodDto) throws SQLException {
        String sql = "INSERT INTO STYLE_PRODUCT (PRODUCT_ID, STYLE_ID, SORT_ORDER) VALUES (?, ?, ?)";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, prodDto.getProduct_id());
            pstmt.setInt(2, prodDto.getStyle_id());
            pstmt.setInt(3, prodDto.getSort_order());
            return pstmt.executeUpdate();
        }
    }

    // 5. 스타일 삭제 (연관 데이터 포함 - 실제로는 USE_YN = 0 처리를 권장하지만, 물리 삭제 시)
    public void deleteStyle(Connection conn, int styleId) throws SQLException {
        // 스타일 상품 -> 스타일 이미지 -> 스타일 순서로 삭제 (FK 제약 조건)
        String sql1 = "DELETE FROM STYLE_PRODUCT WHERE STYLE_ID = ?";
        String sql2 = "DELETE FROM STYLE_IMAGE WHERE STYLE_ID = ?";
        String sql3 = "DELETE FROM STYLE WHERE STYLE_ID = ?";
        
        try (PreparedStatement pstmt1 = conn.prepareStatement(sql1);
             PreparedStatement pstmt2 = conn.prepareStatement(sql2);
             PreparedStatement pstmt3 = conn.prepareStatement(sql3)) {
            pstmt1.setInt(1, styleId); pstmt1.executeUpdate();
            pstmt2.setInt(1, styleId); pstmt2.executeUpdate();
            pstmt3.setInt(1, styleId); pstmt3.executeUpdate();
        }
    }
}