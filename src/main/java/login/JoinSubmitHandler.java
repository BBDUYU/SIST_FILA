package login;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import command.CommandHandler;
import member.MemberDAO;
import member.MemberDTO;

public class JoinSubmitHandler implements CommandHandler {

    @Override
    public String process(HttpServletRequest request, HttpServletResponse response) {

        // 1️⃣ 파라미터 수집
        String id = request.getParameter("id");
        String password = request.getParameter("password");
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String birthday = request.getParameter("birthday"); // yyyy-MM-dd
        String gender = request.getParameter("gender");

        String marketingAgreeParam = request.getParameter("marketingAgree");
        int marketingAgree = (marketingAgreeParam != null) ? 1 : 0;

        // 2️⃣ DTO 매핑 (DB 테이블 기준)
        MemberDTO dto = new MemberDTO();
        dto.setId(id);
        dto.setPassword(password);
        dto.setName(name);
        dto.setEmail(email);
        dto.setPhone(phone);
        dto.setBirthday(birthday);
        dto.setGender(gender);
        dto.setMarketingAgree(marketingAgree);

        // 기본값
        dto.setRole("USER");
        dto.setStatus("ACTIVE");
        dto.setGrade("BASIC");

        // 3️⃣ DB 저장
        MemberDAO dao = MemberDAO.getInstance();
        int result = dao.insert(dto);

        // 4️⃣ 결과 처리
        if (result == 1) {
            // 성공 → 로그인 페이지
            return "redirect:/login.htm";
        } else {
            // 실패 → 다시 회원가입 페이지
            request.setAttribute("error", "joinFail");
            return "/view/user/member_join_intro.jsp";
        }
    }
}
