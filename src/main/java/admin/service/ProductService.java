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


	public void createProduct(CreateproductDTO product, String[] categoryIds, String[] tagIds,
			String genderOption, String sportOption, String[] sizeOptions,
			ArrayList<CreateproductDTO> imageList,
			int styleId, int sectionId, int stock) {
		Connection conn = null;
		try {
			conn = ConnectionProvider.getConnection();
			conn.setAutoCommit(false); 

			dao.insertProduct(conn, product);
			dao.insertCategoryRelations(conn, product.getProduct_id(), categoryIds,genderOption);
			if (tagIds != null && tagIds.length > 0) {
	            // 기존에 만든 insertCategoryRelations를 재활용하거나, 태그 전용을 호출
	            dao.insertCategoryRelations(conn, product.getProduct_id(), tagIds, null); 
	        }
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
	// ProductService.java
	public void updateProduct(CreateproductDTO dto, List<CreateproductDTO> newImages, String[] deleteImageIds, 
	        String[] categoryIds, String[] tagIds, String genderOption, String sportOption, String[] sizeOptions, 
	        int styleId, int sectionId, int stock) {
	    Connection conn = null;
	    try {
	        conn = ConnectionProvider.getConnection();
	        conn.setAutoCommit(false);

	        // 1. 기본 정보 업데이트
	        dao.updateProduct(conn, dto);

	        // 2. [이미지 처리 로직 전면 수정]
	        // 핸들러에서 "최종적으로 화면에 떠 있는 모든 이미지 목록"을 newImages로 준다고 가정해야 합니다.
	        // 만약 newImages가 새로 추가된 것만이 아니라 '최종 리스트'라면 아래처럼 단순화됩니다.
	        
	        List<CreateproductDTO> finalImageList = new ArrayList<>();
	        if (newImages != null) {
	            for (CreateproductDTO img : newImages) {
	                String url = img.getImage_url();
	                // 경로 정제 (서블릿 주소 제거)
	                if (url.contains("path=")) {
	                    url = url.split("path=")[1];
	                }
	                // 경로 역슬래시 통일 및 C: 중복 방지
	                url = url.replace("/", "\\").replace("C:C:", "C:");
	                img.setImage_url(url);
	                img.setProduct_id(dto.getProduct_id()); // ID 세팅 누락 방지
	                finalImageList.add(img);
	            }
	        }

	        // 3. [DB 청소] - 이 순서가 매우 중요합니다.
	        dao.deleteRelatedData(conn, dto.getProduct_id());     // 옵션, 카테고리 등 삭제
	        dao.deleteAllImagesByProductId(conn, dto.getProduct_id()); // 기존 이미지 레코드 싹 삭제

	        // 4. [데이터 재등록]
	        if (!finalImageList.isEmpty()) {
	            // 이제 finalImageList에는 화면에 보이는 '진짜 3장'만 들어있어야 합니다.
	            dao.insertProductImages(conn, finalImageList);
	        }

	        // 5. 기타 연관 데이터 재등록
	        dao.insertCategoryRelations(conn, dto.getProduct_id(), categoryIds, genderOption);
	        if (tagIds != null && tagIds.length > 0) {
	            dao.insertCategoryRelations(conn, dto.getProduct_id(), tagIds, null);
	        }
	        dao.insertProductOptions(conn, dto.getProduct_id(), genderOption, sportOption, sizeOptions);
	        dao.insertDefaultStock(conn, dto.getProduct_id(), sizeOptions, stock);

	        if (styleId > 0) dao.insertStyleProduct(conn, dto.getProduct_id(), styleId);
	        if (sectionId > 0) dao.insertEventProduct(conn, dto.getProduct_id(), sectionId);

	        conn.commit();
	        System.out.println("✅ 상품 수정 및 이미지 동기화 완료: " + dto.getProduct_id());

	    } catch (Exception e) {
	        JdbcUtil.rollback(conn);
	        e.printStackTrace();
	        throw new RuntimeException("수정 실패: " + e.getMessage());
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
	// ProductService.java


	// 이미지를 가져오는 메서드를 별도로 활용 (핸들러에서 호출용)
	public ArrayList<CreateproductDTO> getProductImages(String productId) {
		try (Connection conn = ConnectionProvider.getConnection()) {
			return CreateproductDAO.getInstance().selectImagesByProductId(conn, productId);
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}
	// ProductService.java 내부에 추가/수정 권장

	// 기존 선택된 카테고리 리스트 가져오기
	public List<Map<String, Object>> getProductCategories(String productId) {
		try (Connection conn = ConnectionProvider.getConnection()) {
			return dao.selectProductCategories(conn, productId); // DAO에 해당 쿼리 구현 필요
		} catch (Exception e) {
			throw new RuntimeException(e); 
		}
	}

	// 기존 선택된 사이즈 ID 리스트 가져오기
	public List<Integer> getProductSizeIds(String productId) {
		try (Connection conn = ConnectionProvider.getConnection()) {
			return dao.selectProductSizeIds(conn, productId); // DAO에 해당 쿼리 구현 필요
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}
}