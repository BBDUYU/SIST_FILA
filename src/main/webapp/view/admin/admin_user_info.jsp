<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
:root {
	--fila-navy: #001E62;
	--fila-red: #E2001A;
	--fila-gray: #F4F4F4;
}

body {
	font-family: 'Noto Sans KR', sans-serif;
	background-color: var(--fila-gray);
	margin: 0;
}

.sidebar {
	width: 240px;
	height: 100vh;
	background: var(--fila-navy);
	color: white;
	position: fixed;
}

.sidebar .logo {
	padding: 30px;
	text-align: center;
	border-bottom: 1px solid #1a3578;
	font-weight: bold;
	font-size: 24px;
	letter-spacing: 2px;
}

.nav-item {
	padding: 15px 25px;
	cursor: pointer;
	border-bottom: 1px solid #1a3578;
	transition: 0.3s;
}

.nav-item:hover {
	background: var(--fila-red);
}

.main-content {
	margin-left: 240px;
	padding: 40px;
}

.card {
	background: white;
	border: 1px solid #ddd;
	border-radius: 0;
	padding: 20px;
}

.btn-fila {
	background: var(--fila-navy);
	color: white;
	border-radius: 0;
	border: none;
	padding: 10px 20px;
}

.btn-fila-red {
	background: var(--fila-red);
	color: white;
	border-radius: 0;
	border: none;
	padding: 10px 20px;
}
</style>
</head>
<body>

	<div class="sidebar">
		<div class="logo">
			<a href="${pageContext.request.contextPath}/view/user/main.mm"
				style="text-decoration: none; color: inherit;"> <span
				style="letter-spacing: 5px;">FILA</span>
			</a> <span
				style="font-weight: 300; font-size: 16px; margin-left: 5px; vertical-align: middle; color: rgba(255, 255, 255, 0.7);">ADMIN</span>
		</div>
		<div class="nav-item" onclick="location.href='${pageContext.request.contextPath}/admin.ad'" style="cursor:pointer;">
		    회원 관리
		</div>
		<div class="nav-item">상품 관리</div>
		<div class="nav-item">쿠폰 관리</div>
		<div class="nav-item">
			1:1 문의 <span class="badge" style="background: var(--fila-red)">3</span>
		</div>
	</div>

	<div class="main-content">
		<div class="card">
			<h2
				style="border-left: 5px solid var(--fila-navy); padding-left: 15px;">회원
				상세 정보</h2>
			<hr>
			<ul class="nav nav-tabs"
				style="border-bottom: 2px solid var(--fila-navy);">
				<li class="nav-item-tab active"
					style="background: var(--fila-navy); color: white; padding: 10px 20px;">기본정보</li>
				<li class="nav-item-tab"
					style="padding: 10px 20px; cursor: pointer;">포인트/쿠폰</li>
				<li class="nav-item-tab"
					style="padding: 10px 20px; cursor: pointer;">주문내역</li>
				<li class="nav-item-tab"
					style="padding: 10px 20px; cursor: pointer;">자녀정보</li>
			</ul>

			<div class="info-body" style="padding-top: 20px;">
				<table class="table" style="width: 100%; border-collapse: collapse;">
					<tr>
						<th
							style="background: #f9f9f9; padding: 15px; border: 1px solid #ddd; width: 200px;">회원
							ID</th>
						<td style="padding: 15px; border: 1px solid #ddd;">PROD_USER_01</td>
					</tr>
				</table>
			</div>
		</div>
	</div>

</body>
</html>