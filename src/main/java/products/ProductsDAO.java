package products;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.util.DBConn; 

public class ProductsDAO {

    // 싱글톤 패턴
    private static ProductsDAO instance = new ProductsDAO();
    public static ProductsDAO getInstance() { return instance; }
    public ProductsDAO() {}

    // -----------------------------------------------------------
    // 1. 상품 전체 목록 조회 (전체보기용)
    // ★ 변경점: Connection을 매개변수로 받음 / throws SQLException 추가
    // -----------------------------------------------------------
    public List<ProductsDTO> selectAllProducts(Connection conn) throws SQLException {
        List<ProductsDTO> list = new ArrayList<>();
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        String sql = " SELECT P.PRODUCT_ID, P.NAME, P.PRICE, P.DISCOUNT_RATE, P.STATUS, "
                   + "        P.CREATED_AT, P.UPDATED_AT, P.CATEGORY_ID, I.IMAGE_URL " 
                   + " FROM PRODUCTS P "
                   + " LEFT JOIN PRODUCT_IMAGE I ON P.PRODUCT_ID = I.PRODUCT_ID AND I.IS_MAIN = 1 "
                   + " ORDER BY P.CREATED_AT DESC ";

        try {
            // conn = DBConn.getConnection(); <--- 이거 삭제됨! (받아온 conn 사용)
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                ProductsDTO dto = new ProductsDTO();
                dto.setProduct_id(rs.getString("PRODUCT_ID"));
                dto.setName(rs.getString("NAME"));
                dto.setPrice(rs.getInt("PRICE"));
                dto.setDiscount_rate(rs.getInt("DISCOUNT_RATE"));
                dto.setStatus(rs.getString("STATUS"));
                dto.setCreated_at(rs.getDate("CREATED_AT"));
                dto.setUpdated_at(rs.getDate("UPDATED_AT"));
                dto.setCategory_id(rs.getInt("CATEGORY_ID")); 
                
                String img = rs.getString("IMAGE_URL");
                if(img == null) img = "//filacdn.styleship.com/filaproduct2/data/productimages/a/1/FS261FT01X001_234.jpg"; 
                dto.setImage_url(img);

                list.add(dto);
            }
        } finally {
            if(rs != null) rs.close();
            if(pstmt != null) pstmt.close();
        }
        return list;
    } 

    // -----------------------------------------------------------
    // 2. 카테고리별 상품 목록 조회 (★ 아까 Service에서 에러 났던 부분 해결!)
    // -----------------------------------------------------------
    public List<ProductsDTO> selectProductsByCategory(Connection conn, int categoryId) throws SQLException {
        List<ProductsDTO> list = new ArrayList<>();
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        String sql = " SELECT P.PRODUCT_ID, P.NAME, P.PRICE, P.DISCOUNT_RATE, P.STATUS, "
                   + "        P.CREATED_AT, P.UPDATED_AT, P.CATEGORY_ID, I.IMAGE_URL " 
                   + " FROM PRODUCTS P "
                   + " LEFT JOIN PRODUCT_IMAGE I ON P.PRODUCT_ID = I.PRODUCT_ID AND I.IS_MAIN = 1 "
                   + " WHERE P.CATEGORY_ID = ? "  // ★ 특정 카테고리만 조회
                   + " ORDER BY P.CREATED_AT DESC ";

        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, categoryId);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                ProductsDTO dto = new ProductsDTO();
                dto.setProduct_id(rs.getString("PRODUCT_ID"));
                dto.setName(rs.getString("NAME"));
                dto.setPrice(rs.getInt("PRICE"));
                dto.setDiscount_rate(rs.getInt("DISCOUNT_RATE"));
                dto.setStatus(rs.getString("STATUS"));
                dto.setCreated_at(rs.getDate("CREATED_AT"));
                dto.setUpdated_at(rs.getDate("UPDATED_AT"));
                dto.setCategory_id(rs.getInt("CATEGORY_ID")); 
                
                String img = rs.getString("IMAGE_URL");
                if(img == null) img = "//filacdn.styleship.com/filaproduct2/data/productimages/a/1/FS261FT01X001_234.jpg"; 
                dto.setImage_url(img);

                list.add(dto);
            }
        } finally {
            if(rs != null) rs.close();
            if(pstmt != null) pstmt.close();
        }
        return list;
    }

    // -----------------------------------------------------------
    // 3. 상품 상세 정보 조회 (상세페이지용)
    // -----------------------------------------------------------
    public ProductsDTO getProduct(Connection conn, String productId) throws SQLException {
        ProductsDTO dto = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        String sql = " SELECT P.PRODUCT_ID, P.NAME, P.PRICE, P.DISCOUNT_RATE, P.STATUS, P.DESCRIPTION, "
                   + "        P.CREATED_AT, P.CATEGORY_ID, I.IMAGE_URL "
                   + " FROM PRODUCTS P "
                   + " LEFT JOIN PRODUCT_IMAGE I ON P.PRODUCT_ID = I.PRODUCT_ID AND I.IS_MAIN = 1 "
                   + " WHERE P.PRODUCT_ID = ? ";

        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, productId);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                dto = new ProductsDTO();
                dto.setProduct_id(rs.getString("PRODUCT_ID"));
                dto.setCategory_id(rs.getInt("CATEGORY_ID"));
                dto.setName(rs.getString("NAME"));
                dto.setPrice(rs.getInt("PRICE"));
                dto.setDiscount_rate(rs.getInt("DISCOUNT_RATE"));
                dto.setStatus(rs.getString("STATUS"));
                dto.setCreated_at(rs.getDate("CREATED_AT"));
                
                try { dto.setDescription(rs.getString("DESCRIPTION")); } catch(Exception e) { dto.setDescription(""); }

                String img = rs.getString("IMAGE_URL");
                if(img == null) img = "//filacdn.styleship.com/filaproduct2/data/productimages/a/1/FS261FT01X001_234.jpg";
                dto.setImage_url(img);
            }
        } finally {
            if(rs != null) rs.close();
            if(pstmt != null) pstmt.close();
        }
        return dto;
    }

    // -----------------------------------------------------------
    // 4. 상품 옵션 목록 조회
    // -----------------------------------------------------------
    public List<ProductsOptionDTO> getProductOptions(Connection conn, String productId) throws SQLException {
        List<ProductsOptionDTO> options = new ArrayList<>();
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        String sql = " SELECT G.OPTION_NAME, V.VALUE_NAME "
                   + " FROM PRODUCT_OPTION_GROUPS G "
                   + " JOIN PRODUCT_OPTION_VALUES V ON G.OPTION_GROUP_ID = V.OPTION_GROUP_ID "
                   + " WHERE G.PRODUCT_ID = ? "
                   + " ORDER BY G.OPTION_GROUP_ID ASC, V.VALUE_ID ASC ";

        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, productId);
            rs = pstmt.executeQuery();

            String currentGroupName = "";
            ProductsOptionDTO currentOption = null;

            while (rs.next()) {
                String groupName = rs.getString("OPTION_NAME");
                String valueName = rs.getString("VALUE_NAME");

                if (!groupName.equals(currentGroupName)) {
                    currentOption = new ProductsOptionDTO(groupName);
                    options.add(currentOption);
                    currentGroupName = groupName;
                }

                if (currentOption != null) {
                    currentOption.addValue(valueName);
                }
            }
        } finally {
            if(rs != null) rs.close();
            if(pstmt != null) pstmt.close();
        }
        return options;
    }
    
    // 카테고리별 상품 개수 세기
    public int getProductCount(Connection conn, int categoryId) {
        String sql = " SELECT COUNT(*) FROM products WHERE category_id = ? "; // 하위 카테고리 포함하려면 로직 복잡해지는데 일단 이걸로!
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        int count = 0;
        
        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, categoryId);
            rs = pstmt.executeQuery();
            
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return count;
    }
    
    
}