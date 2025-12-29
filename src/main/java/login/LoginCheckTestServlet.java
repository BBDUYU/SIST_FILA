package login;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import member.MemberDTO;

@WebServlet("/test/loginCheck.htm")
public class LoginCheckTestServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 여기 도착 = 필터 통과 = 로그인 상태
        HttpSession session = request.getSession(false);
        MemberDTO auth = (MemberDTO) session.getAttribute("auth");

        request.setAttribute("loginUser", auth);
        request.getRequestDispatcher("/test/loginCheck.jsp")
               .forward(request, response);
    }
}
