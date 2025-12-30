<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>카카오 회원가입 | FILA</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<style>
/* ===== 기본 ===== */
* {
    box-sizing: border-box;
    font-family: 'Arial', sans-serif;
}
body {
    margin: 0;
    background: #fff;
    color: #000;
}

/* ===== 컨테이너 ===== */
#contents {
    max-width: 420px;
    margin: 80px auto;
    padding: 0 20px;
}

.tit__style1 {
    font-size: 26px;
    font-weight: bold;
    text-align: center;
    margin-bottom: 12px;
}

.desc {
    font-size: 14px;
    color: #555;
    text-align: center;
    margin-bottom: 30px;
    line-height: 1.5;
}

/* ===== 박스 ===== */
.mbr-box {
    border-top: 2px solid #000;
    padding-top: 30px;
}

.inp-box input {
    width: 100%;
    height: 48px;
    padding: 0 14px;
    font-size: 15px;
    border: 1px solid #ccc;
    margin-bottom: 14px;
}

/* ===== 버튼 ===== */
.btn-box {
    margin-top: 20px;
}

.btn_kakao {
    display: block;
    width: 100%;
    height: 48px;
    background: #FEE500;
    color: #000;
    font-size: 15px;
    font-weight: bold;
    border: none;
    cursor: pointer;
}

.notice {
    margin-top: 20px;
    font-size: 13px;
    color: #777;
    text-align: center;
}
</style>
</head>
<body>



<div id="contents">
    <h2 class="tit__style1">카카오 회원가입</h2>
    <p class="desc">
        카카오 로그인은 완료되었습니다.<br>
        FILA 서비스를 이용하기 위해<br>
        간단한 정보만 입력해주세요.
    </p>

    <section class="mbr-box">
        <form method="post" action="<%=request.getContextPath()%>/member/kakao-join">
            <!-- 카카오 로그인 서블릿에서 전달 -->
            <input type="hidden" name="kakaoId" value="${kakaoId}">

            <div class="inp-box">
                <input type="text" name="name" placeholder="이름" required>
            </div>

            <div class="btn-box">
                <button type="submit" class="btn_kakao">
                    카카오 계정으로 가입 완료
                </button>
            </div>
        </form>

        <p class="notice">
            카카오 계정으로 간편하게 가입되며<br>
            비밀번호 없이 로그인할 수 있습니다.
        </p>
    </section>
</div>

</body>
</html>
