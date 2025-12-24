package categories;

import java.io.IOException;
import java.sql.Connection;
import java.util.ArrayList;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.util.ConnectionProvider;
import com.util.JdbcUtil;

import search.searchDAO;
import search.searchDTO;
import event_product.eventproductDAO;
import event_product.eventproductDTO;

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
            categoriesDAO cDao = categoriesDAO.getInstance();
            searchDAO sDao = searchDAO.getInstance();
            eventproductDAO epDao = eventproductDAO.getInstance();

            if (uri.endsWith("main.mm")) {
                // 검색어 저장 (검색창에서 입력 후 엔터 쳤을 때)
                String searchItem = request.getParameter("searchItem"); 
                if (searchItem != null && !searchItem.trim().isEmpty()) {
                    sDao.upsertKeyword(conn, searchItem.trim());
                }
            	
                // 카테고리 리스트 조회
                ArrayList<categoriesDTO> categoryList = cDao.selectCategoryList(conn);
                request.setAttribute("list", categoryList);

                // 인기 검색어 조회
                ArrayList<searchDTO> popularKeywords = sDao.selectTopKeywords(conn, 8);
                request.setAttribute("popularKeywords", popularKeywords);

                // 추천 검색어 (이벤트+상품) 조회
                ArrayList<eventproductDTO> recommendKeywords = epDao.selectRecommendKeywords(conn);
                request.setAttribute("recommendKeywords", recommendKeywords);

                // 추천 상품 (슬라이더용 12개) 조회
                ArrayList<eventproductDTO> recommendProducts = epDao.selectRecommendProducts(conn);
                request.setAttribute("recommendProducts", recommendProducts);
                
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