<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
    <c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>personal</title>
    <link rel="stylesheet" type="text/css" href="${ctx }/css/personal.css"/>
       <script src="${ctx }/js/jquery-2.2.0.min.js"></script>
		<script type="text/javascript">
			function check(){
				var str = document.search.message.value;
				if(str.length<1){
					document.getElementById('id').disabled=true;
				}else{
					document.getElementById('id').disabled=false;
				}
			}
			setInterval(check,100);  //循环调用函数判断搜索框中为空值是，搜索按钮不可点击
		</script>
	</head>
	<body>
		<div id="person_banner">
			<div id="banner_logo"><img src="${ctx }/img/logo1.png"></div>
			<form name="search" method="get" action="ss">
			<div id="banner_seek"> <input type="text" name="message" id="banner_input_size" ></div>
			<div id="banner_button"><input type="submit" value="搜索"  id="id" class="banner_button_style" ></div>
			</form>
			<div id="banner_logo_address"> <img src="${ctx }/img/adress.png"></div>
			<div id="banner_address_position"><span>石家庄</span><button id="banner_aderss_button">切换地址</button></div>
			<div class="banner_personcenter_position" >
				<div id="d1"></div>		
				<div id="d2">
					<div id="d1-3"></div>
					<div id="d1-1">
						<div id="d1-1-1"><img src="${ctx }/img/Personal Center .png" width="100%" height="100%"></div>
						<div id="d1-1-2">哇哈哈</div>
					</div>
					<div id="d1-2">
						<div id="d2-2-1">个人资料</div>
						<div id="d2-2-2">预约</div>
						<div id="d2-2-3">访问历史</div>
						<div id="d2-2-4">收藏</div>

					</div>
				</div>		
			</div>
		</div>
		
		<div class="main_left">
			<div class="image"  id="image"><img src="${ctx }/img/1.jpg" width="100%" height="100%"></div>
			<div class="image_change" id="image_change">
				<img src="${ctx }/img/timg.jpg"width="100%" height="100%">
				<p class="image_text" id="image_text">更换头像</p>
			</div>
			<div class="username">昵称</div>
			<div class="username_mananger">账户管理</div>
				<div class="usermessage"></div>
				<a  href="${ctx }/user/person_message?address=message" target="preson_megs"><div class="usermessage1" id="usermessage1" name="yes">个人信息</div></a>
				<a  href="${ctx }/user/person_message?address=history" target="preson_megs"><div class="usermessage2" id="usermessage2">访问历史</div></a>
				<a  href="${ctx }/user/person_message?address=yuyue" target="preson_megs"><div class="usermessage3" id="usermessage3">预约课程</div></a>
				<a  href="${ctx }/user/person_message?address=collect" target="preson_megs"><div class="usermessage4" id="usermessage4">收藏课程</div></a>
		</div>
		<div id="buton1" class="buton1" onclick="check()">编辑</div>
		<div class="main_right">
			<iframe src="${ctx}/user/person_message?address='message'"  frameborder="0" width="100%" scrolling="no" height="100%" name="preson_megs"></iframe>
		</div>

	<script>
		$("#d1").mouseover(function(){
		  $("#d2").css("display","block");
		  $("#buton1").css("display","none");
		});
		$("#d1").mouseleave(function(){
		});
		$("#d2").mouseover(function(){
		  $("#d2").css("display","black");
		  $("#buton1").css("display","none");
		});		
		$("#d2").mouseleave(function(){
		  $("#d2").css("display","none");
		  if($("#usermessage1").attr("name")=="yes"){
		  	$("#buton1").css("display","block");
		  }else{
		  	$("#buton1").css("display","none");
		  }
		});
		$("#buton1").mouseover(function(){
		  $("#buton1").css("color","#1C86EE");
		});
		$("#buton1").mouseleave(function(){
		  $("#buton1").css("color","black");
		});
    </script>
    <script>
        var d11 = document.getElementById('d2-2-1');
        var d22 = document.getElementById('d2-2-2');
		var d33 = document.getElementById('d2-2-3');
		var d44 = document.getElementById('d2-2-4');
        d11.onmouseover = function() {
            d11.style.background = "#CDCDC1";
        }
        d11.onmouseout = function() {
            d11.style.background = "beige";
        }
        d22.onmouseover = function() {
            d22.style.background = "#CDCDC1";
        }
        d22.onmouseout = function() {
            d22.style.background = "beige";
        }
        d33.onmouseover = function() {
            d33.style.background = "#CDCDC1";
        }
        d33.onmouseout = function() {
            d33.style.background = "beige";
        }
        d44.onmouseover = function() {
            d44.style.background = "#CDCDC1";
        }
        d44.onmouseout = function() {
            d44.style.background = "beige";
        }
    </script>
    <script>
        var t1 = document.getElementById('image_change');
        var t2 = document.getElementById('image');
		var t3 = document.getElementById('image_text');
		var t4 = document.getElementById('buton1');
		var t5 = document.getElementById('usermessage1');
		var t6 = document.getElementById('usermessage2');
		var t7 = document.getElementById('usermessage3');
		var t8 = document.getElementById('usermessage4');
        t2.onmouseover = function() {
            t1.style.display = "block";
        }
        t1.onmouseout = function() {
            t1.style.display = "none";
        }
        t3.onmouseover = function() {
            t1.style.display = "block";
        }
        t3.onmouseout = function() {
            t1.style.display = "block";
        }
        t5.onclick =function(){
        	t4.style.display = "block";
        }
		t6.onclick =function(){
        	t4.style.display = "none";
        }
		t7.onclick =function(){
        	t4.style.display = "none";
        }
		t8.onclick =function(){
        	t4.style.display = "none";
        }
    </script>
	<script>
		$(function(){
		  $('.usermessage2').click(function(){
			$(".usermessage1").attr("name","no");
			$('.usermessage3').removeClass('usermessage111').addClass('usermessage5'); 
			$('.usermessage4').removeClass('usermessage111').addClass('usermessage5'); 
			$('.usermessage1').removeClass('usermessage111').addClass('usermessage5'); 
			$(this).addClass('usermessage111').removeClass('usermessage5'); 
		   }
		  );
		 });
		$(function(){
		  $('.usermessage3').click(function(){
			$(".usermessage1").attr("name","no");
			$('.usermessage1').removeClass('usermessage111').addClass('usermessage5'); 
			$('.usermessage2').removeClass('usermessage111').addClass('usermessage5'); 
			$('.usermessage4').removeClass('usermessage111').addClass('usermessage5'); 
			$(this).addClass('usermessage111').removeClass('usermessage5'); 
		   }
		  );
		 });
		$(function(){
		  $('.usermessage4').click(function(){
			$(".usermessage1").attr("name","no");
			$('.usermessage1').removeClass('usermessage111').addClass('usermessage5'); 
			$('.usermessage2').removeClass('usermessage111').addClass('usermessage5'); 
			$('.usermessage3').removeClass('usermessage111').addClass('usermessage5'); 
			$(this).addClass('usermessage111').removeClass('usermessage5'); 
		   }
		  );
		 });
		$(function(){
		  $('.usermessage1').click(function(){
			$(".usermessage1").attr("name","yes");
			$('.usermessage3').removeClass('usermessage111').addClass('usermessage5'); 
			$('.usermessage2').removeClass('usermessage111').addClass('usermessage5'); 
			$('.usermessage4').removeClass('usermessage111').addClass('usermessage5'); 
			$(this).addClass('usermessage111').removeClass('usermessage5'); 
		   }
		  );
		 });	
   </script>
     <script>
   		window.onload = function() { 
   			$(".usermessage1").attr("name","yes");
	    	$(".usermessage1").addClass('usermessage111').removeClass('usermessage5');
	    	$('.usermessage3').removeClass('usermessage111').addClass('usermessage5'); 
			$('.usermessage2').removeClass('usermessage111').addClass('usermessage5'); 
			$('.usermessage4').removeClass('usermessage111').addClass('usermessage5'); 
   			$("a")[0].click();  //默认第一个超链接被点击
   		};
  </script>
  	<script>
  		
  	
		function check(){  
			var bton=document.getElementById("buton1");//获取button按钮
				
				//获取页面高度和宽度
				var sHeight=document.documentElement.scrollHeight;
				var sWidth=document.documentElement.scrollWidth;
				
				//可是区域的高度和宽度
				var wHeight=document.documentElement.clientHeight;
				
				var oMask=document.createElement("div");
					oMask.id="mask";
					oMask.style.height=sHeight+"px";
					oMask.style.Width=sWidth+"px";
					document.body.appendChild(oMask);
				var oLogin=document.createElement("div");
					oLogin.id="messagechange";
					oLogin.innerHTML="<div id='message'>"+
					                     "<div id='close'>&times;</div>"
					                     +"<div class='change_meg'>编辑个人信息</div>"
					                     +	"<form  action='${ctx }/user/updateUserMessage' method='post'>"
					                     +		"<div class='user_name'>"
					                     +			"<div class='user_name1'>昵称：</div>"
					                     +          "<div class='user_name3'><input type='text' name='username' class='user_name2'/></div>"
					                     +      "</div>"
					                     +		"<div class='user_gender'>"
					                     +			"<div class='user_gender1'>性别：</div>"
					                     +			"<div class='user_gender2'/><input type='radio'  name='gender' value='男'/>男</div>"
					                     +          "<div class='user_gender2'/><input type='radio'  name='gender' value='女'/>女</div>"
					                     +      "</div>"
					                     +		"<div class='user_address'>"
					                     +			"<div class='user_address1'>地址：</div>"
					                     +          "<div class='user_address2'><select>"
										 +											"<option value='volvo'>省</option>"
										 +											"<option value='saab'>Saab</option>"
										 +											"<option value='opel'>Opel</option>"
										 +											"<option value='audi'>Audi</option>"
										 +										"</select>"
										 +			"</div>"
					                     +          "<div class='user_address2'><select>"
										 +											"<option value='volvo'>市</option>"
										 +											"<option value='saab'>Saab</option>"
										 +											"<option value='opel'>Opel</option>"
										 +											"<option value='audi'>Audi</option>"
										 +										"</select>"
										 +			"</div>"
					                     +          "<div class='user_address2'><select>"
										 +											"<option value='volvo'>区县</option>"
										 +											"<option value='saab'>Saab</option>"
										 +											"<option value='opel'>Opel</option>"
										 +											"<option value='audi'>Audi</option>"
										 +										"</select>"
										 +			"</div>"
					                     +      "</div>"
					                     +      "<div class='textarea'>"
					                     +			"<div class='textarea1'>个人描述：</div>"
					                     +			"<div class='textarea2'><textarea name='userDiscription' rows='5' cols='38' class='textarea3'  onchange='this.value=this.value.substring(0, 128)' onkeydown='this.value=this.value.substring(0, 128)' onkeyup='this.value=this.value.substring(0, 128)'></textarea></div>"
					                     +		"</div>"
					                     +      "<div class='button0'>"
					                     +           "<div><button  id='id'  class='button1'/>取消</div>"
					                     +           "<div><input type='submit' id='id' value='确定' class='button2'/></div>"
					                     +      "</div>"
					                     +	"</form>"
					                  +"</div>"
					document.body.appendChild(oLogin);
				//获取login的高度和宽度
				var dHeight=oLogin.offsetHeight;
				var dWidth=oLogin.offsetWidth;
				oLogin.style.left=(sWidth-dWidth)/2+"px";
				oLogin.style.top=(wHeight-dHeight)/2+"px";	
				
				var oClose=document.getElementById("close");
					oMask.onclick=oClose.onclick=function(){
						document.body.removeChild(oMask);
						document.body.removeChild(oLogin);
					}
				

			
		}
  	</script>
	</body>
</html>