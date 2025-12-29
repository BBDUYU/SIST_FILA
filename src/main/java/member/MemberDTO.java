package member;

public class MemberDTO {

    private int userNumber;   // USERS.USER_NUMBER (PK)

    private String id;        // USERS.ID (일반 로그인 아이디)
    private String password;  // USERS.PASSWORD

    private String name;      // USERS.NAME
    private String phone;     // USERS.PHONE
    private String email;     // USERS.EMAIL

    private String kakaoId;   // USERS.KAKAO_ID (카카오 로그인)
    private String role;      // USERS.ROLE
    private String status;    // USERS.STATUS

    // ===== getter / setter =====
    public int getUserNumber() { return userNumber; }
    public void setUserNumber(int userNumber) { this.userNumber = userNumber; }

    public String getId() { return id; }
    public void setId(String id) { this.id = id; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getKakaoId() { return kakaoId; }
    public void setKakaoId(String kakaoId) { this.kakaoId = kakaoId; }

    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
}
