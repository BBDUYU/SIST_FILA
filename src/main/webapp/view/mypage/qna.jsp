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
           			<h2 class="tit__style4" style="user-select: auto !important;">1:1 문의</h2>
					<a href="#" class="btn_sld__bk btn_rt qna-write__btn" style="user-select: auto !important;">1:1 문의하기</a>

					<!-- 1:1문의 -->
					<ul class="qna__list" style="user-select: auto !important;">

						<li style="user-select: auto !important;">
							<!-- Q -->
							<div class="qna-q" style="user-select: auto !important;">
								<div class="info" style="user-select: auto !important;">
									<div style="user-select: auto !important;">
										<p class="status" style="user-select: auto !important;">완료</p>
										<p class="category" style="user-select: auto !important;">고객의 소리</p>
									</div>

									<p class="date" style="user-select: auto !important;">2026-01-03</p>
								</div>

								<div class="qna-tit" style="user-select: auto !important;">
									<p style="user-select: auto !important;">문의합니다</p>
								</div>
							</div>
							<!-- //Q -->

							<!-- A -->
							<div class="qna-a" style="user-select: auto !important;">
								<div class="q-txt-box" style="user-select: auto !important;">
									<div style="user-select: auto !important;">

										<p style="user-select: auto !important;">바로삭제할꼐요..</p>

									</div>
								</div>

								<div class="a-txt-box" style="user-select: auto !important;">
									<div style="user-select: auto !important;">
										<p style="user-select: auto !important;">
											</p><div style="user-select: auto !important;">안녕하세요, FILA 온라인스토어 입니다.&nbsp;</div><div style="user-select: auto !important;">문의사항에 대한 답변 안내드립니다~!&nbsp;</div><div style="user-select: auto !important;"><br style="user-select: auto !important;"></div><div style="user-select: auto !important;"><div style="user-select: auto !important;">문의하신 내용 관련하여 어떤 내용으로 문의하는지</div><div style="user-select: auto !important;">확인이 어려워 답변 드리지 못하는 점 너른 양해 부탁드립니다.</div><div style="user-select: auto !important;"><br style="user-select: auto !important;"></div><div style="user-select: auto !important;">궁금하신 점 기재하여 재차 문의주시면</div><div style="user-select: auto !important;">정성껏 답변 안내 드리도록 하겠습니다.&nbsp;</div></div><div style="user-select: auto !important;"><br style="user-select: auto !important;"></div><div style="user-select: auto !important;">궁금하신 사항이 있다면 언제든지 문의 부탁드립니다.</div><div style="user-select: auto !important;">오늘 하루도 좋은하루 되시길 바랍니다.</div><div style="user-select: auto !important;">감사합니다.</div>
										<p style="user-select: auto !important;"></p>
									</div>

									<p class="date" style="user-select: auto !important;">2026-01-05 10:51</p>
								</div>
								
								<!-- 만족도 -->
								<div class="a-point-box" style="user-select: auto !important;">

									<p style="user-select: auto !important;">
										답변내용 별점 평가
									</p>
									<div class="star-inp-box" style="user-select: auto !important;">
										<input type="radio" id="reviewStar01" name="qnaStarPoint" disabled="" style="user-select: auto !important;">
										<label for="reviewStar01" style="user-select: auto !important;"></label>

										<input type="radio" id="reviewStar02" name="qnaStarPoint" disabled="" style="user-select: auto !important;">
										<label for="reviewStar02" style="user-select: auto !important;"></label>

										<input type="radio" id="reviewStar03" name="qnaStarPoint" disabled="" style="user-select: auto !important;">
										<label for="reviewStar03" style="user-select: auto !important;"></label>

										<input type="radio" id="reviewStar04" name="qnaStarPoint" disabled="" style="user-select: auto !important;">
										<label for="reviewStar04" style="user-select: auto !important;"></label>

										<input type="radio" id="reviewStar05" name="qnaStarPoint" checked="" style="user-select: auto !important;">
										<label for="reviewStar05" style="user-select: auto !important;"></label>

										<div class="bg" style="user-select: auto !important;">
											<div style="user-select: auto !important;"></div>
											<div style="user-select: auto !important;"></div>
											<div style="user-select: auto !important;"></div>
											<div style="user-select: auto !important;"></div>
											<div style="user-select: auto !important;"></div>
										</div>
									</div>

								</div>
								<!-- //만족도 -->

							</div>
							<!-- //A -->
						</li>

<form name="QnaStar" method="post" style="user-select: auto !important;">
<input type="hidden" name="qnaNo" id="qnaNo" value="" style="user-select: auto !important;">
<input type="hidden" name="qnaStarPoint" id="qnaStarPoint" value="5" style="user-select: auto !important;">
</form>
<iframe name="qnaImgFrame" id="qnaImgFrame" style="display: none; user-select: auto !important;"></iframe>

					</ul>
					<!-- //1:1문의 -->
					
				</section>

</div>
</div>
<script>
$(function () {

    // 모달 열기
    $('.qna-write__btn').on('click', function (e) {
        e.preventDefault();
        $('.common__layer._qna_write').show();
    });

    // 모달 닫기
    $('.common__layer').on('click', '.close__btn, .layer_dim', function () {
        $('.common__layer._qna_write').hide();
    });

});
</script>

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
<jsp:include page="/view/mypage/qna_modal_form.jsp"/>




</body>
</html>
