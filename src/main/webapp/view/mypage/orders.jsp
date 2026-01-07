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
           			<h2 class="tit__style4" style="user-select: auto !important;">주문 · 배송 조회</h2>
					<!--p class="" style="color: rgb(204, 0, 0); font-size: 16px; font-weight: 400; line-height: 26px;">
						※ 당사 물류 사정에 의해 12/23(토) 이후 반품 신청건에 대해서는 1/2(화)부터 순차 처리될 예정이오니 교환/반품 시 참고 부탁드립니다.
					</p--><!--2023-12-22 문구 추가-->
					<div class="my-sort-wrap" style="user-select: auto !important;">
					<form method="post" action="myOrder.asp" name="serchOrderForm" style="user-select: auto !important;">
					<input type="hidden" name="Smode" value="ok" style="user-select: auto !important;">
						<div class="my-sort-box" style="user-select: auto !important;">
							<p class="total" style="user-select: auto !important;">총 0건</p>
							<div class="period" style="user-select: auto !important;">
								<!--a href="javascript:searchDate('2026-01-07', '0');serchOrderForm.submit();"  >오늘</a-->
								<a href="javascript:searchDate('2025-12-31', '7');serchOrderForm.submit();" style="user-select: auto !important;">1주일</a>
								<a href="javascript:searchDate('2025-12-08', '30');serchOrderForm.submit();" class="on" style="user-select: auto !important;">1개월</a>
								<a href="javascript:searchDate('2025-10-09', '90');serchOrderForm.submit();" style="user-select: auto !important;">3개월</a>
								<a href="javascript:searchDate('2025-07-11', '180');serchOrderForm.submit();" style="user-select: auto !important;">6개월</a>
								<a href="javascript:searchDate('2025-01-07', '365');serchOrderForm.submit();" style="user-select: auto !important;">1년</a>
								<!--a href="" class="self-write">직접입력</a-->
								<input type="hidden" id="dateFrom" name="dateFrom" class="input" value="2025-12-08" readonly="" style="user-select: auto !important;">
								<input type="hidden" id="dateTo" name="dateTo" class="input" value="2026-01-07" readonly="" style="user-select: auto !important;"> 
								<input type="hidden" name="nowDate" id="nowDate" value="2026-01-07" style="user-select: auto !important;">
								<input type="hidden" name="oStatus" id="oStatus" value="" style="user-select: auto !important;">
							</div>
						</div>
						<!-- 직접입력 선택 시 오픈 -->
						<div class="date-write-box" style="user-select: auto !important;">
							<input type="text" name="keyword" placeholder="날짜 입력 후 조회 혹은 주문번호 입력 후 조회" style="user-select: auto !important;">
							<input type="hidden" name="category" value="4" style="user-select: auto !important;">
							<button type="submit" style="user-select: auto !important;">조회</button>
						</div>
						<!-- //직접입력 선택 시 오픈 -->
					</form>
					</div>

					<div class="my-odr-wrap" style="user-select: auto !important;">

<p class="odr-txt_none" style="user-select: auto !important;">최근 주문 내역이 없습니다.</p>


					</div>
					
					<!-- 교환 취소 반품 안내 -->
					<div class="myorder-return-box" style="user-select: auto !important;">
						<h3 class="tit__style2" style="user-select: auto !important;">교환 · 취소 · 반품 안내</h3>
						<div style="user-select: auto !important;">
							<p class="tit" style="user-select: auto !important;">취소접수</p>
							<p class="txt" style="user-select: auto !important;">
								<span style="user-select: auto !important;">입금대기 중 단계에 있는 경우</span>
								해당 상품의 [주문취소] 버튼을 누르시면 바로 취소하실 수 있습니다.
								<br style="user-select: auto !important;"><br style="user-select: auto !important;">
								<span style="user-select: auto !important;">입금확인, 배송 준비 중 단계에 있는 경우</span>
								[주문취소 접수]버튼을 누르시면, 주문취소접수가 되며, 고객센터에서 확인 후 주문취소 됩니다. <br style="user-select: auto !important;">
								(24시간 내에 처리, 공휴일제외)
								<br style="user-select: auto !important;"><br style="user-select: auto !important;">
								<span style="user-select: auto !important;">발송 중 단계에 있는 경우</span>
								주문취소가 되지 않으며, 발송이 완료 된 시점에서 7일 이내에 주문취소를 하셔야 됩니다.
							</p>
						</div>
						<div style="user-select: auto !important;">
							<p class="tit" style="user-select: auto !important;">반품처리</p>
							<ul class="txt" style="user-select: auto !important;">
								<li style="user-select: auto !important;">반품 접수 후 상품을 보내주셔야 합니다.</li>
								<li style="user-select: auto !important;">단순변심으로 인한 반품 택배비는 고객님께서 부담하셔야 합니다.</li>
								<li style="user-select: auto !important;">상품의 하자 및 오배송인 경우 택배비는 휠라코리아에서 부담하며, 고객센터로 접수 후 절차 안내를 받으시면 됩니다.</li>
								<li style="user-select: auto !important;">반품주소지 : 경기도 부천시 송내대로 30번길 13 CJ 대한통운 부천지점</li>
							</ul>
						</div>
						<div style="user-select: auto !important;">
							<p class="tit" style="user-select: auto !important;">취소완료</p>
							<ul class="txt" style="user-select: auto !important;">
								<li style="user-select: auto !important;">반품 완료가 되면 결제하셨던 수단에 따라 각기 다른 방식으로 처리됩니다.</li>
								<li style="user-select: auto !important;">카드결제는 승인취소가 되며, 일반적으로 카드사에서는 승인취소일로부터 4~5일(영업일 기준) 이후에 취소 확인이 가능합니다.</li>
								<li style="user-select: auto !important;">현금(무통장/실시간 계좌이체(에스크로 포함) 등) 결제건은 반품이 완료되면, 반품완료일로부터 영업일 기준 3일 내에 결제금액을 환불해 드립니다.</li>
							</ul>
						</div>
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
