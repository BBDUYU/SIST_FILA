package admin;

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

// 관리자 페이지 호출 시 이 서블릿을 거치도록 설정 (패턴을 *.mm으로 하거나 경로를 맞추세요)
@WebServlet("admin.ad") 
public class UserInfoServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        Connection conn = null;
        try {
            // 1. DB 연결
            conn = ConnectionProvider.getConnection();
            
            // 2. AdminDAO를 통해 회원 리스트 조회
            UserInfoDAO dao = UserInfoDAO.getInstance();
            ArrayList<UserInfoDTO> userList = dao.selectUserList(conn);
            
            // 3. JSP에 전달할 수 있도록 리스트 저장
            request.setAttribute("userList", userList);
            
            // 4. 관리자 메인(회원 목록) 페이지로 이동
            String path = "/view/admin/admin.jsp"; 
            request.getRequestDispatcher(path).forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // 5. 커넥션 종료
            JdbcUtil.close(conn);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}