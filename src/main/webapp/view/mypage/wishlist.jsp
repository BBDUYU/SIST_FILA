<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

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
		      <c:forEach var="w" items="${wishList}" varStatus="st">
		        <li>
		
		          <!-- ✅ 공홈처럼: 체크박스 + label -->
		          <div class="_soldout">
		            <c:set var="cid" value="checkwish${st.index}" />
		            <input type="checkbox"
		                   id="${cid}"
		                   name="checkwish"
		                   value="${w.wishlist_id}"
		                   class="cb__style1 wishChk">
		            <label for="${cid}">선택</label>
		          </div>
		
		          <!-- ✅ 공홈처럼 썸네일 -->
		          <div class="goods-thumb">
		            <a href="${pageContext.request.contextPath}/product/product_detail.htm?product_id=${w.product_id}">
		              <img src="${w.image_url}" alt="${w.product_name}"
		                   onerror="this.src='${pageContext.request.contextPath}/images/no_image.jpg';">
		            </a>
		          </div>
		
		          <!-- ✅ 공홈처럼 상품정보 -->
		          <div class="goods-info">
		            <p class="sex">FILA</p>
		            <p class="tit">${w.product_name}</p>
		            <p class="info">${w.size_text}</p>
		            <p class="price">
		              <span class="sale"><fmt:formatNumber value="${w.price}" pattern="#,###"/>원</span>
		            </p>
		          </div>
		
		          <!-- ✅ 공홈처럼 우측 버튼 -->
		          <div class="goods-etc">
		            <p class="ico">
		              <button type="button" class="btn_review"
		                      onclick="location.href='${pageContext.request.contextPath}/product/product_detail.htm?product_id=${w.product_id}';">
		                리뷰보기
		              </button>
		
		              <!-- ❗class/id 변경 금지라서 del + btnDelOne 같이 둠 -->
		              <button type="button"
		                      class="del btnDelOne"
		                      data-wishid="${w.wishlist_id}">
		                삭제
		              </button>
		            </p>
		            <p class="btn-box"></p>
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

<script>
(function(){
  const $ = window.jQuery;
  const ctx = "${pageContext.request.contextPath}";

  // ✅ returnUrl: 현재 페이지 그대로 돌아오게
  function getReturnUrl(){
    return encodeURIComponent(location.pathname + location.search);
  }

  /* ===============================
     0) 전체 선택 (checkAll)
  =============================== */
  $('#checkAll').on('change', function(){
    $('.wishChk').prop('checked', this.checked);
  });

  // ✅ 개별 체크 변경하면 checkAll 상태도 맞추기
  $('.odr__list').on('change', '.wishChk', function(){
    const total = $('.wishChk').length;
    const checked = $('.wishChk:checked').length;
    $('#checkAll').prop('checked', total > 0 && total === checked);
  });

  /* ===============================
     1) 단건 삭제 (.btnDelOne)
  =============================== */
  $('.odr__list').on('click', '.btnDelOne', function(){
    const id = $(this).data('wishid');
    if(!id) return;

    if(!confirm('삭제하시겠습니까?')) return;

    location.href =
      ctx + "/mypage/wish/delete.htm?wishlist_id=" + encodeURIComponent(id)
      + "&returnUrl=" + getReturnUrl();
  });

  /* ===============================
     2) 선택 삭제 (#btnDeleteSelected)
  =============================== */
  $('#btnDeleteSelected').on('click', function(){
    const ids = $('.wishChk:checked').map(function(){ return this.value; }).get();
    if(ids.length === 0){
      alert('삭제할 상품을 선택하세요.');
      return;
    }

    if(!confirm('선택한 상품을 삭제하시겠습니까?')) return;

    location.href =
      ctx + "/mypage/wish/deleteSelected.htm?ids=" + encodeURIComponent(ids.join(','))
      + "&returnUrl=" + getReturnUrl();
  });

})();
</script>

</body>
</html>