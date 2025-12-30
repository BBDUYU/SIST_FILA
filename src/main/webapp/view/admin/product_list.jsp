<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
/* 기본 폰트 및 배경 설정 */
body {
	font-family: 'Noto Sans KR', sans-serif;
	background-color: #f4f4f4;
	margin: 0;
}

/* 섹션 레이아웃 보정 */
.admin-section {
	margin-left: 240px; /* 사이드바 너비 */
	padding: 50px 40px;
	min-height: 100vh;
}

/* 섹션 타이틀 (FILA RED 포인트) */
.section-title {
	font-size: 22px;
	font-weight: 800;
	color: var(--fila-navy);
	letter-spacing: -0.5px;
	position: relative;
	padding-left: 15px;
}

.section-title::before {
	content: '';
	position: absolute;
	left: 0;
	top: 50%;
	transform: translateY(-50%);
	width: 4px;
	height: 20px;
	background-color: var(--fila-red);
}

/* 테이블 디자인 */
.info-table {
	width: 100%;
	border-collapse: collapse;
	border-top: 2px solid var(--fila-navy);
	box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
}

.info-table th {
	background-color: #fff;
	color: #333;
	font-weight: 700;
	font-size: 13px;
	padding: 15px 10px;
	border-bottom: 1px solid #eee;
	text-transform: uppercase;
}

.info-table td {
	padding: 12px 10px;
	border-bottom: 1px solid #f1f1f1;
	text-align: center;
	font-size: 14px;
	color: #555;
	background-color: #fff;
	vertical-align: middle;
}

/* 상품명 좌측 정렬 및 강조 */
.info-table td:nth-child(4) {
	text-align: left;
	padding-left: 20px;
}

/* 이미지 썸네일 스타일 */
.info-table img {
	border: 1px solid #eee;
	border-radius: 4px;
	display: block;
	margin: 0 auto;
}

/* 버튼 스타일링 */
.submit-btn {
	background-color: var(--fila-navy);
	color: #fff;
	border: none;
	padding: 10px 20px;
	font-weight: 600;
	cursor: pointer;
	transition: 0.3s;
	font-size: 13px;
}

.submit-btn:hover {
	background-color: #001640;
}

.small-btn {
	background-color: #fff;
	color: var(--fila-navy);
	border: 1px solid var(--fila-navy);
	padding: 5px 12px;
	font-size: 12px;
	font-weight: 600;
	cursor: pointer;
	transition: 0.2s;
}

.small-btn:hover {
	background-color: var(--fila-navy);
	color: #fff;
}

/* 재고 상태 표시 */
.stock-low {
	color: var(--fila-red);
	font-weight: 800;
	background-color: #fff0f0;
	padding: 2px 6px;
	border-radius: 3px;
}

/* 판매 상태 뱃지 (옵션) */
.status-badge {
	display: inline-block;
	padding: 4px 8px;
	border-radius: 20px;
	font-size: 11px;
	font-weight: bold;
	background: #eee;
}
</style>
</head>
<body>
	<jsp:include page="../common/sidebar.jsp">
        <jsp:param name="currentPage" value="product" />
    </jsp:include>

	<div class="admin-section">
		<div class="section-header"
			style="display: flex; justify-content: space-between; align-items: center;">
			<h3 class="section-title">상품 관리 리스트</h3>
			<button onclick="location.href='createProduct.htm'"
				class="submit-btn" style="width: 150px; margin: 0;">+ 신규 상품
				등록</button>
		</div>

		<table class="info-table" style="margin-top: 20px; background: white;">
			<thead>
				<tr style="background: #f9f9f9;">
					<th>이미지</th>
					<th>상품코드</th>
					<th>카테고리</th>
					<th>상품명</th>
					<th>판매가</th>
					<th>재고</th>
					<th>상태</th>
					<th>관리</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="p" items="${productList}">
					<tr>
						<td><img src="${pageContext.request.contextPath}${p.mainImageUrl}" width="50" height="50"
							style="object-fit: cover;"></td>
						<td>${p.productid}</td>
						<td>${p.categoryName}</td>
						<td style="text-align: left; font-weight: bold;">${p.name}</td>
						<td><fmt:formatNumber value="${p.price}" pattern="#,###" />원</td>
						<td><span class="${p.totalStock < 10 ? 'stock-low' : ''}">${p.totalStock}</span>
						</td>
						<td><c:choose>
								<c:when test="${p.status eq '판매중'}">
									<span style="color: #2ecc71; font-weight: bold;">●
										${p.status}</span>
								</c:when>
								<c:when test="${p.status eq '품절'}">
									<span style="color: var(--fila-red); font-weight: bold;">●
										${p.status}</span>
								</c:when>
								<c:otherwise>
									<span>${p.status}</span>
								</c:otherwise>
							</c:choose></td>
						<td>
							<button class="small-btn"
								onclick="location.href='editProduct.htm?id=${p.productid}'">수정</button>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
</body>
</html>