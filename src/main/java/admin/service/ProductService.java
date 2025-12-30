package admin.service;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import com.util.ConnectionProvider;
import com.util.JdbcUtil;
import admin.domain.CreateproductDTO;
import admin.persistence.CreateproductDAO;

public class ProductService {
    private ProductService() {}
    private static ProductService instance = new ProductService();
    public static ProductService getInstance() { return instance; }

    private CreateproductDAO dao = CreateproductDAO.getInstance();

    // 1. 등록 폼에 필요한 데이터 로드
    public Map<Integer, List<Map<String, Object>>> getProductFormData() {
        try (Connection conn = ConnectionProvider.getConnection()) {
            return dao.selectAllOptions(conn);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    // 2. 상품 등록 전체 프로세스 (트랜잭션)
    public void createProduct(CreateproductDTO product, String[] categoryIds, 
                              String genderOption, String sportOption, String[] sizeOptions,
                              ArrayList<CreateproductDTO> imageList) {
        Connection conn = null;
        try {
            conn = ConnectionProvider.getConnection();
            conn.setAutoCommit(false); // 트랜잭션 시작

            // 1. 기본 정보 및 카테고리 관계
            dao.insertProduct(conn, product);
            dao.insertCategoryRelations(conn, product.getProduct_id(), categoryIds);
            
            // 2. 옵션 및 재고
            dao.insertProductOptions(conn, product.getProduct_id(), genderOption, sportOption, sizeOptions);
            dao.insertDefaultStock(conn, product.getProduct_id(), sizeOptions);
            
            // 3. 이미지 저장
            if (imageList != null && !imageList.isEmpty()) {
                dao.insertProductImages(conn, imageList);
            }

            conn.commit(); // 모든 작업 성공 시 커밋
        } catch (Exception e) {
            JdbcUtil.rollback(conn); // 하나라도 실패 시 롤백
            throw new RuntimeException(e);
        } finally {
            JdbcUtil.close(conn);
        }
    }
}