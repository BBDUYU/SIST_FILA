package command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class MyPageHandler implements CommandHandler {

    @Override
    public String process(HttpServletRequest request, HttpServletResponse response) {
        // 마이페이지 메인 화면
        return "/view/mypage/mypage.jsp";
    }
}
