package login;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebFilter(
	    urlPatterns = {
	        "/mypage/*",
	        "/admin/*",
	        "/board/*",
	        "/test/*"
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

	        boolean isAjax = req.getRequestURI().endsWith(".ajax");

	        if (auth == null) {
	            if (isAjax) {
	                resp.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
	            } else {
	                resp.sendRedirect(req.getContextPath() + "/login.htm");
	            }
	            return;
	        }
	        


	        chain.doFilter(request, response);
	    }
	}

