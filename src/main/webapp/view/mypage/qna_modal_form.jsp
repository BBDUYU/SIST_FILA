<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div class="common__layer _qna_write" id="qnaWriteLayer">
  <div class="layer_dim"></div>

  <div class="layer_wrap">
    <!-- header -->
    <div class="layer_header">
      <h2>문의하기</h2>
      <button type="button" class="btn_close">✕</button>
    </div>

    <!-- body -->
    <div class="layer_body">
      <form id="qnaWriteForm" enctype="multipart/form-data">

        <div class="qna_wrap">

          <!-- LEFT -->
          <div class="qna_left">
            <select class="select_box" name="categoryId" required>
              <option value="">문의유형 선택</option>
              <option value="1">상품문의</option>
              <option value="2">배송문의</option>
              <option value="3">교환/반품</option>
            </select>

            <input type="text" class="inp" name="title"
                   placeholder="제목을 입력해주세요." required>

            <textarea class="textarea" name="content"
              placeholder="문의 내용을 입력해주세요.
휴대폰 번호, 주민등록번호 등 개인정보 입력은 삼가주세요."
              required></textarea>

            <div class="file_box">
              <label for="file_upload">사진첨부</label>
              <input type="file" id="file_upload" name="files" multiple>
              <p>이미지는 최대 3장까지 첨부 가능합니다.</p>
            </div>
          </div>

          <!-- RIGHT -->
          <div class="qna_right">
            <button type="button" class="btn_black">주문상품 찾기</button>

            <label class="chk">
              <input type="checkbox" name="noOrder">
              주문번호 없이 문의하기
            </label>

            <input type="text" class="inp" name="email"
                   value="${loginUser.email}">

            <label class="chk">
              <input type="checkbox" name="emailAgree">
              이메일로 답변받기 (선택)
            </label>

            <div class="privacy_box">
              <h3>개인정보 수집 동의</h3>
              <p>
                1. 개인정보 수집 및 이용목적 : 민원처리 답변사항 전달<br>
                2. 수집항목 : 이메일<br>
                3. 보유 및 이용기간 : 3년
              </p>

              <div class="radio_group">
                <label><input type="radio" name="agree" value="Y" required> 동의함</label>
                <label><input type="radio" name="agree" value="N"> 동의안함</label>
              </div>
            </div>

          </div>
        </div>
      </form>
    </div>

    <!-- footer -->
    <div class="layer_footer">
      <button type="button" class="btn_cancel">취소</button>
      <button type="button" class="btn_submit">문의하기</button>
    </div>
  </div>
</div>
