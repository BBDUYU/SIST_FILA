function openInquiryModal() {
  console.log('1:1 문의 모달 열기');

  if (document.querySelector('#qnaWriteLayer')) return;

  fetch('/mypage/qna/write.ajax')
    .then(res => res.text())
    .then(html => {
      document.body.insertAdjacentHTML('beforeend', html);
      bindQnaModalEvents();
    })
    .catch(err => console.error(err));
}

function bindQnaModalEvents() {
  const layer = document.querySelector('#qnaWriteLayer');
  if (!layer) return;

  const closeBtn = layer.querySelector('.btn_close');
  const cancelBtn = layer.querySelector('.btn_cancel');
  const dim = layer.querySelector('.layer_dim');

  closeBtn && closeBtn.addEventListener('click', closeQnaModal);
  cancelBtn && cancelBtn.addEventListener('click', closeQnaModal);
  dim && dim.addEventListener('click', closeQnaModal);
}

function closeQnaModal() {
  const layer = document.querySelector('#qnaWriteLayer');
  if (layer) layer.remove();
}
