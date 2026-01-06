<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<div class="qna-page">

  <div class="qna-page__head">
    <h2 class="qna-page__title">1:1 문의</h2>

    <!-- 모달 열기 버튼 -->
    <button type="button" class="qna-page__writeBtn">
      1:1 문의하기
    </button>
  </div>

  <div class="qna-tab">
    <a href="javascript:void(0);" class="qna-tab__item is-active" data-status="ALL">전체</a>
    <a href="javascript:void(0);" class="qna-tab__item" data-status="DONE">완료</a>
    <a href="javascript:void(0);" class="qna-tab__item" data-status="WAIT">접수</a>
  </div>

  <div class="qna-list" id="qnaListArea">
    <c:choose>
      <c:when test="${empty qnaList}">
        <div class="qna-empty">
          <p class="qna-empty__title">문의합니다</p>
          <p class="qna-empty__desc">문의 내역이 없습니다.</p>
        </div>
      </c:when>

      <c:otherwise>
        <ul class="qna-accordion">
          <c:forEach var="row" items="${qnaList}">
            <li class="qna-item">
              <button type="button" class="qna-item__head" aria-expanded="false">
                <span class="qna-item__badge">
                  <c:choose>
                    <c:when test="${row.status eq 'DONE'}">완료</c:when>
                    <c:otherwise>접수</c:otherwise>
                  </c:choose>
                </span>

                <span class="qna-item__category">${row.categoryName}</span>
                <span class="qna-item__title">${row.title}</span>
                <span class="qna-item__date">
                  <c:out value="${fn:substring(row.createdAt, 0, 10)}"/>
                </span>
                <span class="qna-item__arrow" aria-hidden="true"></span>
              </button>

              <div class="qna-item__body" hidden>
                <div class="qna-item__content">
                  <p class="qna-item__label">문의내용</p>
                  <div class="qna-item__text">
                    <c:out value="${row.content}"/>
                  </div>
                </div>

                <c:if test="${not empty row.replyContent}">
                  <div class="qna-item__reply">
                    <p class="qna-item__label">답변</p>
                    <div class="qna-item__text">
                      <c:out value="${row.replyContent}"/>
                    </div>
                  </div>
                </c:if>
              </div>
            </li>
          </c:forEach>
        </ul>
      </c:otherwise>
    </c:choose>
  </div>
</div>

<script>
/* ===============================
   1. 리스트 아코디언 (기존 그대로)
================================ */
(function () {
  const list = document.querySelector('#qnaListArea');
  if (!list) return;

  list.addEventListener('click', function(e) {
    const head = e.target.closest('.qna-item__head');
    if (!head) return;

    const item = head.closest('.qna-item');
    const body = item.querySelector('.qna-item__body');

    const expanded = head.getAttribute('aria-expanded') === 'true';
    head.setAttribute('aria-expanded', String(!expanded));

    body.hidden = expanded;
    item.classList.toggle('is-open', !expanded);
  });
})();

/* ===============================
   2. 1:1 문의 모달 (이게 핵심)
================================ */
(function () {
  const contextPath = '${pageContext.request.contextPath}';
  const WRITE_LAYER_URL = contextPath + '/mypage/writeLayer.htm';

  // 버튼 클릭 → 모달 열기
  document.addEventListener('click', function (e) {
    const btn = e.target.closest('.qna-page__writeBtn');
    if (!btn) return;

    // 이미 열려 있으면 중복 방지
    if (document.querySelector('#qnaWriteLayer')) return;

    fetch(WRITE_LAYER_URL)
      .then(res => {
        if (!res.ok) throw new Error(res.status);
        return res.text();
      })
      .then(html => {
        document.body.insertAdjacentHTML('beforeend', html);
        bindQnaModalEvents();
      })
      .catch(err => console.error('모달 로드 실패', err));
  });

  function bindQnaModalEvents() {
    const layer = document.querySelector('#qnaWriteLayer');
    if (!layer) return;

    layer.querySelector('.btn_close')?.addEventListener('click', closeQnaModal);
    layer.querySelector('.btn_cancel')?.addEventListener('click', closeQnaModal);
    layer.querySelector('.layer_dim')?.addEventListener('click', closeQnaModal);
  }

  function closeQnaModal() {
    document.querySelector('#qnaWriteLayer')?.remove();
  }
})();
</script>
