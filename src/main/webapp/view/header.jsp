<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

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
<script src="${pageContext.request.contextPath}/js/default.js"></script>

<script>
	jQuery(window.document).ready(function(){
		jQuery(window.document).on("contextmenu", function(event){return false;});
	});  
</script>
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
$(document).on('click', '.cancel__btn', function () {
    $('body').removeClass('search--open');
});
</script>
<script src="${pageContext.request.contextPath}/js/main.js"></script>
</head>

<body class="hd__style1 _style_main">
<script>
document.addEventListener('DOMContentLoaded', () => {
	  const body = document.body;

	  // 이벤트 위임: #header nav 내부의 li에 마우스 enter/leave 시 동작
	  document.querySelector('#header nav').addEventListener('mouseover', (e) => {
	    if(e.target.closest('li')) body.classList.add('_bg_on');
	  });

	  document.querySelector('#header nav').addEventListener('mouseout', (e) => {
	    if(e.target.closest('li')) body.classList.remove('_bg_on');
	  });
	});

  </script>

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
															<li><a href="/SIST_FILA/view/product/list.jsp?no=${d2.category_id}">
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
				<form action="#" name="searchForm2"
					method="get" autocomplete="off" onsubmit="searchRun2(); return false;">
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
							
							        <input type="search" placeholder="검색어 입력" name="searchItem" id="searchItem2" value="">
							        <input type="hidden" name="searchsCateNo" id="searchsCateNo" value="">
							
							        <button type="button" class="search__btn" onclick="searchRun2();">search</button>
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
										<%
										    // 쿠키에서 recentSearch 가져오기
										    String recentSearch = "";
										    javax.servlet.http.Cookie[] cookies = request.getCookies();
										    if (cookies != null) {
										        for (javax.servlet.http.Cookie c : cookies) {
										            if ("recentSearch".equals(c.getName())) {
										                recentSearch = java.net.URLDecoder.decode(c.getValue(), "UTF-8");
										                break;
										            }
										        }
										    }
										    // request scope에 저장해서 JSTL에서 사용
										    request.setAttribute("recentSearch", recentSearch);
										%>
									
									<ul class="latest__list" id="sWordHistory">
									    <c:choose>
									        <c:when test="${not empty recentSearch}">
									            <c:forEach var="word" items="${fn:split(recentSearch, ',')}">
									                <li data-sword="${word}">
									                    <a href="/search/search_result.asp?sWord=${fn:escapeXml(word)}">${word}</a>
									                    <button type="button" class="delete__btn sWordRemove btn_remove">delete</button>
									                </li>
									            </c:forEach>
									        </c:when>
									        <c:otherwise>
									            <li class="no_search_list">최근 검색어가 없습니다.</li>
									        </c:otherwise>
									    </c:choose>
									</ul>									
									</div>
								</div>
								<!-- //최근 검색어 -->


								<!-- 인기 검색어 js필요 -->
								<div class="keywords-box _popular">
									<div>
										<p class="tit">인기 검색어</p>
										<!-- <p class="update-txt">19:00 업데이트</p> -->
									</div>

									<div> 
										<ul>
											<c:choose>
								                <c:when test="${not empty popularKeywords}">
								                    <c:forEach var="sDto" items="${popularKeywords}">
								                        <li>
								                            <%-- 검색 결과 페이지 주소에 맞게 수정하세요 --%>
								                            <a href="/SIST_FILA/view/main.mm?searchItem=${fn:escapeXml(sDto.keyword)}">
								                                ${sDto.keyword}
								                            </a>
								                        </li>
								                    </c:forEach>
								                </c:when>
								                <c:otherwise>
								                    <li>검색 기록이 없습니다.</li>
								                </c:otherwise>
								            </c:choose>
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
								            <c:choose>
								                <c:when test="${not empty recommendKeywords}">
								                    <c:forEach var="rDto" items="${recommendKeywords}">
								                        <li>
								                            <c:choose>
								                                <%-- 1. 상품 ID가 있으면 상품 상세 페이지로 --%>
								                                <c:when test="${not empty rDto.product_id}">
								                                    <a href="/SIST_FILA/view/productDetail.mm?product_id=${rDto.product_id}">
								                                        ${rDto.name}
								                                    </a>
								                                </c:when>
								                                
								                                <%-- 2. 슬러그가 있으면 이벤트 페이지로 (이벤트 이름 출력) --%>
								                                <c:when test="${not empty rDto.slug}">
								                                    <a href="/SIST_FILA/view/eventView.mm?slug=${rDto.slug}">
								                                        ${rDto.event_name}
								                                    </a>
								                                </c:when>
								                            </c:choose>
								                        </li>
								                    </c:forEach>
								                </c:when>
								                <c:otherwise>
								                    <%-- 데이터가 없을 경우 기본 표시 --%>
								                    <li>추천 검색어가 없습니다.</li>
								                </c:otherwise>
								            </c:choose>
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
														<!-- 반복 -->
														<c:choose>
													    <c:when test="${not empty recommendProducts}">
													        <c:forEach var="pDto" items="${recommendProducts}" varStatus="status">
													            <%-- 각 상품 슬라이드 --%>
													            <div class="goods swiper-slide" data-val="${status.count}" role="group" aria-label="${status.count} / 12">
													                <div class="photo">
													                    <div class="before">
													                        <%-- 상품 상세 페이지 이동 --%>
													                        <a href="/SIST_FILA/view/productDetail.mm?product_id=${pDto.product_id}">
													                            <%-- 이미지 경로는 프로젝트의 이미지 저장 규칙에 맞게 수정하세요 --%>
													                            <img src="/SIST_FILA/images/products/${pDto.product_id}.jpg" alt="${pDto.name}">
													                        </a>
													                    </div>
													                </div>
													
													                <div class="info">
													                    <a href="/SIST_FILA/view/productDetail.mm?product_id=${pDto.product_id}">
													                        <div class="top">
													                            <%-- 카테고리나 태그 데이터가 DTO에 있다면 활용 가능 --%>
													                            <p class="category">RECOMMEND</p>
													                            <div class="tag">
													                                <c:if test="${pDto.discount_rate > 0}">
													                                    <span class="sale-tag">${pDto.discount_rate}%</span>
													                                </c:if>
													                            </div>
													                        </div>
													
													                        <p class="name">${pDto.name}</p>
													                        
													                        <div class="price">
													                            <c:choose>
													                                <c:when test="${pDto.discount_rate > 0}">
													                                    <%-- 할인이 있는 경우 계산 로직 (정수 처리) --%>
													                                    <p class="sale">
													                                        <fmt:formatNumber value="${pDto.price * (1 - pDto.discount_rate/100)}" type="number" />원
													                                    </p>
													                                    <p class="origin" style="text-decoration: line-through; color: #999; font-size: 0.9em;">
													                                        <fmt:formatNumber value="${pDto.price}" type="number" />원
													                                    </p>
													                                </c:when>
													                                <c:otherwise>
													                                    <%-- 할인이 없는 경우 --%>
													                                    <p class="sale">
													                                        <fmt:formatNumber value="${pDto.price}" type="number" />원
													                                    </p>
													                                </c:otherwise>
													                            </c:choose>
													                        </div>
													                    </a>
													                </div>
													            </div>
													        </c:forEach>
													    </c:when>
													    <c:otherwise>
													        <div class="swiper-slide">추천 상품이 없습니다.</div>
													    </c:otherwise>
													</c:choose>


												
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

<script>
function searchRun2() {
    const searchInput = document.getElementById("searchItem2");
    const searchItem = searchInput ? searchInput.value.trim() : "";
    const cateNo = document.getElementById("searchsCateNo").value || "";

    if (!searchItem) {
        alert("검색어를 입력해주세요.");
        return false;
    }

    // 1. 쿠키 저장 (가장 먼저 실행)
    try {
        let name = "recentSearch";
        let recent = getCookie(name) || "";
        let list = recent ? recent.split(",") : [];

        // 중복 제거 및 최신순 정렬
        list = list.filter(item => item !== searchItem);
        list.unshift(searchItem);
        if (list.length > 5) list.pop();

        // 쿠키 쓰기
        const d = new Date();
        d.setTime(d.getTime() + (7 * 24 * 60 * 60 * 1000));
        document.cookie = name + "=" + encodeURIComponent(list.join(",")) + ";path=/;expires=" + d.toUTCString();
        console.log("쿠키 저장 완료:", document.cookie);
    } catch (e) {
        console.error("쿠키 저장 중 에러:", e);
    }

    const cp = "/SIST_FILA"; 
    const recordUrl = cp + "/record.ss?keyword=" + encodeURIComponent(searchItem);
    const moveUrl = cp + "/view/main.mm?searchItem=" + encodeURIComponent(searchItem) + "&searchsCateNo=" + encodeURIComponent(cateNo);

    // 3. 서버 기록 및 이동
    // fetch가 안 될 상황을 대비해 0.5초 뒤에는 무조건 이동하게 처리
    let moved = false;
    const timer = setTimeout(() => {
        if(!moved) {
            moved = true;
            location.href = moveUrl;
        }
    }, 500);

    fetch(recordUrl)
        .then(() => {
            if(!moved) {
                moved = true;
                clearTimeout(timer);
                location.href = moveUrl;
            }
        })
        .catch(err => {
            console.error("서버 기록 실패:", err);
            location.href = moveUrl;
        });

    return false; // form 제출 방지
}

// 단순화된 쿠키 가져오기
function getCookie(name) {
    const value = "; " + document.cookie;
    const parts = value.split("; " + name + "=");
    if (parts.length === 2) return decodeURIComponent(parts.pop().split(";").shift());
    return "";
}
</script>




</body>
</html>