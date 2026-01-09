<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <title>회원가입</title>
</head>
<body>

<div id="wrap">
    <jsp:include page="../common/header.jsp" />

    <div id="contents" class="mbr__contents">
        <h2 class="tit__style1">회원가입</h2>

        <section class="mbr-box">

            <!-- 최종 회원가입 -->
            <form action="${pageContext.request.contextPath}/member/joinSubmit.htm"
                  method="post">

                <!-- intro에서 넘어온 값 유지 -->
                <input type="hidden" name="name" value="${param.name}">
                <input type="hidden" name="birthday" value="${param.birthday}">
                <input type="hidden" name="gender" value="${param.gender}">
                <input type="hidden" name="phone" value="${param.phone}">

                <!-- 아이디 -->
                <div class="inp-box">
                    <input type="text" name="id" placeholder="아이디" required>
                </div>

                <!-- 비밀번호 -->
                <div class="inp-box">
                    <input type="password" name="password" placeholder="비밀번호" required>
                </div>

                <!-- 이메일 -->
                <div class="inp-box">
                    <input type="email" name="email" placeholder="이메일" required>
                </div>

                <!-- 마케팅 동의 -->
                <div class="inp-box">
                    <label>
                        <input type="checkbox" name="marketingAgree" value="1">
                        마케팅 수신 동의
                    </label>
                </div>

                <div class="btn-box">
                    <button type="submit" class="btn_bg__bk">회원가입</button>
                </div>

            </form>
        </section>
    </div>

    <jsp:include page="../common/footer.jsp" />
</div>

</body>
</html>
