<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="common__layer _qna_write" id="qnaWriteLayer">
  <div class="layer_dim"></div>

  <div class="layer_wrap">
    <div class="layer_header">
      <h2>1:1 문의하기</h2>
      <button type="button" class="btn_close">✕</button>
    </div>

    <div class="layer_body">

      <form action="${pageContext.request.contextPath}/mypage/qna/write_submit.ajax"
            method="post">

        <select name="categoryId" required>
          <option value="">문의 유형을 선택해주세요</option>
          <c:forEach var="cat" items="${categoryList}">
            <option value="${cat.categoryId}">
              ${cat.categoryName}
            </option>
          </c:forEach>
        </select>

        <input type="text" name="title" placeholder="제목" required />

        <textarea name="content"
          placeholder="문의 내용을 입력해주세요"
          required></textarea>

        <div class="layer_footer">
          <button type="button" class="btn_cancel">취소</button>
          <button type="submit">문의 등록</button>
        </div>

      </form>

    </div>
  </div>
</div>
