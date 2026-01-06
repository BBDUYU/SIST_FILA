package mypage.qna;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import command.CommandHandler;
import member.MemberDTO;

public class QnaWriteHandler implements CommandHandler {

    @Override
    public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {

        /* 1️⃣ 로그인 체크 */
        HttpSession session = request.getSession(false);
        MemberDTO loginUser = (session != null)
                ? (MemberDTO) session.getAttribute("auth")
                : null;

        if (loginUser == null) {
            return "redirect:/login.htm";
        }

        /* 2️⃣ 파라미터 받기 */
        int categoryId = Integer.parseInt(request.getParameter("categoryId"));
        String title = request.getParameter("title");
        String content = request.getParameter("content");

        /* 3️⃣ DTO 세팅 */
        QnaDTO dto = new QnaDTO();
        dto.setUserNumber(loginUser.getUserNumber());
        dto.setCategoryId(categoryId);
        dto.setTitle(title);
        dto.setContent(content);

        /* 4️⃣ DB INSERT */
        QnaDAO dao = new QnaDAOImpl();
        dao.insert(dto);

        /* 5️⃣ 목록으로 이동 */
        return "redirect:/mypage/qna.htm";
    }
}
