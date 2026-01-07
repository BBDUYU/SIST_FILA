package mypage;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import command.CommandHandler;
import member.MemberDTO;
import mypage.qna.QnaDAO;
import mypage.qna.QnaDAOImpl;
import mypage.qna.QnaDTO;

public class QnaHandler implements CommandHandler {

    @Override
    public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {

        HttpSession session = request.getSession(false);
        MemberDTO auth = (session == null) ? null : (MemberDTO) session.getAttribute("auth");

        if (auth == null) {
            response.sendRedirect(request.getContextPath() + "/login.htm");
            return null;
        }

        long userNumber = auth.getUserNumber();

        QnaDAO dao = new QnaDAOImpl();
        List<QnaDTO> qnaList = dao.findByUser(userNumber);

        request.setAttribute("qnaList", qnaList);
        request.setAttribute("contentPage", "/view/mypage/qna.jsp");

        return "/view/mypage/qna.jsp";
    }
}
