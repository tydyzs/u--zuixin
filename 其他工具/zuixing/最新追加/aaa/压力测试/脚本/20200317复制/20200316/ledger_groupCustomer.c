ledger_groupCustomer()
{

	lr_think_time(20);

	web_custom_request("info_23", 
		"URL=http://127.0.0.1:9528/dev-api/git-user/info", 
		"Method=POST", 
		"Resource=0", 
		"RecContentType=application/json", 
		"Referer=http://127.0.0.1:9528/", 
		"Snapshot=t41.inf", 
		"Mode=HTML", 
		"EncType=", 
		EXTRARES, 
		"Url=../git-loan/csmGroupMember/listCsmGroupMemberPage?current=1&size=10&orgNum=01000&customerName=&userNum=&r=1584362428085", "Referer=http://127.0.0.1:9528/", ENDITEM, 
		"Url=../git-loan/csmGroupMember/findCsmGroupMemberPage?current=1&size=10&memberCustomerNum=&orgNum=01000&r=1584362428085", "Referer=http://127.0.0.1:9528/", ENDITEM, 
		"Url=../git-loan/csmGroupMember/listCsmGroupMemberPage?current=1&size=99999999&orgNum=01000&customerName=&userNum=&r=1584362428085", "Referer=http://127.0.0.1:9528/", ENDITEM, 
		"Url=../git-loan/csmGroupMember/findCsmGroupMemberPage?current=1&size=10&memberCustomerNum=C0034&orgNum=14103&r=1584362434354", "Referer=http://127.0.0.1:9528/", ENDITEM, 
		LAST);

	lr_think_time(4);

	web_custom_request("getList_7", 
		"URL=http://127.0.0.1:9528/dev-api/git-system/dept/getList?current=1&size=10&deptName=&fullName=&orgType=", 
		"Method=POST", 
		"Resource=0", 
		"RecContentType=application/json", 
		"Referer=http://127.0.0.1:9528/", 
		"Snapshot=t42.inf", 
		"Mode=HTML", 
		"EncType=", 
		EXTRARES, 
		"Url=../dict/dictTranslate?code=org&r=1584362440333", "Referer=http://127.0.0.1:9528/", ENDITEM, 
		LAST);

	web_custom_request("getList_8", 
		"URL=http://127.0.0.1:9528/dev-api/git-system/dept/getList?current=1&size=10&deptName=%E5%9F%8E%E5%8C%BA%E4%BF%A1%E7%94%A8%E7%A4%BE&fullName=&orgType=", 
		"Method=POST", 
		"Resource=0", 
		"RecContentType=application/json", 
		"Referer=http://127.0.0.1:9528/", 
		"Snapshot=t43.inf", 
		"Mode=HTML", 
		"EncType=", 
		EXTRARES, 
		"Url=/dev-api/git-loan/csmGroupMember/listCsmGroupMemberPage?current=1&size=10&orgNum=14103&customerName=&userNum=&r=1584362452820", "Referer=http://127.0.0.1:9528/", ENDITEM, 
		"Url=/dev-api/git-loan/csmGroupMember/findCsmGroupMemberPage?current=1&size=10&memberCustomerNum=C0034&orgNum=14103&r=1584362461001", "Referer=http://127.0.0.1:9528/", ENDITEM, 
		"Url=/dev-api/git-loan/csmGroupMember/listCsmGroupMemberPage?current=1&size=10&orgNum=14103&customerName=%E4%B8%AD%E5%85%B4&userNum=&r=1584362464247", "Referer=http://127.0.0.1:9528/", ENDITEM, 
		"Url=/dev-api/git-loan/csmGroupMember/findCsmGroupMemberPage?current=1&size=10&memberCustomerNum=C0034&orgNum=14103&r=1584362481918", "Referer=http://127.0.0.1:9528/", ENDITEM, 
		"Url=/dev-api/git-loan/csmGroupMember/listCsmGroupMemberPage?current=1&size=10&orgNum=14103&customerName=%E4%B8%AD%E5%85%B4&userNum=&r=1584362490509", "Referer=http://127.0.0.1:9528/", ENDITEM, 
		"Url=/dev-api/git-loan/csmGroupMember/listCsmGroupMemberPage?current=1&size=10&orgNum=&customerName=&userNum=&r=1584362498753", "Referer=http://127.0.0.1:9528/", ENDITEM, 
		"Url=/dev-api/git-loan/csmGroupMember/listCsmGroupMemberPage?current=1&size=10&orgNum=&customerName=&userNum=&r=1584362506694", "Referer=http://127.0.0.1:9528/", ENDITEM, 
		LAST);

	return 0;
}
