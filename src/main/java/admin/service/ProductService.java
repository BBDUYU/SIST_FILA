package admin.service;

import java.io.File;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import com.util.ConnectionProvider;
import com.util.JdbcUtil;
import admin.domain.CreateproductDTO;
import admin.persistence.CreateproductDAO;
import style.StyleDAO;

public class ProductService {
    private ProductService() {}
    private static ProductService instance = new ProductService();
    public static ProductService getInstance() { return instance; }

    private CreateproductDAO dao = CreateproductDAO.getInstance();
    private StyleDAO styleDao = StyleDAO.getInstance();
    // 1. 등록 폼에 필요한 데이터 로드
    public Map<Integer, List<Map<String, Object>>> getProductFormData() {
        try (Connection conn = ConnectionProvider.getConnection()) {
            return dao.selectAllOptions(conn);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }


    public void createProduct(CreateproductDTO product, String[] categoryIds, 
                              String genderOption, String sportOption, String[] sizeOptions,
                              ArrayList<CreateproductDTO> imageList,
                              int styleId, int sectionId, int stock) {
        Connection conn = null;
        try {
            conn = ConnectionProvider.getConnection();
            conn.setAutoCommit(false); 

            dao.insertProduct(conn, product);
            dao.insertCategoryRelations(conn, product.getProduct_id(), categoryIds,genderOption);
            
            dao.insertProductOptions(conn, product.getProduct_id(), genderOption, sportOption, sizeOptions);
            dao.insertDefaultStock(conn, product.getProduct_id(), sizeOptions, stock);            
            if (imageList != null && !imageList.isEmpty()) {
                dao.insertProductImages(conn, imageList);
            }

            if (styleId > 0) dao.insertStyleProduct(conn, product.getProduct_id(), styleId);
            if (sectionId > 0) dao.insertEventProduct(conn, product.getProduct_id(), sectionId);

            conn.commit(); 
        } catch (Exception e) {
            JdbcUtil.rollback(conn);
            e.printStackTrace();
            throw new RuntimeException(e);
        } finally {
            JdbcUtil.close(conn);
        }
    }
    public void getAdminFullFormData(javax.servlet.http.HttpServletRequest request) {
        try (Connection conn = ConnectionProvider.getConnection()) {
            // 1. 기존 옵션 데이터 (스포츠, 사이즈 등)
            request.setAttribute("options", dao.selectAllOptions(conn));
            // 2. 스타일 리스트 추가
            request.setAttribute("styleList", styleDao.selectStyleList(conn));            
            // 3. 이벤트 섹션 리스트 추가
            request.setAttribute("eventSectionList", dao.selectActiveEventSections(conn));
            
        } catch (Exception e) {
            throw new RuntimeException("폼 데이터 로드 중 오류 발생", e);
        }
    }
 // 수정 페이지용 데이터 로드
    public CreateproductDTO getProductDetail(String productId) {
        try (Connection conn = ConnectionProvider.getConnection()) {
            return dao.selectProductById(conn, productId);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    // 상품 수정 프로세스
    public void updateProduct(CreateproductDTO product, String[] categoryIds, 
                              String genderOption, String sportOption, String[] sizeOptions,
                              ArrayList<CreateproductDTO> imageList, int styleId, int sectionId, int stock) {
        Connection conn = null;
        try {
            conn = ConnectionProvider.getConnection();
            conn.setAutoCommit(false);

            // 1. 기본 정보 업데이트
            dao.updateProduct(conn, product);
            
            // 2. 기존 연관 데이터 삭제 (카테고리, 옵션, 이미지 등)
            dao.deleteRelatedData(conn, product.getProduct_id());
            
            // 3. 새로 등록 (기존 insert 로직 재활용)
            dao.insertCategoryRelations(conn, product.getProduct_id(), categoryIds,genderOption);
            dao.insertProductOptions(conn, product.getProduct_id(), genderOption, sportOption, sizeOptions);
            dao.insertDefaultStock(conn, product.getProduct_id(), sizeOptions, stock);            
            if (imageList != null && !imageList.isEmpty()) {
                dao.insertProductImages(conn, imageList);
            }
            if (styleId > 0) dao.insertStyleProduct(conn, product.getProduct_id(), styleId);
            if (sectionId > 0) dao.insertEventProduct(conn, product.getProduct_id(), sectionId);

            conn.commit();
        } catch (Exception e) {
            JdbcUtil.rollback(conn);
            throw new RuntimeException(e);
        } finally {
            JdbcUtil.close(conn);
        }
    }
    
    public void deleteProduct(String productId) {
        Connection conn = null;
        try {
            conn = ConnectionProvider.getConnection();
            conn.setAutoCommit(false);

            // 실제 삭제 대신 상태값만 변경
            dao.updateProductStatusDeleted(conn, productId);

            conn.commit();
        } catch (Exception e) {
            JdbcUtil.rollback(conn);
            throw new RuntimeException("상품 상태 변경 중 오류 발생: " + e.getMessage());
        } finally {
            JdbcUtil.close(conn);
        }
    }
}