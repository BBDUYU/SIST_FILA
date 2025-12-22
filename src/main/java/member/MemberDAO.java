package member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.util.ConnectionProvider;

public class MemberDAO {

    public MemberDTO login(String id, String pw) {

        String sql =
            "SELECT user_number, id, name " +
            "FROM users " +
            "WHERE id = ? " +
            "AND password = ?";

        try (
            Connection conn = ConnectionProvider.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql)
        ) {
        	System.out.println(conn.getMetaData().getUserName());


            pstmt.setString(1, id);
            pstmt.setString(2, pw);

            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                MemberDTO dto = new MemberDTO();
                dto.setUserNumber(rs.getInt("user_number"));
                dto.setId(rs.getString("id"));
                dto.setName(rs.getString("name"));
                return dto;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }
}
