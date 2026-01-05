<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<title>장바구니 | FILA</title>

<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.1, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi">


	<meta name="title" content="FILA KOREA" />
	<meta name="description" content="FILA 공식 온라인 스토어, 신상품정보, 신규가입 혜택, 매장안내" />
	<meta name="keywords" content="FILA,휠라코리아,휠라,FILA KOREA" />
	<meta name="image" content="http://www.fila.co.kr/images/img_yrl_fila.png" />
	<meta property="og:url" content="https://www.fila.co.kr/order/cart.asp?mode=2" />
	<meta property="og:title" content="FILA KOREA" />
	<meta property="og:description" content="FILA 공식 온라인 스토어, 신상품정보, 신규가입 혜택, 매장안내" />
	<meta property="og:image" content="http://www.fila.co.kr/images/img_yrl_fila.png" />	
	<meta property="og:type" content="company" />
	<meta property="og:site_name" content="Fila" />
	<meta property="og:locale" content="ko_KR" />
	<META NAME="ROBOTS" CONTENT="INDEX, FOLLOW">
	<link rel="canonical" href="https://www.fila.co.kr/order/cart.asp">
	


<meta name="google-site-verification" content="Dmig64DN96tegHOMDkLPB0oWoVMVUEugRp1Wks6yesc" />
<meta name="naver-site-verification" content="1b1f51a708ed50b7d8d98cb6b19a05c710b58497" />

<link rel="icon" type="image/x-icon" href="//filacdn.styleship.com/filacontent2/favicon.ico" />

<link href="${pageContext.request.contextPath}/css/SpoqaHanSansNeo.css" rel="stylesheet">
	
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/normalize.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/opt-default.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/swiper-bundle.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/layout.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/product.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/sub.css">

<script src="${pageContext.request.contextPath}/js/TweenMax.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery-1.12.4.js"></script>
<script src="${pageContext.request.contextPath}/js/mighty.base.1.5.7.js"></script>
<script src="${pageContext.request.contextPath}/js/swiper-bundle.js"></script>
<script src="${pageContext.request.contextPath}/js/swiper-bundle.js"></script>

<script src="${pageContext.request.contextPath}/js/default.js"></script>

	<script>
	jQuery(window.document).ready(function(){
		jQuery(window.document).on("contextmenu", function(event){return false;});
	});  
	</script>


    <script>
/* #HJ 2019-10-23 SUZZEST 스크립트는 삭제 */
		$.cachedScript = function( url, options ) {
				options = $.extend( options || {}, {
				dataType: "script",
				cache: true,
				url: url,
				async: false
			});
			return $.ajax( options );
		};

		$(function() {
			function async_call(js, cb){
				$.cachedScript(js).done(function() {
					if(cb != undefined){
						return eval(cb)();
					}
				})
			}
			async_call('//service.stylecomment.com/common/js/social.js?v=20180515');
		});
	</script>

<!-- 2017-01-11 추가 SISO Pixel Code 2018-03-12 주석처리 -->
<!-- 2017-01-11 추가 End SISO Pixel Code -->

	<!-- Global site tag (gtag.js) - Google Analytics -->
	<script async src="https://www.googletagmanager.com/gtag/js?id=UA-71658650-2"></script>
	<script>
		/*
		* 광고차단시 이벤트콜백 작동
		* 2018.07.03 - gtag 이벤트콜백 검증추가
		* 박재영
		*/
		function gtag(){
			var a = arguments,o = "object",f = "function", g = window.gaData;
			dataLayer.push(a);
			if(!g || !g["UA-71658650-2"]) if(typeof(a[2]) == o) if(typeof(a[2].event_callback) == f) a[2].event_callback();
	 	}
		gtag('js', new Date());
		gtag('config', 'UA-71658650-2');
		
		/* 2019-01-03 추가 01-11 수정 */
	  gtag('config', 'AW-779324062');
	  gtag('config', 'AW-772098764');
	  gtag('config', 'AW-772108122');				
	</script>


<!--RecoPick 로그수집 스크립트 #HJ 2017-03-24 추가 LHS 2021-06-09 레코픽 스크립트 삭제-->
<!--RecoPick 로그수집 스크립트 E -->

<!-- 2023-09-01 Facebook Pixel Code 삭제 tagmanager에 존재함 -->

<!-- 2023-02-02 Kakao Pixel Code -->
<script type="text/javascript" charset="UTF-8" src="//t1.daumcdn.net/kas/static/kp.js"></script>
<script type="text/javascript">
kakaoPixel('4536685350611693576').pageView();
</script>
<!-- 2023-02-02 End Kakao Pixel Code -->

<!-- 2019-01-03 Start Performance Analytics (PA) 2022-06-02 다시 복원 PA 맞음 -->
<script>
!function(w,e){if(w.cre) return;
e=w.cre=function(i,c,m,n){e.queue.push(arguments);};
e.push=e;e.loaded=!0;e.queue=[];}(window);
cre('init','fila');
cre('send','Pageview');
</script>
<script src="//cdn.cresendo.net/Track.js"></script>
<!-- 2019-01-03 Start Performance Analytics (PA) -->

<!-- 2020-05-07 Groobee 2020-08-31 교체 -->
<!-- 2020-05-07 ''' groobee 2024-03-29 삭제 -->

<!-- 2020-07-23 #HJ karamel S 2022-05-30 제거 -->
<!-- 2020-07-23 #HJ karamel E -->

<!-- cre.ma / 공통 스크립트 (PC) / 스크립트를 수정할 경우 연락주세요 (support@cre.ma) -->
<script>(function(i,s,o,g,r,a,m){if(s.getElementById(g)){return};a=s.createElement(o),m=s.getElementsByTagName(o)[0];a.id=g;a.async=1;a.src=r;m.parentNode.insertBefore(a,m)})(window,document,'script','crema-jssdk','//widgets.cre.ma/fila.co.kr/init.js');</script>

		<script> window.cremaAsyncInit = function () { crema.init('jyj030818','지영주'); } </script>

<!-- #HJ Opinno 2023-06-01 S -->
<script src="https://www.googleoptimize.com/optimize.js?id=OPT-WZGPRFT"></script>
<!-- #HJ Opinno 2023-06-01 E -->

<!-- #HJ INSIDER 2024-01-16 S -->
<script src="https://filacokr.api.useinsider.com/ins.js?id=10009917"></script>
<!-- #HJ INSIDER 2024-01-16 E -->
<!-- 개별 css, js -->
<script src="/pc/resource/js/pages/order.js?v=2023041907"></script>
<script>
var GV_DANGILDELIVERY = "5000";
var GV_MEMBERID = "jyj030818"
</script>
<!-- 2019-01-03 Google_Conversion AW-772098764 gtag3 -->
<!-- 2019-01-03 Google_Traffic 772108122 gtag4 -->
<script>
function gtag_report_conversion(url) {
	var totalprice = 0;
	jQuery("input[name=checkwish]:checked").each(function(){
		totalprice += parseFloat(jQuery(this).attr("data-price"));
	})
	totalprice += parseFloat(jQuery("#DeliveryTotal").val())

  gtag('event', 'conversion', {
      'send_to': 'AW-779324062/9YuYCIiM7o0BEJ6VzvMC',
      'value': totalprice,
      'currency': 'KRW'
  });
  gtag('event', 'conversion', {
      'send_to': 'AW-772098764/ZNOnCN38rJIBEMyVlfAC',
      'value': totalprice,
      'currency': 'KRW'
  });
  gtag('event', 'conversion', {
      'send_to': 'AW-772108122/lBXiCIqArZIBENrelfAC',
      'value': totalprice,
      'currency': 'KRW'
  });
  return false;
}
</script>


<script>
function changeCheck(obj,cn){
	
	jQuery("."+cn).prop("checked",jQuery(obj).is(":checked"))
}
function changeCartPrice2(){

	if(jQuery("#todayDeliView").is(":checked")){
		changeCartPrice3();
	}else{

		var cprice = 0;
		var oprice = 0;
		var cpromo = 0;
		var addpoint = 0;
		var miPrice = 0;
		var maxPrice = 30000;
		var DeliveryTotal = 3000;

		///1+1시 가격 설정
		/*
		jQuery("input[name=checkwish]:checked").each(function(){
			if (jQuery(this).attr("data-promo") == "True" ){
				cpromo++;	
			}
			if (jQuery(this).attr("data-promo") == "True" && jQuery(this).attr("data-pq") % 2 == 0){
				cpromo++;
			}
		})
		*/
		try{
			console.log(1);
			jQuery("input[name=checkwish]:checked").each(function(){
				if (cpromo % 2 == 0 && cpromo > 0 && jQuery(this).attr("data-promo") == "True" ){
					cprice += (parseFloat(jQuery(this).attr("data-price"))/2);
				}else if (cpromo > 0 && jQuery(this).attr("data-promo") == "True" && jQuery(this).attr("data-pq") % 2 == 0 ){
					cprice += (parseFloat(jQuery(this).attr("data-price"))/2);
				}else{
					cprice += parseFloat(jQuery(this).attr("data-price"));
				}
				oprice += parseFloat(jQuery(this).attr("data-priceOri"));
				addpoint += parseFloat(jQuery(this).attr("data-addPoint"));
				miPrice += parseFloat(jQuery(this).attr("data-pricesale"));
			})
			
			if (parseFloat(cprice) <= parseFloat(maxPrice) && parseFloat(cprice) > 0 ){
				jQuery("#DeliveryTotal").val(DeliveryTotal);
			}else{
				jQuery("#DeliveryTotal").val(0);
			}
			cprice += parseFloat(jQuery("#DeliveryTotal").val());
			//oprice += parseFloat(jQuery("#DeliveryTotal").val());
			jQuery("#ctPice").empty();
			jQuery("#ctPice").html(PrintComma(oprice));
			jQuery("#pPrice").empty();
			jQuery("#pPrice").html(PrintComma(cprice) + "");
			jQuery("#miPrice").empty();
			jQuery("#miPrice").html(PrintComma(miPrice) + "");
			jQuery("#dvPoint").html(PrintComma(addpoint) + "P");
			
			jQuery("#dvPrice").empty();
			jQuery("#dvPrice").html(PrintComma(jQuery("#DeliveryTotal").val()) + "");
					if ( jQuery("input[id^=checkProduct]").length - jQuery("input[id^=checkProduct]:checked").length == 0  )	{
						jQuery("#checkAll").prop("checked", true);
					}else{
						jQuery("#checkAll").prop("checked", false);
					}
		}catch(e){
			jQuery("input[name=checkwish]:checked").each(function(){
				if (cpromo % 2 == 0 && cpromo > 0 && jQuery(this).attr("data-promo") == "True" ){
					cprice += (parseFloat(jQuery(this).attr("data-price"))/2);
				}else if (cpromo > 0 && jQuery(this).attr("data-promo") == "True" && jQuery(this).attr("data-pq") % 2 == 0 ){
					cprice += (parseFloat(jQuery(this).attr("data-price"))/2);
				}else{
					cprice += parseFloat(jQuery(this).attr("data-price"));
				}
				oprice += parseFloat(jQuery(this).attr("data-price"));
				addpoint += parseFloat(jQuery(this).attr("data-addPoint"));
			})
			if (parseFloat(cprice) <= parseFloat(maxPrice) && parseFloat(cprice) > 0 ){
				jQuery("#DeliveryTotal").val(DeliveryTotal);
			}else{
				jQuery("#DeliveryTotal").val(0);
			}
			cprice += parseFloat(jQuery("#DeliveryTotal").val());
			//oprice += parseFloat(jQuery("#DeliveryTotal").val());
			jQuery("#ctPice").empty();
			jQuery("#ctPice").html(PrintComma(oprice));
			jQuery("#pPrice").empty();
			jQuery("#pPrice").html(PrintComma(cprice) + "");
			jQuery("#miPrice").empty();
			jQuery("#miPrice").html(PrintComma(miPrice) + "");
			jQuery("#dvPoint").html(PrintComma(addpoint) + "P");
			jQuery("#dvPrice").empty();
			jQuery("#dvPrice").html(PrintComma(jQuery("#DeliveryTotal").val()) + "");
					if ( jQuery("input[id^=checkProduct]").length - jQuery("input[id^=checkProduct]:checked").length == 0  )	{
						jQuery("#checkAll").prop("checked", true);
					}else{
						jQuery("#checkAll").prop("checked", false);
					}
		}
	}

	dangilYN();
}

function setCartQty(obj,cq){
	var cartqty = jQuery(obj).val();
	jQuery(".qty" + cq).val(cartqty);
}
</script>
<script>
// 뷰
jQuery(function(){
	// 수량 빼기
	jQuery(document).on("click",  "#vpop button[id^=qtyMinus]", function() {
		var maxStock = jQuery("input:radio[name='ProductSize_Cart']:checked").attr("data-limit") != undefined ?jQuery("input:radio[name='ProductSize_Cart']:checked").attr("data-limit") : ProductStockLimitNumber ; 
		var minStock = maxStock > 0 ? 1 : 0 ;

		var obj = jQuery(this).next( "input[id^=ProductQuantity]" )
		var qtyVal = obj.val(); 
		
		qtyVal = jQuery.isNumeric(qtyVal) ? qtyVal : minStock ;
		qtyVal--;
		qtyVal = qtyVal < minStock ? minStock : qtyVal ;
		obj.val( qtyVal );
		var val7 = document.form99.cartPrice.value;
		$("#ctoprice").html(PrintComma(val7*qtyVal)+"원");
	})
	// 수량 더하기
	jQuery(document).on("click",  "#vpop button[id^=qtyPlus]", function() {
		var maxStock = jQuery("input:radio[name='ProductSize_Cart']:checked").attr("data-limit") != undefined ?jQuery("input:radio[name='ProductSize_Cart']:checked").attr("data-limit") : ProductStockLimitNumber ; 
		var minStock = maxStock > 0 ? 1 : 0 ;
		//console.log(11);
		var obj = jQuery(this).prev( "input[id^=ProductQuantity]" ); 
		var qtyVal = obj.val(); 
		qtyVal = jQuery.isNumeric(qtyVal) ? qtyVal : minStock ;
		qtyVal++;
		qtyVal = qtyVal > maxStock ? maxStock : qtyVal ;
		obj.val( qtyVal );
		var val7 = document.form99.cartPrice.value;
		$("#ctoprice").html(PrintComma(val7*qtyVal)+"원");
	})
	jQuery(document).on("blur", "#vpop input[id^=ProductQuantity]", function() {
		var maxStock = jQuery("input:radio[name='ProductSize_Cart']:checked").attr("data-limit") != undefined ?jQuery("input:radio[name='ProductSize_Cart']:checked").attr("data-limit") : ProductStockLimitNumber ; 
		var minStock = maxStock > 0 ? 1 : 0 ;

		var regex = /[0-9]|\./;
		var obj = jQuery(this);
		var val = obj.val();
		!regex.test( val ) ? obj.val( minStock ) : "" ;

		val < minStock ? obj.val( minStock ) : "" ;
		val > maxStock ? obj.val( maxStock ) : "" ;
		var val7 = document.form99.cartPrice.value;
		$("#ctoprice").html(PrintComma(val7*qtyVal)+"원");
	})
	
	jQuery('#todayDeliView').click();void(0);
	
})
</script>
</head>
<body class="">
	<!-- start of :: wrap -->
	<div id="wrap">
		<!-- 2023-12-19 띠배너 추가 -->
		
<style>
	.banner__top {
		position: fixed;
		top: 0;
		left: 0;
		width: 100%;
		min-width: 1200px;
		height: 30px;
		background-color: #002053;
		padding: 0 40px;
		box-sizing: border-box;
		z-index: 301;
	}
	.banner__top p {
		display: flex;
		justify-content: center;
		align-items: center;
		width: 100%;
		height: 100%;
		font-size: 14px;
		font-family: 'Pretendard', 'Tartuffo-Bold', 'Spoqa Han Sans Neo', sans-serif;
		font-weight: 700;
		line-height: 16px;
		text-align: center;
		color: rgb(255,255,255);
	}
	.banner__top .top__close-btn {
		position: absolute;
		right: 33px;
		top: 50%;
		width: 30px;
		height: 30px;
		transform: translateY(-50%);
		background: url(/pc/resource/images/common/ban_close_btn_wt_15x15.png) no-repeat center/15px;
	}
</style>
		
<!-- #HJ 2019-08-19 BODY start Google Tag Manager (noscript) -->
<noscript><iframe src="https://www.googletagmanager.com/ns.html?id=GTM-PK46MQC"
height="0" width="0" style="display:none;visibility:hidden"></iframe></noscript>
<!-- End Google Tag Manager (noscript) -->

<!--  start of : skipNavi -->
<ul id="skipNavi">
	<li><a href="#contents">본문내용 바로가기</a></li>
	<li><a href="#footer">하단메뉴 바로가기</a></li>
</ul>
<!-- // end of  skipNavi -->

<!-- start of :: header -->
<header id="header">
	<!-- logo -->
	<h1 class="logo">
		<a href="/main/main.asp">FILA</a>
	</h1>
	<!-- //logo -->

	<!-- gnb -->
	<nav class="gnb">
		<ul>

			<!--li class="_gnb_kids">
				<a href="/event/blackfriday2025/" style="color: rgb(10,1,254);">BLACK FRIDAY</a>
			</li-->

			
			<li>
				<a href="/main/women.asp">WOMEN</a>

				<!-- 2 Depth -->
				<div class="depth2-box">
					<div class="inner">
						<!-- side menu -->
						<div class="side-menu-box">
							<a class="link-tit">New &amp; Featured</a>

							<div>
								<ul>
									<li>
										<a href="/product/new.asp?no=2001">신상품</a>
									</li>
									<li>
										<a href="/product/best.asp?no=2001">베스트</a>
									</li>
									<li>
										<a href="/product/style.asp?cno=101">스타일</a>
									</li>
									<li>
										<a href="/product/sale.asp?no=2001">세일</a>
									</li>
								</ul>

								<ul>
									<li>
										<a href="/event/view.asp?seq=1309">1911 Knit Track</a>
									</li>
									<li>
										<a href="/product/list.asp?no=2246">Holiday Gifts</a>
									</li>
									<li>
										<a href="/event/view.asp?seq=1303">Ritmo Sleek</a>
									</li>
									<li>
										<a href="/event/view.asp?seq=1298">Glio Silver-Moon</a>
									</li>
									<li>
										<a href="/event/view.asp?seq=1294">플로우다운</a>
									</li>
									<li>
										<a href="/event/view.asp?seq=1289">Her Winter Ritual</a>
									</li>
									
									<li>
										<a href="/event/view.asp?seq=1285">HAREPIN 1998</a>
									</li>
									
									<li>
										<a href="/event/view.asp?seq=1279">한소희&김나영 에샤페</a>
									</li>
									<li>
										<a href="/event/view.asp?seq=1269">Sydney Trip with 차정원</a>
									</li>
									<li>
										<a href="/event/view.asp?seq=1277">에센셜 언더웨어</a>
									</li>
								</ul>
							</div>
						</div>
						<!-- //side menu -->

						<!-- category menu -->
						<div class="category-menu-box">

							<!-- 묶음 -->
							<div>
								
									<a href="/product/list.asp?no=2007" class="link-tit">의류</a>
								
								<div>

									<ul>
									
										<li>
											<a href="/product/list.asp?no=2007">전체보기</a>
										</li>
										
										<li>
											<a href="/product/list.asp?no=2100" >패딩/다운점퍼</a>
										</li>
										
										<li>
											<a href="/product/list.asp?no=2040" >바람막이/집업</a>
										</li>
										
										<li>
											<a href="/product/list.asp?no=2267" >긴팔</a>
										</li>
										
										<li>
											<a href="/product/list.asp?no=2041" >맨투맨/후디</a>
										</li>
										
										<li>
											<a href="/product/list.asp?no=2048" >플리스</a>
										</li>
										
										<li>
											<a href="/product/list.asp?no=2046" >팬츠</a>
										</li>
										
										<li>
											<a href="/product/list.asp?no=2047" >스커트/원피스</a>
										</li>
										
										<li>
											<a href="/product/list.asp?no=2044" >반팔</a>
										</li>
										
										<li>
											<a href="/product/list.asp?no=2045" >브라탑/베스트</a>
										</li>
										
										<li>
											<a href="/product/list.asp?no=2101" >쇼츠</a>
										</li>
										
										<li>
											<a href="/product/list.asp?no=2303" >레깅스</a>
										</li>
										
										<li>
											<a href="/product/list.asp?no=2042" >트레이닝 셋업</a>
										</li>
										
										<li>
											<a href="/product/list.asp?no=2043" >테니스</a>
										</li>
										
									</ul>

								</div>
							</div>
							<!-- //묶음 -->

							<!-- 묶음 -->
							<div>
								
									<a href="/product/list.asp?no=2008" class="link-tit">신발</a>
								
								<div>

									<ul>
									
										<li>
											<a href="/product/list.asp?no=2008">전체보기</a>
										</li>
										
										<li>
											<a href="/product/list.asp?no=2112" >윈터슈즈</a>
										</li>
										
										<li>
											<a href="/product/list.asp?no=2049" >라이프스타일</a>
										</li>
										
										<li>
											<a href="/product/list.asp?no=2050" >헤리티지</a>
										</li>
										
										<li>
											<a href="/product/list.asp?no=2051" >테니스</a>
										</li>
										
										<li>
											<a href="/product/list.asp?no=2052" >러닝</a>
										</li>
										
										<li>
											<a href="/product/list.asp?no=2053" >샌들/슬리퍼</a>
										</li>
										
										<li>
											<a href="/product/list.asp?no=2210" >판테라 99/25</a>
										</li>
										
										<li>
											<a href="/product/list.asp?no=2134" >에샤페</a>
										</li>
										
										<li>
											<a href="/product/list.asp?no=2320" >하레핀</a>
										</li>
										
										<li>
											<a href="/product/list.asp?no=3134" >리트모</a>
										</li>
										
										<li>
											<a href="/product/list.asp?no=3136" >글리오</a>
										</li>
										
									</ul>

								</div>
							</div>
							<!-- //묶음 -->

							<!-- 묶음 -->
							<div>
								
									<a href="/product/list.asp?no=2009" class="link-tit">용품</a>
								
								<div>

									<ul>
									
										<li>
											<a href="/product/list.asp?no=2009">전체보기</a>
										</li>
										
										<li>
											<a href="/product/list.asp?no=2061" >테니스</a>
										</li>
										
										<li>
											<a href="/product/list.asp?no=2054" >백팩</a>
										</li>
										
										<li>
											<a href="/product/list.asp?no=2095" >숄더/토트백</a>
										</li>
										
										<li>
											<a href="/product/list.asp?no=2055" >메신저/크로스백</a>
										</li>
										
										<li>
											<a href="/product/list.asp?no=2058" >짐백</a>
										</li>
										
										<li>
											<a href="/product/list.asp?no=2057" >슬링백/힙색</a>
										</li>
										
										<li>
											<a href="/product/list.asp?no=2059" >모자</a>
										</li>
										
										<li>
											<a href="/product/list.asp?no=2060" >양말</a>
										</li>
										
										<li>
											<a href="/product/list.asp?no=2110" >윈터 아이템</a>
										</li>
										
										<li>
											<a href="/product/list.asp?no=2062" >기타</a>
										</li>
										
									</ul>

								</div>
							</div>
							<!-- //묶음 -->

							<!-- 묶음 -->
							<div>
								
									<a href="/main/underwear_w.asp" class="link-tit">언더웨어</a>
								
								<div>

									<ul>
									
										<li>
											<a href="/product/list.asp?no=2010">전체보기</a>
										</li>
										
										<li>
											<a href="/product/list.asp?no=2246" class="_type_holiday">홀리데이</a>
										</li>
										
										<li>
											<a href="/product/list.asp?no=3137" >휠라 X 쿠키런</a>
										</li>
										
										<li>
											<a href="/product/list.asp?no=2323" >에센셜 클래식</a>
										</li>
										
										<li>
											<a href="/product/list.asp?no=2274" >러버스</a>
										</li>
										
										<li>
											<a href="/product/list.asp?no=2212" >멜로우</a>
										</li>
										
										<li>
											<a href="/product/list.asp?no=2324" >버터소프트</a>
										</li>
										
										<li>
											<a href="/product/list.asp?no=2211" >벨로</a>
										</li>
										
										<li>
											<a href="/product/list.asp?no=2297" >퓨징</a>
										</li>
										
										<li>
											<a href="/product/list.asp?no=2288" >F코튼</a>
										</li>
										
										<li>
											<a href="/product/list.asp?no=2124" >파자마</a>
										</li>
										
										<li>
											<a href="/product/list.asp?no=2118" >와이어브라</a>
										</li>
										
										<li>
											<a href="/product/list.asp?no=2119" >노와이어브라</a>
										</li>
										
										<li>
											<a href="/product/list.asp?no=2121" >패키지</a>
										</li>
										
										<li>
											<a href="/product/list.asp?no=2117" >브라탑</a>
										</li>
										
										<li>
											<a href="/product/list.asp?no=2067" >팬티</a>
										</li>
										
										<li>
											<a href="/product/list.asp?no=2122" >사각드로즈</a>
										</li>
										
										<li>
											<a href="/product/list.asp?no=2123" >이지웨어</a>
										</li>
										
									</ul>

								</div>
							</div>
							<!-- //묶음 -->

							<!-- 묶음 -->
							<div class="cate">
								<a href="/main/tennis.asp" class="link-tit">스포츠</a>

								<div>
									<ul>
										<li>
											<a href="/main/tennis.asp">테니스</a>
										</li>
										<li>
											<a href="/main/running.asp">러닝/트레이닝</a>
										</li>
										
									</ul>
								</div>
							</div>
							<!-- //묶음 -->

						</div>
						<!-- //category menu -->
					</div>
				</div>
				<!-- //2 Depth -->						

				<div class="gnb-bg__wrap"></div>		
			</li>
			<li> <!-- 활성화시 클래스 on -->
				<a href="/main/men.asp">MEN</a>

				<!-- 2 Depth -->
				<div class="depth2-box">
					<div class="inner">
						<!-- side menu -->
						<div class="side-menu-box">
							<a class="link-tit">New &amp; Featured</a>

							<div>
								<ul>
									<li>
										<a href="/product/new.asp?no=2000">신상품</a>
									</li>
									<li>
										<a href="/product/best.asp?no=2000">베스트</a>
									</li>
									<!--li>
										<a href="/product/style.asp?cno=100">스타일</a>
									</li-->
									<li>
										<a href="/product/sale.asp?no=2000">세일</a>
									</li>
								</ul>

								<ul>
									<li>
										<a href="/product/list.asp?no=2246">Holiday Gifts</a>
									</li>
									<li>
										<a href="/event/view.asp?seq=1294">플로우다운</a>
									</li>
									
									<li>
										<a href="/event/view.asp?seq=1285">HAREPIN 1998</a>
									</li>
									
									<li>
										<a href="/event/view.asp?seq=1236">AXILUS 3 T9</a>
									</li>
									<li>
										<a href="/event/view.asp?seq=1214">Tennis Shoes</a>
									</li>
									<li>
										<a href="/event/view.asp?seq=1194">UNDERWEAR X BALANSA</a>
									</li>
								</ul>
							</div>
						</div>
						<!-- //side menu -->

						<!-- category menu -->
						<div class="category-menu-box">

							<!-- 묶음 -->
							<div>
								
									<a href="/product/list.asp?no=2003" class="link-tit">의류</a>
								
								<div>

									<ul>
									
										<li>
											<a href="/product/list.asp?no=2003">전체보기</a>
										</li>
										
										<li>
											<a href="/product/list.asp?no=2102" >패딩/다운점퍼</a>
										</li>
										
										<li>
											<a href="/product/list.asp?no=2014" >바람막이/집업</a>
										</li>
										
										<li>
											<a href="/product/list.asp?no=2266" >긴팔</a>
										</li>
										
										<li>
											<a href="/product/list.asp?no=2015" >맨투맨/후디</a>
										</li>
										
										<li>
											<a href="/product/list.asp?no=2019" >팬츠</a>
										</li>
										
										<li>
											<a href="/product/list.asp?no=2020" >플리스</a>
										</li>
										
										<li>
											<a href="/product/list.asp?no=2018" >반팔</a>
										</li>
										
										<li>
											<a href="/product/list.asp?no=2318" >베스트</a>
										</li>
										
										<li>
											<a href="/product/list.asp?no=2103" >쇼츠</a>
										</li>
										
										<li>
											<a href="/product/list.asp?no=2016" >트레이닝 셋업</a>
										</li>
										
										<li>
											<a href="/product/list.asp?no=2017" >테니스</a>
										</li>
										
									</ul>

								</div>
							</div>
							<!-- //묶음 -->

							<!-- 묶음 -->
							<div>
								
									<a href="/product/list.asp?no=2004" class="link-tit">신발</a>
								
								<div>

									<ul>
									
										<li>
											<a href="/product/list.asp?no=2004">전체보기</a>
										</li>
										
										<li>
											<a href="/product/list.asp?no=2111" >윈터슈즈</a>
										</li>
										
										<li>
											<a href="/product/list.asp?no=2021" >라이프스타일</a>
										</li>
										
										<li>
											<a href="/product/list.asp?no=2022" >헤리티지</a>
										</li>
										
										<li>
											<a href="/product/list.asp?no=2023" >테니스</a>
										</li>
										
										<li>
											<a href="/product/list.asp?no=2024" >러닝</a>
										</li>
										
										<li>
											<a href="/product/list.asp?no=2025" >샌들/슬리퍼</a>
										</li>
										
										<li>
											<a href="/product/list.asp?no=2213" >에샤페</a>
										</li>
										
										<li>
											<a href="/product/list.asp?no=2209" >판테라 99/25</a>
										</li>
										
										<li>
											<a href="/product/list.asp?no=2319" >하레핀</a>
										</li>
										
										<li>
											<a href="/product/list.asp?no=3135" >리트모</a>
										</li>
										
									</ul>

								</div>
							</div>
							<!-- //묶음 -->

							<!-- 묶음 -->
							<div>
								
									<a href="/product/list.asp?no=2005" class="link-tit">용품</a>
								
								<div>

									<ul>
									
										<li>
											<a href="/product/list.asp?no=2005">전체보기</a>
										</li>
										
										<li>
											<a href="/product/list.asp?no=2033" >테니스</a>
										</li>
										
										<li>
											<a href="/product/list.asp?no=2026" >백팩</a>
										</li>
										
										<li>
											<a href="/product/list.asp?no=2027" >메신저/크로스백</a>
										</li>
										
										<li>
											<a href="/product/list.asp?no=2030" >숄더/짐백</a>
										</li>
										
										<li>
											<a href="/product/list.asp?no=2029" >슬링백/힙색</a>
										</li>
										
										<li>
											<a href="/product/list.asp?no=2031" >모자</a>
										</li>
										
										<li>
											<a href="/product/list.asp?no=2032" >양말</a>
										</li>
										
										<li>
											<a href="/product/list.asp?no=2109" >윈터 아이템</a>
										</li>
										
										<li>
											<a href="/product/list.asp?no=2034" >기타</a>
										</li>
										
									</ul>

								</div>
							</div>
							<!-- //묶음 -->

							<!-- 묶음 -->
							<div>
								
									<a href="/main/underwear_m.asp" class="link-tit">언더웨어</a>
								
								<div>

									<ul>
									
										<li>
											<a href="/product/list.asp?no=2006">전체보기</a>
										</li>
										
										<li>
											<a href="/product/list.asp?no=3133" class="_type_holiday">홀리데이</a>
										</li>
										
										<li>
											<a href="/product/list.asp?no=3138" >휠라 X 쿠키런</a>
										</li>
										
										<li>
											<a href="/product/list.asp?no=2326" >슬라이스클럽</a>
										</li>
										
										<li>
											<a href="/product/list.asp?no=2035" >패키지</a>
										</li>
										
										<li>
											<a href="/product/list.asp?no=2036" >드로즈</a>
										</li>
										
										<li>
											<a href="/product/list.asp?no=2298" >트렁크</a>
										</li>
										
										<li>
											<a href="/product/list.asp?no=2125" >스포츠</a>
										</li>
										
										<li>
											<a href="/product/list.asp?no=2126" >이지웨어</a>
										</li>
										
										<li>
											<a href="/product/list.asp?no=2127" >파자마</a>
										</li>
										
										<li>
											<a href="/product/list.asp?no=2295" >F코튼</a>
										</li>
										
									</ul>

								</div>
							</div>
							<!-- //묶음 -->

							<!-- 묶음 -->
							<div class="cate">
								<a href="#" class="link-tit">스포츠</a>

								<div>
									<ul>
										<li>
											<a href="/main/tennis.asp">테니스</a>
										</li>										
										<li>
											<a href="/main/running.asp">러닝/트레이닝</a>
										</li>
										
									</ul>
								</div>
							</div>
							<!-- //묶음 -->

						</div>
						<!-- //category menu -->
					</div>
				</div>
				<!-- //2 Depth -->						

				<div class="gnb-bg__wrap"></div>		
			</li>			
			<li class="_gnb_kids">
				<a href="/main/kids.asp">KIDS</a>

				<!-- 2 Depth -->
				<div class="depth2-box">
					<div class="inner">
						<!-- side menu -->
						<div class="side-menu-box">
							<a class="link-tit">New &amp; Featured</a>

							<div>
								<ul>
									<li>
										<a href="/product/new.asp?no=2002">신상품</a>
									</li>
									<li>
										<a href="/product/best.asp?no=2002">베스트</a>
									</li>
									<li>
										<a href="/product/style.asp?cno=102">스타일</a>
									</li>
									<li>
										<a href="/product/sale.asp?no=2002">세일</a>
									</li>
								</ul>
								<ul>
									<li>
										<a href="/teeniepingrun/">FILA KIDS Teenieping Run</a>
									</li>
									<li>
										<a href="/event/view.asp?seq=1304">&#x1F392; 2026 신학기 백팩 컬렉션</a>
									</li>
								
									<li>
										<a href="/event/view.asp?seq=1292">&#127872; 여아 다운 & 부츠 컬렉션</a>
									</li>
								
									<li>
										<a href="/event/view.asp?seq=1286">&#128420; 프리미엄 구스 다운 : 아이스 블랙</a>
									</li>
									<li>
										<a href="/event/view.asp?seq=1287">&#128098; 코코부츠</a>
									</li>
									<li>
										<a href="/event/view.asp?seq=1270">&#128052; 마이 프렌즈 포니</a>
									</li>
								</ul>
							</div>
						</div>
						<!-- //side menu -->

						<!-- category menu -->
						<div class="category-menu-box kids">

							<!-- 묶음 -->
							<div>
								
									<a href="/product/list.asp?no=2011" class="link-tit">의류</a>
								
								<div>

									<ul>
									
										<li>
											<a href="/product/list.asp?no=2011">전체보기</a>
										</li>
										
										<li>
											<a href="/product/list.asp?no=2078" >다운/플리스</a>
										</li>
										
										<li>
											<a href="/product/list.asp?no=2176" >경량/퀼팅</a>
										</li>
										
										<li>
											<a href="/product/list.asp?no=2076" >바람막이/집업/자켓</a>
										</li>
										
										<li>
											<a href="/product/list.asp?no=2075" >후드티/맨투맨</a>
										</li>
										
										<li>
											<a href="/product/list.asp?no=2070" >상하의 셋업</a>
										</li>
										
										<li>
											<a href="/product/list.asp?no=2072" >팬츠/레깅스</a>
										</li>
										
										<li>
											<a href="/product/list.asp?no=2071" >티셔츠</a>
										</li>
										
										<li>
											<a href="/product/list.asp?no=2074" >스커트</a>
										</li>
										
										<li>
											<a href="/product/list.asp?no=2302" >원피스</a>
										</li>
										
									</ul>

								</div>
							</div>
							<!-- //묶음 -->

							<!-- 묶음 -->
							<div>
								
									<a href="/product/list.asp?no=2012" class="link-tit">신발</a>
								
								<div>

									<ul>
									
										<li>
											<a href="/product/list.asp?no=2012">전체보기</a>
										</li>
										
										<li>
											<a href="/product/list.asp?no=2084" >윈터슈즈</a>
										</li>
										
										<li>
											<a href="/product/list.asp?no=2315" >리틀에샤페</a>
										</li>
										
										<li>
											<a href="/product/list.asp?no=2316" >에픽런</a>
										</li>
										
										<li>
											<a href="/product/list.asp?no=2104" >휠라꾸미</a>
										</li>
										
										<li>
											<a href="/product/list.asp?no=2079" >운동화(130~160mm)</a>
										</li>
										
										<li>
											<a href="/product/list.asp?no=2081" >운동화(170~240mm)</a>
										</li>
										
										<li>
											<a href="/product/list.asp?no=2177" >레인부츠</a>
										</li>
										
									</ul>

								</div>
							</div>
							<!-- //묶음 -->

							<!-- 묶음 -->
							<div>
								
									<a href="/product/list.asp?no=2013" class="link-tit">용품</a>
								
								<div>

									<ul>
									
										<li>
											<a href="/product/list.asp?no=2013">전체보기</a>
										</li>
										
										<li>
											<a href="/product/list.asp?no=3004" >26 신학기 책가방</a>
										</li>
										
										<li>
											<a href="/product/list.asp?no=2092" >윈터 아이템</a>
										</li>
										
										<li>
											<a href="/product/list.asp?no=2086" >책가방</a>
										</li>
										
										<li>
											<a href="/product/list.asp?no=2087" >보조가방 </a>
										</li>
										
										<li>
											<a href="/product/list.asp?no=2088" >모자</a>
										</li>
										
										<li>
											<a href="/product/list.asp?no=2089" >양말</a>
										</li>
										
										<li>
											<a href="/product/list.asp?no=2090" >기타</a>
										</li>
										
									</ul>

								</div>
							</div>
							<!-- //묶음 -->

						</div>
						<!-- //category menu -->
					</div>
				</div>
				<!-- //2 Depth -->							

				<div class="gnb-bg__wrap"></div>	
			</li>
		</ul>

		<div class="bar"></div>

		<ul>
			<!-- 2023-06-28 MEMBERS WEEK 추가 -->
			<!--li class="no-depth">
				<a href="/event/membersweek2023_2/index.asp" style="color: rgb(225,0,0);">MEMBERS WEEK</a>
			</li-->
			
			<li class="no-depth" style="display: none;"> <!-- 2023-07-11 숨김 -->
				<a href="/collabo/list.asp">COLLABORATION</a>
			</li>
			
			<!-- //2023-06-28 MEMBERS WEEK 추가 -->


			<!-- 2024-04-25 테니스 추가 -->
			<li class="_gnb_tennis"> <!-- 활성화시 클래스 on -->
				<a href="/main/tennis.asp">TENNIS</a>

				<!-- 2 Depth -->
				<div class="depth2-box">
					<div class="inner">
						<!-- side menu -->
						<div class="side-menu-box">
							<a class="link-tit">New &amp; Featured</a>

							<div>
								<ul>
									<li>
										<a href="/event/view.asp?seq=1236">AXILUS 3 T9</a>
									</li>
									<li>
										<a href="/event/view.asp?seq=1184">FIRE ACE T7​</a>
									</li>
									<li>
										<a href="https://clubmatch.fila.co.kr/main/main.asp">2025 FILA 클럽매치</a>
									</li>
									<li>
										<a href="/event/view.asp?seq=1214">Tennis Shoes Guide</a>
									</li>
									<li>
										<a href="/wos2025/">2025 WHITE OPEN SEOUL</a>
									</li>
								</ul>
							</div>
						</div>
						<!-- //side menu -->

						<!-- category menu -->
						<div class="category-menu-box">
							<div>								
								<a href="/product/list.asp?no=2043" class="link-tit">WOMEN</a>
								
								<div>
									<ul>
									
										<li>
											<a href="/product/list.asp?no=2043">의류</a>
										</li>
									
										<li>
											<a href="/product/list.asp?no=2051">신발</a>
										</li>

										<li>
											<a href="/product/list.asp?no=2061">용품</a>
										</li>

									</ul>
								</div>
	
								<div class="wide-link-box"> <!-- 2025-09-01 _v2 추가-->
									<a href="/customstudio/intro.asp" class="link-custom _v2">테니스화 커스텀 서비스</a>
								</div>
							</div>

							<div>								
								<a href="/product/list.asp?no=2017" class="link-tit">MEN</a>
								
								<div>
									<ul>
									
										<li>
											<a href="/product/list.asp?no=2017">의류</a>
										</li>
									
										<li>
											<a href="/product/list.asp?no=2023">신발</a>
										</li>

										<li>
											<a href="/product/list.asp?no=2033">용품</a>
										</li>

									</ul>
								</div>
							</div>

							<div>
								<div class="tennis-bot-ban">
									<ul>
										<!--li>
											<a href="/filatennis/index.asp#whiteSeoul">
												<div class="img">
													<img src="https://web1.fila.co.kr/data/contentsfile/d_gnb_tennis_01_240425.jpg" alt="">
												</div>
												<p>FILA White Open Seoul 2024</p>	
											</a>
										</li-->

										<li class="tennis-club-link">
											<a href="https://clubmatch.fila.co.kr/main/main.asp">
												<div class="img">
													<img src="//filacdn.styleship.com/filacontent2/data/contentsfile/d_gnb_banner_clubmatch2025_v2.png" alt="">
												</div>
												<p>FILA Club Match</p>	
											</a>
										</li>

										<li class="tennis-club-link">
											<a href="/event/view.asp?seq=1264">
												<div class="img">
													<img src="//filacdn.styleship.com/filacontent2/data/contentsfile/d_gnb_banner_FILAMATCH.png" alt="">
												</div>
												<p>2025 FILA MATCH</p>	
											</a>
										</li>

										<!--
										<li class="tennis-club-link">
											<a href="/customstudio/intro.asp">
												<div class="img">
													<img src="//filacdn.styleship.com/filacontent2/data/contentsfile/img_custom_d_240530.png" alt="">
												</div>
												<p>FILA Custom Studio</p>	
											</a>
										</li>
										-->
									</ul>
								</div>
							</div>
							
						</div>
						<!-- //category menu -->
					</div>
				</div>
				<!-- //2 Depth -->						

				<div class="gnb-bg__wrap"></div>		
			</li>			
			<!-- //2024-04-25 테니스 추가 -->


			<li class="_brand_gnb" style=""> 
				<a href="#">BRAND</a>

				<!-- 2 Depth -->
				<div class="depth2-box">
					<div class="inner">
						<ul class="brand-gnb__list">
							<li>
								<a href="/about/about.asp">
									<div class="photo">
										<img src="//filacdn.styleship.com/filacontent2/pc/resource/images/common/1.jpg" alt="">
									</div>

									<p>About FILA</p>
								</a>
							</li>

							<li>
								<a href="/collabo/list.asp">
									<div class="photo">
										<img src="//filacdn.styleship.com/filacontent2/pc/resource/images/common/2.jpg" alt="">
									</div>

									<p>Collaboration</p>
								</a>
							</li>

							<li>
								<a href="/sustainability/">
									<div class="photo">
										<img src="//filacdn.styleship.com/filacontent2/pc/resource/images/common/3_240626.jpg" alt="">
									</div>

									<p>Sustainability</p>
								</a>
							</li>

							<li>
								<a href="/brand/athletes/">
									<div class="photo">
										<img src="//filacdn.styleship.com/filacontent2/pc/resource/images/common/4.jpg" alt="">
									</div>

									<p>Athletes</p>
								</a>
							</li>

							<li>
								<a href="/brand/tennis/story.asp">
									<div class="photo">
										<img src="//filacdn.styleship.com/filacontent2/pc/resource/images/common/img_brand_tennis_d.jpg" alt="">
									</div>

									<p>Content</p>
								</a>
							</li>
						</ul>
					</div>
				</div>
				<!-- //2 Depth -->	

				<div class="gnb-bg__wrap"></div>
			</li>
			
			<!-- 2024-07-26 UPCOMING 추가 -->
			<li class=""> 
				<a href="/upcoming/list.asp">UPCOMING</a>
			</li>
			<!-- // 2024-07-26 UPCOMING 추가 -->
						

			<!-- 2025-12-18 -->
			<!--
			<li class=""> 
				<a href="/teeniepingrun/" style="color: #DE4888;">Teenieping Run</a>
			</li>
			<!-- //2025-12-18 -->

		</ul>
	</nav>
	<!-- //gnb -->

	<!-- util -->
	<div class="util">
		<div class="util-store">
			<a href="/customer/store.asp" class="store__btn">store</a>
		</div>

		<div class="util-search">
			<button type="button" class="search-open__btn" >search</button>
			<form action="javascript:searchRun2();" name="searchForm2" method="get"  autocomplete="off">
			<!-- search layer -->
			<div class="search__layer">	

				<div class="head">
					<div class="search-category-box">
						<div>
							<button type="button" class="on searchCate searchs" onclick="searchsCate('');">전체</button> <!-- 활성화시 클래스 on -->
							<button type="button" class="searchCate searchs2001" onclick="searchsCate('2001');">WOMEN</button>
							<button type="button" class="searchCate searchs2000" onclick="searchsCate('2000');">MEN</button>
							<button type="button" class="searchCate searchs2002" onclick="searchsCate('2002');">KIDS</button>
						</div>
					</div>
					

					<div class="search-input-box">
						<div>						
							<button type="button" class="close__btn"></button>

							<!--<input type="search" placeholder="검색어 입력" name="searchItem" id="searchItem2" value="" onfocus="this.value='';" >-->
							<input type="search" placeholder="검색어 입력" name="searchItem" id="searchItem2" value="">
							<input type="hidden" name="searchsCateNo" id="searchsCateNo" value="">

							<button type="button" class="search__btn" onclick="javascript:searchRun2();void(0);">search</button>
						</div>
						
						<button type="button" class="cancel__btn">취소</button>
					</div>
				</div>

				

				<div class="con">
					<div class="inner">
						<!-- 최근 검색어 -->
						<div class="keywords-box _recommend">
							<div>
								<p class="tit">최근 검색어</p>

								<button type="button" class="all-delete__btn" onclick="wordRemoveAll();">전체 기록 삭제</button>
							</div>

							<div>
								<ul class="latest__list" id="sWordHistory">
								</ul>
								
							</div>
						</div>
						<!-- //최근 검색어 -->


						<!-- 인기 검색어 -->
						<div class="keywords-box _popular">
							<div>
								<p class="tit">인기 검색어</p>

								<p class="update-txt">12:00 업데이트</p>
							</div>

							<div>
								<ul>

									<li>
										<a href="/search/search_result.asp?sWord=%uD55C%uC18C%uD76C">한소희</a>
									</li>

									<li>
										<a href="/search/search_result.asp?sWord=FS254RB01F002">FS254RB01F002</a>
									</li>

									<li>
										<a href="/search/search_result.asp?sWord=%uBE0C%uB77C">브라</a>
									</li>

									<li>
										<a href="/search/search_result.asp?sWord=FK253CD01X008">FK253CD01X008</a>
									</li>

									<li>
										<a href="/search/search_result.asp?sWord=FS253OD03X014">FS253OD03X014</a>
									</li>

									<li>
										<a href="/search/search_result.asp?sWord=%uD32C%uD2F0">팬티</a>
									</li>

									<li>
										<a href="/search/search_result.asp?sWord=%uC5D0%uC0E4%uD398">에샤페</a>
									</li>


								</ul>
							</div>
						</div>
						<!-- //인기 검색어 -->

						<!-- 추천 검색어 -->
						<div class="keywords-box _recommend">
							<div>
								<p class="tit">추천 검색어</p>
							</div>

							<div>
								<ul>

									<li>
										<a href="https://www.fila.co.kr/event/view.asp?seq=1269">차정원 신발</a>
									</li>

									<li>
										<a href="https://www.fila.co.kr/event/view.asp?seq=1268">판테라 LX</a>
									</li>

									<li>
										<a href="https://www.fila.co.kr/product/view.asp?ProductNo=60326">에픽런 포니</a>
									</li>

									<li>
										<a href="https://www.fila.co.kr/product/view.asp?ProductNo=60294">리틀에샤페</a>
									</li>

									<li>
										<a href="https://www.fila.co.kr/event/view.asp?seq=1233">피트니스</a>
									</li>


								</ul>
							</div>
						</div>
						<!-- //추천 검색어 -->

						<!-- 추천 상품 -->
						<div class="keywords-box _recommend_goods">
							<div>
								<p class="tit">추천상품</p>
							</div>

							<div>
								<div class="goods-scroll-box _type_v2"> <!-- 2024-08-05 클래스 추가 _type_v2 -->
									<div class="slider-box">
										<div class="goods__slider swiper">
											<div class="swiper-wrapper" id="headerProduct">

											</div>
										</div>

										<div class="goods-slider-scrollbar"></div>
									</div>				
								</div>
							</div>
						</div>
						<!-- //추천 상품 -->
					</div>
				</div>
			</form>
			</div>

			<div class="search-bg__wrap"></div>
			<!-- //search layer -->
			
		</div>

		<div class="util-account">
			<button type="button" class="account__btn" onclick="location.href='/member/login.asp'">account</button>

			<!-- account layer -->
			<div class="account__layer">
				<div class="inner">

					<div class="account-info-box loginMember" >
						<div>
							<p class="name">지영주님</p>
							<p class="level">
WHITE
							</p>
						</div>
	
						<div>
							<p class="percent">2% 적립</p>

							<a href="/customer/membership.asp">자세히 보기</a>
						</div>
	
					</div>

					<div class="account-menu-box" >
						<ul>
							<li id="globalMenu1">
								&nbsp;
							</li>

							<li id="globalMenu2">
								&nbsp;
							</li>

							<li id="globalMenu3">
								&nbsp;
							</li>
							<li id="globalMenu7">
								&nbsp;
							</li>
							<li id="globalMenu4">
								&nbsp;
							</li>
							<li id="globalMenu5">
								&nbsp;
							</li>
							<li id="globalMenu8">
								&nbsp;
							</li>
						</ul>
						<button type="button" class="logout__btn" id="globalMenu6" onclick="location.href='/member/logout.asp';">로그아웃</button>
					</div>


					<!-- //로그인 후 -->
				</div>
			</div>
			<!-- //account layer -->
		</div>

		<div class="util-cart">
			<button type="button" class="cart__btn" data-num="0" id="cart_cnt" onclick="location.href='/order/cart.asp';" rel="nosublink">cart</button>
		</div>
	</div>
	<!-- //util -->
</header>		
<!-- // end of :: header -->	
<form name="searchFormReal" method="get"  autocomplete="off" action="/search/search_result.asp">
	<input type="hidden" name="sWord" value />
	<input type="hidden" name="searchsCateNo" value />
</form>	


		<!-- start of :: contents -->
		<div id="contents" class="odr__contents">
           	<h2 class="tit__style1">장바구니</h2>

			<!-- 2023-09-07 상단 띠 배너 추가 (로그인 / 비로그인 상태에 따로 별도 설정) -->
			<div class="cart-top-ban">
				<div class="swiper-wrapper">

					<div class="swiper-slide"><p class="txt"><a href="/event/review.asp" target="_self">리뷰 작성 시 최대 3만 포인트 지급</a></p></div>


					<div class="swiper-slide"><p class="txt"><a href="/specialoffer/view.asp?seq=373" target="_self">오늘 도착 5,000원 혜택</a></p></div>


					<div class="swiper-slide"><p class="txt"><a href="/specialoffer/view.asp?seq=377" target="_self">신규 가입 시 1만원 할인</a></p></div>


				</div>
			</div>
			<!-- //2023-09-07 상단 띠 배너 추가 (로그인 / 비로그인 상태에 따로 별도 설정) -->
	
			<!-- cart tab -->
			<ul class="odr-tab">
				<li><a href="${pageContext.request.contextPath}/view/pay/cart.jsp" id="normalli" >일반배송 <sup>0</sup></a></li> <!-- 활성화 class "on" -->
				<input type="checkbox" id="todayDeliView" onclick="todayDeliViewAll();void(0);" style="display:none"/>
				<li><a href="${pageContext.request.contextPath}/view/pay/cart2.jsp" id="todayli" class="on"><label for="" >오늘도착 <sup id="todayCnt">0</sup></label></a></li>
			</ul>

			<!-- //cart tab -->
			<!-- // 일반배송일 경우 display: none처리 / 오늘도착 일 경우 block 처리 -->
			<div class="order-info-box todayinfo" style="">
				<div class="hd">
					<p class="tit">오늘도착 가능</p>
				</div>

				<div class="cn">
					<div class="txt-box">
						<p>멤버쉽 전용 서비스입니다.</p>
						<p>오늘도착 서비스는 [오늘도착]상품끼리만 주문가능합니다.</p>
						<p>오늘도착 주문은 평일 오전 11시 50분까지 “결제완료”된 주문건에 한해 배송됩니다.</p>
						<p>배송가능 지역은 서울 전지역만 가능하며, 주문서 작성 페이지에서 확인 가능합니다.</p>
						<p>주문하시는 상품의 크기 및 수량에 따라 박스당 5,000원의 배송비가 발생됩니다.</p>
					</div>
				</div>
			</div>
			
			
			<c:choose>
			<%-- 장바구니에 상품이 없을 경우 --%>
			<c:when test="${empty cartList}">
			  <div class="cart__empty">
			    <p class="txt">장바구니에 담긴 상품이 없습니다.</p>
			    <a class="btn_sld__bk" href="<c:url value='/'/>">쇼핑 계속하기</a> <%-- 메인 완성되면 메인 링크 추가 필요함 --%>
			  </div>
			</c:when>
			
			<%-- 장바구니에 상품이 있을 경우 --%>
			<%-- 
			  <c:if test="${not empty cartList}">
				  <c:forEach var="item" items="${cartList}">
				    <div class="cart-item">
				      <img src="${item.mainImageUrl}">
				      <div class="name">${item.productName}</div>
				      <div class="price">${item.saleUnitPrice}</div>
				      <div class="qty">${item.quantity}</div>
				    </div>
				  </c:forEach>
				</c:if>
			 --%>
				
			
			  <c:otherwise>

			    <section class="odr-wrap">
			      <div class="odr-box">
			
			        <div class="odr-hd">
			          <div>
			            <input type="checkbox" id="checkAll" checked="checked">
			            <label for="checkAll">전체선택 <span>(${fn:length(cartList)})</span></label>
			          </div>
			          <div class="txt-btn">
			            <a href="javascript:void(0);">품절삭제</a>
			            <a href="javascript:void(0);">선택삭제</a>
			          </div>
			        </div>
			
			        <ul class="odr__list">
			
			          <c:set var="sumOrigin" value="0"/>
			          <c:set var="sumSale"   value="0"/>
			          <c:set var="sumLine"   value="0"/>
			
			          <c:forEach var="item" items="${cartList}" varStatus="st">
			            <c:set var="sumOrigin" value="${sumOrigin + (item.originUnitPrice * item.quantity)}"/>
			            <c:set var="sumSale"   value="${sumSale + (item.saleUnitPrice * item.quantity)}"/>
			            <c:set var="sumLine"   value="${sumLine + item.lineAmount}"/>
			
			            <li>
			              <div class="goods_sel">
			                <input type="checkbox" id="checkProduct${st.index}" checked="checked">
			                <label for="checkProduct${st.index}">선택</label>
			              </div>
			
			              <div class="goods-thumb">
			                <a href="<c:url value='/product/view.do?productId=${item.productId}'/>">
			                  <c:choose>
			                    <c:when test="${not empty item.mainImageUrl}">
			                      <img src="${item.mainImageUrl}" alt="${item.productName}">
			                    </c:when>
			                    <c:otherwise>
			                      <img src="<c:url value='/images/noimage.png'/>" alt="no image">
			                    </c:otherwise>
			                  </c:choose>
			                </a>
			              </div>
			
			              <div class="goods-info">
			                <p class="sex">FILA</p>
			                <p class="tit">${item.productName}</p>
			
			                <div class="info">
			                  <div><p>수량 : ${item.quantity}개</p></div>
			                </div>
			
			                <div class="pp-box">
			                  <div class="price">
			                    <p class="sale">
			                      <fmt:formatNumber value="${item.saleUnitPrice}" pattern="#,###"/>원
			                    </p>
			                  </div>
			                </div>
			
			                <p class="today_tag">오늘도착 가능</p>
			              </div>
			
			              <div class="goods-etc">
			                <p class="ico">
			                  <button type="button" class="wish">위시</button>
			                  <button type="button" class="del">삭제</button>
			                </p>
			                <p class="btn-box">
			                  <button type="button" class="btn_sld__gr">옵션 변경</button>
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
			              <dd><span id="ctPice"><fmt:formatNumber value="${sumOrigin}" pattern="#,###"/></span>원</dd>
			            </dl>
			            <dl>
			              <dt>상품 할인금액</dt>
			              <dd class="_type_red">-<span id="miPrice"><fmt:formatNumber value="${sumOrigin - sumSale}" pattern="#,###"/></span>원</dd>
			            </dl>
			            <dl>
			              <dt>배송비</dt>
			              <dd><span id="dvPrice">0</span>원</dd>
			            </dl>
			            <dl class="total-pirce">
			              <dt>총 결제 예상 금액</dt>
			              <dd><span id="pPrice"><fmt:formatNumber value="${sumLine}" pattern="#,###"/></span>원</dd>
			            </dl>
			
			            <div class="btn-box">
			              <a href="javascript:void(0);" class="btn_bg__bk">구매하기</a>
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
			

			<!-- 2023-09-07 배너 추가 (로그인 여부 상관없이 적용) -->
			<section class="cart-ban-box">
				<div class="swiper-wrapper">
 
					<a href="/event/review.asp" class="swiper-slide" target="_self"><img src="//filacdn.styleship.com/filacontent2/data/banner/cart_banner_dt_58.jpg" alt=""></a>
 
					<a href="/specialoffer/view.asp?seq=373" class="swiper-slide" target="_self"><img src="//filacdn.styleship.com/filacontent2/data/banner/cart_banner_dt_03_39.jpg" alt=""></a>
 
					<a href="/specialoffer/view.asp?seq=377" class="swiper-slide" target="_self"><img src="//filacdn.styleship.com/filacontent2/data/banner/cart_banner_dt_04_43.jpg" alt=""></a>

				</div>
				
				<div class="scroll-bar-box">
					<div class="cart-sldr-pagination"></div>
					<div class="pagination-curr-bar">
						<div></div>
					</div>
				</div>
			</section>
			<!-- // 2023-09-07 배너 추가 (로그인 여부 상관없이 적용) -->
	

		</div>

		<!-- // end of :: contents -->

<!-- 2023-04-03 #HJ GA4 S -->

<!-- 2023-04-03 #HJ GA4 E -->
	
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
<footer id="footer">
	<div class="top">
		<!-- logo, link -->
		<div>
			<a href="/main/main.asp" class="logo">FILA</a>
			
			<ul class="link__list">
				<li>
					<a href="https://www.mistoholdings.com/investors/kor/irInfo.do" target="_blank">
						<span>Misto Holdings IR</span>						
					</a>
				</li>

				<!--<li>
					<a href="/ethics/ethics_management.asp">윤리경영</a>
				</li>-->
			</ul>
		</div>
		<!-- //logo, link -->
		
		<!-- sns -->
		<div class="sns-box">
			<a href="http://instagram.com/fila_korea" target="_blank" class="instagram__sns">instagram</a>
			<a href="http://www.facebook.com/FILAKOREA" target="_blank" class="facebook__sns">facebook</a>
			<a href="http://www.youtube.com/FILAKOREA" target="_blank" class="youtube__sns">youtube</a>
			<a href="https://pf.kakao.com/_aNxaCu" target="_blank" class="kakao__sns">kakao</a>
		</div>
		<!-- //sns -->
	</div>
	
	<div class="bot">
		<!-- link, address -->
		<div>
			<ul class="link__list">
				<li>
					<a href="/customer/store.asp">매장안내</a>
				</li>

				<li>
					<a href="/customer/notice.asp">공지사항</a>
				</li>

				<li>
					<a href="/customer/membership.asp">
						<span>MEMBERSHIP</span>						
					</a>
				</li>

				<li><!--2023-09-01 추가-->
					<a href="/event/view.asp?seq=883">단체 판매</a>
				</li>

				<li>
					<a href="/customer/agent.asp">대리점 개설문의</a>
				</li>

				<li>
					<a href="/customer/bidding.asp">입찰 참여 안내</a>
				</li>
				
			</ul>

			<div class="txt-box">
				<p class="address">
					서울특별시 성북구 보문로 35, 3~8층(보문동7가, 다홍빌딩) 미스토코리아(주) &nbsp;&nbsp;&nbsp;&nbsp;대표이사 : 김지헌<br />						
					사업자등록번호 : 716-81-01573&nbsp;&nbsp;<a href="http://www.ftc.go.kr/bizCommPop.do?wrkr_no=7168101573&apv_perm_no=2001321007630200873" target="_blank">사업자정보확인</a>&nbsp;&nbsp;&nbsp;&nbsp;통신판매업신고 : 제 2024-서울성북-0914 호<br />
					개인정보 보호책임자 : 이학우<br /><br />

					본 사이트의 상품이미지 저작권은 미스토코리아(주)에 있으며, 내용의 무단복제를 금합니다. <br />
					
				</p>
				
				<div class="content-info">
					<p>콘텐츠산업진흥법에 의한 콘텐츠보호안내&nbsp;</p>
					<button type="button">자세히 보기</button>

					<div class="img-box">
						<img src="//filacdn.styleship.com/filacontent2/pc/resource/images/common/fila_content_info_250422.jpg" alt="콘텐츠 산업진흥법에 의한 표시">
					</div>
				</div>
			</div>

			<ul class="link__list">
				<li>
					<a href="/company/agree.asp">통합회원 이용약관</a>
				</li>

				<li>
					<a href="/company/privacy.asp">
						<strong>개인정보 처리방침</strong>
					</a>
				</li>
				<li>
					<a href="/ethics/ethics_report.asp">제보센터</a>
				</li>
				<!-- <li>
					<a href="/company/.asp">
						<strong>제보센터</strong>
					</a>
				</li> -->
			</ul>
		</div>
		<!-- //link, address -->

		<!-- cs center, family site -->
		<div>
			<div class="cscenter-box">
				<a href="/customer/faq.asp" class="tit">CS CENTER</a>

				<p class="tel">1577-3472</p>
				<a href="mailto:filaonline@mistobrand.com">filaonline@mistobrand.com</a>
				<p class="txt">평일 월 - 금 : 09시 - 18시 (공휴일 제외)</p>
			</div>

			<div class="select-box">
				<div>
					<a href="javascript:;" class="language__btn">
						<img src="/pc/resource/images/common/ico_kor_16x10.png" alt="" />
						<span>KOREA</span>
					</a>
				</div>

				<div>
					<select onchange="window.open(value,'_target')">
						<option value="">FAMILY SITE</option>
						<option value="https://www.keds.co.kr/main/main.asp">KEDS 온라인스토어</option>
						<option value="https://www.nicedocu.com/web/buyer/main/index.jsp">FILA 입찰공고</option>
						<option value="https://www.mistoholdings.com/kor/main.do">Misto Holdings</option>
					</select>
				</div>
			</div>
		</div>
		<!-- //cs center, family site -->
	</div>
</footer>
<!-- // end of :: footer -->
<form name="form6" id="form6"  target="dataFrame"><input type="hidden" name="checkwish"><input type="hidden" name="ProductQuantity"></form>
<iframe name="dataFrame" id="dataFrame" style="display:none;"></iframe>

<!-- 2017-06-08 옮김 -->
<!-- 2016-03-30 공통 적용 스크립트 , 모든 페이지에 노출되도록 설치. 단 전환페이지 설정값보다 항상 하단에 위치해야함 --> 
<!-- 2019-06-12 재처리 -->
<script type="text/javascript" src="//wcs.naver.net/wcslog.js"> </script> 
<script type="text/javascript"> 
if (!wcs_add) var wcs_add={};
wcs_add["wa"] = "s_2dc7206136e";
if (!_nasa) var _nasa={};
wcs.inflow();
wcs_do(_nasa);
</script>

<!-- 2016-03-16 adinsight 공통스크립트 start 2022-05-30 제거 -->
<!-- adinsight 공통스크립트 end -->

<!-- 2022-11-15 #HJ criteo S -->
<!-- Criteo 로더 파일 -->
<script type="text/javascript" src="//dynamic.criteo.com/js/ld/ld.js?a=29360" async="true"></script>
<!-- END Criteo 로더 파일 -->

<!-- Criteo 장바구니 태그 -->
<script type="text/javascript">
window.criteo_q = window.criteo_q || [];
var deviceType = /iPad/.test(navigator.userAgent) ? "t" : /Mobile|iP(hone|od)|Android|BlackBerry|IEMobile|Silk/.test(navigator.userAgent) ? "m" : "d";
window.criteo_q.push(
 { event: "setAccount", account: 29360},
 
 { event: "setEmail", email: "jyj030818@naver.com", hash_method: "" },
 { event: "setZipcode", zipcode: "06193" },

 { event: "setSiteType", type: deviceType}
	
);
</script>
<!-- END Criteo 장바구니 태그 -->

<!-- 2022-11-15 #HJ criteo E -->



<!-- 2016-05-23 Google 리마케팅 태그 코드 S -->
<!-- 
리마케팅 태그를 개인식별정보와 연결하거나 민감한 카테고리와 관련된 페이지에 추가해서는 안 됩니다. 리마케팅 태그를 설정하는 방법에 대해 자세히 알아보려면 다음 페이지를 참조하세요. http://google.com/ads/remarketingsetup
-->
<script type="text/javascript">
/* <![CDATA[ */
var google_conversion_id = 881946050;
var google_custom_params = window.google_tag_params;
var google_remarketing_only = true;
/* ]]> */
</script>
<script type="text/javascript" src="//www.googleadservices.com/pagead/conversion.js">
</script>
<noscript>
<div style="display:inline;">
<img height="1" width="1" style="border-style:none;" alt="" src="//googleads.g.doubleclick.net/pagead/viewthroughconversion/881946050/?value=0&amp;guid=ON&amp;script=0"/>
</div>
</noscript>
<!-- 2016-05-23 Google 리마케팅 태그 코드 E -->


<!-- Enliple Tracker Start -->
<script type="text/javascript">
(function(a,g,e,n,t){a.enp=a.enp||function(){(a.enp.q=a.enp.q||[]).push(arguments)};n=g.createElement(e);n.async=!0;n.defer=!0;n.src="https://cdn.megadata.co.kr/dist/prod/enp_tracker_self_hosted.min.js";t=g.getElementsByTagName(e)[0];t.parentNode.insertBefore(n,t)})(window,document,"script");
enp('create', 'common', 'doa_filaunder', { device: 'W' });  // W:웹, M: 모바일, B: 반응형
enp('send', 'common', 'doa_filaunder');
</script>
<!-- Enliple Tracker End -->

<!-- #HJ 2023-01-02 OPINNO ContentSquare start -->

<script>

dataLayer.push ({
	'event':'page_view_cs',
	'property' : {
	  'brand_sub' : 'FILA',
	  'page_type' : 'CART',
	  'utm_source' : '',
	  'utm_medium' : '',
	  'utm_campaign' : '',
	  'utm_content' : '',
	  'utm_term' : ''
	}	
})	

dataLayer.push ({
	'event':'user_info',
	'property' : {
	  'userId' : '1f22d2e12c6896fa7eea8864590058bc',
	  'custno' : 'A20251128145726285180',
	  'registration_date' : '20251128',
	  'login_type' : 'eshop',	  	 		
	  'device' : 'desktop',
	  'logged_in' : 'yes',
	  'lifetime_value' : 0,
	  'order_count' : 0,
	  'grades' : 'WHITE',
	  'birth_year' : '2003',
	  'gender' : 'F',
	  'age' : 22,
	  'employee' : 'N'	  	  
	}	
})	
</script>
<!-- #HJ 2023-01-02 OPINNO ContentSquare end -->	

<!-- 2024-04-01 insider S -->	
<script language="javascript">

	var goodspno3 = "";
	var goodspno4 = "";
	var tagID = "";
	let campID = "";
	var nowUrl = location.href;
	var depth1No = "";
	var depth2No = "";
	var depth3No = "";
	var campaignId4 = "";
	var variationId4 = "";
	var headerchk = "";

		/* 해당 페이지에서만 처리 */
		if ((nowUrl.indexOf("/main/main") >= 0) || (nowUrl.indexOf("/product/view") >= 0) || (nowUrl.indexOf("/order/cart") >= 0) || (nowUrl.indexOf("/search/search") >= 0) || (nowUrl.indexOf("/main/kids") >= 0) || (nowUrl.indexOf("/main/tennis") >= 0) || (nowUrl.indexOf("/product/men") >= 0) || (nowUrl.indexOf("/product/women") >= 0) || (nowUrl.indexOf("/main/women") >= 0) || (nowUrl.indexOf("/main/men") >= 0) || (nowUrl.indexOf("/main/underwear") >= 0) || (nowUrl.indexOf("/order/pay_com") >= 0) || (nowUrl.indexOf("/product/list") >= 0)  || (nowUrl.indexOf("upcoming/list") >= 0) || (nowUrl.indexOf("/event/view") >= 0) || (nowUrl.indexOf("/product/membersweek") >= 0) )   {

			
	
			const timeInterval = setInterval(function(){
					Insider.eventManager.once('ins-sr:only-api-campaign:load', function (event, data) {
						var nowUrl = location.href;
						if (data.campaignId === 113 && nowUrl.indexOf('/main/main') >= 0) {	///통합메인페이지
							console.log(data);
							$.each(data.products, function(key,value){
								//console.log('key:' + key + ', ProductNo : ' + value.item_id );
								if (goodspno3 == ""){
									goodspno3 = value.item_id;
								}else{
									goodspno3 += "," + value.item_id;
								}
							})

							tagID = "recopickProduct";
							mode = "MAINDIVCART"
							GetCartInsiderView(tagID,data.campaignId,data.variationId, goodspno3,mode)
							//clearInterval(timeInterval);
						}else if (data.campaignId === 242 && nowUrl.indexOf('/main/women') >= 0)	{	///우먼메인
							console.log(data);
							$.each(data.products, function(key,value){
								//console.log('key:' + key + ', ProductNo : ' + value.item_id );
								if (goodspno3 == ""){
									goodspno3 = value.item_id;
								}else{
									goodspno3 += "," + value.item_id;
								}
							})

							tagID = "recopickProduct";
							mode = "MAINDIVCART"
							GetCartInsiderView(tagID,data.campaignId,data.variationId, goodspno3,mode)
							//clearInterval(timeInterval);
						}else if (data.campaignId === 243 && nowUrl.indexOf('/main/men') >= 0)	{	///맨메인
							console.log(data);
							$.each(data.products, function(key,value){
								//console.log('key:' + key + ', ProductNo : ' + value.item_id );
								if (goodspno3 == ""){
									goodspno3 = value.item_id;
								}else{
									goodspno3 += "," + value.item_id;
								}
							})

							tagID = "recopickProduct";
							mode = "MAINDIVCART"
							GetCartInsiderView(tagID,data.campaignId,data.variationId, goodspno3,mode)
							//clearInterval(timeInterval);
						}else if (data.campaignId === 244 && nowUrl.indexOf('/main/kids') >= 0)	{	///키즈메인
							console.log(data);
							$.each(data.products, function(key,value){
								//console.log('key:' + key + ', ProductNo : ' + value.item_id );
								if (goodspno3 == ""){
									goodspno3 = value.item_id;
								}else{
									goodspno3 += "," + value.item_id;
								}
							})

							tagID = "recopickProduct";
							mode = "MAINDIVCART"
							GetCartInsiderView(tagID,data.campaignId,data.variationId, goodspno3,mode)
							//clearInterval(timeInterval);
						}else if (data.campaignId === 245 && nowUrl.indexOf('/main/tennis') >= 0)	{	///테니스메인
							console.log(data);
							$.each(data.products, function(key,value){
								//console.log('key:' + key + ', ProductNo : ' + value.item_id );
								if (goodspno3 == ""){
									goodspno3 = value.item_id;
								}else{
									goodspno3 += "," + value.item_id;
								}
							})

							tagID = "recopickProduct";
							mode = "MAINDIVCART"
							GetCartInsiderView(tagID,data.campaignId,data.variationId, goodspno3,mode)
							//clearInterval(timeInterval);
						}else if (data.campaignId === 265 && nowUrl.indexOf('/main/underwear_w') >= 0)	{	///키즈메인
							console.log(data);
							$.each(data.products, function(key,value){
								//console.log('key:' + key + ', ProductNo : ' + value.item_id );
								if (goodspno3 == ""){
									goodspno3 = value.item_id;
								}else{
									goodspno3 += "," + value.item_id;
								}
							})

							tagID = "recopickProduct";
							mode = "MAINDIVCART"
							GetCartInsiderView(tagID,data.campaignId,data.variationId, goodspno3,mode)
							//clearInterval(timeInterval);
						}else if (data.campaignId === 266 && nowUrl.indexOf('/main/underwear_m') >= 0)	{	///키즈메인
							console.log(data);
							$.each(data.products, function(key,value){
								//console.log('key:' + key + ', ProductNo : ' + value.item_id );
								if (goodspno3 == ""){
									goodspno3 = value.item_id;
								}else{
									goodspno3 += "," + value.item_id;
								}
							})

							tagID = "recopickProduct";
							mode = "MAINDIVCART"
							GetCartInsiderView(tagID,data.campaignId,data.variationId, goodspno3,mode)
							//clearInterval(timeInterval);
						}else if (data.campaignId === 114 && nowUrl.indexOf('/product/view') >= 0)	{	///상품상세
							console.log(data);
							$.each(data.products, function(key,value){
								//console.log('key:' + key + ', ProductNo : ' + value.item_id );
								if (goodspno3 == ""){
									goodspno3 = value.item_id;
								}else{
									goodspno3 += "," + value.item_id;
								}
							})

							tagID = "recopickProduct";
							mode = "MAINDIVCART"
							GetCartInsiderView(tagID,data.campaignId,data.variationId, goodspno3,mode)
							//clearInterval(timeInterval);
						}else if (data.campaignId === 116 && nowUrl.indexOf('/product/view') >= 0)	{	///상품상세 장바구니 팝업
							/*
							console.log(data);
							$.each(data.products, function(key,value){
								//console.log('key:' + key + ', ProductNo : ' + value.item_id );
								if (goodspno4 == ""){
									goodspno4 = value.item_id;
								}else{
									goodspno4 += "," + value.item_id;
								}
							})
							*/
						}else if (data.campaignId === 115 && nowUrl.indexOf('/order/cart') >= 0)	{	///장바구니
							console.log(data);
							$.each(data.products, function(key,value){
								//console.log('key:' + key + ', ProductNo : ' + value.item_id );
								if (goodspno3 == ""){
									goodspno3 = value.item_id;
								}else{
									goodspno3 += "," + value.item_id;
								}
							})

							tagID = "recopickProduct";
							mode = "MAINDIVCART"
							GetCartInsiderView(tagID,data.campaignId,data.variationId, goodspno3,mode)
							//clearInterval(timeInterval);
						}else if (data.campaignId === 120 && nowUrl.indexOf('/search/search') >= 0)	{	///검색
							console.log(data);
							$.each(data.products, function(key,value){
								//console.log('key:' + key + ', ProductNo : ' + value.item_id );
								if (goodspno3 == ""){
									goodspno3 = value.item_id;
								}else{
									goodspno3 += "," + value.item_id;
								}
							})

							tagID = "recopickProduct";
							mode = "MAINDIVCART"
							GetCartInsiderView(tagID,data.campaignId,data.variationId, goodspno3,mode)
							//clearInterval(timeInterval);
						}else if (data.campaignId === 257 && nowUrl.indexOf('/product/view') >= 0 && (depth2No == "2003" || depth2No == "2004" || depth2No == "2005" || depth2No == "2007" || depth2No == "2008" || depth2No == "2009" || depth2No == "2135" || depth2No == "2136" ) ){ //상세 의류/슈즈/용품
							console.log(data);
							$.each(data.products, function(key,value){
								//console.log('key:' + key + ', ProductNo : ' + value.item_id );
								if (goodspno3 == ""){
									goodspno3 = value.item_id;
								}else{
									goodspno3 += "," + value.item_id;
								}
							})
							//goodspno4 = goodspno3;
							tagID = "recopickProduct";
							mode = "MAINDIVCART"
							GetCartInsiderView(tagID,data.campaignId,data.variationId, goodspno3,mode)
							//clearInterval(timeInterval);
						}else if (data.campaignId === 258 && nowUrl.indexOf('/product/view') >= 0 && (depth2No == "2006") ){ //상세 언더(남)
							console.log(data);
							$.each(data.products, function(key,value){
								//console.log('key:' + key + ', ProductNo : ' + value.item_id );
								if (goodspno3 == ""){
									goodspno3 = value.item_id;
								}else{
									goodspno3 += "," + value.item_id;
								}
							})
							//goodspno4 = goodspno3;
							tagID = "recopickProduct";
							mode = "MAINDIVCART"
							GetCartInsiderView(tagID,data.campaignId,data.variationId, goodspno3,mode)
							//clearInterval(timeInterval);						
						}else if (data.campaignId === 259 && nowUrl.indexOf('/product/view') >= 0 && ( ( depth2No == "2010" || depth2No == "2198" ) ) ){ //상세 언더(여)
							console.log(data);
							$.each(data.products, function(key,value){
								//console.log('key:' + key + ', ProductNo : ' + value.item_id );
								if (goodspno3 == ""){
									goodspno3 = value.item_id;
								}else{
									goodspno3 += "," + value.item_id;
								}
							})
							//goodspno4 = goodspno3;
							tagID = "recopickProduct";
							mode = "MAINDIVCART"
							GetCartInsiderView(tagID,data.campaignId,data.variationId, goodspno3,mode)
							//clearInterval(timeInterval);	
						}else if (data.campaignId === 260 && nowUrl.indexOf('/product/view') >= 0 && ( (depth1No == "2002" || depth2No == "2137" ) ) ) { //상세 키즈
							console.log(data);
							$.each(data.products, function(key,value){
								//console.log('key:' + key + ', ProductNo : ' + value.item_id );
								if (goodspno3 == ""){
									goodspno3 = value.item_id;
								}else{
									goodspno3 += "," + value.item_id;
								}
							})
							//goodspno4 = goodspno3;
							tagID = "recopickProduct";
							mode = "MAINDIVCART"
							GetCartInsiderView(tagID,data.campaignId,data.variationId, goodspno3,mode)
							//clearInterval(timeInterval);	
						}else if (data.campaignId === 261 && nowUrl.indexOf('/product/view') >= 0 && (depth3No == "2017" || depth3No == "2023" || depth3No == "2033" ||  depth3No == "2043" ||  depth3No == "2051" ||  depth3No == "2061" ||  depth3No == "2194" ||  depth3No == "2193" ) ) { //상세 테니스
							console.log(data);
							$.each(data.products, function(key,value){
								//console.log('key:' + key + ', ProductNo : ' + value.item_id );
								if (goodspno3 == ""){
									goodspno3 = value.item_id;
								}else{
									goodspno3 += "," + value.item_id;
								}
							})
							//goodspno4 = goodspno3;
							tagID = "recopickProduct";
							mode = "MAINDIVCART"
							GetCartInsiderView(tagID,data.campaignId,data.variationId, goodspno3,mode)
							//clearInterval(timeInterval);	
						}else if (data.campaignId === 272 && nowUrl.indexOf('/product/view') >= 0 && (depth2No == "2003" || depth2No == "2004" || depth2No == "2005" || depth2No == "2007" || depth2No == "2008" || depth2No == "2009" ) ){ //상세 의류/슈즈/용품 장바구니팝업
							console.log(data);
							$.each(data.products, function(key,value){
								//console.log('key:' + key + ', ProductNo : ' + value.item_id );
								if (goodspno4 == ""){
									goodspno4 = value.item_id;
								}else{
									goodspno4 += "," + value.item_id;
								}
								campaignId4 = data.campaignId;
								variationId4 = data.variationId;

							})
						}else if (data.campaignId === 273 && nowUrl.indexOf('/product/view') >= 0 && (depth2No == "2006") ){ //상세 언더(남) 장바구니팝업
							console.log(data);
							$.each(data.products, function(key,value){
								//console.log('key:' + key + ', ProductNo : ' + value.item_id );
								if (goodspno4 == ""){
									goodspno4 = value.item_id;
								}else{
									goodspno4 += "," + value.item_id;
								}
								campaignId4 = data.campaignId;
								variationId4 = data.variationId;
							})
						}else if (data.campaignId === 274 && nowUrl.indexOf('/product/view') >= 0 && (depth2No == "2010") ){ //상세 언더(여) 장바구니팝업
							console.log(data);
							$.each(data.products, function(key,value){
								//console.log('key:' + key + ', ProductNo : ' + value.item_id );
								if (goodspno4 == ""){
									goodspno4 = value.item_id;
								}else{
									goodspno4 += "," + value.item_id;
								}
								campaignId4 = data.campaignId;
								variationId4 = data.variationId;
							})
						}else if (data.campaignId === 275 && nowUrl.indexOf('/product/view') >= 0 && (depth1No == "2002") ){ //상세 키즈 장바구니팝업
							console.log(data);
							$.each(data.products, function(key,value){
								//console.log('key:' + key + ', ProductNo : ' + value.item_id );
								if (goodspno4 == ""){
									goodspno4 = value.item_id;
								}else{
									goodspno4 += "," + value.item_id;
								}
							})
						}else if (data.campaignId === 276 && nowUrl.indexOf('/product/view') >= 0 && (depth3No == "2017" || depth3No == "2023" || depth3No == "2033" ||  depth3No == "2043" ||  depth3No == "2051" ||  depth3No == "2061" ) ) { //상세 테니스 장바구니팝업
							console.log(data);
							$.each(data.products, function(key,value){
								//console.log('key:' + key + ', ProductNo : ' + value.item_id );
								if (goodspno4 == ""){
									goodspno4 = value.item_id;
								}else{
									goodspno4 += "," + value.item_id;
								}
								campaignId4 = data.campaignId;
								variationId4 = data.variationId;
							})	
						}else if (data.campaignId === 135 && nowUrl.indexOf('/main/kids') >= 0)	{	///검색
							/*
							console.log(data);
							$.each(data.products, function(key,value){
								//console.log('key:' + key + ', ProductNo : ' + value.item_id );
								if (goodspno3 == ""){
									goodspno3 = value.item_id;
								}else{
									goodspno3 += "," + value.item_id;
								}
							})

							tagID = "recopickProduct";
							mode = "MAINDIVCART"
							GetCartInsiderView(tagID,data.campaignId,data.variationId, goodspno3,mode)
							//clearInterval(timeInterval);
							*/
						}else{	///해당 페이지 안떴을 경우 있는거 아무거나
							//console.log(data.campaignId);
							/*
							$.each(data.products, function(key,value){
								//console.log('key:' + key + ', ProductNo : ' + value.item_id );
								if (goodspno3 == ""){
									goodspno3 = value.item_id;
								}else{
									goodspno3 += "," + value.item_id;
								}
							})

							tagID = "recopickProduct";
							mode = "MAINMOBILE"
							GetCartInsiderView(tagID,data.campaignId,data.variationId, goodspno3,mode)
							//clearInterval(timeInterval);
							*/
						}
						
						console.log(data.campaignId)
						console.log(222)
						if (goodspno3 != "" ){	
							GetCartInsiderView("headerProduct",data.campaignId,data.variationId, goodspno3,"HEADER");
							headerchk = 1
						}else{
							GetCartInsiderView("headerProduct","","", "","HEADER");
							headerchk = 1
						}
						if (campID == ""){
							campID = data.campaignId;
						}else{
							campID += "," + data.campaignId;
						}														
					});

			}, 400);






				/* 3초 동안 못 받아오면 처리 */
				setTimeout(() => {
					//alert(goodspno3 + goodspno4);
					nowUrl = location.href;

					if (goodspno3 == "" ){			
						tagID = "recopickProduct";
						mode = "MAINDIVCART"
						if ((nowUrl.indexOf("/main/kids") >= 0)) {
							campaignId = 244
						}
						else {
							if ((nowUrl.indexOf("/product/list") >= 0)) {
								
									campaignId = 122
								
							}else{
								campaignId = 122
							}
						}
						goodspno3 = "0"
						variationId = ""
						//console.log("");
						//GetCartInsiderView(tagID,campaignId, goodspno3,mode)
						GetCartInsiderView(tagID,campaignId,variationId, goodspno3,mode);
						if (headerchk == ""){
							GetCartInsiderView("headerProduct","","", "","HEADER");
						}
/*
							jQuery.ajax({
								type: "POST",
								data: "pno=&campID=" + campID,
								url: "/ext/insiderCheck.asp",
								dataType : "JSON",
								success: function(data) {
									//codetype = data.codetype;
								},
								error: function(e) {
									//alert("e");
								}
							});
*/							
					}	
				}, 5000);
		}else{	//지정 외 페이지에도 서치쪽 추천 상품은 나오게 해야함
			GetCartInsiderView("headerProduct","","", "","HEADER");
		}
</script>
<!-- 2024-04-01 insider E -->	

<div id="cartlog"></div>

<div id="addLayerDiv"></div> <!-- #HJ 2025-03-19 추가 -->

<!-- #HJ 2025-06-17 insider S -->

<script>
    window.insider_object = window.insider_object || {};
    window.insider_object.page = {
			"type": "Basket"
    }
</script>

<script>
    window.insider_object = window.insider_object || {};
    window.insider_object.user = {
			"uuid": "20251128145726285180",
			"gdpr_optin": true,			
			"gender": "F"
    }
</script>

<!-- #HJ 2025-06-17 insider E -->
<script>

$(function(){
	$("#todayCnt").html("0");
})

</script>
	</div>
    <!-- // end of :: wrap -->    
    
<!-- NAVER SCRIPT -->
<script type="text/javascript" src="//wcs.naver.net/wcslog.js"></script> 
<script type="text/javascript"> 
if (!wcs_add) var wcs_add={};
wcs_add["wa"] = "s_2dc7206136e";
if (!_nasa) var _nasa={};
_nasa["cnv"] = wcs.cnv("3","1"); 
wcs_do(_nasa);
</script>
<!-- NAVER SCRIPT END -->

<!-- #HJ 2018-04-30 AdVisor Facebook event script-->
<!-- 2023-09-01 Facebook Pixel Code 삭제 tagmanager에 존재함 -->
<!--AdVisor Facebook event script End-->

<!-- 2020-05-07 #HJ groobee 2020-08-31 교체 S 2020-09-23 ProductNo로 수정 -->

<!-- 2020-05-07 #HJ groobee E -->


<!-- Enliple Tracker Start -->
<script type="text/javascript">
var ENP_VAR = { conversion: { product: [] } };

// 주문한 각 제품들을 배열에 저장
ENP_VAR.conversion.product.push(

	
	);

	ENP_VAR.conversion.totalPrice = '';  // 없는 경우 단일 상품의 정보를 이용해 계산
	ENP_VAR.conversion.totalQty = '';  // 없는 경우 단일 상품의 정보를 이용해 계산
	ENP_VAR.conversion.siteCode = "a77f4c3cce5da84764222f25cdd9c40e";

	(function(a,g,e,n,t){a.enp=a.enp||function(){(a.enp.q=a.enp.q||[]).push(arguments)};n=g.createElement(e);n.async=!0;n.defer=!0;n.src="https://cdn.megadata.co.kr/dist/prod/enp_tracker_self_hosted.min.js";t=g.getElementsByTagName(e)[0];t.parentNode.insertBefore(n,t)})(window,document,"script");
</script>
<!-- Enliple Tracker End -->
    
    
</body>
</html>