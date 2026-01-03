package login;

import member.MemberDAO;
import member.MemberDTO;

public class LoginService implements ILogin{
	private MemberDAO dao = MemberDAO.getInstance();

    @Override
    public MemberDTO login(String id, String pw) {
        // 비밀번호 암호화 로직 등이 나중에 여기에 추가될 수 있습니다.
        return dao.login(id, pw);
    }

    @Override
    public MemberDTO kakaoLogin(String kakaoId, String name) {
        // 1. 기존 회원인지 확인
        MemberDTO member = dao.findByKakaoId(kakaoId);
        
        // 2. 없으면 신규 가입 진행
        if (member == null) {
            member = dao.insertKakaoMember(kakaoId, name);
        }
        
        return member;
    }
}
