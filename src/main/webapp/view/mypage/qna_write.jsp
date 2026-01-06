<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<form action="/mypage/qna/write_submit.ajax" method="post">

  <select name="categoryId" required>
    <option value="">문의 유형을 선택해주세요</option>
    <c:forEach var="cat" items="${categoryList}">
      <option value="${cat.categoryId}">
        ${cat.categoryName}
      </option>
    </c:forEach>
  </select>

  <input type="text" name="title" placeholder="제목" required />

  <textarea name="content" placeholder="문의 내용을 입력해주세요" required></textarea>

  <button type="submit">문의 등록</button>
</form>
