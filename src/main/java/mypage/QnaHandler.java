package mypage;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import command.CommandHandler;
import member.MemberDTO;
import mypage.qna.QnaDTO;
import mypage.QnaService;

public class QnaHandler implements CommandHandler {

    @Override
    public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {

        HttpSession session = request.getSession(false);
        MemberDTO auth = (session == null) ? null : (MemberDTO) session.getAttribute("auth");

        if (auth == null) {
            return "redirect:/login.htm";
        }

        QnaService service = QnaService.getInstance();

        List<QnaDTO> qnaList = service.getQnaList(auth.getUserNumber());

        request.setAttribute("qnaList", qnaList);
        request.setAttribute("contentPage", "/view/mypage/qna.jsp");

        return "/view/mypage/mypage.jsp";
    }
}
