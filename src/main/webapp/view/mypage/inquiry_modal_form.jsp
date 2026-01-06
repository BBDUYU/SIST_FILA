<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="modal-overlay" onclick="closeInquiryModal()">
    <div class="modal-content" onclick="event.stopPropagation()">
        <div class="modal-header">
            <h3>문의하기</h3>
            <button type="button" class="close-btn" onclick="closeInquiryModal()">&times;</button>
        </div>
        <form action="${pageContext.request.contextPath}/inquiry/insert.htm" method="post" enctype="multipart/form-data">
            <div class="modal-body">
                <div class="input-row">
                    <select name="category" required>
                        <option value="">문의유형 선택</option>
                        <option value="1">상품문의</option>
                        <option value="2">배송문의</option>
                    </select>
                </div>
                <div class="input-row">
                    <input type="text" name="title" placeholder="제목을 입력해주세요." required>
                </div>
                <div class="input-row">
                    <textarea name="content" placeholder="문의 내용을 입력해주세요." required></textarea>
                </div>
                <div class="file-row">
                    <input type="file" name="file">
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn-cancel" onclick="closeInquiryModal()">취소</button>
                <button type="submit" class="btn-submit">문의하기</button>
            </div>
        </form>
    </div>
</div>