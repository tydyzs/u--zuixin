package cn.stylefeng.guns.modular.tydyzs.common.controller;

import cn.stylefeng.guns.modular.common.util.CommonUtil;
import cn.stylefeng.guns.modular.common.util.Result;
import cn.stylefeng.guns.modular.tydyzs.common.entity.FileInfo;
import cn.stylefeng.guns.modular.tydyzs.common.service.IFileInfoService;
import cn.stylefeng.guns.sys.modular.system.model.UploadResult;
import cn.stylefeng.roses.core.base.controller.BaseController;
import cn.stylefeng.roses.kernel.model.response.ResponseData;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.URLEncoder;
import java.util.Date;
import java.util.HashMap;
import java.util.List;


/**
 * 改造后文件公共类
 */
@Controller
@RequestMapping("/myFileInfo")
@Validated
public class FileInfoController extends BaseController {

	public static String CONDITION_FIELDS = "CONDITION_FIELDS";

	private String PREFIX = "/tydyzs/common";

	@Autowired
	private IFileInfoService iService;


	/**
	 * layui上传组件 通用文件上传接口
	 *
	 * @author fengshuonan
	 * @Date 2019-2-23 10:48:29
	 */
	@RequestMapping(method = RequestMethod.POST, path = "/upload")
	@ResponseBody
	public ResponseData layuiUpload(@RequestPart("file") MultipartFile file,String fileType, HttpServletRequest request) {
		String realPath = request.getSession().getServletContext().getRealPath("/");//服务器绝对路径
		String filePath="upload/"+ CommonUtil.dateToStr(new Date(),"yyyy-MM")+"/"+CommonUtil.dateToStr(new Date(),"dd");//上传目录
		String fileSavePath=realPath+filePath;//上传路径
		String contextPath = request.getContextPath();
		UploadResult uploadResult = this.iService.uploadFile(file,fileSavePath,fileType);
		String fileId = uploadResult.getFileId();
		HashMap<String, Object> map = new HashMap<>();
		map.put("fileId", fileId);
		return ResponseData.success(0, "上传成功", map);
	}
	/**
	 * layui上传组件 图片上传接口（图片单独目录）
	 *
	 * @author fengshuonan
	 * @Date 2019-2-23 10:48:29
	 */
	@RequestMapping(method = RequestMethod.POST, path = "/layuiUploadImg")
	@ResponseBody
	public ResponseData layuiUploadImg(@RequestPart("file") MultipartFile file,String fileType, HttpServletRequest request) {
		String realPath = request.getSession().getServletContext().getRealPath("/");//服务器绝对路径
		String filePath="upload/img/"+ CommonUtil.dateToStr(new Date(),"yyyy-MM")+"/"+CommonUtil.dateToStr(new Date(),"dd")+"/";//上传目录
		String fileSavePath=realPath+filePath;//上传路径
		String contextPath = request.getContextPath();
		UploadResult uploadResult = this.iService.uploadFile(file,fileSavePath,fileType);
		String fileId = uploadResult.getFileId();
		HashMap<String, Object> map = new HashMap<>();
		map.put("fileId", fileId);
		return ResponseData.success(0, "上传成功", map);
	}
	@ResponseBody
	@RequestMapping("/queryFileData")
	public Result queryFileData(@RequestBody FileInfo fileInfo) {
		QueryWrapper<FileInfo> queryWrapper=new QueryWrapper(fileInfo);
		List data = iService.list(queryWrapper);
		Result res=new Result();
		res.setData(data);
		return res;
	}

	/**
	 * 下载文件(根据文件对象获取）
	 */
	@ResponseBody
	@RequestMapping("/getFile")
	public void getFile(String fileId, HttpServletRequest request, HttpServletResponse response) throws IOException {
		FileInfo fileInfo=new FileInfo();
		fileInfo.setFileId(fileId);
		QueryWrapper<FileInfo> queryWrapper=new QueryWrapper(fileInfo);
		FileInfo data= iService.getOne(queryWrapper);
		String filePath=data.getFilePath();
		String filename=data.getFileName();
		response.setHeader("content-disposition","attachment;filename="+ URLEncoder.encode(filename,"UTF-8"));
		InputStream in=new FileInputStream(filePath);//获取文件输入流
		int len=0;
		byte[] buffer=new byte[1024];
		ServletOutputStream out=response.getOutputStream();
		while((len=in.read(buffer))>0){
			out.write(buffer,0,len);//将缓冲区的数据输入到客户端浏览器
		}
		in.close();
	}

	/**
	 * 删除文件
	 */
	@ResponseBody
	@RequestMapping("/delFile")
	public Result delFile(@RequestBody FileInfo fileInfo) {
		QueryWrapper<FileInfo> queryWrapper=new QueryWrapper(fileInfo);
		fileInfo=iService.getOne(queryWrapper);
		String filePath=fileInfo.getFilePath();
		CommonUtil.deleteFile(filePath);
		iService.removeById(fileInfo.getFileId());
		Result result=new Result();
		result.setState("0");
		return result;
	}
}


