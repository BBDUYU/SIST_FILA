package admin;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class UserInfoDAO {
    private static UserInfoDAO dao = new UserInfoDAO();
    private UserInfoDAO() {}
    public static UserInfoDAO getInstance() { return dao; }

    public ArrayList<UserInfoDTO> selectUserList(Connection conn) {
        ArrayList<UserInfoDTO> list = new ArrayList<>();
        // 가입일 기준 내림차순 정렬
        String sql = "SELECT USER_NUMBER, ID, NAME, EMAIL, PHONE, GRADE, STATUS, CREATED_AT FROM USERS ORDER BY CREATED_AT DESC";

        try (PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                UserInfoDTO dto = UserInfoDTO.builder()
                        .usernumber(rs.getInt("USER_NUMBER"))
                        .id(rs.getString("ID"))
                        .childname(rs.getString("NAME")) // DTO의 childname 필드에 이름을 잠시 담음
                        .email(rs.getString("EMAIL"))
                        .phone(rs.getString("PHONE"))
                        .grade(rs.getString("GRADE"))
                        .status(rs.getString("STATUS"))
                        .createAt(rs.getDate("CREATED_AT"))
                        .build();
                list.add(dto);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}