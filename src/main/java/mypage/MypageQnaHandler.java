package mypage;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import command.CommandHandler;
import java.util.List;

import inquiry.InquiryDAO;
import inquiry.InquiryDAOImpl;
import inquiry.InquiryDTO;

public class MypageQnaHandler implements CommandHandler {

    @Override
    public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {
        
        // 어떤 주소로 들어왔는지 확인
        String requestURI = request.getRequestURI(); 
        
        // 1. 글쓰기 페이지 요청 (/inquiry/write.htm)
        if (requestURI.contains("write.htm")) {
            // 이 파일이 WebContent/view/mypage/ 폴더 안에 실제로 있어야 합니다.
            return "/view/mypage/inquiryWrite.jsp"; 
        }

        // 2. 목록 페이지 요청 처리 (기본값)
        long userNumber = 10001; 
        InquiryDAO dao = new InquiryDAOImpl();
        List<InquiryDTO> list = dao.findByUser(userNumber);
        request.setAttribute("list", list);

        return "/view/mypage/inquiryList.jsp";
    }
}