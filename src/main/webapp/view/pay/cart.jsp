<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="ko-KR">
<head>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/sub.css">

<meta charset="UTF-8">
<title>장바구니 | FILA</title>

<script src="${pageContext.request.contextPath}/js/TweenMax.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery-1.12.4.js"></script>
<script src="${pageContext.request.contextPath}/js/mighty.base.1.5.7.js"></script>
<script src="${pageContext.request.contextPath}/js/matiz.js"></script>
<script src="${pageContext.request.contextPath}/js/swiper-bundle.js"></script>
<script src="${pageContext.request.contextPath}/js/default.js?v=202504161631"></script>
<script src="${pageContext.request.contextPath}/js/main.js"></script>
<script src="${pageContext.request.contextPath}/js/list.js"></script>

<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.1, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.1, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi">

</head>

<body class="tit__style1" style="overflow-x: hidden;">

	<jsp:include page="../common/header.jsp" />

	<div id="contents" class="odr__contents">
		<h2 class="tit__style1">장바구니</h2>

		<div class="cart-top-ban">
			<div class="swiper-wrapper">
				<div class="swiper-slide">
					<p class="txt">
						<a href="#">신규 가입 시 1만원 할인</a>
					</p>
				</div>
			</div>
		</div>

		<ul class="odr-tab">
			<li><a href="javascript:void(0);" id="normalli" class="on">일반배송
					<sup>${fn:length(cartList)}</sup>
			</a></li>
			<li><a href="/" id="todayli">오늘도착 <sup id="todayCnt">0</sup></a></li>
		</ul>

		<div class="order-info-box todayinfo" style="display: none;">
			<div class="hd">
				<p class="tit">오늘도착 가능</p>
			</div>
			<div class="cn">
				<div class="txt-box">
					<p>배송가능 지역은 서울 전지역만 가능하며, 오전 11시 50분 결제건까지 당일 배송됩니다.</p>
				</div>
			</div>
		</div>

		<c:choose>
			<c:when test="${empty cartList}">
				<div class="cart__empty">
					<p class="txt">장바구니에 담긴 상품이 없습니다.</p>
					<a href="${pageContext.request.contextPath}/" class="btn_sld__bk">쇼핑
						계속하기</a>
				</div>
			</c:when>

			<c:otherwise>
				<section class="odr-wrap">
					<div class="odr-box">
						<div class="odr-hd">
							<div>
								<input type="checkbox" id="checkAll" class="cb__style3" onclick="CheckedAll2(form1);void(0);" checked="">
								<label for="checkAll">전체선택<span id="cartlistCnt"></span></label>
							</div> 
							<div class="txt-btn">
								<a href="javascript:CheckedSoldOut();void(0);" onclick="deleteAll()">전체삭제</a>
								
								<script>
									function deleteAll() {
									  if (!confirm("장바구니 상품을 전체 삭제하시겠습니까?")) return;
									  location.href = "${pageContext.request.contextPath}/pay/cart.htm?action=clear";
									}
								</script>
							</div>
						</div>

						<div id="optionModal" class="modal"
							style="display: none; position: fixed; z-index: 9999; left: 0; top: 0; width: 100%; height: 100%; background: rgba(0, 0, 0, 0.5);">
							<div class="modal-content"
								style="background: #fff; width: 400px; margin: 15% auto; padding: 20px; border-radius: 5px;">
								<h3>옵션/수량 변경</h3>
								<hr>
								<input type="hidden" id="modalCartItemId">
								<div style="margin: 20px 0;">
									<p>수량</p>
									<input type="number" id="modalQty" min="1"
										style="width: 100%; padding: 10px; border: 1px solid #ddd;">
								</div>
								<div
									style="display: flex; justify-content: space-between; margin-top: 20px;">
									<button type="button" onclick="closeModal()"
										style="padding: 10px 30px; background: #eee; border: none; cursor: pointer;">취소</button>
									<button type="button" onclick="submitOption()"
										style="padding: 10px 30px; background: #000; color: #fff; border: none; cursor: pointer;">변경적용</button>
								</div>
							</div>
						</div>

						<ul class="odr__list">
							<c:forEach var="item" items="${cartList}" varStatus="st">

								<c:set var="rawImg" value="${item.mainImageUrl}" />
								<c:set var="finalImg"
									value="${fn:replace(rawImg, 'file:///C:/fila_upload', '/upload')}" />

								<li>
									<!-- 선택 -->
									<div class="goods_sel">
										<input type="checkbox" id="checkProduct${st.index}"
											class="cb__style3 todaydelichk item-chk" checked="checked"
											data-price="${item.saleUnitPrice * item.quantity}"
											data-priceori="${item.originUnitPrice}"
											data-pricesale="${item.saleUnitPrice}"
											data-pq="${item.quantity}"> <label
											for="checkProduct${st.index}">선택</label>
									</div>
									
									<!-- 상품 이미지 -->
									<div class="goods-thumb">
										<a href="${pageContext.request.contextPath}/product/product_detail.htm?product_id=${item.productId}">
										  <img
										    src="${pageContext.request.contextPath}/displayImage.do?path=C:/fila_upload/product/${item.productId}/${item.productId}_main_1.jpg"
										    alt="${item.productName}"
										    onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/images/no_image.jpg';">
										</a>
									</div> 
									
									<!-- 상품 정보 -->
									<div class="goods-info">
										<p class="sex">FILA</p>
										<p class="tit">${item.productName}</p>

										<div class="info">
								 	`		<div>
								 				<p>사이즈&nbsp;:&nbsp;
													<c:choose>
										                <c:when test="${not empty item.size}">
										                    ${item.size}
										                </c:when>
										                <c:otherwise>
										                    <span style="color:red;">사이즈 정보 없음</span>
										                </c:otherwise>
										            </c:choose>
												</p>
								 			</div>
											<div>
												<p>수량&nbsp;:&nbsp;${item.quantity}개</p>
											</div>
										</div>

										<div class="pp-box">
											<div class="price">
												<p class="sale">
													<fmt:formatNumber
														value="${item.saleUnitPrice * item.quantity}"
														pattern="#,###" />
													원
												</p>

												<c:if test="${item.originUnitPrice > item.saleUnitPrice}">
													<p class="normal _sale">
														<fmt:formatNumber
															value="${item.originUnitPrice * item.quantity}"
															pattern="#,###" />
														원
													</p>
													<p class="percent">
														<fmt:formatNumber
															value="${100 - (item.saleUnitPrice * 100 / item.originUnitPrice)}"
															maxFractionDigits="0" />
														%
													</p>
												</c:if>
											</div>
										</div>

										<!-- 오늘도착 -->
										<p class="today_tag">오늘도착 가능</p>
									</div> <!-- 기타 버튼 -->
									<div class="goods-etc">
										<p class="ico">
											<button type="button" class="del"
												onclick="deleteItem(${item.cartItemId})">삭제</button>
										</p>
										<p class="btn-box">
											<button type="button" class="btn_sld__gr option-change__btn"
												onclick="changeOption(${item.cartItemId})">옵션 변경</button>
										</p>
									</div>
								</li>

							</c:forEach>
						</ul>

					</div>

					<div class="total-box">
					<div class="price-box">
						<div class="price-inner">
							<dl>
								<dt>총 상품금액</dt>
								<dd><span id="ctPice">0</span>원</dd>
							</dl>
							<dl>
								<dt>상품 할인금액</dt>
								<dd>- <span id="miPrice">0</span>원</dd>
							</dl>
							<dl>
								<dt>배송비</dt>
								<dd><span id="dvPrice">0</span>원</dd>
							</dl>
							<dl class="total">
								<dt>총 결제 예상 금액</dt>
								<dd><span id="pPrice">0</span>원</dd>
							</dl>
							
							<div class="btn-box">
								<!--a href="javascript:CheckedAllBuy(form1);" class="btn_bg__bk">구매하기</a-->
								<a href="javascript:CheckedBuy();" class="btn_bg__bk">구매하기</a>
							</div>
						</div>

						<div class="cart-notice-box">
							<p>장바구니는 멤버십 회원 로그인 시 15일간 보관됩니다.</p>
							<p>더 오래 보관 하고 싶은 상품은 위시리스트에 담아주세요.</p>
							<p>장바구니 보관 중 상품가격이나 혜택이 변동될 수 있습니다.</p>
						</div>
					</div>

					
				</div>
				</section>
			</c:otherwise>
		</c:choose>
	</div>

	<script>
$(document).ready(function() {
    updateTotal();

    // 탭 전환 이벤트
    $(".odr-tab li a").click(function() {
        $(".odr-tab li a").removeClass("on");
        $(this).addClass("on");
        if($(this).attr("id") == "todayli") $(".todayinfo").show();
        else $(".todayinfo").hide();
    });

    // 전체 선택
    $("#checkAll").click(function() {
        $(".item-chk").prop("checked", this.checked);
        updateTotal();
    });

    $(document).on("click", ".item-chk", function() {
        $("#checkAll").prop("checked", $(".item-chk:checked").length == $(".item-chk").length);
        updateTotal();
    });
});

//모달 열기
function changeOption(id) {
    const item = $(".cart-item[data-id='" + id + "']");
    const currentQty = item.data("qty");
    
    $("#modalCartItemId").val(id);
    $("#modalQty").val(currentQty);
    $("#optionModal").show();
}

function closeModal() {
    $("#optionModal").hide();
}

// 백엔드로 변경 요청 보내기 (Ajax 사용 권장)
function submitOption() {
    const cartItemId = $("#modalCartItemId").val();
    const newQty = $("#modalQty").val();

    // 폼 전송 또는 Ajax 호출
    // 여기서는 간단하게 location.href로 예시를 들지만, 실무는 Ajax가 좋습니다.
    if(confirm("옵션을 변경하시겠습니까?")) {
        location.href = "${pageContext.request.contextPath}/pay/updateCart.htm?cartItemId=" + cartItemId + "&qty=" + newQty;
    }
}

function updateTotal() {
    let totalOrigin = 0;
    let totalSale = 0;
    let deliPrice = 0;

    $(".cart-item").each(function() {
        if ($(this).find(".item-chk").is(":checked")) {
            let origin = parseInt($(this).data("origin")) || 0;
            let sale = parseInt($(this).data("sale")) || 0;
            let qty = parseInt($(this).data("qty")) || 0;
            totalOrigin += (origin * qty);
            totalSale += (sale * qty);
        }
    });

    // 배송비 계산 (예: 3만원 미만 시 3,000원)
    deliPrice = (totalSale > 0 && totalSale < 30000) ? 3000 : 0;

    $("#ctPice").text(totalOrigin.toLocaleString());
    $("#miPrice").text((totalOrigin - totalSale).toLocaleString());
    $("#deliPrice").text(deliPrice.toLocaleString());
    $("#pPrice").text((totalSale + deliPrice).toLocaleString());
}

function deleteItem(id) {
    if(confirm("해당 상품을 삭제하시겠습니까?")) {
        location.href = "${pageContext.request.contextPath}/pay/cart.htm?ids=" + id;
    }
}

function deleteSelected() {
    let ids = [];
    $(".item-chk:checked").each(function() {
        ids.push($(this).closest("li").data("id"));
    });
    if(ids.length === 0) { alert("삭제할 상품을 선택해주세요."); return; }
    if(confirm("선택한 상품을 삭제하시겠습니까?")) {
        location.href = "${pageContext.request.contextPath}/pay/cart.htm?ids=" + ids.join(",");
    }
}

//모달 열기 함수
function changeOption(id) {
    const item = $(".cart-item[data-id='" + id + "']");
    const currentQty = item.data("qty");
    
    $("#modalCartItemId").val(id);
    $("#modalQty").val(currentQty);
    $("#optionModal").show();
}

function closeModal() {
    $("#optionModal").hide();
}

// 수량 조절 버튼
function changeModalQty(step) {
    let qty = parseInt($("#modalQty").val());
    qty += step;
    if (qty < 1) qty = 1;
    $("#modalQty").val(qty);
}

// 변경 적용 (백엔드 전송)
function submitUpdate() {
    const cartItemId = $("#modalCartItemId").val();
    const quantity = $("#modalQty").val();
    
    // Handler의 update 액션으로 이동
    location.href = "${pageContext.request.contextPath}/pay/cart.htm?action=update&cartItemId=" + cartItemId + "&quantity=" + quantity;
}

function goOrder() {
    let ids = [];
    $(".item-chk:checked").each(function() {
        ids.push($(this).closest("li").data("id"));
    });
    if(ids.length === 0) { alert("구매할 상품을 선택해주세요."); return; }
    location.href = "${pageContext.request.contextPath}/order/setup.htm?ids=" + ids.join(",");
}
</script>

	<jsp:include page="../common/footer.jsp" />
</body>
</html>