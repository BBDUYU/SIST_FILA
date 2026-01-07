// qna.js
$(function () {

	// 열기
	$(document).on('click', '.qna-write__btn', function (e) {
		e.preventDefault();
		$('.common__layer._qna_write').fadeIn(200);
		$('body').addClass('no-scroll');
	});

	// 닫기
	$(document).on(
		'click',
		'.common__layer._qna_write .close__btn, .common__layer._qna_write .layer-bg__wrap',
		function () {
			$('.common__layer._qna_write').fadeOut(200);
			$('body').removeClass('no-scroll');
		}
	);

});
