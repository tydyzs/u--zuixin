/*
 *      Copyright (c) 2018-2028, Chill Zhuang All rights reserved.
 *
 *  Redistribution and use in source and binary forms, with or without
 *  modification, are permitted provided that the following conditions are met:
 *
 *  Redistributions of source code must retain the above copyright notice,
 *  this list of conditions and the following disclaimer.
 *  Redistributions in binary form must reproduce the above copyright
 *  notice, this list of conditions and the following disclaimer in the
 *  documentation and/or other materials provided with the distribution.
 *  Neither the name of the dreamlu.net developer nor the names of its
 *  contributors may be used to endorse or promote products derived from
 *  this software without specific prior written permission.
 *  Author: Chill 庄骞 (smallchill@163.com)
 */
package cn.stylefeng.guns.modular.tydyzs.intermediary.marriage.vo;

import cn.stylefeng.guns.modular.tydyzs.intermediary.marriage.entity.CustomerManage;
import io.swagger.annotations.ApiModel;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * 视图实体类
 *
 * @author git
 * @since 2019-10-21
 */
@Data
@EqualsAndHashCode(callSuper = true)
@ApiModel(value = "CrdProductVO对象", description = "CrdProductVO对象")
public class CustomerManageVO extends CustomerManage {
	private static final long serialVersionUID = 1L;

	private String genderValue;//性别字典
	private String maritalStatusValue;//婚姻状况字典
	private String educationValue;//学历字典
	private String roomValue;//是否有房字典
	private String vehicleValue;//是否有车字典
	private String householdValue;//户口所在地字典
	private String addressValue;//常驻地址字典




}
