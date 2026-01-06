<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html lang="ko-KR">
<head>
    <meta charset="UTF-8">
    <title>장바구니 | FILA</title>
    
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.1, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.1, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi">
</head>

<body class="view__style1">

<jsp:include page="../common/header.jsp" />

<div id="contents" class="odr__contents">
    <h2 class="tit__style1">장바구니</h2>
    
    <c:choose>
        <c:when test="${empty cartList}">
            <div class="cart__empty" style="text-align:center; padding:100px 0;">
                <p class="txt">장바구니에 담긴 상품이 없습니다.</p>
                <a class="btn_sld__bk" href="${pageContext.request.contextPath}/">쇼핑 계속하기</a>
            </div>
        </c:when>
        <c:otherwise>
            <section class="odr-wrap">
                <div class="odr-box">
                    <div class="odr-hd" style="display:flex; justify-content:space-between; align-items:center; padding:15px; border-bottom:1px solid #ddd;">
                        <div>
                            <input type="checkbox" id="checkAll" checked="checked">
                            <label for="checkAll">전체선택 <span>(${fn:length(cartList)})</span></label>
                        </div>
                        <div class="txt-btn">
                            <a href="javascript:void(0);" onclick="deleteSoldOut()">품절삭제</a>
                            <a href="javascript:void(0);" onclick="deleteSelected()">선택삭제</a>
                        </div>
                    </div>

                    <ul class="odr__list">
                        <c:forEach var="item" items="${cartList}" varStatus="st">
                            <c:set var="rawImg" value="${item.mainImageUrl}" />
                            <c:set var="finalImg" value="${fn:replace(rawImg, 'file:///C:/fila_upload', '/upload')}" />
                            
                            <li class="cart-item" 
                                data-id="${item.cartItemId}" 
                                data-origin="${item.originUnitPrice}" 
                                data-sale="${item.saleUnitPrice}" 
                                data-qty="${item.quantity}"
                                style="display:flex; padding:20px; border-bottom:1px solid #eee; align-items:center;">
                                
                                <div class="goods_sel">
                                    <input type="checkbox" id="checkProduct${st.index}" class="item-chk" checked="checked">
                                </div>

                                <div class="goods-thumb" style="width:100px; margin:0 20px;">
                                    <a href="${pageContext.request.contextPath}/product/product_detail.htm?productId=${item.productId}">
                                        <img src="${not empty finalImg ? finalImg : '/images/noimage.png'}" alt="${item.productName}" style="width:100%;">
                                    </a>
                                </div>

                                <div class="goods-info" style="flex:1;">
                                    <p class="tit" style="font-weight:bold;">${item.productName}</p>
                                    <div class="info">수량 : ${item.quantity}개</div>
                                    <div class="price" style="color:#000; font-weight:bold;">
                                        <fmt:formatNumber value="${item.saleUnitPrice}" pattern="#,###"/>원
                                    </div>
                                </div>

                                <div class="goods-etc">
                                    <button type="button" class="btn_del" onclick="deleteItem(${item.cartItemId})" style="cursor:pointer; border:1px solid #ccc; padding:5px 10px; background:#fff;">삭제</button>
                                </div>
                            </li>
                        </c:forEach>
                    </ul>
                </div>

                <div class="total-box" style="margin-top:30px; padding:20px; background:#f9f9f9; border:1px solid #ddd;">
                    <dl style="display:flex; justify-content:space-between;"><dt>총 상품금액</dt><dd><span id="ctPice">0</span>원</dd></dl>
                    <dl style="display:flex; justify-content:space-between; color:red;"><dt>상품 할인금액</dt><dd>-<span id="miPrice">0</span>원</dd></dl>
                    <dl style="display:flex; justify-content:space-between; font-weight:bold; font-size:1.3em; border-top:1px solid #ccc; padding-top:10px;"><dt>총 결제 금액</dt><dd><span id="pPrice">0</span>원</dd></dl>
                    <div class="btn-box" style="margin-top:20px; text-align:center;">
                        <button type="button" onclick="goOrder()" style="padding:15px 60px; background:#000; color:#fff; cursor:pointer; font-size:1.1em; border:none;">구매하기</button>
                    </div>
                </div>
            </section>
        </c:otherwise>
    </c:choose>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
$(document).ready(function() {
    updateTotal();

    $("#checkAll").click(function() {
        $(".item-chk").prop("checked", this.checked);
        updateTotal();
    });

    $(document).on("click", ".item-chk", function() {
        $("#checkAll").prop("checked", $(".item-chk:checked").length == $(".item-chk").length);
        updateTotal();
    });
});

function updateTotal() {
    let totalOrigin = 0;
    let totalSale = 0;

    $(".cart-item").each(function() {
        if ($(this).find(".item-chk").is(":checked")) {
            let origin = parseInt($(this).data("origin")) || 0;
            let sale = parseInt($(this).data("sale")) || 0;
            let qty = parseInt($(this).data("qty")) || 0;
            totalOrigin += (origin * qty);
            totalSale += (sale * qty);
        }
    });

    $("#ctPice").text(totalOrigin.toLocaleString());
    $("#miPrice").text((totalOrigin - totalSale).toLocaleString());
    $("#pPrice").text(totalSale.toLocaleString());
}

// 삭제 시 현재 경로 문제를 방지하기 위해 절대경로 사용
function deleteItem(id) {
    if(confirm("해당 상품을 삭제하시겠습니까?")) {
        location.href = "${pageContext.request.contextPath}/pay/cart.htm?ids=" + id;
    }
}

function deleteSelected() {
    let ids = [];
    $(".item-chk:checked").each(function() {
        ids.push($(this).closest("li").data("id"));
    });

    if(ids.length === 0) {
        alert("삭제할 상품을 선택해주세요.");
        return;
    }
    if(confirm("선택한 상품을 삭제하시겠습니까?")) {
        location.href = "${pageContext.request.contextPath}/pay/cart.htm?ids=" + ids.join(",");
    }
}

function deleteSoldOut() {
    if(confirm("품절 상품을 모두 삭제하시겠습니까?")) {
        location.href = "${pageContext.request.contextPath}/pay/cart.htm?action=deleteSoldOut";
    }
}

function goOrder() {
    let ids = [];
    $(".item-chk:checked").each(function() {
        ids.push($(this).closest("li").data("id"));
    });

    if(ids.length === 0) {
        alert("구매할 상품을 선택해주세요.");
        return;
    }
    location.href = "${pageContext.request.contextPath}/order/setup.htm?ids=" + ids.join(",");
}
</script>

<jsp:include page="../common/footer.jsp" />
</body>
</html>