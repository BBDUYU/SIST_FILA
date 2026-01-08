<%@ page contentType="text/html; charset=UTF-8" %>

<div class="common__layer sch-idpw _qna_write">

  <div class="layer-bg__wrap"></div>

  <div class="inner">
    <div class="head">
      <p class="tit">문의하기</p>
      <button type="button" class="close__btn">close</button>
    </div>

    <div class="con">
			<div>
				<!-- 문의하기 카테고리 -->
				<div class="qna-category-box">
					<div>
						<select class="sel__style1" name="category" id="category">
							<option value="">문의유형 선택</option>

							<option value="4">결제/주문/배송</option>	

							<option value="5">취소/교환/반품</option>	

							<option value="1">불량/AS</option>	

							<option value="9">행사/사은품/리뷰</option>	

							<option value="7">회원/멤버십/쿠폰/포인트</option>	

							<option value="8">매장관련</option>	

							<option value="11">고객의 소리</option>	

							<option value="99">기타</option>	

						</select>
					</div>

				</div>
				<!-- //문의하기 카테고리 -->

				<!-- 주문상품 찾기 -->
				<div class="search-order-box" id="selectBefore">
					<!-- 주문 상품 찾기 전 -->
					<button type="button" id="btnSchOrder" class="btn_sld__bk">주문상품 찾기</button>

					<div>
						<div class="chk">
							<input type="checkbox" name="noItemCheck" id="noItemCheck" class="cb__style1" value="1">
							<label for="noItemCheck">주문번호 없이 문의하기</label>
						</div>

						<p>주문번호 입력 시 더욱 빠르고 정확한 답변이 가능합니다.</p>
					</div>
					<!-- //주문 상품 찾기 전 -->


					<!-- //주문 상품 찾기 후 -->
				</div>
				<div class="search-order-box" id="selectAfter" style="display:none;">


					<!-- 주문 상품 찾기 후 -->
					<!-- //주문 상품 찾기 후 -->

				</div>
				<!-- //주문상품 찾기 -->
			</div>

			
			<div>
				<div>
					<!-- 문의 내용 입력 -->
					<div class="qna-write-box">
						<input type="text" name="boardTitle" id="boardTitle" placeholder="제목을 입력해주세요.">

						<textarea name="boardContents" id="boardContents" placeholder="문의 내용을 입력해주세요.
휴대폰 번호, 주민등록번호와 같은 개인정보의
입력은 삼가해 주시기 바랍니다."></textarea>
					</div>
					<!-- //문의 내용 입력 -->

					<!-- 이미지 업로드 -->
					<div class="qna-upload-box">
						<div class="inp-box">
							<!-- 업로드시 노출 -->
							<div class="uploaded">
								<ul class="file_photo" id="file_photo">
									<!--li>
										<img src="/mo/resource/images/_temp/goods02.jpg" alt="" class="autofit" />

										<button type="button" class="delete__btn">delete</button>
									</li-->
								</ul>
							</div>
							<!-- //업로드시 노출 -->
							
							<!-- 업로드 버튼 -->
							<input type="file" name="qnaFile" id="qnaFile">
							<label for="qnaFile" class="upload__btn">
								<span>사진첨부</span>
							</label>
							<!-- //업로드 버튼 -->
						</div>

						<div class="txt-box">
							<p>최대 3장 첨부 가능하며, <br>10mb 미만의 JPG, GIF, PNG 파일만 가능합니다.</p>
						</div>
					</div>
					<!-- //이미지 업로드 -->
				</div>

				<div>
					<!-- 이메일 -->
					<div class="email-box">
						<div class="inp-box">
							<input type="text" placeholder="이메일주소" name="memberEmail1" id="memberEmail1" value="vfeefvrtyuio@naver.com">
						</div>

						<div class="chk">
							<input type="checkbox" id="emailChk" class="cb__style1" value="1" name="isEmail">
							<label for="emailChk">이메일로 답변받기 (선택)</label>
						</div>
					</div>
					<!-- //이메일 -->

					<!-- 개인정보 수집 동의 -->
					<div class="my-privacy-box">
						<p class="tit">개인정보 수집 동의</p>

						<p class="txt">1. 개인정보 수집 및 이용목적 : 이용자의 민원처리 답변사항 전달</p>
						<p class="txt">2. 개인정보 수집 항목 : 이메일</p>
						<p class="txt">
							<strong>
								3. 개인정보 보유 이용 기간 : 전자상거래 등에서의 소비자 보호에 관한 법률 등에서 정한 보존기간 동안 고객님의 개인 정보를 보유합니다. <br>
								소비자의 불만 또는 분쟁처리에 관한 기록 : 3년
							</strong>
						</p>

						<p class="txt2">
							개인정보 수집 및 이용에 대한 동의를 거부할 수 있으나, 동의를 거부하실 경우 1:1 문의에 대한 이메일 답변이 불가할 수 있습니다.
						</p>

						<div class="chk-box">
							<div class="chk">
								<input type="radio" id="privacy1" name="privacy1" value="1">
								<label for="privacy1">동의합니다</label>
							</div>

							<div class="chk">
								<input type="radio" id="privacy2" name="privacy1" value="0" onclick="alert('개인정보 수집에 동의해 주셔야 이메일로 답변받기가 가능합니다');">
								<label for="privacy2">동의하지 않습니다</label>
							</div>
						</div>
					</div>
					<!-- //개인정보 수집 동의 -->
				</div>	
			</div>
		</div>

    <div class="foot">
      <button type="button" class="btnCancel">취소</button>
      <button type="button" class="on" onclick="fn_send()">문의하기</button>
    </div>
  </div>

</div>
