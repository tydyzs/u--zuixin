/* -------------------------------------------------------------------------------
	Script Title       : 
	Script Description : 
                        
                        
	Recorder Version   : 8859
   ------------------------------------------------------------------------------- */

vuser_init()
{

	web_set_user("saber", 
		lr_decrypt("5e6f76398af6daa370fd64a38078fa36"), 
		"127.0.0.1:9528");

	web_url("127.0.0.1:9528", 
		"URL=http://127.0.0.1:9528/", 
		"Resource=0", 
		"Referer=", 
		"Mode=HTML", 
		LAST);

	web_url("127.0.0.1:9528_2", 
		"URL=http://127.0.0.1:9528/", 
		"Resource=0", 
		"Referer=", 
		"Mode=HTML", 
		EXTRARES, 
		"Url=/app.js", ENDITEM, 
		"Url=/static/img/login_big1.3eb485a7.jpg", ENDITEM, 
		"Url=/static/fonts/element-icons.535877f5.woff", ENDITEM, 
		"Url=/static/img/login_left2.e886d96e.png", ENDITEM, 
		"Url=/static/img/login_right.a0f85c66.png", ENDITEM, 
		"Url=http://192.168.43.81:9528/sockjs-node/info?t=1584361917974", ENDITEM, 
		"Url=http://localhost:9528/sockjs-node/info?t=1584361917972", ENDITEM, 
		"Url=/favicon.ico", "Referer=", ENDITEM, 
		"Url=/dev-api/git-system/menu/routes?r=1584361953973", ENDITEM, 
		"Url=/img/bg/logobg.jpg", ENDITEM, 
		"Url=/dev-api/git-system/menu/buttons?r=1584361954432", ENDITEM, 
		"Url=/dev-api/git-system/sysdate/workDateTime?r=1584361955574", ENDITEM, 
		"Url=/dev-api/git-system/menu/top-menu?r=1584361955574", ENDITEM, 
		"Url=/dev-api/git-desk/notice/page?createDept=01000&current=1&size=999&r=1584361956944", ENDITEM, 
		"Url=/dev-api/git-chart/org-chart/getStatisOrg?orgNum=01000&r=1584361956944", ENDITEM, 
		"Url=/dev-api/git-rcm/ledger/home?useOrgNum=16200&r=1584361956944", ENDITEM, 
		LAST);

	web_add_cookie("IMEVER=8.5.0.1183; DOMAIN=get.sogou.com");

	web_add_cookie("YYID=7ECF564122FC186A3C4FC2D561C3B41E; DOMAIN=get.sogou.com");

	web_add_cookie("SMYUV=1583581077639800; DOMAIN=get.sogou.com");

	web_add_cookie("QIDIANID=p7C0OD8RPST7NB245ehyDXgGZVgMnAbtUZCbHRefZrCQ2uraLlVYvdVls/lyIPaRDTpqAROwylfuYQuS1r2eFg==; DOMAIN=get.sogou.com");

	web_add_cookie("SUV=00EF753BAB51E25C5E5B0FBCBA581727; DOMAIN=get.sogou.com");

	web_add_cookie("usid=WHNFd5Y14tfbGbCs; DOMAIN=get.sogou.com");

	web_add_cookie("SUID=0FE251ABAE32A00A000000005E638B0C; DOMAIN=get.sogou.com");

	web_add_cookie("IPLOC=CN4200; DOMAIN=get.sogou.com");

	web_add_cookie("SNUID=4BF549B3171DB8FAE6BC5D3A187E3754; DOMAIN=get.sogou.com");

	web_add_cookie("CXID=EAF0F91EE2276FC6E4C711C491F4D9B9; DOMAIN=get.sogou.com");

	web_add_cookie("ad=blllllllll2WbeVklllllVis9Qllllll$C4Pjyllll9lllll9Vxlw@@@@@@@@@@@; DOMAIN=get.sogou.com");

	web_add_cookie("ld=6lllllllll2WzLZClllllVisJDYlllll$C4AcZllllwlllll9llll5@@@@@@@@@@; DOMAIN=get.sogou.com");

	web_custom_request("q", 
		"URL=http://get.sogou.com/q", 
		"Method=POST", 
		"Resource=0", 
		"RecContentType=text/plain", 
		"Referer=", 
		"Snapshot=t3.inf", 
		"Mode=HTML", 
		"Body=k=npdgxRf7moxE8e1z91wKuSrxwatjnVtHYG2VDOGvC9p1+cEwhHZFJ82RjatjYfjSE6ufBCbTjGIUYCGOjCpFLYlVfDw4jk7gcvc2Ij+6zkq4NVFaXJdy/6UCmEdf7dUhSx+ZScPFcXOEYxuXHMpBB1tb7v8tnX7Bd8rxA8kNK9Q=&v=RL+8PLygg69sS2tJOVhCRPhPAAx1VwLNFt/iEeXg099QDZMOFves04o71C3rmisgQyfXffqYVpk5DOeKKjCVUrLIYg2Bl5h05GN2li0tNzz63K6cyxpLTN/RZSRGBZMFWrIm6KrXDR5NYSLR1xzkmcOiPflYXY4NDN48znGLgE8=&u=wJX8GwBfy8S3jLk0tHHdhcpWjCQsa8RloklHXfPt7wk=&g=wd49xbAEPCUjwWz/2M04cIaMZiilqGPrhgGv5iRUZLiniF0pGNhufMOroo16z1niMhzHhpGLWdfubwLKy9356Q==&p="
		"xInB9thgPzUz7A91m0ZI2JSlvw9avD1tXHMU/TBjhgSivNQ6X9z0ox1v/hEf9fzuq2tPQ+wfDAcsRkd6vMz0IxkhgiiyGW2tEsj7g3yOkDw=", 
		LAST);

	web_url("websocket", 
		"URL=http://192.168.43.81:9528/sockjs-node/165/d5pj3u2l/websocket", 
		"Resource=0", 
		"Referer=", 
		"Snapshot=t4.inf", 
		"Mode=HTML", 
		LAST);

	lr_think_time(4);

	web_url("websocket_2", 
		"URL=http://localhost:9528/sockjs-node/813/a1rkabrl/websocket", 
		"Resource=0", 
		"Referer=", 
		"Snapshot=t5.inf", 
		"Mode=HTML", 
		LAST);

	lr_think_time(6);

	web_custom_request("q_2", 
		"URL=http://get.sogou.com/q", 
		"Method=POST", 
		"Resource=0", 
		"RecContentType=text/plain", 
		"Referer=", 
		"Snapshot=t6.inf", 
		"Mode=HTML", 
		"Body=k=toUGdQ4DRmBg1XQJtAPYVEJbvqFbDviyqAIOuywV0CvZaWiuIcn6YKy7XEILl5B6NPRVI0qdagw7J+0PrKiY6NhmQaxkUC8yv9QwME6u+jn0hwbLfkghcsGUqcNRP4RqjgExauXkqtVM2qi/HXC0v4IvDqojY3WFdnz8XqUtXEs=&v=oscaVMhEmL7mbfR/5N3rvpJAkkIKOZmaYuPD/lacc41WvJcs75MbduiZ5XS08nkEsiA0ptHSXdFLTqT3bVlR9MlPsy3seQECOtG9rtMQEBXwTWOME8QR8RMxlIUj5v7BEjmEsmrYXglGTl18vrwXhS+Ft/ELUuJf7Vo72VLq4t0=&u=3dEL2BdA4timfxnrAYgCqknQ4C5yf2cV0GrhzC04fzA=&g=RXJTvD+7Mib+e8ekar3HW3PAR5il09nfpXCondsNWGkXboX12O2Zo65p2uCAfCWJprQeGXwMVcUcTfmf5y9a3g==&p="
		"w6EnzwvMuzRamyU/LGGW9bj38Nu+QjkJhPRBWlYEHIL5m/23oQzpcEM3feI4fxkC4EpMfAvIYROrgNh44xe5EGsn3Kw/UrbIZIkKdjRt7AbkV6aA98baMvPx+LYd2enX", 
		LAST);

	web_custom_request("depts", 
		"URL=http://127.0.0.1:9528/dev-api/git-auth/oauth/depts?account=admin", 
		"Method=POST", 
		"Resource=0", 
		"RecContentType=application/json", 
		"Referer=http://127.0.0.1:9528/", 
		"Snapshot=t7.inf", 
		"Mode=HTML", 
		"EncType=", 
		LAST);

	web_add_cookie("IMEVER=8.5.0.1183; DOMAIN=config.push.sogou.com");

	web_add_cookie("YYID=7ECF564122FC186A3C4FC2D561C3B41E; DOMAIN=config.push.sogou.com");

	web_add_cookie("SMYUV=1583581077639800; DOMAIN=config.push.sogou.com");

	web_add_cookie("QIDIANID=p7C0OD8RPST7NB245ehyDXgGZVgMnAbtUZCbHRefZrCQ2uraLlVYvdVls/lyIPaRDTpqAROwylfuYQuS1r2eFg==; DOMAIN=config.push.sogou.com");

	web_add_cookie("SUV=00EF753BAB51E25C5E5B0FBCBA581727; DOMAIN=config.push.sogou.com");

	web_add_cookie("usid=WHNFd5Y14tfbGbCs; DOMAIN=config.push.sogou.com");

	web_add_cookie("SUID=0FE251ABAE32A00A000000005E638B0C; DOMAIN=config.push.sogou.com");

	web_add_cookie("IPLOC=CN4200; DOMAIN=config.push.sogou.com");

	web_add_cookie("SNUID=4BF549B3171DB8FAE6BC5D3A187E3754; DOMAIN=config.push.sogou.com");

	web_add_cookie("CXID=EAF0F91EE2276FC6E4C711C491F4D9B9; DOMAIN=config.push.sogou.com");

	web_add_cookie("ad=blllllllll2WbeVklllllVis9Qllllll$C4Pjyllll9lllll9Vxlw@@@@@@@@@@@; DOMAIN=config.push.sogou.com");

	web_add_cookie("ld=6lllllllll2WzLZClllllVisJDYlllll$C4AcZllllwlllll9llll5@@@@@@@@@@; DOMAIN=config.push.sogou.com");

	lr_think_time(6);

	web_custom_request("token", 
		"URL=http://127.0.0.1:9528/dev-api/git-auth/oauth/token?account=admin&password=123456&grant_type=password&scope=all&type=account&deptId=01000", 
		"Method=POST", 
		"Resource=0", 
		"RecContentType=application/json", 
		"Referer=http://127.0.0.1:9528/", 
		"Snapshot=t8.inf", 
		"Mode=HTML", 
		"EncType=", 
		EXTRARES, 
		"Url=http://config.push.sogou.com/config/pushserver.do?conn-type=array&udid=7ECF564122FC186A3C4FC2D561C3B41E&appid=4000", "Referer=", ENDITEM, 
		LAST);

	web_add_cookie("IMEVER=8.5.0.1183; DOMAIN=dralot.ie.sogou.com");

	web_add_cookie("YYID=7ECF564122FC186A3C4FC2D561C3B41E; DOMAIN=dralot.ie.sogou.com");

	web_add_cookie("SMYUV=1583581077639800; DOMAIN=dralot.ie.sogou.com");

	web_add_cookie("QIDIANID=p7C0OD8RPST7NB245ehyDXgGZVgMnAbtUZCbHRefZrCQ2uraLlVYvdVls/lyIPaRDTpqAROwylfuYQuS1r2eFg==; DOMAIN=dralot.ie.sogou.com");

	web_add_cookie("SUV=00EF753BAB51E25C5E5B0FBCBA581727; DOMAIN=dralot.ie.sogou.com");

	web_add_cookie("usid=WHNFd5Y14tfbGbCs; DOMAIN=dralot.ie.sogou.com");

	web_add_cookie("SUID=0FE251ABAE32A00A000000005E638B0C; DOMAIN=dralot.ie.sogou.com");

	web_add_cookie("IPLOC=CN4200; DOMAIN=dralot.ie.sogou.com");

	web_add_cookie("SNUID=4BF549B3171DB8FAE6BC5D3A187E3754; DOMAIN=dralot.ie.sogou.com");

	web_add_cookie("CXID=EAF0F91EE2276FC6E4C711C491F4D9B9; DOMAIN=dralot.ie.sogou.com");

	web_add_cookie("ad=blllllllll2WbeVklllllVis9Qllllll$C4Pjyllll9lllll9Vxlw@@@@@@@@@@@; DOMAIN=dralot.ie.sogou.com");

	web_add_cookie("ld=6lllllllll2WzLZClllllVisJDYlllll$C4AcZllllwlllll9llll5@@@@@@@@@@; DOMAIN=dralot.ie.sogou.com");

	web_custom_request("feedback", 
		"URL=http://dralot.ie.sogou.com/feedback", 
		"Method=POST", 
		"Resource=0", 
		"RecContentType=text/plain", 
		"Referer=", 
		"Snapshot=t9.inf", 
		"Mode=HTML", 
		"Body={\"cmd\":\"dralotStatus\",\"data\":\"\",\"hid\":\"7ECF564122FC186A3C4FC2D561C3B41E\",\"version\":1}", 
		LAST);

	web_submit_data("coll", 
		"Action=http://dralot.ie.sogou.com/coll", 
		"Method=POST", 
		"RecContentType=text/plain", 
		"Referer=", 
		"Mode=HTML", 
		ITEMDATA, 
		"Name=h", "Value=7ECF564122FC186A3C4FC2D561C3B41E", ENDITEM, 
		"Name=r", "Value=0000", ENDITEM, 
		"Name=v", "Value=8.6.1.31812", ENDITEM, 
		"Name=cid", "Value=b9aebb212fdc48e643bcaea597920d89", ENDITEM, 
		LAST);

	web_custom_request("favor", 
		"URL=http://dralot.ie.sogou.com/actor/favor", 
		"Method=POST", 
		"Resource=0", 
		"RecContentType=text/plain", 
		"Referer=", 
		"Snapshot=t10.inf", 
		"Mode=HTML", 
		"Body={\"cmd\":\"status\",\"hid\":\"7ECF564122FC186A3C4FC2D561C3B41E\"}", 
		LAST);

	web_add_cookie("x-access-token="
		"eyJ0eXAiOiJKc29uV2ViVG9rZW4iLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJpc3N1c2VyIiwiYXVkIjoiYXVkaWVuY2UiLCJ0ZW5hbnRfaWQiOiIwMDAwMDAiLCJyb2xlX25hbWUiOiJhZG1pbmlzdHJhdG9yIiwidXNlcl9pZCI6IjExMjM1OTg4MjE3Mzg2NzUyMDEiLCJyb2xlX2lkIjoiMTEyMzU5ODgxNjczODY3NTIwMSIsInVzZXJfbmFtZSI6ImFkbWluIiwibmlja19uYW1lIjoi566h55CG5ZGYIiwidG9rZW5fdHlwZSI6ImFjY2Vzc190b2tlbiIsImRlcHRfaWQiOiIwMTAwMCIsImFjY291bnQiOiJhZG1pbiIsImNsaWVudF9pZCI6InNhYmVyIiwiZXhwIjoxNTg0MzY1NTQ4LCJuYmYiOjE1ODQzNjE5NDh9.9DaAaG4qSdU9mU-o8oTaPtzYNUV2sHXJAcEAKr0M"
		"9FQ; DOMAIN=127.0.0.1");

	web_add_cookie("x-refresh-token=eyJ0eXAiOiJKc29uV2ViVG9rZW4iLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJpc3N1c2VyIiwiYXVkIjoiYXVkaWVuY2UiLCJ1c2VyX2lkIjoiMTEyMzU5ODgyMTczODY3NTIwMSIsInRva2VuX3R5cGUiOiJyZWZyZXNoX3Rva2VuIiwiY2xpZW50X2lkIjoic2FiZXIiLCJleHAiOjE1ODQ5NjY3NDgsIm5iZiI6MTU4NDM2MTk0OH0.s-MIY-SiCHi69yvm0JH6j2rrzOD6Xyht_-dW7DQR3Sk; DOMAIN=127.0.0.1");

	web_custom_request("info", 
		"URL=http://127.0.0.1:9528/dev-api/git-user/info", 
		"Method=POST", 
		"Resource=0", 
		"RecContentType=application/json", 
		"Referer=http://127.0.0.1:9528/", 
		"Snapshot=t11.inf", 
		"Mode=HTML", 
		"EncType=", 
		LAST);

	web_custom_request("info_2", 
		"URL=http://127.0.0.1:9528/dev-api/git-user/info", 
		"Method=POST", 
		"Resource=0", 
		"RecContentType=application/json", 
		"Referer=http://127.0.0.1:9528/", 
		"Snapshot=t12.inf", 
		"Mode=HTML", 
		"EncType=", 
		LAST);

	web_custom_request("info_3", 
		"URL=http://127.0.0.1:9528/dev-api/git-user/info", 
		"Method=POST", 
		"Resource=0", 
		"RecContentType=application/json", 
		"Referer=http://127.0.0.1:9528/", 
		"Snapshot=t13.inf", 
		"Mode=HTML", 
		"EncType=", 
		LAST);

	web_custom_request("depts_2", 
		"URL=http://127.0.0.1:9528/dev-api/git-auth/oauth/depts?account=admin", 
		"Method=POST", 
		"Resource=0", 
		"RecContentType=application/json", 
		"Referer=http://127.0.0.1:9528/", 
		"Snapshot=t14.inf", 
		"Mode=HTML", 
		"EncType=", 
		LAST);

	return 0;
}
