package cn.stylefeng.guns.modular.tydyzs.common.service.impl;

import cn.stylefeng.guns.base.pojo.page.LayuiPageInfo;
import cn.stylefeng.guns.modular.tydyzs.common.entity.Dict;
import cn.stylefeng.guns.modular.tydyzs.common.mapper.CommonMapper;
import cn.stylefeng.guns.modular.tydyzs.common.service.ICommonService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;


/**
 * 服务实现类
 *
 * @author git
 * @since 2019-10-21
 */
@Service
public class CommonServiceImpl extends ServiceImpl<CommonMapper, Dict> implements ICommonService {
    /**
     * 查所有字典（sql方式)
     * @param param
     * @return
     */
    public LayuiPageInfo queryDict(Map param){
        //2.开始查询
        List<Map> data = baseMapper.queryDict(param);
        LayuiPageInfo result=new LayuiPageInfo();
        result.setData(data);
        return result;
    }

}
