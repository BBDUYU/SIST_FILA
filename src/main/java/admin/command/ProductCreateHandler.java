package admin.command;

import java.io.File;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.util.ConnectionProvider;

import admin.domain.CreateproductDTO;
import admin.persistence.CreateproductDAO;
import admin.service.ProductService;
import command.CommandHandler;

public class ProductCreateHandler implements CommandHandler {

    @Override
    public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {
        
        // GET 방식: 등록 페이지로 이동
        if (request.getMethod().equalsIgnoreCase("GET")) {
            ProductService service = ProductService.getInstance();
            // 카테고리 리스트는 보통 공통으로 쓰이지만, 옵션 데이터 등은 서비스에서 가져옴
            request.setAttribute("options", service.getProductFormData());
            return "/view/admin/product_create.jsp";
        } 
        
        // POST 방식: 실제 상품 등록 처리
        else {
            // 1. 파일 업로드 경로 설정
            String rootPath = request.getServletContext().getRealPath("/upload/products");
            String tempPath = rootPath + File.separator + "temp"; 
            File tempDir = new File(tempPath);
            if (!tempDir.exists()) tempDir.mkdirs();

            int maxSize = 1024 * 1024 * 100; // 100MB
            MultipartRequest multi = new MultipartRequest(request, tempPath, maxSize, "UTF-8", new DefaultFileRenamePolicy());

            ProductService service = ProductService.getInstance();
            CreateproductDAO dao = CreateproductDAO.getInstance(); // ID 생성을 위해 직접 참조

            try (Connection conn = ConnectionProvider.getConnection()) {
                // 2. 파라미터 수집 및 상품 ID 생성
                String[] categoryIds = multi.getParameterValues("category_ids");
                int mainCateId = Integer.parseInt(categoryIds[0]);
                String productId = dao.generateProductId(conn, mainCateId);

                // 3. 상품 전용 폴더 생성
                String productPath = rootPath + File.separator + productId;
                File productDir = new File(productPath);
                if (!productDir.exists()) productDir.mkdirs();

                // 4. 상품 기본 정보 DTO 생성
                CreateproductDTO product = CreateproductDTO.builder()
                        .product_id(productId)
                        .category_id(mainCateId)
                        .name(multi.getParameter("productName"))
                        .description(multi.getParameter("description"))
                        .price(Integer.parseInt(multi.getParameter("price")))
                        .discount_rate(Integer.parseInt(multi.getParameter("discount")))
                        .build();

                // 5. 파일 처리 로직 실행 (임시 폴더 -> 실제 폴더 이동 및 리스트 생성)
                ArrayList<CreateproductDTO> imageList = processFiles(multi, productId, tempPath, productPath);

                // 6. 서비스 호출 (트랜잭션 처리)
                service.createProduct(
                    product, 
                    categoryIds, 
                    multi.getParameter("gender_option"), 
                    multi.getParameter("sport_option"), 
                    multi.getParameterValues("size_options"), 
                    imageList
                );

                // 7. 완료 후 이동 (리다이렉트나 메인페이지 경로)
                // DispatcherServlet의 구조에 따라 다르지만 보통 포워딩 경로를 보냄
                return "/main.htm"; 
            } catch (Exception e) {
                e.printStackTrace();
                throw e;
            }
        }
    }

    /**
     * 파일 이동 및 이미지 DTO 리스트 생성 로직
     */
    private ArrayList<CreateproductDTO> processFiles(MultipartRequest multi, String productId, String tempPath, String productPath) {
        ArrayList<CreateproductDTO> imageList = new ArrayList<>();
        Enumeration<?> files = multi.getFileNames();
        int fileIndex = 1;

        while (files.hasMoreElements()) {
            String inputName = (String) files.nextElement();
            String systemName = multi.getFilesystemName(inputName);

            if (systemName != null) {
                // 확장자 추출 및 새 파일명 생성 (예: PROD10001_1.jpg)
                String extension = systemName.substring(systemName.lastIndexOf("."));
                String newFileName = productId + "_" + fileIndex + extension;

                // 파일 이동 (temp -> PROD_ID 폴더)
                File oldFile = new File(tempPath + File.separator + systemName);
                File newFile = new File(productPath + File.separator + newFileName);
                oldFile.renameTo(newFile);

                // 이미지 타입 판별
                String type = "MAIN";
                if (inputName.toLowerCase().contains("model")) type = "MODEL";
                else if (inputName.toLowerCase().contains("detail")) type = "DETAIL";

                // 이미지 DTO 생성
                CreateproductDTO imgDto = CreateproductDTO.builder()
                        .product_id(productId)
                        .image_url("/upload/products/" + productId + "/" + newFileName)
                        .image_type(type)
                        .is_main(type.equals("MAIN") ? 1 : 0)
                        .sort_order(fileIndex)
                        .build();
                
                imageList.add(imgDto);
                fileIndex++;
            }
        }
        return imageList;
    }
}