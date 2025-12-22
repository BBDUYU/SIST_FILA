package products;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class productsDAO {
	
	private static productsDAO dao = null;
	private productsDAO() {
		
	}
	public static productsDAO getInstance() {
		if(dao==null) {
			dao=new productsDAO();
		}
		return dao;
	}
	
	
	public ArrayList<productsDTO> selectFileList(Connection conn){
		ArrayList<productsDTO> list=null;
		String sql="select * "
				+" from products ";
		PreparedStatement pstmt = null;
		ResultSet rs =null;
		try {
			pstmt=conn.prepareStatement(sql);
			rs=pstmt.executeQuery();
			
			productsDTO dto = null;
			if(rs.next()) {
				list = new ArrayList<productsDTO>();
				do {
					dto=new productsDTO();
					dto.setProduct_id(rs.getString("product_id"));
					dto.setCategory_id(rs.getInt("category_id"));
					dto.setName(rs.getString("name"));
					dto.setDescription(rs.getString("description"));
					dto.setPrice(rs.getInt("price"));
					dto.setView_count(rs.getInt("view_count"));
					dto.setCreated_at(rs.getDate("created_at"));
					dto.setUpdated_at(rs.getDate("updated_at"));

					list.add(dto);
				}while(rs.next());
			}
		}catch(Exception e) {
			System.out.println("> dao.select() :"+e.toString());
		}finally {
			try {pstmt.close();}catch(SQLException e) {e.printStackTrace();}
		}
		
		return list;
	}
}
