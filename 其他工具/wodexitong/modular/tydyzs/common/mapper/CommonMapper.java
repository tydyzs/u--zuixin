package cn.stylefeng.guns.modular.tydyzs.common.mapper;

import cn.stylefeng.guns.modular.tydyzs.common.entity.Dict;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;

import java.util.List;
import java.util.Map;


/**
 *  Mapper 接口
 *
 * @author git
 * @since 2019-10-21
 */
public interface CommonMapper extends BaseMapper<Dict> {
	List<Map> queryDict(Map param);
}
