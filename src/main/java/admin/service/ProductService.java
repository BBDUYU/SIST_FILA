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
	// ProductService.java
	public void updateProduct(CreateproductDTO dto, List<CreateproductDTO> newImages, String[] deleteImageIds, 
			String[] categoryIds, String genderOption, String sportOption, String[] sizeOptions, 
			int styleId, int sectionId, int stock) {
		Connection conn = null;
		try {
			
			conn = ConnectionProvider.getConnection();
			conn.setAutoCommit(false);

			// 1. [기본 정보 수정]
			dao.updateProduct(conn, dto);

			/* 2. [물리적 파일 삭제] 사용자가 삭제 버튼 누른 것들 실제 하드에서 지우기
			if (deleteImageIds != null && deleteImageIds.length > 0) {
				List<String> deletePaths = dao.getImagePathsByIds(conn, deleteImageIds);
				for (String path : deletePaths) {
					// 경로 정제: 가상경로가 포함되어 있다면 순수 C:/... 만 추출
					String pPath = path.contains("path=") ? path.split("path=")[1] : path;
					File f = new File(pPath);
					if (f.exists()) f.delete();
				}
				dao.deleteSpecificImages(conn, deleteImageIds); // DB에서 해당 이미지들 삭제
			}
*/
			// 3. [기존 이미지 확보 및 정제] DB에 아직 남아있는 이미지들 가져오기
			List<CreateproductDTO> currentImages = dao.selectImagesByProductId(conn, dto.getProduct_id());
			List<CreateproductDTO> finalImageList = new ArrayList<>();

			for (CreateproductDTO img : currentImages) {
				String url = img.getImage_url();
				// 이미 /displayImage... 가 붙어있다면 떼어내고 순수 C:/ 경로만 보관
				if (url.contains("path=")) {
					img.setImage_url(url.split("path=")[1]);
				}
				finalImageList.add(img);
			}

			// 4. [새 이미지 추가] 핸들러에서 넘어온 새 이미지들도 합치기
			if (newImages != null) {
				finalImageList.addAll(newImages);
			}

			// 5. [중요: 전체 삭제 후 재등록] 관계 데이터 싹 지우기
			dao.deleteRelatedData(conn, dto.getProduct_id());     // 옵션, 카테고리 등 삭제
			dao.deleteAllImagesByProductId(conn, dto.getProduct_id()); // 이미지 레코드만 싹 삭제

			// 6. [데이터 재등록]
			// 이미지 저장 (정제된 C:/... 경로로 깨끗하게 인서트)
			if (!finalImageList.isEmpty()) {
				dao.insertProductImages(conn, finalImageList);
			}

			dao.insertCategoryRelations(conn, dto.getProduct_id(), categoryIds, genderOption);
			dao.insertProductOptions(conn, dto.getProduct_id(), genderOption, sportOption, sizeOptions);
			dao.insertDefaultStock(conn, dto.getProduct_id(), sizeOptions, stock);

			if (styleId > 0) dao.insertStyleProduct(conn, dto.getProduct_id(), styleId);
			if (sectionId > 0) dao.insertEventProduct(conn, dto.getProduct_id(), sectionId);

			conn.commit();
			System.out.println("상품 수정 완료: " + dto.getProduct_id());

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