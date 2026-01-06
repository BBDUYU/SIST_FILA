	package mypage.qna;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import command.CommandHandler;
import member.MemberDTO;

public class QnaListHandler implements CommandHandler {

    @Override
    public String process(HttpServletRequest request, HttpServletResponse response) {

        // 로그인 사용자
        MemberDTO loginUser = (MemberDTO) request.getSession().getAttribute("auth");

        QnaDAO dao = new QnaDAOImpl();
        List<QnaDTO> list = dao.findByUser(loginUser.getUserNumber());

        request.setAttribute("list", list);

        // ⭐⭐⭐ 이게 핵심
        request.setAttribute("contentPage", "/view/mypage/qna_list.jsp");

        return "/view/mypage/mypage.jsp";
    }
}
