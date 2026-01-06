package mypage.qna;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import command.CommandHandler;
import member.MemberDTO;

public class QnaWriteHandler implements CommandHandler {

    @Override
    public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {

        HttpSession session = request.getSession(false);
        MemberDTO loginUser = (session != null) ? (MemberDTO) session.getAttribute("auth") : null;

        if (loginUser == null) {
            return "redirect:/login.htm";
        }

        // 파라미터
        int categoryId = Integer.parseInt(request.getParameter("categoryId"));
        String title = request.getParameter("title");
        String content = request.getParameter("content");

        QnaDTO dto = new QnaDTO();
        dto.setUserNumber(loginUser.getUserNumber());
        dto.setCategoryId(categoryId);
        dto.setTitle(title);
        dto.setContent(content);

        QnaDAO dao = new QnaDAOImpl();
        dao.insert(dto);

        return "redirect:/mypage/qna.htm";
    }
}
