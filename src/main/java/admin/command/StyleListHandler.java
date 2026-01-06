package admin.command;

import java.sql.Connection;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.util.ConnectionProvider;
import command.CommandHandler;
import admin.persistence.StyleDAO;
import admin.domain.StyleDTO;

public class StyleListHandler implements CommandHandler {

    @Override
    public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {
        StyleDAO styleDAO = StyleDAO.getInstance();

        List<StyleDTO> styleList = null;
        try (Connection conn = ConnectionProvider.getConnection()) {
            styleList = styleDAO.selectStyleList(conn);
        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("styleList", styleList);
        
        request.setAttribute("pageName", "style");

        return "/view/admin/style_list.jsp";
    }
}