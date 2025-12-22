(function(ssq){
	var	struc={}, config={}, listener={};
	ssq(document).ready(function(){ struc.init() });
	function trace(a){ var b=""; for(var i=0;i<arguments.length;i++){if(i>0)b+=", ";b+=arguments[i];} try{console.log(b);}catch(e){}}
	struc = {
		init : function() {
			struc.regist(); 
			struc.pageMethod();
			listener.start();
		},
		regist : function() {

		},
		pageMethod : function () {			
			globalMenu();
			la.init();
			wish.init();
		}
	};
	listener = {
		start : function(){
			ssq(window).bind("resize", listener.resizePage); listener.resizePage();
			/*ssq("a[href=#]").on("click",function(e){
				e.preventDefault();
			});*/
			ssq(window).on('scroll', function() {
				la.fixBtn.scr();

				$('#header').css('left', 0 - $(this).scrollLeft() + 'px');

				la.sclUpDown.didScroll = true; 
			});
		},
		resizePage : function(e) {

		}
	};
	
	var la = {
		init: function(){
			window.onload = function(){
				la.goodsOver();
			};

			setTimeout(function(){
				la.goodsOver();
			}, 1000);

			setTimeout(function(){
				la.goodsOver();
			}, 2000);
			
			la.search();
			la.gnb();
			la.fixBtn.init();
			la.layer.init();

			la.sclUpDown.init();
			
			la.vTab();
		},
		// 2023-04-11 異붽� 
		layer: {
			init: function(){
				la.layer.glbLyr();
			},
			glbLyr: function(){
				var popup = function(){
					$.ajax({
						type: 'GET',
						url: '/pc/layout/pop_global.asp',
						data: '',
						dataType: 'html',
						success: function(html) {
							$('body').addClass('lyr-global--open');
							$('body').append(html);

							$('.common__layer._global .global-list-box ul li .tit').on('click', function(e){
								e.preventDefault();
								$(this).parent().find('.depth2-box').slideToggle();
								$(this).toggleClass('on');
							});
						},
						error: function(e) {
							console.log(e)
						}
					});
				};

				$('body').on('click', '#footer .select-box .language__btn', function(){
					popup();
				});

				$('body').on('click', '.common__layer._global .close__btn', function(){
					$('body').removeClass('lyr-global--open');
					$('.common__layer._global').remove();
				});
			}, 
		},
		fixBtn: {
			init: function(){
				la.mFixedBtn = $('.bot-fix-box');

				la.fixBtn.scr();
				la.fixBtn.top();
				la.fixBtn.todayGoodsLayer();
			},
			scr: function(){
				if($(window).scrollTop() > 100){
					la.mFixedBtn.fadeIn();
				}else{
					la.mFixedBtn.fadeOut();
				}
			},
			top: function(){
				$('.bot-fix-box .top__btn').on('click', function(){
					$('body, html').animate({
						scrollTop: 0
					}, 800);
						return false;
				});
			},
			todayGoodsLayer: function(){
				var popup = function(){
					$.ajax({
						type: 'GET',
						url: '/pc/main/pop_today_goods.asp',
						dataType: 'html',
						success: function(html) {
							$('body').addClass('today-goods--open');
							$('body').append(html);
						},
						error: function(e) {
							console.log('e');
						}
					});
				};

				$('.today-goods__btn').on('click', function(){
					popup();
				});

				$('body').on('click', '.today-goods__layer .close__btn, .tg-wrap', function(){
					$('body').removeClass('today-goods--open');		
					$('.today-goods__layer').remove();
				});
			}
		},
		goodsOver: function(){
			if($('.goods .after').length){
				$('.goods .after').each(function(idx){
					$(this).addClass('_g0' + idx);

					var swiper = new Swiper('._g0' + idx + ' .hover__slider', {
						spaceBetween: 1,
						slidesPerView: 'auto',
						scrollbar: {
							el: '._g0' + idx + ' .slider-scrollbar',
						},
						navigation: {
						  nextEl: '._g0' + idx + ' .next__btn',
						  prevEl: '._g0' + idx + ' .prev__btn',
						}
					});

					if($('._g0' + idx + ' .hover__slider .swiper-slide').length == 1){
						$('.slider-btn-box').hide();
					}
				});
			}		
			

			// 2024-08-05 異붽�
			if($('.goods .other-box').length){
				$('.goods .other-box').each(function(idx){
					$(this).addClass('_go0' + idx);

					var swiper = new Swiper('._go0' + idx + ' .other__slider', {
						spaceBetween: 5,
						freeMode: true,
						slidesPerView: 'auto'
					});
				});
			}
		},
		search: function(){
			$('.search-open__btn').on('click', function(){
				$('body').addClass('search--open');
				
				setTimeout(function(){
					$('.search__layer .head input').focus();
				}, 500);
			});

			$('.search__layer .head .close__btn').on('click', function(){
				$('.search__layer .head input').val('');
				$('.search__layer .head').removeClass('_val');
			});

			$('.search__layer .cancel__btn, .search-bg__wrap').on('click', function(){
				$('body').removeClass('search--open');
			});

			$('.search__layer .head input').on('keyup', function(){
				if($(this).val() == ''){
					$('.search__layer .head').removeClass('_val');
				}else{
					$('.search__layer .head').addClass('_val');
				}
			});
		},
		gnb: function(){
			$('body._style_main #header .gnb > ul > li').on('mouseover', function(){
				$('body').addClass('_bg_on');
			});

			$('body._style_main #header .gnb > ul > li').on('mouseleave', function(){
				$('body').removeClass('_bg_on');
			});

			// 2025-03-20 �щ씪�대뱶 異붽�
			if($('.side-menu-box .preview__slider').length){
				$('.side-menu-box .preview__slider').each(function () {
					var totalSlide = $(this).find('.swiper-slide').length;

					var swiper = new Swiper(this, {  
						direction: 'horizontal',
						loop: true,
						loopAdditionalSlides: 1,
						slidesPerView: 1,
						parallax: true,
						speed: 500,
						pagination: {
							el: $(this).find('.preview-slider-fraction')[0], 
							type: 'fraction'
						},
						autoplay: {
							delay: 3000,
							disableOnInteraction: false
						},
					});
				});
			};	
		},
		sclUpDown: {
			didScroll: null,
			lastScrollTop: 0,
			delta: 50,
			navbarHeight: $('#header').outerHeight(),
			
			init: function(){
				la.sclUpDown.scroll(); 

				setInterval(function(){
					if(la.sclUpDown.didScroll){
						la.sclUpDown.scroll(); 
						la.sclUpDown.didScroll = false; 
					}
				}, 250);				
			},
			scroll: function(){
				var st = $(window).scrollTop(); 
				
				if(Math.abs(la.sclUpDown.lastScrollTop - st) <= la.sclUpDown.delta) return;
				
				if(st > la.sclUpDown.lastScrollTop && st > la.sclUpDown.navbarHeight){
					// Scroll Down 
					$('body').removeClass('scl-up').addClass('scl-down');
				}else{
					// Scroll Up
					if(st + $(window).height() < $(document).height()){
						$('body').removeClass('scl-down').addClass('scl-up');						
					}
				}
				
				la.sclUpDown.lastScrollTop = st;

				if(st < 100){
					$('body').addClass('_w_top');
				}else{
					$('body').removeClass('_w_top');
				}
			}
		},
		vTab: function(){
			$('.goods-bt .event_tab a').on('click', function(){
				$('.goods-bt .event_tab a').removeClass('on');
				$(this).addClass('on');

				


			});
			/*var wSt = $(window).scrollTop();
				var tabHt = $('.goods-bt .event_tab a').height();
				var tabBtns = $('.goods-bt .event_tab a');
				var evCont = $('.goods-bt .event_list_box > div');

				for(var i = 0; i < tabBtns.length; i ++) {
					if(wSt < evCont[0].offset().top){
						for (tabBtn of tabBtns)
						{
							tabBtn.removeClass('on');
						}
					}else if (wSt > evCont[i].offset().top)
					{
						for(tabBtn of tabBtns){
							tabBtn.removeClass('on');
						}
						tabBtns[i].addClass('on');
					}
				}*/
				const tabBtns = document.querySelectorAll('.goods-bt .event_tab a');
				const tabBoxs = document.querySelectorAll('.goods-bt .event_list_box > div');

				const tabScroll = ()=> {
					const wSt = document.querySelector('html').scrollTop; // 釉뚮씪�곗� �ㅽ겕濡� �꾩튂

					for(let i = 0; i < tabBtns.length; i++){			
						if(wSt < tabBoxs[0].offsetTop - 190){ // �ㅽ겕濡� �꾩튂媛� 泥ル쾲吏� 諛뺤뒪 �꾩튂蹂대떎 ��쑝硫�
							for(tabBtn of tabBtns){
								tabBtn.classList.remove('on');
							}
						}else if(wSt > tabBoxs[i].offsetTop - 190){ // �ㅽ겕濡� �꾩튂媛� 媛� 諛뺤뒪留덈떎 �꾩튂�� �덉쑝硫�?
							for(tabBtn of tabBtns){
								tabBtn.classList.remove('on');
							}
							tabBtns[i].classList.add('on');
						}
					}
				}
				
				document.addEventListener('scroll', ()=> {
					tabScroll();		
				});                                     
				tabScroll();
		},
	};

	// 2025-04-16 硫붿씤由щ돱�� goodsOver(); �몄텧��
	window.MyApp = window.MyApp || {};
	MyApp.la = la;

	var wish = {
		list : null, curr:null, 
		init : function() {
			wish.list = ssq(".wish[data-wish]");
			ssq(document).on("click", ".wish[data-wish]", function(e){
				var obj = ssq(this), pno = obj.attr("data-wish");
				wish.changeWish(obj, pno);
			});
		},
		changeWish:function(obj,pno) {
			wish.curr = obj;
			var strQuery;
			var url;
			var elementname;
		
		
			strQuery = jQuery(":input", document.form2).serialize();
			url = "/product/put_wishlist.asp?rand=" + Math.random() + "&ProductNo=" + pno  + "&" + new Date().getTime(); 
		
		    var reqObj;
		    reqObj=initXMLHttp();
			reqObj.open("GET",url,true);
		    reqObj.onreadystatechange = function() {
		
		      if(reqObj.readyState == 4) {
		          if(reqObj.status==200) {
					eval("var response = (" + reqObj.responseText + ")");
		
					for(var i = 0; i < response.length;i++){				
						switch(response[i].title){
							case "type":
								type = response[i].value;
								break;
							case "total_qty":
								total_qty = response[i].value;
								break;
							default:
								break;
						}
					}
		
					if (type=='add') {
						obj.addClass("on");				
						//obj.html(total_qty);
					}
					else if(type=='remove') {
						obj.removeClass("on");				
						//obj.html(total_qty);
					}
					else if(type=='nothing') {
						alert("議댁옱�섏��딅뒗�쒗뭹�낅땲��.");	
					}
					else if(type=='error') {
						alert("�쒖뒪�쒖삤瑜섏엯�덈떎 [err03]");
					}	
					else if(type=='login') {
						alert("濡쒓렇�� �� �댁슜媛��ν빀�덈떎.");
						location.href = "/member/login.asp"
					}	
		          }
		      }
		    }
			reqObj.send(null);
		}
	}

	/* #HJ 201704 異붽� */
	function globalMenu() {
		jQuery.ajax({
			type: "POST",
			url: "/member/ajaxGlobalMenu.asp",
			dataType : "JSON",
			success: function(data) {
				var login = data.login;
				var cart = data.cart;
				var coupon = data.coupon;
				var point = data.point;
				var wishcnt = data.wishcnt;
				var joinText; 
						joinText = "<a href='https://www.fila.co.kr/member/join_intro.asp''>�뚯썝媛���</a>";
						joinText = joinText + "<div class='layer_join'>";
						joinText = joinText + "<h3>吏�湲� <span>FILA ONE</span> �뚯썝�� �섎㈃</h3>";
						joinText = joinText + "<ul>";
						joinText = joinText + "<li><span>10,000</span>�좉퇋媛��� 留뚯썝 荑좏룿 �쒓났</li>";
						joinText = joinText + "<li><span>Point</span>硫ㅻ쾭�� �곷┰ �쒗깮</li>";
						joinText = joinText + "<li><span>Coupon</span>湲곕뀗��/ �깃툒蹂� 荑좏룿�쒓났</li>";
						joinText = joinText + "</ul>";
						joinText = joinText + "<div class='btn_box'>";
						joinText = joinText + "<a href='https://www.fila.co.kr/member/join_intro.asp' class='btn_join'>�뚯썝媛���</a>";
						joinText = joinText + "<a href='http://www.fila.co.kr/customer/membership2.asp' class='btn_benefit'>�� 留롮� �쒗깮 蹂닿린</a>";
						joinText = joinText + "</div>";
						joinText = joinText + "</div>";
	
				if (login == 1) { 
						jQuery("#globalMenu1").html("<a href='/mypage/mypage.asp'>留덉씠�섏씠吏�</a>");
						jQuery("#globalMenu2").html("<a href='/mypage/myOrder.asp'>二쇰Ц/諛곗넚</a>");
						jQuery("#globalMenu3").html("<a href='/mypage/qna.asp'>1:1臾몄쓽</a>");
						jQuery("#globalMenu4").html("<a href='/mypage/coupon.asp'>荑좏룿</a><strong><a href='/mypage/coupon.asp'>" + coupon + "媛�</a></strong>");
						jQuery("#globalMenu5").html("<a href='/mypage/point.asp'>�ъ씤��</a><strong><a href='/mypage/point.asp'>" + point + "P</a></strong>");
						jQuery("#globalMenu7").html("<a href='/mypage/wishlist.asp'>�꾩떆由ъ뒪��</a><strong><a href='/mypage/wishlist.asp'>" + wishcnt + "媛�</a></strong>");						
						jQuery("#globalMenu8").html("<a href='/specialoffer/list.asp'>�대깽��</a>");
						jQuery("#globalMenu5").show();
						jQuery("#globalMenu6").show();
						jQuery("#globalMenu7").show();
						jQuery("#globalMenu1m").html("<a href='/member/logout.asp'>濡쒓렇�꾩썐</a>");
						jQuery("#globalMenu2m").html("<a href='/mypage/mypage.asp'>留덉씠�섏씠吏�</a>");
						jQuery("#globalMenu3m").html("<a href='/mypage/myOrder.asp'>二쇰Ц/諛곗넚</a>");					
						jQuery("#globalMenu4m").html("<a href='/customer/notice.asp'>怨좉컼�쇳꽣</a>");
						jQuery("#cart_cnt").attr("data-num",cart);
				}
				else {
						jQuery("#globalMenu1").html("<a href='/member/login.asp'>濡쒓렇��</a>");
						//jQuery("#globalMenu2").html(joinText);
						jQuery("#globalMenu2").html("<a href='/member/join_intro.asp' >�뚯썝媛���</a>");
						jQuery("#globalMenu3").html("<a href='/member/searchIDPW.asp'>�꾩씠�� 쨌 鍮꾨�踰덊샇 李얘린</a>");
						jQuery("#globalMenu8").html("<a href='/specialoffer/list.asp'>�대깽��</a>");
						//jQuery("#globalMenu4").html("<a href='/member/guest.asp'>鍮꾪쉶�� 二쇰Ц議고쉶</a>");
						jQuery("#globalMenu4").html("");
						jQuery("#globalMenu5").hide();
						jQuery("#globalMenu6").hide();
						jQuery("#globalMenu7").hide();
						jQuery("#globalMenu1m").html("<a href='/member/login.asp'>濡쒓렇��</a>");
						jQuery("#globalMenu2m").html("<a href='https://www.fila.co.kr/member/join_intro.asp'>�뚯썝媛���</a>");				
						jQuery("#globalMenu3m").html("<a href='/mypage/myOrder.asp'>二쇰Ц/諛곗넚</a>");					
						jQuery("#globalMenu4m").html("<a href='/customer/notice.asp'>怨좉컼�쇳꽣</a>");
						jQuery("#cart_cnt").attr("data-num",cart);
				}			
			},
			error: function(e) {
						jQuery("#globalMenu1").html("<a href='/member/login.asp'>濡쒓렇��</a>");
						//jQuery("#globalMenu2").html(joinText);
						jQuery("#globalMenu2").html("<a href='/member/join_intro.asp' >�뚯썝媛���</a>");
						jQuery("#globalMenu3").html("<a href='/member/searchIDPW.asp'>�꾩씠�� 쨌 鍮꾨�踰덊샇 李얘린</a>");
						//jQuery("#globalMenu4").html("<a href='/member/guest.asp'>鍮꾪쉶�� 二쇰Ц議고쉶</a>");
						jQuery("#globalMenu4").html("");
						jQuery("#globalMenu5").hide();
						jQuery("#globalMenu6").hide();
						jQuery("#globalMenu7").hide();
						jQuery("#globalMenu1m").html("<a href='/member/login.asp'>濡쒓렇��</a>");
						jQuery("#globalMenu2m").html("<a href='https://www.fila.co.kr/member/join_intro.asp'>�뚯썝媛���</a>");				
						jQuery("#globalMenu3m").html("<a href='/mypage/myOrder.asp'>二쇰Ц/諛곗넚</a>");					
						jQuery("#globalMenu4m").html("<a href='/customer/notice.asp'>怨좉컼�쇳꽣</a>");
						jQuery("#cart_cnt").attr("data-num","0");
			}
		});	
	}

})(jQuery);
function initXMLHttp() 
{
  var xmlHttp = false;
        
  if (window.XMLHttpRequest) { // Mozilla, Safari,...
     xmlHttp = new XMLHttpRequest();
     if (xmlHttp.overrideMimeType) {
     	// set type accordingly to anticipated content type
        //xmlHttp.overrideMimeType('text/xml');
        xmlHttp.overrideMimeType('text/html');
     }
  } else if (window.ActiveXObject) { // IE
     try {
        xmlHttp = new ActiveXObject("Msxml2.XMLHTTP");
     } catch (e) {
        try {
           xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
        } catch (e) {}
     }
  }
  if (!xmlHttp) {
     alert('Cannot create XMLHTTP instance');
     return false;
  }
    return xmlHttp;
}   


//AS議고쉶�� �곸뼱 �レ옄留� 媛���
function ReturnAsVal(obj,val) {
    obj.value = obj.value.replace(/[^a-zA-Z0-9]/g, '');
    
    if (obj.value == null || obj.value == "" || obj.value == 0) {
        obj.value = val;
    }
    /*
    alert(isNaN(obj.value));
    alert($.isNumeric(obj.value));
    alert(parseInt(obj.val));
    alert(parseInt("000"));
    */
}

var doubleSubmitFlag = false;

function fncSubmit(formName) {
    if(doubleSubmitFlag){
        return false;
    }else {
    	doubleSubmitFlag = true;
			formName.submit();
    }
}
function searchRun2() {
	var gnbFormObj = document.searchForm2;
	var FormObj = document.searchFormReal;	

	if(gnbFormObj.searchItem.value=="" || gnbFormObj.searchItem.value == "寃��됱뼱瑜� �낅젰�섏꽭��") {
		alert("寃��됱뼱瑜� �낅젰�섏꽭��.");
		gnbFormObj.searchItem.value = "";
		gnbFormObj.searchItem.focus();
		return;
	}
	else {
		tempItem = escape(gnbFormObj.searchItem.value);
		if (tempItem == "寃��됱뼱瑜� �낅젰�섏꽭��.") { 
			tempItem = "";
			gnbFormObj.searchItem.value = "";
		}
		else { 
			doubleSubmitFlag = false;
			FormObj.sWord.value = gnbFormObj.searchItem.value;
			FormObj.searchsCateNo.value = gnbFormObj.searchsCateNo.value;
			fncSubmit(FormObj);
			//FormObj.submit();		
		}				
	}
}
function searchRun3() {
	var gnbFormObj = document.searchForm3;
	var FormObj = document.searchFormReal;	

	if(gnbFormObj.searchItem.value=="" || gnbFormObj.searchItem.value == "寃��됱뼱瑜� �낅젰�섏꽭��") {
		alert("寃��됱뼱瑜� �낅젰�섏꽭��.");
		gnbFormObj.searchItem.value = "";
		gnbFormObj.searchItem.focus();
		return;
	}
	else {
		tempItem = escape(gnbFormObj.searchItem.value);
		if (tempItem == "寃��됱뼱瑜� �낅젰�섏꽭��.") { 
			tempItem = "";
			gnbFormObj.searchItem.value = "";
		}
		else { 
			FormObj.sWord.value = gnbFormObj.searchItem.value;
			FormObj.searchsCateNo.value = gnbFormObj.searchsCateNo.value;
			fncSubmit(FormObj);
			//FormObj.submit();		
		}				
	}
}
function searchsCate(n){
	$(".searchCate").removeClass("on");
	$(".searchs" + n).addClass("on");
	$("#searchsCateNo").val(n);
}

function searchsCate2(n){
	$(".searchCate2").removeClass("on");
	$(".searchss" + n).addClass("on");
	$("#searchsCateNo2").val(n);
}

function snsLogin(ss){
		window.open('https://' + location.host + '/socialConnect/call.asp?channel=' + ss + '&action=LOGIN','sns','width=500,height=500');
}
function snsLogin2(ss){
		location.href='https://' + location.host + '/socialConnect/call.asp?channel=' + ss + '&action=LOGIN';
}
function snsConnect(ss){
		window.open('https://' + location.host + '/socialConnect/call.asp?channel=' + ss + '&action=CONNECT','sns','width=500,height=500');
}
function snsClear(v1,v2){
	if (v1 != "" && v2 != ""){
		if(confirm("�곕룞�� �댁젣�섏떆寃좎뒿�덇퉴?")){
			dataFrame.location.href = "/member/snsClear.asp?v1=" + v1 + "&v2=" + v2;
		}
	}
}
//safe_send5()
function connectChk(ss){
	dataFrame.location.href = "/member/snsCheck.asp?v1=" + ss;
}

function snsJoin(ss){
		window.open('https://' + location.host + '/socialConnect/call.asp?channel=' + ss + '&action=JOIN','sns','width=500,height=500');
}

function wish_Cart_action(pno) {
				var btn = $('.cart__btn');
				var popup = function() {
					$.ajax({
						type: 'GET',
						url: '/pc/product/pop_wishcart.asp',
						data: 'pno=' + pno,
						dataType: 'html',
						success: function(html) {
							//$('body').append(html);
							$('#addLayerDiv').empty();
							$('#addLayerDiv').append(html);							
						},
						error: function(e) {

						}
					});
				} 
				
				popup();

				$('body').on('click', '.common__layer._option .close__btn', function(){
					$('.common__layer').remove();
				});
} 

function colorChgOpAll(obj){
	var pColorName = $(obj).attr("data-color");
	var pCode = $(obj).attr("data-code");
	document.form99.ProductNo.value = pColorName;
	document.form99.CodeProductColor.value = $(obj).attr("data-colorcode");	
	
//	alert($(obj).val());
	$(".colorName").html(pColorName);
	$(".cartVsize").empty();
	
	$(".cartVsize").html($(".colorSize" + $(obj).val()).html());
	$("input:radio[name='ProductSize_Cart']").prop("checked",false);
}

function PrintComma(srcNumber) {
	var txtNumber = '' + srcNumber;
	var rxSplit = new RegExp('([0-9])([0-9][0-9][0-9][,.])');
	var arrNumber = txtNumber.split('.');
	arrNumber[0] += '.';
	do 
	{
		arrNumber[0] = arrNumber[0].replace(rxSplit, '$1,$2');
	} while (rxSplit.test(arrNumber[0]));
	
	if (arrNumber.length > 1) 
	{
		return arrNumber.join('');
	}
	else 
	{
		return arrNumber[0].split('.')[0];
    }
}

var processImg = new Image();
processImg.src = "/pc/resource/images/waiting.gif";
var lang;

function changeToProcess(){
	var imgLang = "";
	if (lang == "ja"){
	imgLang = "ja/";
	}
/*					
	if (document.all){
		document.all['checkoutbtn'].innerHTML = "<button id='loginbtn2' class='btn_bg__bk btn _style_loading'></button>";
	} else if (document.layers){
		document.layers['checkoutbtn'].innerHTML = "<button id='loginbtn2'  class='btn_bg__bk btn _style_loading'></button>";
	} else if (document.getElementById){
		document.getElementById('checkoutbtn').innerHTML = "<button id='loginbtn2'  class='btn_bg__bk btn _style_loading'></button>";
	}
*/
	if (document.all){
		document.all['checkoutbtn'].innerHTML = "<a id='loginbtn2' class='btn_bg__bk btn _style_loading'></a>";
	} else if (document.layers){
		document.layers['checkoutbtn'].innerHTML = "<a id='loginbtn2'  class='btn_bg__bk btn _style_loading'></a>";
	} else if (document.getElementById){
		document.getElementById('checkoutbtn').innerHTML = "<a id='loginbtn2'  class='btn_bg__bk btn _style_loading'></a>";
	}
}

//@�대떦�쇱쟾泥닿��ъ슜
function ReturnNumberVal(obj,val) {
    obj.value = obj.value.replace(/[^0-9]/g, '');
    
    if (obj.value == null || obj.value == "" || obj.value == 0) {
        obj.value = val;
    }
    /*
    alert(isNaN(obj.value));
    alert($.isNumeric(obj.value));
    alert(parseInt(obj.val));
    alert(parseInt("000"));
    */
}

//�쇱そ�� 遺숈� 0 �쒓굅
function pointNumberVal(obj){
	if (obj.value.length > 1){
		obj.value = obj.value.replace(/(^0+)/, "");
	}
}
function shareTo( cte ) {
	if ( cte != "" ) {
		jQuery(".ssSocial-Sharing:eq(0) ." + cte + " a").click();
	}
}

jQuery(document).on("click", ".sWordRemove", function(e){ 
	var sWord = jQuery(this).parent("li").attr("data-sword")
	jQuery(this).parent("li").remove();
	jQuery.ajax({
		type: "GET",
		url: "/ext/searchRemove.asp",
		data: "sWord=" + sWord,
		dataType : "JSON",
		success: function(data) {
			if(data.result == ""){
				$(".latest__list").empty();
				$(".latest__list").append('<li class="no_search_list">理쒓렐 寃��됱뼱媛� �놁뒿�덈떎.</li>');
			}
		}
	})
	//寃��됱뼱 �⑥븘�덉쓣 寃쎌슦 �덉씠�� �� �ロ엳�꾨줉
	//if ( jQuery(".sWordRemove").length > 2 ) {
	//	e.stopPropagation();
	//}
});
function wordRemoveAll(){

	jQuery.ajax({
		type: "POST",
		url: "/ext/searchRemove.asp",
		data: "sWord=removeAll",
		dataType : "JSON",
		success: function(data) {
			$(".latest__list").empty();
			$(".latest__list").append('<li class="no_search_list">理쒓렐 寃��됱뼱媛� �놁뒿�덈떎.</li>');
		}
	})

}

jQuery(document).on("click", ".toDayViewRemove", function(e){ 
	var pno = jQuery(this).parent("li").attr("data-no")
	jQuery(this).parent("li").remove();
	jQuery.ajax({
		type: "GET",
		url: "/ext/todayViewRemove.asp",
		data: "pno=" + pno,
		dataType : "JSON",
		success: function(data) {
			if(data.result == ""){
				$(".todayViewList").empty();
				$(".todayViewList").append('<div class="tg-txt-box"><p>理쒓렐 蹂� �곹뭹�� �놁뒿�덈떎.</p>	</div>');
			}
		}
	})
});

function todayViewRemoveAll(){

	jQuery.ajax({
		type: "POST",
		url: "/ext/todayViewRemove.asp",
		data: "pno=removeAll",
		dataType : "JSON",
		success: function(data) {
				$(".todayViewList").empty();
				$(".todayViewList").append('<div class="tg-txt-box"><p>理쒓렐 蹂� �곹뭹�� �놁뒿�덈떎.</p>	</div>');
		}
	})

}

	//'''LHS 20220121	'''�ㅻ뒛�꾩갑 諛곗넚�좎씤 荑좏룿
	function todayCouponDown(){
		cpnUrl = "/event/todayCoupon/coupon_down.asp";

		jQuery.ajax({
			type: "POST",
			url: cpnUrl,
			dataType : "JSON",
			success: function(data) {
				var result = data.result;
				var msg = data.msg;

				if (result == 9) { 
					alert("濡쒓렇�� �� �댁슜�� 二쇱꽭��.");
					top.location.href=msg;
				}
				if (result == 2) { 
					alert(msg);
				}			
				if (result == 3) { 
					alert(msg);
				}						
				if (result == 0) { 
					alert(msg);
					todayDelivery();
					//top.location.href="/mypage/coupon.asp";
				}		
			},
			error: function(e) {

			}
		});	
	}


	//20240514 荑좏룿x �뚮┝�좎껌
	function groobee240514(){
		if ($("#promoCheck").is(":checked")){

			cpnUrl = "/event/groobee/20240514_result.asp";

			jQuery.ajax({
				type: "POST",
				url: cpnUrl,
				data: "rand=" + Math.random(),
				dataType : "JSON",
				success: function(data) {
					var result = data.result;
					var msg = data.msg;

					if (result == 9) { 
						alert("濡쒓렇�� �� �댁슜�� 二쇱꽭��.");
						top.location.href=msg;
					}
					if (result == 2) { 
						alert(msg);
						//$('body').addClass('cfm--open');
						//$('.eventCmt').html(msg);
					}			
					if (result == 3) { 
						alert(msg);
						//$('body').addClass('cfm--open');
						//$('.eventCmt').html(msg);
					}
					if (result == 8) { 
						alert(msg);
						//$('body').addClass('cfm--open');
						//$('.eventCmt').html(msg);
					}
					if (result == 0) { 
						alert(msg);
						//$('body').addClass('cfm--open');
						//$('.eventCmt').html(msg);
						//top.location.href="/mypage/coupon.asp";
					}		
				},
				error: function(e) {

				}
			});	

		}else{
			alert("SMS 留덉��� �섏떊�숈쓽�� �숈쓽�댁＜�몄슂.")
			//$('body').addClass('cfm--open');
			//$('.eventCmt').html("SMS 留덉��� �섏떊�숈쓽�� �숈쓽�댁＜�몄슂.");
		}
	}

	//20240320 荑좏룿x �먯궛�곗쭠 �뚮┝�좎껌
	function doosanAlrim2024(){
		if ($("#promoCheck").is(":checked")){

			cpnUrl = "/event/groobee/20240429_result.asp";

			jQuery.ajax({
				type: "POST",
				url: cpnUrl,
				data: "rand=" + Math.random(),
				dataType : "JSON",
				success: function(data) {
					var result = data.result;
					var msg = data.msg;

					if (result == 9) { 
						alert("濡쒓렇�� �� �댁슜�� 二쇱꽭��.");
						top.location.href=msg;
					}
					if (result == 2) { 
						alert(msg);
						//$('body').addClass('cfm--open');
						//$('.eventCmt').html(msg);
					}			
					if (result == 3) { 
						alert(msg);
						//$('body').addClass('cfm--open');
						//$('.eventCmt').html(msg);
					}
					if (result == 8) { 
						alert(msg);
						//$('body').addClass('cfm--open');
						//$('.eventCmt').html(msg);
					}
					if (result == 0) { 
						alert(msg);
						//$('body').addClass('cfm--open');
						//$('.eventCmt').html(msg);
						//top.location.href="/mypage/coupon.asp";
					}		
				},
				error: function(e) {

				}
			});	

		}else{
			alert("SMS 留덉��� �섏떊�숈쓽�� �숈쓽�댁＜�몄슂.")
			//$('body').addClass('cfm--open');
			//$('.eventCmt').html("SMS 留덉��� �섏떊�숈쓽�� �숈쓽�댁＜�몄슂.");
		}
	}


	//20240604 荑좏룿x �뚮┝�좎껌
	function ojosConfirm(){
		loginUrl = "/member/ajaxGlobalMenu.asp"
		jQuery.ajax({
			type: "POST",
			url: loginUrl,
			data: "rand=" + Math.random(),
			dataType : "JSON",
			success: function(logindata) {
				idName = logindata.idname;
				if (idName == ""){
					alert("濡쒓렇�� �� �댁슜�� 二쇱꽭��.");
					top.location.href="/member/login.asp";
				}else{
					if ($("#promoCheck").is(":checked")){

						cpnUrl = "/event/groobee/20240604_result.asp";

						jQuery.ajax({
							type: "POST",
							url: cpnUrl,
							data: "rand=" + Math.random(),
							dataType : "JSON",
							success: function(data) {
								var result = data.result;
								var msg = data.msg;

								if (result == 9) { 
									alert("濡쒓렇�� �� �댁슜�� 二쇱꽭��.");
									top.location.href=msg;
								}
								if (result == 2) { 
									alert(msg);
									//$('body').addClass('cfm--open');
									//$('.eventCmt').html(msg);
								}			
								if (result == 3) { 
									alert(msg);
									//$('body').addClass('cfm--open');
									//$('.eventCmt').html(msg);
								}
								if (result == 8) { 
									alert(msg);
									//$('body').addClass('cfm--open');
									//$('.eventCmt').html(msg);
								}
								if (result == 0) { 
									alert(msg);
									//$('body').addClass('cfm--open');
									//$('.eventCmt').html(msg);
									//top.location.href="/mypage/coupon.asp";
								}		
							},
							error: function(e) {

							}
						});	

					}else{
						alert("SMS 留덉��� �섏떊�숈쓽�� �숈쓽�댁＜�몄슂.")
						//$('body').addClass('cfm--open');
						//$('.eventCmt').html("SMS 留덉��� �섏떊�숈쓽�� �숈쓽�댁＜�몄슂.");
					}
				}
			},
			error: function(e) {

			}
		});

	}

	//20240612 荑좏룿x �뚮┝�좎껌
	function mw2406Confirm(){
		loginUrl = "/member/ajaxGlobalMenu.asp"
		jQuery.ajax({
			type: "POST",
			url: loginUrl,
			data: "rand=" + Math.random(),
			dataType : "JSON",
			success: function(logindata) {
				idName = logindata.idname;
				if (idName == ""){
					alert("濡쒓렇�� �� �댁슜�� 二쇱꽭��.");
					top.location.href="/member/login.asp";
				}else{
					if ($("#promoCheck").is(":checked")){

						cpnUrl = "/event/groobee/20240612_result.asp";

						jQuery.ajax({
							type: "POST",
							url: cpnUrl,
							data: "rand=" + Math.random(),
							dataType : "JSON",
							success: function(data) {
								var result = data.result;
								var msg = data.msg;

								if (result == 9) { 
									alert("濡쒓렇�� �� �댁슜�� 二쇱꽭��.");
									top.location.href=msg;
								}
								if (result == 2) { 
									alert(msg);
									//$('body').addClass('cfm--open');
									//$('.eventCmt').html(msg);
								}			
								if (result == 3) { 
									alert(msg);
									//$('body').addClass('cfm--open');
									//$('.eventCmt').html(msg);
								}
								if (result == 8) { 
									alert(msg);
									//$('body').addClass('cfm--open');
									//$('.eventCmt').html(msg);
								}
								if (result == 0) { 
									alert(msg);
									//$('body').addClass('cfm--open');
									//$('.eventCmt').html(msg);
									//top.location.href="/mypage/coupon.asp";
								}		
							},
							error: function(e) {

							}
						});	

					}else{
						alert("SMS 留덉��� �섏떊�숈쓽�� �숈쓽�댁＜�몄슂.")
						//$('body').addClass('cfm--open');
						//$('.eventCmt').html("SMS 留덉��� �섏떊�숈쓽�� �숈쓽�댁＜�몄슂.");
					}
				}
			},
			error: function(e) {

			}
		});

	}


	//'''LHS 20240701	'''湲고쉷�� 移댁뭅�� �뚯튇 荑좏룿�ㅼ슫濡쒕뱶
	function groobee240701(){
		cpnUrl = "/event/groobee/20240701_result.asp";

		jQuery.ajax({
			type: "POST",
			url: cpnUrl,
			dataType : "JSON",
			success: function(data) {
				var result = data.result;
				var msg = data.msg;

				if (result == 9) { 
					alert("濡쒓렇�� �� �댁슜�� 二쇱꽭��.");
					top.location.href=msg;
				}
				if (result == 2) { 
					alert(msg);
				}			
				if (result == 3) { 
					alert(msg);
				}						
				if (result == 0) { 
					alert(msg);
					//top.location.href="/mypage/coupon.asp";
				}		
			},
			error: function(e) {

			}
		});	
	}


	//20240712 荑좏룿x �뚮┝�좎껌
	function groobee240712(){
		loginUrl = "/member/ajaxGlobalMenu.asp"
		jQuery.ajax({
			type: "POST",
			url: loginUrl,
			data: "rand=" + Math.random(),
			dataType : "JSON",
			success: function(logindata) {
				idName = logindata.idname;
				if (idName == ""){
					alert("濡쒓렇�� �� �댁슜�� 二쇱꽭��.");
					top.location.href="/member/login.asp";
				}else{
					if ($("#promoCheck").is(":checked")){

						cpnUrl = "/event/groobee/20240712_result.asp";

						jQuery.ajax({
							type: "POST",
							url: cpnUrl,
							data: "rand=" + Math.random(),
							dataType : "JSON",
							success: function(data) {
								var result = data.result;
								var msg = data.msg;

								if (result == 9) { 
									alert("濡쒓렇�� �� �댁슜�� 二쇱꽭��.");
									top.location.href=msg;
								}
								if (result == 2) { 
									alert(msg);
									//$('body').addClass('cfm--open');
									//$('.eventCmt').html(msg);
								}			
								if (result == 3) { 
									alert(msg);
									//$('body').addClass('cfm--open');
									//$('.eventCmt').html(msg);
								}
								if (result == 8) { 
									alert(msg);
									//$('body').addClass('cfm--open');
									//$('.eventCmt').html(msg);
								}
								if (result == 0) { 
									alert(msg);
									//$('body').addClass('cfm--open');
									//$('.eventCmt').html(msg);
									//top.location.href="/mypage/coupon.asp";
								}		
							},
							error: function(e) {

							}
						});	

					}else{
						alert("SMS 留덉��� �섏떊�숈쓽�� �숈쓽�댁＜�몄슂.")
						//$('body').addClass('cfm--open');
						//$('.eventCmt').html("SMS 留덉��� �섏떊�숈쓽�� �숈쓽�댁＜�몄슂.");
					}
				}
			},
			error: function(e) {

			}
		});

	}

	//20240719 荑좏룿x �뚮┝�좎껌
	function groobee240719(){
		loginUrl = "/member/ajaxGlobalMenu.asp"
		jQuery.ajax({
			type: "POST",
			url: loginUrl,
			data: "rand=" + Math.random(),
			dataType : "JSON",
			success: function(logindata) {
				idName = logindata.idname;
				if (idName == ""){
					alert("濡쒓렇�� �� �댁슜�� 二쇱꽭��.");
					top.location.href="/member/login.asp";
				}else{
					if ($("#promoCheck").is(":checked")){

						cpnUrl = "/event/groobee/20240719_result.asp";

						jQuery.ajax({
							type: "POST",
							url: cpnUrl,
							data: "rand=" + Math.random(),
							dataType : "JSON",
							success: function(data) {
								var result = data.result;
								var msg = data.msg;

								if (result == 9) { 
									alert("濡쒓렇�� �� �댁슜�� 二쇱꽭��.");
									top.location.href=msg;
								}
								if (result == 2) { 
									alert(msg);
									//$('body').addClass('cfm--open');
									//$('.eventCmt').html(msg);
								}			
								if (result == 3) { 
									alert(msg);
									//$('body').addClass('cfm--open');
									//$('.eventCmt').html(msg);
								}
								if (result == 8) { 
									alert(msg);
									//$('body').addClass('cfm--open');
									//$('.eventCmt').html(msg);
								}
								if (result == 0) { 
									alert(msg);
									//$('body').addClass('cfm--open');
									//$('.eventCmt').html(msg);
									//top.location.href="/mypage/coupon.asp";
								}		
							},
							error: function(e) {

							}
						});	

					}else{
						alert("SMS 留덉��� �섏떊�숈쓽�� �숈쓽�댁＜�몄슂.")
						//$('body').addClass('cfm--open');
						//$('.eventCmt').html("SMS 留덉��� �섏떊�숈쓽�� �숈쓽�댁＜�몄슂.");
					}
				}
			},
			error: function(e) {

			}
		});

	}

	//20240807 荑좏룿x �뚮┝�좎껌
	function groobee240807(){
		loginUrl = "/member/ajaxGlobalMenu.asp"
		jQuery.ajax({
			type: "POST",
			url: loginUrl,
			data: "rand=" + Math.random(),
			dataType : "JSON",
			success: function(logindata) {
				idName = logindata.idname;
				if (idName == ""){
					alert("濡쒓렇�� �� �댁슜�� 二쇱꽭��.");
					top.location.href="/member/login.asp";
				}else{
					if ($("#promoCheck").is(":checked")){

						cpnUrl = "/event/groobee/20240807_result.asp";

						jQuery.ajax({
							type: "POST",
							url: cpnUrl,
							data: "rand=" + Math.random(),
							dataType : "JSON",
							success: function(data) {
								var result = data.result;
								var msg = data.msg;

								if (result == 9) { 
									alert("濡쒓렇�� �� �댁슜�� 二쇱꽭��.");
									top.location.href=msg;
								}
								if (result == 2) { 
									alert(msg);
									//$('body').addClass('cfm--open');
									//$('.eventCmt').html(msg);
								}			
								if (result == 3) { 
									alert(msg);
									//$('body').addClass('cfm--open');
									//$('.eventCmt').html(msg);
								}
								if (result == 8) { 
									alert(msg);
									//$('body').addClass('cfm--open');
									//$('.eventCmt').html(msg);
								}
								if (result == 0) { 
									alert(msg);
									//$('body').addClass('cfm--open');
									//$('.eventCmt').html(msg);
									//top.location.href="/mypage/coupon.asp";
								}		
							},
							error: function(e) {

							}
						});	

					}else{
						alert("SMS 留덉��� �섏떊�숈쓽�� �숈쓽�댁＜�몄슂.")
						//$('body').addClass('cfm--open');
						//$('.eventCmt').html("SMS 留덉��� �섏떊�숈쓽�� �숈쓽�댁＜�몄슂.");
					}
				}
			},
			error: function(e) {

			}
		});

	}

	//20240812 荑좏룿x �뚮┝�좎껌
	function groobee240812(){
		loginUrl = "/member/ajaxGlobalMenu.asp"
		jQuery.ajax({
			type: "POST",
			url: loginUrl,
			data: "rand=" + Math.random(),
			dataType : "JSON",
			success: function(logindata) {
				idName = logindata.idname;
				if (idName == ""){
					alert("濡쒓렇�� �� �댁슜�� 二쇱꽭��.");
					top.location.href="/member/login.asp";
				}else{
					if ($("#promoCheck").is(":checked")){

						cpnUrl = "/event/groobee/20240812_result.asp";

						jQuery.ajax({
							type: "POST",
							url: cpnUrl,
							data: "rand=" + Math.random(),
							dataType : "JSON",
							success: function(data) {
								var result = data.result;
								var msg = data.msg;

								if (result == 9) { 
									alert("濡쒓렇�� �� �댁슜�� 二쇱꽭��.");
									top.location.href=msg;
								}
								if (result == 2) { 
									alert(msg);
									//$('body').addClass('cfm--open');
									//$('.eventCmt').html(msg);
								}			
								if (result == 3) { 
									alert(msg);
									//$('body').addClass('cfm--open');
									//$('.eventCmt').html(msg);
								}
								if (result == 8) { 
									alert(msg);
									//$('body').addClass('cfm--open');
									//$('.eventCmt').html(msg);
								}
								if (result == 0) { 
									alert(msg);
									//$('body').addClass('cfm--open');
									//$('.eventCmt').html(msg);
									//top.location.href="/mypage/coupon.asp";
								}		
							},
							error: function(e) {

							}
						});	

					}else{
						alert("SMS 留덉��� �섏떊�숈쓽�� �숈쓽�댁＜�몄슂.")
						//$('body').addClass('cfm--open');
						//$('.eventCmt').html("SMS 留덉��� �섏떊�숈쓽�� �숈쓽�댁＜�몄슂.");
					}
				}
			},
			error: function(e) {

			}
		});

	}

	//'''LHS 20240813	'''湲고쉷�� 荑좏룿�ㅼ슫濡쒕뱶
	function groobee240813(){
		cpnUrl = "/event/groobee/20240813_result.asp";

		jQuery.ajax({
			type: "POST",
			url: cpnUrl,
			dataType : "JSON",
			success: function(data) {
				var result = data.result;
				var msg = data.msg;

				if (result == 9) { 
					alert("濡쒓렇�� �� �댁슜�� 二쇱꽭��.");
					top.location.href=msg;
				}
				if (result == 2) { 
					alert(msg);
				}			
				if (result == 3) { 
					alert(msg);
				}						
				if (result == 0) { 
					alert(msg);
					//top.location.href="/mypage/coupon.asp";
				}		
			},
			error: function(e) {

			}
		});	
	}

	//20240906 荑좏룿x �뚮┝�좎껌
	function groobee240906(){
		loginUrl = "/member/ajaxGlobalMenu.asp"
		jQuery.ajax({
			type: "POST",
			url: loginUrl,
			data: "rand=" + Math.random(),
			dataType : "JSON",
			success: function(logindata) {
				idName = logindata.idname;
				if (idName == ""){
					alert("濡쒓렇�� �� �댁슜�� 二쇱꽭��.");
					top.location.href="/member/login.asp";
				}else{
					if ($("#promoCheck").is(":checked")){

						cpnUrl = "/event/groobee/20240906_result.asp";

						jQuery.ajax({
							type: "POST",
							url: cpnUrl,
							data: "rand=" + Math.random(),
							dataType : "JSON",
							success: function(data) {
								var result = data.result;
								var msg = data.msg;

								if (result == 9) { 
									alert("濡쒓렇�� �� �댁슜�� 二쇱꽭��.");
									top.location.href=msg;
								}
								if (result == 2) { 
									alert(msg);
								}			
								if (result == 3) { 
									alert(msg);
								}
								if (result == 8) { 
									alert(msg);
								}
								if (result == 0) { 
									alert(msg);
								}		
							},
							error: function(e) {

							}
						});	

					}else{
						alert("SMS 留덉��� �섏떊�숈쓽�� �숈쓽�댁＜�몄슂.")
					}
				}
			},
			error: function(e) {

			}
		});

	}

	//'''LHS 20241001	'''湲고쉷�� 移댁뭅�� �뚯튇 荑좏룿�ㅼ슫濡쒕뱶
	function groobee241001(){
		cpnUrl = "/event/groobee/20241001_result.asp";

		jQuery.ajax({
			type: "POST",
			url: cpnUrl,
			dataType : "JSON",
			success: function(data) {
				var result = data.result;
				var msg = data.msg;

				if (result == 9) { 
					alert("濡쒓렇�� �� �댁슜�� 二쇱꽭��.");
					top.location.href=msg;
				}
				if (result == 2) { 
					alert(msg);
				}			
				if (result == 3) { 
					alert(msg);
				}						
				if (result == 0) { 
					alert(msg);
					//top.location.href="/mypage/coupon.asp";
				}		
			},
			error: function(e) {

			}
		});	
	}

	//'''LHS 20241101	'''湲고쉷�� �ㅼ쫰 11�� 荑좏룿�� 荑좏룿�ㅼ슫濡쒕뱶
	function groobee241101(){
		cpnUrl = "/event/groobee/20241101_result.asp";

		jQuery.ajax({
			type: "POST",
			url: cpnUrl,
			dataType : "JSON",
			success: function(data) {
				var result = data.result;
				var msg = data.msg;

				if (result == 9) { 
					alert("濡쒓렇�� �� �댁슜�� 二쇱꽭��.");
					top.location.href=msg;
				}
				if (result == 2) { 
					alert(msg);
				}			
				if (result == 3) { 
					alert(msg);
				}						
				if (result == 0) { 
					alert(msg);
					//top.location.href="/mypage/coupon.asp";
				}		
			},
			error: function(e) {

			}
		});	
	}

	//20241118 荑좏룿x �뚮┝�좎껌
	function groobee241121(){
		loginUrl = "/member/ajaxGlobalMenu.asp"
		jQuery.ajax({
			type: "POST",
			url: loginUrl,
			data: "rand=" + Math.random(),
			dataType : "JSON",
			success: function(logindata) {
				idName = logindata.idname;
				if (idName == ""){
					alert("濡쒓렇�� �� �댁슜�� 二쇱꽭��.");
					top.location.href="/member/login.asp";
				}else{
					if ($("#promoCheck").is(":checked")){

						cpnUrl = "/event/groobee/20241121_result.asp";

						jQuery.ajax({
							type: "POST",
							url: cpnUrl,
							data: "rand=" + Math.random(),
							dataType : "JSON",
							success: function(data) {
								var result = data.result;
								var msg = data.msg;

								if (result == 9) { 
									alert("濡쒓렇�� �� �댁슜�� 二쇱꽭��.");
									top.location.href=msg;
								}
								if (result == 2) { 
									alert(msg);
								}			
								if (result == 3) { 
									alert(msg);
								}
								if (result == 8) { 
									alert(msg);
								}
								if (result == 0) { 
									alert(msg);
								}		
							},
							error: function(e) {

							}
						});	

					}else{
						alert("SMS 留덉��� �섏떊�숈쓽�� �숈쓽�댁＜�몄슂.")
					}
				}
			},
			error: function(e) {

			}
		});

	}

	//'''LHS 20250106	'''湲고쉷�� �ㅼ썙�� 荑좏룿�ㅼ슫濡쒕뱶 
	function groobee250106(){
		cpnUrl = "/event/groobee/20250106_result.asp";
		var keyword = $("#keywordCpn").val();
		jQuery.ajax({
			type: "POST",
			url: cpnUrl,
			data : "keyword=" + keyword,
			dataType : "JSON",
			success: function(data) {
				var result = data.result;
				var msg = data.msg;

				if (result == 9) { 
					alert("濡쒓렇�� �� �댁슜�� 二쇱꽭��.");
					top.location.href=msg;
				}
				if (result == 2) { 
					alert(msg);
				}			
				if (result == 3) { 
					alert(msg);
				}						
				if (result == 0) { 
					alert(msg);
					//top.location.href="/mypage/coupon.asp";
				}		
			},
			error: function(e) {

			}
		});	
	}

	//'''LHS 20250101	'''湲고쉷�� 移댁뭅�� �뚯튇 荑좏룿�ㅼ슫濡쒕뱶
	function groobee250101(){
		cpnUrl = "/event/groobee/20250101_result.asp";

		jQuery.ajax({
			type: "POST",
			url: cpnUrl,
			dataType : "JSON",
			success: function(data) {
				var result = data.result;
				var msg = data.msg;

				if (result == 9) { 
					alert("濡쒓렇�� �� �댁슜�� 二쇱꽭��.");
					top.location.href=msg;
				}
				if (result == 2) { 
					alert(msg);
				}			
				if (result == 3) { 
					alert(msg);
				}						
				if (result == 0) { 
					alert(msg);
					//top.location.href="/mypage/coupon.asp";
				}		
			},
			error: function(e) {

			}
		});	
	}

	//'''LHS 20250116	'''湲고쉷�� 荑좏룿�ㅼ슫濡쒕뱶
	function groobee250116(){
		cpnUrl = "/event/groobee/20250116_result.asp";

		jQuery.ajax({
			type: "POST",
			url: cpnUrl,
			dataType : "JSON",
			success: function(data) {
				var result = data.result;
				var msg = data.msg;

				if (result == 9) { 
					alert("濡쒓렇�� �� �댁슜�� 二쇱꽭��.");
					top.location.href=msg;
				}
				if (result == 2) { 
					alert(msg);
				}			
				if (result == 3) { 
					alert(msg);
				}						
				if (result == 0) { 
					alert(msg);
					//top.location.href="/mypage/coupon.asp";
				}		
			},
			error: function(e) {

			}
		});	
	}

	//'''LHS 20250422	'''湲고쉷�� 荑좏룿�ㅼ슫濡쒕뱶
	function groobee250422(){
		cpnUrl = "/event/groobee/20250422_result.asp";

		jQuery.ajax({
			type: "POST",
			url: cpnUrl,
			dataType : "JSON",
			success: function(data) {
				var result = data.result;
				var msg = data.msg;

				if (result == 9) { 
					alert("濡쒓렇�� �� �댁슜�� 二쇱꽭��.");
					top.location.href=msg;
				}
				if (result == 2) { 
					alert(msg);
				}			
				if (result == 3) { 
					alert(msg);
				}						
				if (result == 0) { 
					alert(msg);
					//top.location.href="/mypage/coupon.asp";
				}		
			},
			error: function(e) {

			}
		});	
	}

	//'''LHS 20250512	'''湲고쉷�� 荑좏룿�ㅼ슫濡쒕뱶
	function groobee250512(){
		cpnUrl = "/event/groobee/20250512_result.asp";

		jQuery.ajax({
			type: "POST",
			url: cpnUrl,
			dataType : "JSON",
			success: function(data) {
				var result = data.result;
				var msg = data.msg;

				if (result == 9) { 
					alert("濡쒓렇�� �� �댁슜�� 二쇱꽭��.");
					top.location.href=msg;
				}
				if (result == 2) { 
					alert(msg);
				}			
				if (result == 3) { 
					alert(msg);
				}						
				if (result == 0) { 
					alert(msg);
					//top.location.href="/mypage/coupon.asp";
				}		
			},
			error: function(e) {

			}
		});	
	}

	//'''LHS 20250630	'''湲고쉷�� 荑좏룿�ㅼ슫濡쒕뱶
	function groobee250630(){
		cpnUrl = "/event/groobee/20250630_result.asp";

		jQuery.ajax({
			type: "POST",
			url: cpnUrl,
			dataType : "JSON",
			success: function(data) {
				var result = data.result;
				var msg = data.msg;

				if (result == 9) { 
					alert("濡쒓렇�� �� �댁슜�� 二쇱꽭��.");
					top.location.href=msg;
				}
				if (result == 2) { 
					alert(msg);
				}			
				if (result == 3) { 
					alert(msg);
				}						
				if (result == 0) { 
					alert(msg);
					//top.location.href="/mypage/coupon.asp";
				}		
			},
			error: function(e) {

			}
		});	
	}
	//'''LHS 20250721	'''湲고쉷�� 荑좏룿�ㅼ슫濡쒕뱶
	function groobee250721(){
		cpnUrl = "/event/groobee/20250721_result.asp";

		jQuery.ajax({
			type: "POST",
			url: cpnUrl,
			dataType : "JSON",
			success: function(data) {
				var result = data.result;
				var msg = data.msg;

				if (result == 9) { 
					alert("濡쒓렇�� �� �댁슜�� 二쇱꽭��.");
					top.location.href=msg;
				}
				if (result == 2) { 
					alert(msg);
				}			
				if (result == 3) { 
					alert(msg);
				}						
				if (result == 0) { 
					alert(msg);
					//top.location.href="/mypage/coupon.asp";
				}		
			},
			error: function(e) {

			}
		});	
	}

	//'''LHS 20250912	'''湲고쉷�� 荑좏룿�ㅼ슫濡쒕뱶
	function groobee250915(){
		cpnUrl = "/event/groobee/20250915_result.asp";

		jQuery.ajax({
			type: "POST",
			url: cpnUrl,
			dataType : "JSON",
			success: function(data) {
				var result = data.result;
				var msg = data.msg;

				if (result == 9) { 
					alert("濡쒓렇�� �� �댁슜�� 二쇱꽭��.");
					top.location.href=msg;
				}
				if (result == 2) { 
					alert(msg);
				}			
				if (result == 3) { 
					alert(msg);
				}						
				if (result == 0) { 
					alert(msg);
					//top.location.href="/mypage/coupon.asp";
				}		
			},
			error: function(e) {

			}
		});	
	}

	//'''LHS 20250912	'''湲고쉷�� 荑좏룿�ㅼ슫濡쒕뱶
	function groobee250915_2(){
		cpnUrl = "/event/groobee/20250915_2_result.asp";

		jQuery.ajax({
			type: "POST",
			url: cpnUrl,
			dataType : "JSON",
			success: function(data) {
				var result = data.result;
				var msg = data.msg;

				if (result == 9) { 
					alert("濡쒓렇�� �� �댁슜�� 二쇱꽭��.");
					top.location.href=msg;
				}
				if (result == 2) { 
					alert(msg);
				}			
				if (result == 3) { 
					alert(msg);
				}						
				if (result == 0) { 
					alert(msg);
					//top.location.href="/mypage/coupon.asp";
				}		
			},
			error: function(e) {

			}
		});	
	}

	//'''LHS 20250917	'''湲고쉷�� 荑좏룿�ㅼ슫濡쒕뱶
	function groobee250919(mode){
		cpnUrl = "/event/groobee/20250919_result.asp";

		jQuery.ajax({
			type: "POST",
			url: cpnUrl,
			data: "mode=" + mode,
			dataType : "JSON",
			success: function(data) {
				var result = data.result;
				var msg = data.msg;

				if (result == 9) { 
					alert("濡쒓렇�� �� �댁슜�� 二쇱꽭��.");
					top.location.href=msg;
				}
				if (result == 2) { 
					alert(msg);
				}			
				if (result == 3) { 
					alert(msg);
				}						
				if (result == 0) { 
					alert(msg);
					//top.location.href="/mypage/coupon.asp";
				}		
			},
			error: function(e) {

			}
		});	
	}

	//'''LHS 20251030	'''湲고쉷�� 荑좏룿�ㅼ슫濡쒕뱶
	function groobee251030(){
		cpnUrl = "/event/groobee/20251030_result.asp";

		jQuery.ajax({
			type: "POST",
			url: cpnUrl,
			dataType : "JSON",
			success: function(data) {
				var result = data.result;
				var msg = data.msg;

				if (result == 9) { 
					alert("濡쒓렇�� �� �댁슜�� 二쇱꽭��.");
					top.location.href=msg;
				}
				if (result == 2) { 
					alert(msg);
				}			
				if (result == 3) { 
					alert(msg);
				}						
				if (result == 0) { 
					alert(msg);
					//top.location.href="/mypage/coupon.asp";
				}		
			},
			error: function(e) {

			}
		});	
	}

	//'''LHS 20251216	'''湲고쉷�� 荑좏룿�ㅼ슫濡쒕뱶
	function groobee251216(){
		cpnUrl = "/event/groobee/20251216_result.asp";

		jQuery.ajax({
			type: "POST",
			url: cpnUrl,
			dataType : "JSON",
			success: function(data) {
				var result = data.result;
				var msg = data.msg;

				if (result == 9) { 
					alert("濡쒓렇�� �� �댁슜�� 二쇱꽭��.");
					top.location.href=msg;
				}
				if (result == 2) { 
					alert(msg);
				}			
				if (result == 3) { 
					alert(msg);
				}						
				if (result == 0) { 
					alert(msg);
					//top.location.href="/mypage/coupon.asp";
				}		
			},
			error: function(e) {

			}
		});	
	}

	//20251218 荑좏룿x �뚮┝�좎껌
	function groobee251218(){
		loginUrl = "/member/ajaxGlobalMenu.asp"
		jQuery.ajax({
			type: "POST",
			url: loginUrl,
			data: "rand=" + Math.random(),
			dataType : "JSON",
			success: function(logindata) {
				idName = logindata.idname;
				if (idName == ""){
					alert("濡쒓렇�� �� �댁슜�� 二쇱꽭��.");
					top.location.href="/member/login.asp";
				}else{
					if ($("#promoCheck").is(":checked")){

						cpnUrl = "/event/groobee/20251218_result.asp";

						jQuery.ajax({
							type: "POST",
							url: cpnUrl,
							data: "rand=" + Math.random(),
							dataType : "JSON",
							success: function(data) {
								var result = data.result;
								var msg = data.msg;

								if (result == 9) { 
									alert("濡쒓렇�� �� �댁슜�� 二쇱꽭��.");
									top.location.href=msg;
								}
								if (result == 2) { 
									alert(msg);
								}			
								if (result == 3) { 
									alert(msg);
								}
								if (result == 8) { 
									alert(msg);
								}
								if (result == 0) { 
									alert(msg);
								}		
							},
							error: function(e) {

							}
						});	

					}else{
						alert("SMS 留덉��� �섏떊�숈쓽�� �숈쓽�댁＜�몄슂.")
					}
				}
			},
			error: function(e) {

			}
		});

	}


// 洹몃（鍮� 異붿쿇 �곹뭹 �섏떊 怨� �몄텧 泥섎━瑜� �꾪븳 �꾩닔 �ㅽ겕由쏀듃 �⑥닔
// �⑥닔紐� 蹂�寃� 遺덇�
var goodspno = "";
var goodspno2 = "";
var ValgorithmCd = "";
var VcampaignKey = "";
var ValgorithmCd2 = "";
var VcampaignKey2 = "";

function setGroobeeRecommend (algorithmCd, campaignKey, goodsArray) {

goodspno = "";
goodspno2 = "";
console.log(campaignKey);
console.log(goodsArray);
	//�λ컮援щ땲 異붿쿇�곹뭹 , 硫붿씤 異붿쿇�곹뭹
	if (campaignKey == "RE738f096310d14a80aa0e6c99d11f9b43" ){
		//�λ컮援щ땲 �앹뾽
		for(key in goodsArray) {
			for (key2 in goodsArray[key]){
				if (goodspno == ""){
					goodspno = goodsArray[key][key2];
				}else{
					goodspno += "," + goodsArray[key][key2];
				}
				
			}
		}


		ValgorithmCd = algorithmCd;
		VcampaignKey = campaignKey;

		//"RE738f096310d14a80aa0e6c99d11f9b43"
		  // 異붿쿇 �곹뭹 �몄텧 泥섎━
		  var groobeeObj;
		  groobeeObj = {
			  algorithmCd : algorithmCd,
			  campaignKey : campaignKey,
			  campaignTypeCd : "RE",
			  goods: goodsArray
		  }
		  groobee.send("DI", groobeeObj);
		
	}else{
		mode = "view";
		if (campaignKey == "RE7b06443a1835447885f5397a2ad35ea3"){
			//�곸꽭 �곷떒
			tagID = "";
		}else if(campaignKey == "RE3ba0cf1effa6490f9216acae3703cba5///" || campaignKey == "REe82aabcd847a42ec827f14aebd7dacd41" || campaignKey == "REe82aabcd847a42ec827f14aebd7dacd4") {
			//�곸꽭 �섎떒
			tagID = "recopickProduct";
			mode = "MAINDIVCART"
		}else if(campaignKey == "REc35a1dc7440342d7a61c65d4e92b2fd9///" || campaignKey == "RE63da5c31590d4fe9bb342b6d5c72c2a2" || campaignKey == "REf70e838c71bf4db080614ac8405f5fe1" || campaignKey == "REc0b801fec2a44867b7cfad920d94b778///"){
			//寃��됲럹�댁�,�ㅻ뒛 蹂� �곹뭹,�꾩떆由ъ뒪��, �λ컮援щ땲
			tagID = "recopickProduct";
			mode = "MAINDIVCART"
		}else if(campaignKey == "REd9c4a9844e4a43d6b5c5cb1cc570b743" || campaignKey == "RE9fe4a0d8b08149d2ad955d0983e89c17" || campaignKey == "RE8f31195d88214821946733f00d611266"){
			//湲고쉷�� �곸꽭,二쇰Ц�꾨즺, 二쇰Ц�곸꽭
			tagID = "recopickProduct";
			mode = "MAINDIV"
		}else if(campaignKey == "REae0d8912d1c34563a8f031af8b2a0181"){
			//2021-08-19 1n1�곸꽭 �곷떒
			tagID = "recopickProduct";
		}else if(campaignKey == "REa8d64c1e7c7045cdaa9557c4ae83e07b"){
			//2021-08-19 1n1�곸꽭 �섎떒
			tagID = "";
		}else if(campaignKey == "REa6ff915f494d46eca43851470022812f///"){
			//2021-09-16 KIDS Items you�셪l like
			tagID = "recopickProduct";
			mode = "MAINDIV"
		}else if(campaignKey == "RE3ca54f07932b48b8857a8c1182dcacde"){
			//2022-05-13 /order/mafila.asp
			tagID = "recopickProduct";
			mode = "MAINDIV"
		}else if (campaignKey == "REdcc67e4f8778494eac3e99f4ee2f7a5c///"){
			//硫붿씤異붿쿇
			tagID = "recopickProduct";
			mode = "MAINDIVCART"
		}else if (campaignKey == "RE116ac5cf56024f5dbd474f9e4f8eb95a" )	{
			//�곸꽭 �섎떒2
			tagID = "recopickProduct2";
			mode = "MAINDIVCART"
		}else{
			tagID = "";
		}

		for(key in goodsArray) {
			for (key2 in goodsArray[key]){
				if (goodspno2 == ""){
					goodspno2 = goodsArray[key][key2];
				}else{
					goodspno2 += "," + goodsArray[key][key2];
				}
				
			}
		}

		ValgorithmCd2 = algorithmCd;
		VcampaignKey2 = campaignKey;

		  // 異붿쿇 �곹뭹 �몄텧 泥섎━
		  var groobeeObj;
		  groobeeObj = {
			  algorithmCd : algorithmCd,
			  campaignKey : campaignKey,
			  campaignTypeCd : "RE",
			  goods: goodsArray
		  }
		  groobee.send("DI", groobeeObj);
		console.log(tagID)
		if (tagID != ""){
			GetCartGroobeView(tagID,algorithmCd, campaignKey, goodspno2,mode)
		}
	}

}
// 異붿쿇 �곹뭹 �대┃ �� �몄텧 �섎뒗 �ㅽ겕由쏀듃 �⑥닔
// �⑥닔紐� �먯쑀 �묒꽦
function clickGroobeeProduct (algorithmCd, campaignKey, goodsNo) {
  // 異붿쿇 �곹뭹 �대┃ 泥섎━
  var groobeeObj;
  groobeeObj = {
    algorithmCd : algorithmCd,
    campaignKey : campaignKey,
    campaignTypeCd : "RE",
    goods: [
        {goodsCd: goodsNo}
    ]
  } 
  groobee.send("CL", groobeeObj);

  // �섏씠吏� �대룞 泥섎━
// [�붽퀬媛앹궗 �묒꽦 �곸뿭 code��

}


function GetCartGroobeView(tagID,algorithmCd, campaignKey, goodsNo,mode){

	//console.log(slidesNo);
	jQuery.ajax({
		type: "POST",
		url: "/ext/groobe_cart_data.asp",
		data: { "productNo" : goodsNo, "algorithmCd" : algorithmCd, "campaignKey" : campaignKey, "mode" : mode},
		async: true,
		success: function (data) {
				if ( data == "" )	{
					jQuery("#" + tagID).hide();
				}else {
					jQuery("#" + tagID).show();
					jQuery("#" + tagID).append(data);					
				}


			}
	})
}

function GetCartInsiderView(tagID,campaignId,variationId,goodsNo,mode){

	//console.log(slidesNo);
	jQuery.ajax({
		type: "POST",
		url: "/ext/groobe_cart_data.asp",
		data: { "productNo" : goodsNo, "campaignId" : campaignId, "variationId" : variationId , "mode" : mode},
		async: true,
		success: function (data) {
				if ( data == "" )	{
					jQuery("#" + tagID).hide();
				}else {
					jQuery("#" + tagID).empty();
					jQuery("#" + tagID).addClass("ins-preview-wrapper-" + variationId);
					jQuery("#" + tagID).show();
					jQuery("#" + tagID).html(data);				
				}


			}
	})
}


function checkoutbtn_getback() {
	var str = '<a href="javascript:pay_checkout();void(0);" class="btn_bg__bk on">援щℓ�섍린</a>';
	jQuery("#checkoutbtn").html(str);
}

function sWordHistory(){
	jQuery.ajax({
		type: "POST",
		url: "/main/sWordHistory.asp",
		data: "",
		dataType : "HTML",
		success: function (data) {
			$("#sWordHistory").empty().html(data);
		}
	})
}


jQuery(function(){
	// �섎웾 鍮쇨린
	jQuery(document).on("click",  "#vpop99 button[id^=qtyMinusW]", function() {

		var maxStock = jQuery("input:radio[name='ProductSize_Cart']:checked").attr("data-limit") != undefined ?jQuery("input:radio[name='ProductSize_Cart']:checked").attr("data-limit") : ProductStockLimitNumber ; 
		var minStock = maxStock > 0 ? 1 : 0 ;

		var obj = jQuery(this).next( "input[id^=ProductQuantityW]" )
		var qtyVal = obj.val(); 
		
		qtyVal = jQuery.isNumeric(qtyVal) ? qtyVal : minStock ;
		qtyVal--;
		qtyVal = qtyVal < minStock ? minStock : qtyVal ;
		obj.val( qtyVal );
		var val7 = document.form99.cartPrice.value;
		$("#ctoprice").html(PrintComma(val7*qtyVal)+"��");
	})
	// �섎웾 �뷀븯湲�
	jQuery(document).on("click",  "#vpop99 button[id^=qtyPlusW]", function() {
		var maxStock = jQuery("input:radio[name='ProductSize_Cart']:checked").attr("data-limit") != undefined ?jQuery("input:radio[name='ProductSize_Cart']:checked").attr("data-limit") : ProductStockLimitNumber ; 
		var minStock = maxStock > 0 ? 1 : 0 ;
		//console.log(11);
		var obj = jQuery(this).prev( "input[id^=ProductQuantityW]" ); 
		var qtyVal = obj.val(); 
		qtyVal = jQuery.isNumeric(qtyVal) ? qtyVal : minStock ;
		qtyVal++;
		if (qtyVal > maxStock) { 
			alert(maxStock + "媛� 源뚯�留� 二쇰Ц 媛��ν빀�덈떎");
		}
		qtyVal = qtyVal > maxStock ? maxStock : qtyVal ;
		obj.val( qtyVal );
		var val7 = document.form99.cartPrice.value;
		$("#ctoprice").html(PrintComma(val7*qtyVal)+"��");
	})
	jQuery(document).on("blur", "#vpop99 input[id^=ProductQuantityW]", function() {
		var maxStock = jQuery("input:radio[name='ProductSize_Cart']:checked").attr("data-limit") != undefined ?jQuery("input:radio[name='ProductSize_Cart']:checked").attr("data-limit") : ProductStockLimitNumber ; 
		var minStock = maxStock > 0 ? 1 : 0 ;

		var regex = /[0-9]|\./;
		var obj = jQuery(this);
		var val = obj.val();
		if (val > maxStock) { 
			alert(maxStock + "媛� 源뚯�留� 二쇰Ц 媛��ν빀�덈떎");
		}
		!regex.test( val ) ? obj.val( minStock ) : "" ;

		val < minStock ? obj.val( minStock ) : "" ;
		val > maxStock ? obj.val( maxStock ) : "" ;
		var val7 = document.form99.cartPrice.value;
		$("#ctoprice").html(PrintComma(val7*qtyVal)+"��");
	})

	//'''20250307 searchHistoryAjax
	sWordHistory();
})

