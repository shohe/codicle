// スライドメニュー
$(function(){
	var menu = SpSlidemenu({
		main : '#main',
		button: '.menu-button-left',
		slidemenu : '.slidemenu-left',
		direction: 'left'
	});
});

// ヘッダーを常に表示
$(window).scroll(function () {
	var posTop = window.pageYOffset;
	$('header').css('top',posTop);
});


