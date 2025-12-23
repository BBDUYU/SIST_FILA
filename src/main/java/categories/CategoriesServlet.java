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
// 추가된 import
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
            categoriesDAO dao = categoriesDAO.getInstance();

            if (uri.endsWith("main.mm")) {
                // 1. 카테고리 리스트 (기존)
                ArrayList<categoriesDTO> list = dao.selectCategoryList(conn);
                request.setAttribute("list", list);

                // 2. 인기 검색어 (기존)
                searchDAO sDao = searchDAO.getInstance();
                ArrayList<searchDTO> popularKeywords = sDao.selectTopKeywords(conn, 10);
                request.setAttribute("popularKeywords", popularKeywords);

                // 3. [추가] 추천 검색어 (이벤트 이름 + 상품 이름)
                eventproductDAO epDao = eventproductDAO.getInstance();
                ArrayList<eventproductDTO> recommendKeywords = epDao.selectRecommendKeywords(conn);
                request.setAttribute("recommendKeywords", recommendKeywords);

                // 4. [추가] 추천 상품 (헤더 슬라이더용)
                ArrayList<eventproductDTO> recommendProducts = epDao.selectRecommendProducts(conn);
                request.setAttribute("recommendProducts", recommendProducts);
                
                // 최종적으로 모든 데이터를 싣고 header.jsp로 이동
                String path = "/view/header.jsp";
                RequestDispatcher dispatcher = request.getRequestDispatcher(path);
                dispatcher.forward(request, response);
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