<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.1, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi">

<title>FILA Header</title>
<style>
</style>
<link rel="icon" type="image/x-icon"
	href="//filacdn.styleship.com/filacontent2/favicon.ico" />
<link href="http://localhost/SIST_FILA/css/SpoqaHanSansNeo.css"
	rel="stylesheet">

<link rel="stylesheet"
	href="http://localhost/SIST_FILA/css/normalize.css">
<link rel="stylesheet"
	href="http://localhost/SIST_FILA/css/opt-default.css">
<link rel="stylesheet"
	href="http://localhost/SIST_FILA/css/swiper-bundle.css">

<link rel="stylesheet" href="http://localhost/SIST_FILA/css/layout.css">
<link rel="stylesheet" href="http://localhost/SIST_FILA/css/product.css">
<link rel="stylesheet" href="http://localhost/SIST_FILA/css/sub.css">

<script src="http://localhost/SIST_FILA/js/TweenMax.js"></script>
<script src="http://localhost/SIST_FILA/js/jquery-1.12.4.js"></script>
<script src="http://localhost/SIST_FILA/js/mighty.base.1.5.7.js"></script>
<script src="http://localhost/SIST_FILA/js/matizResizeMap.1.0.0.js"></script>
<script src="http://localhost/SIST_FILA/js/swiper-bundle.js"></script>

<style>

</style>
<script>
$(document).on('click', '.search-open__btn', function () {
	  $('body').addClass('search--open');

	  setTimeout(function () {
	    new Swiper('.goods__slider', {
	      slidesPerView: 'auto',
	      freeMode: true,
	      scrollbar: {
	        el: '.goods-slider-scrollbar',
	        draggable: true
	      }
	    });
	  }, 300);
	});

</script>
</head>
<body class="hd__style1 _style_main">


	<header id="header">
		<!-- logo -->
		<h1 class="logo">
			<a href="/main/main.asp">FILA</a>
		</h1>
		<!-- //logo -->

		<!-- gnb -->
		<nav class="gnb">
			<ul class="gnb">
				<c:forEach items="${list}" var="d1">
					<!-- ===== 1 DEPTH : FEMALE / MALE / KIDS ===== -->
					<c:if test="${d1.depth eq 1}">
						<li><a href="#">${d1.name}</a> <!-- ===== 2 DEPTH WRAP ===== -->
							<div class="depth2-box">
								<div class="inner">

									<!-- category menu -->
									<div class="category-menu-box">

										<c:forEach items="${list}" var="d2">
											<!-- ===== 2 DEPTH : 의류 / 신발 / 용품 ===== -->
											<c:if
												test="${d2.depth eq 2 && d2.parent_id eq d1.category_id}">
												<div class="category-group">

													<a href="/product/list.asp?depth=${d2.depth}"
														class="link-tit"> ${d2.name} </a>

													<!-- ===== 3 DEPTH ===== -->
													<div>
														<ul>
															<li><a href="/product/list.asp?no=${d2.category_id}">
																	전체보기 </a></li>

															<c:forEach items="${list}" var="d3">
																<c:if
																	test="${d3.depth eq 3 && d3.parent_id eq d2.category_id}">
																	<li><a
																		href="/product/list.asp?no=${d3.category_id}">
																			${d3.name} </a></li>
																</c:if>
															</c:forEach>
														</ul>
													</div>

												</div>
											</c:if>
										</c:forEach>

									</div>
									<!-- //category menu -->

								</div>
							</div> <!-- //2 DEPTH -->

							<div class="gnb-bg__wrap"></div></li>
					</c:if>
				</c:forEach>

			</ul>


		</nav>
		<!-- //gnb -->

		<!-- util -->
		<div class="util">
			<div class="util-store">
				<a href="#" class="store__btn">store</a>
			</div>

			<div class="util-search">
				<button type="button" class="search-open__btn">search</button>
				<form action="javascript:searchRun2();" name="searchForm2"
					method="get" autocomplete="off">
					<!-- search layer -->
					<div class="search__layer">

						<div class="head">
							<div class="search-category-box">
								<div>
									<button type="button" class="on searchCate searchs"
										onclick="searchsCate('');">전체</button>
									<!-- 활성화시 클래스 on -->
									<button type="button" class="searchCate searchs2001"
										onclick="searchsCate('2001');">WOMEN</button>
									<button type="button" class="searchCate searchs2000"
										onclick="searchsCate('2000');">MEN</button>
									<button type="button" class="searchCate searchs2002"
										onclick="searchsCate('2002');">KIDS</button>
								</div>
							</div>


							<div class="search-input-box">
								<div>
									<button type="button" class="close__btn"></button>

									<!--<input type="search" placeholder="검색어 입력" name="searchItem" id="searchItem2" value="" onfocus="this.value='';" >-->
									<input type="search" placeholder="검색어 입력" name="searchItem"
										id="searchItem2" value=""> <input type="hidden"
										name="searchsCateNo" id="searchsCateNo" value="">

									<button type="button" class="search__btn"
										onclick="javascript:searchRun2();void(0);">search</button>
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

										<button type="button" class="all-delete__btn"
											onclick="wordRemoveAll();">전체 기록 삭제</button>
									</div>

									<div>
										<ul class="latest__list" id="sWordHistory">
											<li class="no_search_list">최근 검색어가 없습니다.</li>
										</ul>

									</div>
								</div>
								<!-- //최근 검색어 -->


								<!-- 인기 검색어 js필요 -->
								<div class="keywords-box _popular">
									<div>
										<p class="tit">인기 검색어</p>

										<p class="update-txt">19:00 업데이트</p>
									</div>

									<div>
										<ul>

											<li><a
												href="/search/search_result.asp?sWord=%uD55C%uC18C%uD76C">한소희</a>
											</li>

											<li><a
												href="/search/search_result.asp?sWord=FS254RB01F002">FS254RB01F002</a>
											</li>

											<li><a
												href="/search/search_result.asp?sWord=%uBE0C%uB77C">브라</a></li>

											<li><a
												href="/search/search_result.asp?sWord=%uD32C%uD2F0">팬티</a></li>

											<li><a
												href="/search/search_result.asp?sWord=FS253OD03X014">FS253OD03X014</a>
											</li>

											<li><a
												href="/search/search_result.asp?sWord=%uC5D0%uC0E4%uD398">에샤페</a>
											</li>

											<li><a
												href="/search/search_result.asp?sWord=%uD55C%uC18C%uD76C">한소희</a>
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

											<li><a
												href="https://www.fila.co.kr/event/view.asp?seq=1269">차정원
													신발</a></li>

											<li><a
												href="https://www.fila.co.kr/event/view.asp?seq=1268">판테라
													LX</a></li>

											<li><a
												href="https://www.fila.co.kr/product/view.asp?ProductNo=60326">에픽런
													포니</a></li>

											<li><a
												href="https://www.fila.co.kr/product/view.asp?ProductNo=60294">리틀에샤페</a>
											</li>

											<li><a
												href="https://www.fila.co.kr/event/view.asp?seq=1233">피트니스</a>
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
										<div class="goods-scroll-box _type_v2 _gs00">
											<!-- 2024-08-05 클래스 추가 _type_v2 -->
											<div class="slider-box">
												<div
													class="goods__slider swiper swiper-initialized swiper-horizontal swiper-pointer-events swiper-free-mode">
													<div class="swiper-wrapper ins-preview-wrapper-"
														id="headerProduct" aria-live="polite">
														<div class="goods swiper-slide swiper-slide-active"
															data-val="1" role="group" aria-label="1 / 12">
															<div class="photo">
																<div class="before">
																	<a href="/product/view.asp?ProductNo=61373"
																		onclick="clickGroobeeProduct('','','61373')"> <img
																		src="//filacdn.styleship.com/filaproduct2/data/productimages/a/3/FS261OD03X009_613.jpg"
																		alt="">
																	</a>
																</div>
																<button type="button" class="wish__btn  wish"
																	data-wish="61373" wish="">wish</button>
																<!-- 활성화시 클래스 on -->

															</div>

															<div class="info">
																<a href="/product/view.asp?ProductNo=61373"
																	onclick="clickGroobeeProduct('','','61373')">
																	<div class="top">
																		<p class="category">공용</p>

																		<div class="tag"></div>
																	</div>

																	<p class="name">휠라 리트모 슬릭 버건디</p>
																	<div class="price">

																		<p class="sale">119,000원</p>

																	</div>
																</a>
															</div>
														</div>


														<div class="goods swiper-slide swiper-slide-next"
															data-val="1" role="group" aria-label="2 / 12">
															<div class="photo">
																<div class="before">
																	<a href="/product/view.asp?ProductNo=61311"
																		onclick="clickGroobeeProduct('','','61311')"> <img
																		src="//filacdn.styleship.com/filaproduct2/data/productimages/a/3/FS261OD03X087_219.jpg"
																		alt="">
																	</a>
																</div>
																<button type="button" class="wish__btn  wish"
																	data-wish="61311" wish="">wish</button>
																<!-- 활성화시 클래스 on -->

															</div>

															<div class="info">
																<a href="/product/view.asp?ProductNo=61311"
																	onclick="clickGroobeeProduct('','','61311')">
																	<div class="top">
																		<p class="category">공용</p>

																		<div class="tag"></div>
																	</div>

																	<p class="name">&lt;한소희 착용&gt; 휠라 에샤페 초코</p>
																	<div class="price">

																		<p class="sale">119,000원</p>

																	</div>
																</a>
															</div>
														</div>


														<div class="goods swiper-slide" data-val="1" role="group"
															aria-label="3 / 12">
															<div class="photo">
																<div class="before">
																	<a href="/product/view.asp?ProductNo=61276"
																		onclick="clickGroobeeProduct('','','61276')"> <img
																		src="//filacdn.styleship.com/filaproduct2/data/productimages/a/3/FS254BT03X007_031.jpg"
																		alt="">
																	</a>
																</div>
																<button type="button" class="wish__btn  wish"
																	data-wish="61276" wish="">wish</button>
																<!-- 활성화시 클래스 on -->

															</div>

															<div class="info">
																<a href="/product/view.asp?ProductNo=61276"
																	onclick="clickGroobeeProduct('','','61276')">
																	<div class="top">
																		<p class="category">여성</p>

																		<div class="tag"></div>
																	</div>

																	<p class="name">푸퍼 볼드 부츠</p>
																	<div class="price">

																		<p class="sale">70,000원</p>
																		<p class="normal _sale">99,900원</p>
																		<p class="percent">30% 할인</p>

																	</div>
																</a>
															</div>
														</div>


														<div class="goods swiper-slide" data-val="1" role="group"
															aria-label="4 / 12">
															<div class="photo">
																<div class="before">
																	<a href="/product/view.asp?ProductNo=59490"
																		onclick="clickGroobeeProduct('','','59490')"> <img
																		src="//filacdn.styleship.com/filaproduct2/data/productimages/a/3/1RM02723H_050.jpg"
																		alt="">
																	</a>
																</div>
																<button type="button" class="wish__btn  wish"
																	data-wish="59490" wish="">wish</button>
																<!-- 활성화시 클래스 on -->

															</div>

															<div class="info">
																<a href="/product/view.asp?ProductNo=59490"
																	onclick="clickGroobeeProduct('','','59490')">
																	<div class="top">
																		<p class="category">공용</p>

																		<div class="tag"></div>
																	</div>

																	<p class="name">인터레이션 v2</p>
																	<div class="price">

																		<p class="sale">89,000원</p>

																	</div>
																</a>
															</div>
														</div>


														<div class="goods swiper-slide" data-val="1" role="group"
															aria-label="5 / 12">
															<div class="photo">
																<div class="before">
																	<a href="/product/view.asp?ProductNo=61269"
																		onclick="clickGroobeeProduct('','','61269')"> <img
																		src="//filacdn.styleship.com/filaproduct2/data/productimages/a/3/FS261RU03X076_217.jpg"
																		alt="">
																	</a>
																</div>
																<button type="button" class="wish__btn  wish"
																	data-wish="61269" wish="">wish</button>
																<!-- 활성화시 클래스 on -->

															</div>

															<div class="info">
																<a href="/product/view.asp?ProductNo=61269"
																	onclick="clickGroobeeProduct('','','61269')">
																	<div class="top">
																		<p class="category">공용</p>

																		<div class="tag"></div>
																	</div>

																	<p class="name">판테라 99/25 LX</p>
																	<div class="price">

																		<p class="sale">129,000원</p>

																	</div>
																</a>
															</div>
														</div>


														<div class="goods swiper-slide" data-val="1" role="group"
															aria-label="6 / 12">
															<div class="photo">
																<div class="before">
																	<a href="/product/view.asp?ProductNo=61371"
																		onclick="clickGroobeeProduct('','','61371')"> <img
																		src="//filacdn.styleship.com/filaproduct2/data/productimages/a/3/FS261OD03X008_734.jpg"
																		alt="">
																	</a>
																</div>
																<button type="button" class="wish__btn  wish"
																	data-wish="61371" wish="">wish</button>
																<!-- 활성화시 클래스 on -->

															</div>

															<div class="info">
																<a href="/product/view.asp?ProductNo=61371"
																	onclick="clickGroobeeProduct('','','61371')">
																	<div class="top">
																		<p class="category">공용</p>

																		<div class="tag"></div>
																	</div>

																	<p class="name">휠라 리트모 슬릭 LX 옐로우</p>
																	<div class="price">

																		<p class="sale">129,000원</p>

																	</div>
																</a>
															</div>
														</div>


														<div class="goods swiper-slide" data-val="1" role="group"
															aria-label="7 / 12">
															<div class="photo">
																<div class="before">
																	<a href="/product/view.asp?ProductNo=60554"
																		onclick="clickGroobeeProduct('','','60554')"> <img
																		src="//filacdn.styleship.com/filaproduct2/data/productimages/a/3/FS253OD03X012_260.jpg"
																		alt="">
																	</a>
																</div>
																<button type="button" class="wish__btn  wish"
																	data-wish="60554" wish="">wish</button>
																<!-- 활성화시 클래스 on -->

															</div>

															<div class="info">
																<a href="/product/view.asp?ProductNo=60554"
																	onclick="clickGroobeeProduct('','','60554')">
																	<div class="top">
																		<p class="category">공용</p>

																		<div class="tag"></div>
																	</div>

																	<p class="name">휠라 에샤페 모카</p>
																	<div class="price">

																		<p class="sale">119,000원</p>

																	</div>
																</a>
															</div>
														</div>


														<div class="goods swiper-slide" data-val="1" role="group"
															aria-label="8 / 12">
															<div class="photo">
																<div class="before">
																	<a href="/product/view.asp?ProductNo=54340"
																		onclick="clickGroobeeProduct('','','54340')"> <img
																		src="//filacdn.styleship.com/filaproduct2/data/productimages/a/3/1RM02752G_023.jpg"
																		alt="">
																	</a>
																</div>
																<button type="button" class="wish__btn  wish"
																	data-wish="54340" wish="">wish</button>
																<!-- 활성화시 클래스 on -->

															</div>

															<div class="info">
																<a href="/product/view.asp?ProductNo=54340"
																	onclick="clickGroobeeProduct('','','54340')">
																	<div class="top">
																		<p class="category">공용</p>

																		<div class="tag"></div>
																	</div>

																	<p class="name">레플리카 2002</p>
																	<div class="price">

																		<p class="sale">139,000원</p>

																	</div>
																</a>
															</div>
														</div>


														<div class="goods swiper-slide" data-val="1" role="group"
															aria-label="9 / 12">
															<div class="photo">
																<div class="before">
																	<a href="/product/view.asp?ProductNo=61370"
																		onclick="clickGroobeeProduct('','','61370')"> <img
																		src="//filacdn.styleship.com/filaproduct2/data/productimages/a/3/FS261OD03X008_370.jpg"
																		alt="">
																	</a>
																</div>
																<button type="button" class="wish__btn  wish"
																	data-wish="61370" wish="">wish</button>
																<!-- 활성화시 클래스 on -->

															</div>

															<div class="info">
																<a href="/product/view.asp?ProductNo=61370"
																	onclick="clickGroobeeProduct('','','61370')">
																	<div class="top">
																		<p class="category">공용</p>

																		<div class="tag"></div>
																	</div>

																	<p class="name">휠라 리트모 슬릭 LX 말차</p>
																	<div class="price">

																		<p class="sale">129,000원</p>

																	</div>
																</a>
															</div>
														</div>


														<div class="goods swiper-slide" data-val="1" role="group"
															aria-label="10 / 12">
															<div class="photo">
																<div class="before">
																	<a href="/product/view.asp?ProductNo=58606"
																		onclick="clickGroobeeProduct('','','58606')"> <img
																		src="//filacdn.styleship.com/filaproduct2/data/productimages/a/3/1RM02486H_100.jpg"
																		alt="">
																	</a>
																</div>
																<button type="button" class="wish__btn  wish"
																	data-wish="58606" wish="">wish</button>
																<!-- 활성화시 클래스 on -->

																<!-- tag -->
																<!--div class="tag-box">
											<div>
												<img src="/pc/resource/images/_temp/tag_product_list_01.png" alt="">
											</div>
										</div-->
																<!-- //tag -->

															</div>

															<div class="info">
																<a href="/product/view.asp?ProductNo=58606"
																	onclick="clickGroobeeProduct('','','58606')">
																	<div class="top">
																		<p class="category">공용</p>

																		<div class="tag"></div>
																	</div>

																	<p class="name">휠라 레인저 22</p>
																	<div class="price">

																		<p class="sale">69,000원</p>

																	</div>
																</a>
															</div>
														</div>


														<div class="goods swiper-slide" data-val="1" role="group"
															aria-label="11 / 12">
															<div class="photo">
																<div class="before">
																	<a href="/product/view.asp?ProductNo=61102"
																		onclick="clickGroobeeProduct('','','61102')"> <img
																		src="//filacdn.styleship.com/filaproduct2/data/productimages/a/3/FS254BT03X001_100.jpg"
																		alt="">
																	</a>
																</div>
																<button type="button" class="wish__btn  wish"
																	data-wish="61102" wish="">wish</button>
																<!-- 활성화시 클래스 on -->

															</div>

															<div class="info">
																<a href="/product/view.asp?ProductNo=61102"
																	onclick="clickGroobeeProduct('','','61102')">
																	<div class="top">
																		<p class="category">공용</p>

																		<div class="tag"></div>
																	</div>

																	<p class="name">푸퍼 멜로우</p>
																	<div class="price">

																		<p class="sale">49,000원</p>
																		<p class="normal _sale">69,900원</p>
																		<p class="percent">30% 할인</p>

																	</div>
																</a>
															</div>
														</div>


														<div class="goods swiper-slide" data-val="1" role="group"
															aria-label="12 / 12">
															<div class="photo">
																<div class="before">
																	<a href="/product/view.asp?ProductNo=59685"
																		onclick="clickGroobeeProduct('','','59685')"> <img
																		src="//filacdn.styleship.com/filaproduct2/data/productimages/a/3/1RM02958H_103.jpg"
																		alt="">
																	</a>
																</div>
																<button type="button" class="wish__btn  wish"
																	data-wish="59685" wish="">wish</button>
																<!-- 활성화시 클래스 on -->

															</div>

															<div class="info">
																<a href="/product/view.asp?ProductNo=59685"
																	onclick="clickGroobeeProduct('','','59685')">
																	<div class="top">
																		<p class="category">공용</p>

																		<div class="tag"></div>
																	</div>

																	<p class="name">프론토 v2</p>
																	<div class="price">

																		<p class="sale">99,000원</p>

																	</div>
																</a>
															</div>
														</div>

													</div>
													<span class="swiper-notification" aria-live="assertive"
														aria-atomic="true"></span>
												</div>

												<div
													class="goods-slider-scrollbar swiper-scrollbar-horizontal"
													style="">
													<div class="swiper-scrollbar-drag"
														style="transform: translate3d(0px, 0px, 0px); width: 199.819px;"></div>
												</div>
											</div>
										</div>
									</div>
								</div>
								<!-- //추천 상품 -->
							</div>
						</div>

					</div>
				</form>

				<div class="search-bg__wrap"></div>
				<!-- //search layer -->

			</div>

			<div class="util-account">
				<button type="button" class="account__btn"
					onclick="location.href='/member/login.asp'">account</button>

				<!-- account layer -->
				<div class="account__layer">
					<div class="inner">

						<div class="account-menu-box">
							<ul>
								<li id="globalMenu1"><a href="/member/login.asp">로그인</a></li>

								<li id="globalMenu2"><a href="/member/join_intro.asp">회원가입</a></li>

								<li id="globalMenu3"><a href="/member/searchIDPW.asp">아이디
										· 비밀번호 찾기</a></li>
								<li id="globalMenu7" style="display: none;">&nbsp;</li>
								<li id="globalMenu4"></li>
								<li id="globalMenu5" style="display: none;">&nbsp;</li>
								<li id="globalMenu8"><a href="/specialoffer/list.asp">이벤트</a></li>
							</ul>
							<button type="button" class="logout__btn" id="globalMenu6"
								onclick="location.href='/member/logout.asp';"
								style="display: none;">로그아웃</button>
						</div>


						<!-- //로그인 후 -->
					</div>
				</div>
				<!-- //account layer -->
			</div>

			<div class="util-cart">
				<button type="button" class="cart__btn" data-num="0" id="cart_cnt"
					onclick="location.href='/order/cart.asp';" rel="nosublink">cart</button>
			</div>
		</div>
		<!-- //util -->
	</header>





</body>
</html>