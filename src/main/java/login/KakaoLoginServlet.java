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

@WebServlet("/member/kakao-login")
public class KakaoLoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String kakaoId = request.getParameter("kakaoId");
        String name = request.getParameter("name");

        if (kakaoId == null || kakaoId.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        MemberDAO dao = new MemberDAO();
        MemberDTO member = dao.findByKakaoId(kakaoId);

        if (member == null) {
            // 신규 카카오 회원 → 회원가입
            member = dao.insertKakaoMember(kakaoId, name);
        }

        HttpSession session = request.getSession();
        session.setAttribute("auth", member);
        session.setMaxInactiveInterval(60 * 30);

        response.sendRedirect(request.getContextPath() + "/view/main.jsp");
    }
}
