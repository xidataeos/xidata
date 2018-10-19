
	$(function() {
		$('.loginbox').css({
			'position': 'absolute',
			'left': ($(window).width() - 692) / 2
		});
		$(window).resize(function() {
			$('.loginbox').css({
				'position': 'absolute',
				'left': ($(window).width() - 692) / 2
			});
		})
		login.clickVerify();
		//login.loginBtn();
	});

	
	var login = {
		
		// 点击获取验证码
		clickVerify :function(){
			$('.get_verification').click(function(){
				var ph = $('#phoneNumber').val();
				if(ph == ''){
					alert("请先输入手机号码")
				}else if(!(/^1(3|4|5|7|8)\d{9}$/.test(ph))){ 
			        alert("手机号码有误，请重新填写");  
			        return false; 
				   
				}else{
					login.getVerification(ph);
					login.countDown();
				}
				
				
			})
		},
		
		// 验证码倒计时
		countDown:function(){
			var num = 60;
			var timer = setInterval(function () {
				
                if(num == 0){
                    $(".get_verification").attr("disabled",false).css({"color":"#000","cursor":"pointer"}).val("获取验证码");
					clearInterval(timer);
                }else {
                    $(".get_verification").attr("disabled",true).css({"color":"#aaa","cursor":"default"}).val("重新获取（"+num+"秒）");
					num -- ;
                }
            },1000);
			
		},
		
		// 获取验证码
		getVerification:function(ph){
			$.ajax({
				type:"post",
				url:"http://192.168.154.107:8080/login/tel",
				data:{"tel":ph},
				dataType: "json",
				success:function(data){
					if(data.status == 200){
						console.log("验证码发送成功。")
					}else{
						console.log("验证码发送失败。")
					}
					
					if(data.data.isReg == 1){
						$("#user_option").html('<input name="" type="button" class="resite_btn" value="注册" />');
						login.register();
					}else{
						$("#user_option").html('<input name="" type="button" class="loginbtn" value="登录" />');
						login.loginBtn();
					}
				}
			});
			
			
		},
		
		// 注册
		register:function(){
			$(".resite_btn").click(function(){
				login.registerVerify()
			})
		},
		
		// 登陆
		loginBtn:function(){
			$(".loginbtn").click(function(){
				login.loginVerify()
			})
		},
		
		// 登陆验证
		loginVerify:function(){
			var verify = true;
			var t = $("#phoneNumber").val();
			var v = $(".loginpwd").val();
			
			if(t == ""){
				alert("请先输入手机号码");
				verify = false;
			}else if(v == ""){
				alert("请先输入验证码");
				verify = false;
			}
			
			if(verify){
				// 提交
				$.ajax({
					type:"post",
					url:"http://192.168.154.107:8080/login/signin",
					data:{"verifyCode": v, "tel": t,},
					dataType:"json",
					success:function(data){
						if(data.status == 200){
							window.location.href='index.html';			
						}else{
							alert(data.message)
						}
					},
					error:function(data){
						alert(data.message)
					}
				});
			}
			
		},
		
		// 注册验证
		registerVerify:function(){
			var verify = true;
			var t = $("#phoneNumber").val();
			var v = $(".loginpwd").val();
			
			if(t == ""){
				alert("请先输入手机号码");
				verify = false;
			}else if(v == ""){
				alert("请先输入验证码");
				verify = false;
			}
			
			if(verify){
				// 注册提交
				$.ajax({
					type:"post",
					url:"http://192.168.154.107:8080/login/signup",
					data:{"verifyCode": v, "tel": t},
					dataType:"json",
					success:function(data){
						debugger
						if(data.status == 200){
							window.location.href='index.html';			
						}else{
							alert(data.message)
						}
					},
					error:function(data){
						alert(data.message)
					}
				});
			}
			
		}
		
		
	}
