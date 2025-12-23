package search;

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

 
            if (uri.contains("record.ss")) {
                String keyword = request.getParameter("keyword");
                if(keyword != null && !keyword.isEmpty()) {
                    dao.upsertKeyword(conn, keyword);
                }

                // JSON으로 결과 반환
                response.setContentType("application/json; charset=UTF-8");
                response.getWriter().write("{\"status\":\"ok\"}");
                return;
            } else if (uri.contains("top-keywords.ss")) {
            	    int limit = 10;
            	    ArrayList<searchDTO> topList = dao.selectTopKeywords(conn, limit);

            	    // JSON 문자열 수동 생성 (간단하게 구현)
            	    // 혹은 Gson 같은 라이브러리가 있다면 더 편하게 사용 가능합니다.
            	    StringBuilder json = new StringBuilder("[");
            	    for (int i = 0; i < topList.size(); i++) {
            	        searchDTO dto = topList.get(i);
            	        json.append(String.format("{\"keyword\":\"%s\", \"count\":%d}", 
            	                    dto.getKeyword(), dto.getSearch_count()));
            	        if (i < topList.size() - 1) json.append(",");
            	    }
            	    json.append("]");

            	    response.setContentType("application/json; charset=UTF-8");
            	    response.getWriter().write(json.toString());
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
