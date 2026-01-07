<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 🔥 mypage layout fragment (include 전용) -->
<link rel="icon" type="image/x-icon" href="//filacdn.styleship.com/filacontent2/favicon.ico" />
<link href="http://localhost/SIST_FILA/css/SpoqaHanSansNeo.css" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/normalize.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/opt-default.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/swiper-bundle.css">
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
<script src="${pageContext.request.contextPath}/js/default.js?v=202504161631"></script>
<script src="${pageContext.request.contextPath}/js/main.js"></script>
<!-- 🔴 중요: wrap 안에 contents -->
<div id="wrap">

    <!-- 🔥 중요: class 반드시 mypage__contents -->
    <div id="contents" class="mypage__contents">

        <!-- ===================== -->
        <!-- 상단 회원 요약 영역 -->
        <!-- ===================== -->
        <div class="mypage__tab">
            <div class="inner">

                <!-- 회원 정보 -->
                <div class="my-info-box">
                    <div class="top">
                        <p class="level">WHITE</p>
                        <a href="#" class="benefit__btn">혜택보기</a>
                    </div>

                    <p class="name">
                        <span>
                            <c:out value="${auth.name != null ? auth.name : '회원'}"/>
                        </span>님
                    </p>

                    <a href="#" class="info-modify__btn">내 정보 변경</a>
                </div>

                <!-- 쿠폰 / 포인트 / 위시 / 주문 -->
                <div class="my-link-box">
                    <div>
                        <a href="#">
                            <dl>
                                <dt>쿠폰</dt>
                                <dd>0개</dd>
                            </dl>
                        </a>
                    </div>
                    <div>
                        <a href="#">
                            <dl>
                                <dt>포인트</dt>
                                <dd>0P</dd>
                            </dl>
                        </a>
                    </div>
                    <div>
                        <a href="#">
                            <dl>
                                <dt>위시리스트</dt>
                                <dd>0개</dd>
                            </dl>
                        </a>
                    </div>
                    <div>
                        <a href="#">
                            <dl>
                                <dt>주문내역</dt>
                                <dd>0건</dd>
                            </dl>
                        </a>
                    </div>
                </div>

            </div>
        </div>

        <!-- ===================== -->
        <!-- 하단 본문 영역 -->
        <!-- ===================== -->
        <div class="mypage__area">

            <!-- 좌측 LNB -->
            <div class="my-lnb">
                <h2 class="tit__style4">마이페이지</h2>

                <!-- 쇼핑정보 -->
                <div>
                    <p class="tit">쇼핑정보</p>
                    <ul>
                    <li><a href="${pageContext.request.contextPath}/mypage/orders.htm">주문 · 배송 조회</a></li>
                    <li><a href="${pageContext.request.contextPath}/mypage/inquiry.htm">교환 · 취소 · 반품 조회</a></li>
                        <li><a href="#"></a></li>
                        <li><a href="${pageContext.request.contextPath}/mypage/review.htm">리뷰</a></li>
                    </ul>
                </div>

                <!-- 상품정보 -->
                <div>
                    <p class="tit">상품정보</p>
                    <ul>
                        <li><a href="${pageContext.request.contextPath}/mypage/wishlist.htm">위시리스트</a></li>
                        <li><a href="#">오늘 본 상품</a></li>
                        <li><a href="#">커스텀 스튜디오</a></li>
                        <li><a href="#">재입고 알림</a></li>
                    </ul>
                </div>

                <!-- 회원정보 -->
                <div>
                    <p class="tit">회원정보</p>
                    <ul>
                        <li><a href="#">내 정보 변경</a></li>
                       <li><a href="${pageContext.request.contextPath}/mypage/delivery_address.htm">배송지 관리</a></li>
                       <li><a href="${pageContext.request.contextPath}/mypage/lgmanage.htm">로그인 관리</a></li>
                    </ul>
                </div>

                <!-- 고객센터 -->
                <div>
                    <p class="tit">고객센터</p>
                    <ul>
                        <li>
                            <a href="${pageContext.request.contextPath}/mypage/qna.htm">1:1 문의</a></li>
                        <li><a href="${pageContext.request.contextPath}/mypage/as.htm">A/S 현황 조회</a></li>
                       
                    </ul>
                </div>
            </div>

            <!-- 🔥 우측 콘텐츠는 각 페이지(qna.jsp 등)에서 채움 -->
            <!-- ex) <section class="my-con"> ... </section> -->

