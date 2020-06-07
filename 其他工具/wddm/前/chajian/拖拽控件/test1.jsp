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
<link rel="stylesheet" href="../css/test1.css" type="text/css">
<script type="text/javascript" src="../js/jquery-1.7.1.js"></script>
<script type="text/javascript" src="../js/dragsort/jquery.dragsort-0.5.2.min.js"></script>
<script type="text/javascript" src="../js/test/test1.js"></script>
<script type="text/javascript">
			var hr="<%=basePath%>";
</script>

</head>


<body>
		<ul class="list2" id="expUl" style="width:99%;height: 150px;border: 1px solid #0099cc;" >
		<li>用于存放li</li>
		</ul>
	<ul class="list2">
		<li><div>10</div></li>
		<li><div>11</div></li>
		<li><div>12</div></li>
		<li><div>13</div></li>
		<li><div>14</div></li>
		<li><div>15</div></li>
		<li><div>16</div></li>
		<li><div>17</div></li>
		<li><div>18</div></li>
	</ul>
	
	
    <!-- 别拖拉的三个块 -->
	<ul id="div2" class="div2" style="width:150px;height: 150px;border: 1px solid #0099cc;" >
	div2
	   <li><span  class="drag " style="width: 20px;" title="+"  lang="el" name="other">[＋]</span></li>
	   <li><span  class="drag " style="width: 20px;" title="-" lang="el" name="other">[－]</span></li>
	</ul>
	 <ul class="div2" style="width:150px;height: 150px;border: 1px solid #0099cc;" >
	 用于存放div2
	</ul> 
	
	
	
</body>
</html>