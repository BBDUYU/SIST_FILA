package products;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.util.JdbcUtil;

import categories.CategoriesDTO; 

public class ProductsDAO {

    // 싱글톤 패턴
    private static ProductsDAO instance = new ProductsDAO();
    public static ProductsDAO getInstance() { return instance; }
    public ProductsDAO() {}

    // -----------------------------------------------------------
    // 1. 상품 전체 목록 조회 (전체보기용)
    // -----------------------------------------------------------
    public List<ProductsDTO> selectAllProducts(Connection conn) throws SQLException {
        List<ProductsDTO> list = new ArrayList<>();
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        // [수정 완료] LSEFT -> LEFT (제 오타 수정했습니다)
        String sql = " SELECT P.PRODUCT_ID, P.NAME, P.PRICE, P.DISCOUNT_RATE, P.STATUS, "
                   + "        P.CREATED_AT, P.CATEGORY_ID, I.IMAGE_URL " 
                   + " FROM PRODUCTS P "
                   + " LEFT JOIN PRODUCT_IMAGE I ON P.PRODUCT_ID = I.PRODUCT_ID AND I.IS_MAIN = 1 "
                   + " ORDER BY P.CREATED_AT DESC ";

        try {
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                list.add(makeDTO(rs));
            }
        } finally {
            JdbcUtil.close(rs);
            JdbcUtil.close(pstmt);
        }
        return list;
    } 

    // -----------------------------------------------------------
    // 2. 카테고리별 상품 목록 조회
    // -----------------------------------------------------------
    public List<ProductsDTO> selectProductsByCategory(Connection conn, int categoryId) throws SQLException {
        List<ProductsDTO> list = new ArrayList<>();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        String sql = " SELECT P.PRODUCT_ID, P.NAME, P.PRICE, P.DISCOUNT_RATE, P.STATUS, P.CREATED_AT, P.CATEGORY_ID, I.IMAGE_URL " 
                   + " FROM PRODUCTS P LEFT JOIN PRODUCT_IMAGE I ON P.PRODUCT_ID = I.PRODUCT_ID AND I.IS_MAIN = 1 "
                   + " WHERE P.CATEGORY_ID IN ( "
                   + "     SELECT CATEGORY_ID FROM CATEGORIES "
                   + "     START WITH CATEGORY_ID = ? CONNECT BY PRIOR CATEGORY_ID = PARENT_ID "
                   + " ) "
                   + " ORDER BY P.CREATED_AT DESC ";
        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, categoryId);
            rs = pstmt.executeQuery();
            while (rs.next()) list.add(makeDTO(rs));
        } finally {
            JdbcUtil.close(rs);
            JdbcUtil.close(pstmt);
        }
        return list;
    }

    // -----------------------------------------------------------
    // 3. 최상위 카테고리 이름 가져오기
    // -----------------------------------------------------------
    public String getRootCategoryName(Connection conn, int categoryId) throws SQLException {
        String name = "";
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        String sql = " SELECT NAME FROM CATEGORIES WHERE DEPTH = 1 "
                   + " START WITH CATEGORY_ID = ? CONNECT BY PRIOR PARENT_ID = CATEGORY_ID ";
        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, categoryId);
            rs = pstmt.executeQuery();
            if (rs.next()) name = rs.getString(1);
        } finally {
            JdbcUtil.close(rs);
            JdbcUtil.close(pstmt);
        }
        return name;
    }
    
    // -----------------------------------------------------------
    // 4. 현재 카테고리 이름 가져오기
    // -----------------------------------------------------------
    public String getCategoryName(Connection conn, int categoryId) throws SQLException {
        String name = "";
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = " SELECT NAME FROM CATEGORIES WHERE CATEGORY_ID = ? ";
        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, categoryId);
            rs = pstmt.executeQuery();
            if (rs.next()) name = rs.getString(1);
        } finally {
            JdbcUtil.close(rs);
            JdbcUtil.close(pstmt);
        }
        return name;
    }

    // -----------------------------------------------------------
    // 5. 상품 상세 정보 조회
    // -----------------------------------------------------------
    public ProductsDTO getProduct(Connection conn, String productId) throws SQLException {
        ProductsDTO dto = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = " SELECT P.PRODUCT_ID, P.NAME, P.PRICE, P.DISCOUNT_RATE, P.STATUS, P.DESCRIPTION, P.CREATED_AT, P.CATEGORY_ID, I.IMAGE_URL "
                   + " FROM PRODUCTS P LEFT JOIN PRODUCT_IMAGE I ON P.PRODUCT_ID = I.PRODUCT_ID AND I.IS_MAIN = 1 "
                   + " WHERE P.PRODUCT_ID = ? ";
        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, productId);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                dto = makeDTO(rs);
                try { dto.setDescription(rs.getString("DESCRIPTION")); } catch(Exception e) {}
            }
        } finally {
            JdbcUtil.close(rs);
            JdbcUtil.close(pstmt);
        }
        return dto;
    }

    // -----------------------------------------------------------
    // 6. 상품 옵션 조회
    // -----------------------------------------------------------
    public List<ProductsOptionDTO> getProductOptions(Connection conn, String productId) throws SQLException {
        List<ProductsOptionDTO> options = new ArrayList<>();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = " SELECT G.OPTION_NAME, V.VALUE_NAME FROM PRODUCT_OPTION_GROUPS G "
                   + " JOIN PRODUCT_OPTION_VALUES V ON G.OPTION_GROUP_ID = V.OPTION_GROUP_ID "
                   + " WHERE G.PRODUCT_ID = ? ORDER BY G.OPTION_GROUP_ID ASC, V.VALUE_ID ASC ";
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
                if (currentOption != null) currentOption.addValue(valueName);
            }
        } finally {
            JdbcUtil.close(rs);
            JdbcUtil.close(pstmt);
        }
        return options;
    }

    // -----------------------------------------------------------
    // 7. 카테고리별 상품 개수 세기
    // -----------------------------------------------------------
    public int getProductCount(Connection conn, int categoryId) {
        int count = 0;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = " SELECT COUNT(*) FROM PRODUCTS WHERE CATEGORY_ID IN ( "
                   + "     SELECT CATEGORY_ID FROM CATEGORIES "
                   + "     START WITH CATEGORY_ID = ? CONNECT BY PRIOR CATEGORY_ID = PARENT_ID "
                   + " ) ";
        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, categoryId);
            rs = pstmt.executeQuery();
            if (rs.next()) count = rs.getInt(1);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            JdbcUtil.close(rs);
            JdbcUtil.close(pstmt);
        }
        return count;
    }

    // [헬퍼] DTO 생성
    private ProductsDTO makeDTO(ResultSet rs) throws SQLException {
        ProductsDTO dto = new ProductsDTO();
        dto.setProduct_id(rs.getString("PRODUCT_ID"));
        dto.setName(rs.getString("NAME"));
        dto.setPrice(rs.getInt("PRICE"));
        dto.setDiscount_rate(rs.getInt("DISCOUNT_RATE"));
        dto.setStatus(rs.getString("STATUS"));
        dto.setCreated_at(rs.getDate("CREATED_AT"));
        dto.setCategory_id(rs.getInt("CATEGORY_ID")); 
        String img = rs.getString("IMAGE_URL");
        if(img == null) img = "//filacdn.styleship.com/filaproduct2/data/productimages/a/1/FS261FT01X001_234.jpg"; 
        dto.setImage_url(img);
        return dto;
    }
    
 // -----------------------------------------------------------
    // ★ [추가] 상품의 태그(스포츠/라이프스타일 등) 가져오기
    // -----------------------------------------------------------
    public String getProductTag(Connection conn, String productId, int masterId) throws SQLException {
        String tagName = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        // 1. 상품 옵션 그룹(PRODUCT_OPTION_GROUPS)에서 해당 상품의 옵션을 찾고
        // 2. 그 옵션의 값(OPTION_VALUE_MASTERS)을 가져오는 쿼리 (JOIN 사용)
        String sql = " SELECT M.VALUE_NAME "
                   + " FROM OPTION_VALUE_MASTERS M "
                   + " JOIN PRODUCT_OPTION_VALUES V ON M.V_MASTER_ID = V.V_MASTER_ID "
                   + " JOIN PRODUCT_OPTION_GROUPS G ON V.OPTION_GROUP_ID = G.OPTION_GROUP_ID "
                   + " WHERE G.PRODUCT_ID = ? AND G.MASTER_ID = ? ";

        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, productId);
            pstmt.setInt(2, masterId); // 2번이 '스포츠' 카테고리라고 가정
            rs = pstmt.executeQuery();
            
            if (rs.next()) {
                tagName = rs.getString("VALUE_NAME");
            }
        } finally {
            JdbcUtil.close(rs);
            JdbcUtil.close(pstmt);
        }
        return tagName;
    }
    
    
}