package command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class MyPageQnaHandler implements CommandHandler {

    @Override
    public String process(HttpServletRequest request, HttpServletResponse response) {
        // 1:1 문의 페이지
        return "/view/mypage/qna.jsp";
    }
}
