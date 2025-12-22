package products;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.util.DBConn; // DBConn 위치 확인!

public class productsDAO {

    private static productsDAO instance = new productsDAO();
    public static productsDAO getInstance() { return instance; }
    public productsDAO() {}

    public List<productsDTO> selectAllProducts() {
        List<productsDTO> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        String sql = " SELECT P.PRODUCT_ID, P.NAME, P.PRICE, P.DISCOUNT_RATE, P.STATUS, P.CREATED_AT, P.UPDATED_AT, I.IMAGE_URL "
                   + " FROM PRODUCTS P "
                   + " LEFT JOIN PRODUCT_IMAGE I ON P.PRODUCT_ID = I.PRODUCT_ID AND I.IS_MAIN = 1 " 
                   + " ORDER BY P.CREATED_AT DESC ";

        try {
            conn = DBConn.getConnection();
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                productsDTO dto = new productsDTO();
                dto.setProduct_id(rs.getString("PRODUCT_ID"));
                dto.setName(rs.getString("NAME"));
                dto.setPrice(rs.getInt("PRICE"));
                dto.setDiscount_rate(rs.getInt("DISCOUNT_RATE"));
                dto.setStatus(rs.getString("STATUS"));
                dto.setCreated_at(rs.getDate("CREATED_AT"));
                dto.setUpdated_at(rs.getDate("UPDATED_AT"));
                
                // 이미지가 없으면 기본 이미지(또는 null) 처리
                String img = rs.getString("IMAGE_URL");
                if(img == null) {
                    // 이미지가 없을 때 보여줄 기본 이미지 (임시)
                    img = "//filacdn.styleship.com/filaproduct2/data/productimages/a/1/FS261FT01X001_234.jpg"; 
                }
                dto.setImage_url(img);

                list.add(dto);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { if(rs != null) rs.close(); } catch(Exception e) {}
            try { if(pstmt != null) pstmt.close(); } catch(Exception e) {}
            DBConn.close(); // 연결 해제
        }
        return list;
    }
}