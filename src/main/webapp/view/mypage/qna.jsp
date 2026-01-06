	<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
	
	<!--
	  이 파일은 "mypage 레이아웃(좌측 LNB + 우측 컨텐츠)" 안에서
	  우측 컨텐츠 부분에 include 되는 것을 전제로 작성.
	  (즉, <html><head> 전체문서 구조는 mypage 공통 JSP가 담당)
	-->
	
	<div class="qna-page">
	
	  <!-- 상단 타이틀/버튼 라인 -->
	  <div class="qna-page__head">
	    <h2 class="qna-page__title">1:1 문의</h2>
	
	  <button type="button"
  class="qna-page__writeBtn"
  onclick="openInquiryModal();">
  1:1 문의하기
</button>


	  </div>
	
	  <!-- 탭 -->
	  <div class="qna-tab">
	    <a href="javascript:void(0);" class="qna-tab__item is-active" data-status="DONE">완료</a>
	    <a href="javascript:void(0);" class="qna-tab__item" data-status="ALL">고객의 소리</a>
	  </div>
	
	  <!-- 리스트 영역 -->
	  <div class="qna-list" id="qnaListArea">
	
	    <!-- (AJAX 붙이기 전) 더미/빈상태 UI -->
	    <c:choose>
	      <c:when test="${empty list}">
	        <div class="qna-empty">
	          <p class="qna-empty__title">문의합니다</p>
	          <p class="qna-empty__desc">문의 내역이 없습니다.</p>
	        </div>
	      </c:when>
	
	      <c:otherwise>
	        <ul class="qna-accordion">
	
	          <c:forEach var="row" items="${list}">
	            <li class="qna-item">
	
	              <!-- 아코디언 헤더 -->
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
	
	              <!-- 아코디언 바디 -->
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
	  // (AJAX 붙이기 전) 아코디언만 먼저 동작
	  (function() {
	    const list = document.querySelector('#qnaListArea');
	    if (!list) return;
	
	    list.addEventListener('click', function(e) {
	      const head = e.target.closest('.qna-item__head');
	      if (!head) return;
	
	      const item = head.closest('.qna-item');
	      const body = item.querySelector('.qna-item__body');
	
	      const expanded = head.getAttribute('aria-expanded') === 'true';
	      head.setAttribute('aria-expanded', String(!expanded));
	
	      if (expanded) {
	        body.hidden = true;
	        item.classList.remove('is-open');
	      } else {
	        body.hidden = false;
	        item.classList.add('is-open');
	      }
	    });
	
	    // 탭은 지금은 UI만. (AJAX 붙이면 data-status로 필터 요청)
	    document.querySelectorAll('.qna-tab__item').forEach(function(tab){
	      tab.addEventListener('click', function(){
	        document.querySelectorAll('.qna-tab__item').forEach(t => t.classList.remove('is-active'));
	        tab.classList.add('is-active');
	      });
	    });
	  })();
	</script>
