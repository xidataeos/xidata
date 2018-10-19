 
var index = {
	
	getUserinfo :function(){
		
		$.ajax({
			type:"get",
			url:"http://192.168.154.107:8080/user/info",
			data:{"userId":'002101'},
			dataType: "json",
			success:function(data){
				//debugger
				$('.header_name').html(data.data.name);		// 用户名
				$(".header_img").find("img").attr("src",data.data.photo);	//用户头像
				
				
				
				
				
			}
		});
		
	}
	
	
}



$(function(){
	index.getUserinfo();
})
