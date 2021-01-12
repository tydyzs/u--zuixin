package cn.stylefeng.guns.modular.common.util;

import lombok.Data;

/*
*封装返回结果
 */
@Data
public class Result {
    private String state ="0";
    private String code ="0";
    private String msg = "请求成功";
    private Object data;//返回数据
    private long count;//条数
}
