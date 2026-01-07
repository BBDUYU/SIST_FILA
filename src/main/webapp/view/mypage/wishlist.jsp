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

<section class="my-con wishlist" style="user-select: auto !important;">
           			<h2 class="tit__style4" style="user-select: auto !important;">위시리스트</h2>

					<div class="odr-box" style="user-select: auto !important;">
				<form name="form7" id="form7" target="dataFrame" style="user-select: auto !important;"><input type="hidden" name="checkwish" style="user-select: auto !important;"></form>				
				<form name="form5" style="user-select: auto !important;">						
						<div class="odr-hd" style="user-select: auto !important;">
							<div style="user-select: auto !important;">
								<input type="checkbox" id="checkAll" title="상품 선택" class="cb__style1" style="user-select: auto !important;">
								<label for="checkAll" style="user-select: auto !important;">선택</label>
							</div> 
							<div class="txt-btn" style="user-select: auto !important;">
								<!--a href="javascript:Checkedwish_cart();void(0);">장바구니</a-->
								<a href="javascript:CheckedDel3();void(0);" style="user-select: auto !important;">선택삭제</a>
								<!--a href="javascript:soldOut_del();void(0);">품절삭제</a-->
							</div>
							
						</div>
						<ul class="odr__list __my_chk" style="user-select: auto !important;">

									<p class="odr-txt_none" style="user-select: auto !important;">위시리스트가 비었습니다.</p>

						</ul>
				</form>
					</div>	
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
