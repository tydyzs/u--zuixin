ledger_individualCustomer()
{

	lr_think_time(21);

	web_url("getCrdListSumPage", 
		"URL=http://127.0.0.1:9528/dev-api/git-chart/customer-chart/getCrdListSumPage?current=1&size=10&userNum=&customerName=&orgNum=&certNum=&certType=&customerType=1&r=1584362159615", 
		"Resource=1", 
		"RecContentType=application/json", 
		"Referer=http://127.0.0.1:9528/", 
		"Snapshot=t22.inf", 
		LAST);

	web_custom_request("info_9", 
		"URL=http://127.0.0.1:9528/dev-api/git-user/info", 
		"Method=POST", 
		"Resource=0", 
		"RecContentType=application/json", 
		"Referer=http://127.0.0.1:9528/", 
		"Snapshot=t23.inf", 
		"Mode=HTML", 
		"EncType=", 
		EXTRARES, 
		"Url=../git-chart/customer-chart/getCrdListSumPage?current=1&size=99999999&userNum=&customerName=&orgNum=&certNum=&certType=&customerType=1&r=1584362159615", "Referer=http://127.0.0.1:9528/", ENDITEM, 
		"Url=../git-chart/customer-chart/getCrdListSumPage?current=1&size=10&userNum=&customerName=&orgNum=01000&certNum=&certType=&customerType=1&r=1584362160500", "Referer=http://127.0.0.1:9528/", ENDITEM, 
		"Url=../git-chart/customer-chart/getCrdListSumPage?current=1&size=10&userNum=&customerName=%E9%99%86%E5%B0%8F%E5%87%A4&orgNum=01000&certNum=&certType=&customerType=1&r=1584362170564", "Referer=http://127.0.0.1:9528/", ENDITEM, 
		LAST);

	web_custom_request("info_10", 
		"URL=http://127.0.0.1:9528/dev-api/git-user/info", 
		"Method=POST", 
		"Resource=0", 
		"RecContentType=application/json", 
		"Referer=http://127.0.0.1:9528/", 
		"Snapshot=t24.inf", 
		"Mode=HTML", 
		"EncType=", 
		EXTRARES, 
		"Url=../git-chart/customer-chart/getCrdListSumPage?current=1&size=10&userNum=&customerName=&orgNum=01000&certNum=&certType=&customerType=1&r=1584362175731", "Referer=http://127.0.0.1:9528/", ENDITEM, 
		LAST);

	lr_think_time(19);

	web_custom_request("info_11", 
		"URL=http://127.0.0.1:9528/dev-api/git-user/info", 
		"Method=POST", 
		"Resource=0", 
		"RecContentType=application/json", 
		"Referer=http://127.0.0.1:9528/", 
		"Snapshot=t25.inf", 
		"Mode=HTML", 
		"EncType=", 
		EXTRARES, 
		"Url=../git-chart/customer-chart/getCrdListSumPage?current=1&size=10&userNum=&customerName=&orgNum=01000&certNum=&certType=&customerType=1&r=1584362196579", "Referer=http://127.0.0.1:9528/", ENDITEM, 
		"Url=../git-chart/customer-chart/getCrdListSumPage?current=1&size=10&userNum=&customerName=&orgNum=01000&certNum=420984199910103300&certType=&customerType=1&r=1584362207317", "Referer=http://127.0.0.1:9528/", ENDITEM, 
		LAST);

	lr_think_time(6);

	web_custom_request("info_12", 
		"URL=http://127.0.0.1:9528/dev-api/git-user/info", 
		"Method=POST", 
		"Resource=0", 
		"RecContentType=application/json", 
		"Referer=http://127.0.0.1:9528/", 
		"Snapshot=t26.inf", 
		"Mode=HTML", 
		"EncType=", 
		EXTRARES, 
		"Url=../git-system/dict/dictTranslate?code=org&r=1584362214698", "Referer=http://127.0.0.1:9528/", ENDITEM, 
		LAST);

	web_custom_request("getList_3", 
		"URL=http://127.0.0.1:9528/dev-api/git-system/dept/getList?current=1&size=10&deptName=&fullName=&orgType=", 
		"Method=POST", 
		"Resource=0", 
		"RecContentType=application/json", 
		"Referer=http://127.0.0.1:9528/", 
		"Snapshot=t27.inf", 
		"Mode=HTML", 
		"EncType=", 
		EXTRARES, 
		"Url=/dev-api/git-chart/customer-chart/getCrdListSumPage?current=1&size=10&userNum=&customerName=&orgNum=01000&certNum=&certType=&customerType=1&r=1584362214931", "Referer=http://127.0.0.1:9528/", ENDITEM, 
		LAST);

	web_custom_request("getList_4", 
		"URL=http://127.0.0.1:9528/dev-api/git-system/dept/getList?current=1&size=10&deptName=%E6%96%B0%E5%BB%BA%E5%86%9C%E5%95%86%E9%93%B6%E8%A1%8C&fullName=&orgType=", 
		"Method=POST", 
		"Resource=0", 
		"RecContentType=application/json", 
		"Referer=http://127.0.0.1:9528/", 
		"Snapshot=t28.inf", 
		"Mode=HTML", 
		"EncType=", 
		EXTRARES, 
		"Url=/dev-api/git-chart/customer-chart/getCrdListSumPage?current=1&size=10&userNum=&customerName=&orgNum=10200&certNum=&certType=&customerType=1&r=1584362225064", "Referer=http://127.0.0.1:9528/", ENDITEM, 
		LAST);

	web_custom_request("info_13", 
		"URL=http://127.0.0.1:9528/dev-api/git-user/info", 
		"Method=POST", 
		"Resource=0", 
		"RecContentType=application/json", 
		"Referer=http://127.0.0.1:9528/", 
		"Snapshot=t29.inf", 
		"Mode=HTML", 
		"EncType=", 
		EXTRARES, 
		"Url=../git-chart/customer-chart/getCrdListSumPage?current=1&size=10&userNum=&customerName=&orgNum=01000&certNum=&certType=&customerType=1&r=1584362229385", "Referer=http://127.0.0.1:9528/", ENDITEM, 
		"Url=../git-system/dict/dictTranslate?code=org&r=1584362240844", "Referer=http://127.0.0.1:9528/", ENDITEM, 
		"Url=../git-chart/customer-chart/getOrgByCust?customerNum=C0016&r=1584362240844", "Referer=http://127.0.0.1:9528/", ENDITEM, 
		"Url=../git-chart/customer-chart/sumCsmCrd?customerNum=C0016&orgNum=01000&r=1584362242906", "Referer=http://127.0.0.1:9528/", ENDITEM, 
		"Url=../git-chart/customer-chart/listCrdDetail?customerNum=C0016&orgNum=01000&r=1584362242906", "Referer=http://127.0.0.1:9528/", ENDITEM, 
		"Url=../git-chart/customer-chart/getCrdListSumPage?current=1&size=10&userNum=&customerName=&orgNum=&certNum=&certType=&customerType=1&r=1584362248048", "Referer=http://127.0.0.1:9528/", ENDITEM, 
		LAST);

	web_custom_request("info_14", 
		"URL=http://127.0.0.1:9528/dev-api/git-user/info", 
		"Method=POST", 
		"Resource=0", 
		"RecContentType=application/json", 
		"Referer=http://127.0.0.1:9528/", 
		"Snapshot=t30.inf", 
		"Mode=HTML", 
		"EncType=", 
		EXTRARES, 
		"Url=../git-chart/customer-chart/getCrdListSumPage?current=1&size=99999999&userNum=&customerName=&orgNum=&certNum=&certType=&customerType=1&r=1584362248048", "Referer=http://127.0.0.1:9528/", ENDITEM, 
		"Url=../git-chart/customer-chart/getCrdListSumPage?current=1&size=10&userNum=&customerName=&orgNum=01000&certNum=&certType=&customerType=1&r=1584362248847", "Referer=http://127.0.0.1:9528/", ENDITEM, 
		"Url=../git-csm/csmindividual/getCsmIndividualPageByCustNum?customerNum=C0016&r=1584362252783", "Referer=http://127.0.0.1:9528/", ENDITEM, 
		"Url=../git-csm/csmaddressinfo/page?current=1&size=5&customerNum=C0016&r=1584362252783", "Referer=http://127.0.0.1:9528/", ENDITEM, 
		"Url=../git-csm/csmrelation/page?current=1&size=5&customerNum=C0016&r=1584362252783", "Referer=http://127.0.0.1:9528/", ENDITEM, 
		"Url=../git-csm/csmmanageteam/getCsmManageTeamPageByCusNum?current=1&size=5&customerNum=C0016&r=1584362252783", "Referer=http://127.0.0.1:9528/", ENDITEM, 
		LAST);

	lr_think_time(4);

	web_custom_request("info_15", 
		"URL=http://127.0.0.1:9528/dev-api/git-user/info", 
		"Method=POST", 
		"Resource=0", 
		"RecContentType=application/json", 
		"Referer=http://127.0.0.1:9528/", 
		"Snapshot=t31.inf", 
		"Mode=HTML", 
		"EncType=", 
		EXTRARES, 
		"Url=../git-chart/customer-chart/getCrdListSumPage?current=1&size=10&userNum=&customerName=&orgNum=&certNum=&certType=&customerType=1&r=1584362258050", "Referer=http://127.0.0.1:9528/", ENDITEM, 
		"Url=../git-chart/customer-chart/getCrdListSumPage?current=1&size=99999999&userNum=&customerName=&orgNum=&certNum=&certType=&customerType=1&r=1584362258050", "Referer=http://127.0.0.1:9528/", ENDITEM, 
		"Url=../git-chart/customer-chart/getCrdListSumPage?current=1&size=10&userNum=&customerName=&orgNum=01000&certNum=&certType=&customerType=1&r=1584362258382", "Referer=http://127.0.0.1:9528/", ENDITEM, 
		LAST);

	return 0;
}
