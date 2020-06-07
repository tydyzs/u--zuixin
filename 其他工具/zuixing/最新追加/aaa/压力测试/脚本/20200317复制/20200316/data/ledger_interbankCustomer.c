ledger_interbankCustomer()
{

	lr_think_time(24);

	web_custom_request("info_16", 
		"URL=http://127.0.0.1:9528/dev-api/git-user/info", 
		"Method=POST", 
		"Resource=0", 
		"RecContentType=application/json", 
		"Referer=http://127.0.0.1:9528/", 
		"Snapshot=t32.inf", 
		"Mode=HTML", 
		"EncType=", 
		EXTRARES, 
		"Url=../git-chart/customer-chart/getCrdListSumPage?current=1&size=10&userNum=&customerName=&orgNum=&certNum=&certType=&customerType=3&r=1584362283340", "Referer=http://127.0.0.1:9528/", ENDITEM, 
		"Url=../git-chart/customer-chart/getCrdListSumPage?current=1&size=99999999&userNum=&customerName=&orgNum=&certNum=&certType=&customerType=3&r=1584362283340", "Referer=http://127.0.0.1:9528/", ENDITEM, 
		"Url=../git-chart/customer-chart/getCrdListSumPage?current=1&size=10&userNum=&customerName=&orgNum=01000&certNum=&certType=&customerType=3&r=1584362283732", "Referer=http://127.0.0.1:9528/", ENDITEM, 
		"Url=../git-chart/customer-chart/getCrdListSumPage?current=1&size=10&userNum=&customerName=%E5%B7%A8%E4%BA%BA&orgNum=01000&certNum=&certType=&customerType=3&r=1584362301114", "Referer=http://127.0.0.1:9528/", ENDITEM, 
		LAST);

	web_custom_request("info_17", 
		"URL=http://127.0.0.1:9528/dev-api/git-user/info", 
		"Method=POST", 
		"Resource=0", 
		"RecContentType=application/json", 
		"Referer=http://127.0.0.1:9528/", 
		"Snapshot=t33.inf", 
		"Mode=HTML", 
		"EncType=", 
		EXTRARES, 
		"Url=../git-chart/customer-chart/getCrdListSumPage?current=1&size=10&userNum=&customerName=&orgNum=01000&certNum=&certType=&customerType=3&r=1584362304479", "Referer=http://127.0.0.1:9528/", ENDITEM, 
		LAST);

	lr_think_time(25);

	web_custom_request("info_18", 
		"URL=http://127.0.0.1:9528/dev-api/git-user/info", 
		"Method=POST", 
		"Resource=0", 
		"RecContentType=application/json", 
		"Referer=http://127.0.0.1:9528/", 
		"Snapshot=t34.inf", 
		"Mode=HTML", 
		"EncType=", 
		EXTRARES, 
		"Url=../git-chart/customer-chart/getCrdListSumPage?current=1&size=10&userNum=&customerName=&orgNum=01000&certNum=&certType=&customerType=3&r=1584362331725", "Referer=http://127.0.0.1:9528/", ENDITEM, 
		"Url=../git-chart/customer-chart/getCrdListSumPage?current=1&size=10&userNum=&customerName=&orgNum=01000&certNum=420984199910103210&certType=&customerType=3&r=1584362347692", "Referer=http://127.0.0.1:9528/", ENDITEM, 
		LAST);

	web_custom_request("info_19", 
		"URL=http://127.0.0.1:9528/dev-api/git-user/info", 
		"Method=POST", 
		"Resource=0", 
		"RecContentType=application/json", 
		"Referer=http://127.0.0.1:9528/", 
		"Snapshot=t35.inf", 
		"Mode=HTML", 
		"EncType=", 
		EXTRARES, 
		"Url=../git-chart/customer-chart/getCrdListSumPage?current=1&size=10&userNum=&customerName=&orgNum=01000&certNum=&certType=&customerType=3&r=1584362352972", "Referer=http://127.0.0.1:9528/", ENDITEM, 
		"Url=../git-system/dict/dictTranslate?code=org&r=1584362363301", "Referer=http://127.0.0.1:9528/", ENDITEM, 
		LAST);

	web_custom_request("getList_5", 
		"URL=http://127.0.0.1:9528/dev-api/git-system/dept/getList?current=1&size=10&deptName=&fullName=&orgType=", 
		"Method=POST", 
		"Resource=0", 
		"RecContentType=application/json", 
		"Referer=http://127.0.0.1:9528/", 
		"Snapshot=t36.inf", 
		"Mode=HTML", 
		"EncType=", 
		LAST);

	web_custom_request("getList_6", 
		"URL=http://127.0.0.1:9528/dev-api/git-system/dept/getList?current=1&size=10&deptName=%E7%8E%89%E5%B1%B1%E5%86%9C%E5%95%86%E9%93%B6%E8%A1%8C&fullName=&orgType=", 
		"Method=POST", 
		"Resource=0", 
		"RecContentType=application/json", 
		"Referer=http://127.0.0.1:9528/", 
		"Snapshot=t37.inf", 
		"Mode=HTML", 
		"EncType=", 
		EXTRARES, 
		"Url=/dev-api/git-chart/customer-chart/getCrdListSumPage?current=1&size=10&userNum=&customerName=&orgNum=16200&certNum=&certType=&customerType=3&r=1584362375243", "Referer=http://127.0.0.1:9528/", ENDITEM, 
		LAST);

	web_custom_request("info_20", 
		"URL=http://127.0.0.1:9528/dev-api/git-user/info", 
		"Method=POST", 
		"Resource=0", 
		"RecContentType=application/json", 
		"Referer=http://127.0.0.1:9528/", 
		"Snapshot=t38.inf", 
		"Mode=HTML", 
		"EncType=", 
		EXTRARES, 
		"Url=../git-chart/customer-chart/getCrdListSumPage?current=1&size=10&userNum=&customerName=&orgNum=01000&certNum=&certType=&customerType=3&r=1584362379498", "Referer=http://127.0.0.1:9528/", ENDITEM, 
		"Url=../git-chart/customer-chart/getOrgByCust?customerNum=C002&r=1584362388620", "Referer=http://127.0.0.1:9528/", ENDITEM, 
		"Url=../git-chart/ledger-chart/queryLedgerDeatilByOrgType?customerNum=C0027&r=1584362388620", "Referer=http://127.0.0.1:9528/", ENDITEM, 
		"Url=../git-chart/ledger-chart/queryLedgerDeatilByOrgTypeThree?customerNum=C0027&crdGrantOrgNum=&r=1584362388620", "Referer=http://127.0.0.1:9528/", ENDITEM, 
		"Url=../git-chart/ledger-chart/queryLedgerDeatilByOrgType?customerNum=C008&r=1584362389054", "Referer=http://127.0.0.1:9528/", ENDITEM, 
		"Url=../git-chart/ledger-chart/queryLedgerDeatilByOrgTypeThree?customerNum=C008&crdGrantOrgNum=10800&r=1584362389054", "Referer=http://127.0.0.1:9528/", ENDITEM, 
		LAST);

	lr_think_time(5);

	web_custom_request("info_21", 
		"URL=http://127.0.0.1:9528/dev-api/git-user/info", 
		"Method=POST", 
		"Resource=0", 
		"RecContentType=application/json", 
		"Referer=http://127.0.0.1:9528/", 
		"Snapshot=t39.inf", 
		"Mode=HTML", 
		"EncType=", 
		EXTRARES, 
		"Url=../git-chart/customer-chart/getCrdListSumPage?current=1&size=10&userNum=&customerName=&orgNum=&certNum=&certType=&customerType=3&r=1584362395383", "Referer=http://127.0.0.1:9528/", ENDITEM, 
		"Url=../git-chart/customer-chart/getCrdListSumPage?current=1&size=99999999&userNum=&customerName=&orgNum=&certNum=&certType=&customerType=3&r=1584362395383", "Referer=http://127.0.0.1:9528/", ENDITEM, 
		"Url=../git-chart/customer-chart/getCrdListSumPage?current=1&size=10&userNum=&customerName=&orgNum=01000&certNum=&certType=&customerType=3&r=1584362395731", "Referer=http://127.0.0.1:9528/", ENDITEM, 
		"Url=../git-csm/csmaddressinfo/page?current=1&size=5&customerNum=C0027&r=1584362400102", "Referer=http://127.0.0.1:9528/", ENDITEM, 
		"Url=../git-csm/csmcorporation/getCsmCorporationPageByCusNum?customerNum=C0027&r=1584362400102", "Referer=http://127.0.0.1:9528/", ENDITEM, 
		"Url=../git-csm/csmrelation/page?current=1&size=5&customerNum=C0027&r=1584362400102", "Referer=http://127.0.0.1:9528/", ENDITEM, 
		"Url=../git-csm/csmmanageteam/getCsmManageTeamPageByCusNum?current=1&size=5&customerNum=C0027&r=1584362400102", "Referer=http://127.0.0.1:9528/", ENDITEM, 
		"Url=../git-chart/customer-chart/getCrdListSumPage?current=1&size=10&userNum=&customerName=&orgNum=&certNum=&certType=&customerType=3&r=1584362405387", "Referer=http://127.0.0.1:9528/", ENDITEM, 
		LAST);

	web_custom_request("info_22", 
		"URL=http://127.0.0.1:9528/dev-api/git-user/info", 
		"Method=POST", 
		"Resource=0", 
		"RecContentType=application/json", 
		"Referer=http://127.0.0.1:9528/", 
		"Snapshot=t40.inf", 
		"Mode=HTML", 
		"EncType=", 
		EXTRARES, 
		"Url=../git-chart/customer-chart/getCrdListSumPage?current=1&size=99999999&userNum=&customerName=&orgNum=&certNum=&certType=&customerType=3&r=1584362405387", "Referer=http://127.0.0.1:9528/", ENDITEM, 
		"Url=../git-chart/customer-chart/getCrdListSumPage?current=1&size=10&userNum=&customerName=&orgNum=01000&certNum=&certType=&customerType=3&r=1584362406589", "Referer=http://127.0.0.1:9528/", ENDITEM, 
		LAST);

	return 0;
}
