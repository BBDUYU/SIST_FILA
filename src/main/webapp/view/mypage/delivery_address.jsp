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

<script src="${pageContext.request.contextPath}/js/mypage.js"></script>
<script src="${pageContext.request.contextPath}/js/searchZip.js"></script>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<script src="https://cdn.jsdelivr.net/npm/swiper@8/swiper-bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/js/TweenMax.js"></script>

<script src="${pageContext.request.contextPath}/js/mighty.base.1.5.7.js"></script>
<script src="${pageContext.request.contextPath}/js/matiz.js"></script>
<script src="${pageContext.request.contextPath}/js/swiper-bundle.js"></script>
<script src="${pageContext.request.contextPath}/js/default.js?v=202504161631"></script>
<script src="${pageContext.request.contextPath}/js/main.js"></script>



    
    <!-- QnA JS -->
    <script src="${pageContext.request.contextPath}/js/qna.js"></script>
    <script src="${pageContext.request.contextPath}/js/inquiry.js"></script>
    <script src="${pageContext.request.contextPath}/js/mypage.js"></script>

    <!-- jQuery -->


</head>

<body>

<jsp:include page="/view/common/header.jsp"/>
<jsp:include page="/view/mypage/mypage.jsp"/>

<section class="my-con">
           			<h2 class="tit__style4">배송지 관리</h2>
					<a href="#" class="btn_sld__bk btn_rt add-addr__btn">신규 배송지 추가</a>
					
					
					<!-- 배송지 관리 -->
					<div class="my-address-box">
					
						<ul class="addr__list">
							<!-- 반복 -->
							<!-- 2023-03-15 배송지 수정 -->
							<li class="_default_addr">
								<input type="radio" id="myAddr0" name="myAddrList" class="addr-chk">
								<label for="myAddr0"></label>

								<div class="addr-info">
									<div class="name-tel">
									
										<p class="tag">기본</p>
									
										<p class="name">지영주</p>
										<p class="tel">01012345678</p>
									</div>

									<div class="addr-detail">
										<p>
											(06193) 서울 강남구 테헤란로70길 12 (대치동)<br>
											9층, 쌍용교육센터
										</p>
									</div>
								</div>

								<div class="btn-box">
									<button type="button" class="modify__btn" onclick="addrAddPopup('1203475');">modify</button>
									
									<button type="button" class="delete__btn" onclick="alert('기본 배송지는 삭제하실 수 없습니다.');">delete</button>
									
								</div>

								<button type="button" class="default-addr__btn" onclick="addrDefault('1203475');">기본으로 설정</button>
								<!-- 
									기본으로 설정 클릭시 레이어 호출
									
									/pc/popup/pop_btn.asp
								-->
							</li>
							<!-- //2023-03-15 배송지 수정 -->
							<!-- 반복 -->

						</ul>
						

					</div>
					<!-- //배송지 추가 -->
							<div id="AddaddressModalOverlay"
						     class="style-modal-overlay"
						     onclick="if(event.target === this) closeQnaModal();"
						     style="display:none;">
						
						    <div id="AddaddModalContent" class="style-modal-wrapper">
						        <!-- AJAX로 qna_modal.jsp 들어올 자리 -->
						    </div>
						</div>
						<!-- //배송지 수정 -->
						<div id="EditaddressModalOverlay"
						     class="style-modal-overlay"
						     onclick="if(event.target === this) closeQnaModal();"
						     style="display:none;">
						
						    <div id="EditaddModalContent" class="style-modal-wrapper">
						        <!-- AJAX로 qna_modal.jsp 들어올 자리 -->
						    </div>
						</div>
						<!-- 주소 -->
						
				</section>

</div>
</div>



<script>
var contextPath = '${pageContext.request.contextPath}';

(function ($) {

  /* =========================
     배송지 수정 (edit_address.jsp)
     ========================= */
  $(document).on('click', '.modify__btn', function (e) {
    e.preventDefault();

    // onclick="addrAddPopup('1203475')" 에서 addrNo 추출
    var addrNo = $(this).attr('onclick').match(/'([^']+)'/)[1];

    $('#EditaddModalContent').load(
      contextPath + '/view/mypage/edit_address.jsp?addrNo=' + addrNo,
      function () {
        $('#EditaddressModalOverlay').css('display', 'flex').show();
        $('body').css('overflow', 'hidden');
      }
    );
  });

  /* =========================
     배송지 추가 (add_address.jsp)
     ========================= */
  $(document).on('click', '.add-addr__btn', function (e) {
    e.preventDefault();

    $('#AddaddModalContent').load(
      contextPath + '/view/mypage/add_address.jsp',
      function () {
        $('#AddaddressModalOverlay').css('display', 'flex').show();
        $('body').css('overflow', 'hidden');
      }
    );
  });

  /* =========================
     공통 닫기
     ========================= */
  window.closeQnaModal = function () {
    $('#AddaddressModalOverlay').hide();
    $('#EditaddressModalOverlay').hide();

    $('#AddaddModalContent').empty();
    $('#EditaddModalContent').empty();

    $('body').css('overflow', 'auto');
  };

  // 닫기 버튼
  $(document).on('click', '.close__btn', function () {
    closeQnaModal();
  });

})(jQuery);
</script>



<jsp:include page="/view/common/footer.jsp"/>
</body>
</html>
