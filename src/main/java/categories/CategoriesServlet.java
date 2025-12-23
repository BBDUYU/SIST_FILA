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

                ArrayList<categoriesDTO> list =
                        dao.selectCategoryList(conn);

                request.setAttribute("list", list);

                searchDAO sDao = searchDAO.getInstance();
                // 상위 10개 혹은 원하는 개수만큼 조회
                ArrayList<searchDTO> popularKeywords = sDao.selectTopKeywords(conn, 10);
                request.setAttribute("popularKeywords", popularKeywords);
                
                String path = "/view/header.jsp";
                RequestDispatcher dispatcher =
                        request.getRequestDispatcher(path);
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
