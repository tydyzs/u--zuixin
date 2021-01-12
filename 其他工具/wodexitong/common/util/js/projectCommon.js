/**
 * 1.根据条件（json字符串）查询字典
 * 参数：
 * dictId，dictCode，dictParentId，dictTypeId，dictTypeCode
 * 字典id（110000：北京市）；字典编码（110101：北京市对应的码值），字典父亲id（110000：查北京市所有的区），字典类型id（1343857470531964930：城市），字典类型编码（city：城市）
 */
function queryDict(param){
    var listObj=[];
    $.ajax({
        url:Feng.ctxPath + "/myCommon/queryDict",
        data:param,
        type:'POST',
        dataType:"json",
        async:false,
        contentType:'application/json',
        success:function(res){
            if(res.code=="0"){
                listObj= res.data;
            }else{
                alert("查询字典失败！")
            }
        },
        error:function(){
            alert("服务器异常")
        }
    });
    return listObj;
}
/**
 * 1.1字典（获取下拉元素strlist）
 * <option value="1">layer</option>
 */
function getOption(objList,nameName,valueName){
    var str="";
    for(var i=0;i<objList.length;i++){
        var name=objList[i][nameName];
        var value=objList[i][valueName];
        str+='<option value="'+value+'">'+name+'</option>'
    }
    return str;
}

/**
 * 字典数据获取“单选”
 * @param objList
 * @param nameName
 * @param valueName
 * @returns {string|string}
 * 标签id，字典code，单选name名称，其标签他属性
 */
function setInput(id,dictTypeCode,name,param){
    var json='{dictTypeCode:"'+dictTypeCode+'"}';
    var objList=queryDict(json);
    var str="";
    for(var i=0;i<objList.length;i++){
        var nameStr=objList[i].DICT_NAME;
        var value=objList[i].DICT_CODE;
        if(i==0){
            str+='<input type="radio"  checked="checked" '+param+' lay-verify="required"  name="'+name+'" value="'+value+'" title="'+nameStr+'"/>'
        }else{
            str+='<input type="radio"  '+param+' lay-verify="required"  name="'+name+'" value="'+value+'" title="'+nameStr+'"/>'
        }
    }
    $("#"+id).html(str);
}
/**
 * 1.1.1字典（获取下拉元素strlist）
 * <option value="1">layer</option>
 * 省瞎市区特殊处理
 * 429000 469000 659000
 */
function getCityOption(id,json){
    var checkList=['429000','469000','659000'];
    var objList=queryDict(json);
    var nameName="DICT_NAME";
    var valueName="DICT_CODE";
    var str="";
    for(var i=0;i<objList.length;i++){
        var name=objList[i][nameName];
        var value=objList[i][valueName];
        var json='{dictParentId:"'+value+'"}';
        if(checkList.indexOf(value)==-1){
            str+='<option value="'+value+'">'+name+'</option>'
        }else{
            var checkObj=queryDict(json);
            for(var j=0;j<checkObj.length;j++){
                var name1=checkObj[j][nameName];
                var value1=checkObj[j][valueName];
                str+='<option value="'+value1+'">'+name1+'</option>'
            }
        }
    }
    $("#"+id).html(str);
}
/**
 * 1.2根据select标签id，字典数据（listObj)，直接初始化字典标签
 */
function setDataSlelct(id,listObj){
    var str=getOption(listObj,"DICT_NAME","DICT_CODE");
    $("#"+id).html(str);
}
/**
 * 1.3根据select标签id，字典查询条件param(json字符串），直接初始化字典标签
 */
function setParamSlelct(id,json){
    var listObj=queryDict(json);
    setDataSlelct(id,listObj);
}
/**
 * 1.4根据标签id，字典类型，初始化select
 */
function setDictSlelct(id,dictTypeCode){
    var json='{dictTypeCode:"'+dictTypeCode+'"}';
    var data=queryDict(json);
    setDataSlelct(id,data);
}
//2.关闭窗口
function closeWindow(state){
    var index=parent.layer.getFrameIndex(window.name); //获取当前窗口的name
    parent.layer.close(index);
}

/////////////////////////////////////条件相关函数/////////////////////////////////////////////
//4.获取字典并生成条件
function ajaxMethodDict(parameter,obj){
    var json='{dictTypeCode:"'+parameter+'"}';
    var data=queryDict(json);
    for(var i=0;i<data.length;i++){
        obj.append('<dd class="left mr20" value="'+ data[i].DICT_CODE +'">'+ data[i].DICT_NAME +'</dd>');
    };
    initSearch(obj);
}
//条件事件,ajaxMethodDict函数中被调用
function initSearch(obj){
    obj.find("dd").click(function () {
        $(this).addClass('active').siblings().removeClass('active');
        search();
    });
}
//获取条件值：
function getQueryParam(id){
    return jQuery("#"+id+" dd[class*='active']").first().attr('value');
}
//重置条件值：
function resetQueryParam(id){
    $("#"+id).children().eq(0).addClass('active').siblings().removeClass('active');
}
/////////////////////////////////////////////////////////////////////////////////////////////////////////


