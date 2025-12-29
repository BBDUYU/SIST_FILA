package login;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import member.MemberDAO;
import member.MemberDTO;

@WebServlet("/login.do")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String id = request.getParameter("mb_id");
        String pw = request.getParameter("password");

        MemberDAO dao = new MemberDAO();
        MemberDTO member = dao.login(id, pw);

        if (member == null) {
            response.sendRedirect(
                request.getContextPath() + "/view/user/login.jsp?error=fail"
            );
            return;
        }

        HttpSession session = request.getSession();
        session.setAttribute("auth", member);
        session.setMaxInactiveInterval(60 * 30); // 30분

        response.sendRedirect(request.getContextPath() + "/view/main.jsp");
    }

    // GET 접근 차단
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
    }
}
