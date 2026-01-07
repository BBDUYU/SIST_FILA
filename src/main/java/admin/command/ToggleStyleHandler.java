package admin.command;

import java.sql.Connection;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.util.ConnectionProvider;
import com.util.JdbcUtil;
import admin.persistence.StyleDAO;
import command.CommandHandler;

public class ToggleStyleHandler implements CommandHandler {

    @Override
    public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {
        int styleId = Integer.parseInt(request.getParameter("id"));
        int status = Integer.parseInt(request.getParameter("status"));

        Connection conn = null;
        try {
            conn = ConnectionProvider.getConnection();
            // 만약 커넥션 풀 설정이 autoCommit = false 라면 아래 코드 필수
            conn.setAutoCommit(false); 

            StyleDAO dao = StyleDAO.getInstance();
            int result = dao.updateStyleStatus(conn, styleId, status);
            
            response.setContentType("text/plain; charset=UTF-8");
            if (result > 0) {
                conn.commit(); // *** 명시적 커밋 ***
                response.getWriter().write("success");
            } else {
                conn.rollback();
                response.getWriter().write("fail");
            }
        } catch (Exception e) {
            if(conn != null) conn.rollback();
            e.printStackTrace();
            response.getWriter().write("error");
        } finally {
            JdbcUtil.close(conn);
        }
        return null;
    }
}