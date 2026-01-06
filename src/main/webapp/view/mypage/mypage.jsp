<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>마이페이지</title>

  <link rel="stylesheet" href="/css/normalize.css">
  <link rel="stylesheet" href="/css/layout.css">
  <link rel="stylesheet" href="/css/sub.css">

  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>

<body class="mypage">

<div id="wrap">

  <!-- HEADER -->
  <jsp:include page="/view/common/header.jsp" />

  <!-- CONTENTS -->
  <main id="contents" class="mypage__contents">

    <!-- 상단 블루 영역 -->
    <section class="mypage__tab">
      <div class="inner">

        <div class="my-info-box">
          <div class="top">
            <p class="level">WHITE</p>
            <a href="/customer/membership.htm" class="benefit__btn">혜택보기</a>
          </div>

          <p class="name">
            <span>${loginUser.name}</span>님
          </p>

          <a href="/mypage/modify.htm" class="info-modify__btn">내 정보 변경</a>
        </div>

        <div class="my-link-box">
          <div><dl><dt>쿠폰</dt><dd>0개</dd></dl></div>
          <div><dl><dt>포인트</dt><dd>0P</dd></dl></div>
          <div><dl><dt>위시리스트</dt><dd>0개</dd></dl></div>
          <div><dl><dt>주문내역</dt><dd>0건</dd></dl></div>
        </div>

      </div>
    </section>

    <!-- 본문 -->
    <section class="mypage__area">

      <!-- 좌측 메뉴 -->
      <aside class="my-lnb">
  <h2 class="tit__style4">마이페이지</h2>

  <div>
    <p class="tit">쇼핑정보</p>
    <ul>
      <li><a href="/mypage/order.htm">주문 · 배송 조회</a></li>
      <li><a href="/mypage/cancel.htm">교환 · 취소 · 반품 조회</a></li>
      <li><a href="/mypage/review.htm">리뷰</a></li>
    </ul>
  </div>

  <div>
    <p class="tit">상품정보</p>
    <ul>
      <li><a href="/mypage/wishlist.htm">위시리스트</a></li>
      <li><a href="/mypage/today.htm">오늘 본 상품</a></li>
      <li><a href="/mypage/custom.htm">커스텀 스튜디오</a></li>
      <li><a href="/mypage/restock.htm">재입고 알림</a></li>
    </ul>
  </div>

  <div>
    <p class="tit">회원정보</p>
    <ul>
      <li><a href="/mypage/modify.htm">내 정보 변경</a></li>
      <li><a href="/mypage/address.htm">배송지 관리</a></li>
      <li><a href="/mypage/login.htm">로그인 관리</a></li>
    </ul>
  </div>

  <div>
    <p class="tit">고객센터</p>
    <ul>
      <li>
  <a href="${pageContext.request.contextPath}/mypage/qna.htm"> 1:1 문의 </a>
</li>

      <li><a href="/mypage/as.htm">A/S 현황 조회</a></li>
    </ul>
  </div>
</aside>


      <!-- 우측 콘텐츠 -->
      <section class="my-con">
        <h2 class="tit__style4">최근 주문</h2>
        <p class="odr-txt_none">최근 주문 내역이 없습니다.</p>
      </section>

    </section>

  </main>

  <!-- FOOTER -->
  <jsp:include page="/view/common/footer.jsp" />

</div>

<!-- 하단 고정 버튼 -->
<div class="bot-fix-box">
  <div class="inner">
    <button class="today-goods__btn"></button>
    <button class="kakaotalk__btn"></button>
    <button class="top__btn">top</button>
  </div>
</div>

<script>
function openInquiryModal() {
  // 이미 열려있으면 중복 방지
  if (document.querySelector('.common__layer._qna_write')) return;

  fetch('/mypage/qna/write.ajax')
    .then(res => res.text())
    .then(html => {
      document.body.insertAdjacentHTML('beforeend', html);
    })
    .catch(err => {
      console.error('문의 모달 로드 실패', err);
    });
}
</script>



</body>
</html>
