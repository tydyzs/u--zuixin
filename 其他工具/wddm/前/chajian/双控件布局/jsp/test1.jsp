<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<!-- 纯面板布局 -->
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'index.jsp' starting page</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	
	
	<link rel="stylesheet" type="text/css" href="<%=basePath%>util/easyui/easyui/themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="<%=basePath%>util/easyui/easyui/themes/icon.css">
	<link rel="stylesheet" type="text/css" href="<%=basePath%>util/easyui/easyui/demo/demo.css">
	<script type="text/javascript" src="<%=basePath%>util/easyui/easyui/jquery.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>util/easyui/easyui/jquery.easyui.min.js"></script>
	
	<script type="text/javascript">
	$(function(){
	})
	</script>
	
  </head>
  
  <body>
	
	
	<!-- 面板 -->
		<div class="easyui-panel" title="测试" style="position:relative;left:0px;top:2px;width:100%;height:100%;padding:10px;"
				data-options="iconCls:'icon-save',closable:false,tools:'#tt'">
				
			<div class="easyui-panel" style="width:100%;height:50px;padding:10px;">
			  <span>
			     <a href="#" class="easyui-linkbutton">新增</a>
			     <a href="#" class="easyui-linkbutton">保存</a>
			     <a href="#" class="easyui-linkbutton">返回</a>
			  </span>
			</div>
		</div>
	
	</body>
</html>
