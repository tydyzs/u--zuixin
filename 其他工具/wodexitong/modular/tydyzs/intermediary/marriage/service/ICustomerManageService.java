package cn.stylefeng.guns.modular.tydyzs.intermediary.marriage.service;

import cn.hutool.db.Page;
import cn.stylefeng.guns.base.pojo.page.LayuiPageInfo;
import cn.stylefeng.guns.modular.common.util.Result;
import cn.stylefeng.guns.modular.tydyzs.intermediary.marriage.entity.CustomerManage;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.Map;

/**
 *  服务类
 *
 * @author git
 * @since 2019-10-21
 */
public interface ICustomerManageService extends IService<CustomerManage> {
	public Result saveCustomer(CustomerManage customerManage);
	public LayuiPageInfo queryCustomer(Map param);//sql分页查询
	public Result queryCustomerMy(Map param);//sql分页查询
	public LayuiPageInfo queryCustomerAll(Map param);//sql所有查询
	public LayuiPageInfo queryCustomerEnt(Map param);//实体分页查询
	public LayuiPageInfo queryCustomerEntAll(Map param);//实体所有查询
}
