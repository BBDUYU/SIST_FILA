<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
    pageEncoding="UTF-8"%>
<html class="no-js" lang="ko-KR"><!--<![endif]--><head>

<%
    // [가짜 데이터 생성 - DB 연결 전 테스트용]
    // 나중에는 Controller에서 이 구조(List<Map>)대로 데이터를 넘겨주면 됩니다.
    java.util.List<java.util.Map<String, Object>> productList = new java.util.ArrayList<>();
    
    // 더미 데이터 8개 생성 (DB의 PRODUCTS + PRODUCT_IMAGE 테이블 조인 결과 흉내)
    for(int i=1; i<=8; i++) {
        java.util.Map<String, Object> item = new java.util.HashMap<>();
        
        // 1. PRODUCTS 테이블 컬럼 매칭
        item.put("PRODUCT_ID", "FS20250220-" + String.format("%03d", i)); // VARCHAR2 타입 반영
        item.put("NAME", "휠라 에센셜 다운 자켓 V" + i);
        item.put("PRICE", 159000 + (i * 1000)); // 정가
        item.put("DISCOUNT_RATE", (i % 2 == 0) ? 20 : 0); // 짝수만 20% 할인 (NUMBER 타입)
        item.put("STATUS", "ON_SALE"); 
        
        // 2. PRODUCT_IMAGE 테이블 매칭 (IS_MAIN = 1 인 것)
        item.put("IMAGE_URL", "//filacdn.styleship.com/filaproduct2/data/productimages/a/1/FS261FT01X001_234.jpg");
        
        productList.add(item);
    }
    
    pageContext.setAttribute("productList", productList);
%>

<!-- End Google Tag Manager -->
<!-- #HJ 2020-05-27 Google optimize 2022-04-28 제거함 -->

	<meta charset="UTF-8">
	<meta name="format-detection" content="telephone=no">

<title>의류 | FILA</title>

<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.1, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.1, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi">

<link rel="icon" type="image/x-icon" href="//filacdn.styleship.com/filacontent2/favicon.ico" />

<link rel="stylesheet" href="http://localhost/SIST_FILA/css/layout.css">
<link rel="stylesheet" href="http://localhost/SIST_FILA/css/normalize.css" />
<link rel="stylesheet" href="http://localhost/SIST_FILA/css/opt-default.css" >
<link rel="stylesheet" href="http://localhost/SIST_FILA/css/product.css">
<link rel="stylesheet" href="http://localhost/SIST_FILA/css/SpoqaHanSansNeo.css">
<link rel="stylesheet" href="http://localhost/SIST_FILA/css/sub.css">
<link rel="stylesheet" href="http://localhost/SIST_FILA/css/swiper-bundle.css">

<script src="http://localhost/SIST_FILA/js/default.js"></script>
<script src="http://localhost/SIST_FILA/js/jquery-1.12.4.js"></script>
<script src="http://localhost/SIST_FILA/js/matizResizeMap.1.0.0.js"></script>
<script src="http://localhost/SIST_FILA/js/mighty.base.1.5.7.js"></script>
<script src="http://localhost/SIST_FILA/js/swiper-bundle.js"></script>
<script src="http://localhost/SIST_FILA/js/TweenMax.js"></script>

<body class="list filter--open">
<!-- 체크박스 누르면 '초기화' 버튼 나오는 UI기능 -->
<!-- 나중에 필터기능 만들때 추가 -->
<!-- 
<script>
//필터 초기화 버튼 노출관련
$(document).ready(function() {
	$("input:checkbox").on('click', function() {
		  if ($("input:checkbox:checked").length == 0){
			  $("#resetB").hide();
		  }else{
			  $("#resetB").show();
		  }
    });
  if ($("input:checkbox:checked").length == 0){
	  $("#resetB").hide();
  }else{
	  $("#resetB").show();
  }
});
</script>
 -->
	<!-- start of :: wrap -->
	<div id="wrap">
		<!-- header include -->
		<jsp:include page="header.jsp" />
		
		<section class="goods-list-box _thumb04">
                <h2 class="hidden">상품 리스트</h2>
                
                <div class="head">
                    <div class="tit-box"><p class="tit">WOMEN<b>&gt;</b><e>의류</e></p></div>
                    <div class="sorting-box">
                        <div><button type="button" class="filter__btn">필터</button></div>
                        <div>
                            <select><option>신상품순</option><option>낮은가격순</option></select>
                        </div>
                    </div>
                </div>

                <div class="con">
                    <div class="filter-box">
                        <div class="category-box">
                            <ul><li class="on"><a href="#">전체</a></li><li><a href="#">아우터</a></li></ul>
                        </div>
                    </div>

                    <div class="list-box">
                        <ul class="goods__list _type_v2" id="product_list">
                            
                            <c:forEach var="item" items="${productList}">
                                <c:set var="finalPrice" value="${item.PRICE * (100 - item.DISCOUNT_RATE) / 100}" />
                                
                                <li class="goods">
                                    <div class="photo">
                                        <a href="product_detail.jsp?product_id=${item.PRODUCT_ID}">
                                            <img src="${item.IMAGE_URL}" alt="${item.NAME}">
                                        </a>
                                        <button type="button" class="wish__btn wish" onclick="alert('관심상품 추가!')">wish</button>
                                    </div>

                                    <div class="info">
                                        <a href="product_detail.jsp?product_id=${item.PRODUCT_ID}">
                                            <div class="top">
                                                <p class="category">FILA</p>
                                                <div class="tag">
                                                    <c:if test="${item.DISCOUNT_RATE > 0}">
                                                        <p style="color:#cf0a2c; font-weight:bold;">SALE</p>
                                                    </c:if>
                                                </div>
                                            </div>

                                            <p class="name">${item.NAME}</p>

                                            <div class="price">
                                                <c:choose>
                                                    <c:when test="${item.DISCOUNT_RATE > 0}">
                                                        <p class="sale"><fmt:formatNumber value="${finalPrice}" pattern="#,###" />원</p>
                                                        <p class="normal _sale"><fmt:formatNumber value="${item.PRICE}" pattern="#,###" />원</p>
                                                        <p class="percent">${item.DISCOUNT_RATE}%</p>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <p class="sale"><fmt:formatNumber value="${item.PRICE}" pattern="#,###" />원</p>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </a>
                                    </div>
                                </li>
                            </c:forEach>

                        </ul>
                        
                        <div class="paging-box">
                            <div class="paging-num"><a href="#" class="pg on">1</a></div>
                        </div>
                    </div>
                </div>
            </section>
		
			
			<!-- 추천 상품 -->
			<section class="goods-scroll-box _type_v2 _gs01">
                <div class="hd">
                    <h2>고객님을 위한 추천 상품</h2>
                </div>

                <div class="slider-box">
                    <div class="goods__slider swiper">
                        <div class="swiper-wrapper">
                            <c:forEach var="item" items="${productList}">
                                <div class="goods swiper-slide">
                                    <div class="photo">
                                        <div class="before">
                                            <a href="product_detail.jsp?product_id=${item.PRODUCT_ID}">
                                                <img src="${item.IMAGE_URL}" alt="${item.NAME}">
                                            </a>
                                        </div>
                                    </div>

                                    <div class="info">
                                        <a href="product_detail.jsp?product_id=${item.PRODUCT_ID}">
                                            <div class="top"><p class="category">공용</p></div>
                                            <p class="name">${item.NAME}</p>
                                            <div class="price">
                                                <p class="sale"><fmt:formatNumber value="${item.PRICE}" pattern="#,###" />원</p>
                                            </div>
                                        </a>
                                        <button type="button" class="wish__btn wish" onclick="alert('관심상품')">wish</button>
                                    </div>
                                    
                                    <button type="button" class="cart__btn btn_sld__gr" onclick="alert('장바구니 담기')">장바구니 담기</button>
                                </div>
                            </c:forEach>
                        </div>
                        <div class="goods-slider-scrollbar swiper-scrollbar-horizontal"></div>
                    </div>
                </div>              
            </section>
			<!-- //추천 상품 -->

			<!-- //2024-08-05 상품 리스트 리뉴얼 -->

		</div>
		<!-- // end of :: contents -->



		<!-- 하단 고정 버튼 (top, sns) -->
<div class="bot-fix-box"> <div class="inner">

		<button type="button" class="today-goods__btn" onclick="alert('오늘 본 상품 기능은 나중에!')">
			<svg id="btn_time" xmlns="http://www.w3.org/2000/svg" width="29" height="29" viewBox="0 0 29 29">
			  <g id="icon" transform="translate(-0.025 -0.025)">
				<path id="패스_706" data-name="패스 706" d="M17.05,24.66A14,14,0,1,0,19.5,9.572l.253-3.648" transform="translate(-15.29 -4.475)" fill="none" stroke="#707070" stroke-linecap="round" stroke-linejoin="round" stroke-width="1"></path>
				<path id="패스_707" data-name="패스 707" d="M6.537,83.1a14.542,14.542,0,0,0-.3,12.37" transform="translate(-4.475 -75.062)" fill="none" stroke="#707070" stroke-linecap="round" stroke-linejoin="round" stroke-width="1" stroke-dasharray="40 40"></path>
				<path id="패스_708" data-name="패스 708" d="M114.512,80.167v6.806l-3.662,3.662" transform="translate(-99.914 -72.362)" fill="none" stroke="#707070" stroke-linecap="round" stroke-linejoin="round" stroke-width="2"></path>
				<line id="선_542" data-name="선 542" x1="3.654" transform="translate(4.307 5.263)" fill="none" stroke="#707070" stroke-linecap="round" stroke-linejoin="round" stroke-width="1"></line>
			  </g>
			</svg>
		</button>

        <button type="button" class="top__btn" onclick="window.scrollTo({top:0, behavior:'smooth'})">top</button>		
	</div>
</div>
<!-- //하단 고정 버튼 (top, sns) -->


<!-- start of :: footer -->
<jsp:include page="footer.jsp" />
<!-- // end of :: footer -->

</div>
</body>
</html>