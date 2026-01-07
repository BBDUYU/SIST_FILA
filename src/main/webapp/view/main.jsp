<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<title>FILA 메인</title>
</head>
<body class="hd__style1 _style_main">
	<jsp:include page="common/header.jsp" />

	<div id="wrap">


		<div id="contents" class="main__contents">


			<!-- 상단 슬라이드 -->
			<section class="main-slider-box _main_slider">
				<h2 class="hidden">상단 슬라이드</h2>

				<div
					class="main__slider swiper swiper-initialized swiper-horizontal swiper-pointer-events">

					<%-- 바깥쪽 div 하나만 남기고 합칩니다. id나 style은 Swiper가 실행되면서 자동으로 붙여주니 클래스명만 잘 적으시면 됩니다. --%>
					<div class="swiper-wrapper">
						<c:forEach var="dto" items="${bannerList}" varStatus="status"
							end="7">
							<c:set var="isVideo" value="${fn:endsWith(dto.imageUrl, '.mp4')}" />

							<div class="swiper-slide ${isVideo ? '_type_vdo' : ''}">
								<a
									href="<%=request.getContextPath()%>/event.htm?eventId=1"
									target="_self">
									<div class="vdo-box">
										<c:choose>
											<c:when test="${isVideo}">
												<video autoplay muted loop playsinline>
													<source
														src="${pageContext.request.contextPath}${dto.imageUrl}"
														type="video/mp4">
												</video>
											</c:when>
											<c:otherwise>
												<img src="${pageContext.request.contextPath}${dto.imageUrl}"
													alt="${dto.bannerName}">
											</c:otherwise>
										</c:choose>
									</div>

									<div class="txt-box _type_wt">
										<p class="tit">${dto.bannerName}</p>
										<p class="more">자세히 보기</p>
									</div>
								</a>
							</div>

						</c:forEach>
					</div>
					<span class="swiper-notification" aria-live="assertive"
						aria-atomic="true"></span>
				</div>

				<div class="scroll-bar-box _type_arrows">
					<!--<div class="main-slider-scrollbar"></div>-->
					<div
						class="main-slider-pagination swiper-pagination-clickable swiper-pagination-bullets swiper-pagination-horizontal"
						data-total-num="0" data-curr-num="1">
						<span
							class="swiper-pagination-bullet swiper-pagination-bullet-active"
							tabindex="0" role="button" aria-label="Go to slide 1"
							aria-current="true"></span><span class="swiper-pagination-bullet"
							tabindex="0" role="button" aria-label="Go to slide 2"></span><span
							class="swiper-pagination-bullet" tabindex="0" role="button"
							aria-label="Go to slide 3"></span><span
							class="swiper-pagination-bullet" tabindex="0" role="button"
							aria-label="Go to slide 4"></span><span
							class="swiper-pagination-bullet" tabindex="0" role="button"
							aria-label="Go to slide 5"></span><span
							class="swiper-pagination-bullet" tabindex="0" role="button"
							aria-label="Go to slide 6"></span><span
							class="swiper-pagination-bullet" tabindex="0" role="button"
							aria-label="Go to slide 7"></span><span
							class="swiper-pagination-bullet" tabindex="0" role="button"
							aria-label="Go to slide 8"></span>
					</div>
					<div class="pagination-curr-bar">
						<div style="width: 12.5%; left: 0%;"></div>
					</div>

					<div class="arrow-box">
						<button type="button" class="prev__btn" tabindex="0"
							aria-label="Previous slide"
							aria-controls="swiper-wrapper-2b66d35d4a56af48">prev</button>
						<button type="button" class="next__btn" tabindex="0"
							aria-label="Next slide"
							aria-controls="swiper-wrapper-2b66d35d4a56af48">next</button>
					</div>
				</div>
			</section>
			<!-- //상단 슬라이드 -->

			<script>
				function mainGroup(num) {
					var formStr = "";
					randNo = Math.floor((Math.random() * (999999 - 1 + 1)) + 1);
					jQuery
							.ajax({
								type : "POST",
								data : "num=" + num + "&random=" + randNo,
								url : "/pc/main/main_group.asp",
								dataType : "HTML",
								success : function(data) {
									formStr = data;
									jQuery(".groupBtn").removeClass("on");
									jQuery(".q" + num + "p").addClass("on");
									jQuery("#groupList").hide().empty()
											.fadeIn().append(data);

									setTimeout(
											function() {
												try {
													var mySwiper = document
															.querySelector('.goods__slider').swiper;
													mySwiper.slideTo(0, 0,
															false);
												} catch (e) {
												}
											}, 100);
								},
								error : function(e) {
									//alert("e");
								}
							});
				}
			</script>

			<!-- 상품 리스트 스크롤 -->
			<section class="goods-scroll-box _gs01">
			    <h2>지금 많이 찾는 상품</h2>
			
			    <div class="category-btn-box">
			        <%-- 활성화된 태그 목록을 순회하며 버튼 생성 --%>
			        <c:forEach var="tag" items="${activeTags}" varStatus="status">
			            <button type="button" 
			                    class="groupBtn q${tag.category_id}p ${status.first ? 'on' : ''}"
			                    onclick="mainGroup(${tag.category_id}, this);">
			                # ${tag.name}
			            </button>
			        </c:forEach>
			    </div>
			
			    <script>
			        <%-- 페이지 로드 시 첫 번째 태그의 상품을 자동으로 불러옴 --%>
			        <c:if test="${not empty activeTags}">
			            window.onload = function() {
			                mainGroup(${activeTags[0].category_id}, document.querySelector('.groupBtn.on'));
			            };
			        </c:if>
			    </script>
			
			    <div class="slider-box">
			        <div class="goods__slider swiper">
			            <%-- AJAX 데이터가 들어갈 공간 --%>
			            <div class="swiper-wrapper" id="groupList">
			                <%-- 여기에 자바스크립트로 생성한 HTML이 삽입됩니다 --%>
			            </div>
			        </div>
			    </div>
			</section>
<script>
function mainGroup(tagId, element) {
    console.log("mainGroup 실행 - tagId:", tagId);

    if (element) {
        var buttons = document.querySelectorAll('.groupBtn');
        for (var i = 0; i < buttons.length; i++) buttons[i].classList.remove('on');
        element.classList.add('on');
    }

    var contextPath = "/SIST_FILA";
    var url = contextPath + "/mainGroupAjax.htm?tagId=" + tagId;

    fetch(url)
        .then(function(res) { return res.json(); })
        .then(function(data) {
            var listWrapper = document.getElementById('groupList');
            var swiperContainer = document.querySelector('.goods__slider');
            
            // 슬라이더 초기화
            if (swiperContainer && swiperContainer.swiper) {
                swiperContainer.swiper.destroy(true, true);
            }
            listWrapper.innerHTML = ""; 

            if (!data || data.length === 0) {
                listWrapper.innerHTML = '<div style="width:100%; text-align:center; padding:50px;">상품이 없습니다.</div>';
                return;
            }

            var html = "";
            for (var i = 0; i < data.length; i++) {
                var prod = data[i];
                var id = prod.product_id;
                var name = prod.name;
                var price = (prod.price || 0).toLocaleString() + "원";
                var category = prod.category_name || "공용";

                // --- [이미지 주소 처리 핵심] ---
                var imgPath = prod.image_url || "";
                // 1. 이미 서블릿 주소가 붙어있다면 진짜 경로만 추출
                if (imgPath.includes("path=")) imgPath = imgPath.split("path=").pop();
                // 2. 톰캣 차단 방지를 위해 C: 제거
                imgPath = imgPath.replace("C:", "");
                // 3. 최종 서블릿 호출 주소
                var finalUrl = contextPath + "/displayImage.do?path=" + imgPath;

                // --- [필라 오리지널 레이아웃 구조] ---
                html += '<div class="goods swiper-slide">'
                     + '  <div class="photo">'
                     + '    <div class="before">'
                     + '      <a href="productView.htm?id=' + id + '">'
                     + '        <img src="' + finalUrl + '" alt="' + name + '">'
                     + '      </a>'
                     + '    </div>'
                     + '  </div>'
                     + '  <div class="info">'
                     + '    <a href="productView.htm?id=' + id + '">'
                     + '      <div class="top">'
                     + '        <p class="category">' + category + '</p>'
                     + '        <div class="tag">'
                     + '          <p>라이프스타일</p>'
                     + '          <p>SEMI-OVER핏</p>'
                     + '        </div>'
                     + '      </div>'
                     + '      <p class="name">' + name + '</p>'
                     + '      <div class="price">'
                     + '        <p class="sale">' + price + '</p>'
                     + '      </div>'
                     + '    </a>'
                     + '    <button type="button" class="wish__btn wish" data-wish="' + id + '">wish</button>'
                     + '  </div>'
                     + '</div>';
            }

            listWrapper.innerHTML = html;

            // Swiper 재시작
            setTimeout(function() {
                goodsSlider = new Swiper('.goods__slider', {
                    slidesPerView: 'auto',
                    freeMode: true,
                    spaceBetween: 10,
                    observer: true,
                    observeParents: true
                });
            }, 50);
        })
        .catch(function(err) { console.error("에러:", err); });
}
</script>	
			<!-- //상품 리스트 스크롤 -->

			<!-- banner -->
			<section class="main-banner-box _v2">
				<!--2023-09-05 _v2(기획전 타이틀 추가)-->
				<div class="hd">
					<h2 class="">기획전</h2>
				</div>

				<div
					class="banner__slider swiper swiper-initialized swiper-horizontal swiper-pointer-events swiper-free-mode swiper-backface-hidden">
					<ul class="swiper-wrapper" id="swiper-wrapper-954e101059cac3699"
						aria-live="polite" style="transform: translate3d(0px, 0px, 0px);">

						<li class="swiper-slide swiper-slide-active" role="group"
							aria-label="1 / 5" style="margin-right: 40px;">
							<div class="photo">
								<a href="http://www.fila.co.kr/event/view.asp?seq=1289 "
									target="_self"> <img
									src="//filacdn.styleship.com/filacontent2/data/banner/main_middle_Wfitness_251023_28.jpg"
									alt="">
								</a>
							</div>

							<div class="info">
								<p class="tit">Her Winter Ritual</p>
								<p class="txt">그녀의 루틴에서 시작되는 겨울 피트니스 무드</p>


								<div class="btn-box">
									<a href="http://www.fila.co.kr/event/view.asp?seq=1289 "
										target="_self">자세히 보기</a>

								</div>

							</div>
						</li>

						<li class="swiper-slide swiper-slide-next" role="group"
							aria-label="2 / 5" style="margin-right: 40px;">
							<div class="photo">
								<a href="https://www.fila.co.kr/event/view.asp?seq=1290"
									target="_self"> <img
									src="//filacdn.styleship.com/filacontent2/data/banner/img_middle_puffer_d_251024_96.jpg"
									alt="">
								</a>
							</div>

							<div class="info">
								<p class="tit">The Puffer Bag Sundae</p>
								<p class="txt">나만의 취향으로 선택하는 푸퍼백 컬렉션</p>


								<div class="btn-box">
									<a href="https://www.fila.co.kr/event/view.asp?seq=1290"
										target="_self"> 자세히 보기</a>

								</div>

							</div>
						</li>

						<li class="swiper-slide" role="group" aria-label="3 / 5"
							style="margin-right: 40px;">
							<div class="photo">
								<a href="http://www.fila.co.kr/event/view.asp?seq=1280"
									target="_self"> <img
									src="//filacdn.styleship.com/filacontent2/data/banner/main_800x800_M_83.jpg"
									alt="">
								</a>
							</div>

							<div class="info">
								<p class="tit">Get Ready with Fila</p>
								<p class="txt">일상의 모든 순간을 함께할 에센셜 아이템을 소개합니다.</p>


								<div class="btn-box">
									<a href="http://www.fila.co.kr/event/view.asp?seq=1280"
										target="_self">자세히 보기</a>

								</div>

							</div>
						</li>

						<li class="swiper-slide" role="group" aria-label="4 / 5"
							style="margin-right: 40px;">
							<div class="photo">
								<a href="https://www.fila.co.kr/event/view.asp?seq=1264"
									target="_self"> <img
									src="//filacdn.styleship.com/filacontent2/data/banner/main_800x800_M_25_2.jpg"
									alt="">
								</a>
							</div>

							<div class="info">
								<p class="tit">2025 FILA MATCH</p>
								<p class="txt">AI로 복원한 그들의 리즈 시절의 대결</p>


								<div class="btn-box">
									<a href="https://www.fila.co.kr/event/view.asp?seq=1264"
										target="_self"> 자세히 보기</a>

								</div>

							</div>
						</li>

						<li class="swiper-slide" role="group" aria-label="5 / 5"
							style="margin-right: 40px;">
							<div class="photo">
								<a href="https://www.fila.co.kr/event/view.asp?seq=1236"
									target="_self"> <img
									src="//filacdn.styleship.com/filacontent2/data/banner/main_800x800_M_40.jpg"
									alt="">
								</a>
							</div>

							<div class="info">
								<p class="tit">AXILUS 3 T9</p>
								<p class="txt">최강의 안정감, 최고의 퍼포먼스</p>


								<div class="btn-box">
									<a href="https://www.fila.co.kr/event/view.asp?seq=1236"
										target="_self"> 자세히 보기</a>

								</div>

							</div>
						</li>

					</ul>
					<span class="swiper-notification" aria-live="assertive"
						aria-atomic="true"></span>
				</div>
			</section>
			<!-- //banner -->

			<!-- 추천 스타일 -->


			<section class="goods-scroll-box _v2 _gs02">
				<div class="hd">
					<h2>추천 스타일</h2>
					<a href="/product/style.asp" class="more-btn">더보기</a>
				</div>

				<div class="slider-box">
					<div
						class="goods__slider swiper swiper-initialized swiper-horizontal swiper-pointer-events swiper-free-mode swiper-backface-hidden">
						<div class="swiper-wrapper" id="swiper-wrapper-5a1f2f11410f67bea"
							aria-live="polite"
							style="transform: translate3d(0px, 0px, 0px); transition-duration: 0ms;">

							<div class="goods swiper-slide swiper-slide-active" role="group"
								aria-label="1 / 8">
								<div class="photo">
									<div class="before">
										<a href="/product/style.asp?cno=101&amp;codiNo=279"> <img
											src="//filacdn.styleship.com/filacontent2/data/codi/리사이징_0001_[보이앤드] 휠라 _ 2차 활용 이미지 원본 _ 김양희 (9)_10.jpg"
											alt="">
										</a>
									</div>
								</div>
							</div>


							<div class="goods swiper-slide swiper-slide-next" role="group"
								aria-label="2 / 8">
								<div class="photo">
									<div class="before">
										<a href="/product/style.asp?cno=101&amp;codiNo=276"> <img
											src="//filacdn.styleship.com/filacontent2/data/codi/1_30.jpg"
											alt="">
										</a>
									</div>
								</div>
							</div>


							<div class="goods swiper-slide" role="group" aria-label="3 / 8">
								<div class="photo">
									<div class="before">
										<a href="/product/style.asp?cno=101&amp;codiNo=275"> <img
											src="//filacdn.styleship.com/filacontent2/data/codi/7_57.jpg"
											alt="">
										</a>
									</div>
								</div>
							</div>


							<div class="goods swiper-slide" role="group" aria-label="4 / 8">
								<div class="photo">
									<div class="before">
										<a href="/product/style.asp?cno=101&amp;codiNo=274"> <img
											src="//filacdn.styleship.com/filacontent2/data/codi/7_66.jpg"
											alt="">
										</a>
									</div>
								</div>
							</div>


							<div class="goods swiper-slide" role="group" aria-label="5 / 8">
								<div class="photo">
									<div class="before">
										<a href="/product/style.asp?cno=101&amp;codiNo=278"> <img
											src="//filacdn.styleship.com/filacontent2/data/codi/4_31.jpg"
											alt="">
										</a>
									</div>
								</div>
							</div>


							<div class="goods swiper-slide" role="group" aria-label="6 / 8">
								<div class="photo">
									<div class="before">
										<a href="/product/style.asp?cno=101&amp;codiNo=277"> <img
											src="//filacdn.styleship.com/filacontent2/data/codi/3_72.jpg"
											alt="">
										</a>
									</div>
								</div>
							</div>


							<div class="goods swiper-slide" role="group" aria-label="7 / 8">
								<div class="photo">
									<div class="before">
										<a href="/product/style.asp?cno=101&amp;codiNo=273"> <img
											src="//filacdn.styleship.com/filacontent2/data/codi/1_67.jpg"
											alt="">
										</a>
									</div>
								</div>
							</div>


							<div class="goods swiper-slide" role="group" aria-label="8 / 8">
								<div class="photo">
									<div class="before">
										<a href="/product/style.asp?cno=101&amp;codiNo=272"> <img
											src="//filacdn.styleship.com/filacontent2/data/codi/2_55_1.jpg"
											alt="">
										</a>
									</div>
								</div>
							</div>



						</div>
						<span class="swiper-notification" aria-live="assertive"
							aria-atomic="true"></span>
					</div>
				</div>
			</section>

			<!-- //추천 스타일 -->

			<!-- 추천 상품 -->
			<section class="goods-scroll-box _gs03">
				<div class="hd">
					<h2>고객님을 위한 추천 상품</h2>
				</div>

				<div class="slider-box">
					<div
						class="goods__slider swiper swiper-initialized swiper-horizontal swiper-pointer-events swiper-free-mode">
						<div class="swiper-wrapper ins-preview-wrapper-178"
							id="recopickProduct" aria-live="polite"
							style="transform: translate3d(0px, 0px, 0px); transition-duration: 0ms;">
							<div class="goods swiper-slide swiper-slide-active" data-val="1"
								role="group" aria-label="1 / 12">
								<div class="photo">
									<div class="before">
										<a href="/product/view.asp?ProductNo=61381"
											onclick="clickGroobeeProduct('','113','61381')"> <img
											src="//filacdn.styleship.com/filaproduct2/data/productimages/a/3/FS261TN03X006_260.jpg"
											alt="">
										</a>
									</div>


								</div>

								<div class="info">
									<a href="/product/view.asp?ProductNo=61381"
										onclick="clickGroobeeProduct('','113','61381')">
										<div class="top">
											<p class="category">공용</p>

											<div class="tag"></div>
										</div>

										<p class="name">휠라 룰즈 모카신 LX</p>

										<div class="price">

											<p class="sale">99,900원</p>

										</div>
									</a>

									<button type="button" class="wish__btn  wish" data-wish="61381"
										wish="">wish</button>
									<!-- 활성화시 클래스 on -->
								</div>

								<button type="button" class="cart__btn btn_sld__gr"
									onclick="location.href='${pageContext.request.contextPath}/pay/cart.htm'">장바구니 담기</button>

							</div>

							<div class="goods swiper-slide swiper-slide-next" data-val="1"
								role="group" aria-label="2 / 12">
								<div class="photo">
									<div class="before">
										<a href="/product/view.asp?ProductNo=61382"
											onclick="clickGroobeeProduct('','113','61382')"> <img
											src="//filacdn.styleship.com/filaproduct2/data/productimages/a/3/FS261TN03X006_820.jpg"
											alt="">
										</a>
									</div>


								</div>

								<div class="info">
									<a href="/product/view.asp?ProductNo=61382"
										onclick="clickGroobeeProduct('','113','61382')">
										<div class="top">
											<p class="category">공용</p>

											<div class="tag"></div>
										</div>

										<p class="name">휠라 룰즈 모카신 LX</p>

										<div class="price">

											<p class="sale">99,900원</p>

										</div>
									</a>

									<button type="button" class="wish__btn  wish" data-wish="61382"
										wish="">wish</button>
									<!-- 활성화시 클래스 on -->
								</div>

								<button type="button" class="cart__btn btn_sld__gr"
									onclick="location.href='${pageContext.request.contextPath}/pay/cart.htm'">장바구니 담기</button>

							</div>

							<div class="goods swiper-slide" data-val="1" role="group"
								aria-label="3 / 12">
								<div class="photo">
									<div class="before">
										<a href="/product/view.asp?ProductNo=61369"
											onclick="clickGroobeeProduct('','113','61369')"> <img
											src="//filacdn.styleship.com/filaproduct2/data/productimages/a/3/FS261OD03X008_001.jpg"
											alt="">
										</a>
									</div>


								</div>

								<div class="info">
									<a href="/product/view.asp?ProductNo=61369"
										onclick="clickGroobeeProduct('','113','61369')">
										<div class="top">
											<p class="category">공용</p>

											<div class="tag"></div>
										</div>

										<p class="name">휠라 리트모 슬릭 LX</p>

										<div class="price">

											<p class="sale">129,000원</p>

										</div>
									</a>

									<button type="button" class="wish__btn  wish" data-wish="61369"
										wish="">wish</button>
									<!-- 활성화시 클래스 on -->
								</div>

								<button type="button" class="cart__btn btn_sld__gr"
									onclick="location.href='${pageContext.request.contextPath}/pay/cart.htm'">장바구니 담기</button>

							</div>

							<div class="goods swiper-slide" data-val="1" role="group"
								aria-label="4 / 12">
								<div class="photo">
									<div class="before">
										<a href="/product/view.asp?ProductNo=60825"
											onclick="clickGroobeeProduct('','113','60825')"> <img
											src="//filacdn.styleship.com/filaproduct2/data/productimages/a/3/FS253RU03X019_370.jpg"
											alt="">
										</a>
									</div>


								</div>

								<div class="info">
									<a href="/product/view.asp?ProductNo=60825"
										onclick="clickGroobeeProduct('','113','60825')">
										<div class="top">
											<p class="category">공용</p>

											<div class="tag"></div>
										</div>

										<p class="name">하레핀 98/25 GTX</p>

										<div class="price">

											<p class="sale">219,000원</p>

										</div>
									</a>

									<button type="button" class="wish__btn  wish" data-wish="60825"
										wish="">wish</button>
									<!-- 활성화시 클래스 on -->
								</div>

								<button type="button" class="cart__btn btn_sld__gr"
									onclick="location.href='${pageContext.request.contextPath}/pay/cart.htm'">장바구니 담기</button>

							</div>

							<div class="goods swiper-slide" data-val="1" role="group"
								aria-label="5 / 12">
								<div class="photo">
									<div class="before">
										<a href="/product/view.asp?ProductNo=61371"
											onclick="clickGroobeeProduct('','113','61371')"> <img
											src="//filacdn.styleship.com/filaproduct2/data/productimages/a/3/FS261OD03X008_734.jpg"
											alt="">
										</a>
									</div>


								</div>

								<div class="info">
									<a href="/product/view.asp?ProductNo=61371"
										onclick="clickGroobeeProduct('','113','61371')">
										<div class="top">
											<p class="category">공용</p>

											<div class="tag"></div>
										</div>

										<p class="name">휠라 리트모 슬릭 LX</p>

										<div class="price">

											<p class="sale">129,000원</p>

										</div>
									</a>

									<button type="button" class="wish__btn  wish" data-wish="61371"
										wish="">wish</button>
									<!-- 활성화시 클래스 on -->
								</div>

								<button type="button" class="cart__btn btn_sld__gr"
									onclick="location.href='${pageContext.request.contextPath}/pay/cart.htm'">장바구니 담기</button>

							</div>

							<div class="goods swiper-slide" data-val="1" role="group"
								aria-label="6 / 12">
								<div class="photo">
									<div class="before">
										<a href="/product/view.asp?ProductNo=61105"
											onclick="clickGroobeeProduct('','113','61105')"> <img
											src="//filacdn.styleship.com/filaproduct2/data/productimages/a/3/FS254BT03X005_217.jpg"
											alt="">
										</a>
									</div>


								</div>

								<div class="info">
									<a href="/product/view.asp?ProductNo=61105"
										onclick="clickGroobeeProduct('','113','61105')">
										<div class="top">
											<p class="category">공용</p>

											<div class="tag"></div>
										</div>

										<p class="name">푸퍼 맥스</p>

										<div class="price">

											<p class="sale">97,000원</p>
											<p class="normal _sale">139,000원</p>
											<p class="percent">30% 할인</p>

										</div>
									</a>

									<button type="button" class="wish__btn  wish" data-wish="61105"
										wish="">wish</button>
									<!-- 활성화시 클래스 on -->
								</div>

								<button type="button" class="cart__btn btn_sld__gr"
									onclick="wish_Cart_action('61105');void(0);">장바구니 담기</button>

							</div>

							<div class="goods swiper-slide" data-val="1" role="group"
								aria-label="7 / 12">
								<div class="photo">
									<div class="before">
										<a href="/product/view.asp?ProductNo=61370"
											onclick="clickGroobeeProduct('','113','61370')"> <img
											src="//filacdn.styleship.com/filaproduct2/data/productimages/a/3/FS261OD03X008_370.jpg"
											alt="">
										</a>
									</div>


								</div>

								<div class="info">
									<a href="/product/view.asp?ProductNo=61370"
										onclick="clickGroobeeProduct('','113','61370')">
										<div class="top">
											<p class="category">공용</p>

											<div class="tag"></div>
										</div>

										<p class="name">휠라 리트모 슬릭 LX</p>

										<div class="price">

											<p class="sale">129,000원</p>

										</div>
									</a>

									<button type="button" class="wish__btn  wish" data-wish="61370"
										wish="">wish</button>
									<!-- 활성화시 클래스 on -->
								</div>

								<button type="button" class="cart__btn btn_sld__gr"
									onclick="wish_Cart_action('61370');void(0);">장바구니 담기</button>

							</div>

							<div class="goods swiper-slide" data-val="1" role="group"
								aria-label="8 / 12">
								<div class="photo">
									<div class="before">
										<a href="/product/view.asp?ProductNo=61274"
											onclick="clickGroobeeProduct('','113','61274')"> <img
											src="//filacdn.styleship.com/filaproduct2/data/productimages/a/3/FS254BT03X006_260.jpg"
											alt="">
										</a>
									</div>


								</div>

								<div class="info">
									<a href="/product/view.asp?ProductNo=61274"
										onclick="clickGroobeeProduct('','113','61274')">
										<div class="top">
											<p class="category">공용</p>

											<div class="tag"></div>
										</div>

										<p class="name">푸퍼 볼드 뮬</p>

										<div class="price">

											<p class="sale">49,000원</p>
											<p class="normal _sale">69,900원</p>
											<p class="percent">30% 할인</p>

										</div>
									</a>

									<button type="button" class="wish__btn  wish" data-wish="61274"
										wish="">wish</button>
									<!-- 활성화시 클래스 on -->
								</div>

								<button type="button" class="cart__btn btn_sld__gr"
									onclick="wish_Cart_action('61274');void(0);">장바구니 담기</button>

							</div>

							<div class="goods swiper-slide" data-val="1" role="group"
								aria-label="9 / 12">
								<div class="photo">
									<div class="before">
										<a href="/product/view.asp?ProductNo=58432"
											onclick="clickGroobeeProduct('','113','58432')"> <img
											src="//filacdn.styleship.com/filaproduct2/data/productimages/a/3/1RM02946H_010.jpg"
											alt="">
										</a>
									</div>


								</div>

								<div class="info">
									<a href="/product/view.asp?ProductNo=58432"
										onclick="clickGroobeeProduct('','113','58432')">
										<div class="top">
											<p class="category">공용</p>

											<div class="tag"></div>
										</div>

										<p class="name">판테라 실버</p>

										<div class="price">

											<p class="sale">109,000원</p>

										</div>
									</a>

									<button type="button" class="wish__btn  wish" data-wish="58432"
										wish="">wish</button>
									<!-- 활성화시 클래스 on -->
								</div>

								<button type="button" class="cart__btn btn_sld__gr"
									onclick="wish_Cart_action('58432');void(0);">장바구니 담기</button>

							</div>

							<div class="goods swiper-slide" data-val="1" role="group"
								aria-label="10 / 12">
								<div class="photo">
									<div class="before">
										<a href="/product/view.asp?ProductNo=61127"
											onclick="clickGroobeeProduct('','113','61127')"> <img
											src="//filacdn.styleship.com/filaproduct2/data/productimages/a/3/FS254DJ01F002_217.jpg"
											alt="">
										</a>
									</div>


								</div>

								<div class="info">
									<a href="/product/view.asp?ProductNo=61127"
										onclick="clickGroobeeProduct('','113','61127')">
										<div class="top">
											<p class="category">여성</p>

											<div class="tag">

												<!--p>라이프스타일</p-->

												<!--p>SEMI-OVER핏</p-->

												<p>SEMI-OVER핏</p>

												<p>라이프스타일</p>

											</div>
										</div>

										<p class="name">&lt;고현정 착용&gt; 플로우 후드 다운 코코아</p>

										<div class="price">

											<p class="sale">279,000원</p>

										</div>
									</a>

									<button type="button" class="wish__btn  wish" data-wish="61127"
										wish="">wish</button>
									<!-- 활성화시 클래스 on -->
								</div>

								<button type="button" class="cart__btn btn_sld__gr"
									onclick="wish_Cart_action('61127');void(0);">장바구니 담기</button>

							</div>

							<div class="goods swiper-slide" data-val="1" role="group"
								aria-label="11 / 12">
								<div class="photo">
									<div class="before">
										<a href="/product/view.asp?ProductNo=61144"
											onclick="clickGroobeeProduct('','113','61144')"> <img
											src="//filacdn.styleship.com/filaproduct2/data/productimages/a/3/FS254DJ01X002_234.jpg"
											alt="">
										</a>
									</div>


								</div>

								<div class="info">
									<a href="/product/view.asp?ProductNo=61144"
										onclick="clickGroobeeProduct('','113','61144')">
										<div class="top">
											<p class="category">공용</p>

											<div class="tag">

												<!--p>라이프스타일</p-->

												<!--p>SEMI-OVER핏</p-->

												<p>SEMI-OVER핏</p>

												<p>라이프스타일</p>

											</div>
										</div>

										<p class="name">&lt;봉태규 착용&gt; 플로우 다운 초코</p>

										<div class="price">

											<p class="sale">259,000원</p>

										</div>
									</a>

									<button type="button" class="wish__btn  wish" data-wish="61144"
										wish="">wish</button>
									<!-- 활성화시 클래스 on -->
								</div>

								<button type="button" class="cart__btn btn_sld__gr"
									onclick="wish_Cart_action('61144');void(0);">장바구니 담기</button>

							</div>

							<div class="goods swiper-slide" data-val="1" role="group"
								aria-label="12 / 12">
								<div class="photo">
									<div class="before">
										<a href="/product/view.asp?ProductNo=61275"
											onclick="clickGroobeeProduct('','113','61275')"> <img
											src="//filacdn.styleship.com/filaproduct2/data/productimages/a/3/FS254BT03X007_001.jpg"
											alt="">
										</a>
									</div>


								</div>

								<div class="info">
									<a href="/product/view.asp?ProductNo=61275"
										onclick="clickGroobeeProduct('','113','61275')">
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

									<button type="button" class="wish__btn  wish" data-wish="61275"
										wish="">wish</button>
									<!-- 활성화시 클래스 on -->
								</div>

								<button type="button" class="cart__btn btn_sld__gr"
									onclick="wish_Cart_action('61275');void(0);">장바구니 담기</button>

							</div>
						</div>
						<span class="swiper-notification" aria-live="assertive"
							aria-atomic="true"></span>
					</div>
				</div>
			</section>
			<!-- //추천 상품 -->


			<!-- instagram -->
			<section class="main-instagram-box">
				<h2 class="hidden">instagram</h2>

				<div class="head">
					<div class="ico">
						<svg xmlns="http://www.w3.org/2000/svg" width="30" height="30"
							viewBox="0 0 30 30">
							<path id="iconmonstr-instagram-11_2_"
								data-name="iconmonstr-instagram-11 (2)"
								d="M15,2.7c4.005,0,4.48.015,6.063.087,4.065.185,5.964,2.114,6.149,6.149C27.284,10.521,27.3,11,27.3,15s-.015,4.48-.086,6.061c-.186,4.031-2.08,5.964-6.149,6.149-1.582.073-2.055.088-6.062.088s-4.48-.015-6.061-.088c-4.075-.186-5.964-2.124-6.149-6.15C2.717,19.48,2.7,19.006,2.7,15s.016-4.479.088-6.061C2.976,4.905,4.87,2.975,8.939,2.79,10.521,2.719,10.995,2.7,15,2.7ZM15,0c-4.074,0-4.584.018-6.184.09C3.369.34.341,3.363.091,8.815.017,10.416,0,10.926,0,15s.018,4.585.09,6.185c.25,5.448,3.273,8.475,8.725,8.725,1.6.073,2.111.09,6.185.09s4.585-.017,6.185-.09c5.443-.25,8.477-3.273,8.724-8.725.074-1.6.091-2.111.091-6.185s-.017-4.584-.09-6.184C29.665,3.374,26.639.341,21.186.091,19.585.017,19.074,0,15,0Zm0,7.3A7.7,7.7,0,1,0,22.7,15,7.7,7.7,0,0,0,15,7.3ZM15,20a5,5,0,1,1,5-5A5,5,0,0,1,15,20ZM23.007,5.194a1.8,1.8,0,1,0,1.8,1.8A1.8,1.8,0,0,0,23.007,5.194Z"></path>
						</svg>
					</div>

					<div class="link">
						<a href="https://www.instagram.com/fila_korea/" target="_blank">@fila_korea</a>
					</div>
				</div>

				<div class="con">
					<ul class="instagram__list">

						<li><a href="https://www.instagram.com/p/DSmTcf5k1mq/"
							target="_blank"><img
								src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAC0lEQVQIW2NkAAIAAAoAAggA9GkAAAAASUVORK5CYII="
								class="autofit" alt=""
								data-src="https://scontent.cdninstagram.com/v/t51.82787-15/602184613_18560559799063350_3076119686301293900_n.jpg?stp=dst-jpg_e35_tt6&amp;_nc_cat=103&amp;ccb=7-5&amp;_nc_sid=18de74&amp;efg=eyJlZmdfdGFnIjoiQ0FST1VTRUxfSVRFTS5iZXN0X2ltYWdlX3VybGdlbi5DMyJ9&amp;_nc_ohc=hdPM6l_PqQIQ7kNvwGwzd-6&amp;_nc_oc=Adkxi6P5jPqIUZVjxo5dlQrB4AcQF8kGNmq74Lr3wi2kI5KqceSLlTgnMMSzh4Sta3Q&amp;_nc_zt=23&amp;_nc_ht=scontent.cdninstagram.com&amp;edm=ANo9K5cEAAAA&amp;_nc_gid=WH5E_bxTa2f4QEUNfehfrA&amp;oh=00_AfkY__jWRD91JVLIL2czAPdTYItlE3XyN7quWw0lhMM-Jg&amp;oe=69513BB9"
								style="background-repeat: no-repeat; background-image: url(https://scontent.cdninstagram.com/v/t51.82787-15/602184613_18560559799063350_3076119686301293900_n.jpg?stp=dst-jpg_e35_tt6&amp;amp;_nc_cat=103&amp;amp;ccb=7-5&amp;amp;_nc_sid=18de74&amp;amp;efg=eyJlZmdfdGFnIjoiQ0FST1VTRUxfSVRFTS5iZXN0X2ltYWdlX3VybGdlbi5DMyJ9&amp;amp;_nc_ohc=hdPM6l_PqQIQ7kNvwGwzd-6&amp;amp;_nc_oc=Adkxi6P5jPqIUZVjxo5dlQrB4AcQF8kGNmq74Lr3wi2kI5KqceSLlTgnMMSzh4Sta3Q&amp;amp;_nc_zt=23&amp;amp;_nc_ht=scontent.cdninstagram.com&amp;amp;edm=ANo9K5cEAAAA&amp;amp;_nc_gid=WH5E_bxTa2f4QEUNfehfrA&amp;amp;oh=00_AfkY__jWRD91JVLIL2czAPdTYItlE3XyN7quWw0lhMM-Jg&amp;amp;oe=69513BB9); background-position: 50% 50%; -webkit-background-size: cover; -moz-background-size: cover; -ms-background-size: cover; -o-background-size: cover; background-size: cover;"></a>
						</li>

						<li><a href="https://www.instagram.com/p/DSjnyisFLKk/"
							target="_blank"><img
								src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAC0lEQVQIW2NkAAIAAAoAAggA9GkAAAAASUVORK5CYII="
								class="autofit" alt=""
								data-src="https://scontent.cdninstagram.com/v/t51.82787-15/587798354_18560465431063350_5222881413946883479_n.jpg?stp=dst-jpg_e35_tt6&amp;_nc_cat=105&amp;ccb=7-5&amp;_nc_sid=18de74&amp;efg=eyJlZmdfdGFnIjoiQ0FST1VTRUxfSVRFTS5iZXN0X2ltYWdlX3VybGdlbi5DMyJ9&amp;_nc_ohc=jcpVwcI_cmQQ7kNvwGgDA1y&amp;_nc_oc=AdlAROq92aEOIHlOE2cRF3piTdRpyiXi2NxYCjqOcb8Fa0SvoerZ6IInEMiOtt26gQ4&amp;_nc_zt=23&amp;_nc_ht=scontent.cdninstagram.com&amp;edm=ANo9K5cEAAAA&amp;_nc_gid=WH5E_bxTa2f4QEUNfehfrA&amp;oh=00_Afl7K0QBPOtdVaLzqUsSywR9CObgh7CfvAgoND0oM1gUgQ&amp;oe=69513902"
								style="background-repeat: no-repeat; background-image: url(https://scontent.cdninstagram.com/v/t51.82787-15/587798354_18560465431063350_5222881413946883479_n.jpg?stp=dst-jpg_e35_tt6&amp;amp;_nc_cat=105&amp;amp;ccb=7-5&amp;amp;_nc_sid=18de74&amp;amp;efg=eyJlZmdfdGFnIjoiQ0FST1VTRUxfSVRFTS5iZXN0X2ltYWdlX3VybGdlbi5DMyJ9&amp;amp;_nc_ohc=jcpVwcI_cmQQ7kNvwGgDA1y&amp;amp;_nc_oc=AdlAROq92aEOIHlOE2cRF3piTdRpyiXi2NxYCjqOcb8Fa0SvoerZ6IInEMiOtt26gQ4&amp;amp;_nc_zt=23&amp;amp;_nc_ht=scontent.cdninstagram.com&amp;amp;edm=ANo9K5cEAAAA&amp;amp;_nc_gid=WH5E_bxTa2f4QEUNfehfrA&amp;amp;oh=00_Afl7K0QBPOtdVaLzqUsSywR9CObgh7CfvAgoND0oM1gUgQ&amp;amp;oe=69513902); background-position: 50% 50%; -webkit-background-size: cover; -moz-background-size: cover; -ms-background-size: cover; -o-background-size: cover; background-size: cover;"></a>
						</li>

						<li><a href="https://www.instagram.com/p/DSbXBS2lEFM/"
							target="_blank"><img
								src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAC0lEQVQIW2NkAAIAAAoAAggA9GkAAAAASUVORK5CYII="
								class="autofit" alt=""
								data-src="https://scontent.cdninstagram.com/v/t51.82787-15/598012616_18559601443063350_3005108580829674545_n.jpg?stp=dst-jpg_e35_tt6&amp;_nc_cat=106&amp;ccb=7-5&amp;_nc_sid=18de74&amp;efg=eyJlZmdfdGFnIjoiQ0FST1VTRUxfSVRFTS5iZXN0X2ltYWdlX3VybGdlbi5DMyJ9&amp;_nc_ohc=8nSvK2dtRqQQ7kNvwEEXZAb&amp;_nc_oc=AdkgTW-ax4EvXu_IJQHoYJf4jqUt1k4o9qzD1bX2IhhNBoxvp0ayXwElLz9R76H5Qfc&amp;_nc_zt=23&amp;_nc_ht=scontent.cdninstagram.com&amp;edm=ANo9K5cEAAAA&amp;_nc_gid=WH5E_bxTa2f4QEUNfehfrA&amp;oh=00_Afkk03ir-AwiLZ-7vlPVZKGhhpCRFMia_bQEDP6KFErZPw&amp;oe=69510417"
								style="background-repeat: no-repeat; background-image: url(https://scontent.cdninstagram.com/v/t51.82787-15/598012616_18559601443063350_3005108580829674545_n.jpg?stp=dst-jpg_e35_tt6&amp;amp;_nc_cat=106&amp;amp;ccb=7-5&amp;amp;_nc_sid=18de74&amp;amp;efg=eyJlZmdfdGFnIjoiQ0FST1VTRUxfSVRFTS5iZXN0X2ltYWdlX3VybGdlbi5DMyJ9&amp;amp;_nc_ohc=8nSvK2dtRqQQ7kNvwEEXZAb&amp;amp;_nc_oc=AdkgTW-ax4EvXu_IJQHoYJf4jqUt1k4o9qzD1bX2IhhNBoxvp0ayXwElLz9R76H5Qfc&amp;amp;_nc_zt=23&amp;amp;_nc_ht=scontent.cdninstagram.com&amp;amp;edm=ANo9K5cEAAAA&amp;amp;_nc_gid=WH5E_bxTa2f4QEUNfehfrA&amp;amp;oh=00_Afkk03ir-AwiLZ-7vlPVZKGhhpCRFMia_bQEDP6KFErZPw&amp;amp;oe=69510417); background-position: 50% 50%; -webkit-background-size: cover; -moz-background-size: cover; -ms-background-size: cover; -o-background-size: cover; background-size: cover;"></a>
						</li>

						<li><a href="https://www.instagram.com/p/DSZbZO_lBgv/"
							target="_blank"><img
								src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAC0lEQVQIW2NkAAIAAAoAAggA9GkAAAAASUVORK5CYII="
								class="autofit" alt=""
								data-src="https://scontent.cdninstagram.com/v/t51.82787-15/598819154_18559601338063350_5974200471525627672_n.jpg?stp=dst-jpg_e35_tt6&amp;_nc_cat=109&amp;ccb=7-5&amp;_nc_sid=18de74&amp;efg=eyJlZmdfdGFnIjoiQ0FST1VTRUxfSVRFTS5iZXN0X2ltYWdlX3VybGdlbi5DMyJ9&amp;_nc_ohc=T8TEqKktvikQ7kNvwFSRIKM&amp;_nc_oc=AdkrTwNtLwcR1AqXTnQv2oobM6Th0as9Vogoi0WFePJXRhOBiMrg6tGOXqpEZ5bZljI&amp;_nc_zt=23&amp;_nc_ht=scontent.cdninstagram.com&amp;edm=ANo9K5cEAAAA&amp;_nc_gid=WH5E_bxTa2f4QEUNfehfrA&amp;oh=00_Afl2gKrotFbzWKn-lZZArKfJz6XAfvPk0cgVFwTsZSKSzA&amp;oe=6951164B"
								style="background-repeat: no-repeat; background-image: url(https://scontent.cdninstagram.com/v/t51.82787-15/598819154_18559601338063350_5974200471525627672_n.jpg?stp=dst-jpg_e35_tt6&amp;amp;_nc_cat=109&amp;amp;ccb=7-5&amp;amp;_nc_sid=18de74&amp;amp;efg=eyJlZmdfdGFnIjoiQ0FST1VTRUxfSVRFTS5iZXN0X2ltYWdlX3VybGdlbi5DMyJ9&amp;amp;_nc_ohc=T8TEqKktvikQ7kNvwFSRIKM&amp;amp;_nc_oc=AdkrTwNtLwcR1AqXTnQv2oobM6Th0as9Vogoi0WFePJXRhOBiMrg6tGOXqpEZ5bZljI&amp;amp;_nc_zt=23&amp;amp;_nc_ht=scontent.cdninstagram.com&amp;amp;edm=ANo9K5cEAAAA&amp;amp;_nc_gid=WH5E_bxTa2f4QEUNfehfrA&amp;amp;oh=00_Afl2gKrotFbzWKn-lZZArKfJz6XAfvPk0cgVFwTsZSKSzA&amp;amp;oe=6951164B); background-position: 50% 50%; -webkit-background-size: cover; -moz-background-size: cover; -ms-background-size: cover; -o-background-size: cover; background-size: cover;"></a>
						</li>

						<li><a href="https://www.instagram.com/reel/DSW20QZj9Mk/"
							target="_blank"><img
								src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAC0lEQVQIW2NkAAIAAAoAAggA9GkAAAAASUVORK5CYII="
								class="autofit" alt=""
								data-src="https://scontent.cdninstagram.com/v/t51.71878-15/602340300_25821487344144044_8681914954917792459_n.jpg?stp=dst-jpg_e35_tt6&amp;_nc_cat=102&amp;ccb=7-5&amp;_nc_sid=18de74&amp;efg=eyJlZmdfdGFnIjoiQ0xJUFMuYmVzdF9pbWFnZV91cmxnZW4uQzMifQ%3D%3D&amp;_nc_ohc=OBEmo09OeHkQ7kNvwHEM3pZ&amp;_nc_oc=AdmpVc0eOCu81ozfHbq9Bp8Otdn_4hMRLzwB6og_AiFURg_-d9lO69BHROqJdnJ9IAo&amp;_nc_zt=23&amp;_nc_ht=scontent.cdninstagram.com&amp;edm=ANo9K5cEAAAA&amp;_nc_gid=WH5E_bxTa2f4QEUNfehfrA&amp;oh=00_Afk0qp0v6VAMQSkFNVCOXfva1YBI2robt4tQew10selhAQ&amp;oe=69512229"
								style="background-repeat: no-repeat; background-image: url(https://scontent.cdninstagram.com/v/t51.71878-15/602340300_25821487344144044_8681914954917792459_n.jpg?stp=dst-jpg_e35_tt6&amp;amp;_nc_cat=102&amp;amp;ccb=7-5&amp;amp;_nc_sid=18de74&amp;amp;efg=eyJlZmdfdGFnIjoiQ0xJUFMuYmVzdF9pbWFnZV91cmxnZW4uQzMifQ%3D%3D&amp;amp;_nc_ohc=OBEmo09OeHkQ7kNvwHEM3pZ&amp;amp;_nc_oc=AdmpVc0eOCu81ozfHbq9Bp8Otdn_4hMRLzwB6og_AiFURg_-d9lO69BHROqJdnJ9IAo&amp;amp;_nc_zt=23&amp;amp;_nc_ht=scontent.cdninstagram.com&amp;amp;edm=ANo9K5cEAAAA&amp;amp;_nc_gid=WH5E_bxTa2f4QEUNfehfrA&amp;amp;oh=00_Afk0qp0v6VAMQSkFNVCOXfva1YBI2robt4tQew10selhAQ&amp;amp;oe=69512229); background-position: 50% 50%; -webkit-background-size: cover; -moz-background-size: cover; -ms-background-size: cover; -o-background-size: cover; background-size: cover;"></a>
						</li>

						<li><a href="https://www.instagram.com/p/DSWNaQAD83i/"
							target="_blank"><img
								src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAC0lEQVQIW2NkAAIAAAoAAggA9GkAAAAASUVORK5CYII="
								class="autofit" alt=""
								data-src="https://scontent.cdninstagram.com/v/t51.82787-15/587792318_18559537567063350_5761531407433289236_n.jpg?stp=dst-jpg_e35_tt6&amp;_nc_cat=105&amp;ccb=7-5&amp;_nc_sid=18de74&amp;efg=eyJlZmdfdGFnIjoiQ0FST1VTRUxfSVRFTS5iZXN0X2ltYWdlX3VybGdlbi5DMyJ9&amp;_nc_ohc=-UYQs9XWQgkQ7kNvwGdG8Ng&amp;_nc_oc=AdlNwVJMF3LXsfG1Xfy98PCeMlKXdk3iBZDtEmsbU1tXvpHcCPPlNTWLbeq125WRrEg&amp;_nc_zt=23&amp;_nc_ht=scontent.cdninstagram.com&amp;edm=ANo9K5cEAAAA&amp;_nc_gid=WH5E_bxTa2f4QEUNfehfrA&amp;oh=00_Afkq1r6DhBe0c-Sf46OosYGcFbQRCIGtGnyP3vnz9uV3Pw&amp;oe=69511165"
								style="background-repeat: no-repeat; background-image: url(https://scontent.cdninstagram.com/v/t51.82787-15/587792318_18559537567063350_5761531407433289236_n.jpg?stp=dst-jpg_e35_tt6&amp;amp;_nc_cat=105&amp;amp;ccb=7-5&amp;amp;_nc_sid=18de74&amp;amp;efg=eyJlZmdfdGFnIjoiQ0FST1VTRUxfSVRFTS5iZXN0X2ltYWdlX3VybGdlbi5DMyJ9&amp;amp;_nc_ohc=-UYQs9XWQgkQ7kNvwGdG8Ng&amp;amp;_nc_oc=AdlNwVJMF3LXsfG1Xfy98PCeMlKXdk3iBZDtEmsbU1tXvpHcCPPlNTWLbeq125WRrEg&amp;amp;_nc_zt=23&amp;amp;_nc_ht=scontent.cdninstagram.com&amp;amp;edm=ANo9K5cEAAAA&amp;amp;_nc_gid=WH5E_bxTa2f4QEUNfehfrA&amp;amp;oh=00_Afkq1r6DhBe0c-Sf46OosYGcFbQRCIGtGnyP3vnz9uV3Pw&amp;amp;oe=69511165); background-position: 50% 50%; -webkit-background-size: cover; -moz-background-size: cover; -ms-background-size: cover; -o-background-size: cover; background-size: cover;"></a>
						</li>

						<li><a href="https://www.instagram.com/p/DSJjJ2dD30Y/"
							target="_blank"><img
								src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAC0lEQVQIW2NkAAIAAAoAAggA9GkAAAAASUVORK5CYII="
								class="autofit" alt=""
								data-src="https://scontent.cdninstagram.com/v/t51.82787-15/588033489_18558823546063350_7411895423672164574_n.jpg?stp=dst-jpg_e35_tt6&amp;_nc_cat=103&amp;ccb=7-5&amp;_nc_sid=18de74&amp;efg=eyJlZmdfdGFnIjoiQ0FST1VTRUxfSVRFTS5iZXN0X2ltYWdlX3VybGdlbi5DMyJ9&amp;_nc_ohc=Kodf5qsWHOwQ7kNvwGuaBJF&amp;_nc_oc=Adl-CeG0PR4Sk_OXHGgFj-8CelztPqFnJ1bj0gDGJ_nDPA1tM0KVNZbgaqUFywCgQOw&amp;_nc_zt=23&amp;_nc_ht=scontent.cdninstagram.com&amp;edm=ANo9K5cEAAAA&amp;_nc_gid=WH5E_bxTa2f4QEUNfehfrA&amp;oh=00_AflQY-6PtS806NPY-F2o5x-eWvaQdmubhtq_HHl_S2083w&amp;oe=6951058B"
								style="background-repeat: no-repeat; background-image: url(https://scontent.cdninstagram.com/v/t51.82787-15/588033489_18558823546063350_7411895423672164574_n.jpg?stp=dst-jpg_e35_tt6&amp;amp;_nc_cat=103&amp;amp;ccb=7-5&amp;amp;_nc_sid=18de74&amp;amp;efg=eyJlZmdfdGFnIjoiQ0FST1VTRUxfSVRFTS5iZXN0X2ltYWdlX3VybGdlbi5DMyJ9&amp;amp;_nc_ohc=Kodf5qsWHOwQ7kNvwGuaBJF&amp;amp;_nc_oc=Adl-CeG0PR4Sk_OXHGgFj-8CelztPqFnJ1bj0gDGJ_nDPA1tM0KVNZbgaqUFywCgQOw&amp;amp;_nc_zt=23&amp;amp;_nc_ht=scontent.cdninstagram.com&amp;amp;edm=ANo9K5cEAAAA&amp;amp;_nc_gid=WH5E_bxTa2f4QEUNfehfrA&amp;amp;oh=00_AflQY-6PtS806NPY-F2o5x-eWvaQdmubhtq_HHl_S2083w&amp;amp;oe=6951058B); background-position: 50% 50%; -webkit-background-size: cover; -moz-background-size: cover; -ms-background-size: cover; -o-background-size: cover; background-size: cover;"></a>
						</li>

						<li><a href="https://www.instagram.com/reel/DSJVeDQj3FY/"
							target="_blank"><img
								src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAC0lEQVQIW2NkAAIAAAoAAggA9GkAAAAASUVORK5CYII="
								class="autofit" alt=""
								data-src="https://scontent.cdninstagram.com/v/t51.71878-15/589623740_876681311418697_4313077346735079558_n.jpg?stp=dst-jpg_e35_tt6&amp;_nc_cat=109&amp;ccb=7-5&amp;_nc_sid=18de74&amp;efg=eyJlZmdfdGFnIjoiQ0xJUFMuYmVzdF9pbWFnZV91cmxnZW4uQzMifQ%3D%3D&amp;_nc_ohc=HNw8pgZYFQkQ7kNvwHp8XAq&amp;_nc_oc=AdnpN-_0Y-CP6IvrnQTRbHPIsF5VYlJ_ZOjmFdG9uoLq786fj-fOKusyhagc_h-WMbU&amp;_nc_zt=23&amp;_nc_ht=scontent.cdninstagram.com&amp;edm=ANo9K5cEAAAA&amp;_nc_gid=WH5E_bxTa2f4QEUNfehfrA&amp;oh=00_Afn9hG79klRbI7O1Ct3ux7_MxcRZV-6sb7KyLXrsincZ_Q&amp;oe=69512A4A"
								style="background-repeat: no-repeat; background-image: url(https://scontent.cdninstagram.com/v/t51.71878-15/589623740_876681311418697_4313077346735079558_n.jpg?stp=dst-jpg_e35_tt6&amp;amp;_nc_cat=109&amp;amp;ccb=7-5&amp;amp;_nc_sid=18de74&amp;amp;efg=eyJlZmdfdGFnIjoiQ0xJUFMuYmVzdF9pbWFnZV91cmxnZW4uQzMifQ%3D%3D&amp;amp;_nc_ohc=HNw8pgZYFQkQ7kNvwHp8XAq&amp;amp;_nc_oc=AdnpN-_0Y-CP6IvrnQTRbHPIsF5VYlJ_ZOjmFdG9uoLq786fj-fOKusyhagc_h-WMbU&amp;amp;_nc_zt=23&amp;amp;_nc_ht=scontent.cdninstagram.com&amp;amp;edm=ANo9K5cEAAAA&amp;amp;_nc_gid=WH5E_bxTa2f4QEUNfehfrA&amp;amp;oh=00_Afn9hG79klRbI7O1Ct3ux7_MxcRZV-6sb7KyLXrsincZ_Q&amp;amp;oe=69512A4A); background-position: 50% 50%; -webkit-background-size: cover; -moz-background-size: cover; -ms-background-size: cover; -o-background-size: cover; background-size: cover;"></a>
						</li>

						<li><a href="https://www.instagram.com/reel/DSEhEAHDzGN/"
							target="_blank"><img
								src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAC0lEQVQIW2NkAAIAAAoAAggA9GkAAAAASUVORK5CYII="
								class="autofit" alt=""
								data-src="https://scontent.cdninstagram.com/v/t51.82787-15/588812126_18558441358063350_3608877056401586937_n.jpg?stp=dst-jpg_e35_tt6&amp;_nc_cat=107&amp;ccb=7-5&amp;_nc_sid=18de74&amp;efg=eyJlZmdfdGFnIjoiQ0xJUFMuYmVzdF9pbWFnZV91cmxnZW4uQzMifQ%3D%3D&amp;_nc_ohc=zgQknUX_1TUQ7kNvwEL8bKW&amp;_nc_oc=AdmgouoOsZWOdt6Vq3S3Imek5e5xbCBYoxkRKcYirqF7syzW3unE5LLkMUBkdxIiH9s&amp;_nc_zt=23&amp;_nc_ht=scontent.cdninstagram.com&amp;edm=ANo9K5cEAAAA&amp;_nc_gid=WH5E_bxTa2f4QEUNfehfrA&amp;oh=00_AflHsfdeA_nx10tM6aoW1QNZAPK2QdG4MOqbCJNZsMhAWw&amp;oe=69513BF8"
								style="background-repeat: no-repeat; background-image: url(https://scontent.cdninstagram.com/v/t51.82787-15/588812126_18558441358063350_3608877056401586937_n.jpg?stp=dst-jpg_e35_tt6&amp;amp;_nc_cat=107&amp;amp;ccb=7-5&amp;amp;_nc_sid=18de74&amp;amp;efg=eyJlZmdfdGFnIjoiQ0xJUFMuYmVzdF9pbWFnZV91cmxnZW4uQzMifQ%3D%3D&amp;amp;_nc_ohc=zgQknUX_1TUQ7kNvwEL8bKW&amp;amp;_nc_oc=AdmgouoOsZWOdt6Vq3S3Imek5e5xbCBYoxkRKcYirqF7syzW3unE5LLkMUBkdxIiH9s&amp;amp;_nc_zt=23&amp;amp;_nc_ht=scontent.cdninstagram.com&amp;amp;edm=ANo9K5cEAAAA&amp;amp;_nc_gid=WH5E_bxTa2f4QEUNfehfrA&amp;amp;oh=00_AflHsfdeA_nx10tM6aoW1QNZAPK2QdG4MOqbCJNZsMhAWw&amp;amp;oe=69513BF8); background-position: 50% 50%; -webkit-background-size: cover; -moz-background-size: cover; -ms-background-size: cover; -o-background-size: cover; background-size: cover;"></a>
						</li>

						<li><a href="https://www.instagram.com/p/DSEggdaDwcp/"
							target="_blank"><img
								src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAC0lEQVQIW2NkAAIAAAoAAggA9GkAAAAASUVORK5CYII="
								class="autofit" alt=""
								data-src="https://scontent.cdninstagram.com/v/t51.82787-15/588231394_18558441136063350_1611504732787430936_n.jpg?stp=dst-jpg_e35_tt6&amp;_nc_cat=111&amp;ccb=7-5&amp;_nc_sid=18de74&amp;efg=eyJlZmdfdGFnIjoiQ0FST1VTRUxfSVRFTS5iZXN0X2ltYWdlX3VybGdlbi5DMyJ9&amp;_nc_ohc=tqXqoUVFox8Q7kNvwF2ROeu&amp;_nc_oc=Adn0w4VswUfQyE3-66c2V5Djp6gvj2t5PXHVBgCxzckh-V4H4fK1EqPKu2jSiImv2nI&amp;_nc_zt=23&amp;_nc_ht=scontent.cdninstagram.com&amp;edm=ANo9K5cEAAAA&amp;_nc_gid=WH5E_bxTa2f4QEUNfehfrA&amp;oh=00_AfkKwYrlURL5hlKHlKmM1KMvbJjqpVWrLQlox-PRVNB0dQ&amp;oe=69510773"
								style="background-repeat: no-repeat; background-image: url(https://scontent.cdninstagram.com/v/t51.82787-15/588231394_18558441136063350_1611504732787430936_n.jpg?stp=dst-jpg_e35_tt6&amp;amp;_nc_cat=111&amp;amp;ccb=7-5&amp;amp;_nc_sid=18de74&amp;amp;efg=eyJlZmdfdGFnIjoiQ0FST1VTRUxfSVRFTS5iZXN0X2ltYWdlX3VybGdlbi5DMyJ9&amp;amp;_nc_ohc=tqXqoUVFox8Q7kNvwF2ROeu&amp;amp;_nc_oc=Adn0w4VswUfQyE3-66c2V5Djp6gvj2t5PXHVBgCxzckh-V4H4fK1EqPKu2jSiImv2nI&amp;amp;_nc_zt=23&amp;amp;_nc_ht=scontent.cdninstagram.com&amp;amp;edm=ANo9K5cEAAAA&amp;amp;_nc_gid=WH5E_bxTa2f4QEUNfehfrA&amp;amp;oh=00_AfkKwYrlURL5hlKHlKmM1KMvbJjqpVWrLQlox-PRVNB0dQ&amp;amp;oe=69510773); background-position: 50% 50%; -webkit-background-size: cover; -moz-background-size: cover; -ms-background-size: cover; -o-background-size: cover; background-size: cover;"></a>
						</li>

					</ul>
				</div>
			</section>
			<!-- //instagram -->
		</div>
	</div>
	<jsp:include page="common/footer.jsp" />

</body>

</html>