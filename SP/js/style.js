$(function() {
	$("div#menu").on("touchstart", function(){
    	if($('div#base-wrapper').css('left') != '200px') {
			$('div#base-wrapper').stop().animate({ left: 200 }, 200, 'easeOutQuint');
			$('div#topic-pic h4').css('width', '100%');
			$(window).on('touchmove.noScroll', function(e) {e.preventDefault()});
		} else {
			if($('div#base-wrapper').css('left') == '200px') {
				$('div#base-wrapper').stop().animate({ left: 0 }, 200, 'easeOutQuint');
				$(window).off('.noScroll');
			}
		}
	})
});

// ブラウザ用
// $(function(){
// 	$("div#menu").click(function(){
// 		if($('div#base-wrapper').css('left') != '200px') {
// 			$('div#base-wrapper').stop().animate({ left: 200 }, 200, 'easeOutQuint');
// 			$('div#topic-pic h4').css('width', '100%');
// 			$(window).on('touchmove.noScroll', function(e) {e.preventDefault()});
// 		} else {
// 			if($('div#base-wrapper').css('left') == '200px') {
// 				$('div#base-wrapper').stop().animate({ left: 0 }, 200, 'easeOutQuint');
// 				$(window).off('.noScroll');
// 			}
// 		}
// 	});
// });

$(document).on("touchstart", function(event) {
    if (!$.contains($('nav')[0], event.target)) {
        if($('div#base-wrapper').css('left') == '200px') {
			$('div#base-wrapper').stop().animate({ left: 0 }, 200, 'easeOutQuint');
			$(window).off('.noScroll');
		}
    }
});