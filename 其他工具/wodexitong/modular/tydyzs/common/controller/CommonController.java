package cn.stylefeng.guns.modular.tydyzs.common.controller;

import cn.stylefeng.guns.base.pojo.page.LayuiPageInfo;
import cn.stylefeng.guns.modular.common.util.Result;
import cn.stylefeng.guns.modular.tydyzs.common.entity.Dict;
import cn.stylefeng.guns.modular.tydyzs.common.service.ICommonService;
import cn.stylefeng.roses.core.base.controller.BaseController;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;


/**
 * 个人业务公共类
 */
@Controller
@RequestMapping("/myCommon")
@Validated
public class CommonController extends BaseController {

	public static String CONDITION_FIELDS = "CONDITION_FIELDS";

	private String PREFIX = "/tydyzs/common";

	@Autowired
	private ICommonService iCommonService;



	/**
	 * 列表（sql查所有）
	 * 根据条件查询字典
	 * 参数：
	 * dictId，dictCode，dictParentId，dictTypeId，dictTypeCode
	 * 字典id（110000：北京市）；字典编码（110101：北京市对应的码值），字典父亲id（110000：查北京市所有的区），字典类型id（1343857470531964930：城市），字典类型编码（city：城市）
	 */
	@ResponseBody
	@RequestMapping("/queryDict")
	public LayuiPageInfo queryDict(@RequestBody HashMap params) {
		return iCommonService.queryDict(params);
	}


}


