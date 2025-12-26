package admin;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class CreateproductDAO {
    
    private static CreateproductDAO dao = null;
    private CreateproductDAO() {}
    public static CreateproductDAO getInstance() {
        if (dao == null) dao = new CreateproductDAO();
        return dao;
    }

    /**
     * 1단계: 카테고리에 맞는 새로운 Product ID 생성
     */
    public String generateProductId(Connection conn, int categoryId) {
        String productId = "";
        String sequenceName = "";
        
        if (categoryId == 10 || (categoryId >= 1000 && categoryId < 2000)) {
            sequenceName = "seq_prod_women";
        } else if (categoryId == 20 || (categoryId >= 2000 && categoryId < 3000)) {
            sequenceName = "seq_prod_men";
        } else if (categoryId == 30 || (categoryId >= 3000 && categoryId < 4000)) {
            sequenceName = "seq_prod_kids";
        } else {
            sequenceName = "seq_prod_women"; 
        }

        String sql = "SELECT 'PROD' || " + sequenceName + ".NEXTVAL FROM DUAL";

        try (PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            if (rs.next()) {
                productId = rs.getString(1);
            }
        } catch (Exception e) {
        	throw new RuntimeException("DB 작업 중 에러 발생: " + e.getMessage(), e);
        }
        return productId;
    }

    public int insertProduct(Connection conn, CreateproductDTO dto) {
        int result = 0;
        // 1. 쿼리 수정: 'Y' 대신 ? 사용
        String sql = "INSERT INTO PRODUCTS (product_id, category_id, name, description, price, "
                   + "view_count, created_at, updated_at, status, discount_rate) "
                   + "VALUES (?, ?, ?, ?, ?, 0, SYSDATE, SYSDATE, ?, ?)";

        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, dto.getProduct_id());
            pstmt.setInt(2, dto.getCategory_id());
            pstmt.setString(3, dto.getName());
            pstmt.setString(4, dto.getDescription());
            pstmt.setInt(5, dto.getPrice());

            // 2. 상태값(status) 판별 로직
            // 할인율이 0보다 크면 'SALE', 아니면 'NORMAL' (또는 null)
            String status = "NORMAL";
            if (dto.getDiscount_rate() > 0) {
                status = "SALE";
            }
            
            pstmt.setString(6, status); // 9번째 ? (status)
            pstmt.setInt(7, dto.getDiscount_rate()); // 10번째 ? (discount_rate)

            result = pstmt.executeUpdate();
        } catch (Exception e) {
        	throw new RuntimeException("DB 작업 중 에러 발생: " + e.getMessage(), e);
        }
        return result;
    }


    public int[] insertProductImages(Connection conn, ArrayList<CreateproductDTO> imgList) {
        int[] results = null;
        String sql = "INSERT INTO product_image (product_image_id, product_id, image_url, "
                   + "image_type, is_main, sort_order) "
                   + "VALUES (prod_img_seq.NEXTVAL, ?, ?, ?, ?, ?)";

        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            for (CreateproductDTO img : imgList) {
                pstmt.setString(1, img.getProduct_id());
                pstmt.setString(2, img.getImage_url());
                pstmt.setString(3, img.getImage_type());
                
                pstmt.setInt(4, img.getIs_main());
                
                pstmt.setInt(5, img.getSort_order());
                
                pstmt.addBatch();
            }
            results = pstmt.executeBatch();
        } catch (Exception e) {
        	throw new RuntimeException("DB 작업 중 에러 발생: " + e.getMessage(), e);
        }
        return results;
    }
    public void insertCategoryRelations(Connection conn, String productId, String[] categoryIds) {
        String sql = "INSERT INTO PRODUCT_CATEGORY_REL (REL_ID, PRODUCT_ID, CATEGORY_ID) "
                   + "VALUES (REL_SEQ.NEXTVAL, ?, ?)";

        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            for (String catId : categoryIds) {
            	if (catId == null || catId.trim().isEmpty()) {
                    continue; 
                }
                pstmt.setString(1, productId);
                pstmt.setInt(2, Integer.parseInt(catId));
                pstmt.addBatch(); // 여러 건을 한 번에 처리하기 위해 배치 사용
            }
            pstmt.executeBatch();
        } catch (Exception e) {
        	throw new RuntimeException("DB 작업 중 에러 발생: " + e.getMessage(), e);
        }
    }
    public Map<Integer, List<Map<String, Object>>> selectAllOptions(Connection conn) throws SQLException {
        Map<Integer, List<Map<String, Object>>> optionsMap = new HashMap<>();
        
        String sql = "SELECT MASTER_ID, V_MASTER_ID, VALUE_NAME FROM OPTION_VALUE_MASTERS ORDER BY MASTER_ID, V_MASTER_ID";
        
        try (PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            
            while (rs.next()) {
                int masterId = rs.getInt("MASTER_ID");
                Map<String, Object> val = new HashMap<>();
                val.put("v_master_id", rs.getInt("V_MASTER_ID"));
                val.put("value_name", rs.getString("VALUE_NAME"));
                
                // 해당 MasterID 리스트가 없으면 새로 생성, 있으면 추가
                optionsMap.computeIfAbsent(masterId, k -> new ArrayList<>()).add(val);
            }
        }
        return optionsMap;
    }
    /**
     * 2단계: 상품 옵션 그룹 및 상세 값 저장 (12, 13번 테이블)
     */
    public void insertProductOptions(Connection conn, String productId, String sportOption, String[] sizeOptions) throws SQLException {
        // 1. 시퀀스 번호를 미리 가져오는 쿼리 (가장 안전)
        String sqlNextGroup = "SELECT SEQ_OPTION_GROUP.NEXTVAL FROM DUAL";
        
        String sqlGroup = "INSERT INTO PRODUCT_OPTION_GROUPS (OPTION_GROUP_ID, PRODUCT_ID, MASTER_ID, OPTION_NAME) VALUES (?, ?, ?, ?)";
        String sqlValue = "INSERT INTO PRODUCT_OPTION_VALUES (VALUE_ID, OPTION_GROUP_ID, V_MASTER_ID, VALUE_NAME) VALUES (SEQ_OPTION_VALUE.NEXTVAL, ?, ?, ?)";

        try (PreparedStatement pstmtSeq = conn.prepareStatement(sqlNextGroup);
             PreparedStatement pstmtGroup = conn.prepareStatement(sqlGroup);
             PreparedStatement pstmtValue = conn.prepareStatement(sqlValue)) {

            // --- A. 스포츠 옵션 저장 ---
            if (sportOption != null && !sportOption.trim().isEmpty()) {
                long gId = 0;
                try (ResultSet rs = pstmtSeq.executeQuery()) { if (rs.next()) gId = rs.getLong(1); }

                if (gId > 0) {
                    pstmtGroup.setLong(1, gId);
                    pstmtGroup.setString(2, productId);
                    pstmtGroup.setInt(3, 2);
                    pstmtGroup.setString(4, "스포츠");
                    pstmtGroup.executeUpdate();

                    pstmtValue.setLong(1, gId);
                    pstmtValue.setInt(2, Integer.parseInt(sportOption));
                    pstmtValue.setString(3, "스포츠값");
                    pstmtValue.executeUpdate();
                }
            }

            // --- B. 사이즈 옵션 저장 ---
            if (sizeOptions != null && sizeOptions.length > 0) {
                long gId = 0;
                try (ResultSet rs = pstmtSeq.executeQuery()) { if (rs.next()) gId = rs.getLong(1); }

                if (gId > 0) {
                    pstmtGroup.setLong(1, gId);
                    pstmtGroup.setString(2, productId);
                    pstmtGroup.setInt(3, 4); // 사이즈 MASTER_ID
                    pstmtGroup.setString(4, "사이즈");
                    pstmtGroup.executeUpdate();

                    for (String vId : sizeOptions) {
                        if (vId == null || vId.trim().isEmpty()) continue;
                        pstmtValue.setLong(1, gId);
                        pstmtValue.setInt(2, Integer.parseInt(vId));
                        pstmtValue.setString(3, "사이즈값");
                        pstmtValue.executeUpdate();
                    }
                }
            }
        }
    }


    /**
     * 3단계: 기본 재고 및 조합 생성 (14, 15, 16번 테이블)
     */
    public void insertDefaultStock(Connection conn, String productId, String[] sizeOptions) throws SQLException {
        String sqlCombi = "INSERT INTO PRODUCT_OPTION_COMBINATIONS (COMBINATION_ID, PRODUCT_ID) VALUES (SEQ_COMBINATION.NEXTVAL, ?)";
        String sqlStock = "INSERT INTO PRODUCT_OPTION_STOCK (STOCK_ID, COMBINATION_ID, STORE_ID, STOCK, IS_SOLDOUT) VALUES (SEQ_STOCK.NEXTVAL, ?, 1, 10, 0)";
        
        // 15번 테이블(Combi_Value) 연결을 위한 VALUE_ID 조회 쿼리
        String sqlFindValueId = "SELECT VALUE_ID FROM PRODUCT_OPTION_VALUES v " +
                                "JOIN PRODUCT_OPTION_GROUPS g ON v.OPTION_GROUP_ID = g.OPTION_GROUP_ID " +
                                "WHERE g.PRODUCT_ID = ? AND v.V_MASTER_ID = ?";

        try (PreparedStatement pstmtCombi = conn.prepareStatement(sqlCombi, new String[]{"COMBINATION_ID"});
             PreparedStatement pstmtStock = conn.prepareStatement(sqlStock);
             PreparedStatement pstmtFind = conn.prepareStatement(sqlFindValueId)) {

            if (sizeOptions != null) {
                for (String vId : sizeOptions) {
                    // 1. 조합 생성
                    pstmtCombi.setString(1, productId);
                    pstmtCombi.executeUpdate();
                    
                    long combiId = 0;
                    try (ResultSet rs = pstmtCombi.getGeneratedKeys()) {
                        if (rs.next()) combiId = rs.getLong(1);
                    }

                    // 2. 재고 등록 (기본 10개)
                    if (combiId > 0) {
                        pstmtStock.setLong(1, combiId);
                        pstmtStock.executeUpdate();
                        
                        // 3. (옵션) 15번 테이블 PRODUCT_OPTION_COMBI_VALUES 채우기
                        // 등록된 VALUE_ID를 찾아서 조합과 연결
                        pstmtFind.setString(1, productId);
                        pstmtFind.setInt(2, Integer.parseInt(vId));
                        try (ResultSet rs = pstmtFind.executeQuery()) {
                            if (rs.next()) {
                                long valueId = rs.getLong("VALUE_ID");
                                String sqlCV = "INSERT INTO PRODUCT_OPTION_COMBI_VALUES (VALUE_ID, COMBINATION_ID) VALUES (?, ?)";
                                try (PreparedStatement pstmtCV = conn.prepareStatement(sqlCV)) {
                                    pstmtCV.setLong(1, valueId);
                                    pstmtCV.setLong(2, combiId);
                                    pstmtCV.executeUpdate();
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
}