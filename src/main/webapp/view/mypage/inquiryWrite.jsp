<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/view/common/header.jsp"/>

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/mypage.css">

<div class="mypage-wrap">
    <div class="mypage__tab">
        <div class="inner">
            <div class="my-info-box">
                <div class="top">
                    <strong class="name" style="color:#fff; font-size:30px;">1:1 문의</strong>
                </div>
                <p class="txt" style="color:rgba(255,255,255,0.7); margin-top:10px;">궁금하신 내용을 남겨주시면 빠르게 답변해 드리겠습니다.</p>
            </div>
        </div>
    </div>

    <div class="inner" style="display: flex; max-width: 1660px; margin: 60px auto; padding: 0 30px;">
        <aside class="mypage-side" style="width: 250px; flex-shrink: 0;">
            <h2 style="font-size: 22px; font-weight: 700; margin-bottom: 25px; color: #00205b;">고객센터</h2>
            <ul style="list-style: none; padding: 0; border-top: 1px solid #ddd;">
                <li style="border-bottom: 1px solid #eee;">
                    <a href="#" style="display: block; padding: 15px 0; color: #00205b; font-weight: 700;">1:1 문의작성</a>
                </li>
                <li style="border-bottom: 1px solid #eee;">
                    <a href="${pageContext.request.contextPath}/inquiry/list.htm" style="display: block; padding: 15px 0; color: #666;">문의 내역 확인</a>
                </li>
            </ul>
        </aside>

        <section class="my-con" style="flex-grow: 1; margin-left: 80px;">
            <div style="border-bottom: 2px solid #00205b; padding-bottom: 15px; margin-bottom: 30px;">
                <h3 style="font-size: 24px; font-weight: 700;">상담내용 입력</h3>
            </div>

            <form action="${pageContext.request.contextPath}/inquiry/insert.htm" method="post">
                <table style="width: 100%; border-top: 1px solid #000; border-collapse: collapse;">
                    <colgroup>
                        <col style="width: 180px;">
                        <col>
                    </colgroup>
                    <tbody>
                        <tr>
                            <th style="background: #f9f9f9; padding: 20px; border-bottom: 1px solid #eee; text-align: left;">제목</th>
                            <td style="padding: 15px; border-bottom: 1px solid #eee;">
                                <input type="text" name="title" required placeholder="제목을 입력하세요." 
                                       style="width: 100%; height: 45px; border: 1px solid #ddd; padding: 0 15px; box-sizing: border-box;">
                            </td>
                        </tr>
                        <tr>
                            <th style="background: #f9f9f9; padding: 20px; border-bottom: 1px solid #eee; text-align: left; vertical-align: top;">내용</th>
                            <td style="padding: 15px; border-bottom: 1px solid #eee;">
                                <textarea name="content" required placeholder="상세 내용을 입력해 주세요." 
                                          style="width: 100%; height: 350px; border: 1px solid #ddd; padding: 15px; resize: none; box-sizing: border-box; line-height:1.6;"></textarea>
                            </td>
                        </tr>
                    </tbody>
                </table>

                <div style="display: flex; justify-content: center; gap: 15px; margin-top: 50px;">
                    <button type="button" onclick="history.back();" 
                            style="width: 200px; height: 60px; background: #fff; border: 1px solid #00205b; color: #00205b; font-weight: 700; cursor: pointer;">취소</button>
                    <button type="submit" 
                            style="width: 200px; height: 60px; background: #00205b; border: none; color: #fff; font-weight: 700; cursor: pointer;">등록하기</button>
                </div>
            </form>
        </section>
    </div>
</div>

<jsp:include page="/view/common/footer.jsp"/>