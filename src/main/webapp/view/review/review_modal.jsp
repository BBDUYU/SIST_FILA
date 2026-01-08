<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<style>
    /* 1. 모달 기본 설정 */
    #reviewModal { display: none; }

    /* --- iframe 안에 있던 디자인(배너, 필터 등)이라 추가한 것 --- */
    
    /* 1. 포인트 안내 배너 */
    .point-guide-banner {
    	margin-top: 35px;
        background-color: #f8f8f8; padding: 25px;
        display: flex; justify-content: space-between; align-items: center;
        border-bottom: 1px solid #eee; margin-bottom: 20px;
    }
    .point-txt h4 { color: #d94d4d; font-size: 14px; margin: 0 0 5px 0; font-weight: bold; }
    .point-txt p { font-size: 12px; color: #888; margin: 0; }
    .point-badges span {
        display: inline-block; background: #fff; border: 1px solid #eee;
        border-radius: 15px; padding: 4px 12px; font-size: 11px; color: #666; margin-left: 5px;
    }
    .point-badges span strong { color: #d94d4d; }

    /* 2. 별점 및 타이틀 */
    .review-summary-head { display: flex; align-items: center; margin-bottom: 15px; }
    .review-summary-head h3 { font-size: 16px; font-weight: bold; margin-right: 10px; }
    .big-rating { font-size: 30px; font-weight: bold; display: flex; align-items: center; }
    .big-rating .star-icon { color: #002053; font-size: 32px; margin-right: 5px; } 

    /* 3. 필터 & 검색바 */
    .filter-toolbar {
        display: flex; justify-content: space-between; align-items: center;
        padding-bottom: 15px; border-bottom: 1px solid #eee; margin-bottom: 15px;
    }
    .sort-opts a { margin-right: 15px; font-size: 13px; color: #999; cursor: pointer; text-decoration: none;}
    .sort-opts a.active { color: #000; font-weight: bold; }
    .search-box input { border: 1px solid #ddd; padding: 8px 10px; width: 200px; font-size: 13px; }

    /* 4. 칩 필터 */
    .chip-filters { display: flex; gap: 8px; padding-bottom: 15px; border-bottom: 1px solid #eee; margin-bottom: 20px; }
    .chip {
        border: 1px solid #eee; padding: 7px 12px; border-radius: 4px; font-size: 12px; 
        background: #fff; cursor: pointer; color: #666;
    }

    /* 5. 리스트 / 없음 메시지 */
    .no-review-msg { text-align: center; padding: 80px 0; color: #999; }
</style>

<div class="common__layer _review" id="reviewModal">
    
    <div class="layer-bg__wrap" onclick="closeReviewModal()"></div>

    <div class="inner">
        <div class="head">
            <div class="goods-info">
                <div class="photo">
                    <img src="${not empty product.image_url ? product.image_url : '//filacdn.styleship.com/filaproduct2/data/productimages/a/1/FS253IP02F003_734.jpg'}" alt="상품이미지">
                </div>

                <div class="info">
                    <div>
                        <p class="txt1">${product.name != null ? product.name : '4부 포켓 바이커쇼츠'}</p>
                    </div>

                    <button type="button" class="review-write__btn" onclick="location.href='/review/write.do?productNo=${product.product_id}'">
                        작성하기
                    </button>
                </div>
            </div>
            <button type="button" class="close__btn" onclick="closeReviewModal()">close</button>
        </div>

        <div class="con">
            
            <div class="point-guide-banner">
                <div class="point-txt">
                    <h4>구매확정 후 90일 이내 상품평 작성 시, 최대 2,000 포인트의 혜택을 드립니다.</h4>
                    <p>작성하신 상품평에 대한 포인트 지급은 작성 후 15일 이내로 적립됩니다.</p>
                </div>
                <div class="point-badges">
                    <span>텍스트 리뷰 500 포인트</span>
                    <span>포토·동영상 리뷰 1,000 포인트</span>
                    <span>최초 리뷰 <strong>X2 포인트</strong></span>
                </div>
            </div>

            <div style="margin-top: 30px;">
                <h3 style="font-weight: bold; font-size: 16px;">REVIEW</h3>
                <div class="big-rating">
                    <span class="star-icon">★</span> 
                    <span>${product.review_score > 0 ? product.review_score : '-'}</span>
                </div>
            </div>

            <div class="filter-toolbar">
                <div class="sort-opts">
                    <a class="active">최신순</a>
                    <a>✨ AI 추천순</a>
                    <a>별점순</a>
                </div>
                <div class="search-box">
                    <input type="text" placeholder="리뷰 키워드 검색">
                </div>
            </div>

            <div class="chip-filters">
                <button class="chip">별점</button>
                <button class="chip">사이즈 어때요?</button>
                <button class="chip">키</button>
                <button class="chip">몸무게</button>
                <button class="chip">성별</button>
            </div>

            <div class="review-content-area">
                <c:choose>
                    <c:when test="${empty reviewList}">
                        <div class="no-review-msg">
                            <p>리뷰가 없습니다.</p>
                        </div>
                    </c:when>

                    <c:otherwise>
                        <c:forEach var="dto" items="${reviewList}">
                            <div class="review-item" style="border-bottom:1px solid #eee; padding: 20px 0;">
                                <div class="user-info" style="margin-bottom:10px; display:flex; justify-content:space-between;">
                                    <div>
                                        <strong>${dto.writer}</strong> 
                                        <span style="color:#999; font-size:12px; margin-left:10px;">${dto.regDate}</span>
                                    </div>
                                    <div style="color:#111;">
                                        <c:forEach begin="1" end="${dto.rating}">★</c:forEach>
                                        <c:forEach begin="1" end="${5 - dto.rating}">☆</c:forEach>
                                    </div>
                                </div>
                                <div class="review-cont">
                                    <p style="white-space: pre-wrap; line-height:1.5;">${dto.content}</p>
                                    <c:if test="${not empty dto.reviewImg}">
                                        <div style="margin-top:15px;">
                                            <img src="${dto.reviewImg}" style="max-width: 150px; border-radius:4px;">
                                        </div>
                                    </c:if>
                                </div>
                            </div>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </div>

        </div>
    </div>
</div>