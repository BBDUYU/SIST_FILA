<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="wishlist.WishlistDAO" %>
<%@ page import="wishlist.WishlistDTO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.DecimalFormat" %>

<%@ page import="member.MyPageDAO" %>
<%@ page import="member.MyPageDTO" %>

<%
    // [테스트용] 로그인 시뮬레이션 (10001번 김철수)
    // 실제 로그인 기능 구현 후에는 이 if문 블록을 지우세요.
    if (session.getAttribute("userNumber") == null) {
        session.setAttribute("userNumber", 10001);
        session.setAttribute("userName", "김철수");
        session.setAttribute("userGrade", "SILVER");
    }

    // 1. 로그인 체크
    Integer userNumber = (Integer)session.getAttribute("userNumber");
    if (userNumber == null) {
%>
        <script>
            alert("로그인이 필요한 서비스입니다.");
            location.href = "login.jsp"; // 로그인 페이지로 이동
        </script>
<%
        return;
    }

    // 2. 위시리스트 데이터 가져오기
    WishlistDAO dao = new WishlistDAO();
    List<WishlistDTO> wishList = dao.getWishlist(userNumber);

    pageContext.setAttribute("wishList", wishList);
    pageContext.setAttribute("wishCount", wishList.size());
    
 	// 3. 마이페이지 상단 정보 가져오기 (쿠폰, 포인트 등)
    member.MyPageDAO myPageDao = new member.MyPageDAO();
    member.MyPageDTO myPageDto = myPageDao.getMyPageSummary(userNumber);
    
    pageContext.setAttribute("myPage", myPageDto);
    
 	// 숫자 포맷터 (3자리마다 콤마)
    DecimalFormat df = new DecimalFormat("#,###");
%>

<!DOCTYPE html>
<html class="no-js" lang="ko-KR">
<head>

	<meta charset="UTF-8">
	<meta name="format-detection" content="telephone=no">

<title>위시리스트 | FILA</title>

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

<!-- 개별 css, js -->
<script src="https://www.fila.co.kr/pc/resource/js/pages/mypage.js"></script>
<script>
        // 개별 삭제
        function deleteWish(wishId) {
            if(confirm("정말 삭제하시겠습니까?")) {
                // TODO: 나중에 실제 삭제 페이지로 연결
                alert("삭제 기능: wishlist_delete.jsp?wish_id=" + wishId);
            }
        }

        // 장바구니 담기
        function addToCart(productId) {
            if(confirm("장바구니에 담으시겠습니까?")) {
                // TODO: 나중에 실제 장바구니 페이지로 연결
                alert("장바구니 기능: cart_add.jsp?product_id=" + productId);
            }
        }

        // 선택 삭제 (체크박스)
        function deleteSelected() {
            var checked = $("input[name=checkwish]:checked");
            if(checked.length == 0) {
                alert("삭제할 상품을 선택해주세요.");
                return;
            }
            if(confirm("선택한 " + checked.length + "개 상품을 삭제하시겠습니까?")) {
                alert("선택 삭제 기능 실행");
            }
        }

        // 전체 선택 체크박스
        $(document).ready(function(){     
            $("#checkAll").click(function(){
                $("input[name=checkwish]").prop("checked", $("#checkAll").prop("checked"));
            });
        });
    </script>

</head>
<body class="">
	<!-- start of :: wrap -->
	<div id="wrap">
		<!-- header include -->
		<jsp:include page="header.jsp" />
		
		<!-- start of :: contents -->
		<div id="contents" class="mypage__contents">

			<div class="mypage__tab">
				<div class="inner">
					<!-- 회원등급, 회원정보 -->
					<div class="my-info-box">
						<div class="top">
							<p class="level">WHITE</p>
							<a href="#" class="benefit__btn">혜택보기</a>
						</div>
						<p class="name">
							<span>${sessionScope.userName}</span>님
						</p>
						<a href="#" class="info-modify__btn">내 정보 변경</a>

					</div>
					<!-- 쿠폰, 포인트, 위시리스트, 주문내역 -->
					<div class="my-link-box">
                        <div><a href="#"><dl><dt>쿠폰</dt><dd><%= df.format(myPageDto.getCouponCount()) %>개</dd></dl></a></div>
                        <div><a href="#"><dl><dt>포인트</dt><dd><%= df.format(myPageDto.getPointBalance()) %>P</dd></dl></a></div>
                        <div><a href="wishlist.jsp"><dl><dt>위시리스트</dt><dd><%= df.format(myPageDto.getWishlistCount()) %>개</dd></dl></a></div>
                        <div><a href="#"><dl><dt>주문내역</dt><dd><%= df.format(myPageDto.getOrderCount()) %>건</dd></dl></a></div>
                    </div>
				</div>
			</div>



			<div class="mypage__area">

				<div class="my-lnb">
           			<h2 class="tit__style4">마이페이지</h2>
					<div>
						<p class="tit">쇼핑정보</p>
						<ul>
							<li><a href="#">주문 · 배송 조회</a></li>
                            <li><a href="#">교환 · 취소 · 반품 조회</a></li>
                            <li><a href="#">리뷰</a></li>
						</ul>
					</div>
					<div>
						<p class="tit">상품정보</p>
						<ul>
							<li  class='on'><a href="wishlist.jsp" >위시리스트</a> </li>
							<li ><a href="#">오늘 본 상품</a></li>
							<li ><a href="#">커스텀 스튜디오</a></li>
							<li ><a href="#">재입고 알림</a></li>
						</ul>
					</div>
					<div>
						<p class="tit">회원정보</p>
						<ul>
							<li><a href="#" class="#">내 정보 변경</a></li>
							<li ><a href="#">배송지 관리</a></li>
							<li ><a href="#">로그인 관리</a></li>
						</ul>
					</div>
					<div>
						<p class="tit">고객센터</p>
						<ul>
							<li ><a href="#">1:1 문의</a></li>
							<li ><a href="#">A/S 현황 조회</a></li>
						</ul>
					</div>
				</div>

				<section class="my-con wishlist">
           			<h2 class="tit__style4">위시리스트<span style="font-size:14px; color:#999;">(<%= wishList.size() %>)</span></h2>

					<div class="odr-box">
                        <div class="odr-hd">
                            <div>
                                <input type="checkbox" id="checkAll" title="상품 선택" class="cb__style1" />
                                <label for="checkAll">선택</label>
                            </div> 
                            <div class="txt-btn">
                                <a href="javascript:void(0);" onclick="deleteSelected()">선택삭제</a>
                            </div>
							
						</div>
						<ul class="odr__list __my_chk">
						<%
                            // 자바 코드로 리스트 반복 출력 (JSTL 사용 X)
                            if (wishList == null || wishList.isEmpty()) {
                        %>
                            <c:choose>
                                <c:when test="${empty wishList}">
                                    <li style="text-align: center; padding: 50px 0;">
                                        위시리스트에 담긴 상품이 없습니다.
                                    </li>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach var="dto" items="${wishList}">
                                        <li>
                                            <div class="_soldout">
                                                <input type="checkbox" id="checkwish${dto.wishlist_id}" name="checkwish" value="${dto.wishlist_id}" class="cb__style1" />
                                                <label for="checkwish${dto.wishlist_id}">선택</label>
                                            </div>
                                            
                                            <div class="goods-thumb">
                                                <a href="product_detail.jsp?product_id=${dto.product_id}">
                                                    <img src="${dto.image_url}" alt="${dto.name}">
                                                </a>
                                            </div>
                                            
                                            <div class="goods-info">
                                                <p class="sex">FILA</p>
                                                
                                                <p class="tit">
                                                    <a href="product_detail.jsp?product_id=${dto.product_id}" style="color:#000;">${dto.name}</a>
                                                </p>
                                                
                                                <p class="info" style="color:#999; font-size:13px; text-transform: uppercase;">
                                                    ${dto.color_options != null ? dto.color_options : '옵션 없음'}
                                                </p>
                                                
                                                <p class="price">
                                                    <c:choose>
                                                        <c:when test="${dto.discount_rate > 0}">
                                                            <%-- 할인가 계산 --%>
                                                            <c:set var="salePrice" value="${dto.price * (100 - dto.discount_rate) / 100}" />
                                                            
                                                            <span class="sale" style="font-weight:bold;">
                                                                <fmt:formatNumber value="${salePrice}" pattern="#,###" />원
                                                            </span>
                                                            
                                                            <span class="normal" style="text-decoration:line-through; color:#aaa; margin-left:5px;">
                                                                <fmt:formatNumber value="${dto.price}" pattern="#,###" />원
                                                            </span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="sale" style="font-weight:bold;">
                                                                <fmt:formatNumber value="${dto.price}" pattern="#,###" />원
                                                            </span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </p>
                                            </div>
                                            
                                            <div class="goods-etc">
                                                <p class="ico">
                                                    <a href="#" style="font-size:13px; color:#666; text-decoration:underline;">리뷰보기</a>
                                                    
                                                    <button type="button" class="del" onclick="deleteWish('${dto.wishlist_id}')" style="margin-left:10px;">삭제</button>
                                                </p>
                                            </div>
                                        </li>
                                    </c:forEach>
                                </c:otherwise>
                            </c:choose>
                        </ul>
				</form>
					</div>	
				</section>
			</div>

		</div>

		<!-- // end of :: contents -->

		<!-- 하단 고정 버튼 (top, sns) -->
<div class="bot-fix-box">
	<div class="inner">

		<!-- 2023-12-13 오늘 본 상품 있는 경우 (상품 썸네일 변경) -->
		<button type="button" class="today-goods__thumb today-goods__btn">
			<img src="//filacdn.styleship.com/filaproduct2/data/productimages/a/1/FS254DJ01F001_561.jpg" alt="">
		</button>
		<!-- // 2023-12-13 오늘 본 상품 있는 경우 (상품 썸네일 변경) -->

		<button type="button" class="top__btn" onclick="window.scrollTo(0,0);">top</button>		
	</div>
</div>
<!-- //하단 고정 버튼 (top, sns) -->

<!-- footer clude -->
<jsp:include page="footer.jsp" />



	</div>
    <!-- // end of :: wrap -->  
    
    <script>
        window.addEventListener("pageshow", function(event) {
            if (event.persisted || (window.performance && window.performance.navigation.type === 2)) {
                window.location.reload();
            }
        });
    </script>
      
</body>
</html>