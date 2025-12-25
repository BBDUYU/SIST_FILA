package categories;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class CategoriesDAO {
	
	private static CategoriesDAO dao = null;
	private CategoriesDAO() {
		
	}
	public static CategoriesDAO getInstance() {
		if(dao==null) {
			dao=new CategoriesDAO();
		}
		return dao;
	}
	
	
	public ArrayList<CategoriesDTO> selectCategoryList(Connection conn){
	    ArrayList<CategoriesDTO> list = new ArrayList<>();
	    String sql = "SELECT * FROM categories WHERE use_yn = 1 ORDER BY depth, category_id";

	    try (PreparedStatement pstmt = conn.prepareStatement(sql);
	         ResultSet rs = pstmt.executeQuery()) {

	        while (rs.next()) {
	            CategoriesDTO dto = CategoriesDTO.builder()
	                    .category_id(rs.getInt("category_id"))
	                    .name(rs.getString("name"))
	                    .parent_id(rs.getInt("parent_id"))
	                    .depth(rs.getInt("depth"))
	                    .created_at(rs.getDate("created_at"))
	                    .updated_at(rs.getDate("updated_at"))
	                    .use_yn(rs.getInt("use_yn"))
	                    .build();

	            list.add(dto);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return list;
	}

}
