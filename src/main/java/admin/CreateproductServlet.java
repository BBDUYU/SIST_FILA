package admin;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.util.ConnectionProvider;

import categories.CategoriesDAO;
import categories.CategoriesDTO;

@WebServlet("/admin/createProduct.do") // URL을 .do 형태로 관리하면 편리합니다.
public class CreateproductServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	// GET 방식: 등록 폼을 보여주기 전 카테고리 리스트를 가져옴
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		Connection conn = null;
		try {
			conn = ConnectionProvider.getConnection();
			CreateproductDAO dao = CreateproductDAO.getInstance();
			CategoriesDAO categoryDao = CategoriesDAO.getInstance();
			
			ArrayList<CategoriesDTO> list = categoryDao.selectCategoryList(conn);
			Map<Integer, List<Map<String, Object>>> options = dao.selectAllOptions(conn);
			request.setAttribute("list", list);
			request.setAttribute("options", options);
			String path ="/view/admin/product_create.jsp";
			request.getRequestDispatcher(path).forward(request, response);

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try { if (conn != null) conn.close(); } catch (SQLException e) {}
		}
	}

	// POST 방식: 폼에서 전송된 데이터를 DB에 저장 (앞서 짠 멀티파트 로직)
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    request.setCharacterEncoding("UTF-8");

	    // 1. 임시 저장 경로 설정
	    String rootPath = getServletContext().getRealPath("/upload/products");
	    String tempPath = rootPath + File.separator + "temp"; 
	    File tempDir = new File(tempPath);
	    if (!tempDir.exists()) tempDir.mkdirs();

	    int maxSize = 1024 * 1024 * 100;
	    MultipartRequest multi = new MultipartRequest(request, tempPath, maxSize, "UTF-8", new DefaultFileRenamePolicy());

	    Connection conn = null;
	    try {
	        conn = ConnectionProvider.getConnection();
	        conn.setAutoCommit(false);
	        CreateproductDAO dao = CreateproductDAO.getInstance();

	        // 2. productId 생성
	        String[] categoryIds = multi.getParameterValues("category_ids");
	        int mainCateId = Integer.parseInt(categoryIds[0]);
	        String productId = dao.generateProductId(conn, mainCateId);

	        // 3. 상품 전용 폴더 생성 (예: /upload/products/PROD10001)
	        String realPath = rootPath + File.separator + productId;
	        File productDir = new File(realPath);
	        if (!productDir.exists()) productDir.mkdirs();

	        // 4. 상품 기본 정보 저장
	        CreateproductDTO product = CreateproductDTO.builder()
	                .product_id(productId)
	                .category_id(mainCateId)
	                .name(multi.getParameter("productName"))
	                .description(multi.getParameter("description"))
	                .price(Integer.parseInt(multi.getParameter("price")))
	                .discount_rate(Integer.parseInt(multi.getParameter("discount")))
	                .build();
	        dao.insertProduct(conn, product);
	        dao.insertCategoryRelations(conn, productId, categoryIds);
	        String sportOption = multi.getParameter("sport_option"); // JSP의 name값 확인 필요
	        String[] sizeOptions = multi.getParameterValues("size_options"); // JSP의 name값 확인 필요

	        dao.insertProductOptions(conn, productId, sportOption, sizeOptions);

	        // 6. 기본 재고 및 조합 생성
	        dao.insertDefaultStock(conn, productId, sizeOptions);
	        
	        // 5. 파일 이동 및 이미지 DTO 생성
	        ArrayList<CreateproductDTO> imageList = new ArrayList<>();
	        Enumeration<?> files = multi.getFileNames();
	        int fileIndex = 1;
	        while (files.hasMoreElements()) {
	            String inputName = (String) files.nextElement();
	            String systemName = multi.getFilesystemName(inputName);

	            if (systemName != null) {
	                // 1. 파일 이름 변경 규칙 적용 (PROD10001_1.jpg 등)
	                String extension = systemName.substring(systemName.lastIndexOf("."));
	                String newFileName = productId + "_" + fileIndex + extension;

	                // 2. 파일 이동
	                File oldFile = new File(tempPath + File.separator + systemName);
	                File newFile = new File(realPath + File.separator + newFileName);
	                oldFile.renameTo(newFile);

	                // 3. 이미지 타입 판별
	                String type = "MAIN";
	                if (inputName.toLowerCase().contains("model")) type = "MODEL";
	                else if (inputName.toLowerCase().contains("detail")) type = "DETAIL";

	                // 4. DTO 생성 (is_main에 숫자를 대입)
	                CreateproductDTO imgDto = CreateproductDTO.builder()
	                        .product_id(productId)
	                        .image_url("/upload/products/" + productId + "/" + newFileName)
	                        .image_type(type)
	                        .is_main(type.equals("MAIN") ? 1 : 0) // 1: 메인, 0: 일반
	                        .sort_order(fileIndex) // 파일 순번 저장
	                        .build();
	                imageList.add(imgDto);
	                fileIndex++;
	            }
	        }

	        if (!imageList.isEmpty()) dao.insertProductImages(conn, imageList);

	        System.out.println(">>> 커밋 직전 - 커넥션 닫힘 여부: " + conn.isClosed());
	        conn.commit();
	        System.out.println(">>> 커밋 완료 호출됨!");
	        
	        // --- 성공 시 알림창 및 이동 ---
	        response.setContentType("text/html; charset=UTF-8");
	        PrintWriter out = response.getWriter();
	        out.println("<script>");
	        out.println("alert('상품이 성공적으로 등록되었습니다.');");
	        out.println("location.href='" + request.getContextPath() + "/main.mm';"); // main.mm으로 이동
	        out.println("</script>");
	        out.flush();

	    } catch (Exception e) {
	        // 하나라도 실패하면 롤백
	        try { if (conn != null) conn.rollback(); } catch (SQLException se) {}
	        e.printStackTrace();
	        
	        // --- 실패 시 알림창 및 이전 페이지로 이동 ---
	        response.setContentType("text/html; charset=UTF-8");
	        PrintWriter out = response.getWriter();
	        out.println("<script>");
	        out.println("alert('상품 등록에 실패하였습니다. 다시 시도해주세요.');");
	        out.println("history.back();"); // 이전 입력 폼으로 되돌리기
	        out.println("</script>");
	        out.flush();
	        
	    } finally {
	        try { if (conn != null) conn.close(); } catch (SQLException e) {}
	    }
	}
}