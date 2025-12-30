package admin.persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import com.util.JdbcUtil;
import admin.domain.UserInfoDTO;

public class UserInfoDAO implements IUserInfo {
    private static UserInfoDAO dao = new UserInfoDAO();
    private UserInfoDAO() {}
    public static UserInfoDAO getInstance() { return dao; }

    @Override
    public ArrayList<UserInfoDTO> selectUserList(Connection conn) throws SQLException {
        ArrayList<UserInfoDTO> list = new ArrayList<>();
        String sql = "SELECT USER_NUMBER, ID, NAME, EMAIL, PHONE, GRADE, STATUS, CREATED_AT FROM USERS ORDER BY CREATED_AT DESC";

        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                UserInfoDTO dto = UserInfoDTO.builder()
                        .usernumber(rs.getInt("USER_NUMBER"))
                        .id(rs.getString("ID"))
                        .childname(rs.getString("NAME")) // 기획에 따라 필드명 매핑 확인 필요
                        .email(rs.getString("EMAIL"))
                        .phone(rs.getString("PHONE"))
                        .grade(rs.getString("GRADE"))
                        .status(rs.getString("STATUS"))
                        .createAt(rs.getDate("CREATED_AT"))
                        .build();
                list.add(dto);
            }
        } finally {
            JdbcUtil.close(rs);
            JdbcUtil.close(pstmt);
        }
        return list;
    }
}