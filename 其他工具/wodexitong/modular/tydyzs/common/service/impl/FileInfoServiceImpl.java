package cn.stylefeng.guns.modular.tydyzs.common.service.impl;

import cn.hutool.core.io.FileUtil;
import cn.stylefeng.guns.modular.common.util.CommonUtil;
import cn.stylefeng.guns.modular.tydyzs.common.entity.FileInfo;
import cn.stylefeng.guns.modular.tydyzs.common.mapper.IFileInfoMapper;
import cn.stylefeng.guns.modular.tydyzs.common.service.IFileInfoService;
import cn.stylefeng.guns.sys.core.exception.enums.BizExceptionEnum;
import cn.stylefeng.guns.sys.modular.system.model.UploadResult;
import cn.stylefeng.roses.core.util.ToolUtil;
import cn.stylefeng.roses.kernel.model.exception.ServiceException;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.IdWorker;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import java.io.File;
import java.math.BigDecimal;
import java.util.List;
import java.util.Map;


/**
 * 服务实现类
 *
 * @author git
 * @since 2019-10-21
 */
@Slf4j
@Service
public class FileInfoServiceImpl extends ServiceImpl<IFileInfoMapper, FileInfo> implements IFileInfoService {

    /**
     * 上传文件（指定上传路径）
     *
     * @author fengshuonan
     * @Date 2019-05-04 17:18
     */
    public UploadResult uploadFile(MultipartFile file, String fileSavePath,String fileType) {

        UploadResult uploadResult = new UploadResult();

        //生成文件的唯一id
        String fileId = IdWorker.getIdStr();
        uploadResult.setFileId(fileId);

        //获取文件后缀
        String fileSuffix = ToolUtil.getFileSuffix(file.getOriginalFilename());
        uploadResult.setFileSuffix(fileSuffix);

        //获取文件原始名称
        String originalFilename = file.getOriginalFilename();
        uploadResult.setOriginalFilename(originalFilename);

        //生成文件的最终名称
        String finalName = fileId + "." + ToolUtil.getFileSuffix(originalFilename);
        uploadResult.setFinalName(finalName);
        uploadResult.setFileSavePath(fileSavePath + finalName);

        try {
            //保存文件到指定目录
            File newFile = new File(fileSavePath + finalName);

            //创建父目录
            FileUtil.mkParentDirs(newFile);

            //保存文件
            file.transferTo(newFile);

            //保存文件信息
            FileInfo fileInfo = new FileInfo();
            fileInfo.setFileId(fileId);
            fileInfo.setFileName(originalFilename);
            fileInfo.setFileSuffix(fileSuffix);
            fileInfo.setFilePath(fileSavePath + finalName);
            fileInfo.setFinalName(finalName);
            fileInfo.setFileType(fileType);
            //计算文件大小kb
            long kb = new BigDecimal(file.getSize())
                    .divide(BigDecimal.valueOf(1024))
                    .setScale(0, BigDecimal.ROUND_HALF_UP).longValue();
            fileInfo.setFileSizeKb(kb);
            this.save(fileInfo);
        } catch (Exception e) {
            log.error("上传文件错误！", e);
            throw new ServiceException(BizExceptionEnum.UPLOAD_ERROR);
        }

        return uploadResult;
    }

    /**
     * 根据文件的最终命名获取文件信息
     *
     * @author fengshuonan
     * @Date 2020/1/1 16:48
     */
    public FileInfo getByFinalName(String finalName) {

        QueryWrapper<FileInfo> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("final_name", finalName);

        return this.getOne(queryWrapper);
    }


    /**
     * 根据文件类型删除文件
     * @param fileType
     */
    public void delFileType(String fileType){
        //删除照片文件
        FileInfo fileInfo=new FileInfo();
        fileInfo.setFileType(fileType);
        QueryWrapper<FileInfo> queryWrapper=new QueryWrapper(fileInfo);//customer为实体类
        List<FileInfo> fileData=baseMapper.selectList(queryWrapper);
        for(FileInfo f:fileData){
            String filePath=f.getFilePath();
            baseMapper.deleteById(f.getFileId());
            CommonUtil.deleteFile(filePath);
        }
    }

}
