package admin.service;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;
import com.util.ConnectionProvider;
import com.util.JdbcUtil;
import admin.domain.StyleDTO;
import admin.domain.StyleImageDTO;
import admin.domain.StyleProductDTO;
import admin.persistence.StyleDAO;

public class StyleService {
    private static StyleService instance = new StyleService();
    public static StyleService getInstance() { return instance; }
    private StyleService() {}

    private StyleDAO styleDAO = StyleDAO.getInstance();

    public boolean registerStyle(StyleDTO styleDto, List<StyleImageDTO> imageList, List<StyleProductDTO> productList) {
        Connection conn = null;
        try {
            conn = ConnectionProvider.getConnection(); 
            conn.setAutoCommit(false); 

            int styleId = styleDAO.insertStyle(conn, styleDto);
            
            if (styleId > 0) {
                for (StyleImageDTO img : imageList) {
                    img.setStyle_id(styleId);
                    styleDAO.insertStyleImage(conn, img);
                }
                
                for (StyleProductDTO prod : productList) {
                    prod.setStyle_id(styleId);
                    styleDAO.insertStyleProduct(conn, prod);
                }
                
                conn.commit(); 
                return true;
            }
            return false;
        } catch (SQLException | javax.naming.NamingException e) { // NamingException 추가
            if (conn != null) JdbcUtil.rollback(conn); 
            e.printStackTrace();
            return false;
        } finally {
            JdbcUtil.close(conn);
        }
    }
 // StyleService.java
    public int registerStyleMaster(StyleDTO dto) {
        try (Connection conn = ConnectionProvider.getConnection()) {
            return styleDAO.insertStyle(conn, dto);
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }

    public void registerStyleDetails(int styleId, List<StyleImageDTO> images, String[] productIds) {
        Connection conn = null;
        try {
            conn = ConnectionProvider.getConnection();
            conn.setAutoCommit(false);
            
            // 1. 이미지 정보 저장
            for (StyleImageDTO img : images) {
                styleDAO.insertStyleImage(conn, img);
            }
            
            // 2. 상품 매칭 정보 저장
            if (productIds != null) {
                for (int i = 0; i < productIds.length; i++) {
                    StyleProductDTO spDto = new StyleProductDTO();
                    spDto.setStyle_id(styleId);
                    spDto.setProduct_id(productIds[i]);
                    spDto.setSort_order(i + 1);
                    styleDAO.insertStyleProduct(conn, spDto);
                }
            }
            conn.commit();
        } catch (Exception e) {
            JdbcUtil.rollback(conn);
            e.printStackTrace();
        } finally {
            JdbcUtil.close(conn);
        }
    }
}