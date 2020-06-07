

//生成uuid
function uuid(len, radix) {
    var chars = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'.split('');
    var uuid = [], i;
    radix = radix || chars.length;
 
    if (len) {
      // Compact form
      for (i = 0; i < len; i++) uuid[i] = chars[0 | Math.random()*radix];
    } else {
      // rfc4122, version 4 form
      var r;
 
      // rfc4122 requires these characters
      uuid[8] = uuid[13] = uuid[18] = uuid[23] = '-';
      uuid[14] = '4';
 
      // Fill in random data.  At i==19 set the high bits of clock sequence as
      // per rfc4122, sec. 4.1.5
      for (i = 0; i < 36; i++) {
        if (!uuid[i]) {
          r = 0 | Math.random()*16;
          uuid[i] = chars[(i == 19) ? (r & 0x3) | 0x8 : r];
        }
      }
    }
 
    return uuid.join('');
}


var uuid_pulic="";

RwpcFile2 = {
		index : 0,
		fileList : [],
		maxFileNum : 5,
		getFileList : function() {
			if(RwpcFile2.fileList.length == 0) {
				return "";
			}
			return mini.encode(RwpcFile2.fileList);
		},
		//上传成功后
		onUploadFileSuccess : function(e){
	 		mini.unmask(document.body);
	 		this.setText("");
	        this.setValue("");
	 		var data = mini.decode(e.serverData);
	 		var msg = mini.decode(decodeURIComponent(data.msg));
	 		if(msg.resMsg){
	 			alert(msg.resMsg);
	 		}else{
	 			//alert("附件上传成功。");
	 			msg.fjmc = e.file.name;
	 			msg.fjdx = e.file.size/1024/1024;
	 			msg.opt = "ADD";
	 			RwpcFile2.addFileViewList(msg);
	 		}
	 	},
	 	getAvailableFileSize : $.noop,
	 	checkFileSelect : function() {
	 		var drFile = mini.get("drFile2");
	 		//检查文件个数和文件名冲突
	 		var fnum = 0;
	 		for(var i = 0; i < RwpcFile2.fileList.length; i++) {
	 			if(RwpcFile2.fileList[i].opt=="DEL") {
	 				//文件已删除，忽略校验
	 				continue;
	 			}
	 			fnum++;
	 			//检测文件名冲突
	 			if(drFile.getValue() == RwpcFile2.fileList[i].fjmc) {
	 				alert("已存在\"" + RwpcFile2.fileList[i].fjmc +"\"的文件。");
	 				return false;
	 			}
	 			// 转化为字符串进行比较
	 			var fileSize = RwpcFile2.getAvailableFileSize();
	 			if ($.type(fileSize) === "undefined") {
	 				fileSize = fnum;
	 			}
	 			//检测个数
	 			if(fileSize >= RwpcFile2.maxFileNum) {
	 				alert("上传文件已达到" + RwpcFile2.maxFileNum + "个。");
	 				return false;
	 			}
	 		}

	 		return true;
	 	},
	 	//执行上传
	 	startUploadFile : function(){
	 		uuid_pulic=uuid(16,36);
	 		var drFile = mini.get("drFile2");
	        drFile.validate();
	        if(!drFile.isValid() || drFile.value == ""){
	        	alert("请选择需要上传的文件。");
	            return;
	        }
	        //检查
	        if(!RwpcFile2.checkFileSelect()) {
	        	return ;
	        }

			var params = {
					impType : "saveData",
					needUnZip : false,
					parseFileClassName : "cn.com.servyou.gddsfxgl.fxgl.mxxq.ExcelUploadLogicHandler",
					handleClassName : "cn.com.servyou.gddsfxgl.fxgl.mxxq.ExcelUploadLogicHandler",
					impParamStr:uuid_pulic,
					impTaskName:"save_enclosure",
					modelPath:mini.get("add_user_id").getValue()
					
			};
			drFile.setPostParam( {
				impparam : mini.encode(params),
				jspPath : _ctx+"/components/fileio/import/form_import1.jsp"
			});
			drFile.startUpload();// 开始上传文件
			mini.mask( {
				el		: document.body,
				html	: "正在上传，请稍候...",
				cls		: "mini-mask-loading"
			});
	 	},
	 	//添加文件显示列表
	 	addFileViewList : function(data, optType, divId) {
	 		if(!divId) {
	 			divId = "fjDiv";
	 		}
	 		data._rowid = RwpcFile2.index++;
	 		RwpcFile2.fileList.push(data);
	 		var fjdz = data.filePath;
	 		var file_paths=data.filepaths;
	 		if(data.rwpcfjBh) {//原附件，直接查看
	 			fjdz = _ctx+"/YdglFjUploadServlet?type=download&daoTaskName=fxyd_rwpcfjzl_getfjnr&params="+data.rwpcfjBh;
	 		}
	 		if(data.jhfjbh){
	 			fjdz = _ctx+"/YdglFjUploadServlet?type=download&daoTaskName=fxgl_fxjh_fj_getfjnr&params="+data.jhfjbh;
	 		}
	 		var fjHtml = "";
	 		var the_xh = data._rowid +1;
	 		if(data.jhfjbh){
	 			fjHtml = fjHtml.concat('<span style="float:left" id="file_', data._rowid ,'"><a href="javascript:;" onclick="RwpcFile2.downloadFj(\'' , fjdz , '\')" class="list_operatelink fkbgtn_remove" >', the_xh+'.'+data.fjmc, '</a>&nbsp;');
	 		}else{
	 			fjHtml = fjHtml.concat('<span style="float:left" id="file_', data._rowid ,'"><a href="javascript:;" onclick="RwpcFile2.downloadFj(\'' , fjdz , '\')" class="list_operatelink fkbgtn_remove">', data.fjmc, '</a>&nbsp;');
	 		}
	 		if(optType != "VIEW") {
	 		/*	fjHtml = fjHtml.concat('<a href="javascript:RwpcFile2.delFile(\'',
	 					data._rowid, '\')" class="list_operatelink" >',
	 			'<img width="16" height="16" src="/fxgl/images/common/delete2.png" complete="complete"/></a>');*/
	 			
	 			fjHtml = fjHtml.concat('<a onclick="RwpcFile2.delFile(this)" class="list_operatelink" >',
	 			'<img width="16" height="16" src="'+_ctx+'/fxgl/images/common/delete2.png" complete="complete"/></a>');
	 		}
	 		fjHtml = fjHtml.concat('&nbsp;&nbsp;</span>');
	 		jQuery("#" + divId).append(fjHtml);
	 		mini.layout();
	 	},

		downloadFj : function(path){
			
		//访问之前先将数据库的文件覆盖到服务端（防止服务端被删除，无法访问）	--/components/fileio/impfile/152600612929529196441/风险模型需求模板.xlsx
		    //var fileids=path.substring(path.indexOf("impfile/")+8,path.lastIndexOf("/"));
			//update_file(fileids);
		    
			var ie = !-[1,];//利用了IE与标准浏览器在处理数组的toString方法的差异判断当前是否为IE
			if(ie){
				//IE要借新窗口打开，不然会报js错误，新窗口尽量小而且居中，这样可以被下载弹出框挡住。
				var iWidth=390;                          //弹出窗口的宽度;
				var iHeight=220;                         //弹出窗口的高度;
				//获得窗口的垂直位置
				var iTop = (window.screen.availHeight - 30 - iHeight) / 2;
				//获得窗口的水平位置
				var iLeft = (window.screen.availWidth - 10 - iWidth) / 2;
				window.open(path, "", 'height=' + iHeight + ',,innerHeight=' + iHeight + ',width=' + iWidth + ',innerWidth=' + iWidth + ',top=' + iTop + ',left=' + iLeft + ',status=no,toolbar=no,menubar=no,location=no,resizable=no,scrollbars=0,titlebar=no');
			}else{
				window.location.href = path;
			}
		},
	 	//界面删除
	 	delFile : function(obj) {
	 		$(obj).parent().remove();
	 	},
	 	loadFileDataList : function(url, param, optType) {
	 		jQuery.ajax({
	 			url : url,
	 			data : param,
	 			type : "get",
	 			dataType: "json",
	 			success : function(res) {
                    var ret = {};//ie8兼容性视图下，ajax方法未加载到base.js里的，原因不明，原生ajax返回的是个object，此处兼容处理
                    if(typeof res == "string"){
    	 				ret = mini.decode(res);
                    }else{
                        ret = res;
                    }
	 				if(ret && ret.length > 0) {
	 					for(var i = 0; i < ret.length; i++) {
	 						RwpcFile2.addFileViewList(ret[i], optType);
	 					}
	 				}
	 			}
	 		});
	 	},
	 	//风险计划界面加载，初始化附件列表
	 	initFxjhFileList : function(jhbh) {
			jhbh = jhbh || "-1";//防止为空时查出所有记录
	 		var url = "initRwpcFileList_noLogin.json?logic-name=fxgl_fxjh_fj_query";
	 		var param = {jhbh : jhbh};
	 		RwpcFile2.loadFileDataList(url, param);
	 	},
	 	//风险计划查看界面加载，初始化附件列表
	 	initFxjhAllFileList : function(jhbh) {
			jhbh = jhbh || "-1";//防止为空时查出所有记录
	 		var url = "initRwpcFileList_noLogin.json?logic-name=fxgl_fxjh_fj_query";
	 		var param = {jhbh:jhbh};
	 		RwpcFile2.loadFileDataList(url, param, "VIEW");
	 	},

	 	//任务批次编辑界面(人工调整)界面加载，初始化附件列表
	 	initFileList : function(rwpcBh) {
			rwpcBh = rwpcBh || "-1";//防止为空时查出所有记录
	 		var url = "initRwpcFileList_noLogin.json?logic-name=ydgl_rwdy_fjzl_query";
	 		var param = {rwpc_bh : rwpcBh};
	 		RwpcFile2.loadFileDataList(url, param);
	 	},
	 	//任务批次查看界面加载，初始化附件列表
	 	initRwpcAllFileList : function(rwpcBh) {
			rwpcBh = rwpcBh || "-1";//防止为空时查出所有记录
	 		var url = "initRwpcFileList_noLogin.json?logic-name=ydgl_rwdy_fjzl_query";
	 		var param = {rwpcBhAll : rwpcBh};
	 		RwpcFile2.loadFileDataList(url, param, "VIEW");
	 	},
	 	//任务明细查看，初始化附件列表
	 	initFxxxAllFileList : function(fxxxBh) {
			fxxxBh = fxxxBh || "-1";//防止为空时查出所有记录
	 		var url = "initRwpcFileList_noLogin.json?logic-name=ydgl_rwdy_fjzl_query";
	 		var param = {fxxxBhAll : fxxxBh};
	 		RwpcFile2.loadFileDataList(url, param, "VIEW");
	 	},
	 	loadSjFileDataList : function(url, param) {
	 		jQuery.ajax({
	 			url : url,
	 			data : param,
	 			type : "get",
	 			dataType: "json",
	 			success : function(res) {
	 				var ret = mini.decode(res);
	 				if(ret && ret.length > 0) {
	 					jQuery("#sjfjDiv").html("");
	 					for(var i = 0; i < ret.length; i++) {
	 						RwpcFile2.addFileViewList(ret[i], "VIEW", "sjfjDiv");
	 					}
	 				}else {
	 					jQuery("#sjfjDiv").html("无上级指引");
	 				}
	 			}
	 		});
	 	},
	 	//待定义上级任务附件列表
	 	initAllDdyParentFileList : function(param) {
	 		var qcond = mini.clone(param);
	 		qcond.sfgb = "N";
	 		qcond.pageSize = "-1";
	 		var url = "initRwpcFileList_noLogin.json?logic-name=ydgl_rwdy_czcx_fjzl";
	 		RwpcFile2.loadSjFileDataList(url, qcond);
	 		mini.get("sjfj_window").show();
	 	},
	 	//人工调整上级任务附件列表
	 	initRgtzDdyParentFileList : function(rwpcBh) {
	 		var url = "initRwpcFileList_noLogin.json?logic-name=ydgl_rwdy_fjzl_query";
	 		var param = {
	 				rwpcBhAll : rwpcBh,
	 				noRwpcBh : rwpcBh
	 		};
	 		RwpcFile2.loadSjFileDataList(url, param);
	 		mini.get("sjfj_window").show();
	 	},
	 	//多次筛选,待定义上级任务附件列表
	 	initSxDdyParentFileList : function(rwpcBhs) {
	 		if(rwpcBhs == null) {
	 			jQuery("#sjfjDiv").html("无上级指引");
	 		} else {
	 			var url = "initRwpcFileList_noLogin.json?logic-name=ydgl_rwdy_fjzl_query";
	 			var bhs = "";
	 			var index = 0;
	 			for(var n in rwpcBhs) {
	 				if(typeof(rwpcBhs[n])=='function')
	 	                continue;

	 				if(index == 0) {
	 					bhs += n;
	 				} else {
	 					bhs += "','" + n;
	 				}
	 				index++;
	 			}
	 			var param = {
	 					rwpcBhAll : bhs
	 			};
	 			RwpcFile2.loadSjFileDataList(url, param);
	 		}
	 		mini.get("sjfj_window").show();
	 	},

		// 单户分析 风险信息页面对应批次附件列表
		initDhfxFileList : function(fxxx_bh) {
			fxxx_bh = fxxx_bh || "-1"; //防止为空时查出所有记录
			var url = "initRwpcFileList_noLogin.json?logic-name=ydgl_rwdy_fjzl_query";
			var param = {
				fxxxBhHGBAll : fxxx_bh
			};
			jQuery.ajax({
				url : url,
				data : param,
				type : "get",
				dataType: "json",
				success : function(res) {
					var ret = mini.decode(res);
					if(ret && ret.length > 0) {
						jQuery("#rwzyDiv").html("");
						for(var i = 0; i < ret.length; i++) {
							RwpcFile2.addFileViewList(ret[i], "VIEW", "rwzyDiv");
						}
					}
				}
			});
			mini.get("rwzy_window").show();	
		},

		//任务明细查看，初始化附件列表含归并
		initFxxxAllHGBFileList : function(fxxxBh) {
			fxxxBh = fxxxBh || "-1";//防止为空时查出所有记录
			var url = "initRwpcFileList_noLogin.json?logic-name=ydgl_rwdy_fjzl_query";
			var param = {fxxxBhHGBAll : fxxxBh};
			RwpcFile2.loadFileDataList(url, param, "VIEW");
		}
};



function update_file(fileids){
	//alert(fileids)
	jQuery.ajax({
		url : "update_file.json?logic-name=mxxq_util&type=update_file&file_id="+fileids,
		dataType : "json",
		showMask : true,
		async:false,
		success : function(data) {
		}
	});
}



function del_file(){//保存成功后对上传的没用的文件删除扫做
	//alert(fileids)
	jQuery.ajax({
		url : "del_file.json?logic-name=mxxq_util&type=del_file&user_id="+mini.get("add_user_id").getValue(),
		dataType : "json",
		showMask : true,
		async:false,
		success : function(data) {
		}
	});
}