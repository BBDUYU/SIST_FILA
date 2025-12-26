package event;

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

@WebServlet("/event")
public class EventServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

  @Override
  protected void doGet(HttpServletRequest request, HttpServletResponse response)
      throws ServletException, IOException {

    request.setCharacterEncoding("UTF-8");
    response.setContentType("text/html; charset=UTF-8");

    int seq = Integer.parseInt(request.getParameter("seq"));

    Connection conn = null;
    try {
      conn = ConnectionProvider.getConnection();

      EventDAO dao = new EventDAO();

      Event event = dao.selectEvent(conn, seq);                  // 제목/배너/슬라이드
      List<EventGroup> groups = dao.selectGroups(conn, seq);     // 탭 그룹 목록

      // 그룹별 상품 목록까지 채우기
      for (EventGroup g : groups) {
        g.setProducts(dao.selectProductsByGroup(conn, g.getGroupId()));
      }

      request.setAttribute("event", event);
      request.setAttribute("groups", groups);

      RequestDispatcher rd = request.getRequestDispatcher("/view/event/event.jsp");
      rd.forward(request, response);

    } catch (Exception e) {
      throw new ServletException(e);
    } finally {
      JdbcUtil.close(conn);
    }
  }
}
