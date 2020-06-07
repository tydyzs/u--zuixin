$(function(){
	
})
var obj={
	init:function(){
		
	},
	query:function(){
		var datas={username:"张三"};
		$.ajax({
			url:service_url+"/testssm",
			data:datas,
			type:"post",
			dataType:"json",
			success:function(result){
				alert(result.data[0].userid);
			},
			error:function(){
				alert("服务器出错")
			}
		})
	}
}