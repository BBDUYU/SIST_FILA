package mypage;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import command.CommandHandler;

public class MypageHandler implements CommandHandler {

    @Override
    public String process(HttpServletRequest request,
                          HttpServletResponse response) throws Exception {

        // 지금은 화면만 보여주면 됨
        return "/view/mypage/mypage.jsp";
    }
}
