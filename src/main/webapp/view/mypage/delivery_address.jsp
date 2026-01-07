<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <title>1:1 문의 | FILA</title>

    <!-- CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/normalize.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/opt-default.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/layout.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/product.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/sub.css">

    <!-- jQuery -->
    <script src="${pageContext.request.contextPath}/js/jquery-1.12.4.js"></script>

    <!-- 🔥 모달 강제 표시용 보정 CSS -->
    <style>
        .common__layer {
            position: fixed !important;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: 9999 !important;
            display: none;
        }
        .common__layer .layer_dim {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0,0,0,.6);
        }
        .common__layer .inner {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background: #fff;
            width: 90%;
            max-width: 420px;
            border-radius: 8px;
            padding: 20px;
        }
        .common__layer .head {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
    </style>
</head>

<body>

<jsp:include page="/view/common/header.jsp"/>
<jsp:include page="/view/mypage/mypage.jsp"/>

<section class="my-con" style="user-select: auto !important;">
           			<h2 class="tit__style4" style="user-select: auto !important;">배송지 관리</h2>
					<a href="#" class="btn_sld__bk btn_rt add-addr__btn" style="user-select: auto !important;">신규 배송지 추가</a>
					
					
					<!-- 배송지 관리 -->
					<div class="my-address-box" style="user-select: auto !important;">
						<ul class="addr__list" style="user-select: auto !important;">
							
							<!-- 2023-03-15 배송지 수정 -->
							<li class="_default_addr" style="user-select: auto !important;">
								<input type="radio" id="myAddr0" name="myAddrList" class="addr-chk" style="user-select: auto !important;">
								<label for="myAddr0" style="user-select: auto !important;"></label>

								<div class="addr-info" style="user-select: auto !important;">
									<div class="name-tel" style="user-select: auto !important;">
									
										<p class="tag" style="user-select: auto !important;">기본</p>
									
										<p class="name" style="user-select: auto !important;">류지호</p>
										<p class="tel" style="user-select: auto !important;">01044326852</p>
									</div>

									<div class="addr-detail" style="user-select: auto !important;">
										<p style="user-select: auto !important;">
											(06279) 서울 강남구 도곡로78길 22 (대치동, 대치삼성아파트)<br style="user-select: auto !important;">
											106동103호
										</p>
									</div>
								</div>

								<div class="btn-box" style="user-select: auto !important;">
									<button type="button" class="modify__btn" onclick="addrAddPopup('1205034');" style="user-select: auto !important;">modify</button>
									
									<button type="button" class="delete__btn" onclick="alert('기본 배송지는 삭제하실 수 없습니다.');" style="user-select: auto !important;">delete</button>
									
								</div>

								<button type="button" class="default-addr__btn" onclick="addrDefault('1205034');" style="user-select: auto !important;">기본으로 설정</button>
								<!-- 
									기본으로 설정 클릭시 레이어 호출
									
									/pc/popup/pop_btn.asp
								-->
							</li>
							<!-- //2023-03-15 배송지 수정 -->


						</ul>

					</div>
					<!-- //배송지 관리 -->

				</section>

</div>
</div>
<jsp:include page="/view/common/footer.jsp"/>

<!-- ===================== -->
<!-- 🔥 JS : 이것만 있으면 무조건 뜸 -->
<!-- ===================== -->
<script>
$(function () {

    $('#btnOpenQna').on('click', function () {
        alert('버튼 눌림');   // ← 이거 뜨면 100% 정상
        $('#qnaWriteLayer').show();
    });

    $('#btnCloseQna, .layer_dim').on('click', function () {
        $('#qnaWriteLayer').hide();
    });

});
</script>

</body>
</html>
