package mypage.qna;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import command.CommandHandler;
import member.MemberDTO;

public class QnaWriteFormHandler implements CommandHandler {

    @Override
    public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {

        /* 1️⃣ 로그인 체크 */
        HttpSession session = request.getSession(false);
        MemberDTO loginUser = (session != null)
                ? (MemberDTO) session.getAttribute("auth")
                : null;

        if (loginUser == null) {
            // 로그인 안 했으면 로그인 페이지로
            return "redirect:/login.htm";
        }

        /* 2️⃣ 문의 카테고리 조회 */
        QnaDAO dao = new QnaDAOImpl();
        List<QnaDTO> categoryList = dao.findCategoryList();

        request.setAttribute("categoryList", categoryList);

        /* 3️⃣ 작성 화면 forward */
        return "/view/mypage/qna/qna_write.jsp";
    }
}
