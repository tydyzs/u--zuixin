<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>

<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>shc</title>
<script src="<%=basePath%>js/jquery-1.7.1.js" type="text/javascript"></script>
<script type="text/javascript">
			var hr="<%=basePath%>";
			var home=hr+"mp4/aiqiu.mp3"
			function aa(){
				$("#aa").attr("src",home)
			}
			function bb(){
				$("#aa").pause();return
				$("#aa").attr("src","")
			}
			function cc(){
				$("#aa").play();
			}
				
			
</script>


</head>


<body>
音乐
   <EMBED style="display:none" id="aaa" src="" width=300 height=45 type=audio/mpeg loop="-1" autostart="false" volume="0">
   </EMBED>
   
   <audio src="" id="aa">你的浏览器不支持audio标签</audio>
   
   <input type="button" onclick="aa()" value="播放"/>
   <input type="button" onclick="bb()" value="停止"/>
   <input type="button" onclick="cc()" value="继续"/>
</body>
</html>