package cn.stylefeng.guns.modular.common.util;

import cn.stylefeng.guns.base.pojo.page.LayuiPageInfo;
import com.baomidou.mybatisplus.core.metadata.IPage;

public class ProjectCommon {
    /**
     * 创建layui能识别的分页响应参数
     *
     * @author fengshuonan
     * @Date 2019/1/25 22:14
     */
    public static Result createPageInfo(IPage page) {
        Result result = new Result();
        result.setCount(page.getTotal());
        result.setData(page.getRecords());
        return result;
    }
}
