package member;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import java.io.IOException;

@WebServlet("/login.do")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        String id = req.getParameter("id");
        String pw = req.getParameter("pw");

        MemberDAO dao = new MemberDAO();
        MemberDTO member = dao.login(id, pw);

        if (member != null) {
            HttpSession session = req.getSession();
            session.setAttribute("loginMember", member);

            resp.sendRedirect(
                req.getContextPath() + "/view/user/login.jsp?success=true"
            );
        } else {
            resp.sendRedirect(
                req.getContextPath() + "/view/user/login.jsp?error=fail"
            );
        }
}
}