<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<script src="${pageContext.request.contextPath}/js/list.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/review/review_style.css">
<script src="${pageContext.request.contextPath}/resources/review/review_script.js"></script>

<div class="common__layer _review" id="reviewModal" style="display:none;">
    
    <div class="layer-bg__wrap" onclick="closeReviewModal()"></div>

    <div class="inner">
        
        <div id="reviewListView" style="height:100%; display:flex; flex-direction:column;">
            
            <div class="head">
                <div class="goods-info">
                    <div class="photo">
                        <img src="${not empty product.image_url ? product.image_url : '//filacdn.styleship.com/filaproduct2/data/productimages/a/1/FS253IP02F003_734.jpg'}" alt="상품이미지">
                    </div>

                    <div class="info">
                        <div>
                            <p class="txt1">${product.name != null ? product.name : '상품명'}</p>
                        </div>
                        <button type="button" class="review-write__btn" onclick="switchToWrite()">
	                        작성하기
	                    </button>
                    </div>
                </div>
                <button type="button" class="close__btn" onclick="closeReviewModal()">close</button>
            </div>

            <div class="con" style="flex:1; overflow-y:auto;">
                
                <div class="point-guide-banner">
                    <div class="point-txt">
                        <h4>구매확정 후 90일 이내 상품평 작성 시, 최대 2,000 포인트 혜택!</h4>
                        <p>작성하신 상품평에 대한 포인트 지급은 작성 후 15일 이내로 적립됩니다.</p>
                    </div>
                    <div class="point-badges">
                        <span>텍스트 리뷰 500P</span>
                        <span>포토 리뷰 1,000P</span>
                    </div>
                </div>

                <div style="margin-top: 30px; margin-bottom: 20px;">
				    <h3 style="font-weight: 700; font-size: 16px; color:#000; margin-bottom:15px;">REVIEW</h3>
				    <div class="big-rating" style="display: flex; align-items: center; gap: 10px;">
				        <%-- 휠라식 날카로운 큰 별 --%>
				        <span style="display: flex; align-items: center;">
				            <svg viewBox="0 0 24 24" style="width: 32px; height: 32px; fill: #003F96;">
				                <path d="M12 .587l3.668 7.568 8.332 1.151-6.064 5.828 1.48 8.279-7.416-3.967-7.417 3.967 1.481-8.279-6.064-5.828 8.332-1.151z"/>
				            </svg>
				        </span> 
				        
				        <%-- [핵심] 실시간 평균 점수 출력 --%>
				        <span style="font-size: 32px; font-weight: 800; color: #000;">
				            <c:choose>
				                <c:when test="${reviewSummary.avg_score > 0}">
				                    <fmt:formatNumber value="${reviewSummary.avg_score}" pattern="0.0" />
				                </c:when>
				                <c:otherwise>0.0</c:otherwise>
				            </c:choose>
				        </span>
				
				        <%-- 구분선과 상세 정보 --%>
				        <div style="width: 1px; height: 30px; background: #eee; margin: 0 15px;"></div>
				        
				        <div style="font-size: 14px; color: #333;">
				            <div>
				                <strong style="color: #003F96;">${reviewSummary.best_rate}%</strong>가 <b>아주 좋아요</b> 라고 평가했습니다.
				            </div>
				            <div style="color: #999; font-size: 13px; margin-top: 3px;">
				                리뷰 ${reviewSummary.total_cnt}개
				            </div>
				        </div>
				    </div>
				</div>

                <div class="filter-toolbar">
                    <div class="sort-opts">
                        <a href="javascript:void(0);" class="active">최신순</a>
                        <a href="javascript:void(0);">별점순</a>
                    </div>
                    <div class="search-box">
                        <input type="text" placeholder="리뷰 키워드 검색">
                    </div>
                </div>

                <div class="review-filter-bar" style="margin-bottom:20px; display:flex; flex-wrap:wrap; gap:8px;">
                    
                    <div class="filter-wrapper" style="position:relative;">
                        <button type="button" class="filter-trigger" onclick="toggleFilter('starOptionBox')" style="background:#fff; border:1px solid #ddd; padding:8px 12px; font-size:13px; cursor:pointer; display:flex; align-items:center; gap:5px;">
                            별점 
                            <svg width="10" height="10" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2" fill="none">
                                <polyline points="6 9 12 15 18 9"></polyline>
                            </svg>
                        </button>
                        <div id="starOptionBox" class="filter-dropdown" style="display:none; position:absolute; top:100%; left:0; width:200px; background:#fff; border:1px solid #000; z-index:100; padding:15px; margin-top:-1px;">
                            <ul class="check-list" style="list-style:none; padding:0; margin-bottom:10px;">
                                <li><label><input type="checkbox" value="5"> 아주 좋아요</label></li>
                                <li><label><input type="checkbox" value="4"> 좋아요</label></li>
                                <li><label><input type="checkbox" value="3"> 보통이에요</label></li>
                                <li><label><input type="checkbox" value="2"> 그냥 그래요</label></li>
                                <li><label><input type="checkbox" value="1"> 별로예요</label></li>
                            </ul>
                            <div class="dropdown-btns" style="display:flex; gap:5px;">
                                <button type="button" class="reset-btn" style="flex:1; border:1px solid #ddd; background:#fff; height:30px;">초기화</button>
                                <button type="button" class="apply-btn" style="flex:1; border:1px solid #000; background:#000; color:#fff; height:30px;" onclick="closeFilter('starOptionBox')">적용</button>
                            </div>
                        </div>
                    </div>

                    <div class="filter-wrapper" style="position:relative;">
                        <button type="button" class="filter-trigger" onclick="toggleFilter('sizeOptionBox')" style="background:#fff; border:1px solid #ddd; padding:8px 12px; font-size:13px; cursor:pointer; display:flex; align-items:center; gap:5px;">
                            사이즈
                            <svg width="10" height="10" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2" fill="none">
                                <polyline points="6 9 12 15 18 9"></polyline>
                            </svg>
                        </button>
                        <div id="sizeOptionBox" class="filter-dropdown" style="display:none; position:absolute; top:100%; left:0; width:150px; background:#fff; border:1px solid #000; z-index:100; padding:15px; margin-top:-1px;">
                            <ul class="check-list" style="list-style:none; padding:0; margin-bottom:10px;">
                                <li><label><input type="checkbox"> 작아요</label></li>
                                <li><label><input type="checkbox"> 조금 작아요</label></li>
                                <li><label><input type="checkbox"> 잘 맞아요</label></li>
                                <li><label><input type="checkbox"> 조금 커요</label></li>
                                <li><label><input type="checkbox"> 커요</label></li>
                            </ul>
                            <div class="dropdown-btns" style="display:flex; gap:5px;">
                                <button type="button" class="reset-btn" style="flex:1; border:1px solid #ddd; background:#fff; height:30px;">초기화</button>
                                <button type="button" class="apply-btn" style="flex:1; border:1px solid #000; background:#000; color:#fff; height:30px;" onclick="closeFilter('sizeOptionBox')">적용</button>
                            </div>
                        </div>
                    </div>

                    <div class="filter-wrapper" style="position:relative;">
                        <button type="button" class="filter-trigger" onclick="toggleFilter('heightOptionBox')" style="background:#fff; border:1px solid #ddd; padding:8px 12px; font-size:13px; cursor:pointer; display:flex; align-items:center; gap:5px;">
                            키
                            <svg width="10" height="10" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2" fill="none">
                                <polyline points="6 9 12 15 18 9"></polyline>
                            </svg>
                        </button>
                        <div id="heightOptionBox" class="filter-dropdown" style="display:none; position:absolute; top:100%; left:0; width:150px; background:#fff; border:1px solid #000; z-index:100; padding:15px; margin-top:-1px;">
                            <ul class="check-list" style="list-style:none; padding:0; margin-bottom:10px;">
                                <li><label><input type="checkbox"> 150cm 이하</label></li>
                                <li><label><input type="checkbox"> 160cm 대</label></li>
                                <li><label><input type="checkbox"> 170cm 대</label></li>
                                <li><label><input type="checkbox"> 180cm 이상</label></li>
                            </ul>
                            <div class="dropdown-btns" style="display:flex; gap:5px;">
                                <button type="button" class="reset-btn" style="flex:1; border:1px solid #ddd; background:#fff; height:30px;">초기화</button>
                                <button type="button" class="apply-btn" style="flex:1; border:1px solid #000; background:#000; color:#fff; height:30px;" onclick="closeFilter('heightOptionBox')">적용</button>
                            </div>
                        </div>
                    </div>

                    <div class="filter-wrapper" style="position:relative;">
                        <button type="button" class="filter-trigger" onclick="toggleFilter('weightOptionBox')" style="background:#fff; border:1px solid #ddd; padding:8px 12px; font-size:13px; cursor:pointer; display:flex; align-items:center; gap:5px;">
                            몸무게
                            <svg width="10" height="10" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2" fill="none">
                                <polyline points="6 9 12 15 18 9"></polyline>
                            </svg>
                        </button>
                        <div id="weightOptionBox" class="filter-dropdown" style="display:none; position:absolute; top:100%; left:0; width:150px; background:#fff; border:1px solid #000; z-index:100; padding:15px; margin-top:-1px;">
                            <ul class="check-list" style="list-style:none; padding:0; margin-bottom:10px;">
                                <li><label><input type="checkbox"> 40kg 대</label></li>
                                <li><label><input type="checkbox"> 50kg 대</label></li>
                                <li><label><input type="checkbox"> 60kg 대</label></li>
                                <li><label><input type="checkbox"> 70kg 대</label></li>
                                <li><label><input type="checkbox"> 80kg 이상</label></li>
                            </ul>
                            <div class="dropdown-btns" style="display:flex; gap:5px;">
                                <button type="button" class="reset-btn" style="flex:1; border:1px solid #ddd; background:#fff; height:30px;">초기화</button>
                                <button type="button" class="apply-btn" style="flex:1; border:1px solid #000; background:#000; color:#fff; height:30px;" onclick="closeFilter('weightOptionBox')">적용</button>
                            </div>
                        </div>
                    </div>

                    <div class="filter-wrapper" style="position:relative;">
                        <button type="button" class="filter-trigger" onclick="toggleFilter('genderOptionBox')" style="background:#fff; border:1px solid #ddd; padding:8px 12px; font-size:13px; cursor:pointer; display:flex; align-items:center; gap:5px;">
                            성별
                            <svg width="10" height="10" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2" fill="none">
                                <polyline points="6 9 12 15 18 9"></polyline>
                            </svg>
                        </button>
                        <div id="genderOptionBox" class="filter-dropdown" style="display:none; position:absolute; top:100%; left:0; width:120px; background:#fff; border:1px solid #000; z-index:100; padding:15px; margin-top:-1px;">
                            <ul class="check-list" style="list-style:none; padding:0; margin-bottom:10px;">
                                <li><label><input type="checkbox"> 남성</label></li>
                                <li><label><input type="checkbox"> 여성</label></li>
                            </ul>
                            <div class="dropdown-btns" style="display:flex; gap:5px;">
                                <button type="button" class="reset-btn" style="flex:1; border:1px solid #ddd; background:#fff; height:30px;">초기화</button>
                                <button type="button" class="apply-btn" style="flex:1; border:1px solid #000; background:#000; color:#fff; height:30px;" onclick="closeFilter('genderOptionBox')">적용</button>
                            </div>
                        </div>
                    </div>

                </div>

                <div class="review-content-area">
				    <c:choose>
				        <c:when test="${empty reviewList}">
				            <div class="no-review-msg" style="text-align:center; padding:80px 0; color:#999;">
				                <p>리뷰가 없습니다.</p>
				            </div>
				        </c:when>
				        <c:otherwise>
				            <%-- 리스트 반복 시작 --%>
				            <c:forEach var="dto" items="${reviewList}">
				                <div class="review-card" style="display: flex; border-bottom: 1px solid #f4f4f4; padding: 30px 0; min-height: 200px;">
				                    
				                    <%-- 1. 왼쪽 영역: 별점, 내용, 사진, 도움 버튼 --%>
				                    <div class="review-left" style="flex: 1; padding-right: 40px;">
				                        
				                        <%-- 별점 (휠라 전용 남색) --%>
				                        <div class="rating-stars" style="display: flex; gap: 2px; margin-bottom: 15px;">
				                            <c:forEach begin="1" end="${dto.rating}">
				                                <svg viewBox="0 0 24 24" style="width: 16px; height: 16px; fill: #003F96;">
				                                    <path d="M12 .587l3.668 7.568 8.332 1.151-6.064 5.828 1.48 8.279-7.416-3.967-7.417 3.967 1.481-8.279-6.064-5.828 8.332-1.151z"/>
				                                </svg>
				                            </c:forEach>
				                            <c:forEach begin="1" end="${5 - dto.rating}">
				                                <svg viewBox="0 0 24 24" style="width: 16px; height: 16px; fill: #ddd;">
				                                    <path d="M12 .587l3.668 7.568 8.332 1.151-6.064 5.828 1.48 8.279-7.416-3.967-7.417 3.967 1.481-8.279-6.064-5.828 8.332-1.151z"/>
				                                </svg>
				                            </c:forEach>
				                        </div>
				
				                        <%-- 리뷰 텍스트 --%>
				                        <div class="review-text" style="font-size: 14px; line-height: 1.6; color: #1a1a1a; margin-bottom: 20px; white-space: pre-wrap;">${dto.content}</div>
				
				                        <%-- 리뷰 사진 --%>
				                        <%-- 기존 review_img 출력 부분 찾아서 교체 --%>
										<c:if test="${not empty dto.review_img}">
										    <div class="review-images" style="margin-bottom: 20px; display:flex; gap:5px;">
										        
										        <%-- 1. 콤마(,)를 기준으로 문자열을 쪼개서 배열(imgs)로 만듦 --%>
										        <c:set var="imgs" value="${fn:split(dto.review_img, ',')}" />
										        
										        <%-- 2. 쪼개진 개수만큼 반복해서 이미지 출력 --%>
										        <c:forEach var="imgUrl" items="${imgs}">
												    <%-- 1. DB경로(/fila_upload/review/neko1.jpg)에서 파일명(neko1.jpg)만 추출 --%>
												    <c:set var="fileName" value="${fn:substringAfter(imgUrl, '/review/')}" />
												    
												    <%-- 2. 핸들러 주소로 요청 (file 파라미터로 이름 넘김) --%>
												    <img src="${pageContext.request.contextPath}/review/image.htm?file=${fileName}" 
												         style="width: 120px; height: 120px; object-fit: cover; border-radius: 4px; border:1px solid #eee;">
												</c:forEach>
										        
										    </div>
										</c:if>
				
				                        <%-- 도움돼요/안돼요 버튼 섹션 --%>
				                        <div class="like-section" style="display: flex; align-items: center; gap: 15px; margin-top: 10px;">
   
										    <button type="button" onclick="handleLike(this, ${dto.review_id}, 1)" 
										            style="background: none; border: none; cursor: pointer; display: flex; align-items: center; font-size: 12px; padding: 0; ${dto.myLike == 1 ? 'color:#003F96;' : 'color:#666;'}">
										        <svg viewBox="0 0 24 24" style="width: 16px; height: 16px; margin-right: 4px; fill: ${dto.myLike == 1 ? '#003F96' : '#999'};">
										            <path d="M1 21h4V9H1v12zm22-11c0-1.1-.9-2-2-2h-6.31l.95-4.57.03-.32c0-.41-.17-.79-.44-1.06L14.17 1 7.59 7.59C7.22 7.95 7 8.45 7 9v10c0 1.1.9 2 2 2h9c.83 0 1.54-.5 1.84-1.22l3.02-7.05c.09-.23.14-.47.14-.73v-2z"/>
										        </svg>
										        도움돼요 <span style="margin-left: 4px; font-weight: bold;">${dto.like_cnt}</span>
										    </button>
										
										    <%-- 도움안돼요 버튼 (myLike가 0이면 파란색) --%>
										    <button type="button" onclick="handleLike(this, ${dto.review_id}, 0)" 
										            style="background: none; border: none; cursor: pointer; display: flex; align-items: center; font-size: 12px; padding: 0; ${dto.myLike == 0 ? 'color:#003F96;' : 'color:#666;'}">
										        <svg viewBox="0 0 24 24" style="width: 16px; height: 16px; margin-right: 4px; transform: rotate(180deg); fill: ${dto.myLike == 0 ? '#003F96' : '#999'};">
										            <path d="M1 21h4V9H1v12zm22-11c0-1.1-.9-2-2-2h-6.31l.95-4.57.03-.32c0-.41-.17-.79-.44-1.06L14.17 1 7.59 7.59C7.22 7.95 7 8.45 7 9v10c0 1.1.9 2 2 2h9c.83 0 1.54-.5 1.84-1.22l3.02-7.05c.09-.23.14-.47.14-.73v-2z"/>
										        </svg>
										        도움안돼요 <span style="margin-left: 4px; font-weight: bold;">${dto.dislike_cnt}</span>
										    </button>
										
										</div>
				                    </div>
				
				                    <%-- 2. 오른쪽 영역: ID(마스킹), 날짜 (구분선 너머) --%>
				                    <div class="review-right" style="width: 150px; border-left: 1px solid #f4f4f4; padding-left: 20px; display: flex; flex-direction: column; justify-content: flex-start;">
				                        <%-- 마스킹된 ID (3글자 노출) --%>
				                        <div class="user-id" style="font-size: 13px; font-weight: bold; color: #333; margin-bottom: 8px;">
				                            <c:set var="maskId" value="${dto.user_id}" />
				                            ${fn:substring(maskId, 0, 3)}****
				                        </div>
				                        <%-- 날짜 (하단 배치) --%>
				                        <div class="created-at" style="font-size: 12px; color: #999; margin-top: auto;">
				                            <fmt:formatDate value="${dto.regdate}" pattern="yyyy. MM. dd." />
				                        </div>
				                    </div>
				
				                </div>
				            </c:forEach>
				        </c:otherwise>
				    </c:choose>
				</div>
            </div>
        </div>


        <div id="reviewWriteView" style="height:100%; display:none; flex-direction:column;">
            
            <div class="head">
                <div class="goods-info">
                    <div class="photo">
                        <img src="${not empty product.image_url ? product.image_url : '//filacdn.styleship.com/filaproduct2/data/productimages/a/1/FS253IP02F003_734.jpg'}" alt="상품이미지">
                    </div>
                    <div class="info">
                        <p class="txt1">후기 작성</p>
                    </div>
                </div>
                <button type="button" class="close__btn" onclick="switchToList()">close</button>
            </div>

            <div class="con" style="flex:1; overflow-y:auto; padding: 0 20px;">
		        <form id="reviewForm" action="${pageContext.request.contextPath}/review/insert.htm" method="post" enctype="multipart/form-data">
		            <input type="hidden" name="productNo" value="${product.product_id}">
		            
		            <%-- 별점 선택 영역 --%>
		            <div style="text-align:center; padding: 40px 0; border-bottom:1px solid #eee;">
		                <p style="font-weight:700; font-size: 18px; margin-bottom:20px; color:#000;">상품은 만족하셨나요?</p>
		                <div class="stars-wrap" style="display:flex; justify-content:center; gap:8px; cursor:pointer;" id="starBox">
		                    <input type="hidden" name="reviewScore" id="reviewScore" value="5">
		                    
		                    <%-- 별 5개 생성: 1번부터 5번까지 --%>
		                    <c:forEach var="i" begin="1" end="5">
		                        <span class="star-svg-wrap" onclick="setRating(${i})">
		                            <svg viewBox="0 0 24 24" class="write-star-svg" data-index="${i}" style="width: 45px; height: 45px; fill: #003F96; transition: 0.2s;">
		                                <path d="M12 .587l3.668 7.568 8.332 1.151-6.064 5.828 1.48 8.279-7.416-3.967-7.417 3.967 1.481-8.279-6.064-5.828 8.332-1.151z"/>
		                            </svg>
		                        </span>
		                    </c:forEach>
		                </div>
		                <div id="scoreText" style="margin-top:15px; font-weight:700; font-size: 16px; color: #003F96;">아주 좋아요</div>
		            </div>
		
		            <%-- 내용 입력 영역 --%>
		            <div style="padding: 30px 0;">
		                <label style="display:block; font-weight:700; font-size: 17px; margin-bottom:15px; color:#000;">내용 입력</label>
		                <textarea name="reviewContent" style="width:100%; height:220px; padding:20px; border:1px solid #ddd; resize:none; box-sizing:border-box; font-size: 16px; line-height: 1.6;" 
		                          placeholder="착용감, 사이즈 등 솔직한 후기를 남겨주세요."></textarea>
		            </div>
		
		            <%-- 사진 첨부 영역 --%>
		            <div style="padding-bottom:30px; border-top: 1px solid #f9f9f9; padding-top: 20px;">
					    <label style="display:block; font-weight:700; font-size: 17px; margin-bottom:15px; color:#000;">
					        사진 첨부 
					        <%-- [NEW] 현재 몇 개 골랐는지 보여주는 숫자 카운터 추가 --%>
					        <span id="fileCount" style="font-size:14px; color:#003F96; font-weight:bold; margin-left:5px;">(0/4)</span>
					    </label>
					    
					    <div style="margin-top:10px;">
					        <%-- multiple 필수 --%>
					        <input type="file" id="reviewFiles" name="reviewFiles" accept="image/*" multiple onchange="handleImgPreview(this)" style="font-size: 15px;">
					    </div>
					
					    <%-- [중요] 여기가 미리보기가 들어갈 자리입니다. 이 div가 없으면 사진이 안 보여요! --%>
					    <div id="imgPreviewBox" style="display:flex; gap:10px; margin-top:15px; flex-wrap:wrap; min-height: 20px;">
					        <%-- 스크립트가 여기에 썸네일을 꽂아줍니다 --%>
					    </div>
					</div>
		
		            <%-- 등록 버튼 --%>
		            <div style="margin-top:20px; padding-bottom: 40px;">
		                <a href="javascript:void(0);" onclick="submitReviewAjax();" 
   style="display:block; width:100%; height:65px; line-height:65px; text-align:center; background:#000; color:#fff; font-size:19px; font-weight:700; border-radius:35px; text-decoration: none;">등록하기</a>
		            </div>
		        </form>
		    </div>
        </div>

    </div>
</div>

<script>
// [전역 변수]
var sel_files = [];

// [1] 모달 열기
function openReviewModal() {
    $('#reviewModal').fadeIn(200);
    $('body').addClass('no-scroll');
    switchToList(); 
}

// [2] 모달 닫기
function closeReviewModal() {
    $('#reviewModal').fadeOut(200);
    $('body').removeClass('no-scroll');
    resetWriteForm();
}

// [3] 작성 화면 전환 (초기화 포함)
function switchToWrite() {
    var isLogOut = ${empty auth}; 
    if (isLogOut) {
        alert("로그인이 필요한 기능입니다.");
        location.href = "${pageContext.request.contextPath}/login.htm";
        return; 
    }
    resetWriteForm(); // 초기화
    $('#reviewListView').hide(); 
    $('#reviewWriteView').css('display', 'flex'); 
}

// [초기화 함수]
function resetWriteForm() {
    sel_files = [];
    $("#imgPreviewBox").empty();
    $("#reviewFiles").val("");
    $("textarea[name='reviewContent']").val("");
    setRating(5);
    $("#scoreText").text("아주 좋아요");
    $(".write-star-svg").css("fill", "#003F96");
    
    // [NEW] 숫자 카운터 초기화
    $("#fileCount").text("(0/4)");
}

// [4] 목록 화면
function switchToList() {
    $('#reviewWriteView').hide();
    $('#reviewListView').css('display', 'flex');
}

// [5] 별점
function setRating(rating) {
    $("#reviewScore").val(rating);
    $(".write-star-svg").each(function() {
        var starIndex = $(this).data("index");
        if (starIndex <= rating) $(this).css("fill", "#003F96");
        else $(this).css("fill", "#ddd");
    });
    var scoreTexts = ["", "별로예요", "그냥 그래요", "보통이에요", "맘에 들어요", "아주 좋아요"];
    $("#scoreText").text(scoreTexts[rating]);
}

// ============================================================
// [6] 이미지 미리보기 & 개수 카운팅 (업그레이드)
// ============================================================
function handleImgPreview(e) {
    var files = e.files;
    var filesArr = Array.prototype.slice.call(files);

    var totalCnt = sel_files.length + filesArr.length;

    // 1. 개수 체크
    if (totalCnt > 4) {
        alert("사진은 최대 4장까지만 등록 가능합니다.\n(현재 " + sel_files.length + "장 + 선택 " + filesArr.length + "장 = 총 " + totalCnt + "장)");
        $(e).val(""); 
        return;
    }

    // 2. 파일 처리
    filesArr.forEach(function(f) {
        if (!f.type.match("image.*")) {
            alert("이미지 파일만 업로드 가능합니다.");
            return;
        }

        sel_files.push(f); 

        var reader = new FileReader();
        reader.onload = function(e) {
            var html = 
                '<div class="img-thumb" style="position:relative; width:80px; height:80px; margin-right:10px; margin-bottom:10px; display:inline-block;">' +
                '   <img src="' + e.target.result + '" style="width:100%; height:100%; object-fit:cover; border-radius:4px; border:1px solid #ddd;">' +
                '   <button type="button" onclick="deleteSelImage(this, \'' + f.name + '\')" ' +
                '       style="position:absolute; top:-5px; right:-5px; background:#000; color:#fff; border:0; width:20px; height:20px; border-radius:50%; font-size:12px; cursor:pointer; display:flex; align-items:center; justify-content:center;">X</button>' +
                '</div>';
            $("#imgPreviewBox").append(html);
        }
        reader.readAsDataURL(f);
    });
    
    // [NEW] 개수 텍스트 갱신
    updateFileCount();
    
    $(e).val(""); // input 초기화
}

function deleteSelImage(btn, fileName) {
    sel_files = sel_files.filter(function(f) {
        return f.name !== fileName;
    });
    $(btn).parent().remove();
    
    // [NEW] 개수 텍스트 갱신
    updateFileCount();
}

// [NEW] 카운트 업데이트 함수
function updateFileCount() {
    $("#fileCount").text("(" + sel_files.length + "/4)");
}

// [AJAX] 리뷰 등록
function submitReviewAjax() {
    var content = $("textarea[name='reviewContent']").val();
    var rating = $("#reviewScore").val();
    var productNo = $("input[name='productNo']").val();

    if (!content) {
        alert("내용을 입력해주세요.");
        return;
    }

    var formData = new FormData();
    formData.append("productNo", productNo);
    formData.append("reviewContent", content);
    formData.append("reviewScore", rating);

    for (var i = 0; i < sel_files.length; i++) {
        formData.append("file" + (i+1), sel_files[i]);
    }

    $.ajax({
        url: "${pageContext.request.contextPath}/review/insert.htm",
        type: "POST",
        data: formData,
        processData: false, 
        contentType: false, 
        dataType: "json",   
        success: function(res) {
            if (res.status === "success") {
                alert("리뷰가 등록되었습니다.");
                location.reload(); 
            } else {
                alert(res.message);
            }
        },
        error: function(err) {
            alert("등록 중 오류가 발생했습니다.");
            console.log(err);
        }
    });
}
// ============================================================

// [7] 필터, [8] 좋아요 함수는 그대로 두시면 됩니다 (생략)
function toggleFilter(id) { var $el = $('#' + id); var isOpen = $el.is(':visible'); $('.filter-dropdown').hide(); if (!isOpen) $el.show(); }
function closeFilter(id) { $('#' + id).hide(); }
$(document).on('click', function(e) { if (!$(e.target).closest('.filter-wrapper').length) { $('.filter-dropdown').hide(); } });

function handleLike(btn, reviewId, type) {
    var isLogin = ${empty sessionScope.auth ? "false" : "true"};
    if (!isLogin) { alert("로그인이 필요한 기능입니다."); location.href = "${pageContext.request.contextPath}/login.htm"; return; }
    $.ajax({
        url: "${pageContext.request.contextPath}/review/like.htm",
        type: "POST",
        data: { reviewId: reviewId, type: type },
        dataType: "text", 
        success: function(res) {
            var result = res.trim();
            if (result === "1") {
                var countSpan = $(btn).find("span");
                countSpan.text(parseInt(countSpan.text()) + 1);
                $(btn).find("svg").css("fill", "#003F96");
                $(btn).css("color", "#003F96");
                alert("반영되었습니다."); 
            } else if (result === "-1") { alert("이미 평가하신 리뷰입니다."); }
            else if (result === "login") { alert("로그인이 필요한 기능입니다."); location.href = "${pageContext.request.contextPath}/login.htm"; }
            else { alert("오류 발생"); }
        },
        error: function() { alert("통신 오류"); }
    });
}
</script>
