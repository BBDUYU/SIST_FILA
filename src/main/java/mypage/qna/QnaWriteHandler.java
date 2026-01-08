package mypage.qna;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import command.CommandHandler;
import member.MemberDTO;
import mypage.QnaService;

public class QnaWriteHandler implements CommandHandler {

	@Override
	public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {

	    System.out.println("🔥🔥 QnaWriteHandler 진입");

	    MemberDTO loginUser = (MemberDTO) request.getSession().getAttribute("auth");
	    if (loginUser == null) {
	        response.sendRedirect(request.getContextPath() + "/login.htm");
	        return null;
	    }

	    int categoryId = Integer.parseInt(request.getParameter("category_id"));
	    String title = request.getParameter("title");
	    String content = request.getParameter("content");

	    QnaDTO dto = QnaDTO.builder()
	            .category_id(categoryId)
	            .title(title)
	            .content(content)
	            .build();

	    QnaService service = QnaService.getInstance();
	    service.writeQna(loginUser, dto);

	    // 🔥 핵심 수정
	    response.sendRedirect(request.getContextPath() + "/mypage/qna.htm");
	    return null;
	}

}
