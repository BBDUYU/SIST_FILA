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
    	String command = request.getServletPath();
        boolean isEdit = command.contains("editProduct");
        
        // GET 방식: 등록 페이지 데이터 준비 및 이동
        if (request.getMethod().equalsIgnoreCase("GET")) {
        	ProductService service = ProductService.getInstance(); 
            
            service.getAdminFullFormData(request);            
            if (isEdit) {
                // 수정 모드일 때: 기존 상품 정보를 불러와서 request에 담기
                String productId = request.getParameter("id");
                CreateproductDTO product = ProductService.getInstance().getProductDetail(productId);
                request.setAttribute("product", product);
                ArrayList<CreateproductDTO> imageList = service.getProductImages(productId);
                request.setAttribute("imageList", imageList);
                
                // 3. [추가] 기존 선택된 사이즈 ID 리스트 (DAO에 구현 필요)
                // request.setAttribute("productSizes", service.getProductSizeIds(productId));
                
                // 4. [추가] 기존 선택된 카테고리 정보 (DAO에 구현 필요)
                // request.setAttribute("productCategories", service.getProductCategories(productId));
                request.setAttribute("mode", "edit");
                return "/view/admin/product_edit.jsp"; // 수정 페이지로 이동
            }
            request.setAttribute("mode", "create");
            return "/view/admin/product_create.jsp";
        } 
        
        // POST 방식: 실제 상품 등록 처리
        else {
            String rootPath = request.getServletContext().getRealPath("/upload/products");
            String tempPath = rootPath + File.separator + "temp";
            
            File tempDir = new File(tempPath);
            if (!tempDir.exists()) tempDir.mkdirs();

            int maxSize = 1024 * 1024 * 100; // 100MB
            MultipartRequest multi = new MultipartRequest(request, tempPath, maxSize, "UTF-8", new DefaultFileRenamePolicy());

            ProductService service = ProductService.getInstance();
            CreateproductDAO dao = CreateproductDAO.getInstance();

            try (Connection conn = ConnectionProvider.getConnection()) {
                String[] categoryIds = multi.getParameterValues("category_ids");
                
                String styleParam = multi.getParameter("styleId");
                String sectionParam = multi.getParameter("sectionId");
                int styleId = (styleParam != null && !styleParam.isEmpty()) ? Integer.parseInt(styleParam) : 0;
                int sectionId = (sectionParam != null && !sectionParam.isEmpty()) ? Integer.parseInt(sectionParam) : 0;
                
                int mainCateId = Integer.parseInt(categoryIds[0]);
                
                // 2. 상품 ID 결정 (수정은 기존 ID 사용, 등록은 신규 생성)
                String productId = isEdit ? multi.getParameter("product_id") : dao.generateProductId(conn, mainCateId);
                
                // 3. 상품 기본 정보 DTO 생성
                CreateproductDTO product = CreateproductDTO.builder()
                        .product_id(productId)
                        .category_id(mainCateId)
                        .name(multi.getParameter("name"))
                        .description(multi.getParameter("description"))
                        .price(Integer.parseInt(multi.getParameter("price")))
                        .discount_rate(Integer.parseInt(multi.getParameter("discount_rate")))
                        .build();

                // 4. 파일 처리 (C:\fila_upload\product\ID 폴더로 이동)
                ArrayList<CreateproductDTO> imageList = processFiles(multi, productId, tempPath, isEdit);                
                String stockStr = multi.getParameter("stock");
                int stock = (stockStr != null && !stockStr.isEmpty()) ? Integer.parseInt(stockStr) : 10; // 기본값 10
                String[] deleteImageIds = multi.getParameterValues("deleteImageIds"); // 추가
                // 5. 서비스 호출 (등록과 수정을 구분해서 호출)
                if (isEdit) {
                    service.updateProduct(
                    		product,             
                            imageList,           
                            deleteImageIds,      
                            categoryIds,        
                            multi.getParameter("gender_option"), 
                            multi.getParameter("sport_option"), 
                            multi.getParameterValues("size_options"),
                            styleId,             
                            sectionId,           
                            stock                
                    );
                } else {
                    service.createProduct(
                        product, categoryIds, 
                        multi.getParameter("gender_option"), 
                        multi.getParameter("sport_option"), 
                        multi.getParameterValues("size_options"), 
                        imageList, styleId, sectionId,stock
                    );
                }
                String contextPath = request.getContextPath(); // /SIST_FILA
                response.sendRedirect(contextPath + "/admin/productList.htm");

                return null; 
            } catch (Exception e) {
                e.printStackTrace();
                throw e;
            }
        }
    }

    private ArrayList<CreateproductDTO> processFiles(MultipartRequest multi, String productId, String tempPath, boolean isEdit) {
        ArrayList<CreateproductDTO> imageList = new ArrayList<>();
        // [체크] 경로 끝에 역슬래시가 확실히 있는지 확인
        String baseDiskPath = "C:\\fila_upload\\product\\" + productId + "\\";
        File saveDir = new File(baseDiskPath);
        
        if (!saveDir.exists()) {
            saveDir.mkdirs();
        } else if (isEdit) {
            File[] files = saveDir.listFiles();
            if (files != null) for (File f : files) f.delete();
        }

        // 파라미터 정렬
        java.util.TreeMap<String, String> sortedFiles = new java.util.TreeMap<>();
        Enumeration files = multi.getFileNames();
        while (files.hasMoreElements()) {
            String name = (String) files.nextElement();
            sortedFiles.put(name, name);
        }

        int currentSortOrder = 1;
        int mainIdx = 1, modelIdx = 1, detailIdx = 1;

        for (String paramName : sortedFiles.keySet()) {
            String systemName = multi.getFilesystemName(paramName);
            if (systemName == null) continue;

            File oldFile = new File(tempPath, systemName);
            if (!oldFile.exists()) {
                System.out.println("⚠ 임시파일 없음: " + systemName);
                continue;
            }

            // 인덱스 및 타입 설정
            String type = paramName.contains("main") ? "MAIN" : (paramName.contains("model") ? "MODEL" : "DETAIL");
            int subIdx = type.equals("MAIN") ? mainIdx++ : (type.equals("MODEL") ? modelIdx++ : detailIdx++);
            
            String ext = systemName.substring(systemName.lastIndexOf(".")).toLowerCase();
            String newFileName = productId + "_" + type.toLowerCase() + "_" + subIdx + ext;
            File newFile = new File(saveDir, newFileName);

            // [핵심 변경] Files.move 대신 직접 바이트를 읽어서 씁니다 (권한/잠금 문제 회피)
            try (java.io.FileInputStream fis = new java.io.FileInputStream(oldFile);
                 java.io.FileOutputStream fos = new java.io.FileOutputStream(newFile)) {
                
                byte[] buffer = new byte[4096];
                int length;
                while ((length = fis.read(buffer)) > 0) {
                    fos.write(buffer, 0, length);
                }
                fos.flush(); // 디스크에 즉시 기록
                
                // 기록 후 즉시 파일 확인
                if (newFile.exists() && newFile.length() > 0) {
                    System.out.println("✅ 물리 저장 성공: " + newFile.getAbsolutePath() + " (" + newFile.length() + " bytes)");
                    
                    imageList.add(CreateproductDTO.builder()
                            .product_id(productId)
                            .image_url(baseDiskPath + newFileName)
                            .image_type(type)
                            .is_main(type.equals("MAIN") && subIdx == 1 ? 1 : 0)
                            .sort_order(currentSortOrder++)
                            .build());
                    
                    // 성공 확인 후 원본 삭제
                    oldFile.delete();
                } else {
                    System.out.println("❌ 파일 생성 실패 (이유 불명): " + newFileName);
                }
            } catch (Exception e) {
                System.out.println("🔥 스트림 복사 에러: " + e.getMessage());
            }
        }
        return imageList;
    }
}