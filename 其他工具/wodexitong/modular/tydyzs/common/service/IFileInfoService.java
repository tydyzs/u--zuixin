package cn.stylefeng.guns.modular.tydyzs.common.service;

import cn.stylefeng.guns.modular.tydyzs.common.entity.FileInfo;
import cn.stylefeng.guns.sys.modular.system.model.UploadResult;
import com.baomidou.mybatisplus.extension.service.IService;
import org.springframework.web.multipart.MultipartFile;

import java.util.Map;

/**
 *  服务类
 *
 * @author git
 * @since 2019-10-21
 */
public interface IFileInfoService extends IService<FileInfo> {
	public UploadResult uploadFile(MultipartFile file, String fileSavePath,String fileType);//上传文件公共类
	public void delFileType(String fileType);//根据文件类型删除文件
}
