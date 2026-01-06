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


								<li>
									<div class="goods-thumb"><img src="//filacdn.styleship.com/filaproduct2/data/productimages/a/2/FS254DJ01F001_234.jpg" alt="<한소희 착용> 여성 플로우다운 초코" /></div>
									<div class="goods-info">
										<p class="sex">FILA</p>
										<p class="tit"><한소희 착용> 여성 플로우다운 초코</p>

										<div class="info">
											<div>
												<p>색상&nbsp;:&nbsp;234</p>
											</div>

											<div>
												<p>사이즈&nbsp;:&nbsp;W80(WXS)</p>
											</div>

											<div>
												<p>수량&nbsp;:&nbsp;1</p>

												<!-- 2023-09-07 품절임박 추가 (전체 재고 5개 이하일 경우 노출) -->
												<!--<p class="oos_tag">품절임박</p>
												<!-- // 2023-09-07 품절임박 추가 (전체 재고 5개 이하일 경우 노출) -->
											</div>
										</div>
										

										<div class="pp-box">

											<div class="price">
												<p class="sale">259,000원</p>
												
											</div>
											
											<!--
											
											
											<p class="point">5,180P</p>
											
											
											-->
										</div>	
										
										<!-- 2023-02-01 오늘 도착 태그 추가 -->
										
										<p class="today_tag">오늘도착 가능</p><!-- 오늘도착 불가인 경우 클래스 _v2 추가 -->
										
									</div>
								</li>
<input type="hidden" name="cart1_coupon1val" id="cart1_coupon1val" value />
<input type="hidden" name="cart1_coupon2val" id="cart1_coupon2val" value />
<input type="hidden" name="cart1_coupon3val" id="cart1_coupon3val" value />
<input type="hidden" name="cart1_coupon4val" id="cart1_coupon4val" value />
<input type="hidden" name="cart1_coupontval" id="cart1_coupontval" value />

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

					<!-- //2023-02-01 사은품 증정 추가 -->


<input type="hidden" name="pay_type" value />
<input type="hidden" name="OrderTotalPrice" value="259000" />
<input type="hidden" name="TotalPrice_Cart" value="259000" />
<!-- Delivery_price가 기본 / transpay가 변형 -->
<input type="hidden" name="Delivery_price" value="0" />
<input type="hidden" name="transpay" value="0" />
<input type="hidden" name="Delivery_coupon" value="" />

<input type="hidden" name="minPoint" value="0" />
<input type="hidden" name="coup1sale" value="0" />
<input type="hidden" name="coup2sale" value="0" />
<input type="hidden" name="coup3sale" value="0" />
<input type="hidden" name="promoTotal" value="0" />

<input type="hidden" name="OrderUseCoupon" value="" />
<input type="hidden" name="OrderUseCouponPrice" value="0" />
<input type="hidden" name="OrderSaleCategory" value="" />
<input type="hidden" name="OrderSalePrice" value="" />

<input type="hidden" name="OrderIsisland" value="0" />
<input type="hidden" name="addpay" value="0" />
<input type="hidden" name="giftEventValue" value="" />
<!-- 오늘도착 여부 -->
<input type="hidden" name="OrderIsDangil" value="0" />

<input type="hidden" name="IsTest" value="" />



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
	
				<!-- total price -->
				<div class="total-box">
					

					<div class="price-box">
						<div class="price-inner">

							<dl>
								<dt>총 상품금액</dt>
								<dd>259,000원</dd>
							</dl>
							<dl>
								<dt>상품 할인금액</dt>
								<dd class="_type_red">-<em id="sale_total3">0</em>원</dd>
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
								<dt>총 주문금액</dt>
								<dd><span id="div_price22">259,000</span>원<span class="sale_txt" id="salerate2"></span></dd>
							</dl>
							
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
<script>

	var productData = new Array()

	/*
	gtag("event", "begin_checkout", {
		"items": productData
	});
	*/
</script>

<!-- DHIVE - GTM datalayer (purchase) 2019-08-29 S -->
<script>
    dataLayer.push({
        'event': 'checkout',
        'ecommerce': {
            'checkout': {
                'actionField':{'step':1},
                'products': [
									
                ]
            }
        }
    });
</script>	

<!-- 2023-04-03 #HJ GA4 S -->
<script>
window.dataLayer = window.dataLayer || [];
window.dataLayer.push({
  event: 'begin_checkout',
  ecommerce: {
    items: [{ item_name: '<한소희 착용> 여성 플로우다운 초코', item_id: '1100FS254DJ01F001234', item_no: '61123', price: 259000,item_brand: 'FILA' , item_category: 'WOMEN', item_category2: '의류', item_category3: '패딩/다운점퍼', item_variant: '234', item_variant2: 'W80(WXS)', quantity: 1 }]
  }
});
</script>
<!-- 2023-04-03 #HJ GA4 E -->

<script>
	// #HJ 2025-06-05 추가 
	/*
  window.InsiderQueue = window.InsiderQueue || [];
  window.InsiderQueue.push({
    type : 'custom_event',
    value : [{
      event_name : 'checkout_custom',
      event_parameters : {
        "currency" : "KRW",
        "session_id" : "2025122310381610514",
        "source" : "Web",
        "device_type" : "PC",
        "products" : []
      }
    }]
  });
  */

  function waitForInsider(callback) {
    if (typeof Insider !== 'undefined') {
      callback();
    } else {
      setTimeout(function () {
        waitForInsider(callback);
      }, 500);
    }
  }

  waitForInsider(function () {
		Insider.track('events', [
			
		]);
  });
</script>

		<!-- 하단 고정 버튼 (top, sns) -->
<div class="bot-fix-box">
	<div class="inner">

		<!-- 2023-12-13 오늘 본 상품 있는 경우 (상품 썸네일 변경) -->
		<button type="button" class="today-goods__thumb today-goods__btn">
			<img src="//filacdn.styleship.com/filaproduct2/data/productimages/a/1/FS254DJ01F001_234.jpg" alt="">
		</button>
		<!-- // 2023-12-13 오늘 본 상품 있는 경우 (상품 썸네일 변경) -->


		<button type="button" class="kakaotalk__btn" onclick="doBizmsg();void(0);">
			<svg xmlns="http://www.w3.org/2000/svg" width="50" height="50" viewBox="0 0 50 50">
				<g id="btn_kakao" transform="translate(-330)">
					<circle id="타원_73" data-name="타원 73" cx="25" cy="25" r="25" transform="translate(330)" fill="#fedc00"/>
					<g id="그룹_18" data-name="그룹 18" transform="translate(345 15)">
						<path id="패스_8" data-name="패스 8" d="M192.79,193.223c-5.868,0-10.625,3.782-10.625,8.447a8.127,8.127,0,0,0,4.614,6.966l-.768,4.118a.236.236,0,0,0,.362.241l4.564-3.006s1.221.128,1.853.128c5.868,0,10.625-3.782,10.625-8.447s-4.757-8.447-10.625-8.447" transform="translate(-182.165 -193.223)" fill="#3c1e1e"/>
					</g>
				</g>
			</svg>
		</button>


		<script src="https://bizmessage.kakao.com/chat/includeScript"></script>
<script type="text/javascript">
function doBizmsg() {
var kakaoPop = window.open("about:blank","kakaoPop","width=350,height=550")
var frm = document.formbiz;
frm.submit();
//document.getElementById("form-biz").submit();

}
</script>
<form id="form-biz" name="formbiz" action="https://bizmessage.kakao.com/chat/open" method="post" target="kakaoPop">
<!--
<input type="hidden" name="uuid" value="@FILA" />
<input type="hidden" name="extra" value="FILA_M"/>
-->

<input type="hidden" name="uuid" value="@fila" />
<input type="hidden" name="extra" value="TCK_M"/>

<input type="hidden" name="bot" value="true" />
<input type="hidden" name="event" value="시작" />
</form>



		<button type="button" class="top__btn">top</button>		
	</div>
</div>
<!-- //하단 고정 버튼 (top, sns) -->

<!-- start of :: footer -->
<jsp:include page="../common/footer.jsp" />
<!-- // end of :: footer -->
 
<script>
        $(document).ready(function(){
            if(typeof Swiper !== 'undefined') {
                new Swiper('.goods__slider', {
                    slidesPerView: 4,
                    spaceBetween: 10,
                    freeMode: true,
                    scrollbar: {
                        el: '.goods-slider-scrollbar',
                        draggable: true,
                    },
                });
            }
        });
</script>    

</body>
</html>