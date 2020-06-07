mechanismView()
{

	lr_think_time(31);

	web_custom_request("info_32", 
		"URL=http://127.0.0.1:9528/dev-api/git-user/info", 
		"Method=POST", 
		"Resource=0", 
		"RecContentType=application/json", 
		"Referer=http://127.0.0.1:9528/", 
		"Snapshot=t58.inf", 
		"Mode=HTML", 
		"EncType=", 
		LAST);

	web_custom_request("treeManage", 
		"URL=http://127.0.0.1:9528/dev-api/git-system/dept/treeManage?orgNum=01000", 
		"Method=POST", 
		"Resource=0", 
		"RecContentType=application/json", 
		"Referer=http://127.0.0.1:9528/", 
		"Snapshot=t59.inf", 
		"Mode=HTML", 
		"EncType=", 
		EXTRARES, 
		"Url=/dev-api/git-chart/org-chart/getStatisOrg?orgNum=01000&r=1584362831209", "Referer=http://127.0.0.1:9528/", ENDITEM, 
		"Url=/dev-api/git-chart/org-chart/listStatis?dimension=1&orgNum=01000&r=1584362831209", "Referer=http://127.0.0.1:9528/", ENDITEM, 
		"Url=/dev-api/git-chart/org-chart/listStatis?dimension=2&orgNum=01000&r=1584362851418", "Referer=http://127.0.0.1:9528/", ENDITEM, 
		LAST);

	return 0;
}
