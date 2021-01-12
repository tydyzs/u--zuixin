var province=[];//省直辖市字典数据
layuiForm=layui.form;
var layuiUpload={};
layui.use(['form', 'admin', 'ax', 'upload', 'laydate', 'selectPlus'], function () {
    var $ = layui.jquery;
    var $ax = layui.ax;
    var admin = layui.admin;
    var upload = layui.upload;
    var laydate = layui.laydate;
    layuiUpload = layui.laydate;
    var selectPlus = layui.selectPlus;
    layuiForm=layui.form;
    init();
    //初始化函数
    function init(){
        //省份下拉初始化
        var json='{dictTypeCode:"city",dictParentId:"0"}';
        province=queryDict(json);
        setDataSlelct("householdProvince",province);
        setDataSlelct("addressProvince",province);
        //学历
        setDictSlelct("education","education");
        //婚姻状况
        setInput("maritalStatusTd","maritalStatus","maritalStatus","required")

        if(formType!="add"){//查看或编辑时先设置数据
            setFormData();
        }else{
            //新增时给市区默认值
            var json1='{dictParentId:"110000"}';
            var cityObj=queryDict(json1);
            setDataSlelct("householdCity",cityObj);
            setDataSlelct("addressCity",cityObj);
            customPhoto=getUuid();
        }
        if(formType=="view"){
            disabledForm();
        }
        if(formType=="edit"){

        }
        var id=setTimeout(function(){
            layuiForm.render();
        },500);
    }
    //layui禁用表单
    function disabledForm(){
        var formObj = layuiForm.val("egFormForm");
        for(var name in formObj){//遍历json
            //alert(i+"="+formObj[i]);
            $("#"+name).addClass("layui-disabled");
            $("#"+name).attr('disabled', 'disabled');
            //单选设置禁用
           $("input[name="+name+" ][type='radio']").attr("disabled","disabled");
            //开关
            //开关禁用
            $("#room").prop("disabled",true);
            $("#vehicle").prop("disabled",true);
            //按钮禁用：
            /*$("#picBtn").attr('disabled', 'disabled');
            $("#picBtn").addClass("layui-disabled");*/
            $("#picBtn").remove();
            $("#saveButton").remove();
        }
        layuiForm.render();
    }

    //初始化时间选择器
    laydate.render({
        elem: '#birthdate'
        ,trigger:'click'
        ,done: function(value, date, endDate){
            dateChange(value,date)
        }
    });

    //上传文件
    upload.render({
        elem: '#fileBtn'
        , url: Feng.ctxPath + '/system/upload?fileType='+customPhoto
        , accept: 'file'
        , before: function (obj) {
            obj.preview(function (index, file, result) {
                $("#fileNameTip").html(file.name);
            });
        }
        , done: function (res) {
            $("#fileInputHidden").val(res.data.fileId);
            Feng.success(res.message);
        }
        , error: function () {
            Feng.error("上传图片失败！");
        }
    });
    //普通图片上传
    upload.render({
        elem: '#picBtn'
        ,multiple:true
        , url: Feng.ctxPath + '/myFileInfo/layuiUploadImg?fileType='+customPhoto
        , before: function (obj) {
            obj.preview(function (index, file, result) {
                /*var str='<img src="'+result+'" style="margin-right:10px;" class="layui-upload-img" width="92px" height="92px">';
                $("#customPhoto").append(str);*/
            });
        }
        , done: function (res) {
            fileRefresh(customPhoto,"customPhoto",isDle);
            Feng.success(res.message);
        }
        , error: function () {
            Feng.error("上传图片失败！");
        }
    });
});
/////////////////////////////////////////////////////////静态函数区域
//保存
function saveData(){
    //校验
    layuiForm.on('submit(formDemo)', function(data){
        save(data.field);
        return false;
    });
}
//保存数据
function save(data){
    data.customerId=customerId;
    data.photo=customPhoto;
    var json=JSON.stringify(data);
    $.ajax({
        url:Feng.ctxPath + "/customer/saveData",
        data:json,
        type:'POST',
        dataType:"json",
        //contentType:'text/json',
        contentType:'application/json',
        success:function(res){
            if(res.state=="0"){
                layer.alert(res.msg,function(){
                    closeWindow();
                })
            }else{
                alert("保存失败！")
            }
        },
        error:function(){
            alert("服务器异常")
        }
    });
}
//获取表单数据
function setFormData(){
    var data={customerId:customerId};
    var json=JSON.stringify(data);
    $.ajax({
        url:Feng.ctxPath + "/customer/getCustomer",
        data:json,
        type:'POST',
        dataType:"json",
        async:false,
        contentType:'application/json',
        success:function(res){
            if(res.state=="0"){
                var data=res.data;
                layuiForm.val('egFormForm',data);
                //获取市区下拉框值
                provinceChange($("#householdProvince").eq(0),"householdCity");
                $("#householdCity").val(data.householdCity);
                provinceChange($("#addressProvince").eq(0),"addressCity");
                $("#addressCity").val(data.addressCity);
                $("#room").prop("checked", data.room=="on");
                $("#vehicle").prop("checked", data.vehicle=="on");
                layuiForm.render();
                customPhoto=data.photo;
                fileRefresh(customPhoto,"customPhoto",isDle);
                //console.log(data)
            }else{
                alert("保存失败！")
            }
        },
        error:function(){
            alert("服务器异常")
        }
    });
}

//省市下钻
function provinceChange(obj,id){
    //var id="householdCity";var id="addressCity";
    var value=$(obj).val();
    var json='{dictParentId:"'+value+'"}';
    //setParamSlelct(id,json);
    getCityOption(id,json)
    layuiForm.render('select');
}

//出生日期改变
function dateChange(value,date){
    var age=getAge(value)+"岁";
    var zodiac=getZodiac(date.year);
    var constellation=getConstellation(date.month,date.date);
    $("#customerAge").val(age);
    $("#customerZodiac").val(zodiac);
    $("#customerConstellation").val(constellation);
}




/**
 * 详情对话框
 */
var EgFormInfoDlg = {
    data: {
        title: "",
        singleTime: "",
        beginTime: "",
        endTime: "",
        multiSelect: "",
        pictureOne: "",
        number: "",
        singleSelectOne: "",
        singleSelectTwo: "",
        pictureTwo: "",
        longText: ""
    }
};

//获取星座
function getConstellation(v_month, v_day) {
    v_month = parseInt(v_month, 10)
    v_day = parseInt(v_day, 10);

    if ((v_month == 12 && v_day >= 22)
        || (v_month == 1 && v_day <= 20)) {
        return "魔羯座";
    }
    else if ((v_month == 1 && v_day >= 21)
        || (v_month == 2 && v_day <= 19)) {
        return "水瓶座";
    }
    else if ((v_month == 2 && v_day >= 20)
        || (v_month == 3 && v_day <= 20)) {
        return "双鱼座";
    }
    else if ((v_month == 3 && v_day >= 21)
        || (v_month == 4 && v_day <= 20)) {
        return "白羊座";
    }
    else if ((v_month == 4 && v_day >= 21)
        || (v_month == 5 && v_day <= 21)) {
        return "金牛座";
    }
    else if ((v_month == 5 && v_day >= 22)
        || (v_month == 6 && v_day <= 21)) {
        return "双子座";
    }
    else if ((v_month == 6 && v_day >= 22)
        || (v_month == 7 && v_day <= 22)) {
        return "巨蟹座";
    }
    else if ((v_month == 7 && v_day >= 23)
        || (v_month == 8 && v_day <= 23)) {
        return "狮子座";
    }
    else if ((v_month == 8 && v_day >= 24)
        || (v_month == 9 && v_day <= 23)) {
        return "处女座";
    }
    else if ((v_month == 9 && v_day >= 24)
        || (v_month == 10 && v_day <= 23)) {
        return "天秤座";
    }
    else if ((v_month == 10 && v_day >= 24)
        || (v_month == 11 && v_day <= 22)) {
        return "天蝎座";
    }
    else if ((v_month == 11 && v_day >= 23)
        || (v_month == 12 && v_day <= 21)) {
        return "射手座";
    }
    return "";
}

//获取生肖
function getZodiac(year) {
    var year1 = Number(year);
    year1 = year1 % 12;
    switch (year1) {
        case 1:
            return '鸡';
            break;
        case 2:
            return '狗';
            break;
        case 3:
            return '猪';
            break;
        case 4:
            return '鼠';
            break;
        case 5:
            return '牛';
            break;
        case 6:
            return '虎';
            break;
        case 7:
            return '兔';
            break;
        case 8:
            return '龙';
            break;
        case 9:
            return '蛇';
            break;
        case 10:
            return '马';
            break;
        case 11:
            return '羊';
            break;
        case 0:
            return '候';
            break;
    }
}
//获取年龄
function getAge(birthday)
{
    //出生时间 毫秒
    var birthDayTime = new Date(birthday).getTime();
    //当前时间 毫秒
    var nowTime = new Date().getTime();
    //一年毫秒数(365 * 86400000 = 31536000000)
    return Math.ceil((nowTime-birthDayTime)/31536000000);
}