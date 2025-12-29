<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<jsp:include page="../common/header.jsp" />
	<div class="container-fluid">
		<h3>회원 관리</h3>
		<div class="card shadow mb-4">
			<div class="card-header py-3">
				<h6 class="m-0 font-weight-bold text-primary">사용자 목록</h6>
			</div>
			<div class="card-body">
				<div class="table-responsive">
					<table class="table table-bordered" id="userTable" width="100%"
						cellspacing="0">
						<thead>
							<tr>
								<th>아이디</th>
								<th>이름</th>
								<th>가입일</th>
								<th>상태</th>
								<th>누적 주문</th>
								<th>관리</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="user" items="${userList}">
								<tr>
									<td>${user.usernumber}</td>
									<td><strong>${user.id}</strong></td>
									<td>${user.childname}</td>
									<td>${user.email}</td>
									<td><fmt:formatDate value="${user.createAt}"
											pattern="yyyy-MM-dd" /></td>
									<td><span class="badge border text-dark">${user.grade}</span></td>
									<td><c:if test="${user.status eq 'ACTIVE'}">
											<span class="badge badge-success"
												style="background-color: #28a745;">정상</span>
										</c:if> <c:if test="${user.status ne 'ACTIVE'}">
											<span class="badge badge-danger"
												style="background-color: var(--fila-red);">차단</span>
										</c:if></td>
									<td>
										<button class="btn btn-sm"
											style="border: 1px solid var(--fila-navy); color: var(--fila-navy);">상세보기</button>
									</td>
								</tr>
							</c:forEach>

							<c:if test="${empty userList}">
								<tr>
									<td colspan="8" style="padding: 50px;">등록된 회원이 없습니다.</td>
								</tr>
							</c:if>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="../common/footer.jsp" />
</body>
</html>