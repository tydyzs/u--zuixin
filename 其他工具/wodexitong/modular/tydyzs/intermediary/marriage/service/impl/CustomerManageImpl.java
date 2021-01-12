package cn.stylefeng.guns.modular.tydyzs.intermediary.marriage.service.impl;

import cn.stylefeng.guns.base.pojo.page.LayuiPageFactory;
import cn.stylefeng.guns.base.pojo.page.LayuiPageInfo;
import cn.stylefeng.guns.modular.common.util.CommonUtil;
import cn.stylefeng.guns.modular.common.util.LoginUtil;
import cn.stylefeng.guns.modular.common.util.Result;
import cn.stylefeng.guns.modular.common.util.ProjectCommon;
import cn.stylefeng.guns.modular.tydyzs.intermediary.marriage.entity.CustomerManage;
import cn.stylefeng.guns.modular.tydyzs.intermediary.marriage.mapper.CustomerManageMapper;
import cn.stylefeng.guns.modular.tydyzs.intermediary.marriage.service.ICustomerManageService;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;
import java.util.Map;


/**
 * 服务实现类
 *
 * @author git
 * @since 2019-10-21
 */
@Service
public class CustomerManageImpl extends ServiceImpl<CustomerManageMapper, CustomerManage> implements ICustomerManageService {


    /**
     * 保存/编辑客户数据
     * @param customerManage
     */
    public Result saveCustomer(CustomerManage customerManage) {
        String customerId=customerManage.getCustomerId();
        if(CommonUtil.checknull(customerManage.getVehicle())){
            customerManage.setVehicle("off");
        }
        if(CommonUtil.checknull(customerManage.getRoom())){
            customerManage.setRoom("off");
        }
        //获取登入信息
        String userId= LoginUtil.getUserId();
        String orgId= LoginUtil.getOrgId();
        Date date=new Date();
        //新增时保存当前登入人信息
        if(CommonUtil.checknull(customerId)){//新增
            customerId=CommonUtil.getUuid();
            customerManage.setCreateUserId(userId);
            customerManage.setCreateOrgId(orgId);
            customerManage.setCreateDate(date);
            customerManage.setIsDelete("1");
        }
        customerManage.setCustomerId(customerId);
        //最后更新信息
        customerManage.setUpdateUserId(userId);
        customerManage.setUpdateOrgId(orgId);
        customerManage.setUpdateDate(date);
        this.saveOrUpdate(customerManage);
        Result res=new Result();
        res.setState("0");
        res.setMsg("保存成功！");
        return res;
    }

    /**
     * 自定义分页
     * sql分页查询客户数据
     * @param param
     * @return
     */
    public LayuiPageInfo queryCustomer(Map param){
        //获取前端分页参数
        Page pageContext = LayuiPageFactory.defaultPage();
        //获取分页查询结果
       //sql方式
        //IPage page = baseMapper.queryCustomer(pageContext, param);
        IPage page = baseMapper.queryCustomerValue(pageContext, param);
        //将结果转换成layui可识别的分页结果
        LayuiPageInfo result=LayuiPageFactory.createPageInfo(page);
        return result;
    }
    /**
     * 自定义分页
     * sql分页查询客户数据
     * @param param
     * @return
     */
    public Result queryCustomerMy(Map param){
        //获取前端分页参数
        Page pageContext = LayuiPageFactory.defaultPage();
        //获取分页查询结果
       //sql方式
        //IPage page = baseMapper.queryCustomer(pageContext, param);
        IPage page = baseMapper.queryCustomerValue(pageContext, param);
        //将结果转换成layui可识别的分页结果
        Result result= ProjectCommon.createPageInfo(page);
        return result;
    }
    /**
     * sql查询所有客户数据
     * @param param
     * @return
     */
    public LayuiPageInfo queryCustomerAll(Map param){
        //获取所有查询结果
        List data = baseMapper.queryCustomerAll(param);
        LayuiPageInfo result=new LayuiPageInfo();
        result.setData(data);
        return result;
    }

    /**
     * 分页查询(实体方式，一般用于单表)
     * @param param
     * @return
     */
    public LayuiPageInfo queryCustomerEnt(Map param){
        //获取前端分页参数
        Page pageContext = LayuiPageFactory.defaultPage();
        //获取分页查询结果
        //实体类方式
       //1.查询条件
        QueryWrapper<CustomerManage> objectQueryWrapper = new QueryWrapper<>();
        if(!CommonUtil.checknull(param.get("name"))){
            objectQueryWrapper.and(i -> i.eq("name", param.get("name")));
        }
        //2.开始查询
        IPage page = this.page(pageContext, objectQueryWrapper);
        //将结果转换成layui可识别的分页结果
        LayuiPageInfo result=LayuiPageFactory.createPageInfo(page);
        return result;
    }
    /**
     * 查所有（实体方式，一般用于单表)
     * @param param
     * @return
     */
    public LayuiPageInfo queryCustomerEntAll(Map param){
        //实体类方式
       //1.查询条件
        QueryWrapper<CustomerManage> objectQueryWrapper = new QueryWrapper<>();
        if(!CommonUtil.checknull(param.get("name"))){
            objectQueryWrapper.and(i -> i.eq("name", param.get("name")));
        }
        //2.开始查询
        List data = this.list(objectQueryWrapper);
        LayuiPageInfo result=new LayuiPageInfo();
        result.setData(data);
        return result;
    }

}
