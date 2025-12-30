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
    public UserInfoDTO getUserDetail(int userNum) {
        Connection conn = null;
        try {
            conn = ConnectionProvider.getConnection();
            UserInfoDAO dao = UserInfoDAO.getInstance();
            UserInfoDTO user = dao.selectOne(conn, userNum);
            
            // 2. 포인트 내역 추가로 가져오기
            if (user != null) {
                ArrayList<UserInfoDTO> pointList = dao.selectPointList(conn, userNum);
                user.setPointList(pointList); // DTO에 List<UserInfoDTO> pointList 필드 추가 필요
            }
            return user;
        } catch (Exception e) {
            throw new RuntimeException("회원 상세 정보 로드 실패", e);
        } finally {
            JdbcUtil.close(conn);
        }
    }
    
}