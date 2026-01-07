package mypage.qna;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import command.CommandHandler;

public class QnaWriteLayerHandler implements CommandHandler {

    @Override
    public String process(HttpServletRequest request, HttpServletResponse response) {
        // 👉 네가 쓰는 규칙 그대로
        return "/view/mypage/writeLayer.jsp";
    }
}
