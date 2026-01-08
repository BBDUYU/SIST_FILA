<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<!-- 1:1 문의 열기 버튼 -->
<button id="btnOpenQna" type="button">
    1:1 문의하기
</button>

<!-- QnA 작성 모달 -->
<div id="qnaWriteLayer" class="common__layer _qna_write" style="display:none;">

    <!-- dim 영역 -->
    <div class="layer_dim"></div>

    <!-- 실제 모달 내용 -->
    <div class="inner">

        <!-- 닫기 버튼 -->
        <button id="btnCloseQna" type="button" class="close__btn">
            닫기
        </button>

        <!-- 문의 작성 폼 -->
        <form id="qnaWriteForm">

            <div class="qna-category-box">
                <!-- 문의 유형 -->
            </div>

            <div class="qna-write-box">
                <input id="qnaTitle" type="text" placeholder="제목">
                <textarea id="qnaContent"></textarea>
            </div>

            <div class="bot-fix-box">
                <button id="btnSubmitQna" type="submit">
                    등록
                </button>
            </div>

        </form>
    </div>
</div>


</body>
</html>