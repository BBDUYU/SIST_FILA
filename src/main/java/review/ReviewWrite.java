package review;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.util.DBConn;
import member.MemberDTO; // 보여주신 MemberDTO 패키지명 적용

@WebServlet("/review/write.do")
public class ReviewWrite extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		
		PrintWriter out = response.getWriter();

		// 1. 세션에서 로그인 정보 가져오기
		HttpSession session = request.getSession();
		
		// [체크] 로그인할 때 저장한 이름이 "member"라고 가정합니다. (가장 흔한 이름)
		// 만약 로그인했는데도 계속 "로그인이 필요합니다"라고 뜨면, 이 "member"를 "authUser"나 "user"로 바꿔보세요.
		Object sessionObj = session.getAttribute("member"); 
		
		String writer = null;

		if (sessionObj != null) {
			if (sessionObj instanceof MemberDTO) {
				MemberDTO member = (MemberDTO) sessionObj;
				writer = member.getId(); // MemberDTO의 id 필드값 가져오기
			}
		}

		// 로그인 안 된 상태면 팅겨내기
		if (writer == null) {
			out.println("<script>");
			out.println("alert('로그인이 필요한 서비스입니다.');");
			out.println("location.href='/member/login.htm';"); // 로그인 페이지 주소 확인
			out.println("</script>");
			return;
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
		
		// 3. DTO 생성 (이미지는 null 처리)
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
			System.out.println("> ReviewWrite.doPost() 에러 발생");
			e.printStackTrace();
		} finally {
			DBConn.close();
		}
		
		// 5. 결과 처리
		if (rowCount == 1) {
            out.println("<script>");
            out.println("alert('리뷰가 성공적으로 등록되었습니다.');");
            // 상품 상세 페이지로 이동 (URL 패턴 확인 필수: .htm 인지 .do 인지)
            out.println("location.href='/product/product_detail.htm?product_id=" + productId + "';");
            out.println("</script>");
        } else {
            out.println("<script>");
            out.println("alert('리뷰 등록 실패. 다시 시도해주세요.');");
            out.println("history.back();");
            out.println("</script>");
        }
	}
}