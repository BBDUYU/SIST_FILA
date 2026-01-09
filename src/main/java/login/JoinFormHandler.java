package login;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import command.CommandHandler;

public class JoinFormHandler implements CommandHandler {

    @Override
    public String process(HttpServletRequest request,
                          HttpServletResponse response) {

        // 회원가입 화면으로 이동
        return "/view/user/login.jsp";
    }
}
