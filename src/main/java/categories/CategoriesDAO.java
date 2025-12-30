package categories;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import com.util.JdbcUtil;

public class CategoriesDAO implements ICategories {
    private CategoriesDAO() {}
    private static CategoriesDAO instance = new CategoriesDAO();
    public static CategoriesDAO getInstance() { return instance; }

    @Override
    public ArrayList<CategoriesDTO> selectCategoryList(Connection conn) throws SQLException {
        String sql = "SELECT * FROM categories WHERE use_yn = 1 ORDER BY depth, category_id";
        ArrayList<CategoriesDTO> list = new ArrayList<>();
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                CategoriesDTO dto = CategoriesDTO.builder()
                        .category_id(rs.getInt("category_id"))
                        .name(rs.getString("name"))
                        .parent_id(rs.getInt("parent_id"))
                        .depth(rs.getInt("depth"))
                        .created_at(rs.getDate("created_at"))
                        .build();
                list.add(dto);
            }
        } finally {
            JdbcUtil.close(rs);
            JdbcUtil.close(pstmt);
        }
        return list;
    }
    
    // 특정 카테고리 정보 조회 (ID로 검색)
    @Override
    public CategoriesDTO selectCategory(Connection conn, int categoryId) throws SQLException {
        String sql = "SELECT * FROM categories WHERE category_id = ?";
        CategoriesDTO dto = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, categoryId);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                dto = CategoriesDTO.builder()
                        .category_id(rs.getInt("category_id"))
                        .name(rs.getString("name"))
                        .parent_id(rs.getInt("parent_id"))
                        .depth(rs.getInt("depth"))
                        .build();
            }
        } finally {
            JdbcUtil.close(rs);
            JdbcUtil.close(pstmt);
        }
        return dto;
    }
    
    // 하위/형제 카테고리 목록 조회 (사이드바 출력용)
    @Override
    public ArrayList<CategoriesDTO> selectChildCategories(Connection conn, int parentId) throws SQLException {
        String sql = "SELECT * FROM categories WHERE parent_id = ? AND use_yn = 1 ORDER BY category_id ASC";
        ArrayList<CategoriesDTO> list = new ArrayList<>();
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, parentId);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                CategoriesDTO dto = CategoriesDTO.builder()
                        .category_id(rs.getInt("category_id"))
                        .name(rs.getString("name"))
                        .parent_id(rs.getInt("parent_id"))
                        .depth(rs.getInt("depth"))
                        .build();
                list.add(dto);
            }
        } finally {
            JdbcUtil.close(rs);
            JdbcUtil.close(pstmt);
        }
        return list;
    }
    
}