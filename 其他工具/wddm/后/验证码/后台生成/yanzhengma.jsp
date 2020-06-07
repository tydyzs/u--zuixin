<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <TITLE> ZTREE DEMO - beforeClick / onClick</TITLE>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	
	
	<script type="text/javascript" src="<%=basePath%>js/jquery-1.7.1.js"></script>

	<SCRIPT type="text/javascript">
	var hr="<%=basePath%>";
	var uuids=uuid();//用于保存后台生成的验证码的id
	
	
	$(function(){
		flushCode();
	})
	function flushCode() {
	    // 每次刷新的时候获取当前时间，防止浏览器缓存刷新失败
	    var time = new Date();
	    uuids=uuid();
	    var srcs=hr+"/user/sc_post?dm_id="+uuids+"&time=" + time;
	    document.getElementById("scode").src = srcs;
	}
	
	
	function  yanzheng(){
		var code_value=$("#code_value").val();
		$.ajax({
			url:hr+"/user/yz_post",
			data:{"code":code_value,"dm_id":uuids},
			type:"post",
			dataType:"json",
			async:false,
			success:function(result){
				//alert(result.msg);
				if(result.msg=="正确"){
					
				}else{
					flushCode();
				}
			},
			error:function(){
				}
			});			
	}
	
	function uuid() {
	    var s = [];
	    var hexDigits = "0123456789abcdef";
	    for (var i = 0; i < 36; i++) {
	        s[i] = hexDigits.substr(Math.floor(Math.random() * 0x10), 1);
	    }
	    s[14] = "4";  // bits 12-15 of the time_hi_and_version field to 0010
	    s[19] = hexDigits.substr((s[19] & 0x3) | 0x8, 1);  // bits 6-7 of the clock_seq_hi_and_reserved to 01
	    s[8] = s[13] = s[18] = s[23] = "-";
	 
	    var uuid = s.join("");
	    return uuid;
	}
	
	</SCRIPT>
	
  </head> 
  
<body>
<form action="<%=request.getContextPath() %>/user/yz_post" method="post">
    请输入验证码：<input id="code_value" type="text" name="code">
    <input type="button" onclick=" yanzheng()" value="确定">
</form>
<img alt="验证码" id="scode" src="" >
<input type="button" onclick="flushCode()" value="看不清"/>

 </body>
</html>
