<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
    

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

          <button type="button" class="qna-item__head" aria-expanded="false">
            <span class="qna-item__badge">
              <c:choose>
                <c:when test="${row.status eq 'DONE'}">완료</c:when>
                <c:otherwise>접수</c:otherwise>
              </c:choose>
            </span>

            <span class="qna-item__category">${row.categoryName}</span>
            <span class="qna-item__title">${row.title}</span>
            <span class="qna-item__date">${fn:substring(row.createdAt,0,10)}</span>
            <span class="qna-item__arrow"></span>
          </button>

          <div class="qna-item__body" hidden>
            <div class="qna-item__content">
              <p class="qna-item__label">문의내용</p>
              <div class="qna-item__text">${row.content}</div>
            </div>

            <c:if test="${not empty row.replyContent}">
              <div class="qna-item__reply">
                <p class="qna-item__label">답변</p>
                <div class="qna-item__text">${row.replyContent}</div>
              </div>
            </c:if>
          </div>

        </li>
      </c:forEach>
    </ul>
  </c:otherwise>
</c:choose>


