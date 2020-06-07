<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<!-- 先布局再面板 -->
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
	
	
	
		
	<link href="<%=basePath%>util/LigerUI/lib/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" />
    <script src="<%=basePath%>util/LigerUI/lib/jquery/jquery-1.9.0.min.js" type="text/javascript"></script>   
    <script src="<%=basePath%>util/LigerUI/lib/ligerUI/js/core/base.js" type="text/javascript"></script>
    <script src="<%=basePath%>util/LigerUI/lib/ligerUI/js/plugins/ligerTree.js" type="text/javascript"></script>
    <script src="<%=basePath%>util/LigerUI/lib/ligerUI/js/plugins/ligerAccordion.js" type="text/javascript"></script>
	
    <link href="<%=basePath%>util/LigerUI/lib/ligerUI/skins/Gray/css/all.css" rel="stylesheet" type="text/css" />
    <script src="<%=basePath%>util/LigerUI/lib/ligerUI/js/plugins/ligerGrid.js" type="text/javascript"></script>
    <script src="<%=basePath%>util/LigerUI/lib/ligerUI/js/plugins/ligerTab.js" type="text/javascript"></script>
    <script src="<%=basePath%>util/LigerUI/lib/ligerUI/js/plugins/ligerDrag.js" type="text/javascript"></script>
	
	
	 <link href="<%=basePath%>util/LigerUI/lib/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" />
    <script src="<%=basePath%>util/LigerUI/lib/ligerUI/js/ligerui.all.js" type="text/javascript"></script>
	
	
	
	
	
	<script type="text/javascript">
var hr="<%=basePath%>";
    //主界面初始化
    $(function(){

    $("#homepages").attr("src",hr+"jsp/test1.jsp");
    $("#navtab1").ligerTab(); 
    })
	</script>
	
  </head>
  
  <body>
 <div id="navtab1" style="width: 900px; overflow: hidden; border: 1px solid #D3D3d3;" class="liger-tab">
        <div tabid="home" title="我的主页" lselected="true" style="height: 300px">
           <div id="maingrid2" style="margin: 10px; height: 300px;">我的主页</div>
        </div> 
        <div title="我的主页3" showclose="true">
            <div id="Div1" style="margin: 10px; height: 300px;">我的主页3</div>
        </div>
        <div title="我的主页4" showclose="true">
            <div id="Div2" style="margin: 10px; height: 300px;">我的主页4</div>
        </div>
    </div>
	</body>
</html>
