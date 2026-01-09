<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<div class="inner">

    <!-- header -->
    <div class="head">
        <p class="tit">문의하기</p>
        <button type="button" class="close__btn">close</button>
    </div>
 <form>
    <!-- content -->
    <div class="con">

        <!-- 상단 영역 -->
        <div>
            <!-- 문의유형 -->
            <div class="qna-category-box">
                <div>
                    <select class="sel__style1" name="categoryId" id="categoryId">
                        <option value="">문의유형 선택</option>
                        <c:forEach var="cat" items="${categoryList}">
                            <option value="${cat.categoryId}">
                                ${cat.categoryName}
                            </option>
                        </c:forEach>
                    </select>
                </div>
            </div>

            <!-- 주문상품 찾기 -->
            <div class="search-order-box" id="selectBefore">
                <button type="button" class="btn_sld__bk">주문상품 찾기</button>

                <div>
                    <div class="chk">
                        <input type="checkbox" id="noItemCheck"
                               class="cb__style1" value="1">
                        <label for="noItemCheck">주문번호 없이 문의하기</label>
                    </div>
                    <p>주문번호 입력 시 더욱 빠르고 정확한 답변이 가능합니다.</p>
                </div>
            </div>
        </div>

        <!-- 하단 영역 -->
        <div>
            <div>
                <!-- 제목 / 내용 -->
                <div class="qna-write-box">
                    <input type="text"
                           name="title"
                           id="boardTitle"
                           placeholder="제목을 입력해주세요.">

                    <textarea name="content"
                              id="boardContents"
                              placeholder="문의 내용을 입력해주세요.
휴대폰 번호, 주민등록번호와 같은 개인정보의
입력은 삼가해 주시기 바랍니다."></textarea>
                </div>

                <!-- 이미지 업로드 -->
                <div class="qna-upload-box">
                    <div class="inp-box">

                        <!-- 업로드 미리보기 -->
                        <div class="uploaded">
                            <ul class="file_photo" id="file_photo"></ul>
                        </div>

                        <input type="file" name="qnaFile" id="qnaFile">
                        <label for="qnaFile" class="upload__btn">
                            <span>사진첨부</span>
                        </label>
                    </div>

                    <div class="txt-box">
                        <p>
                            최대 3장 첨부 가능하며,<br>
                            10mb 미만의 JPG, GIF, PNG 파일만 가능합니다.
                        </p>
                    </div>
                </div>
            </div>

            <div>
                <!-- 이메일 -->
                <div class="email-box">
                    <div class="inp-box">
                        <input type="text"
                               name="email"
                               id="memberEmail1"
                               value="${sessionScope.auth.email}"
                               placeholder="이메일주소">
                    </div>

                    <div class="chk">
                        <input type="checkbox"
                               id="emailChk"
                               class="cb__style1"
                               value="1">
                        <label for="emailChk">이메일로 답변받기 (선택)</label>
                    </div>
                </div>

                <!-- 개인정보 동의 -->
                <div class="my-privacy-box">
                    <p class="tit">개인정보 수집 동의</p>

                    <p class="txt">
                        1. 개인정보 수집 및 이용목적 : 이용자의 민원처리 답변사항 전달
                    </p>
                    <p class="txt">
                        2. 개인정보 수집 항목 : 이메일
                    </p>
                    <p class="txt">
                        <strong>
                            3. 개인정보 보유 이용 기간 :
                            전자상거래 등에서의 소비자 보호에 관한 법률 등에서
                            정한 보존기간 동안 고객님의 개인 정보를 보유합니다.<br>
                            소비자의 불만 또는 분쟁처리에 관한 기록 : 3년
                        </strong>
                    </p>

                    <p class="txt2">
                        개인정보 수집 및 이용에 대한 동의를 거부할 수 있으나,
                        동의를 거부하실 경우 1:1 문의에 대한 이메일 답변이
                        불가할 수 있습니다.
                    </p>

                    <div class="chk-box">
                        <div class="chk">
                            <input type="radio" id="privacy1"
                                   name="privacyAgree" value="1">
                            <label for="privacy1">동의합니다</label>
                        </div>

                        <div class="chk">
                            <input type="radio" id="privacy2"
                                   name="privacyAgree" value="0">
                            <label for="privacy2">동의하지 않습니다</label>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>
      </form>

    <!-- footer -->
    <div class="foot" id="writeButton">
        <button type="button" class="btn_cancel">취소</button>
        <button type="button" class="on">문의하기</button>
    </div>

    <div class="foot" id="writeButton2" style="display:none;">
        <img src="${pageContext.request.contextPath}/images/waiting.gif">
    </div>

</div>
