package command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import search.SearchService;

public class SearchHandler implements CommandHandler {

	public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {
	    String keyword = request.getParameter("keyword");
	    
	    if (keyword != null && !keyword.trim().isEmpty()) {
	        // SearchService 호출
	        SearchService.getInstance().recordSearchKeyword(keyword);
	        
	        response.getWriter().write("success");
	    }
	    return null; 
	}
}