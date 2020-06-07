vuser_end()
{

	lr_think_time(38);

	web_custom_request("logout", 
		"URL=http://127.0.0.1:9528/dev-api/git-auth/oauth/logout", 
		"Method=POST", 
		"Resource=0", 
		"RecContentType=application/json", 
		"Referer=http://127.0.0.1:9528/", 
		"Snapshot=t60.inf", 
		"Mode=HTML", 
		"EncType=", 
		LAST);

	return 0;
}