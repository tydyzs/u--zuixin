ledger_companyCustomer()
{

	lr_think_time(40);

	web_custom_request("info_4", 
		"URL=http://127.0.0.1:9528/dev-api/git-user/info", 
		"Method=POST", 
		"Resource=0", 
		"RecContentType=application/json", 
		"Referer=http://127.0.0.1:9528/", 
		"Snapshot=t15.inf", 
		"Mode=HTML", 
		"EncType=", 
		EXTRARES, 
		"Url=../git-chart/customer-chart/getCrdListSumPage?current=1&size=10&userNum=&customerName=&orgNum=&certNum=&certType=&customerType=2&r=1584362002373", "Referer=http://127.0.0.1:9528/", ENDITEM, 
		"Url=../git-chart/customer-chart/getCrdListSumPage?current=1&size=9999999&userNum=&customerName=&orgNum=&certNum=&certType=&customerType=2&r=1584362002373", "Referer=http://127.0.0.1:9528/", ENDITEM, 
		"Url=../git-chart/customer-chart/getCrdListSumPage?current=1&size=10&userNum=&customerName=&orgNum=01000&certNum=&certType=&customerType=2&r=1584362003011", "Referer=http://127.0.0.1:9528/", ENDITEM, 
		"Url=../git-chart/customer-chart/getCrdListSumPage?current=1&size=10&userNum=&customerName=%E5%AD%99%E6%82%9F%E7%A9%BA&orgNum=01000&certNum=&certType=&customerType=2&r=1584362021230", "Referer=http://127.0.0.1:9528/", ENDITEM, 
		"Url=../git-chart/customer-chart/getCrdListSumPage?current=1&size=10&userNum=&customerName=&orgNum=01000&customerNum=C0011&certNum=&certType=&customerType=2&r=1584362029586", "Referer=http://127.0.0.1:9528/", ENDITEM, 
		LAST);

	lr_think_time(9);

	web_custom_request("info_5", 
		"URL=http://127.0.0.1:9528/dev-api/git-user/info", 
		"Method=POST", 
		"Resource=0", 
		"RecContentType=application/json", 
		"Referer=http://127.0.0.1:9528/", 
		"Snapshot=t16.inf", 
		"Mode=HTML", 
		"EncType=", 
		EXTRARES, 
		"Url=../git-chart/customer-chart/getCrdListSumPage?current=1&size=10&userNum=&customerName=&orgNum=01000&certNum=&certType=&customerType=2&r=1584362040636", "Referer=http://127.0.0.1:9528/", ENDITEM, 
		"Url=../git-chart/customer-chart/getCrdListSumPage?current=1&size=10&userNum=&customerName=&orgNum=01000&certNum=420984199910107000&certType=&customerType=2&r=1584362065001", "Referer=http://127.0.0.1:9528/", ENDITEM, 
		LAST);

	lr_think_time(5);

	web_custom_request("info_6", 
		"URL=http://127.0.0.1:9528/dev-api/git-user/info", 
		"Method=POST", 
		"Resource=0", 
		"RecContentType=application/json", 
		"Referer=http://127.0.0.1:9528/", 
		"Snapshot=t17.inf", 
		"Mode=HTML", 
		"EncType=", 
		EXTRARES, 
		"Url=../git-chart/customer-chart/getCrdListSumPage?current=1&size=10&userNum=&customerName=&orgNum=01000&certNum=&certType=&customerType=2&r=1584362071705", "Referer=http://127.0.0.1:9528/", ENDITEM, 
		"Url=../git-system/dict/dictTranslate?code=org&r=1584362078451", "Referer=http://127.0.0.1:9528/", ENDITEM, 
		LAST);

	web_custom_request("getList", 
		"URL=http://127.0.0.1:9528/dev-api/git-system/dept/getList?current=1&size=10&deptName=&fullName=&orgType=", 
		"Method=POST", 
		"Resource=0", 
		"RecContentType=application/json", 
		"Referer=http://127.0.0.1:9528/", 
		"Snapshot=t18.inf", 
		"Mode=HTML", 
		"EncType=", 
		LAST);

	web_custom_request("getList_2", 
		"URL=http://127.0.0.1:9528/dev-api/git-system/dept/getList?current=1&size=10&deptName=%E8%B5%A3%E6%98%8C%E5%86%9C%E5%95%86%E9%93%B6%E8%A1%8C&fullName=&orgType=", 
		"Method=POST", 
		"Resource=0", 
		"RecContentType=application/json", 
		"Referer=http://127.0.0.1:9528/", 
		"Snapshot=t19.inf", 
		"Mode=HTML", 
		"EncType=", 
		EXTRARES, 
		"Url=/dev-api/git-chart/customer-chart/getCrdListSumPage?current=1&size=10&userNum=&customerName=&orgNum=10100&certNum=&certType=&customerType=2&r=1584362093632", "Referer=http://127.0.0.1:9528/", ENDITEM, 
		"Url=/dev-api/git-chart/customer-chart/getOrgByCust?customerNum=C0011&r=1584362108463", "Referer=http://127.0.0.1:9528/", ENDITEM, 
		"Url=../dict/dictTranslate?code=org&r=1584362108463", "Referer=http://127.0.0.1:9528/", ENDITEM, 
		"Url=/dev-api/git-chart/customer-chart/sumCsmCrd?customerNum=C0011&orgNum=01000&r=1584362110740", "Referer=http://127.0.0.1:9528/", ENDITEM, 
		"Url=/dev-api/git-chart/customer-chart/listCrdDetail?customerNum=C0011&orgNum=01000&r=1584362110740", "Referer=http://127.0.0.1:9528/", ENDITEM, 
		LAST);

	lr_think_time(12);

	web_custom_request("info_7", 
		"URL=http://127.0.0.1:9528/dev-api/git-user/info", 
		"Method=POST", 
		"Resource=0", 
		"RecContentType=application/json", 
		"Referer=http://127.0.0.1:9528/", 
		"Snapshot=t20.inf", 
		"Mode=HTML", 
		"EncType=", 
		EXTRARES, 
		"Url=../git-chart/customer-chart/getCrdListSumPage?current=1&size=10&userNum=&customerName=&orgNum=&certNum=&certType=&customerType=2&r=1584362123111", "Referer=http://127.0.0.1:9528/", ENDITEM, 
		"Url=../git-chart/customer-chart/getCrdListSumPage?current=1&size=9999999&userNum=&customerName=&orgNum=&certNum=&certType=&customerType=2&r=1584362123111", "Referer=http://127.0.0.1:9528/", ENDITEM, 
		"Url=../git-chart/customer-chart/getCrdListSumPage?current=1&size=10&userNum=&customerName=&orgNum=01000&certNum=&certType=&customerType=2&r=1584362123533", "Referer=http://127.0.0.1:9528/", ENDITEM, 
		"Url=../git-csm/csmcorporation/getCsmCorporationPageByCusNum?customerNum=C0011&r=1584362129715", "Referer=http://127.0.0.1:9528/", ENDITEM, 
		"Url=../git-csm/csmaddressinfo/page?current=1&size=5&customerNum=C0011&r=1584362129715", "Referer=http://127.0.0.1:9528/", ENDITEM, 
		"Url=../git-csm/csmrelation/page?current=1&size=5&customerNum=C0011&r=1584362129715", "Referer=http://127.0.0.1:9528/", ENDITEM, 
		"Url=../git-csm/csmmanageteam/getCsmManageTeamPageByCusNum?current=1&size=5&customerNum=C0011&r=1584362129715", "Referer=http://127.0.0.1:9528/", ENDITEM, 
		LAST);

	lr_think_time(6);

	web_custom_request("info_8", 
		"URL=http://127.0.0.1:9528/dev-api/git-user/info", 
		"Method=POST", 
		"Resource=0", 
		"RecContentType=application/json", 
		"Referer=http://127.0.0.1:9528/", 
		"Snapshot=t21.inf", 
		"Mode=HTML", 
		"EncType=", 
		EXTRARES, 
		"Url=../git-chart/customer-chart/getCrdListSumPage?current=1&size=10&userNum=&customerName=&orgNum=&certNum=&certType=&customerType=2&r=1584362136727", "Referer=http://127.0.0.1:9528/", ENDITEM, 
		"Url=../git-chart/customer-chart/getCrdListSumPage?current=1&size=9999999&userNum=&customerName=&orgNum=&certNum=&certType=&customerType=2&r=1584362136727", "Referer=http://127.0.0.1:9528/", ENDITEM, 
		"Url=../git-chart/customer-chart/getCrdListSumPage?current=1&size=10&userNum=&customerName=&orgNum=01000&certNum=&certType=&customerType=2&r=1584362137117", "Referer=http://127.0.0.1:9528/", ENDITEM, 
		LAST);

	return 0;
}
