package products;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.util.DBConn; 

public class ProductsDAO {

    // 싱글톤 패턴
    private static ProductsDAO instance = new ProductsDAO();
    public static ProductsDAO getInstance() { return instance; }
    public ProductsDAO() {}

    // -----------------------------------------------------------
    // 1. 상품 전체 목록 조회 (리스트 페이지용 - ★여기 수정됨!)
    // -----------------------------------------------------------
    public List<ProductsDTO> selectAllProducts() {
        List<ProductsDTO> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        // ★ [수정] SQL에 P.CATEGORY_ID를 추가했습니다! (이게 없어서 에러 났을 거예요)
        String sql = " SELECT P.PRODUCT_ID, P.NAME, P.PRICE, P.DISCOUNT_RATE, P.STATUS, "
                   + "        P.CREATED_AT, P.UPDATED_AT, P.CATEGORY_ID, I.IMAGE_URL " 
                   + " FROM PRODUCTS P "
                   + " LEFT JOIN PRODUCT_IMAGE I ON P.PRODUCT_ID = I.PRODUCT_ID AND I.IS_MAIN = 1 "
                   + " ORDER BY P.CREATED_AT DESC ";

        try {
            conn = DBConn.getConnection();
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
                // 이미지가 없으면 기본 이미지로 대체
                if(img == null) img = "//filacdn.styleship.com/filaproduct2/data/productimages/a/1/FS261FT01X001_234.jpg"; 
                dto.setImage_url(img);

                list.add(dto);
            }
        } catch (Exception e) {
            System.out.println("❌ selectAllProducts 에러 발생!"); // 콘솔 확인용
            e.printStackTrace();
        } finally {
            try { if(rs != null) rs.close(); } catch(Exception e) {}
            try { if(pstmt != null) pstmt.close(); } catch(Exception e) {}
            DBConn.close(); 
        }
        return list;
    } 

 // -----------------------------------------------------------
    // 2. 상품 상세 정보 조회 (디버깅 코드 추가 버전!)
    // -----------------------------------------------------------
    public ProductsDTO getProduct(String productId) {
        ProductsDTO dto = null;
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        // ★ 디버깅 시작 알림
        System.out.println("=============================================");
        System.out.println("🔍 [디버깅] getProduct 메서드 시작! 요청 ID: " + productId);

        String sql = " SELECT P.PRODUCT_ID, P.NAME, P.PRICE, P.DISCOUNT_RATE, P.STATUS, P.DESCRIPTION, "
                   + "        P.CREATED_AT, P.CATEGORY_ID, I.IMAGE_URL "
                   + " FROM PRODUCTS P "
                   + " LEFT JOIN PRODUCT_IMAGE I ON P.PRODUCT_ID = I.PRODUCT_ID AND I.IS_MAIN = 1 "
                   + " WHERE P.PRODUCT_ID = ? ";

        try {
            conn = DBConn.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, productId);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                System.out.println("✅ DB에서 해당 ID의 상품을 찾았습니다!");

                dto = new ProductsDTO();
                
                // 1. ID 확인
                String dbId = rs.getString("PRODUCT_ID");
                dto.setProduct_id(dbId);
                System.out.println("   -> ID: " + dbId);

                // 2. 카테고리 ID 확인 (여기가 0이면 안됨!)
                int cateId = rs.getInt("CATEGORY_ID");
                dto.setCategory_id(cateId);
                System.out.println("   -> 카테고리ID: " + cateId);

                // 3. 이름 확인
                String dbName = rs.getString("NAME");
                dto.setName(dbName);
                System.out.println("   -> 상품명: " + dbName);

                // 4. 가격 확인
                int price = rs.getInt("PRICE");
                dto.setPrice(price);
                System.out.println("   -> 가격: " + price);

                // 5. 기타 정보
                dto.setDiscount_rate(rs.getInt("DISCOUNT_RATE"));
                dto.setStatus(rs.getString("STATUS"));
                dto.setCreated_at(rs.getDate("CREATED_AT"));
                
                // CLOB 설명 처리 (에러 방지)
                try {
                    dto.setDescription(rs.getString("DESCRIPTION"));
                } catch(Exception e) {
                    dto.setDescription("내용 없음");
                }

                // 6. 이미지 확인
                String img = rs.getString("IMAGE_URL");
                if(img == null) {
                    System.out.println("   -> ⚠️ 이미지가 없어서 기본 이미지로 대체합니다.");
                    img = "//filacdn.styleship.com/filaproduct2/data/productimages/a/1/FS261FT01X001_234.jpg";
                } else {
                    System.out.println("   -> 이미지 URL: " + img);
                }
                dto.setImage_url(img);

                System.out.println("🎉 DTO 생성 완료!");

            } else {
                System.out.println("❌ [경고] DB에 해당 ID(" + productId + ")를 가진 상품이 없습니다.");
                System.out.println("   -> SQL Developer에서 조회해보세요: SELECT * FROM PRODUCTS WHERE PRODUCT_ID='" + productId + "'");
            }

        } catch (Exception e) {
            System.out.println("🔥 [에러] getProduct 실행 중 오류 발생!");
            e.printStackTrace(); // 에러 내용을 콘솔에 출력
        } finally {
            try { if(rs != null) rs.close(); } catch(Exception e) {}
            try { if(pstmt != null) pstmt.close(); } catch(Exception e) {}
            DBConn.close();
        }
        
        System.out.println("=============================================");
        return dto;
    }

    // -----------------------------------------------------------
    // 3. 상품 옵션 목록 조회 (상세 페이지 옵션용)
    // -----------------------------------------------------------
    public List<ProductsOptionDTO> getProductOptions(String productId) {
        List<ProductsOptionDTO> options = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        String sql = " SELECT G.OPTION_NAME, V.VALUE_NAME "
                   + " FROM PRODUCT_OPTION_GROUPS G "
                   + " JOIN PRODUCT_OPTION_VALUES V ON G.OPTION_GROUP_ID = V.OPTION_GROUP_ID "
                   + " WHERE G.PRODUCT_ID = ? "
                   + " ORDER BY G.OPTION_GROUP_ID ASC, V.VALUE_ID ASC ";

        try {
            conn = DBConn.getConnection();
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
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { if(rs != null) rs.close(); } catch(Exception e) {}
            try { if(pstmt != null) pstmt.close(); } catch(Exception e) {}
            DBConn.close();
        }
        return options;
    }
}