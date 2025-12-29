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

@WebServlet("/member/kakao-join")
public class kakaoJoinServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        String kakaoId = req.getParameter("kakaoId");
        String name = req.getParameter("name");

        if (kakaoId == null || name == null ||
            kakaoId.trim().isEmpty() || name.trim().isEmpty()) {

            resp.sendRedirect(req.getContextPath() + "/member/login.jsp");
            return;
        }

        try {
            MemberDAO dao = new MemberDAO();

            // 1. 카카오 회원 INSERT
            MemberDTO member = dao.insertKakaoMember(kakaoId, name);

            // 2. 세션 로그인 처리
            HttpSession session = req.getSession();
            session.setAttribute("loginMember", member);

            // 3. 메인 이동
            resp.sendRedirect(req.getContextPath() + "/main.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/member/login.jsp?error=fail");
        }
    }
}
