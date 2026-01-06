package mypage;

import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession; // 세션 사용을 위해 추가
import command.CommandHandler;
import member.MemberDTO; // 로그인 정보를 담은 DTO 클래스
import mypage.qna.QnaDAO;
import mypage.qna.QnaDAOImpl;
import mypage.qna.QnaDTO;

public class MypageHandler implements CommandHandler {

    @Override
    public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {
        
        String requestURI = request.getRequestURI(); 
        
        // 1. 1대1 문의하기 글쓰기 폼 요청
        if (requestURI.contains("write.htm")) {
            return "/view/mypage/inquiryWrite.jsp"; 
        }

        // 2. 1대1 문의 리스트 요청 (/inquiry/list.htm)
        if (requestURI.contains("inquiry")) {
            // [수정 포인트] 세션에서 로그인한 사용자 정보를 가져옵니다.
            HttpSession session = request.getSession(false);
            MemberDTO auth = (session == null) ? null : (MemberDTO) session.getAttribute("auth");

            if (auth != null) {
                // 고정된 10001 대신 실제 로그인한 유저의 번호를 사용합니다.
                long userNumber = auth.getUserNumber(); 
                QnaDAO dao = new QnaDAOImpl();
                List<QnaDTO> list = dao.findByUser(userNumber);
                request.setAttribute("list", list);
                
           
                return "/view/mypage/inquiryList.jsp";
            } else {
                // 로그인 정보가 없으면 로그인 페이지로 리다이렉트
                response.sendRedirect(request.getContextPath() + "/login.htm");
                return null;
            }
        }

        // 3. 마이페이지 메인 (/mypage.htm)
        return "/view/mypage/mypage.jsp"; 
    }
}