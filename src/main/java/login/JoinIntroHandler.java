package login;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import command.CommandHandler;

public class JoinIntroHandler implements CommandHandler {

    @Override
    public String process(HttpServletRequest request, HttpServletResponse response) {

        // 1. 파라미터 받기
        String name = request.getParameter("name");
        String birthday = request.getParameter("birthday"); // yyyyMMdd
        String gender = request.getParameter("gender");     // M / F
        String phone = request.getParameter("phone");       // 숫자만

        // 2. 세션 저장
        HttpSession session = request.getSession();
        session.setAttribute("join_name", name);
        session.setAttribute("join_birthday", birthday);
        session.setAttribute("join_gender", gender);
        session.setAttribute("join_phone", phone);

        // 3. 다음 회원가입 페이지로 이동
        return "/view/user/member_join_intro.jsp";
    }
}
