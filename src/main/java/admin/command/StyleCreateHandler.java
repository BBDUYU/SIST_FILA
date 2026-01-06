package admin.command;

import java.io.File;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.util.ConnectionProvider;

import admin.domain.ProductDTO;
import admin.domain.StyleDTO;
import admin.domain.StyleImageDTO;
import admin.domain.StyleProductDTO;
import admin.persistence.ProductDAO;
import admin.service.StyleService; // 서비스 임포트
import command.CommandHandler;

public class StyleCreateHandler implements CommandHandler {

    @Override
    public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {
        
        if (request.getMethod().equalsIgnoreCase("GET")) {
            ProductDAO pDao = ProductDAO.getInstance();
            try (Connection conn = ConnectionProvider.getConnection()) {
                List<ProductDTO> productList = pDao.selectProductList(conn);
                request.setAttribute("productList", productList);
            }
            return "/view/admin/style_create.jsp";
        } 
        
     // ... 상단 임포트 생략 ...

        else { // POST 요청 (Ajax)
            String baseDir = "C:\\fila_upload\\style";
            String tempPath = baseDir + "\\temp";
            File tempDir = new File(tempPath);
            if (!tempDir.exists()) tempDir.mkdirs();
            
            int maxSize = 10 * 1024 * 1024;
            MultipartRequest multi = new MultipartRequest(request, tempPath, maxSize, "UTF-8", new DefaultFileRenamePolicy());
            
            String styleName = multi.getParameter("style_name");
            // MultipartRequest는 인자 한 개만 받습니다. null 체크로 기본값 처리
            String useYnStr = multi.getParameter("use_yn");
            int useYn = (useYnStr != null) ? Integer.parseInt(useYnStr) : 1;

            StyleDTO styleDto = StyleDTO.builder()
                    .style_name(styleName)
                    .description(multi.getParameter("description"))
                    .use_yn(useYn)
                    .build();

            StyleService service = StyleService.getInstance();
            
            // 아래 메서드들은 Service에서 새로 만들 것입니다.
            int styleId = service.registerStyleMaster(styleDto); 

            if (styleId > 0) {
                File targetDir = new File(baseDir + "\\" + styleId);
                if (!targetDir.exists()) targetDir.mkdirs();

                List<StyleImageDTO> imageList = new ArrayList<>();
                Enumeration files = multi.getFileNames();
                int order = 1;

                while (files.hasMoreElements()) {
                    String fieldName = (String) files.nextElement();
                    String filesystemName = multi.getFilesystemName(fieldName);
                    
                    if (filesystemName != null) {
                        File oldFile = new File(tempPath + "\\" + filesystemName);
                        File newFile = new File(targetDir + "\\" + filesystemName);
                        oldFile.renameTo(newFile); 

                        StyleImageDTO imgDto = new StyleImageDTO();
                        imgDto.setStyle_id(styleId);
                        // DB 저장 경로 조절 (C:를 제외한 상대경로)
                        imgDto.setImage_url("/upload/style/" + styleId + "/" + filesystemName);
                        imgDto.setIs_main(order == 1 ? 1 : 0);
                        imgDto.setSort_order(order++);
                        imgDto.setAlt_text(styleName + " 이미지");
                        imageList.add(imgDto);
                    }
                }
                
                // 상세 정보(이미지, 상품) 한 번에 처리하는 메서드로 통합 호출
                String[] matchProducts = multi.getParameterValues("match_products");
                service.registerStyleDetails(styleId, imageList, matchProducts);

                response.getWriter().print("success");
            } else {
                response.sendError(500);
            }
            return null;
        }
    }
}