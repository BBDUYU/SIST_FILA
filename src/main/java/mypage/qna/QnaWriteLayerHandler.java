package mypage.qna;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import command.CommandHandler;
import mypage.QnaService;

public class QnaWriteLayerHandler implements CommandHandler {

	@Override
	public String process(HttpServletRequest request, HttpServletResponse response) {

	    QnaService service = QnaService.getInstance();

	    request.setAttribute(
	        "categoryList",
	        service.getCategoryList()
	    );

	    return "/view/mypage/writeLayer.jsp";
	}
}