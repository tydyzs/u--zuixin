package cn.stylefeng.guns.modular.tydyzs.common.service;

import cn.stylefeng.guns.base.pojo.page.LayuiPageInfo;
import cn.stylefeng.guns.modular.common.util.Result;
import cn.stylefeng.guns.modular.tydyzs.common.entity.Dict;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.Map;

/**
 *  服务类
 *
 * @author git
 * @since 2019-10-21
 */
public interface ICommonService extends IService<Dict> {
	public LayuiPageInfo queryDict(Map param);//sql所有查询
}
