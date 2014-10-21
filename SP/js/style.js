
// スライドメニュー
$(function(){
	var menu = SpSlidemenu({
		main : '#main',
		button: '.menu-button-left',
		slidemenu : '.slidemenu-left',
		direction: 'left'
	});

	$('.list-img').bind('load',function(){
		// 画像トリミング
	    if($(this).height() > $(this).width()){
	    	$(this).css({'height':'auto', 'width':'75px', 'top':'-20px'});
	    } else {
	    	$(this).css({'width':'auto', 'height':'75px', 'top':'0px'});
	    }

	    // 画像リサイズ
	    if($(this).height() > $(this).width()){
	    	$(this).css({'height':'auto', 'width':'75px', 'top':'-20px'});
	    } else {
	    	$(this).css({'width':'auto', 'height':'75px', 'top':'0px'});
	    }
    });
});


