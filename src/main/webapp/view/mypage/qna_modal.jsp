<%@ page contentType="text/html; charset=UTF-8" %>

<style>
/* ===== 1:1 문의 모달 컴팩트화 ===== */
.common__layer._qna_write .inner {
  max-width: 720px;
  width: 90%;
  padding: 24px 28px;
}

/* 헤더 높이 축소 */
.common__layer._qna_write .head {
  padding-bottom: 12px;
}

/* 카테고리 영역 여백 줄이기 */
.common__layer._qna_write .qna-category-box {
  margin-bottom: 16px;
}

/* 제목 input */
.common__layer._qna_write .qna-write-box input {
  height: 44px;
  margin-bottom: 10px;
}

/* textarea 높이 축소 */
.common__layer._qna_write .qna-write-box textarea {
  min-height: 160px;
}

/* 하단 버튼 영역 */
.common__layer._qna_write .foot {
  margin-top: 20px;
  padding-top: 12px;
}

/* 전체 행 간격 살짝 조임 */
.common__layer._qna_write .con > div {
  margin-bottom: 12px;
}
</style>

<div class="common__layer sch-idpw _qna_write">

  <div class="layer-bg__wrap"></div>

  <div class="inner">
    <div class="head">
      <p class="tit">문의하기</p>
      <button type="button" class="close__btn" onclick="closeQnaModal()">close</button>
    </div>

    <!-- 🔥 여기부터 form (이게 핵심) -->
    <form action="${pageContext.request.contextPath}/mypage/qna/write_submit.htm" method="get">


      <div class="con">
        <div>
          <!-- 문의하기 카테고리 -->
          <div class="qna-category-box">
            <div>
              <select class="sel__style1" name="category_id" id="category" required>
                <option value="">문의유형 선택</option>
                <option value="1">결제/주문/배송</option>
                <option value="2">취소/교환/반품</option>
                <option value="3">불량/AS</option>
                <option value="4">행사/사은품/리뷰</option>
                <option value="5">회원/멤버십/쿠폰/포인트</option>
              </select>
            </div>
          </div>
          <!-- //문의하기 카테고리 -->
        </div>

        <div>
          <div>
            <!-- 문의 내용 입력 -->
            <div class="qna-write-box">
              <input
                type="text"
                name="title"
                id="boardTitle"
                placeholder="제목을 입력해주세요."
                required
              >

              <textarea
                name="content"
                id="boardContents"
                placeholder="문의 내용을 입력해주세요.
휴대폰 번호, 주민등록번호와 같은 개인정보의
입력은 삼가해 주시기 바랍니다."
                required
              ></textarea>
            </div>
            <!-- //문의 내용 입력 -->
          </div>
        </div>
      </div>

      <div class="foot">
        <button type="button" class="btnCancel" onclick="closeQnaModal()">취소</button>
        <!-- 🔥 onclick 제거 + submit -->
        <button type="submit" class="on">문의하기</button>
      </div>

    </form>
    <!-- 🔥 form 끝 -->

  </div>
</div>
