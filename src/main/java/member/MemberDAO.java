package member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import com.util.ConnectionProvider;

public class MemberDAO {

    // --- 싱글톤 패턴 시작 ---
    private static MemberDAO instance = new MemberDAO();

    // 외부에서 new MemberDAO() 못하게 private으로 막음 (선택사항이지만 권장)
    private MemberDAO() {} 

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

    // ✅ 카카오 로그인 (기존 회원 조회)
    public MemberDTO findByKakaoId(String kakaoId) {
        String sql = "SELECT user_number, id, name, kakao_id FROM users WHERE kakao_id = ?";
        try (Connection conn = ConnectionProvider.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, kakaoId);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    MemberDTO dto = new MemberDTO();
                    dto.setUserNumber(rs.getInt("user_number"));
                    dto.setId(rs.getString("id"));
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

    // ✅ 카카오 회원가입 + 로그인용 DTO 반환
    public MemberDTO insertKakaoMember(String kakaoId, String name) {
        String insertSql = "INSERT INTO users (user_number, name, kakao_id) VALUES (SEQ_USERS.NEXTVAL, ?, ?)";
        String selectSql = "SELECT user_number, name, kakao_id FROM users WHERE kakao_id = ?";

        try (Connection conn = ConnectionProvider.getConnection()) {
            try (PreparedStatement pstmt = conn.prepareStatement(insertSql)) {
                pstmt.setString(1, name);
                pstmt.setString(2, kakaoId);
                pstmt.executeUpdate();
            }
            try (PreparedStatement pstmt = conn.prepareStatement(selectSql)) {
                pstmt.setString(1, kakaoId);
                try (ResultSet rs = pstmt.executeQuery()) {
                    if (rs.next()) {
                        MemberDTO dto = new MemberDTO();
                        dto.setUserNumber(rs.getInt("user_number"));
                        dto.setName(rs.getString("name"));
                        dto.setKakaoId(rs.getString("kakao_id"));
                        return dto;
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}