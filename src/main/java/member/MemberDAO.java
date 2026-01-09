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
    	String sql =
    		    "INSERT INTO USERS ( " +
    		    " USER_NUMBER, ID, PASSWORD, NAME, EMAIL, PHONE, " +
    		    " BIRTHDAY, GENDER, MARKETING_AGREE, ROLE, STATUS, GRADE, CREATED_AT " +
    		    ") VALUES ( " +
    		    " SEQ_USERS.NEXTVAL, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, SYSDATE " +
    		    ")";


        try (Connection conn = ConnectionProvider.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, dto.getId());
            pstmt.setString(2, dto.getPassword());
            pstmt.setString(3, dto.getName());
            pstmt.setString(4, dto.getEmail());
            pstmt.setString(5, dto.getPhone());
            pstmt.setDate(6, java.sql.Date.valueOf(dto.getBirthday())); // yyyy-MM-dd
            pstmt.setString(7, dto.getGender());
            pstmt.setInt(8, dto.getMarketingAgree());
            pstmt.setString(9, dto.getRole());
            pstmt.setString(10, dto.getStatus());
            pstmt.setString(11, dto.getGrade());

            return pstmt.executeUpdate(); // 1이면 성공
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

   
  
}