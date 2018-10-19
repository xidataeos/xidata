

function popPosition(popup){
	var scrollHeight = $(document).scrollTop();//获取当前窗口距离页面顶部高度
    var windowHeight = $(window).height();//获取当前窗口高度
    var windowWidth = $(window).width();//获取当前窗口宽度
    var popupHeight = popup.height();//获取弹出层高度
    var popupWeight = popup.width();//获取弹出层宽度
    var posiTop = (windowHeight)/2 - (popupHeight/2);
    var posiLeft = (windowWidth)/2 - (popupWeight/2);
    popup.css({"left": posiLeft + "px","top":posiTop + "px","display":"block"});//设置position
    $('body').append('<div class="popup_shadow"></div>');
    
    popup.find('.popup-head-close').click(function(){
    	$(".popup_shadow").remove();
    	popup.hide();
    })
    
}



