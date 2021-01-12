package cn.stylefeng.guns.modular.tydyzs.common.mapper;

import cn.stylefeng.guns.modular.tydyzs.common.entity.FileInfo;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;

import java.util.List;
import java.util.Map;


/**
 *  Mapper 接口
 *
 * @author git
 * @since 2019-10-21
 */
public interface IFileInfoMapper extends BaseMapper<FileInfo> {
	List<Map> queryFileInfo(FileInfo param);
}
