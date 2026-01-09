<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!--
  역할:
  - 모달 overlay + 공홈 레이어를 한 덩어리로 제공
  - qna.jsp에는 모달 관련 DOM이 아예 존재하지 않음
-->

<!-- ✅ overlay를 여기서 책임 -->
<div id="qnaModalOverlay">

    <!-- 공홈 레이어 -->
    <div class="common__layer _qna_write" id="qnaWriteLayer">

        <!-- dim -->
        <div class="layer-bg__wrap"></div>

        <!-- 실제 내용 -->
        <jsp:include page="qna_write.jsp" />

    </div>

</div>
