var layuiForm={};
layui.use(['form','table', 'admin', 'ax', 'func','selectPlus'], function () {
    var $ = layui.$;
    var table = layui.table;
    var $ax = layui.ax;
    var admin = layui.admin;
    var func = layui.func;
    layuiForm=layui.form;

    initCity();
    //search();



    //初始化函数
    function initCity(){
        //省份下拉初始化
        var json='{dictTypeCode:"city",dictParentId:"0"}';
        province=queryDict(json);
        setDataSlelct("addressProvince",province);
        var optionStr='<option value="">全国</option>';
        var addressObj=$("#addressProvince");
        addressObj.html(optionStr+addressObj.html());

        var id=setTimeout(function(){
            layuiForm.render();
        },500);
    }

    // 操作
    table.on('tool(' + 'egFormTable' + ')', function (obj) {
        var data = obj.data;
        var layEvent = obj.event;
        var customerId=data.customerId;
        if(obj.event === 'view'){
            view(customerId);
        } else if(obj.event === 'delete'){
            deleteCustomer(customerId);
        } else if(obj.event === 'edit'){
            edit(customerId);
        }
    });
    //查看
    function view(customerId){
        func.open({
            height: 780,
            width: "65%",
            title: '查看客户',
            maxmin:true,
            content:  Feng.ctxPath + "/customer/peopleManageForm?type=view&customerId="+customerId,
            tableId: "peopleManageAdd"
        });
    }
    //删除
    function deleteCustomer(customerId){
        layer.confirm('确定删除此数据？', function(index){
            var data={customerId:customerId}
            var json=objToStr(data);
            $.ajax({
                url:Feng.ctxPath + "/customer/delCustomer",
                data:json,
                type:'POST',
                contentType:'application/json',
                dataType:"json",
                success:function(res){
                    if(res.state=="0"){
                        layer.msg("删除成功！")
                        search();
                    }else{
                        alert("删除失败！")
                    }
                },
                error:function(){
                    alert("服务器异常")
                }
            });
        });
    }
    //编辑
    function edit(customerId){
        func.open({
            height: 780,
            width: "65%",
            title: '编辑客户',
            maxmin:true,
            content:  Feng.ctxPath + "/customer/peopleManageForm?type=edit&customerId="+customerId,
            tableId: "peopleManageAdd",
            closeEnd: function(){
                //location.reload();
                search();
            }
        });
    }


    // 新增
    $('#btnAdd').click(function () {
        func.open({
            height: 780,
            width: "65%",
            title: '新增客户',
            maxmin:true,
            content:  Feng.ctxPath + "/customer/peopleManageForm?type=add",
            tableId: "peopleManageAdd",
            closeEnd: function(){
                //location.reload();
                search();
            }
        });
    });

});
//查询方法
function search(){
    var queryData = {};
    var sex = getQueryParam("SEX");
    var education = getQueryParam("education");
    var maritalStatus = getQueryParam("maritalStatus");
    var addressProvince=$("#addressProvince").val();
    var addressCity=$("#addressCity").val();
    queryData.sex=sex;
    queryData.education=education;
    queryData.maritalStatus=maritalStatus;
    queryData.addressProvince=addressProvince;
    queryData.addressCity=addressCity;
    queryData['name'] = $("#condition").val();
    var table = layui.table;
    table.reload("egFormTable",
        {
            url:Feng.ctxPath + '/customer/list',
            where: queryData
        });
}
$(function(){
    init();
});
//初始化条件字典
function init(){
    ajaxMethodDict("SEX",$('#SEX'));
    ajaxMethodDict("education",$('#education'));
    ajaxMethodDict("maritalStatus",$('#maritalStatus'));
}
//省市下钻
function provinceChange(obj){
    var id="addressCity";
    var addressProvinceValue=$("#addressProvince").val();
    if(checkNull(addressProvinceValue)){
        debugger;
        $("#"+id).html("");
        layuiForm.render('select');
    }else{
        var value=$(obj).val();
        var json='{dictParentId:"'+value+'"}';
        //setParamSlelct(id,json);
        getCityOption(id,json)
        //余外元素追加
        var optionStr='<option value="">全部</option>';
        var addressObj=$("#"+id);
        addressObj.html(optionStr+addressObj.html());

        $("#"+id).val("");
        layuiForm.render('select');
    }
    search();
}
//选择市
function addressChange(){
    search();
}
//重置条件
function reset(){
    $("#addressProvince").val("");
    $("#addressCity").val("");
    $("#addressCity").html("");
    resetQueryParam("SEX");
    resetQueryParam("education");
    resetQueryParam("maritalStatus");
    layuiForm.render('select');
    search();
}