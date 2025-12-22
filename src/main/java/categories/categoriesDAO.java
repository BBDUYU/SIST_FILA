package categories;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class categoriesDAO {
	
	private static categoriesDAO dao = null;
	private categoriesDAO() {
		
	}
	public static categoriesDAO getInstance() {
		if(dao==null) {
			dao=new categoriesDAO();
		}
		return dao;
	}
	
	
	public ArrayList<categoriesDTO> selectCategoryList(Connection conn){
	    ArrayList<categoriesDTO> list = new ArrayList<>();
	    String sql = "SELECT * FROM categories WHERE use_yn = 1 ORDER BY depth, category_id";

	    try (PreparedStatement pstmt = conn.prepareStatement(sql);
	         ResultSet rs = pstmt.executeQuery()) {

	        while (rs.next()) {
	            categoriesDTO dto = categoriesDTO.builder()
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
