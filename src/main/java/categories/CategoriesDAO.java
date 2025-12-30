package categories;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import com.util.JdbcUtil;
import categories.CategoriesDTO;

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
}