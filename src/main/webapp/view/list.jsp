<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html class="no-js" lang="ko-KR">
<head>
    <meta charset="UTF-8">
    <meta name="format-detection" content="telephone=no">

    <title>의류 | FILA</title>

    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.1, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi">

    <link rel="icon" type="image/x-icon" href="//filacdn.styleship.com/filacontent2/favicon.ico" />

    <link rel="stylesheet" href="http://localhost/SIST_FILA/css/layout.css">
    <link rel="stylesheet" href="http://localhost/SIST_FILA/css/normalize.css" />
    <link rel="stylesheet" href="http://localhost/SIST_FILA/css/opt-default.css">
    <link rel="stylesheet" href="http://localhost/SIST_FILA/css/product.css">
    <link rel="stylesheet" href="http://localhost/SIST_FILA/css/SpoqaHanSansNeo.css">
    <link rel="stylesheet" href="http://localhost/SIST_FILA/css/sub.css">
    <link rel="stylesheet" href="http://localhost/SIST_FILA/css/swiper-bundle.css">

    <!-- jQuery는 Swiper 초기화에 필요하니 먼저 -->
    <script src="http://localhost/SIST_FILA/js/jquery-1.12.4.js"></script>
    <script src="http://localhost/SIST_FILA/js/default.js"></script>
    <script src="http://localhost/SIST_FILA/js/matizResizeMap.1.0.0.js"></script>
    <script src="http://localhost/SIST_FILA/js/mighty.base.1.5.7.js"></script>
    <script src="http://localhost/SIST_FILA/js/swiper-bundle.js"></script>
    <script src="http://localhost/SIST_FILA/js/TweenMax.js"></script>
</head>

<body class="list filter--open">

    <!-- start of :: wrap -->
    <div id="wrap">

        <!-- header include -->
        <jsp:include page="header.jsp" />

        <section class="goods-list-box _thumb04">
            <h2 class="hidden">상품 리스트</h2>

            <div class="head">
                <div class="tit-box">
                    <p class="tit">WOMEN<b>&gt;</b><e>의류</e></p>
                </div>
                <div class="sorting-box">
                    <div><button type="button" class="filter__btn">필터</button></div>
                </div>
            </div>

            <div class="con">
                <div class="filter-box">
                    <div class="category-box">
                        <ul>
                            <li class="on"><a href="#">전체</a></li>
                            <li><a href="#">아우터</a></li>
                        </ul>
                    </div>
                </div>

                <div class="list-box">
                    <ul class="goods__list _type_v2" id="product_list">

                        <c:if test="${empty productList}">
                            <div style="width:100%; padding:50px; text-align:center; font-size:16px;">
                                등록된 상품이 없습니다.<br>
                                (서블릿(/products/list)로 접속했는지 확인)
                            </div>
                        </c:if>

                        <c:forEach var="item" items="${productList}">
                            <c:set var="finalPrice" value="${item.price * (100 - item.discount_rate) / 100}" />

                            <li class="goods">
                                <div class="photo">
                                    <a href="product_detail.jsp?product_id=${item.product_id}">
                                        <img src="${item.image_url}" alt="${item.name}">
                                    </a>
                                    <button type="button" class="wish__btn wish" onclick="alert('찜하기!')">wish</button>
                                </div>

                                <div class="info">
                                    <a href="product_detail.jsp?product_id=${item.product_id}">
                                        <div class="top">
                                            <p class="category">FILA</p>
                                            <div class="tag">
                                                <c:if test="${item.discount_rate > 0}">
                                                    <p style="color:#cf0a2c; font-weight:bold;">SALE</p>
                                                </c:if>
                                                <c:if test="${item.status == 'NEW'}">
                                                    <p style="color:blue; font-weight:bold;">NEW</p>
                                                </c:if>
                                            </div>
                                        </div>

                                        <p class="name">${item.name}</p>

                                        <div class="price">
                                            <c:choose>
                                                <c:when test="${item.discount_rate > 0}">
                                                    <p class="sale"><fmt:formatNumber value="${finalPrice}" pattern="#,###" />원</p>
                                                    <p class="normal _sale"><fmt:formatNumber value="${item.price}" pattern="#,###" />원</p>
                                                    <p class="percent">${item.discount_rate}%</p>
                                                </c:when>
                                                <c:otherwise>
                                                    <p class="sale"><fmt:formatNumber value="${item.price}" pattern="#,###" />원</p>
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
            <div class="hd"><h2>고객님을 위한 추천 상품</h2></div>
            <div class="slider-box">
                <div class="goods__slider swiper">
                    <div class="swiper-wrapper">
                        <c:forEach var="item" items="${productList}">
                            <div class="goods swiper-slide">
                                <div class="photo">
                                    <div class="before">
                                        <a href="product_detail.jsp?product_id=${item.product_id}">
                                            <img src="${item.image_url}" alt="${item.name}">
                                        </a>
                                    </div>
                                </div>
                                <div class="info">
                                    <a href="product_detail.jsp?product_id=${item.product_id}">
                                        <div class="top"><p class="category">공용</p></div>
                                        <p class="name">${item.name}</p>
                                        <div class="price">
                                            <p class="sale"><fmt:formatNumber value="${item.price}" pattern="#,###" />원</p>
                                        </div>
                                    </a>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                    <div class="goods-slider-scrollbar swiper-scrollbar-horizontal"></div>
                </div>
            </div>
        </section>
        <!-- //추천 상품 -->

    </div>
    <!-- // end of :: wrap -->

    <!-- 하단 고정 버튼 (top, sns) -->
    <div class="bot-fix-box">
        <div class="inner">
            <button type="button" class="today-goods__btn" onclick="alert('나중에!')">
                <svg id="btn_time" xmlns="http://www.w3.org/2000/svg" width="29" height="29" viewBox="0 0 29 29">
                    <g id="icon" transform="translate(-0.025 -0.025)">
                        <path d="M17.05,24.66A14,14,0,1,0,19.5,9.572l.253-3.648" transform="translate(-15.29 -4.475)" fill="none" stroke="#707070" stroke-linecap="round" stroke-linejoin="round" stroke-width="1"></path>
                        <path d="M6.537,83.1a14.542,14.542,0,0,0-.3,12.37" transform="translate(-4.475 -75.062)" fill="none" stroke="#707070" stroke-linecap="round" stroke-linejoin="round" stroke-width="1" stroke-dasharray="40 40"></path>
                        <path d="M114.512,80.167v6.806l-3.662,3.662" transform="translate(-99.914 -72.362)" fill="none" stroke="#707070" stroke-linecap="round" stroke-linejoin="round" stroke-width="2"></path>
                        <line x1="3.654" transform="translate(4.307 5.263)" fill="none" stroke="#707070" stroke-linecap="round" stroke-linejoin="round" stroke-width="1"></line>
                    </g>
                </svg>
            </button>
            <button type="button" class="top__btn" onclick="window.scrollTo({top:0, behavior:'smooth'})">top</button>
        </div>
    </div>
    <!-- //하단 고정 버튼 (top, sns) -->

    <!-- footer -->
    <jsp:include page="footer.jsp" />

    <script>
        $(document).ready(function(){
            if(typeof Swiper !== 'undefined') {
                new Swiper('.goods__slider', {
                    slidesPerView: 4,
                    spaceBetween: 10,
                    freeMode: true,
                    scrollbar: {
                        el: '.goods-slider-scrollbar',
                        draggable: true,
                    },
                });
            }
        });
    </script>

</body>
</html>
