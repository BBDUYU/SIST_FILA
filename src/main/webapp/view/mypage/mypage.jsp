<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <title>마이페이지</title>

  <script>
    // 컨텍스트 패스 (예: /SIST_FILA)
    const contextPath = '${pageContext.request.contextPath}';

    // ✅ 모달 HTML(레이어) 불러오는 URL (여기만 네 프로젝트 라우팅에 맞게 쓰면 됨)
    // 예시1) 핸들러: /mypage/qna/writeLayer.htm
    // 예시2) jsp 조각: /view/mypage/qna/qna_write_layer.jsp (직접 접근 가능하면)
    const QNA_LAYER_URL = contextPath + '/mypage/qna/writeLayer.htm';
  </script>

  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/normalize.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/layout.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/sub.css">

  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>

<body class="mypage">
<div id="wrap">

  <jsp:include page="/view/common/header.jsp" />

  <main id="contents" class="mypage__contents">

    <section class="mypage__tab">
      <div class="inner">

        <div class="my-info-box">
          <div class="top">
            <p class="level">WHITE</p>
            <a href="${pageContext.request.contextPath}/customer/membership.htm" class="benefit__btn">혜택보기</a>
          </div>

          <p class="name">
            <span>${loginUser.name}</span>님
          </p>

          <a href="${pageContext.request.contextPath}/mypage/modify.htm" class="info-modify__btn">내 정보 변경</a>
        </div>

        <div class="my-link-box">
          <div><dl><dt>쿠폰</dt><dd>0개</dd></dl></div>
          <div><dl><dt>포인트</dt><dd>0P</dd></dl></div>
          <div><dl><dt>위시리스트</dt><dd>0개</dd></dl></div>
          <div><dl><dt>주문내역</dt><dd>0건</dd></dl></div>
        </div>

      </div>
    </section>

    <section class="mypage__area">

      <aside class="my-lnb">
        <h2 class="tit__style4">마이페이지</h2>

        <div>
          <p class="tit">쇼핑정보</p>
          <ul>
            <li><a href="${pageContext.request.contextPath}/mypage/order.htm">주문 · 배송 조회</a></li>
            <li><a href="${pageContext.request.contextPath}/mypage/cancel.htm">교환 · 취소 · 반품 조회</a></li>
            <li><a href="${pageContext.request.contextPath}/mypage/review.htm">리뷰</a></li>
          </ul>
        </div>

        <div>
          <p class="tit">상품정보</p>
          <ul>
            <li><a href="${pageContext.request.contextPath}/mypage/wishlist.htm">위시리스트</a></li>
            <li><a href="${pageContext.request.contextPath}/mypage/today.htm">오늘 본 상품</a></li>
            <li><a href="${pageContext.request.contextPath}/mypage/custom.htm">커스텀 스튜디오</a></li>
            <li><a href="${pageContext.request.contextPath}/mypage/restock.htm">재입고 알림</a></li>
          </ul>
        </div>

        <div>
          <p class="tit">회원정보</p>
          <ul>
            <li><a href="${pageContext.request.contextPath}/mypage/modify.htm">내 정보 변경</a></li>
            <li><a href="${pageContext.request.contextPath}/mypage/address.htm">배송지 관리</a></li>
            <li><a href="${pageContext.request.contextPath}/mypage/login.htm">로그인 관리</a></li>
          </ul>
        </div>

        <div>
          <p class="tit">고객센터</p>
          <ul>
            <li><a href="${pageContext.request.contextPath}/mypage/qna.htm">1:1 문의</a></li>
            <li><a href="${pageContext.request.contextPath}/mypage/as.htm">A/S 현황 조회</a></li>
          </ul>
        </div>
      </aside>

      <section class="my-con">
        <c:if test="${not empty contentPage}">
          <jsp:include page="${contentPage}" />
        </c:if>
      </section>

    </section>
  </main>

  <jsp:include page="/view/common/footer.jsp" />
</div>

<div class="bot-fix-box">
  <div class="inner">
    <button class="today-goods__btn" type="button"></button>
    <button class="kakaotalk__btn" type="button"></button>
    <button class="top__btn" type="button">top</button>
  </div>
</div>

<script>
  // =========================
  // 1:1 문의 모달(레이어) 제어
  // =========================

  window.openInquiryModal = function () {
    // 이미 열려 있으면 중복 생성 방지
    if (document.querySelector('#qnaWriteLayer')) return;

    // ✅ fetch가 빠져있어서 니 코드가 터졌던 거임
    fetch(QNA_LAYER_URL, { method: 'GET' })
      .then(res => {
        if (!res.ok) throw new Error(res.status);
        return res.text();
      })
      .then(html => {
        document.body.insertAdjacentHTML('beforeend', html);
        bindQnaModalEvents();
      })
      .catch(err => console.error('모달 로드 실패', err));
  };

  window.bindQnaModalEvents = function () {
    const layer = document.querySelector('#qnaWriteLayer');
    if (!layer) return;

    // 닫기 버튼(네 모달 마크업에 맞춰 selector는 필요하면 바꿔)
    layer.querySelector('.btn_close')?.addEventListener('click', closeQnaModal);
    layer.querySelector('.btn_cancel')?.addEventListener('click', closeQnaModal);

    // dim 클릭 닫기
    layer.querySelector('.layer_dim')?.addEventListener('click', closeQnaModal);

    // ESC 닫기
    document.addEventListener('keydown', onEscClose);
  };

  function onEscClose(e) {
    if (e.key === 'Escape') closeQnaModal();
  }

  window.closeQnaModal = function () {
    document.removeEventListener('keydown', onEscClose);
    document.querySelector('#qnaWriteLayer')?.remove();
  };

  // =========================
  // 버튼 클릭 시 모달 열기
  // =========================
  document.addEventListener('click', function (e) {
    const btn = e.target.closest('.qna-page__writeBtn');
    if (!btn) return;
    openInquiryModal();
  });
</script>

<script>
(function () {
  const form = document.getElementById('qnaWriteForm');
  if (!form) return;

  form.addEventListener('submit', function (e) {
    e.preventDefault();

    const formData = new FormData(form);

    fetch('${pageContext.request.contextPath}/mypage/qna/write_submit.ajax', {
      method: 'POST',
      body: formData
    })
    .then(res => res.json())
    .then(data => {
      if (data.result === 'success') {
        alert('문의가 등록되었습니다.');
        document.querySelector('#qnaWriteLayer')?.remove();
        location.reload();
      } else {
        alert(data.message || '등록 실패');
      }
    })
    .catch(err => {
      console.error(err);
      alert('서버 오류');
    });
  });
})();
</script>


</body>
</html>
