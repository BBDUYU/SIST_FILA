<%@ page contentType="text/html; charset=UTF-8" %>
<div class="inner" style="background:#fff; width:90%; max-width:680px; height:520px; position:relative; border-radius:8px; padding:10px;">
  <button type="button" class="close__btn" style="position:absolute; right:10px; top:10px;">닫기</button>
  <div id="daumWrap" style="width:100%; height:100%; min-height:480px;"></div>
</div>

<script>
(function(){
  // ✅ 다음 스크립트가 없으면 로드
  function ensureDaum(cb){
    if (typeof daum !== 'undefined' && daum.Postcode) return cb();
    var s = document.createElement('script');
    s.src = 'https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js';
    s.onload = cb;
    document.head.appendChild(s);
  }

  ensureDaum(function(){
    new daum.Postcode({
      oncomplete: function(data){
        var zipcode = data.zonecode;

        // ✅ 너 폼 name에 맞춤 (네가 준 name 그대로)
        jQuery("input[name=zipcode]").val(zipcode);
        jQuery("input[name=addr3]").val(data.address);
        jQuery("input[name=addr1]").val(data.jibunAddress || data.address);
        jQuery("input[name=addr2]").focus();

        // ✅ map 모달 닫기
        jQuery('#MapModalOverlay').hide();
        jQuery('#MapModalContent').empty();
        jQuery('body').css('overflow','auto');
      }
    }).embed(document.getElementById('daumWrap'));
  });
})();
</script>
