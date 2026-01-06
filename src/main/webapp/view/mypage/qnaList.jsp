<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/view/common/header.jsp"/>

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/mypage.css">

<div class="mypage-wrap">
    <div class="inner" style="display: flex; max-width: 1660px; margin: 50px auto; padding: 0 30px;">
        
        <aside class="mypage-side" style="width: 250px; flex-shrink: 0;">
            <h2 style="font-size: 24px; font-weight: 700; margin-bottom: 30px;">MY PAGE</h2>
            <ul class="side-menu" style="list-style: none; padding: 0;">
                <li style="margin-bottom: 15px;"><a href="#" style="color: #333; font-weight: 700;">1:1 문의하기</a></li>
                <li style="margin-bottom: 15px;"><a href="${pageContext.request.contextPath}/inquiry/list.htm" style="color: #888;">문의 내역 확인</a></li>
            </ul>
        </aside>

        <section class="inquiry-content" style="flex-grow: 1; margin-left: 80px;">
            <div class="tit-area" style="border-bottom: 2px solid #00205b; padding-bottom: 15px; margin-bottom: 30px;">
                <h3 style="font-size: 28px; font-weight: 700; color: #00205b;">1:1 문의</h3>
            </div>

            <form action="${pageContext.request.contextPath}/inquiry/insert.htm" method="post">
                <table class="inquiry-table" style="width: 100%; border-top: 1px solid #000; border-collapse: collapse;">
                    <colgroup>
                        <col style="width: 180px;">
                        <col>
                    </colgroup>
                    <tbody>
                        <tr>
                            <th style="background: #f9f9f9; padding: 20px; border-bottom: 1px solid #eee; text-align: left; font-size: 14px;">제목 <span style="color: #e21836;">*</span></th>
                            <td style="padding: 15px; border-bottom: 1px solid #eee;">
                                <input type="text" name="title" required placeholder="제목을 입력해주세요." 
                                       style="width: 100%; height: 45px; border: 1px solid #ddd; padding: 0 15px;">
                            </td>
                        </tr>
                        <tr>
                            <th style="background: #f9f9f9; padding: 20px; border-bottom: 1px solid #eee; text-align: left; font-size: 14px; vertical-align: top;">내용 <span style="color: #e21836;">*</span></th>
                            <td style="padding: 15px; border-bottom: 1px solid #eee;">
                                <textarea name="content" required placeholder="문의하실 내용을 상세히 입력해주세요. (최대 2,000자)" 
                                          style="width: 100%; height: 300px; border: 1px solid #ddd; padding: 15px; resize: none; line-height: 1.6;"></textarea>
                            </td>
                        </tr>
                        <tr>
                            <th style="background: #f9f9f9; padding: 20px; border-bottom: 1px solid #eee; text-align: left; font-size: 14px;">파일첨부</th>
                            <td style="padding: 15px; border-bottom: 1px solid #eee;">
                                <input type="file" name="file" style="font-size: 13px;">
                                <p style="font-size: 12px; color: #888; margin-top: 10px;">* 10MB 이하의 이미지 파일(jpg, png)만 등록 가능합니다.</p>
                            </td>
                        </tr>
                    </tbody>
                </table>

                <div class="btn-group" style="display: flex; justify-content: center; gap: 10px; margin-top: 50px;">
                    <button type="button" onclick="history.back();" 
                            style="width: 200px; height: 60px; border: 1px solid #ddd; background: #fff; color: #333; font-weight: 700; cursor: pointer;">취소</button>
                    <button type="submit" 
                            style="width: 200px; height: 60px; border: none; background: #00205b; color: #fff; font-weight: 700; cursor: pointer;">문의하기</button>
                </div>
            </form>
        </section>
    </div>
</div>

<jsp:include page="/view/common/footer.jsp"/>