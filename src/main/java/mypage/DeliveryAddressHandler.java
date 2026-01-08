package mypage;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import command.CommandHandler;
import member.MemberDTO;

public class DeliveryAddressHandler implements CommandHandler {

    @Override
    public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {

        // 로그인 체크 (너희 세션 auth 기준)
        MemberDTO loginUser = (MemberDTO) request.getSession().getAttribute("auth");
        if (loginUser == null) return "redirect:/login.htm";

        // ✅ 마이페이지 레이아웃에 배송지 페이지를 꽂기
        request.setAttribute("contentPage", "/view/mypage/delivery_address.jsp");

        // ✅ 레이아웃으로 보내기 (중요)
        return "/view/mypage/mypage.jsp";
    }
}