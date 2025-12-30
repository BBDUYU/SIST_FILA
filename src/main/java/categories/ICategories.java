package categories;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import categories.CategoriesDTO;

public interface ICategories {
    // 카테고리 목록 조회
    ArrayList<CategoriesDTO> selectCategoryList(Connection conn) throws SQLException;
}