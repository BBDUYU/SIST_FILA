<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>

<html class="no-js" lang="ko-KR"> <!--<![endif]-->
<head>
	<meta charset="UTF-8">
	<meta name="format-detection" content="telephone=no">

<title>주문/결제 | FILA</title>

<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.1, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.1, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi">

</head>

<body class="tit__style1" style="overflow-x: hidden;">

<!-- start of :: header -->
<jsp:include page="../common/header.jsp" />		
<!-- // end of :: header -->

<form name="form6" id="form6"  target="dataFrame">

	<input type="hidden" name="checkwish"><input type="hidden" name="ProductQuantity"></form>
<iframe name="dataFrame" id="dataFrame" style="display:none;"></iframe>

		<!-- start of :: contents -->
		<div id="contents" class="odr__contents">
           	<h2 class="tit__style1">주문 및 결제</h2>
		<form name="user" method="post" > 
		
		<c:if test="${not empty cartItemIds}">
	        <input type="hidden" name="cartItemIds" value="${cartItemIds}" />
	    </c:if>
	
	    <c:if test="${isDirect}">
	        <input type="hidden" name="productId" value="${orderItems[0].productId}" />
	        <input type="hidden" name="quantity" value="${orderItems[0].quantity}" />
	        <input type="hidden" name="combinationId" value="${orderItems[0].combinationId}" />
	    </c:if>
    
			<section class="odr-wrap">
				<!-- order -->
				<div class="odr-box">

<!-- 주문자 정보 -->
<input type="hidden" name="sid" value="jyj030818" />  
<input type="hidden" name="totalpaytemp" value="" />  
<input type="hidden" name="usemile1" />
<input type="hidden" name="usemiletemp" value="5000" />
<input type="hidden" name="ismember" value="1" />
<input type="hidden" name="addrate" value="" />
<input type="hidden" name="totalprice" value="" />

<input type="hidden" name="totalpay" value="" />
<input type="hidden" name="usermile" value="5000" />
<input type="hidden" name="temptotal" value="" />

<input type="hidden" name="aOrderOName" value="지영주" />  
<input type="hidden" name="aOrderOZip" value="06193" />  

<input type="hidden" name="aOrderOAddress1" value="서울 강남구 대치동 890-60" />
<input type="hidden" name="aOrderOAddress2" value="9층, 쌍용교육센터" />
<input type="hidden" name="aOrderORoadAddress" value="서울 강남구 테헤란로70길 12 (대치동)" />
<input type="hidden" name="aOrderOEmail" value="" />
<input type="hidden" name="aOrderOTel11" value="" />
<input type="hidden" name="aOrderOTel12" value="" />
<input type="hidden" name="aOrderOTel13" value="" />
<input type="hidden" name="aOrderOTel21" value="010" />
<input type="hidden" name="aOrderOTel22" value="1234" />
<input type="hidden" name="aOrderOTel23" value="5678" />


<input type="hidden" id="orderNum"  class="input size4" title="전화번호 앞자리" name="OrderOTel11" value="" maxlength="3" />
<input type="hidden" class="input size4" title="전화번호 중간자리" name="OrderOTel12" value="" maxlength="4" />
<input type="hidden"  class="input size4" title="전화번호 뒷자리" name="OrderOTel13" value="" maxlength="4"  />

<input type="hidden" name="OrderOZip" value="06193" />
<input type="hidden" name="OrderOAddress1" value="서울 강남구 테헤란로70길 12 (대치동)" />
<input type="hidden" name="OrderOAddress2" value="9층, 쌍용교육센터" />
<input type="hidden" name="OrderORoadAddress" value="서울 강남구 테헤란로70길 12 (대치동)" />
<input type="hidden" name="BonusGift" id="BonusGift" class=" BonusGift" value="" />


					<!-- 2023-02-01 주문자 정보 (비회원) 추가 -->


					<div class="odr-toggle-box ordInfo open" style="display:none;">
						<div class="hd">
							<h3>주문자 정보</h3>

							<div>
								<button type="button" class="toggle__btn">button</button>
							</div>
						</div>

						<div class="cn">
							<div class="addr-info-box">
								<div class="inp-box">
									<div class="nm_pn">
										<div class="name">
											<input type="text" placeholder ="이름" maxlength="10" name="OrderOName" id="orderName2" value="지영주" readonly>
										</div>
										<div class="phn">
											<input type="number" placeholder ="휴대폰 번호를 '-' 제외하고 숫자만 입력해주세요" name="OrderOTel21" id="OrderOTel21" maxlength="11" value="01021246441"  onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" onKeyDown="this.value=this.value.replace(/[^0-9]/g,'');" onBlur="this.value=this.value.replace(/[^0-9]/g,'');" readonly>
										</div>
									</div>
									<div class="addr">	
										<div style="display:none;">
											<input type="text" >
										</div>
										<div>
											<input type="text" class="" maxlength="50" name="OrderOEmail" id="email" placeholder="이메일" value="jyj030818@naver.com">
										</div>
									</div>
								</div>							
							</div>						
						</div>
<script>
$('#OrderOTel21').keyup(function (e) {
	let content = $(this).val();        
    // 글자수 제한
    if (content.length > 11) {
        $(this).val($(this).val().substring(0, 11));
    };
});
</script>
					</div>



					<!-- // 2023-02-01 배송지 정보 (비회원) 추가 -->





					<!-- 배송지 정보 -->
					<div class="odr-toggle-box _type_addr open"> <!-- 2023-02-21 클래스 추가 _type_addr -->
						<div class="hd">
							<h3>배송지 정보</h3>
							<div>
								<button type="button" class="delivery-change__btn addrBtn">변경</button>
							</div>
	
						</div>

						<div class="cn">
							<div class="addr-info-box">
								<div class="txt-box">
									<p class="name delivery-change__btn" id="dName">지영주</p>
									<p class="tel delivery-change__btn" id="dTel">010-1234-5678</p>
								</div>

								<div class="txt-box">
									<p class="addr delivery-change__btn" id="dAddr">
										(06193)&nbsp;서울 강남구 테헤란로70길 12 (대치동)&nbsp;9층, 쌍용교육센터
									</p>
									<!--span class="fc09" id="addDelivery"></span-->
								</div>
								
								<!-- 배송 메시지 -->
								<div class="msg-box">
									<select onchange="$('#orderMemo').val(this.value);">
										<option value="">배송요청사항 선택</option>
										<option value="부재시 문앞에 부탁드려요.">부재시 문앞에 부탁드려요.</option>
										<option value="경비실에 맡겨주세요.">경비실에 맡겨주세요.</option>
										<option value="">직접 입력</option>
									</select>
									<input type="text" placeholder="내용을 입력해주세요." name="OrderContents" id="orderMemo">
								</div>
								<!-- //배송 메시지 -->
							</div>						
						</div>
					</div>
					<!-- //배송지 정보 -->

					
					<input type="hidden" placeholder ="이름" maxlength="10" name="OrderDName" id="orderName" value="지영주">
					<input type="hidden" placeholder ="휴대폰 번호를 '-' 제외하고 숫자만 입력해주세요" name="OrderDTel21" maxlength="11" value="01012345678">
					<input type="hidden" class="" readonly name="OrderDZip" value="06193">
					<input type="hidden" class="" readonly maxlength="100" name="OrderDAddress1" value="서울 강남구 대치동 890-60">
					<input type="hidden" class="" readonly maxlength="100" name="OrderDRoadAddress" value="서울 강남구 테헤란로70길 12 (대치동)">
					<input type="hidden" class="" maxlength="100" tabindex="24" name="OrderDAddress2" value="9층, 쌍용교육센터" autocomplete="off">

					<!-- 배송 방법 -->
					<div class="odr-toggle-box open deliveryTypeBox">
						<div class="hd">
							<h3>배송방법</h3>
						</div>

						<div class="cn" id="todayDelivery">
							<div class="delivery-type-box">
								<!-- 배송방법 버튼 -->
								<input type="radio" name="deliveryOption" id="delivery_method1" value="0" onclick="todayDeliveryCheck();" data-gtm-form-interact-field-id="0" class="_val">
								<label for="delivery_method1">일반배송</label>

								<input type="radio" name="deliveryOption" id="delivery_method2" value="1" onclick="todayDeliveryCheck();" data-gtm-form-interact-field-id="1">  
								<label for="delivery_method2">오늘도착</label><br>

											<!--<a href="javascript:popAddDelivery()" class="btn_style6 addDeli"><span class="gr">+</span> 같이 배송</a>-->

								<!-- //배송방법 버튼 -->
								
								<!-- 설명 -->
								<div class="delivery-info-box">
									<div class="basic-box" style="display: block;">
										<p class="txt">3만원 이상 무료 배송 / 익일 출고</p>
									</div>

									<div class="today-box" style="display: none;">
										<p class="txt">
											* 멤버쉽회원만 이용가능합니다.<br>
											<b>* 오전 <strong class="red">11시50분 이후 주문시엔 익일 배송</strong>되며,<br>
											주말, 공휴일 주문시 이후 평일(영업일)에 출고됩니다.<br></b>
											* 배송 지역 : 서울 전체<br><br>
											
											<span>
												<!--* 오늘도착 불가능 상품 포함되었습니다.<br />
												* 오늘도착 가능한 재고가 없습니다.<br />
												* 배송지를 입력해주세요.-->

												<span class="red">5,000원</span> / <b style="color:blue;">12/30(화)</b> <ee style="color:black;">23시전 도착예정</ee><br>
	
											</span></p><p id="useCpn">
												
											</p>
											
											
										<p></p>
									</div>
								</div>
								<!-- //설명 -->
							</div>



<script>
	$("#delivery_method1").click();
	todayDeliveryCheck();

</script>
</div>

					</div>
					<!-- //배송 방법 -->


					<!-- 주문상품 -->
					<div class="odr-toggle-box open" id="cartList" >


						<div class="hd">
							<h3>주문 상품</h3> <!-- 2024-11-07 상품 수량/가격 위치 변경-->
							<p class="notice" style="display:none;">* 매장 발송 상품은  물류센터에서 발송되는 상품과 개별 배송되오니 참고 부탁드립니다.</p>
							<p class="txt _v2">1건&nbsp;/&nbsp;<ee id="TotalPrice_Cart">0</ee>원</p>

							<div>
								<button type="button" class="toggle__btn">button</button>
							</div>
						</div>
						
						<div class="cn">
							<ul class="odr__list __pay">
    <c:forEach var="item" items="${orderItems}">
        <li>
            <div class="goods-thumb">
			    <img src="${pageContext.request.contextPath}/displayImage.do?path=C:/fila_upload/product/${item.productId}/${item.productId}_main_1.jpg" 
			         alt="${item.productName}" 
			         onerror="this.src='${pageContext.request.contextPath}/resources/images/no_image.jpg';">
			</div>
            <div class="goods-info">
                <p class="sex">FILA</p>
                <p class="tit">${item.productName}</p>

                <div class="info">
                    <div><p>상품코드&nbsp;:&nbsp;${item.productId}</p></div>
                    <div><p>옵션(ID)&nbsp;:&nbsp;${item.combinationId}</p></div>
                    <div><p>수량&nbsp;:&nbsp;${item.quantity}</p></div>
                </div>

                <div class="pp-box">
                    <div class="price">
                        <p class="sale"><fmt:formatNumber value="${item.price}" pattern="#,###"/>원</p>
                    </div>
                </div>
                <p class="today_tag">배송준비중</p>
            </div>
        </li>
    </c:forEach>
</ul>
						</div>



<script>
	$("#TotalPrice_Cart").html("259,000");
	
</script>
					</div>
					<!-- // 주문상품 -->
						
					<!-- 2023-02-01 사은품 증정 추가 -->

				<!-- 2020-10-19 gift_area S -->

			<div class="odr-toggle-box open odr-gift-wrap gift-present">
						<div class="hd">
							<h3>사은품 증정</h3>
						</div>
						<div class="cn">
							<ul class="thumb3_list">

<!--div>25 실버문 신꾸 패키지 종료 되었습니다.</div-->

							</ul>

						</div>	
					</div>
				<!-- 2020-10-19 gift_area E -->

<script>
	jQuery(".gift-present").hide();
</script>







					<!-- 결제방법 -->
					<div class="odr-toggle-box open">
						<div class="hd">
							<h3>결제방법을 선택해 주세요.</h3>

							<div>
								<p class="txt" id="paymethod"></p>
								<button type="button" class="toggle__btn">button</button>
							</div>
						</div>

						<div class="cn">
							<div class="pay-method-box">
								<ul>
									<li>
										<input type="radio" name="gopaymethod" id="payWay1" value="card" data-method="신용카드" >
										<label for="payWay1">신용카드</label>
										<!--span class="tag">혜택</span-->
									</li>  
									<li>
										<input type="radio" name="gopaymethod" id="payWay9" value="iniciskakao" data-method="카카오페이" >
										<label for="payWay9">
											<img src="//filacdn.styleship.com/filacontent2//mo/resource/images/sub/pay_kakao.png" alt="" style="width: 60px;" />
										</label>
									</li>
								</ul>

								<div class="chk-pay">
									<input type="checkbox" id="payChk" name="paymethodSave" value="1" class="cb__style1" checked>
									<label for="payChk">선택한 결제수단을 다음에도 사용</label>
								</div>
							</div>
						</div>
					</div>
					<!-- //결제방법 -->


					
				</div>	
				<!-- // order -->
					<c:set var="totalGoodsPrice" value="0" />
				<c:forEach var="item" items="${orderItems}">
				    <c:set var="totalGoodsPrice" value="${totalGoodsPrice + (item.price * item.quantity)}" />
				</c:forEach>
				<!-- total price -->
				<div class="total-box">
					

					<div class="price-box">
						<div class="price-inner">

							<dl>
							    <dt>총 상품금액</dt>
							    <dd><fmt:formatNumber value="${totalOriginalPrice}" pattern="#,###"/>원</dd>
							</dl>
							<dl>
							    <dt>상품 할인금액</dt>
							    <dd class="_type_red">-
							        <em id="sale_total3">
							            <fmt:formatNumber value="${totalOriginalPrice - totalSalePrice}" pattern="#,###"/>
							        </em>원
							    </dd>
							</dl>

							

							<dl>
								<dt>
									쿠폰 할인
									
									<button type="button" class="coupon__btn">선택</button>									
								</dt>
								<dd class="_type_red">-<em id="sale_total2">0</em>원</dd>

								<!-- 쿠폰 선택시 노출 -->
								<dd class="selected-coupon" id="cpnName" ></dd>
								<!-- //쿠폰 선택시 노출 -->
							</dl>
							

							<dl id="pointArea">
								<dt>
									포인트 사용
									
									<button type="button" class="point__btn" data-txt1="모두 사용" data-txt2="사용 취소" onclick="is_check0_ALL();">모두사용</button>
								</dt>
								<dd class="_type_red">-<input type="text" name="usemile" value="0" style="ime-mode:disabled;" onblur="pay_change0();" onfocus="if (this.value==0) this.value='';void(0);" maxlength="7"  onkeyup="ReturnNumberVal(this,0);pointNumberVal(this);if (event.keyCode==13) pay_change0();void(0);">P</dd>
								<input type="text" style="display:none;">

								<!-- 쿠폰 선택시 노출 -->
								<dd class="my-point">보유 포인트 : <ee id="usePoint">5,000</ee>P</dd>
								<!-- //쿠폰 선택시 노출 -->
							</dl>



							<!--dl>
								<dt>포인트</dt>
								<dd>-<em id="sale_total3">0</em>원</dd>
							</dl-->
							<dl>
								<dt>배송비</dt>
								<dd>
									<em id="transprice2">0</em>원
									<em class="pcolor1" id="islandPay2"></em>
									<em class="pcolor1" id="dangilPay2"></em>
								</dd>
									
							</dl>
							
							<dl class="total-pirce">
							    <dt>최종 결제금액</dt>
							    <dd><span id="display_total_price"><fmt:formatNumber value="${totalSalePrice}" pattern="#,###"/></span>원</dd>
							</dl>
							<input type="hidden" name="OrderTotalPrice" id="OrderTotalPrice" value="${totalGoodsPrice}" />
							<input type="hidden" name="address_id" value="1" /> 
							
							<dl class="_type_agree">
								<dt>주문 내용을 확인했으며, 약관에 동의합니다.</dt>
								<dd><a href="javascript:;" class="btn_agree_view">약관보기</a></dd>
							</dl>
							<input type="hidden" name="use_rnd1" value="ok">
							

							<div class="btn-box" id="checkoutbtn">
								<a href="javascript:pay_checkout();void(0);" class="btn_bg__bk on">결제하기</a> <!-- 구매하기 버튼 활성화시 off 제거-->
							</div>

						</div>
						
					</div>

				</div>
				<!-- //total price -->

				
			</section>
			</form>
			
		</div>

		<!-- // end of :: contents -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
function pay_checkout() {
    // 1. 필수 선택값 체크
    const paymentMethod = $("input[name='gopaymethod']:checked").val();
    if (!paymentMethod) {
        alert("결제 수단을 선택해 주세요.");
        return;
    }

    if (!confirm("정말로 결제하시겠습니까?")) return;

    // 2. 서버로 보낼 데이터 수집
    // Serialize를 사용하면 form 내의 모든 input 값을 한 번에 가져옵니다.
    const formData = $("form[name='user']").serialize();

    $.ajax({
        url: "${pageContext.request.contextPath}/order/processOrder.htm", // 아까 properties에 등록한 주소
        type: "POST",
        data: formData,
        dataType: "json",
        success: function(res) {
            if (res.status === "success") {
                alert("주문이 완료되었습니다!");
                location.href = res.redirect; // 완료 페이지로 이동
            } else {
                alert("오류 발생: " + res.message);
            }
        },
        error: function(xhr, status, error) {
            console.error(error);
            alert("결제 처리 중 통신 오류가 발생했습니다.");
        }
    });
}
</script>
<!-- start of :: footer -->
<jsp:include page="../common/footer.jsp" />
  

</body>
</html>