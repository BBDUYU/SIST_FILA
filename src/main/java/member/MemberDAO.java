package member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import com.util.ConnectionProvider;

public class MemberDAO {

    // --- 싱글톤 패턴 시작 ---
    private static MemberDAO instance = new MemberDAO();

    // 외부에서 new MemberDAO() 못하게 private으로 막음 (선택사항이지만 권장)
    public MemberDAO() {} 

    // 서비스에서 호출할 static 메서드
    public static MemberDAO getInstance() {
        if (instance == null) {
            instance = new MemberDAO();
        }
        return instance;
    }
    // --- 싱글톤 패턴 끝 ---

    // ✅ 일반 로그인
    public MemberDTO login(String id, String pw) {
        String sql = "SELECT user_number, id, name FROM users WHERE id = ? AND password = ?";
        try (Connection conn = ConnectionProvider.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, id);
            pstmt.setString(2, pw);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    MemberDTO dto = new MemberDTO();
                    dto.setUserNumber(rs.getInt("user_number"));
                    dto.setId(rs.getString("id"));
                    dto.setName(rs.getString("name"));
                    return dto;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }


 // ✅ 회원가입
    public int insert(MemberDTO dto) {

        int result = 0;

        String sql =
            "INSERT INTO USERS ( " +
            " USER_NUMBER, ID, PASSWORD, NAME, EMAIL, PHONE, " +
            " BIRTHDAY, GENDER, ROLE, STATUS, GRADE, CREATED_AT, UPDATED_AT, KAKAO_ID " +
            ") VALUES ( " +
            " SEQ_USERS.NEXTVAL, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, SYSDATE, SYSDATE, NULL " +
            ")";

        try (Connection conn = ConnectionProvider.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, dto.getId());
            pstmt.setString(2, dto.getPassword());
            pstmt.setString(3, dto.getName());
            pstmt.setString(4, dto.getEmail());
            pstmt.setString(5, dto.getPhone());
            pstmt.setDate(6, java.sql.Date.valueOf(dto.getBirthday()));
            pstmt.setString(7, dto.getGender());
            pstmt.setString(8, dto.getRole());
            pstmt.setString(9, dto.getStatus());
            pstmt.setString(10, dto.getGrade());

            result = pstmt.executeUpdate();

            System.out.println("▶ USERS INSERT ROW = " + result);
            System.out.println("ID=" + dto.getId());
            System.out.println("EMAIL=" + dto.getEmail());
            System.out.println("BIRTHDAY=" + dto.getBirthday());

            

        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }



 // ✅ 아이디 중복확인
    public boolean isDuplicateId(String id) {
        String sql = "SELECT COUNT(*) FROM users WHERE id = ?";

        try (Connection conn = ConnectionProvider.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, id);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0; // true = 이미 존재
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
 // ✅ 이름+휴대폰으로 아이디 찾기
    public String findIdByNameAndPhone(String name, String phone) {

        String sql =
            "SELECT id FROM users " +
            "WHERE name = ? AND REPLACE(phone, '-', '') = ?";

        try (Connection conn = ConnectionProvider.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, name);
            pstmt.setString(2, phone.replace("-", ""));

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getString("id");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }


  
    public boolean updatePassword(String id, String newPw) {

        String sql = "UPDATE users SET password = ? WHERE id = ?";

        try (Connection conn = ConnectionProvider.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, newPw);
            pstmt.setString(2, id);

            return pstmt.executeUpdate() == 1;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
 // ✅ 이름 + 휴대폰 존재 여부 (아이디 찾기용)
    public boolean existsByNameAndPhone(String name, String phone) {

        String sql =
            "SELECT COUNT(*) FROM users " +
            "WHERE name = ? AND REPLACE(phone, '-', '') = ?";

        try (Connection conn = ConnectionProvider.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, name);
            pstmt.setString(2, phone.replace("-", ""));

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) return rs.getInt(1) > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

 // ✅ 아이디 + 휴대폰 존재 여부 (비밀번호 재설정용)
    public boolean existsByIdAndPhone(String id, String phone) {

        String sql =
            "SELECT COUNT(*) FROM users " +
            "WHERE id = ? AND REPLACE(phone, '-', '') = ?";

        try (Connection conn = ConnectionProvider.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, id);
            pstmt.setString(2, phone.replace("-", ""));

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) return rs.getInt(1) > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    
  
}