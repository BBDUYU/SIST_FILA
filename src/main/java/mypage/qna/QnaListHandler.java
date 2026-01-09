package mypage.qna;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import command.CommandHandler;
import member.MemberDTO;
import mypage.qna.QnaDTO;
import categories.CategoriesDTO;

public class QnaListHandler implements CommandHandler {

    @Override
    public String process(HttpServletRequest request, HttpServletResponse response) {

        MemberDTO loginUser = (MemberDTO) request.getSession().getAttribute("auth");
        if (loginUser == null) {
            return "redirect:/login.htm";
        }

        QnaService service = QnaService.getInstance();

        // 1. 내 문의 목록
        List<QnaDTO> qnaList = service.getQnaList(loginUser.getUserNumber());
        request.setAttribute("qnaList", qnaList);

        // 2. 문의 카테고리 (모달용)
        List<CategoriesDTO> categoryList = service.getCategoryList();
        request.setAttribute("categoryList", categoryList);

        // 3. mypage 레이아웃 사용
        return "/view/mypage/qna.jsp";
    }
}
