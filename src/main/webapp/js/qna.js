$(function () {
  loadInquiryList();
});

function loadInquiryList() {
  $.ajax({
    url: contextPath + '/mypage/qna/list.ajax',
    type: 'GET',
    dataType: 'html',
    success: function (html) {
      $('#qnaListArea').html(html);
    }
  });
}


function openInquiryModal() {
  console.log('1:1 문의 모달 열기');

  if (document.querySelector('#qnaWriteLayer')) return;

  fetch('/mypage/qna/write.ajax')
    .then(res => res.text())
    .then(html => {
      document.body.insertAdjacentHTML('beforeend', html);
      bindQnaModalEvents();
    })
    .catch(console.error);
}

function bindQnaModalEvents() {
  const layer = document.querySelector('#qnaWriteLayer');
  if (!layer) return;

  layer.querySelector('.btn_close')?.addEventListener('click', closeQnaModal);
  layer.querySelector('.btn_cancel')?.addEventListener('click', closeQnaModal);
  layer.querySelector('.layer_dim')?.addEventListener('click', closeQnaModal);
}

function closeQnaModal() {
  document.querySelector('#qnaWriteLayer')?.remove();
}
