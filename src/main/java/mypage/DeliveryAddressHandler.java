package mypage;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import command.CommandHandler;
import member.MemberDTO;

public class DeliveryAddressHandler implements CommandHandler {

    @Override
    public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {

        // 1. 로그인 체크
        MemberDTO loginUser = (MemberDTO) request.getSession().getAttribute("auth");
        if (loginUser == null) {
            return "redirect:/login.htm";
        }

        // 2. qna.jsp 방식과 동일하게 본문 JSP를 직접 리턴
        // 이렇게 하면 delivery_address.jsp 안의 include들이 실행되면서 전체 페이지가 구성됩니다.
        return "/view/mypage/delivery_address.jsp"; 
    }
}