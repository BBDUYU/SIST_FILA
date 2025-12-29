package member;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import java.io.IOException;

@WebServlet("/member/login")
public class LoginServlet extends HttpServlet {

    // ✅ 로그인 페이지 보여주기
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.getRequestDispatcher("/WEB-INF/views/member/login.jsp")
           .forward(req, resp);
    }

    // ✅ 로그인 처리
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

    	 req.setCharacterEncoding("UTF-8");

         String id = req.getParameter("mb_id");
         String pw = req.getParameter("password");

         MemberDAO dao = new MemberDAO();
         MemberDTO member = dao.login(id, pw);

         if (member != null) {
             HttpSession session = req.getSession();
             session.setAttribute("loginMember", member);
             resp.sendRedirect(req.getContextPath() + "/main.jsp");
         } else {
             resp.sendRedirect(req.getContextPath() + "/view/user/login.jsp?error=fail");
         }
     }
 }