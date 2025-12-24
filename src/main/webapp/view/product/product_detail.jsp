<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@ page import="products.productsDAO" %>
<%@ page import="products.productsDTO" %>
<%@ page import="java.util.List" %>

<%
    // ★ [추적용] JSP가 실행되었는지 확인하는 코드
    System.out.println("---------------------------------------");
    System.out.println("🚩 [JSP] product_detail.jsp 페이지 진입 성공!");
    
    String reqId = request.getParameter("product_id");
    System.out.println("🚩 [JSP] URL에서 받은 ID: " + reqId);

    if (reqId == null || reqId.isEmpty()) {
        System.out.println("🚨 [JSP 경고] product_id가 없습니다! URL을 확인하세요.");
    }
%>

<%
    // 1. 상품 ID 받기
    String productId = request.getParameter("product_id");

    // 2. DB 조회 (상품 정보 + 옵션 정보)
    productsDAO dao = new productsDAO();
    productsDTO product = dao.getProduct(productId);
    
    // ★ [추가] 옵션 데이터 가져오기
    List<products.productsOptionDTO> optionList = dao.getProductOptions(productId);
    
    // 3. 유효성 검사
    if(product == null) {
%>
        <script>alert("존재하지 않는 상품입니다."); location.href = "list.jsp";</script>
<%
        return;
    }

    // 4. 데이터 저장
    pageContext.setAttribute("product", product);
    int finalPrice = product.getPrice() * (100 - product.getDiscount_rate()) / 100;
    pageContext.setAttribute("finalPrice", finalPrice);
    
    // ★ [추가] 옵션을 '색상'과 '사이즈'로 분리해서 저장 (JSP에서 쓰기 편하게)
    products.productsOptionDTO colorOption = null;
    products.productsOptionDTO sizeOption = null;
    
    if(optionList != null) {
        for(products.productsOptionDTO opt : optionList) {
            if(opt.getGroupName().contains("색상") || opt.getGroupName().contains("Color")) {
                colorOption = opt;
            } else if(opt.getGroupName().contains("사이즈") || opt.getGroupName().contains("Size")) {
                sizeOption = opt;
            }
        }
    }
    pageContext.setAttribute("colorOption", colorOption);
    pageContext.setAttribute("sizeOption", sizeOption);
%>

<!DOCTYPE html>
<head>

	<title>FILA 상품상세</title>

</head>

<body class="view__style1" style="overflow-x: hidden;">
	<input type="hidden" name="bnftNm" id="bnftNm" value="" />	
	<input type="hidden" name="bnftVal" id="bnftVal" value="" />		
	<input type="hidden" name="bnftDate" id="bnftDate" value="" />	
	<input type="hidden" name="bnftLimit" id="bnftLimit" value="" />	
	<!-- start of :: wrap -->
	<div id="wrap">
		
<!-- start of :: header -->
	<jsp:include page="../header.jsp" />
<!-- // end of :: header -->	

		<!-- start of :: contents -->
		<div id="contents" class="goods__contents">			
			<section class="goods-view-box">
				<h2 class="hidden">상품 상세</h2>

				<!-- sticky -->
				<div class="sticky-box">
					<!-- 상품 이미지, 상품 디테일 -->
					<div class="goods-detail-box">


						<!-- 상품 이미지 -->
						<div class="photo-list-box _style1"> <!-- 영상,이미지 없을 경우 _style1 추가 -->
							<ul>
                                <li>
                                    <img src="${product.image_url}" alt="${product.name}" onError="$(this).parent('li').hide();" />
                                </li>
                                </ul>

							<!-- 영상, 이미지 -->							
							<div class="view-slider-box">
								<div class="inner">
									<!-- 슬라이드 -->
									<div class="view-photo__slider swiper">
										<div class="swiper-wrapper">
										
										</div>
									</div>
									<!-- //슬라이드 -->

									<!-- 슬라이드 버튼 -->
									<div class="slider-btn-box">
										<button type="button" class="prev__btn"></button>
										<div class="slider-scrollbar"></div>
										<button type="button" class="next__btn"></button>
									</div>
									<!-- //슬라이드 버튼 -->
								</div>


								<!-- 모델 스펙 -->
								<!--div class="model-spec">
									<p>(여) 165cm / 착용사이즈 : WS/S</p>
									<p>모델 착용 이미지보다 제품컷 이미지의 컬러가 정확합니다.</p>
								</div-->
								<!-- //모델 스펙 -->


							</div>
							<!-- //영상, 이미지 -->

						</div>
						<!-- //상품 이미지 -->

						<!-- 상품 디테일 -->						
						<div class="detail-box">

							<!-- 2024-09-11 이미지 배너 추가 -->
							
							<div class="product-notice-banner">
								<img src="//filacdn.styleship.com/filacontent2/data/ContentsFile/PDP_img_d.jpg" alt="">
							</div>
							
							<!-- //2024-09-11 이미지 배너 추가 -->

							<!-- 모델컷 -->
							<div class="model-cut-box">
								<div class="hd">
									<p class="tit">모델컷</p>
								</div>
								
								<div class="cn">
									<!-- 슬라이더 -->
									<div class="mc-slider-box">
										<div class="mc__slider">
											<div class="swiper-wrapper">

												<div class="swiper-slide">
													<img src="http://filacdn.styleship.com/filaproduct2/data/productImages/model01/4/FS254DJ01F001_561.jpg" alt="">
												</div>

												<div class="swiper-slide">
													<img src="http://filacdn.styleship.com/filaproduct2/data/productImages/model02/4/FS254DJ01F001_561.jpg" alt="">
												</div>

												<div class="swiper-slide">
													<img src="http://filacdn.styleship.com/filaproduct2/data/productImages/model03/4/FS254DJ01F001_561.jpg" alt="">
												</div>

												<div class="swiper-slide">
													<img src="http://filacdn.styleship.com/filaproduct2/data/productImages/model04/4/FS254DJ01F001_561.jpg" alt="">
												</div>

											</div>
										</div>

										<div class="mc-swiper-pagination"></div>
									</div>
									<!-- //슬라이더 -->
								</div>

									<!-- 2024-02-06 모델정보 추가 -->
									<!-- //모델 스펙 -->
									<div class="mc-info-box">
										<p>
											(여) 165cm / 착용사이즈 : WS/S<br>
											모델 착용 이미지보다 제품컷 이미지의 컬러가 정확합니다.
										</p>
									</div>
									<!-- //모델 스펙 -->
									<!-- // 2024-02-06 모델정보 추가 -->

							</div>
							<!-- //모델컷 -->

							<!-- 2023-06-21 추가 -->
							<div class="top-img-box">
								<div class="img"><img src="//filacdn.styleship.com/filacontent2/data/filastyle/img_FlowDown_04_d_31.jpg" alt=""></div>
								
								<p class="txt"></p>
							</div>
							<!-- // 2023-06-21 추가 -->

							<!-- 2023-06-21 추가 -->
							<div class="top-img-box">
								<div class="img"><img src="//filacdn.styleship.com/filacontent2/data/filastyle/img_FlowDown_01_57.jpg" alt=""></div>
								
								<p class="txt"></p>
							</div>
							<!-- // 2023-06-21 추가 -->

							<!-- 2023-06-21 추가 -->
							<div class="top-img-box">
								<div class="img"><img src="//filacdn.styleship.com/filacontent2/data/filastyle/img_FlowDown_02_42.jpg" alt=""></div>
								
								<p class="txt"></p>
							</div>
							<!-- // 2023-06-21 추가 -->

							<!-- 2023-06-21 추가 -->
							<div class="top-img-box">
								<div class="img"><img src="//filacdn.styleship.com/filacontent2/data/filastyle/img_FlowDown_03_74.jpg" alt=""></div>
								
								<p class="txt"></p>
							</div>
							<!-- // 2023-06-21 추가 -->

							<!-- 체크 포인트 -->
							<div class="checkpoint-box">
								<div class="hd">
									<p class="tit">체크 포인트</p>
								</div>

								<div class="cn">
									<!-- 슬라이더 -->
									<div class="cp-slider-box">
										<div class="cp__slider swiper">
											<div class="swiper-wrapper">

												<div class="swiper-slide">
												
													<img src="//filacdn.styleship.com/filacontent2/data/filastyle/유러피안_(white2)_(960x640)_89.jpg" alt="">
												
													<div class="txt-box">
														<p class="tit"></p>
														<p class="txt">
															
														</p>
													</div>
												</div>

											</div>
										</div>

										<div class="cp-swiper-pagination"></div>
									</div>
									<!-- //슬라이더 -->
								</div>
							</div>
							<!-- //체크 포인트 -->

							<!-- 핏 가이드 -->

							<!-- //핏 가이드 -->


<Script>$(".goods-setup-box").hide()</Script>

						</div>
						<!-- //상품 디테일 -->

<div class="crema-fit-product-combined-detail" data-product-code="1100FS254DJ01F001561"></div>

					</div>
					<!-- //상품 이미지, 상품 디테일 -->


					<!-- 상품 정보 -->
					<div class="goods-info-box">
						<!-- 상품 기본 정보 -->
						<div class="info-box">
							<div class="scroll-box">
							<!-- 상품 기본 정보 -->
							<div class="tag">
						    <p>
						        <c:choose>
						            <%-- 1000 ~ 1999 (또는 10) -> 여성 --%>
						            <c:when test="${product.category_id >= 1000 && product.category_id < 2000 || product.category_id == 10}">
						                WOMEN
						            </c:when>
						            
						            <%-- 2000 ~ 2999 (또는 20) -> 남성 --%>
						            <c:when test="${product.category_id >= 2000 && product.category_id < 3000 || product.category_id == 20}">
						                MEN
						            </c:when>
						            
						            <%-- 3000 ~ 3999 (또는 30) -> 아동 --%>
						            <c:when test="${product.category_id >= 3000 && product.category_id < 4000 || product.category_id == 30}">
						                KIDS
						            </c:when>
						            
						            <c:otherwise>
						                FILA
						            </c:otherwise>
						        </c:choose>
							    </p>
								
				<!--p>라이프스타일</p-->

				<!--p>SEMI-OVER핏</p-->

				<p>SEMI-OVER핏</p>

				<p>라이프스타일</p>

							</div>

							<p class="name">${product.name}</p>

							<div class="price">
							<c:choose>
                                <c:when test="${product.discount_rate > 0}">
                                    <p class="sale"><fmt:formatNumber value="${finalPrice}" pattern="#,###" />원</p>
                                    <p class="normal _sale"><fmt:formatNumber value="${product.price}" pattern="#,###" />원</p>
                                    <p class="percent">${product.discount_rate}% 할인</p>
                                </c:when>
                                <c:otherwise>
                                    <p class="sale"><fmt:formatNumber value="${product.price}" pattern="#,###" />원</p>
                                </c:otherwise>
                            </c:choose>
							
								
							</div>

							<!-- //상품 기본 정보 -->

							<!-- 상품 설명 -->
							<div class="goods-desc">

								<!-- 2024-11-07 reduce 영역 추가 -->
								<!-- 동물복지 윤리를 준수한 상품일 경우 뜨는 상품 (추후에 수정) -->
								<div class="reduce-box _v2">
									<p>
										채취 시 동물 복지 윤리를 준수하고 생산 전 단계를 추적·관리하는 RDS 인증 다운 충전재를 100% 사용한 제품입니다.
									</p>
								</div>

<!-- # include virtual = "/product/reduce.asp" -->

								<p>
									${product.description}
								</p>
							</div>
							<!-- //상품 설명 -->

							<!-- 상품 소재 -->
							<div class="goods-material">
								<p>

									<b>제품소재</b> <br>겉감: 폴리에스터 100%, 안감: 나일론 100%, 충전재: 오리 솜털 80%, 오리 깃털 20%
								</p>

								<!-- 2023-04-07 상품코드 추가 -->
								<p>
									<b>상품코드</b> <br>${product.product_id}
								</p>
								<!-- //2023-04-07 상품코드 추가 -->
							</div>
							<!-- //상품 소재 -->

							<!-- 버튼 -->
							<div class="info-btn-box">
								<button type="button" class="goods-info__btn" data-no="61125">상품 정보 고시</button>
							</div>
							<!-- //버튼 -->

							<!-- 모델 스펙 -->
							<!--<div class="model-spec">
								<p>(여) 165cm / 착용사이즈 : WS/S</p>
								<p>모델 착용 이미지보다 제품컷 이미지의 컬러가 정확합니다.</p>	
							</div>-->
							<!-- //모델 스펙 -->

							<!-- 공유하기 -->
							<div class="share-box">
								<button type="button" class="share__btn" data-path="/product/view.asp?ProductNo=61125">share</button>
							</div>
							<!-- //공유하기 -->

							</div>
						</div>
						<!-- //상품 기본 정보 -->

						<!-- 옵션 선택, 구매 버튼, 레이어 버튼 -->
						<div class="option-box">
							<!-- scroll -->
							<div class="scroll-box">

							<!-- 옵션 선택 -->
							<div class="option-choice-box">
                                        
                                        <c:if test="${not empty colorOption}">
                                            <div class="_color">
                                                <p class="tit">${colorOption.groupName}</p>
                                                <div>
                                                    <div class="color__slider swiper">
                                                        <ul class="swiper-wrapper">
                                                            <c:forEach var="colorVal" items="${colorOption.values}" varStatus="status">
                                                                <li class="swiper-slide ${status.first ? 'on' : ''}">
                                                                    <a href="javascript:void(0);" title="${colorVal}">
                                                                        <img src="${product.image_url}" alt="${colorVal}" />
                                                                    </a>
                                                                </li>
                                                            </c:forEach>
                                                        </ul>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:if>
                                        <c:if test="${not empty sizeOption}">
                                            <div class="_size">
                                                <p class="tit">${sizeOption.groupName}</p>
                                                <div class="layer-btn-box">
                                                    <div>
                                                        <button type="button" class="bell__btn" id="alim" onclick="alert('로그인 후 이용가능합니다.');">입고 알림</button>
                                                        <button type="button" class="inventory__btn">주변 매장 재고</button>
                                                    </div>
                                                </div>
                                                <div>
                                                    <div class="size__slider swiper size">
                                                        <ul class="swiper-wrapper" id="vSize">
                                                            <c:forEach var="sizeVal" items="${sizeOption.values}" varStatus="status">
                                                                <li class="swiper-slide">
                                                                    <input type="radio" name="size" id="size_${status.index}" value="${sizeVal}">
                                                                    <label for="size_${status.index}">${sizeVal}</label>
                                                                </li>
                                                            </c:forEach>
                                                        </ul>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:if>
                                        <div class="_qty" id="vpop">
                                            <div class="qty-box">
                                                <button type="button" name="qtyMinus" id="qtyMinus" class="minus__btn">minus</button>
                                                <input type="number" name="ProductQuantity" id="ProductQuantity" value="1" readonly>
                                                <button type="button" name="qtyPlus" id="qtyPlus" class="plus__btn">plus</button>
                                            </div>
                                        </div>
                                        <div class="total-box">
                                            <dl>
                                                <dt>주문금액</dt>
                                                <dd id="buytotal"><fmt:formatNumber value="${finalPrice}" pattern="#,###" />원</dd>
                                            </dl>
                                        </div>
                                        </div>
							<!-- //scroll -->
							
								<!-- 구매 버튼 -->
								<div class="buy-btn-box">
									<button type="button" class="buy__btn" onclick="alert('구매하기')">바로 구매하기</button>

									<div>
										<!-- location.href='/member/login.jsp';void(0); 로그인 링크 걸기 -->
										<button type="button" class="wish__btn" onclick="javascript:alert('로그인 후 이용가능합니다.');" id="wishBtn">wish</button> <!-- 활성화시 클래스 on -->
										<!-- onclick="javascript:AddToShoppingbag();void(0);" -->
										<button type="button" class="cart__btn"  id="cartBtn">카트담기</button >
									</div>
								</div>
								<!-- //구매 버튼 -->
									

						

							<!-- 레이어 버튼 -->
							<div class="lyr-btn-box">
								
								<!-- 2025-06-30 리뷰 이벤트 배너 -->
								<a href="#" class="rv-ban-box">
									<img src="//filacdn.styleship.com/filacontent2/pc/resource/images/sub/review_event_d_banner_2506.jpg" alt="">
								</a>
								
								

								<div class="lyr__style1">
									<div class="toggle-menu-box">

										<!--button type="button" class="more__btn">신학기 가방 더블 혜택 프로모션</button>
										<div class="toggle-con-box">
											<p>
												백팩 구매시  2만원 쿠폰 & 2만원 포인트<br/>
												<a href="javascript:groobee230206();void(0);" class="btn"><u>쿠폰 다운로드</u></a>
											</p>
										</div-->

										<button type="button" class="more__btn">신규회원 10,000원 할인 쿠폰 발급</button>
										<div class="toggle-con-box">
											<p>
												가입 시 즉시발급 / 50,000원 이상 구매 시 사용가능
											</p>
										</div>

									</div>
									<!-- <div>
										<button type="button" onclick="location.href='/event/review.asp';">리뷰 작성 시 최대 50,000 포인트 지급</button>
									</div>
										 -->							
									<div>
										<button type="button" class="review-more__btn">상품 리뷰<span class=" crema-product-reviews-count" data-product-code="1100FS254DJ01F001561"></span></button>
									</div>

									<div>
										<button type="button" class="qna-more__btn" data-no="${product.product_id}">상품 문의<span>0</span></button>
									</div>
								</div>

								<div class="lyr__style2">
									<div>
										<button type="button" class="delivery-info__btn" data-size="F" data-no="${product.product_id}">배송 정보</button>
									</div>

									<div>
										<button type="button" class="return-info__btn" data-size="F" data-no="${product.product_id}">교환 및 반품</button>
									</div>

									<div>
										<button type="button" class="clean-info__btn" data-size="F" data-no="${product.product_id}" data-text="101/1">세탁방법</button>
									</div>

									<div>
										<button type="button" class="as-info__btn" data-size="F" data-no="${product.product_id}">A/S</button>
									</div>
								</div>
							</div>
							<!-- //레이어 버튼 -->
						</div>
						<!-- //옵션 선택, 구매 버튼, 레이어 버튼 -->		
						
					</div>
					<!-- // 상품 정보 -->
				</div>
				</div>
				<!-- //sticky -->


				<!-- 실시간 많이 본 상품 -->
				<div class="goods-scroll-box">
					<h2>이 상품을 본 고객이 함께 본 상품</h2>

					<div class="slider-box">
						<div class="goods__slider swiper">
							<div class="swiper-wrapper" id="recopickProduct">


							</div>
						</div>

						<div class="scroll-bar-box">
							<div class="goods-slider-scrollbar"></div>
						</div>
					</div>
				</div>
				<!-- //실시간 많이 본 상품 -->
				<!-- 실시간 많이 본 상품 -->
				<div class="goods-scroll-box" style="display:none;">
					<h2>추천 상품2</h2>

					<div class="slider-box">
						<div class="goods__slider swiper">
							<div class="swiper-wrapper" id="recopickProduct2">


							</div>
						</div>

						<div class="scroll-bar-box">
							<div class="goods-slider-scrollbar"></div>
						</div>
					</div>
				</div>
				<!-- //실시간 많이 본 상품 -->
			</section>
		</form>
		<form name="qoptForm" id="qoptForm">
			<input type="hidden" name="answerVal2" id="answerVal2" value="">
			<input type="hidden" name="cateVal2" id="cateVal2" value="">
			<input type="hidden" name="myVal" id="myVal" value="0">

			<input type="hidden" name="pageVal2" id="pageVal2">
			<input type="hidden" name="pageSizeVal2" id="pageSizeVal2">
			<input type="hidden" name="qpno" id="qpno" value="61125">

			<input type="hidden" name="mchk" id="mchk" value="0">
		</form>
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


		<button type="button" class="top__btn">top</button>		
	</div>
</div>
<!-- //하단 고정 버튼 (top, sns) -->


<!-- start of :: footer -->
<jsp:include page="../footer.jsp" />
<!-- // end of :: footer -->
<form name="form6" id="form6"  target="dataFrame"><input type="hidden" name="checkwish"><input type="hidden" name="ProductQuantity"></form>
<iframe name="dataFrame" id="dataFrame" style="display:none;"></iframe>

</body>
</html>