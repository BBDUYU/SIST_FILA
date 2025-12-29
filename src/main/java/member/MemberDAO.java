package member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.util.ConnectionProvider;

public class MemberDAO {

    // ✅ 기존 로그인 (그대로 유지)
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

    // ✅ ⭐ 여기부터 추가 ⭐ (카카오 로그인용)
    public MemberDTO findByKakaoId(String kakaoId) {

        String sql =
            "SELECT user_number, id, name, kakao_id " +
            "FROM users " +
            "WHERE kakao_id = ?";

        try (
            Connection conn = ConnectionProvider.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql)
        ) {

            pstmt.setString(1, kakaoId);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                MemberDTO dto = new MemberDTO();
                dto.setUserNumber(rs.getInt("user_number"));
                dto.setId(rs.getString("id"));      // 일반 ID 없을 수도 있음
                dto.setName(rs.getString("name"));
                dto.setKakaoId(rs.getString("kakao_id"));
                return dto;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

//✅ 카카오 회원가입 (INSERT)
public MemberDTO insertKakaoMember(String kakaoId, String name) {

 String insertSql =
     "INSERT INTO users (user_number, name, kakao_id) " +
     "VALUES (SEQ_USERS.NEXTVAL, ?, ?)";

 String selectSql =
     "SELECT user_number, name, kakao_id " +
     "FROM users " +
     "WHERE kakao_id = ?";

 try (Connection conn = ConnectionProvider.getConnection()) {

     // 1. INSERT
     try (PreparedStatement pstmt = conn.prepareStatement(insertSql)) {
         pstmt.setString(1, name);
         pstmt.setString(2, kakaoId);
         pstmt.executeUpdate();
     }

     // 2. INSERT 후 다시 조회 (로그인용 DTO 생성)
     try (PreparedStatement pstmt = conn.prepareStatement(selectSql)) {
         pstmt.setString(1, kakaoId);
         ResultSet rs = pstmt.executeQuery();

         if (rs.next()) {
             MemberDTO dto = new MemberDTO();
             dto.setUserNumber(rs.getInt("user_number"));
             dto.setName(rs.getString("name"));
             dto.setKakaoId(rs.getString("kakao_id"));
             return dto;
         }
     }

 } catch (Exception e) {
     e.printStackTrace();
 }

 return null;
}
}
