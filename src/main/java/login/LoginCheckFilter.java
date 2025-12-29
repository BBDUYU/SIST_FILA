package login;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebFilter(
    urlPatterns = {
        "/test/*",
        "/board/*",
        "/admin/*"
    }
)
public class LoginCheckFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response,
                         FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;

        HttpSession session = req.getSession(false);
        Object auth = (session == null) ? null : session.getAttribute("auth");

        // 로그인 안 된 상태
        if (auth == null) {
            resp.sendRedirect(req.getContextPath() + "/view/user/login.jsp");
            return;
        }

        // 로그인 되어 있으면 통과
        chain.doFilter(request, response);
    }
}
