package event;

import com.util.ConnectionProvider;
import com.util.JdbcUtil;
import event.EventDAO;
import event.dto.EventDetailDTO;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;

@WebServlet("/event")
public class EventServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private final EventDAO eventDao = new EventDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        long eventId = 0;
        try {
            eventId = Long.parseLong(request.getParameter("eventId"));
        } catch (Exception ignored) {
            // 테스트용 기본값
            eventId = 1236;
        }

        Connection con = null;
        try {
            con = ConnectionProvider.getConnection();

            EventDetailDTO detail = eventDao.selectEventDetail(con, eventId);
            if (detail == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Event not found");
                return;
            }

            request.setAttribute("detail", detail);
            RequestDispatcher rd = request.getRequestDispatcher("/view/event/event.jsp");
            rd.forward(request, response);

        } catch (Exception e) {
            throw new ServletException(e);
        } finally {
            JdbcUtil.close(con);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
