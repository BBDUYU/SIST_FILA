<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <title>1:1 문의 | FILA</title>

<link rel="icon" type="image/x-icon" href="//filacdn.styleship.com/filacontent2/favicon.ico" />
<link href="http://localhost/SIST_FILA/css/SpoqaHanSansNeo.css" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/normalize.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/opt-default.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/swiper-bundle.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/layout.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/product.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/sub.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@8/swiper-bundle.min.css" />

<script src="https://cdn.jsdelivr.net/npm/swiper@8/swiper-bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/js/TweenMax.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery-1.12.4.js"></script>
<script src="${pageContext.request.contextPath}/js/mighty.base.1.5.7.js"></script>
<script src="${pageContext.request.contextPath}/js/matiz.js"></script>
<script src="${pageContext.request.contextPath}/js/swiper-bundle.js"></script>
<script src="${pageContext.request.contextPath}/js/default.js?v=202504161631"></script>
<script src="${pageContext.request.contextPath}/js/main.js"></script>
    
    <!-- QnA JS -->
    <script src="${pageContext.request.contextPath}/js/inquiry.js"></script>
    <script src="${pageContext.request.contextPath}/js/mypage.js"></script>

    <!-- jQuery -->
    <script src="${pageContext.request.contextPath}/js/jquery-1.12.4.js"></script>


</head>

<body>

<jsp:include page="/view/common/header.jsp"/>
<jsp:include page="/view/mypage/mypage.jsp"/>

<section class="my-con" style="user-select: auto !important;">
           			<h2 class="tit__style4" style="user-select: auto !important;">1:1 문의</h2>
					<a href="#" class="btn_sld__bk btn_rt qna-write__btn" style="user-select: auto !important;">1:1 문의하기</a>

					<!-- 1:1문의 -->
					<ul class="qna__list" style="user-select: auto !important;">
					<!-- 복제예정 -->
						<li style="user-select: auto !important;" class>
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
	

							</div>
							
						</li>
						<!-- 복제예정 -->
					</ul>
					<!-- //1:1문의 -->
					<div id="qnaModalOverlay" style="display:none;">
						    <div id="qnaModalContent"></div>
						</div>
				</section>

</div>
</div>



<script>
var contextPath = '${pageContext.request.contextPath}';

(function ($) {

	  // 1:1 문의 모달 열기
	  $(document).on('click', '.qna-write__btn', function (e) {
	    e.preventDefault();
	    openQnaModal();
	  });

	  function openQnaModal() {
		    $.ajax({
		        url: contextPath + '/view/mypage/qna_modal.jsp',
		        type: 'GET',
		        success: function (res) {
		            // 1. 데이터를 먼저 넣는다
		            $('#qnaModalContent').html(res);
		            
		            // 2. 부모 div를 단순히 보이게 한다
		            $('#qnaModalOverlay').show(); 

		            // 3. (핵심) AJAX로 들어온 태그들이 CSS 스타일을 먹도록 강제 노출
		            // 만약 CSS 파일에 display: none이 걸려있을 수 있으므로 강제 block 처리
		            $('.common__layer').css({
		                'display': 'block',
		                'z-index': '9999' 
		            });
		            
		            $('.common__layer .inner').css({
		                'display': 'block',
		                'z-index': '10000'
		            });

		            $('body').css('overflow', 'hidden'); // 뒷배경 스크롤 방지
		        }
		    });
		}

	  // 닫기
	  window.closeQnaModal = function () {
	    $('#qnaModalOverlay').hide();
	    $('#qnaModalContent').empty();
	    $('body').css('overflow', 'auto');
	  };

	  // 내부 닫기 버튼
	  $(document).on('click', '#btnCloseQna, .close__btn', function () {
	    closeQnaModal();
	  });

	})(jQuery);

</script>

<jsp:include page="/view/common/footer.jsp"/>
<%-- <jsp:include page="/view/mypage//qna_write.jsp"/>
 --%>
</body>
</html>
