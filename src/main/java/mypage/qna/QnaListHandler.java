package mypage.qna;

import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import command.CommandHandler;
import member.MemberDTO;

public class QnaListHandler implements CommandHandler {

    @Override
    public String process(HttpServletRequest request, HttpServletResponse response) {

        MemberDTO loginUser = (MemberDTO) request.getSession().getAttribute("auth");
        if (loginUser == null) {
            return "redirect:/login.htm";
        }

        QnaDAO dao = new QnaDAOImpl();

        // 1️⃣ QnA 목록
        List<QnaDTO> qnaList = dao.findByUser(loginUser.getUserNumber());
        request.setAttribute("qnaList", qnaList);

        // 2️⃣ 카테고리 (모달에서도 사용)
        request.setAttribute("categoryList", dao.findCategoryList());

        // 🔥 핵심: mypage.jsp가 이걸 include 하게 만든다
        request.setAttribute("contentPage", "/view/mypage/qna.jsp");

        // 🔥 반드시 mypage.jsp로 간다 (단독 렌더링 금지)
        return "/view/mypage/mypage.jsp";
    }
}
