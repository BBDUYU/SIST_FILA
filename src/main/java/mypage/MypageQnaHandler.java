package mypage;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

import command.CommandHandler;
import mypage.qna.QnaDAO;
import mypage.qna.QnaDAOImpl;
import categories.CategoriesDTO;

public class MypageQnaHandler implements CommandHandler {

    @Override
    public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {

        QnaDAO dao = new QnaDAOImpl();

        // ✅ 카테고리 목록 (문의 작성용)
        List<CategoriesDTO> categoryList = dao.findCategoryList();

        request.setAttribute("categoryList", categoryList);

        // 👉 마이페이지 안에서 include 될 JSP
        request.setAttribute("contentPage", "/view/mypage/qna.jsp");

        return "/view/mypage/mypage.jsp";
    }
}
