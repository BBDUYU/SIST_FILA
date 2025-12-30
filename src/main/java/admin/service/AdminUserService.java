package admin.service;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import com.util.ConnectionProvider;
import com.util.JdbcUtil;
import admin.domain.UserInfoDTO;
import admin.persistence.UserInfoDAO;

public class AdminUserService {
    private AdminUserService() {}
    private static AdminUserService instance = new AdminUserService();
    public static AdminUserService getInstance() { return instance; }

    public ArrayList<UserInfoDTO> getUserList() {
        Connection conn = null;
        try {
            conn = ConnectionProvider.getConnection();
            UserInfoDAO dao = UserInfoDAO.getInstance();
            return dao.selectUserList(conn);
        } catch (Exception e) {
            throw new RuntimeException("회원 목록 로드 실패", e);
        } finally {
            JdbcUtil.close(conn);
        }
    }
}