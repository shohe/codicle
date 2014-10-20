
// スライドメニュー
$(function(){
	var menu = SpSlidemenu({
		main : '#main',
		button: '.menu-button-left',
		slidemenu : '.slidemenu-left',
		direction: 'left'
	});
});

// 写真固定
// $(window).scroll(function (){
// 	var posTop = window.pageYOffset;
// 	if(posTop >= 0){
// 		$('#article-pic').css('transform','translate3d(0px, '+posTop+'px, 0px)');
// 	} else {
// 		$('#article-pic').css('transform','translate3d(0px, 0px, 0px)');
// 	}
// });


