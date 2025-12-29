package categories;

import java.io.IOException;
import java.sql.Connection;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.util.ConnectionProvider;
import com.util.JdbcUtil;

import search.SearchDAO;
import search.SearchDTO;
import event_product.eventproductDAO;
import event_product.eventproductDTO;
import main.MainbannerDAO;
import main.MainbannerDTO;

@WebServlet("*.mm")
public class CategoriesServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        String uri = request.getRequestURI();
        Connection conn = null;

        try {
            conn = ConnectionProvider.getConnection();
            CategoriesDAO cDao = CategoriesDAO.getInstance();
            SearchDAO sDao = SearchDAO.getInstance();
            eventproductDAO epDao = eventproductDAO.getInstance();
            MainbannerDAO ebDao = MainbannerDAO.getInstance();
            
            if (uri.endsWith("main.mm")) {
                // 검색어 저장 (검색창에서 입력 후 엔터 쳤을 때)
                String searchItem = request.getParameter("searchItem"); 
                if (searchItem != null && !searchItem.trim().isEmpty()) {
                    sDao.upsertKeyword(conn, searchItem.trim());
                }
            	
                // 카테고리 리스트 조회
                ArrayList<CategoriesDTO> categoryList = cDao.selectCategoryList(conn);
                request.getSession().setAttribute("list", categoryList);

                // 인기 검색어 조회
                ArrayList<SearchDTO> popularKeywords = sDao.selectTopKeywords(conn, 8);
                request.setAttribute("popularKeywords", popularKeywords);

                // 추천 검색어 (이벤트+상품) 조회
                ArrayList<eventproductDTO> recommendKeywords = epDao.selectRecommendKeywords(conn);
                request.setAttribute("recommendKeywords", recommendKeywords);

                // 추천 상품 (슬라이더용 12개) 조회
                ArrayList<eventproductDTO> recommendProducts = epDao.selectRecommendProducts(conn);
                request.setAttribute("recommendProducts", recommendProducts);
                
                //이벤트배너
                ArrayList<MainbannerDTO> bannerList = ebDao.selectMainBannerList(conn);
                
                if (bannerList != null) {
                    // 동영상을 리스트 맨 뒤로 보내는 정렬 로직
                    bannerList.sort((a, b) -> {
                        boolean aIsVideo = a.getImageUrl().toLowerCase().endsWith(".mp4");
                        boolean bIsVideo = b.getImageUrl().toLowerCase().endsWith(".mp4");
                        
                        if (aIsVideo && !bIsVideo) return 1;  // a가 비디오면 뒤로
                        if (!aIsVideo && bIsVideo) return -1; // a가 이미지면 앞으로
                        return 0;                             // 동일 타입 유지
                    });
                    request.setAttribute("bannerList", bannerList);
                }
                
                // 모든 데이터를 싣고 이동
                // 화면 레이아웃에 따라 main.jsp 혹은 header.jsp로 결정
                String path = "/view/main.jsp"; 
                request.getRequestDispatcher(path).forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            JdbcUtil.close(conn);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}