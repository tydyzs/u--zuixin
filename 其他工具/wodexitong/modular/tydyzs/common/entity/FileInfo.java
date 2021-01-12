package cn.stylefeng.guns.modular.tydyzs.common.entity;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
 * <p>
 * 文件信息表
 * </p>
 *
 * @author stylefeng
 * @since 2019-05-04
 */
@Data
@TableName("sys_file_info")
public class FileInfo implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 主键id
     */
    @TableId(value = "file_id", type = IdType.ID_WORKER)
    private String fileId;

    /**
     * 文件仓库（oss仓库）
     */
    @TableField("file_bucket")
    private String fileBucket;
    /**
     * 文件分类
     */
    @TableField("file_type")
    private String fileType;

    /**
     * 文件名称
     */
    @TableField("file_name")
    private String fileName;

    /**
     * 文件后缀
     */
    @TableField("file_suffix")
    private String fileSuffix;

    /**
     * 文件大小kb
     */
    @TableField("file_size_kb")
    private Long fileSizeKb;

    /**
     * 文件唯一标识id
     */
    @TableField("final_name")
    private String finalName;

    /**
     * 存储路径
     */
    @TableField("file_path")
    private String filePath;

    /**
     * 创建时间
     */
    @TableField(value = "create_time", fill = FieldFill.INSERT)
    private Date createTime;

    /**
     * 修改时间
     */
    @TableField(value = "update_time", fill = FieldFill.UPDATE)
    private Date updateTime;

    /**
     * 创建用户
     */
    @TableField(value = "create_user", fill = FieldFill.INSERT)
    private Long createUser;

    /**
     * 修改用户
     */
    @TableField(value = "update_user", fill = FieldFill.UPDATE)
    private Long updateUser;



    @Override
    public String toString() {
        return "FileInfo{" +
        "fileId=" + fileId +
        ", fileBucket=" + fileBucket +
        ", fileName=" + fileName +
        ", fileSuffix=" + fileSuffix +
        ", fileSizeKb=" + fileSizeKb +
        ", finalName=" + finalName +
        ", filePath=" + filePath +
        ", createTime=" + createTime +
        ", updateTime=" + updateTime +
        ", createUser=" + createUser +
        ", updateUser=" + updateUser +
        "}";
    }
}
