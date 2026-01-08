<%@ page contentType="text/html; charset=UTF-8" %>

<div class="common__layer _addr_add sch-idpw">
	<div class="layer-bg__wrap"></div>

	<div class="inner">
		<div class="head">
			<p class="tit">배송지 추가</p>
			<button type="button" class="close__btn">close</button>
		</div>

		<div class="con">
			<form name="addr" id="addr" action="/mypage/pop_delivery_result.asp" target="dataFrame" method="post">	
			<input type="hidden" name="addrNo" value="1203475">
			<div class="addr-add-box">
				<div>
					<input type="text" placeholder="수령인" name="addrname" value="지영주" maxlength="25" id="addrRecipient ">
				</div>

				<div>
					<input type="text" name="tel2_1" id="addrPhone" placeholder="휴대폰 번호를 '-' 제외하고 숫자만 입력해주세요" maxlength="11" value="01012345678" onkeyup="this.value=this.value.replace(/[^0-9]/g,'');">
				</div>

				<div class="_addr">
					<div>
						<input type="text" name="zipcode" readonly="" value="06193" onclick="searchZipD5();void(0);" id="addrNum1">
						<button type="button" class="zipcode__btn" onclick="searchZipD5();void(0);">주소찾기</button>
					</div>

					<div>
						<input type="text" name="addr3" maxlength="200" value="서울 강남구 테헤란로70길 12 (대치동)" readonly="" id="addrNum1">
						<input type="hidden" name="addr1" value="서울 강남구 대치동 890-60" readonly="" id="addrNum2" class="input_size4">
					</div>

					<div>
						<input type="text" name="addr2" value="9층, 쌍용교육센터" maxlength="100" id="addrNum3" autocomplete="off">
					</div>
				</div>

				<div class="chk">
				
					<input type="checkbox" class="cb__style1" id="addrCheck" checked="" onclick="$(this).prop('checked',true)">
					<label for="addrCheck">기본 배송지로 저장</label>
					<input type="hidden" name="addrDefault" value="D" id="addrCheck2">
				
				</div>
			</div>
			<div id="MapModalOverlay"
						     class="style-modal-overlay"
						     onclick="if(event.target === this) closeQnaModal();"
						     style="display:none;">
						
						    <div id="MapModalContent" class="style-modal-wrapper">
						        <!-- AJAX로 qna_modal.jsp 들어올 자리 -->
						    </div>
						</div>
			</form>
		</div>

		<div class="foot">
			<button type="button" onclick="$('.close__btn').click();">취소</button>
			<button type="button" class="on" onclick="javascript:addrSubmit();">저장하기</button>
		</div>
	</div>
</div>
<script>
var contextPath = '${pageContext.request.contextPath}';

(function ($) {

  /* =========================
     주소 검색 (map.jsp) - 이중 모달 대응
     ========================= */
  $(document).on('click', '.zipcode__btn', function (e) {
    e.preventDefault();

    // 🔥 현재 버튼이 속한 add/edit 모달 "안"에서만 map 모달 찾기
    var $scope = $(this).closest(
      '.style-modal-wrapper, .inner, #AddaddModalContent, #EditaddModalContent'
    );

    var $mapOverlay = $scope.find('#MapModalOverlay');
    var $mapContent = $scope.find('#MapModalContent');

    // 안전장치 (scope 못 찾았을 때)
    if ($mapOverlay.length === 0) $mapOverlay = $('#MapModalOverlay');
    if ($mapContent.length === 0) $mapContent = $('#MapModalContent');

    $mapContent.load(
      contextPath + '/view/mypage/map.jsp',
      function () {
        $mapOverlay.css('display', 'flex').show();
      }
    );
  });

  /* =========================
     map 모달 닫기
     ========================= */
  $(document).on('click', '#MapModalOverlay, #MapModalOverlay .close__btn', function (e) {
    if (e.target !== this && !$(e.target).hasClass('close__btn')) return;

    var $overlay = $(this).closest('#MapModalOverlay');
    $overlay.hide();
    $overlay.find('#MapModalContent').empty();
  });

})(jQuery);
</script>

<script>
function addrSubmit(){
  var $f = jQuery('#addr');

  jQuery.ajax({
	  url: contextPath + '/mypage/address/edit.htm',
    type: 'POST',
    data: $f.serialize(),
    dataType: 'json',
    success: function(res){
      if(res && res.ok){
        if (window.closeQnaModal) closeQnaModal();
        location.reload();
      } else {
        alert('수정 실패');
      }
    },
    error: function(xhr){
      alert('수정 실패 (' + xhr.status + ')');
    }
  });
}
</script>

<script>
	if (!window.jQuery) document.write('<script src="${pageContext.request.contextPath}/js/jquery-1.12.4.js"><\/script>');
</script>