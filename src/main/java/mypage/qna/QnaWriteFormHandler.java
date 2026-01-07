package mypage.qna;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import categories.CategoriesDTO;
import command.CommandHandler;
import member.MemberDTO;

public class QnaWriteFormHandler implements CommandHandler {

    @Override
    public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {

        HttpSession session = request.getSession(false);
        MemberDTO loginUser = (session != null) ? (MemberDTO) session.getAttribute("auth") : null;

        if (loginUser == null) {
            return "redirect:/login.htm";
        }

        QnaDAO dao = new QnaDAOImpl();
        List<CategoriesDTO> categoryList = dao.findCategoryList();

        request.setAttribute("categoryList", categoryList);

        // ✅ 이 JSP는 "모달 fragment"로만 내려주는 용도
        return "/view/mypage/qna_modal_form.jsp";
    }
}
