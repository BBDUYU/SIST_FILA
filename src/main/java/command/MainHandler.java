package command;

import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import service.MainService;

public class MainHandler implements CommandHandler {

    @Override
    public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {
        
        // 1. 검색 파라미터 받기
        String searchItem = request.getParameter("searchItem");
        
        // 2. 서비스를 통해 데이터 뭉치 가져오기
        MainService service = MainService.getInstance();
        Map<String, Object> mainData = service.getMainData(searchItem);
        
        // 3. View(JSP)에 전달할 데이터 세팅
        // 카테고리는 헤더에서 공통으로 쓰므로 세션에 저장 (기존 서블릿 로직 유지)
        request.getSession().setAttribute("list", mainData.get("categoryList"));
        
        // 나머지 데이터는 request에 저장
        request.setAttribute("popularKeywords", mainData.get("popularKeywords"));
        request.setAttribute("recommendKeywords", mainData.get("recommendKeywords"));
        request.setAttribute("r ecommendProducts", mainData.get("recommendProducts"));
        request.setAttribute("bannerList", mainData.get("bannerList"));

        // 4. 이동할 JSP 경로 리턴
        return "/view/main.jsp";
    }
}