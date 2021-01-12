package cn.stylefeng.guns.modular.common.util;

import cn.stylefeng.guns.base.auth.model.LoginUser;
import cn.stylefeng.guns.sys.core.auth.LoginContextSpringSecutiryImpl;

public class LoginUtil {
    /**
     * 获取当前登录用户
     * @return
     */
    public static LoginUser getUser(){
        LoginContextSpringSecutiryImpl login=new LoginContextSpringSecutiryImpl();
        if(CommonUtil.checknull(login)){
            return null;
        }
        return login.getUser();
    }
    /**
     * 获取当前登录用户id
     */
    public static String getUserId(){
        LoginContextSpringSecutiryImpl login=new LoginContextSpringSecutiryImpl();
        if(CommonUtil.checknull(login)){
            return null;
        }
        return login.getUserId()+"";
    }
    /**
     * 获取当前登录部门id
     */
    public static String getOrgId(){
        LoginUser user= LoginUtil.getUser();
        if(CommonUtil.checknull(user)){
            return null;
        }
        return user.getDeptId()+"";
    }



}
