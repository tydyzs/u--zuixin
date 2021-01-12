/**
 * 文件分类id，标签id,是否允许删除
//刷新图片
*/
var imgObjList={};
function fileRefresh(fileType,id,isDle){
    if(checkNull(imgObjList[id+"Obj"])){
        imgObjList[id+"Obj"]=$("#"+id);
    }
    var imgObj=imgObjList[id+"Obj"];
    imgObj.html("");
    imgObj.viewer('destroy');
    var json='{fileType:"'+fileType+'"}';
    var delStr="";
    $.ajax({
        url:Feng.ctxPath + "/myFileInfo/queryFileData",
        data:json,
        type:'POST',
        dataType:"json",
        async:false,
        //contentType:'text/json',
        contentType:'application/json',
        success:function(res){
            var data=res.data;
            for(var i=0;i<data.length;i++){
                var fileId=data[i].fileId;
                var fileIdParam="'"+data[i].fileId+"'";
                if(isDle){
                    delStr='<div style="width: 20px;height:20px;float: right;">\n' +
                        '\t<a href="javascript:void(0)" onclick="deleteFjFile(this,'+fileIdParam+')" \n' +
                        '\tstyle="width: 20px;height:20px;float: left;background:url('+Feng.ctxPath+'/assets/common/util/img/f_delete.png) no-repeat;background-size:contain;">\n' +
                        '\t</a>\n' +
                        '</div>'
                }
                var url=Feng.ctxPath + '/myFileInfo/getFile?fileId='+fileId;
                var str='<li style="width:110px;float: left;margin-right:10px;">' +
                    '<img width="90px" height=90px" src="'+url+'">' +
                    delStr+
                    '</li>';
                imgObj.append($(str));
            }

            //imgObj.viewer('update');
            var viewer=imgObj.data('viewer');
            imgObj.viewer('update');
        },
        error:function(){
            alert("服务器异常")
        }
    });
}

//删除文件
function deleteFjFile(obj,fileId){
    layer.confirm('删除后无法恢复，确认删除此文件？', function(index){
        var data={fileId:fileId}
        var json=objToStr(data);
        $.ajax({
            url:Feng.ctxPath + "/myFileInfo/delFile",
            data:json,
            type:'POST',
            contentType:'application/json',
            dataType:"json",
            success:function(res){
                if(res.state=="0"){
                    $(obj).parent().parent().remove();
                    layer.msg("删除成功！")
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