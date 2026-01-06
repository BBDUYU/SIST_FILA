package mypage;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

import command.CommandHandler;
import mypage.qna.QnaDAO;
import mypage.qna.QnaDAOImpl;
import mypage.qna.QnaDTO;

public class MypageQnaHandler implements CommandHandler {

    @Override
    public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {

        QnaDAO dao = new QnaDAOImpl();

        // ⭐ 카테고리 목록
        List<QnaDTO> categoryList = dao.findCategoryList();

        request.setAttribute("categoryList", categoryList);
       

        // 문의 작성 JSP
        return "/view/mypage/qna_write.jsp";
    }
}
