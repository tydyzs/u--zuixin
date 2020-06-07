ledger_interbankCredit()
{

	lr_think_time(28);

	web_url("workDateTime", 
		"URL=http://127.0.0.1:9528/dev-api/git-system/sysdate/workDateTime?r=1584362766409", 
		"Resource=1", 
		"RecContentType=application/json", 
		"Referer=http://127.0.0.1:9528/", 
		"Snapshot=t55.inf", 
		LAST);

	web_custom_request("info_31", 
		"URL=http://127.0.0.1:9528/dev-api/git-user/info", 
		"Method=POST", 
		"Resource=0", 
		"RecContentType=application/json", 
		"Referer=http://127.0.0.1:9528/", 
		"Snapshot=t56.inf", 
		"Mode=HTML", 
		"EncType=", 
		EXTRARES, 
		"Url=../git-desk/notice/page?createDept=01000&current=1&size=999&r=1584362766830", "Referer=http://127.0.0.1:9528/", ENDITEM, 
		"Url=../git-chart/org-chart/getStatisOrg?orgNum=01000&r=1584362766832", "Referer=http://127.0.0.1:9528/", ENDITEM, 
		"Url=../git-rcm/ledger/home?useOrgNum=16200&r=1584362766832", "Referer=http://127.0.0.1:9528/", ENDITEM, 
		"Url=../git-doc/excel-report/query/bankCreditTable?current=1&size=10&customerName=&r=1584362768530", "Referer=http://127.0.0.1:9528/", ENDITEM, 
		"Url=../git-doc/excel-report/query/bankCreditTable?current=1&size=10&customerName=%E7%9C%81&r=1584362789626", "Referer=http://127.0.0.1:9528/", ENDITEM, 
		"Url=../git-doc/excel-report/query/bankCreditTable?current=1&size=10&customerName=&r=1584362793514", "Referer=http://127.0.0.1:9528/", ENDITEM, 
		"Url=../git-doc/excel-report/query/bankCreditTable?current=1&size=10&customerName=&r=1584362794734", "Referer=http://127.0.0.1:9528/", ENDITEM, 
		LAST);

	web_url("bankCreditTable", 
		"URL=http://106.12.241.109:9080/git-doc/excel-report/download/bankCreditTable?customerName", 
		"Resource=0", 
		"Referer=http://127.0.0.1:9528/", 
		"Snapshot=t57.inf", 
		"Mode=HTML", 
		LAST);

	return 0;
}
