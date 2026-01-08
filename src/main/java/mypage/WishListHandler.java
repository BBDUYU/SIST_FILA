package mypage;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import command.CommandHandler;
import member.MemberDTO;
import mypage.WishListService;

public class WishListHandler implements CommandHandler {

    @Override
    public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {

        // 1) 로그인 체크
        MemberDTO loginUser = (MemberDTO) request.getSession().getAttribute("auth");
        if (loginUser == null) {
            return "redirect:/login.htm";
        }

        // 2) 서비스 호출
        WishListService service = WishListService.getInstance();
        List<WishListDTO> wishList = service.getWishList(loginUser.getUserNumber());

        // 3) JSP에 전달
        request.setAttribute("wishList", wishList);

        // ✅ mypage.jsp가 이 페이지를 include 하게 만들기
        request.setAttribute("contentPage", "/view/mypage/wishlist.jsp");

        // 4) 반드시 mypage.jsp로 이동(헤더/사이드 유지)
        return "/view/mypage/mypage.jsp";
    }
}
