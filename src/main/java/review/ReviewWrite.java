package review;

import java.sql.Connection;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.util.DBConn;
import command.CommandHandler; // 인터페이스 import
import member.MemberDTO;

public class ReviewWrite implements CommandHandler { // 1. 인터페이스 구현으로 변경

    @Override // 2. process 메서드로 로직 통합
    public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {
        
        // POST 방식일 때만 처리를 원하신다면 (선택 사항)
        if (request.getMethod().equalsIgnoreCase("GET")) {
            return "/view/review/review_form.jsp"; // 혹은 적절한 폼 페이지
        }

        // 1. 세션에서 로그인 정보 가져오기
        HttpSession session = request.getSession();
        Object sessionObj = session.getAttribute("member"); 
        
        String writer = null;

        if (sessionObj != null && sessionObj instanceof MemberDTO) {
            MemberDTO member = (MemberDTO) sessionObj;
            writer = member.getId();
        }

        // 로그인 안 된 상태 처리
        if (writer == null) {
            request.setAttribute("msg", "로그인이 필요한 서비스입니다.");
            request.setAttribute("loc", "/login.htm");
            return "/view/common/alert.jsp"; // 알림창을 띄워주는 공통 JSP가 있다고 가정
        }

        // 2. 파라미터 받기
        String productId = request.getParameter("product_id");
        String content = request.getParameter("content");
        
        int rating = 5; 
        try {
            rating = Integer.parseInt(request.getParameter("rating"));
        } catch (NumberFormatException e) {
            rating = 5; 
        }
        
        // 3. DTO 생성
        ReviewDTO dto = ReviewDTO.builder()
                .product_id(productId)
                .writer(writer)
                .content(content)
                .rating(rating)
                .review_img(null) 
                .build();

        // 4. DB 저장
        Connection conn = DBConn.getConnection();
        ReviewDAO dao = new ReviewDAOImpl(conn);
        
        int rowCount = 0;
        try {
            rowCount = dao.insert(dto);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // 주의: DBConn.close()가 Connection을 닫는 로직인지 확인하세요.
            // 보통 핸들러에서는 커넥션을 직접 관리하기보다 서비스 레이어를 거치는 게 좋습니다.
            conn.close(); 
        }
        
        // 5. 결과 처리
        if (rowCount == 1) {
            // 성공 시 이동할 상세 페이지 주소 (DispatcherServlet이 처리하도록 리다이렉트 경로 리턴)
            // 뷰 리졸버 설정에 따라 "redirect:..." 형식을 쓰거나 직접 경로를 적어줍니다.
            return "/product/product_detail.htm?product_id=" + productId; 
        } else {
            return "/view/review/review_error.jsp";
        }
    }
}