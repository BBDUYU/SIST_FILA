package member;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/member/kakao-login")
public class KakaoLoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        String kakaoId = req.getParameter("kakaoId");

        if (kakaoId == null || kakaoId.trim().isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/view/user/login.jsp");
            return;
        }

        try {
            // ✅ DAO는 기본 생성자 사용
            MemberDAO dao = new MemberDAO();
            MemberDTO member = dao.findByKakaoId(kakaoId);

            if (member != null) {
                // 기존 카카오 회원 → 로그인
                HttpSession session = req.getSession();
                session.setAttribute("loginMember", member);
                resp.sendRedirect(req.getContextPath() + "/main.jsp");

            } else {
                // 최초 카카오 로그인 → 가입 유도
                req.setAttribute("kakaoId", kakaoId);
                RequestDispatcher rd =
                    req.getRequestDispatcher("/WEB-INF/view/user/kakaoJoin.jsp");
                rd.forward(req, resp);
            }

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect(
            	    req.getContextPath() + "/view/user/login.jsp?error=fail");

        }
    }
}
