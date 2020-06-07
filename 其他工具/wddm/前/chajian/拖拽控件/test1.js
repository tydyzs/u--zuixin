

$(function(){
	dragsort()
})



/**
 * 初始化业务拖拉控件
 */
function dragsort(){
	$(".div2").dragsort({
		dragSelector: "span",
		dragBetween: true,
		dragEnd: saveOrder,
		placeHolderTemplate: "<li><span></span></li>" });
	$(".list2").dragsort({
		dragSelector: "div",
		dragBetween: true,
		dragEnd: saveOrder,
		placeHolderTemplate: "<li class='placeHolder'><div></div></li>" 
	});
	function saveOrder(){
		/**
		 * 拖拽后回调函数
		 * TODO 修改拖拉后的公式,看是否需要重构,原理获取ul下的li,然后重新赋值给text
		 ***/
	}
}

