package cn.stylefeng.guns.modular.tydyzs.intermediary.marriage.controller;

import cn.stylefeng.guns.base.pojo.page.LayuiPageInfo;
import cn.stylefeng.guns.modular.common.util.CommonUtil;
import cn.stylefeng.guns.modular.common.util.Result;
import cn.stylefeng.guns.modular.tydyzs.common.entity.FileInfo;
import cn.stylefeng.guns.modular.tydyzs.common.service.IFileInfoService;
import cn.stylefeng.guns.modular.tydyzs.common.service.impl.FileInfoServiceImpl;
import cn.stylefeng.guns.modular.tydyzs.intermediary.marriage.entity.CustomerManage;
import cn.stylefeng.guns.modular.tydyzs.intermediary.marriage.service.ICustomerManageService;
import cn.stylefeng.roses.core.base.controller.BaseController;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;


/**
 * 客户管理
 */
@Controller
@RequestMapping("/customer")
@Validated
public class CustomerManageController extends BaseController {

	public static String CONDITION_FIELDS = "CONDITION_FIELDS";

	private String PREFIX = "/tydyzs/intermediary/marriage";

	@Autowired
	private ICustomerManageService iCustomerManageService;
	@Autowired
	private IFileInfoService iFileInfoService;

	/**
	 * 跳转到主页面
	 *
	 * @author stylefeng
	 * @Date 2019-06-15
	 */
	@RequestMapping("")
	public String index() {
		return PREFIX + "/peopleManage.html";
	}

	/**
	 * 表单页面
	 */
	@RequestMapping("/peopleManageForm")
	public String form(String type) {
		return PREFIX + "/peopleManageForm.html";
	}
	/**
	 * sql分页列表
	 */
	@ResponseBody
	@RequestMapping("/list")
	public LayuiPageInfo list(@RequestParam Map<String, String> params) {
		LayuiPageInfo data=iCustomerManageService.queryCustomer(params);
		return data;
	}
	@ResponseBody
	@RequestMapping("/listMy")
	public Result listMy(@RequestParam Map<String, String> params) {
		Result data=iCustomerManageService.queryCustomerMy(params);
		return data;
	}
	/**
	 * sql列表（所有）
	 */
	@ResponseBody
	@RequestMapping("/listAll")
	public LayuiPageInfo listAll(@RequestParam Map<String, String> params) {
		return iCustomerManageService.queryCustomerAll(params);
	}
	/**
	 * 列表（单表实体分页）
	 */
	@ResponseBody
	@RequestMapping("/queryCustomerEnt")
	public LayuiPageInfo queryCustomerEnt(@RequestParam Map<String, String> params) {
		return iCustomerManageService.queryCustomerEnt(params);
	}
	/**
	 * 列表（单表实体所有）
	 */
	@ResponseBody
	@RequestMapping("/queryCustomerEntAll")
	public LayuiPageInfo queryCustomerEntAll(@RequestParam Map<String, String> params) {
		return iCustomerManageService.queryCustomerEntAll(params);
	}
	/**
	 * 查实体
	 */
	@ResponseBody
	@RequestMapping("/getCustomer")
	public Result getCustomer(@RequestBody CustomerManage customer) {
		//实体类方式
		//1.查询条件
		QueryWrapper<CustomerManage> qw=new QueryWrapper(customer);
		CustomerManage customerManage = iCustomerManageService.getOne(qw);
		Result result=new Result();
		result.setState("0");
		result.setData(customerManage);
		return result;
	}
	/**
	 * 删除客户
	 */
	@ResponseBody
	@RequestMapping("/delCustomer")
	public Result delCustomer(@RequestBody CustomerManage customer) {
		CustomerManage data=iCustomerManageService.getById(customer.getCustomerId());
		String fileType=data.getPhoto();
		customer.setIsDelete("0");
		iCustomerManageService.saveOrUpdate(customer);
		iFileInfoService.delFileType(fileType);//删除文件数据和文件
		Result result=new Result();
		result.setState("0");
		return result;
	}

	/**
	 * 保存数据
	 *
	 * @author stylefeng
	 * @Date 2019-02-18
	 */
	@RequestMapping(value="/saveData",method = RequestMethod.POST)
	@ResponseBody
	public Result saveData(@RequestBody CustomerManage customer) {
		return iCustomerManageService.saveCustomer(customer);
	}

}


