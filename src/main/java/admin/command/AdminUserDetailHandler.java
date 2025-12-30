package admin.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import admin.domain.UserInfoDTO;
import admin.service.AdminUserService;
import command.CommandHandler;

public class AdminUserDetailHandler implements CommandHandler {

    @Override
    public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String strUserNum = request.getParameter("userNum");
        if (strUserNum == null || strUserNum.isEmpty()) {
            return "redirect:/admin/userList.htm"; // 번호가 없으면 리스트로 튕기기
        }
        
        int userNum = Integer.parseInt(strUserNum);
        
        // 2. 서비스 호출
        AdminUserService service = AdminUserService.getInstance();
        UserInfoDTO user = service.getUserDetail(userNum);
        
        // 3. 결과 담기
        request.setAttribute("user", user);
        
        // 4. 상세 페이지 JSP 경로 리턴
        return "/view/admin/admin_user_info.jsp";
    }
}