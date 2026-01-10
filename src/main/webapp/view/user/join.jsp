<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<!-- ✅ 헤더 -->
<jsp:include page="../common/header.jsp" />

<div id="contents" class="mbr__contents">
			<h2 class="tit__style1">회원가입</h2>

			<!-- join -->
			<section class="mbr-box">
					<!-- 카카오 간편 회원가입 -->
					<div class="join-sec">
						<p class="txt">카카오 간편 회원가입으로 보다 간편하게 회원가입이 가능합니다.</p>
						<div class="btn-box">
							<a href="javascript:snsJoin('KK');void(0);" class="join_kakao">카카오 1초 간편가입</a>
						</div>
					</div>
					<!-- 카카오 간편 회원가입 -->
				<form name="idform">
					<input type="hidden" name="mb_id" id="mb_id" value="">
				</form>
				<form name="myform" class="join_form join_form_style ">
					<input type="hidden" name="joinMode" id="joinMode" value="">
					<input type="hidden" name="id_check" id="id_check" value="no">
					<input type="hidden" name="join_cert" id="join_cert" value="no">
					<input type="hidden" name="memberTel2" id="memberTel2" value="">
					<input type="hidden" name="custNo" id="custNo" value="">
					<input type="hidden" name="joinGbn" id="joinGbn" value="">
					<input type="hidden" name="DI" id="DI" value="">
					<input type="hidden" name="CI" id="CI" value="">
					<input type="hidden" name="uid" id="uid" value="">
					<input type="hidden" name="compCd" id="compCd" value="">
					<input type="hidden" name="birthY" id="birthY" value="">
					<input type="hidden" name="birthM" id="birthM" value="">
					<input type="hidden" name="birthD" id="birthD" value="">
						<!-- 본인인증 -->
						<div class="join-sec ">
							<div class="title-box">
								<h3 class="tit__style2">본인인증</h3>
							</div>
							<div class="inp-box _bf">
								<!-- 이름 -->
								<div class="name" id="memberNameTxt">
									<input type="text" placeholder="이름" class="" name="memberName" id="memberName" maxlength="50" onchange="" onkeyup="fnChkByte50(this);">
									<select name="NationalInfo" id="NationalInfo" class="sel__style1 wid__style1 cbox">
										<option value="0">내국인</option>
										<option value="1">외국인</option>
									</select>
								</div>
								<!-- // 에러메시지(공통클래스 err-msg) 활성화시 클래스 on 추가 // -->
								<p class="err-msg" id="nameCheckText">이름을 입력해주세요.</p>
								<!-- 생년월일 -->
								<div class="birthday" id="bday2" style="display:none;"></div>
								<div class="birthday" id="bday">
									<input type="text" placeholder="생년월일 8자리 Ex.20260110" class="" maxlength="8" name="birthDay" id="birthDay" onkeyup="valchk(this,8)" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');">
									<select name="MemberGender" id="MemberGender" class="sel__style1 wid__style1">
										<option value="">성별</option>
										<option value="M">남자</option>
										<option value="F">여자</option>
									</select>
								</div>
								<p class="err-msg" id="bdayCheckText">생년월일을 선택해주세요.</p>
								<!-- 휴대폰 -->
								<div id="phone hplist2" style="display:none;"></div>
								<div class="phone" id="hplist">
								
									<select id="phone1" name="phone1" class="sel__style1 wid__style3">
										<option value="010">010</option>
										<option value="011">011</option>
										<option value="017">017</option>
										<option value="018">018</option>
										<option value="019">019</option>
									</select>
									<input type="text" maxlength="8" class="inp__phone" id="phone2" name="phone2" validate="required;" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"> 
								</div>
								<p class="err-msg" id="phoneCheckText">휴대폰 번호를 입력해주세요.</p>
							</div>
							<!------------- 2023-02-07 본인인증 완료 시 추가 (본인인증 완료 시 display: block 처리) --------------->
							<div class="inp-box _af" style="display:none ">
								<!-- 이름 -->
								<div class="name">
									<input type="text" class="" id="memberNametemp" maxlength="50" onchange="" disabled="">
									<select class="sel__style1 wid__style1 " id="NationalTemp" disabled="">
									</select>
								</div>
								<!-- 생년월일 -->
								<div class="birthday">
									<input type="text" id="birthTemp" class="" maxlength="8" disabled="">
									<select class="sel__style1 wid__style1" id="genderTemp" disabled="">
									</select>
								</div>
								<div class="phone">
									<select id="cellphonetemp" class="sel__style1 wid__style2" disabled="">
									</select>
									<select id="phone1temp" class="sel__style1 wid__style3" disabled="">
									</select>
									<input type="number" maxlength="8" class="inp__phone" id="phone2temp" validate="required;" disabled=""> 
								</div>
							</div>
							<!-- // 2023-02-07 본인인증 완료 시 추가 -->

							<!-- 본인인증 약관-->
							<div class="self-verification ">
								<div class="all-agree-box hbox">
									<input type="checkbox" class="cb__style1" name="Certall1" id="Certall1" onclick="CertagreeAll();">
									<label for="Certall1">본인 인증을 위한 약관 모두 동의</label>
									<a href="javascript:;" class="arr-down-btn"></a>
								</div>
								<div class="agree-chk-box self-agree-wrap cbox"
     id="certAgreeBox"
     style="display:none;">

									<ul>
										<li>
											<input type="checkbox" class="cb__style1" name="Certagree1" id="Certagree1" onclick="Certagrees();">
											<label for="Certagree1">개인정보이용 동의</label>
											<a href="javascript:;" class="view-btn" id="view1">전문보기</a>
										</li>
										<li>
											<input type="checkbox" class="cb__style1" name="Certagree2" id="Certagree2" onclick="Certagrees();">
											<label for="Certagree2">고유식별정보처리 동의</label>
											<a href="javascript:;" class="view-btn" id="view2">전문보기</a>
										</li>
										<li>
											<input type="checkbox" class="cb__style1" name="Certagree3" id="Certagree3" onclick="Certagrees();">
											<label for="Certagree3">서비스 이용약관 동의</label>
											<a href="javascript:;" class="view-btn" id="view3">전문보기</a>
										</li>
										<li>
											<input type="checkbox" class="cb__style1" name="Certagree4" id="Certagree4" onclick="Certagrees();">
											<label for="Certagree4">통신사 이용약관 동의</label>
											<a href="javascript:;" class="view-btn" id="view4">전문보기</a>
										</li>
									</ul>
								</div>
								<div class="inp-box cbox" id="certAfter" style="display:none;">
									<!-- 인증번호 -->
									<div class="self-number">
										<input type="text" placeholder="인증번호" name="sAuthNo" id="sAuthNo" validatetext="인증번호" maxlength="6" validate="required">
										<div class="inp_in">
											<small id="countdown" class="count count_down time"></small>
											<button type="button" onclick="confirmReturn();">확인</button>
											<button type="button" onclick="confirmJoin();">재전송</button>
											<input type="hidden" name="responsedata" id="responsedata">
											<input type="hidden" name="requestdata" id="requestdata">
										</div>
									</div>
								</div>
								<div class="btn-box cbox">
									<a href="javascript:confirmJoin();void(0);" class="btn_sld__bk" id="loginbtn">본인인증</a>
									<a id="loginbtn2" style="display:none;" class="btn_sld__bk"><img src="/pc/resource/images/waiting.gif"></a>
								</div>
								<p class="err-msg" id="certCheckText">본인인증을 진행해주세요.</p>
							</div>
							<!-- 필수정보 -->
							<div class="title-box certView" style="display:none;">
								<h3 class="tit__style2">필수정보</h3>
							</div>
							<div class="inp-box m0 certView" style="display:none;">
								<!-- 아이디 -->
								<div class="inp_id">
									<input type="text" placeholder="아이디 (대소문자를 반드시 확인해주세요)" name="memberId" id="joinId" maxlength="16" onchange="document.myform.id_check.value='';" style="text-transform: lowercase;">
									<button onclick="javascript:checkidN();" type="button" class="btn__chk_id btn_sld__bk">중복확인</button>	
								</div>
								<p class="err-msg" id="idCheckText">아이디를 입력해주세요.</p>
								<!-- 비밀번호 -->
								<div>
									<input type="password" class="inp__pw" name="memberPassword" id="memberPassword" placeholder="8-16자:영문,숫자,특수문자 조합" maxlength="16" onkeyup="checkReg(event)">
									<button type="button" class="pwonoff__btn off">on/off</button>
									<!-- 눈 감기 클래스 off -->

									<script>
										function checkReg(event) {
										  //const regExp = /[a-z0-9]|[ \[\]{}()<>?|`~!@#$%^&*-_+=,.;:\"'\\]/g;
										  const regExp = /[^0-9a-zA-Z\[\]{}()<>?|`~!@#$%^&*-_+=,.;:\"'\\]/g;
										  const del = event.target;
										  if (regExp.test(del.value)) {
											del.value = del.value.replace(regExp, '');
										  }
										};
									</script>
								</div>
								<div><em id="pwResult" style="font-style:normal; font-family:dotum; font-size:12px;"></em></div>
								<p class="err-msg" id="pwResult3">비밀번호를 입력해주세요.</p>
								<!-- 이매알 -->
								<div class="inp_eml">
									<input type="text" placeholder="이메일 주소" name="email1" id="userEmail" pattern="[a-zA-Z0-9]" onkeyup="this.value=this.value.replace(/[\ㄱ-ㅎㅏ-ㅣ가-힣]/g, '');emailChk();">
								</div>
								<p class="err-msg" id="emailCheckText">이메일 주소를 입력해주세요.</p>
							</div>
						</div>

						<!-- 부가정보 입력 -->
						<div class="join-sec certView" style="display:none;">
							<div class="title-box">
								<h3 class="tit__style2">자녀정보</h3>
								<button type="button" class="btn_sel">추가시 생일 쿠폰 증정<span class="pm"></span></button>
							</div>
							<div class="children-box " id="Children">
								<div class="inp-box child-group">

									<!-- 자녀명 -->
									<div class="inp_child">
										<input type="hidden" name="custChSqor" id="custChSqor" value="">
										<input type="text" name="ChildName" maxlength="20" placeholder="자녀명">
									</div>
									<!-- 생년월일 -->
									<div class="birthday">
										<input type="text" name="birthch" placeholder="생년월일 8자리" class="" maxlength="8">
										<select name="MemberGender1" id="MemberGender1" class="sel__style1 wid__style1">
											<option value="">성별</option>
											<option value="M">남성</option>
											<option value="F">여성</option>
										</select>
									</div>
									<!-- 자녀추가 -->
									<cc class="children-btn btn-box" style="margin-top:10px;">
									</cc>
								</div>
							</div>
								<div class="children-btn btn-box" style="display:none;">
									<cc>
									<button type="button" class="child-add__btn btn_sld__gr plus" onclick="javascript:fn_append('Children');void(0);">자녀 추가</button>
									
									</cc>
									<p class="txt__gr mt15">고객님의 자녀 정보는 당사 마케팅 / 홍보 등에 활용될 수 있습니다.</p>
									<button type="button" class="child-add__btn btn_sld__gr reset" onclick="fn_reset('Children');">초기화</button>
								</div>
						</div>
					

					<!-- 이용약관 및 마케팅 정보 수신 동의 -->
					<div class="join-sec certView" style="display:none;"> <!-- 2025-12-10 텍스트 수정 -->
						<div class="title-box">
							<h3 class="tit__style2">이용약관 및 마케팅 정보 수신 동의</h3>
						</div>
						<div class="all-agree-box">
							<input type="checkbox" class="cb__style1" name="all1" id="all1" onclick="agreeAll2022();">
							<label for="all1">약관 전체 동의합니다.</label>
							<a href="javascript:;" class="arr-down-btn"></a>
						</div>
						<div class="agree-chk-wrap">
							<!-- 이용약관 -->
							<ul class="agree-chk-box">
								<li>
									<input type="checkbox" class="cb__style1" name="agree1" id="agree1" onclick="agrees2022();">
									<label for="agree1">이용약관 <span class="red">(필수)</span></label>
									<a href="javascript:;" class="view-btn" id="view5">전문보기</a>
								</li>
								<li>
									<input type="checkbox" class="cb__style1" name="agree2" id="agree2" onclick="agrees2022();">
									<label for="agree2">개인정보의 수집 및 이용에 관한 동의 <span class="red">(필수)</span></label>
									<a href="javascript:;" class="view-btn" id="view6">전문보기</a>
								</li>
								<!--<li>
									<input type="checkbox" class="cb__style1" name="agree5" id="agree5" onclick="agrees2022();" value="1">
									<label for="agree5">개인정보수집 및 활용에 대한 동의<span class="">(선택)</span></label>
									<a href="javascript:;" class="view-btn" id="view8">전문보기</a>
								</li>-->
								<!--<li>
									<input type="checkbox" class="cb__style1" name="agree3" id="agree3" value="1" onclick="agrees2022();">
									<label for="agree3">개인정보 국외 이전에 관한 동의 <span class="red">(필수)</span></label>
									<a href="javascript:;" class="view-btn" id="view7">전문보기</a>
								</li>-->
								<li>
									<input type="checkbox" class="cb__style1" name="agree4" id="agree4" onclick="agrees2022();receptionAll();" value="1">
									<label for="agree4">혜택 알림 수신 동의 <span class="">(선택)</span></label>
									
								</li>
							</ul>
							<div class="txt-box _agree">
								<p class="txt__gr">
									이메일, 휴대폰 문자(SMS), 카카오톡(브랜드 메시지 등)을 통한 <br>이벤트·할인·신상품 안내 등 마케팅 정보 수신에 동의합니다.
								</p>
							 	<p>
									<input type="checkbox" class="cb__style1" name="MemberIsSMS" id="MemberIsSMS" onclick="agrees2022();reception();" value="Y">
									<label for="MemberIsSMS" style="margin-right: 20px;">휴대폰(문자(SMS) 카카오톡(브랜드 메시지 등)) 수신 동의</label>
									
									<input type="checkbox" class="cb__style1" name="MemberIsMaillinglist" id="MemberIsMaillinglist" onclick="agrees2022();reception();" value="Y">
									<label for="MemberIsMaillinglist" style="margin-top: 20px;">이메일 수신동의</label>
								</p>
								<p class="txt__gr m0">회원가입 및 거래정보(주문, 반품, 교환)등의 메일은 마케팅 정보 수신과 무관하며,
									개인정보보호법 제15조 제1항에 의거 '정보주체와의 계약의 체결 및 이행을 위하여
									불가피하게 필요한 경우'에 해당하므로 수신동의를 하지 않더라도 모든 회원에게
									발송됩니다.
								</p>
							</div>

						</div>
						<p class="err-msg" id="agreeCheckText"></p>
					</div>
					<!-- 이용약관 및 마케팅 정보 수신 동의 -->

					<!-- 개인정보 필수 위탁에 대한 안내 -->
					<div class="join-wt certView" style="display:none;">
						<div class="title-box">
							<!-- <p class="tit__style2">개인정보 필수 위탁에 대한 안내</p>
							<a href="javascript:;" class="view-btn" id="view9">전문보기</a> -->
							<span class="txt__style1">
								* 필수항목에 동의하지 않으실 경우 회원가입이 불가합니다. <br>
								* 선택항목은 동의하지 않으셔도 서비스 이용이 가능합니다.
							</span>
						</div>
						
					</div>
					<!-- 개인정보 필수 위탁에 대한 안내 -->

					<!-- 통합멤버십 동의 -->
					<!-- <div class="join-wt">
						<h4 class="tit__style3">통합멤버십 동의 <span class="red">(필수)</span></h4>
						<p class="txt">
							휠라 온라인 스토어에서는 한번을 가입으로 FILA KOREA에서 운영하는 <br>
							전 브랜드의 고객 혜택 사용이 가능한 통합 멤버십 서비스로 운영 중입니다.<br>
							이에 동의하면 통합멤버십에 가입 됩니다.
						</p>
						<div class="btn__flex">
							<input type="button" value="동의합니다">
							<input type="button" value="동의하지 않습니다">
						</div>
					</div> -->
					<div class="btn-box certView" style="display:none;" id="loginButton">
						<a href="javascript:sendform();void(0);" class="btn_bg__bk">동의하고 가입하기</a>
					</div>
						<div class="btn-box" id="loginButton2" style="display:none;">
							<img src="/images/waiting.gif">
						</div>
				</form>
			</section>
			<!-- //join -->
		</div>
		
		<script>
function CertagreeAll() {
    const allChk = document.getElementById("Certall1");
    const agreeBox = document.getElementById("certAgreeBox");

    if (!agreeBox) return;

    if (allChk.checked) {
        agreeBox.style.display = "block";
    } else {
        agreeBox.style.display = "none";

        // 하위 체크 전부 해제
        document
          .querySelectorAll("#certAgreeBox input[type='checkbox']")
          .forEach(chk => chk.checked = false);
    }
}
</script>
		

</body>

<jsp:include page="../common/footer.jsp" />	
</html>