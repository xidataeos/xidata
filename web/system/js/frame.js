
$(function(){
	$("#left").load('left.html');
	$('nav').load('top.html',function(){
		pageHeight();
	});
	
})

// 页面高度
function pageHeight(){
	var wh = $(window).height();
	var ph = $('#container').height();
	if(ph < wh){
		$('#container').css({"height":wh})
	}
}
