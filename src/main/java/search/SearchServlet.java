package search;

import java.io.IOException;
import java.sql.Connection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.util.ConnectionProvider;
import com.util.JdbcUtil;

@WebServlet("*.ss")
public class SearchServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        String uri = request.getRequestURI();
        Connection conn = null;

        try {
            conn = ConnectionProvider.getConnection();
            searchDAO dao = searchDAO.getInstance();

 
            if (uri.endsWith("record.ss")) {
                String keyword = request.getParameter("keyword");
                if(keyword != null && !keyword.isEmpty()) {
                    dao.upsertKeyword(conn, keyword);
                }

                // JSON으로 결과 반환
                response.setContentType("application/json; charset=UTF-8");
                response.getWriter().write("{\"status\":\"ok\"}");
                return;
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
