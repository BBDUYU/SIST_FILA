<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<title>FILA Admin - 상품 등록</title>
<style>
/* FILA 스타일의 아이템 디자인 */
.cate-item {
	padding: 10px;
	cursor: pointer;
	border-bottom: 1px solid #f0f0f0;
	font-size: 13px;
	transition: 0.2s;
}

.cate-item:hover {
	background-color: #f9f9f9;
}

/* 선택되었을 때의 스타일 */
.cate-item.active {
	background-color: var(--fila-navy) !important;
	color: white !important;
	font-weight: bold;
}

.cate-tag {
	background: #e21836; /* FILA RED 포인트 */
	color: #fff;
	padding: 6px 14px;
	border-radius: 4px;
	font-size: 12px;
	display: flex;
	align-items: center;
	gap: 10px;
	font-weight: 500;
}

.cate-tag span {
	cursor: pointer;
	opacity: 0.8;
	font-size: 14px;
}

.cate-tag span:hover {
	opacity: 1;
}
</style>

<style>
.placeholder-txt {
	text-align: center;
	color: #ccc;
	margin-top: 60px;
	font-size: 12px;
}

.category-select div.active {
	background-color: var(--fila-navy);
	color: white;
	font-weight: bold;
}
</style>
<style>
:root {
	--fila-navy: #00205b;
	--fila-red: #e21836;
	--fila-white: #ffffff;
	--bg-gray: #f4f4f4;
	--border-color: #ddd;
}

/* 헤더 가림 방지를 위한 충분한 패딩 */
.admin-section {
	padding-top: 150px;
	padding-bottom: 60px;
	background-color: var(--bg-gray);
	min-height: 100vh;
}

.section-title {
	border-bottom: 2px solid #000;
	padding-bottom: 10px;
	margin-bottom: 20px;
	font-size: 20px;
	font-weight: bold;
	color: var(--fila-navy);
	text-transform: uppercase;
}

.input-group {
	margin-bottom: 25px;
}

.input-group label {
	display: block;
	font-weight: bold;
	margin-bottom: 10px;
	font-size: 14px;
	color: #333;
}

.f-input {
	width: 100%;
	padding: 12px;
	border: 1px solid var(--border-color);
	font-size: 14px;
	box-sizing: border-box;
}

/* 이미지 업로드 공통 스타일 */
.upload-wrapper {
	background: #fff;
	padding: 20px;
	border: 1px solid var(--border-color);
}

.photo-upload-zone {
	border: 2px dashed var(--border-color);
	padding: 25px;
	text-align: center;
	background: #fafafa;
	cursor: pointer;
	transition: 0.2s;
}

.photo-upload-zone:hover {
	border-color: var(--fila-navy);
	background: #fff;
}

.photo-upload-zone .icon {
	font-size: 24px;
	color: var(--fila-navy);
	display: block;
	margin-bottom: 5px;
}

.photo-upload-zone .desc {
	font-size: 13px;
	color: #666;
}

/* 미리보기 영역 */
.preview-container {
	display: flex;
	gap: 8px;
	margin-top: 15px;
	flex-wrap: wrap;
}

.preview-container img {
	width: 80px;
	height: 80px;
	object-fit: cover;
	border: 1px solid #eee;
	background: #fff;
}

/* 카테고리 및 기타 스타일 (이전과 동일) */
.category-container {
	display: flex;
	gap: 10px;
	background: white;
	padding: 15px;
	border: 1px solid var(--border-color);
}

.category-select {
	flex: 1;
	height: 160px;
	border: 1px solid #eee;
	overflow-y: auto;
}

.category-select div {
	padding: 10px;
	cursor: pointer;
	border-bottom: 1px solid #f9f9f9;
	font-size: 13px;
}

.category-select div:hover {
	background-color: #f4f4f4;
}

.category-select div.active {
	background-color: var(--fila-navy);
	color: white;
}

.submit-btn {
	width: 100%;
	height: 60px;
	background: var(--fila-navy);
	color: white;
	border: none;
	font-size: 18px;
	font-weight: bold;
	cursor: pointer;
	margin-top: 40px;
}

/* 인풋 테두리 및 스타일 강조 */
.f-input {
	width: 100%;
	padding: 12px;
	/* 테두리를 더 명확하게 설정 (1px 실선, 회색) */
	border: 1px solid #333 !important;
	font-size: 14px;
	box-sizing: border-box;
	background-color: #fff;
	transition: all 0.2s ease; /* 부드러운 색상 변경 */
}

/* 마우스를 올렸을 때 */
.f-input:hover {
	border-color: #000;
}

/* 클릭(포커스) 시 테두리를 FILA 네이비 색상으로 강조 */
.f-input:focus {
	border: 1.5px solid var(--fila-navy) !important;
	outline: none;
	/* 약간의 그림자를 주어 입체감 부여 */
	box-shadow: 0 0 5px rgba(0, 32, 91, 0.1);
}

/* 에디터(Textarea) 전용 스타일 */
textarea.f-input {
	min-height: 100px;
	line-height: 1.5;
}
/* 옵션 리스트 레이아웃 */
.opt-list {
	display: flex;
	flex-wrap: wrap;
	gap: 10px;
	margin-top: 10px;
	min-height: 20px; /* 영역 확보 */
}

/* 개별 옵션 아이템 디자인 */
.opt-item {
	display: inline-flex;
	align-items: center;
	padding: 8px 15px;
	border: 1px solid #ddd;
	background: #fff;
	cursor: pointer;
	font-size: 13px;
	transition: 0.2s;
}

.opt-item input {
	margin-right: 8px;
}

/* 체크/라디오 선택 시 스타일 (FILA NAVY) */
.opt-item:has(input:checked) {
	border-color: var(--fila-navy);
	background-color: #f0f4f9;
	color: var(--fila-navy);
	font-weight: bold;
}
</style>
</head>

<body class="view__style1">
	<jsp:include page="../common/header.jsp" />

	<div id="wrap" class="admin-section">
		<form id="productForm" action="createProduct.do" method="post"
			enctype="multipart/form-data">
			<div id="contents" class="goods__contents"
				style="max-width: 1300px; margin: 0 auto; display: flex; gap: 40px;">

				<div style="flex: 1.4;">
					<h3 class="section-title">상품 비주얼 등록</h3>

					<div class="input-group">
						<label>메인 상품 이미지 (최대 13장)</label>
						<div class="upload-wrapper">
							<div class="photo-upload-zone"
								onclick="document.getElementById('mainImgs').click()">
								<span class="icon">+</span> <span class="desc">클릭하여 메인
									이미지 업로드 (13장까지 선택 가능)</span> <input type="file" id="mainImgs"
									name="mainImages" multiple style="display: none"
									onchange="previewImages(this, 'main-preview')">
							</div>
							<div id="main-preview" class="preview-container"></div>
						</div>
					</div>

					<div class="input-group">
						<label>모델컷 이미지 등록</label>
						<div class="upload-wrapper">
							<div class="photo-upload-zone"
								onclick="document.getElementById('modelImgs').click()">
								<span class="icon">+</span> <span class="desc">클릭하여 모델 촬영
									이미지 업로드</span> <input type="file" id="modelImgs" name="modelImages"
									multiple style="display: none"
									onchange="previewImages(this, 'model-preview')">
							</div>
							<div id="model-preview" class="preview-container"></div>
						</div>
					</div>

					<div class="input-group">
						<label>상세 설명 하단 이미지 (배너/디테일)</label>
						<div class="upload-wrapper">
							<div class="photo-upload-zone"
								onclick="document.getElementById('detailImgs').click()">
								<span class="icon">+</span> <span class="desc">클릭하여 상세
									페이지용 이미지 업로드</span> <input type="file" id="detailImgs"
									name="detailImages" multiple style="display: none"
									onchange="previewImages(this, 'detail-preview')">
							</div>
							<div id="detail-preview" class="preview-container"></div>
						</div>
					</div>
				</div>

				<div
					style="flex: 1; background: #fff; padding: 30px; border: 1px solid var(--border-color); height: fit-content;">
					<h3
						style="color: var(--fila-navy); margin-top: 0; padding-bottom: 15px; border-bottom: 1px solid #eee;">상품
						정보 설정</h3>

					<div class="input-group">
						<label>노출 카테고리 지정 (각 박스에서 해당되는 항목을 모두 클릭하세요)</label>
						<div class="category-container">
							<div class="category-select" id="depth1">
								<c:forEach items="${list}" var="c">
									<c:if test="${c.depth eq 1}">
										<div class="cate-item"
											onclick="filterCategory(2, '${c.category_id}', this)">${c.name}</div>
									</c:if>
								</c:forEach>
							</div>

							<div class="category-select" id="depth2">
								<c:forEach items="${list}" var="c">
									<c:if test="${c.depth eq 2}">
										<div class="cate-item" data-parent="${c.parent_id}"
											onclick="filterCategory(3, '${c.category_id}', this)"
											style="display: none;">${c.name}</div>
									</c:if>
								</c:forEach>
							</div>

							<div class="category-select" id="depth3">
								<c:forEach items="${list}" var="c">
									<c:if test="${c.depth eq 3}">
										<div class="cate-item" data-parent="${c.parent_id}"
											onclick="toggleCategory(this, '${c.category_id}')"
											style="display: none;">${c.name}</div>
									</c:if>
								</c:forEach>
							</div>
						</div>

						<div id="selected-tags"></div>
						<div id="hidden-inputs"></div>

						<div id="selected-values">
							<input type="hidden" name="category_ids" id="main_cate_input">
						</div>

						<div id="selected-tags"
							style="margin-top: 15px; display: flex; gap: 8px; flex-wrap: wrap;"></div>

						<div id="hidden-inputs"></div>
					</div>
					<div class="input-group">
						<label>상품 옵션 설정</label>
						<div class="upload-wrapper"
							style="background: #fff; border: 1px solid #333; padding: 20px;">

							<div
								style="margin-bottom: 25px; border-bottom: 1px dashed #eee; padding-bottom: 15px;">
								<p
									style="font-size: 13px; font-weight: bold; margin-bottom: 10px;">스포츠
									분류</p>
								<div class="opt-list">
									<c:set var="hasSport" value="false" />
									<c:forEach items="${options}" var="entry">
										<c:if test="${entry.key == 2}">
											<c:set var="hasSport" value="true" />
											<c:forEach items="${entry.value}" var="opt">
												<label class="opt-item"> <input type="radio"
													name="sport_option" value="${opt.v_master_id}" required>
													<span>${opt.value_name}</span>
												</label>
											</c:forEach>
										</c:if>
									</c:forEach>

									<c:if test="${not hasSport}">
										<span style="color: #ccc; font-size: 12px;">등록된 스포츠
											데이터가 없습니다.</span>
									</c:if>
								</div>
							</div>

							<div>
								<p
									style="font-size: 13px; font-weight: bold; margin-bottom: 10px;">
									사이즈 <span id="size-target-name"
										style="color: var(--fila-red); font-size: 11px;"></span>
								</p>
								<div id="size-area" class="opt-list">
									<c:forEach var="mId" begin="4" end="8">
										<c:forEach items="${options[mId]}" var="opt">
											<label class="opt-item size-item m-${mId}"
												style="display: none;"> <input type="checkbox"
												name="size_options" value="${opt.v_master_id}"> <span>${opt.value_name}</span>
											</label>
										</c:forEach>
									</c:forEach>
									<div id="size-placeholder"
										style="color: #999; font-size: 12px;">카테고리를 선택하면 해당 사이즈
										목록이 나타납니다.</div>
								</div>
							</div>
						</div>
					</div>




					<div class="input-group">
						<label>제품명</label> <input type="text" name="productName"
							class="f-input">
					</div>

					<div style="display: flex; gap: 10px;">
						<div class="input-group" style="flex: 1;">
							<label>판매가(원)</label> <input type="number" name="price"
								class="f-input">
						</div>
						<div class="input-group" style="flex: 1;">
							<label>할인율(%)</label> <input type="number" name="discount"
								class="f-input">
						</div>
					</div>

					<div class="input-group">
						<label>상품 설명</label>
						<textarea name="description" class="f-input"
							style="height: 100px; resize: none;"></textarea>
					</div>

					<button type="submit" class="submit-btn">상품 등록 완료</button>
				</div>
			</div>
		</form>
	</div>

	<jsp:include page="../common/footer.jsp" />

	<script>
    // 이미지 미리보기 공통 함수
    function previewImages(input, previewId) {
        const preview = document.getElementById(previewId);
        preview.innerHTML = ""; // 초기화
        
        if (input.files) {
            const filesArray = Array.from(input.files);
            
            // 메인 이미지의 경우 13장 제한 알림 (선택 사항)
            if(previewId === 'main-preview' && filesArray.length > 13) {
                alert("메인 이미지는 최대 13장까지 가능합니다.");
                input.value = ""; // 리셋
                return;
            }

            filesArray.forEach(file => {
                const reader = new FileReader();
                reader.onload = function(e) {
                    const img = document.createElement("img");
                    img.src = e.target.result;
                    preview.appendChild(img);
                }
                reader.readAsDataURL(file);
            });
        }
    }


  
    let selectedMap = new Map();

 function filterCategory(nextDepth, parentId, element) {
     // 1단계를 클릭했을 경우, 다른 1단계 선택은 해제하고 하위 선택 기록도 초기화
     if (nextDepth === 2) {
         selectedMap.clear(); // 1단계가 바뀌면 꼬이지 않게 싹 비움
         document.querySelectorAll('.cate-item').forEach(i => i.classList.remove('active'));
     }

     // 클릭한 항목 active 처리
     const siblings = element.parentElement.querySelectorAll('.cate-item');
     siblings.forEach(s => s.classList.remove('active'));
     element.classList.add('active');

     // 다음 단계 노출 제어
     const nextStepDiv = document.getElementById('depth' + nextDepth);
     if (nextStepDiv) {
         const items = nextStepDiv.querySelectorAll('.cate-item');
         items.forEach(item => {
             if (item.getAttribute('data-parent') === parentId) {
                 item.style.display = 'block';
             } else {
                 item.style.display = 'none';
                 item.classList.remove('active');
             }
         });
     }

     // 1단계를 누르면 3단계는 무조건 숨김
     if (nextDepth === 2) {
         document.querySelectorAll('#depth3 .cate-item').forEach(i => i.style.display = 'none');
     }

     // 1단계(성별) ID도 전송해야 하므로 맵에 추가
     selectedMap.set(parentId, element.innerText.trim());
     renderCategoryUI();
     
     if (nextDepth === 3) {
         const depth1Text = document.querySelector('#depth1 .cate-item.active').innerText.trim();
         const depth2Text = element.innerText.trim();
         
         const sizePlaceholder = document.getElementById('size-placeholder');
         const sizeTargetName = document.getElementById('size-target-name');

         // 1. 초기화
         document.querySelectorAll('.size-item').forEach(el => {
             el.style.display = 'none';
             el.querySelector('input').checked = false;
         });

         let targetId = null;

         // 2. 사이즈 매핑 로직 (성별 + 카테고리)
         if (depth2Text.includes("신발")) {
             targetId = (depth1Text === "KIDS") ? 8 : 7;
         } else if (depth2Text.includes("의류")) {
             if (depth1Text === "MALE") targetId = 4;
             else if (depth1Text === "FEMALE") targetId = 5;
             else if (depth1Text === "KIDS") targetId = 6;
         }

         // 3. UI 업데이트
         if (targetId) {
             sizePlaceholder.style.display = 'none';
             sizeTargetName.innerText = "[" + depth1Text + " " + depth2Text + " 사이즈]";
             document.querySelectorAll('.m-' + targetId).forEach(el => el.style.display = 'inline-flex');
         } else {
             sizePlaceholder.style.display = 'block';
             sizeTargetName.innerText = "";
         }
     }
     if (nextDepth === 2) {
         // 성별(depth1)의 v_master_id를 담을 히든 인풋 생성/업데이트
         let genderInput = document.getElementById('gender_option_input');
         if (!genderInput) {
             genderInput = document.createElement('input');
             genderInput.type = 'hidden';
             genderInput.id = 'gender_option_input';
             genderInput.name = 'gender_option'; // 서블릿에서 이 이름으로 받음
             document.getElementById('productForm').appendChild(genderInput);
         }
         
         // 선택된 성별의 명칭에 따라 v_master_id 매칭 (DB의 성별 값 확인 필요)
         // 보통 남성:101, 여성:102 이런 식으로 저장되어 있을 것임
         // 여기서는 단순히 카테고리 ID를 활용하거나 텍스트로 판별
         const genderText = element.innerText.trim();
         if(genderText === "MALE") genderInput.value = "101"; // 실제 DB의 남성 v_master_id
         else if(genderText === "FEMALE") genderInput.value = "102"; // 실제 DB의 여성 v_master_id
         else if(genderText === "KIDS") genderInput.value = "103";
     }
 }

 // 2. [수정] 최종 단계 혹은 하위 단계 선택 (중복 선택 가능)
 function toggleCategory(element, id) {
     const name = element.innerText.trim();
     
     if (selectedMap.has(id)) {
         selectedMap.delete(id);
         element.classList.remove('active');
     } else {
         selectedMap.set(id, name);
         element.classList.add('active');
     }
     renderCategoryUI();
 }

 // 3. UI 렌더링 (작성하신 코드 유지)
 function renderCategoryUI() {
     const tagContainer = document.getElementById('selected-tags');
     const inputContainer = document.getElementById('hidden-inputs');
     
     tagContainer.innerHTML = "";
     inputContainer.innerHTML = "";

     selectedMap.forEach((name, id) => {
         const tag = document.createElement('div');
         tag.className = 'cate-tag';
         tag.innerHTML = `\${name} <span onclick="removeCategory('\${id}')">&times;</span>`;
         tagContainer.appendChild(tag);

         const input = document.createElement('input');
         input.type = "hidden";
         input.name = "category_ids"; // 서블릿 String[] categoryIds로 들어감
         input.value = id;
         inputContainer.appendChild(input);
     });
 }

 function removeCategory(id) {
     selectedMap.delete(id);
     const items = document.querySelectorAll('.cate-item');
     items.forEach(item => {
         if (item.getAttribute('onclick').includes(`'\${id}'`)) {
             item.classList.remove('active');
         }
     });
     renderCategoryUI();
 }

</script>


</body>
</html>