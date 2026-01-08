<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

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
                    <h3 style="font-weight: 700; font-size: 16px; color:#000;">REVIEW</h3>
                    <div class="big-rating">
                        <span class="star-icon" style="color:#002053;">★</span> 
                        <span>${product.review_score > 0 ? product.review_score : '0.0'}</span>
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
                            <c:forEach var="dto" items="${reviewList}">
                                <div class="review-item" style="border-bottom:1px solid #eee; padding: 20px 0;">
                                    <div class="user-info" style="margin-bottom:10px; display:flex; justify-content:space-between;">
                                        <strong>${dto.writer}</strong> 
                                        <span style="color:#999; font-size:12px;">${dto.regDate}</span>
                                    </div>
                                    <div style="color:#000; margin-bottom:10px;">
                                        <c:forEach begin="1" end="${dto.rating}">★</c:forEach>
                                        <c:forEach begin="1" end="${5 - dto.rating}">☆</c:forEach>
                                    </div>
                                    <p style="white-space: pre-wrap; line-height:1.5;">${dto.content}</p>
                                    <c:if test="${not empty dto.reviewImg}">
                                        <div style="margin-top:15px;">
                                            <img src="${dto.reviewImg}" style="width: 100px; height: 100px; object-fit: cover; border-radius:4px;">
                                        </div>
                                    </c:if>
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

            <div class="con" style="flex:1; overflow-y:auto;">
                <form id="reviewForm" action="${pageContext.request.contextPath}/review/insert.htm" method="post" enctype="multipart/form-data">
                    <input type="hidden" name="productNo" value="${product.product_id}">
                    
                    <div style="text-align:center; padding: 30px 0; border-bottom:1px solid #eee;">
                        <p style="font-weight:700; margin-bottom:15px;">상품은 만족하셨나요?</p>
                        <div class="stars-wrap" style="font-size:40px; color:#ddd; cursor:pointer;" id="starBox">
                            <input type="hidden" name="reviewScore" id="reviewScore" value="5">
                            <span class="star-icon on" onclick="setRating(1)" style="color:#000;">★</span>
                            <span class="star-icon on" onclick="setRating(2)" style="color:#000;">★</span>
                            <span class="star-icon on" onclick="setRating(3)" style="color:#000;">★</span>
                            <span class="star-icon on" onclick="setRating(4)" style="color:#000;">★</span>
                            <span class="star-icon on" onclick="setRating(5)" style="color:#000;">★</span>
                        </div>
                        <div id="scoreText" style="margin-top:10px; font-weight:bold;">아주 좋아요</div>
                    </div>

                    <div style="padding: 20px 0;">
                        <label style="display:block; font-weight:700; margin-bottom:10px;">내용 입력</label>
                        <textarea name="reviewContent" style="width:100%; height:200px; padding:15px; border:1px solid #ddd; resize:none; box-sizing:border-box;" placeholder="착용감, 사이즈 등 솔직한 후기를 남겨주세요. (최소 10자 이상)"></textarea>
                    </div>

                    <div style="padding-bottom:20px;">
                        <label style="display:block; font-weight:700; margin-bottom:10px;">사진 첨부</label>
                        <div style="margin-top:10px;">
                            <input type="file" id="reviewFile" name="reviewFile" accept="image/*" onchange="previewImage(this)">
                        </div>
                        <div id="imgPreviewBox" style="display:none; margin-top:10px; position:relative; width:100px;">
                            <img id="imgPreview" src="" style="width:100px; height:100px; object-fit:cover;">
                            <button type="button" onclick="deleteImage()" style="position:absolute; top:0; right:0; background:#000; color:#fff; border:0; cursor:pointer;">X</button>
                        </div>
                    </div>

                    <div style="margin-top:20px;">
                        <a href="javascript:void(0);" onclick="$('#reviewForm').submit();" style="display:block; width:100%; height:60px; line-height:60px; text-align:center; background:#000; color:#fff; font-size:18px; font-weight:700; border-radius:30px;">등록하기</a>
                    </div>
                </form>
            </div>
        </div>

    </div>
</div>

<script>
//[1] 모달 열기
function openReviewModal() {
    $('#reviewModal').fadeIn(200);
    $('body').addClass('no-scroll');
    switchToList(); // 항상 목록 화면부터 시작
}

// [2] 모달 닫기
function closeReviewModal() {
    $('#reviewModal').fadeOut(200);
    $('body').removeClass('no-scroll');
}

//[3] 작성 화면 보여주기
function switchToWrite() {
    // 1. 로그인 체크
    var isLogOut = ${empty auth}; 
    
    if (isLogOut) {
        alert("로그인이 필요한 기능입니다.");
        location.href = "${pageContext.request.contextPath}/login.htm";
        return; 
    }

    $('#reviewListView').hide(); // 목록 화면 숨기기
    $('#reviewWriteView').css('display', 'flex'); // 작성 화면 보여주기 (flex 구조 유지)
    
    console.log("리뷰 작성 화면으로 전환 완료");
}

// [4] 목록 화면 보여주기
function switchToList() {
    $('#reviewWriteView').hide();
    $('#reviewListView').css('display', 'flex');
}

// [5] 별점 기능
function setRating(score) {
    $('#reviewScore').val(score);
    var texts = ['별로예요', '그저 그래요', '보통이에요', '좋아요', '아주 좋아요'];
    
    $('#starBox span').each(function(index) {
        if (index < score) {
            $(this).css('color', '#000');
        } else {
            $(this).css('color', '#ddd');
        }
    });
    $('#scoreText').text(texts[score-1]);
}

// [6] 이미지 미리보기
function previewImage(input) {
    if (input.files && input.files[0]) {
        var reader = new FileReader();
        reader.onload = function(e) {
            $('#imgPreview').attr('src', e.target.result);
            $('#imgPreviewBox').show();
        };
        reader.readAsDataURL(input.files[0]);
    }
}

function deleteImage() {
    $('#reviewFile').val('');
    $('#imgPreviewBox').hide();
}

// [7] 필터 토글
function toggleFilter(id) {
    var $el = $('#' + id);
    var isOpen = $el.is(':visible');
    $('.filter-dropdown').hide(); 
    if (!isOpen) $el.show();
}

function closeFilter(id) {
    $('#' + id).hide();
}

$(document).on('click', function(e) {
    if (!$(e.target).closest('.filter-wrapper').length) {
        $('.filter-dropdown').hide();
    }
});
</script>
