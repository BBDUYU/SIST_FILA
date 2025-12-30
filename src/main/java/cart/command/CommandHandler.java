package cart.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface CommandHandler {
	
	// View를 리턴값으로 사용
	String process(HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	
}
