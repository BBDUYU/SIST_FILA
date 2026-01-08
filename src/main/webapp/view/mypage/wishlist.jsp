<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <title>위시리스트 | FILA</title>

    <!-- CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/normalize.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/opt-default.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/layout.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/product.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/sub.css">

    <!-- jQuery -->
    <script src="${pageContext.request.contextPath}/js/jquery-1.12.4.js"></script>

    <!-- 🔥 모달 강제 표시용 보정 CSS -->
    <style>
        .common__layer {
            position: fixed !important;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: 9999 !important;
            display: none;
        }
        .common__layer .layer_dim {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0,0,0,.6);
        }
        .common__layer .inner {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background: #fff;
            width: 90%;
            max-width: 420px;
            border-radius: 8px;
            padding: 20px;
        }
        .common__layer .head {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
    </style>
</head>

<body>

<jsp:include page="/view/common/header.jsp"/>
<jsp:include page="/view/mypage/mypage.jsp"/>

	<section class="my-con wishlist">
	  <h2 class="tit__style4">위시리스트</h2>
	
	  <div class="odr-box">
	    <form name="form5">
	      <div class="odr-hd">
	        <div>
	          <input type="checkbox" id="checkAll" title="상품 선택" class="cb__style1">
	          <label for="checkAll">선택</label>
	        </div>
	        <div class="txt-btn">
	          <a href="javascript:void(0);" id="btnDeleteSelected">선택삭제</a>
	        </div>
	      </div>
	
	      <ul class="odr__list __my_chk">
	        <c:choose>
	          <c:when test="${empty wishList}">
	            <p class="odr-txt_none">위시리스트가 비었습니다.</p>
	          </c:when>
	
	          <c:otherwise>
	            <c:forEach var="w" items="${wishList}">
	              <li class="odr__item" style="display:flex; align-items:center; gap:20px; padding:20px 0; border-top:1px solid #eee;">
	                <div>
	                  <input type="checkbox" class="cb__style1 wishChk" value="${w.wishlistId}">
	                </div>
	
	                <div style="display:flex; align-items:center; gap:20px; flex:1;">
	                  <a href="${pageContext.request.contextPath}/product/product_detail.htm?product_id=${w.productId}">
	                    <c:choose>
	                      <c:when test="${empty w.imageUrl}">
	                        <div style="width:120px; height:120px; background:#f3f3f3;"></div>
	                      </c:when>
	                      <c:otherwise>
	                        <img src="${w.imageUrl}" alt="${w.productName}" style="width:120px; height:120px; object-fit:cover;">
	                      </c:otherwise>
	                    </c:choose>
	                  </a>
	
	                  <div style="min-width:300px;">
	                    <div style="font-weight:700;">FILA</div>
	                    <div style="margin:6px 0; font-size:16px; font-weight:600;">${w.productName}</div>
	
	                    <!-- ✅ DB수정 없이 "사이즈만" : 지금은 고정값 -->
	                    <div style="color:#777; font-size:13px;">W85(WS)</div>
	
	                    <div style="margin-top:8px; font-weight:700;">
	                      <fmt:formatNumber value="${w.price}" pattern="#,###"/>원
	                    </div>
	                  </div>
	                </div>
	
	                <div style="display:flex; align-items:center; gap:18px;">
	                  <a href="${pageContext.request.contextPath}/product/product_detail.htm?product_id=${w.productId}" style="color:#777;">리뷰보기</a>
	                  <button type="button" class="btnDelOne" data-wishid="${w.wishlistId}" style="border:0; background:transparent; cursor:pointer;">🗑</button>
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
<jsp:include page="/view/common/footer.jsp"/>

<!-- ===================== -->
<!-- 🔥 JS : 이것만 있으면 무조건 뜸 -->
<!-- ===================== -->
<script>
(function(){
  const $ = window.jQuery;

  // 전체선택
  $('#checkAll').on('change', function(){
    $('.wishChk').prop('checked', this.checked);
  });

  // 단건 삭제(일단 alert만: 서버 delete 핸들러 없으면 여기서 링크만 막힘)
  $('.odr__list').on('click', '.btnDelOne', function(){
    const id = $(this).data('wishid');
    alert('삭제(단건) wishlist_id=' + id + '  ※ delete 핸들러 연결 필요');
  });

  // 선택삭제
  $('#btnDeleteSelected').on('click', function(){
    const ids = $('.wishChk:checked').map(function(){ return this.value; }).get();
    if(ids.length === 0){ alert('삭제할 상품을 선택하세요.'); return; }
    alert('삭제(선택) ids=' + ids.join(',') + '  ※ deleteSelected 핸들러 연결 필요');
  });
})();
</script>

</body>
</html>
