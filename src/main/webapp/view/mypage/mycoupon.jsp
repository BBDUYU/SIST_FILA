<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <title>1:1 문의 | FILA</title>

    <!-- CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/normalize.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/opt-default.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/layout.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/product.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/sub.css">

    <!-- jQuery -->
    <script src="${pageContext.request.contextPath}/js/jquery-1.12.4.js"></script>


</head>

<body>

<jsp:include page="/view/common/header.jsp"/>
<jsp:include page="/view/mypage/mypage.jsp"/>

<%-- 상단 생략 --%>
<section class="my-con">
           			<h2 class="tit__style4">쿠폰</h2>
					<div class="coupon-box">
						<p class="txt">공통으로 사용가능한 쿠폰은 사용처별로 각각 노출됩니다.</p>

						<div class="coupon-inp-box">
							<input type="text" placeholder="쿠폰 시리얼 번호 입력" id="offline" maxlength="17" onkeydown="if (event.keyCode==13) $('#offlineBtn').click();void(0);">
							<div>
								<button type="button" id="offlineBtn">확인</button>
							</div>
						</div>

                        <ul class="coupon__list" style="padding: 0; margin: 0; list-style: none;">
    <c:choose>
        <c:when test="${not empty couponList}">
            <c:forEach var="coupon" items="${couponList}">
                <li style="border-bottom: 1px solid #eee; padding: 30px 0; display:flex; justify-content: space-between; align-items: center; min-height: 100px;">
                    
                    <div class="coupon-info" style="flex: 1; display: flex; flex-direction: column; justify-content: center;">
                        <strong style="font-size:18px; display:block; margin-bottom:8px; color:#333; line-height: 1.2;">
                            ${coupon.coupon_name}
                        </strong>
                        <p style="color:#666; font-size:14px; margin:0; line-height: 1;">
                            <span style="color:#ff0000; font-weight:bold;">
                                <c:choose>
                                    <c:when test="${coupon.discount_type eq 'PERCENT'}">${coupon.price}% 할인</c:when>
                                    <c:when test="${coupon.discount_type eq 'AMOUNT'}"><fmt:formatNumber value="${coupon.price}" pattern="#,###"/>원 할인</c:when>
                                    <c:when test="${coupon.discount_type eq 'DELIVERY'}">무료배송</c:when>
                                    <c:otherwise>기타 할인</c:otherwise>
                                </c:choose>
                            </span>
                            <span style="margin-left:10px; color:#999;">
                                | 유효기간: <fmt:formatDate value="${coupon.expireddate}" pattern="yyyy-MM-dd"/> 까지
                            </span>
                        </p>
                    </div>

                    <div class="coupon-status" style="width: 120px; display: flex; justify-content: flex-end; align-items: center;">
                        <c:choose>
                            <c:when test="${coupon.isused eq '1'}">
                                <span class="status-badge" style="display:inline-block; width:80px; height:32px; line-height:32px; text-align:center; background:#888; color:#fff; border-radius:2px; font-size:12px; font-weight:bold;">사용완료</span>
                            </c:when>
                            <c:otherwise>
                                <span class="status-badge" style="display:inline-block; width:80px; height:32px; line-height:32px; text-align:center; background:#00205b; color:#fff; border-radius:2px; font-size:12px; font-weight:bold;">사용가능</span>
                            </c:otherwise>
                        </c:choose>
                    </div>

                </li>
            </c:forEach>
        </c:when>
        <c:otherwise>
            <li style="width:100%; text-align:center; padding:50px 0;">
                <p class="odr-txt_none" style="color:#999;">보유하신 쿠폰 내역이 없습니다.</p>
            </li>
        </c:otherwise>
    </c:choose>
</ul>

					</div>
				</section>

</div>
</div>
<jsp:include page="/view/common/footer.jsp"/>
<script>
    jQuery(document).on("click", "#offlineBtn", function(){
        var val1 = jQuery("#offline").val();
        if (val1 != "") {
            jQuery.ajax({
                type: "POST",
                data: { "randomNo": val1 }, // 데이터를 객체 형태로 보내는 것이 더 안전합니다.
                // 🚩 URL을 우리 프로젝트의 핸들러 경로로 수정
                url: "${pageContext.request.contextPath}/mypage/coupon_process.htm",
                dataType : "JSON",
                success: function(data) {
                    // 서버에서 보낸 스크립트(alert 등)를 실행
                    if(data.msg) {
                        // 문자열로 된 자바스크립트를 실행하기 위해 eval 또는 Function 사용
                        var fn = new Function(data.msg);
                        fn();
                    }
                },
                error: function(e) {
                    alert("쿠폰 등록 중 오류가 발생했습니다.");
                    location.reload();
                }
            });
        }
        else {
            alert("쿠폰번호를 입력해 주세요");
            jQuery("#offline").focus();
        }
    });
</script>

<script>
$(document).ready(function() {
    // 비밀번호 변경 버튼 클릭 시
    $('.pw-change__btn').on('click', function(e) {
        e.preventDefault();
        
        // 1. modifyPwd.jsp의 내용을 AJAX로 가져옴
        $.ajax({
            url: "${pageContext.request.contextPath}/view/mypage/modifyPwd.jsp", // 실제 파일 경로 확인
            type: "GET",
            success: function(data) {
                // 2. 모달 컨텐츠 영역에 HTML 주입
                $('#PwdModifyModalContent').html(data);
                // 3. 모달 레이어 표시
                $('#PwdModifyModalOverlay').fadeIn(200);
            },
            error: function() {
                alert("비밀번호 변경 창을 불러오는데 실패했습니다.");
            }
        });
    });

    // 모달 닫기 (취소 버튼 또는 X 버튼 클릭 시)
    $(document).on('click', '.close__btn, .btn_can', function() {
        $('#PwdModifyModalOverlay').fadeOut(200);
        $('#PwdModifyModalContent').empty(); // 내용 비우기
    });
});
function fn_append(id) {
    const html = `
        <div class="child-group" style="margin-bottom: 15px; border-bottom: 1px solid #eee; padding-bottom: 10px;">
            <div class="name" style="display:flex; gap:10px;">
                <input type="text" name="ChildName" placeholder="자녀명" style="flex:1;">
                <button type="button" class="btn_sld__gr" onclick="$(this).closest('.child-group').remove()" style="background:#666;">삭제</button>
            </div>
            <div class="info" style="display:flex; gap:10px; margin-top:5px;">
                <input type="text" name="birthch" placeholder="생년월일 8자리" maxlength="8" style="flex:1;">
                <select class="sel__style1" name="MemberGender1" style="flex:1;">
                    <option value="">성별</option>
                    <option value="M">남성</option>
                    <option value="F">여성</option>
                </select>
            </div>
        </div>`;
    $('#' + id).append(html);
}

function updateform_simple2() {
    if(confirm("수정하시겠습니까?")) {
        document.myform.submit();
    }
}
$(document).ready(function() {
    // 페이지 로드 시 개별 체크박스 상태에 따라 전체 동의 체크박스 업데이트
    reception(); 
});

function reception() {
    // SMS와 EMAIL이 모두 체크되어 있으면 전체동의 체크, 아니면 해제
    if($("#MemberIsSMS").is(":checked") && $("#MemberIsMaillinglist").is(":checked")) {
        $("#agree4").prop("checked", true);
    } else {
        $("#agree4").prop("checked", false);
    }
}
//1. 자녀 추가 (삭제 버튼이 포함된 새 그룹 추가)
function fn_append(id) {
    const html = `
        <div class="child-group">
            <div class="name">
                <input type="hidden" name="custChSqor" value="">
                <input type="text" name="ChildName" maxlength="20" placeholder="자녀명">
            </div>
            <div class="info">
                <div><input type="text" name="birthch" placeholder="생년월일 8자리" maxlength="8"></div>
                <div>
                    <select class="sel__style1" name="MemberGender1">
                        <option value="">성별</option>
                        <option value="M">남성</option>
                        <option value="F">여성</option>
                    </select>
                </div>
            </div>
            <cc><button type="button" class="child-add__btn btn_sld__gr minus" onclick="fn_remove(this);">삭제</button></cc>
        </div>`;
    $('#' + id).append(html);
}

// 2. 개별 삭제
function fn_remove(obj) {
    $(obj).closest('.child-group').remove();
}

// 3. 전체 초기화 (첫 번째 그룹만 남기고 내용 비우기)
function fn_reset(id) {
    if(confirm("입력하신 자녀 정보를 모두 초기화하시겠습니까?")) {
        const $container = $('#' + id);
        // 첫 번째 그룹 외에 모두 삭제
        $container.find('.child-group:not(:first)').remove();
        // 첫 번째 그룹의 입력값 비우기
        const $first = $container.find('.child-group:first');
        $first.find('input[type="text"]').val('');
        $first.find('select').val('');
    }
}
//회원탈퇴 버튼 클릭 시
$('.retire-change__btn').on('click', function(e) {
    e.preventDefault();
    
    if (confirm("정말로 탈퇴하시겠습니까?\n탈퇴 시 동일 아이디로 재가입이 불가능할 수 있으며, 모든 혜택이 소멸됩니다.")) {
        // 탈퇴 핸들러로 이동
        location.href = "${pageContext.request.contextPath}/mypage/retireMember.htm";
    }
});
</script>

</body>
</html>
