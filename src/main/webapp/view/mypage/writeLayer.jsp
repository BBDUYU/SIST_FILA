<%@ page contentType="text/html; charset=UTF-8" %>

<div id="qnaWriteLayer" class="common__layer _qna_write _v2" style="display:block;">
  <div class="layer_dim"></div>

  <div class="inner">
    <div class="head">
      <h2 class="tit">문의하기</h2>
      <button type="button" class="close__btn btn_close">닫기</button>
    </div>

    <div class="con">

      <!-- 상단 영역 -->
      <div class="qna-category-box">
        <select name="categoryId">
          <option value="">문의유형 선택</option>
          <option value="1">상품</option>
          <option value="2">배송</option>
          <option value="3">교환/반품</option>
          <option value="4">기타</option>
        </select>

        <button type="button" class="btn__order">
          주문상품 찾기
        </button>

        <label class="chk-box">
          <input type="checkbox">
          <span>주문번호 없이 문의하기</span>
        </label>
      </div>

      <!-- 입력 영역 -->
      <div class="qna-write-box">
        <input type="text" name="title" placeholder="제목을 입력해주세요.">

        <textarea name="content" placeholder="문의 내용을 입력해주세요.&#10;휴대폰 번호, 주민등록번호 등 개인정보 입력은 삼가주세요."></textarea>
      </div>

      <!-- 이메일 -->
      <div class="email-box">
        <input type="email" name="email" placeholder="이메일주소">
        <label class="chk-box">
          <input type="checkbox">
          <span>이메일로 답변받기 (선택)</span>
        </label>
      </div>

      <!-- 개인정보 -->
      <div class="my-privacy-box">
        <p class="tit">개인정보 수집 동의</p>
        <ul>
          <li>1. 개인정보 수집 목적: 고객문의 응대</li>
          <li>2. 수집 항목: 이메일</li>
          <li>3. 보유 기간: 3년</li>
        </ul>
      </div>

    </div>
  </div>

  <!-- 하단 고정 버튼 -->
  <div class="bot-fix-box">
    <div class="inner">
      <button type="button" class="btn_cancel">취소</button>
      <button type="submit" class="btn_submit">문의하기</button>
    </div>
  </div>
</div>
