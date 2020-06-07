# 1 "d:\\\323\303\273\247\304\277\302\274\\desktop\\aaa\\\321\271\301\246\262\342\312\324\\\275\305\261\276\\20200317\270\264\326\306\\20200316\\\\combined_20200316.c"
# 1 "E:\\anzhuang\\LoadRunner\\include/lrun.h" 1
 
 












 











# 103 "E:\\anzhuang\\LoadRunner\\include/lrun.h"








































































	

 


















 
 
 
 
 


 
 
 
 
 
 














int     lr_start_transaction   (char * transaction_name);
int lr_start_sub_transaction          (char * transaction_name, char * trans_parent);
long lr_start_transaction_instance    (char * transaction_name, long parent_handle);



int     lr_end_transaction     (char * transaction_name, int status);
int lr_end_sub_transaction            (char * transaction_name, int status);
int lr_end_transaction_instance       (long transaction, int status);


 
typedef char* lr_uuid_t;
 



lr_uuid_t lr_generate_uuid();

 


int lr_generate_uuid_free(lr_uuid_t uuid);

 



int lr_generate_uuid_on_buf(lr_uuid_t buf);

   
# 263 "E:\\anzhuang\\LoadRunner\\include/lrun.h"
int lr_start_distributed_transaction  (char * transaction_name, lr_uuid_t correlator, long timeout  );

   







int lr_end_distributed_transaction  (lr_uuid_t correlator, int status);


double lr_stop_transaction            (char * transaction_name);
double lr_stop_transaction_instance   (long parent_handle);


void lr_resume_transaction           (char * trans_name);
void lr_resume_transaction_instance  (long trans_handle);


int lr_update_transaction            (const char *trans_name);


 
void lr_wasted_time(long time);


 
int lr_set_transaction(const char *name, double duration, int status);
 
long lr_set_transaction_instance(const char *name, double duration, int status, long parent_handle);


int   lr_user_data_point                      (char *, double);
long lr_user_data_point_instance                   (char *, double, long);
 



int lr_user_data_point_ex(const char *dp_name, double value, int log_flag);
long lr_user_data_point_instance_ex(const char *dp_name, double value, long parent_handle, int log_flag);


int lr_transaction_add_info      (const char *trans_name, char *info);
int lr_transaction_instance_add_info   (long trans_handle, char *info);
int lr_dpoint_add_info           (const char *dpoint_name, char *info);
int lr_dpoint_instance_add_info        (long dpoint_handle, char *info);


double lr_get_transaction_duration       (char * trans_name);
double lr_get_trans_instance_duration    (long trans_handle);
double lr_get_transaction_think_time     (char * trans_name);
double lr_get_trans_instance_think_time  (long trans_handle);
double lr_get_transaction_wasted_time    (char * trans_name);
double lr_get_trans_instance_wasted_time (long trans_handle);
int    lr_get_transaction_status		 (char * trans_name);
int	   lr_get_trans_instance_status		 (long trans_handle);

 



int lr_set_transaction_status(int status);

 



int lr_set_transaction_status_by_name(int status, const char *trans_name);
int lr_set_transaction_instance_status(int status, long trans_handle);


typedef void* merc_timer_handle_t;
 

merc_timer_handle_t lr_start_timer();
double lr_end_timer(merc_timer_handle_t timer_handle);


 
 
 
 
 
 











 



int   lr_rendezvous  (char * rendezvous_name);
 




int   lr_rendezvous_ex (char * rendezvous_name);



 
 
 
 
 
char *lr_get_vuser_ip (void);
void   lr_whoami (int *vuser_id, char ** sgroup, int *scid);
char *	  lr_get_host_name (void);
char *	  lr_get_master_host_name (void);

 
long     lr_get_attrib_long	(char * attr_name);
char *   lr_get_attrib_string	(char * attr_name);
double   lr_get_attrib_double      (char * attr_name);

char * lr_paramarr_idx(const char * paramArrayName, unsigned int index);
char * lr_paramarr_random(const char * paramArrayName);
int    lr_paramarr_len(const char * paramArrayName);

int	lr_param_unique(const char * paramName);
int lr_param_sprintf(const char * paramName, const char * format, ...);


 
 
static void *ci_this_context = 0;






 








void lr_continue_on_error (int lr_continue);
char *   lr_decrypt (const char *EncodedString);


 
 
 
 
 
 



 







 















void   lr_abort (void);
void lr_exit(int exit_option, int exit_status);
void lr_abort_ex (unsigned long flags);

void   lr_peek_events (void);


 
 
 
 
 


void   lr_think_time (double secs);

 


void lr_force_think_time (double secs);


 
 
 
 
 



















int   lr_msg (char * fmt, ...);
int   lr_debug_message (unsigned int msg_class,
									    char * format,
										...);
# 502 "E:\\anzhuang\\LoadRunner\\include/lrun.h"
void   lr_new_prefix (int type,
                                 char * filename,
                                 int line);
# 505 "E:\\anzhuang\\LoadRunner\\include/lrun.h"
int   lr_log_message (char * fmt, ...);
int   lr_message (char * fmt, ...);
int   lr_error_message (char * fmt, ...);
int   lr_output_message (char * fmt, ...);
int   lr_vuser_status_message (char * fmt, ...);
int   lr_error_message_without_fileline (char * fmt, ...);
int   lr_fail_trans_with_error (char * fmt, ...);

 
 
 
 
 
# 528 "E:\\anzhuang\\LoadRunner\\include/lrun.h"

 
 
 
 
 





int   lr_next_row ( char * table);
int lr_advance_param ( char * param);



														  
														  

														  
														  

													      
 


char *   lr_eval_string (char * str);
int   lr_eval_string_ext (const char *in_str,
                                     unsigned long const in_len,
                                     char ** const out_str,
                                     unsigned long * const out_len,
                                     unsigned long const options,
                                     const char *file,
								     long const line);
# 562 "E:\\anzhuang\\LoadRunner\\include/lrun.h"
void   lr_eval_string_ext_free (char * * pstr);

 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
int lr_param_increment (char * dst_name,
                              char * src_name);
# 585 "E:\\anzhuang\\LoadRunner\\include/lrun.h"













											  
											  

											  
											  
											  

int	  lr_save_var (char *              param_val,
							  unsigned long const param_val_len,
							  unsigned long const options,
							  char *			  param_name);
# 609 "E:\\anzhuang\\LoadRunner\\include/lrun.h"
int   lr_save_string (const char * param_val, const char * param_name);
int   lr_free_parameter (const char * param_name);
int   lr_save_int (const int param_val, const char * param_name);


 
 
 
 
 
 
# 676 "E:\\anzhuang\\LoadRunner\\include/lrun.h"
void   lr_save_datetime (const char *format, int offset, const char *name);









 











 
 
 
 
 






 



char * lr_error_context_get_entry (char * key);

 



long   lr_error_context_get_error_id (void);


 
 
 

int lr_table_get_rows_num (char * param_name);

int lr_table_get_cols_num (char * param_name);

char * lr_table_get_cell_by_col_index (char * param_name, int row, int col);

char * lr_table_get_cell_by_col_name (char * param_name, int row, const char* col_name);

int lr_table_get_column_name_by_index (char * param_name, int col, 
											char * * const col_name,
											int * col_name_len);
# 737 "E:\\anzhuang\\LoadRunner\\include/lrun.h"

int lr_table_get_column_name_by_index_free (char * col_name);


 
 
 
 
 
 
 
 

 
 
 
 
 
 
int   lr_param_substit (char * file,
                                   int const line,
                                   char * in_str,
                                   int const in_len,
                                   char * * const out_str,
                                   int * const out_len);
# 762 "E:\\anzhuang\\LoadRunner\\include/lrun.h"
void   lr_param_substit_free (char * * pstr);


 
# 774 "E:\\anzhuang\\LoadRunner\\include/lrun.h"





char *   lrfnc_eval_string (char * str,
                                      char * file_name,
                                      long const line_num);
# 782 "E:\\anzhuang\\LoadRunner\\include/lrun.h"


int   lrfnc_save_string ( const char * param_val,
                                     const char * param_name,
                                     const char * file_name,
                                     long const line_num);
# 788 "E:\\anzhuang\\LoadRunner\\include/lrun.h"

int   lrfnc_free_parameter (const char * param_name );

int lr_save_searched_string(char *buffer, long buf_size, unsigned int occurrence,
			    char *search_string, int offset, unsigned int param_val_len, 
			    char *param_name);

 
char *   lr_string (char * str);

 
# 859 "E:\\anzhuang\\LoadRunner\\include/lrun.h"

int   lr_save_value (char * param_val,
                                unsigned long const param_val_len,
                                unsigned long const options,
                                char * param_name,
                                char * file_name,
                                long const line_num);
# 866 "E:\\anzhuang\\LoadRunner\\include/lrun.h"


 
 
 
 
 











int   lr_printf (char * fmt, ...);
 
int   lr_set_debug_message (unsigned int msg_class,
                                       unsigned int swtch);
# 888 "E:\\anzhuang\\LoadRunner\\include/lrun.h"
unsigned int   lr_get_debug_message (void);


 
 
 
 
 

void   lr_double_think_time ( double secs);
void   lr_usleep (long);


 
 
 
 
 
 




int *   lr_localtime (long offset);


int   lr_send_port (long port);


# 964 "E:\\anzhuang\\LoadRunner\\include/lrun.h"



struct _lr_declare_identifier{
	char signature[24];
	char value[128];
};

int   lr_pt_abort (void);

void vuser_declaration (void);






# 993 "E:\\anzhuang\\LoadRunner\\include/lrun.h"


# 1005 "E:\\anzhuang\\LoadRunner\\include/lrun.h"
















 
 
 
 
 







int    _lr_declare_transaction   (char * transaction_name);


 
 
 
 
 







int   _lr_declare_rendezvous  (char * rendezvous_name);

 
 
 
 
 

 
int lr_enable_ip_spoofing();
int lr_disable_ip_spoofing();


 




int lr_convert_string_encoding(char *sourceString, char *fromEncoding, char *toEncoding, char *paramName);





 
 

















# 1 "d:\\\323\303\273\247\304\277\302\274\\desktop\\aaa\\\321\271\301\246\262\342\312\324\\\275\305\261\276\\20200317\270\264\326\306\\20200316\\\\combined_20200316.c" 2

# 1 "globals.h" 1



 
 

# 1 "E:\\anzhuang\\LoadRunner\\include/web_api.h" 1
 







# 1 "E:\\anzhuang\\LoadRunner\\include/as_web.h" 1
 






















































 




 








 
 
 

  int
	web_add_filter(
		const char *		mpszArg,
		...
	);									 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 

  int
	web_add_auto_filter(
		const char *		mpszArg,
		...
	);									 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
	
  int
	web_add_auto_header(
		const char *		mpszHeader,
		const char *		mpszValue);

  int
	web_add_header(
		const char *		mpszHeader,
		const char *		mpszValue);
  int
	web_add_cookie(
		const char *		mpszCookie);
  int
	web_cleanup_auto_headers(void);
  int
	web_cleanup_cookies(void);
  int
	web_concurrent_end(
		const char * const	mpszReserved,
										 
		...								 
	);
  int
	web_concurrent_start(
		const char * const	mpszConcurrentGroupName,
										 
										 
		...								 
										 
	);
  int
	web_create_html_param(
		const char *		mpszParamName,
		const char *		mpszLeftDelim,
		const char *		mpszRightDelim);
  int
	web_create_html_param_ex(
		const char *		mpszParamName,
		const char *		mpszLeftDelim,
		const char *		mpszRightDelim,
		const char *		mpszNum);
  int
	web_custom_request(
		const char *		mpszReqestName,
		...);							 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
  int
	web_disable_keep_alive(void);
  int
	web_enable_keep_alive(void);
  int
	web_find(
		const char *		mpszStepName,
		...);							 
										 
										 
										 
										 
										 
										 
										 
										 
										 
  int
	web_get_int_property(
		const int			miHttpInfoType);
  int
	web_image(
		const char *		mpszStepName,
		...);							 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
  int
	web_image_check(
		const char *		mpszName,
		...);
  int
	web_java_check(
		const char *		mpszName,
		...);
  int
	web_link(
		const char *		mpszStepName,
		...);							 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 

	
  int
	web_global_verification(
		const char *		mpszArg1,
		...);							 
										 
										 
										 
										 
										 

  int
	web_reg_find(
		const char *		mpszArg1,
		...);							 
										 
										 
										 
										 
										 
										 
										 
				
  int
	web_reg_save_param(
		const char *		mpszParamName,
		...);							 
										 
										 
										 
										 
										 
										 

  int
	web_convert_param(
		const char * 		mpszParamName, 
										 
		...);							 
										 
										 


										 

										 
  int
	web_remove_auto_filter(
		const char *		mpszArg,
		...
	);									 
										 
				
  int
	web_remove_auto_header(
		const char *		mpszHeaderName,
		...);							 
										 



  int
	web_remove_cookie(
		const char *		mpszCookie);

  int
	web_save_header(
		const char *		mpszType,	 
		const char *		mpszName);	 
  int
	web_set_certificate(
		const char *		mpszIndex);
  int
	web_set_certificate_ex(
		const char *		mpszArg1,
		...);							 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
  int
	web_set_connections_limit(
		const char *		mpszLimit);
  int
	web_set_max_html_param_len(
		const char *		mpszLen);
  int
	web_set_max_retries(
		const char *		mpszMaxRetries);
  int
	web_set_proxy(
		const char *		mpszProxyHost);
  int
	web_set_proxy_bypass(
		const char *		mpszBypass);
  int
	web_set_secure_proxy(
		const char *		mpszProxyHost);
  int
	web_set_sockets_option(
		const char *		mpszOptionID,
		const char *		mpszOptionValue
	);
  int
	web_set_option(
		const char *		mpszOptionID,
		const char *		mpszOptionValue,
		...								 
	);
  int
	web_set_timeout(
		const char *		mpszWhat,
		const char *		mpszTimeout);
  int
	web_set_user(
		const char *		mpszUserName,
		const char *		mpszPwd,
		const char *		mpszHost);

  int
	web_sjis_to_euc_param(
		const char *		mpszParamName,
										 
		const char *		mpszParamValSjis);
										 

  int
	web_submit_data(
		const char *		mpszStepName,
		...);							 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
  int
	web_submit_form(
		const char *		mpszStepName,
		...);							 
										 
										 
										 
										 
										 
										 
										 
										 
										  
										 
										 
										 
										 
										 
										  
										 
										 
										 
										 
										 
										 
										 
										  
										 
										 
										 
										 
										 
										  
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
  int
	web_url(
		const char *		mpszUrlName,
		...);							 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 

  int 
	web_set_proxy_bypass_local(
		const char * mpszNoLocal
		);

  int 
	web_cache_cleanup(void);

  int
	web_create_html_query(
		const char* mpszStartQuery,
		...);							 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 

  int 
	web_create_radio_button_param(
		const char *NameFiled,
		const char *NameAndVal,
		const char *ParamName
		);

  int
	web_convert_from_formatted(
		const char * mpszArg1,
		...);							 
										 
										 
										 
										 
										 
										
  int
	web_convert_to_formatted(
		const char * mpszArg1,
		...);							 
										 
										 
										 
										 
										 

  int
	web_reg_save_param_ex(
		const char * mpszParamName,
		...);							 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 

  int
	web_reg_save_param_xpath(
		const char * mpszParamName,
		...);							
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 
										 










# 596 "E:\\anzhuang\\LoadRunner\\include/as_web.h"


# 609 "E:\\anzhuang\\LoadRunner\\include/as_web.h"



























# 647 "E:\\anzhuang\\LoadRunner\\include/as_web.h"

 
 
 


  int
	FormSubmit(
		const char *		mpszFormName,
		...);
  int
	InitWebVuser(void);
  int
	SetUser(
		const char *		mpszUserName,
		const char *		mpszPwd,
		const char *		mpszHost);
  int
	TerminateWebVuser(void);
  int
	URL(
		const char *		mpszUrlName);
























# 715 "E:\\anzhuang\\LoadRunner\\include/as_web.h"



 
 
 






# 10 "E:\\anzhuang\\LoadRunner\\include/web_api.h" 2












 






 











  int
	web_reg_add_cookie(
		const char *		mpszCookie,
		...);							 
										 

  int
	web_report_data_point(
		const char *		mpszEventType,
		const char *		mpszEventName,
		const char *		mpszDataPointName,
		const char *		mpszLAST);	 
										 
										 
										 

  int
	web_text_link(
		const char *		mpszStepName,
		...);

  int
	web_element(
		const char *		mpszStepName,
		...);

  int
	web_image_link(
		const char *		mpszStepName,
		...);

  int
	web_static_image(
		const char *		mpszStepName,
		...);

  int
	web_image_submit(
		const char *		mpszStepName,
		...);

  int
	web_button(
		const char *		mpszStepName,
		...);

  int
	web_edit_field(
		const char *		mpszStepName,
		...);

  int
	web_radio_group(
		const char *		mpszStepName,
		...);

  int
	web_check_box(
		const char *		mpszStepName,
		...);

  int
	web_list(
		const char *		mpszStepName,
		...);

  int
	web_text_area(
		const char *		mpszStepName,
		...);

  int
	web_map_area(
		const char *		mpszStepName,
		...);

  int
	web_eval_java_script(
		const char *		mpszStepName,
		...);

  int
	web_reg_dialog(
		const char *		mpszArg1,
		...);

  int
	web_reg_cross_step_download(
		const char *		mpszArg1,
		...);

  int
	web_browser(
		const char *		mpszStepName,
		...);

  int
	web_control(
		const char *		mpszStepName,
		...);

  int
	web_set_rts_key(
		const char *		mpszArg1,
		...);

  int
	web_save_param_length(
		const char * 		mpszParamName,
		...);

  int
	web_save_timestamp_param(
		const char * 		mpszParamName,
		...);

  int
	web_load_cache(
		const char *		mpszStepName,
		...);							 
										 

  int
	web_dump_cache(
		const char *		mpszStepName,
		...);							 
										 
										 

  int
	web_reg_find_in_log(
		const char *		mpszArg1,
		...);							 
										 
										 

  int
	web_get_sockets_info(
		const char *		mpszArg1,
		...);							 
										 
										 
										 
										 

  int
	web_add_cookie_ex(
		const char *		mpszArg1,
		...);							 
										 
										 
										 

  int
	web_hook_java_script(
		const char *		mpszArg1,
		...);							 
										 
										 
										 





 
 
 


# 7 "globals.h" 2

# 1 "E:\\anzhuang\\LoadRunner\\include/lrw_custom_body.h" 1
 





# 8 "globals.h" 2



 
 


# 2 "d:\\\323\303\273\247\304\277\302\274\\desktop\\aaa\\\321\271\301\246\262\342\312\324\\\275\305\261\276\\20200317\270\264\326\306\\20200316\\\\combined_20200316.c" 2

# 1 "vuser_init.c" 1
 







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
		"LAST");

	web_url("127.0.0.1:9528_2", 
		"URL=http://127.0.0.1:9528/", 
		"Resource=0", 
		"Referer=", 
		"Mode=HTML", 
		"EXTRARES", 
		"Url=/app.js", "ENDITEM", 
		"Url=/static/img/login_big1.3eb485a7.jpg", "ENDITEM", 
		"Url=/static/fonts/element-icons.535877f5.woff", "ENDITEM", 
		"Url=/static/img/login_left2.e886d96e.png", "ENDITEM", 
		"Url=/static/img/login_right.a0f85c66.png", "ENDITEM", 
		"Url=http://192.168.43.81:9528/sockjs-node/info?t=1584361917974", "ENDITEM", 
		"Url=http://localhost:9528/sockjs-node/info?t=1584361917972", "ENDITEM", 
		"Url=/favicon.ico", "Referer=", "ENDITEM", 
		"Url=/dev-api/git-system/menu/routes?r=1584361953973", "ENDITEM", 
		"Url=/img/bg/logobg.jpg", "ENDITEM", 
		"Url=/dev-api/git-system/menu/buttons?r=1584361954432", "ENDITEM", 
		"Url=/dev-api/git-system/sysdate/workDateTime?r=1584361955574", "ENDITEM", 
		"Url=/dev-api/git-system/menu/top-menu?r=1584361955574", "ENDITEM", 
		"Url=/dev-api/git-desk/notice/page?createDept=01000&current=1&size=999&r=1584361956944", "ENDITEM", 
		"Url=/dev-api/git-chart/org-chart/getStatisOrg?orgNum=01000&r=1584361956944", "ENDITEM", 
		"Url=/dev-api/git-rcm/ledger/home?useOrgNum=16200&r=1584361956944", "ENDITEM", 
		"LAST");

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
		"LAST");



	lr_think_time(4);



	lr_think_time(6);



	web_custom_request("depts", 
		"URL=http://127.0.0.1:9528/dev-api/git-auth/oauth/depts?account={username}", 
		"Method=POST", 
		"Resource=0", 
		"RecContentType=application/json", 
		"Referer=http://127.0.0.1:9528/", 
		"Snapshot=t7.inf", 
		"Mode=HTML", 
		"EncType=", 
		"LAST");

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
		"URL=http://127.0.0.1:9528/dev-api/git-auth/oauth/token?account={username}&password={password}&grant_type=password&scope=all&type=account&deptId=01000", 
		"Method=POST", 
		"Resource=0", 
		"RecContentType=application/json", 
		"Referer=http://127.0.0.1:9528/", 
		"Snapshot=t8.inf", 
		"Mode=HTML", 
		"EncType=", 
		"EXTRARES", 
		"Url=http://config.push.sogou.com/config/pushserver.do?conn-type=array&udid=7ECF564122FC186A3C4FC2D561C3B41E&appid=4000", "Referer=", "ENDITEM", 
		"LAST");

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
		"LAST");

	web_submit_data("coll", 
		"Action=http://dralot.ie.sogou.com/coll", 
		"Method=POST", 
		"RecContentType=text/plain", 
		"Referer=", 
		"Mode=HTML", 
		"ITEMDATA", 
		"Name=h", "Value=7ECF564122FC186A3C4FC2D561C3B41E", "ENDITEM", 
		"Name=r", "Value=0000", "ENDITEM", 
		"Name=v", "Value=8.6.1.31812", "ENDITEM", 
		"Name=cid", "Value=b9aebb212fdc48e643bcaea597920d89", "ENDITEM", 
		"LAST");

	web_custom_request("favor", 
		"URL=http://dralot.ie.sogou.com/actor/favor", 
		"Method=POST", 
		"Resource=0", 
		"RecContentType=text/plain", 
		"Referer=", 
		"Snapshot=t10.inf", 
		"Mode=HTML", 
		"Body={\"cmd\":\"status\",\"hid\":\"7ECF564122FC186A3C4FC2D561C3B41E\"}", 
		"LAST");

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
		"LAST");

	web_custom_request("info_2", 
		"URL=http://127.0.0.1:9528/dev-api/git-user/info", 
		"Method=POST", 
		"Resource=0", 
		"RecContentType=application/json", 
		"Referer=http://127.0.0.1:9528/", 
		"Snapshot=t12.inf", 
		"Mode=HTML", 
		"EncType=", 
		"LAST");

	web_custom_request("info_3", 
		"URL=http://127.0.0.1:9528/dev-api/git-user/info", 
		"Method=POST", 
		"Resource=0", 
		"RecContentType=application/json", 
		"Referer=http://127.0.0.1:9528/", 
		"Snapshot=t13.inf", 
		"Mode=HTML", 
		"EncType=", 
		"LAST");

	web_custom_request("depts_2", 
		"URL=http://127.0.0.1:9528/dev-api/git-auth/oauth/depts?account={username}", 
		"Method=POST", 
		"Resource=0", 
		"RecContentType=application/json", 
		"Referer=http://127.0.0.1:9528/", 
		"Snapshot=t14.inf", 
		"Mode=HTML", 
		"EncType=", 
		"LAST");

	return 0;
}
# 3 "d:\\\323\303\273\247\304\277\302\274\\desktop\\aaa\\\321\271\301\246\262\342\312\324\\\275\305\261\276\\20200317\270\264\326\306\\20200316\\\\combined_20200316.c" 2

# 1 "ledger_companyCustomer.c" 1
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
		"EXTRARES", 
		"Url=../git-chart/customer-chart/getCrdListSumPage?current=1&size=10&userNum=&customerName=&orgNum=&certNum=&certType=&customerType=2&r=1584362002373", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"Url=../git-chart/customer-chart/getCrdListSumPage?current=1&size=9999999&userNum=&customerName=&orgNum=&certNum=&certType=&customerType=2&r=1584362002373", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"Url=../git-chart/customer-chart/getCrdListSumPage?current=1&size=10&userNum=&customerName=&orgNum=01000&certNum=&certType=&customerType=2&r=1584362003011", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"Url=../git-chart/customer-chart/getCrdListSumPage?current=1&size=10&userNum=&customerName=%E5%AD%99%E6%82%9F%E7%A9%BA&orgNum=01000&certNum=&certType=&customerType=2&r=1584362021230", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"Url=../git-chart/customer-chart/getCrdListSumPage?current=1&size=10&userNum=&customerName=&orgNum=01000&customerNum=C0011&certNum=&certType=&customerType=2&r=1584362029586", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"LAST");

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
		"EXTRARES", 
		"Url=../git-chart/customer-chart/getCrdListSumPage?current=1&size=10&userNum=&customerName=&orgNum=01000&certNum=&certType=&customerType=2&r=1584362040636", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"Url=../git-chart/customer-chart/getCrdListSumPage?current=1&size=10&userNum=&customerName=&orgNum=01000&certNum=420984199910107000&certType=&customerType=2&r=1584362065001", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"LAST");

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
		"EXTRARES", 
		"Url=../git-chart/customer-chart/getCrdListSumPage?current=1&size=10&userNum=&customerName=&orgNum=01000&certNum=&certType=&customerType=2&r=1584362071705", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"Url=../git-system/dict/dictTranslate?code=org&r=1584362078451", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"LAST");

	web_custom_request("getList", 
		"URL=http://127.0.0.1:9528/dev-api/git-system/dept/getList?current=1&size=10&deptName=&fullName=&orgType=", 
		"Method=POST", 
		"Resource=0", 
		"RecContentType=application/json", 
		"Referer=http://127.0.0.1:9528/", 
		"Snapshot=t18.inf", 
		"Mode=HTML", 
		"EncType=", 
		"LAST");

	web_custom_request("getList_2", 
		"URL=http://127.0.0.1:9528/dev-api/git-system/dept/getList?current=1&size=10&deptName=%E8%B5%A3%E6%98%8C%E5%86%9C%E5%95%86%E9%93%B6%E8%A1%8C&fullName=&orgType=", 
		"Method=POST", 
		"Resource=0", 
		"RecContentType=application/json", 
		"Referer=http://127.0.0.1:9528/", 
		"Snapshot=t19.inf", 
		"Mode=HTML", 
		"EncType=", 
		"EXTRARES", 
		"Url=/dev-api/git-chart/customer-chart/getCrdListSumPage?current=1&size=10&userNum=&customerName=&orgNum=10100&certNum=&certType=&customerType=2&r=1584362093632", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"Url=/dev-api/git-chart/customer-chart/getOrgByCust?customerNum=C0011&r=1584362108463", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"Url=../dict/dictTranslate?code=org&r=1584362108463", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"Url=/dev-api/git-chart/customer-chart/sumCsmCrd?customerNum=C0011&orgNum=01000&r=1584362110740", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"Url=/dev-api/git-chart/customer-chart/listCrdDetail?customerNum=C0011&orgNum=01000&r=1584362110740", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"LAST");

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
		"EXTRARES", 
		"Url=../git-chart/customer-chart/getCrdListSumPage?current=1&size=10&userNum=&customerName=&orgNum=&certNum=&certType=&customerType=2&r=1584362123111", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"Url=../git-chart/customer-chart/getCrdListSumPage?current=1&size=9999999&userNum=&customerName=&orgNum=&certNum=&certType=&customerType=2&r=1584362123111", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"Url=../git-chart/customer-chart/getCrdListSumPage?current=1&size=10&userNum=&customerName=&orgNum=01000&certNum=&certType=&customerType=2&r=1584362123533", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"Url=../git-csm/csmcorporation/getCsmCorporationPageByCusNum?customerNum=C0011&r=1584362129715", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"Url=../git-csm/csmaddressinfo/page?current=1&size=5&customerNum=C0011&r=1584362129715", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"Url=../git-csm/csmrelation/page?current=1&size=5&customerNum=C0011&r=1584362129715", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"Url=../git-csm/csmmanageteam/getCsmManageTeamPageByCusNum?current=1&size=5&customerNum=C0011&r=1584362129715", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"LAST");

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
		"EXTRARES", 
		"Url=../git-chart/customer-chart/getCrdListSumPage?current=1&size=10&userNum=&customerName=&orgNum=&certNum=&certType=&customerType=2&r=1584362136727", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"Url=../git-chart/customer-chart/getCrdListSumPage?current=1&size=9999999&userNum=&customerName=&orgNum=&certNum=&certType=&customerType=2&r=1584362136727", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"Url=../git-chart/customer-chart/getCrdListSumPage?current=1&size=10&userNum=&customerName=&orgNum=01000&certNum=&certType=&customerType=2&r=1584362137117", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"LAST");

	return 0;
}
# 4 "d:\\\323\303\273\247\304\277\302\274\\desktop\\aaa\\\321\271\301\246\262\342\312\324\\\275\305\261\276\\20200317\270\264\326\306\\20200316\\\\combined_20200316.c" 2

# 1 "ledger_individualCustomer.c" 1
ledger_individualCustomer()
{

	lr_think_time(21);

	web_url("getCrdListSumPage", 
		"URL=http://127.0.0.1:9528/dev-api/git-chart/customer-chart/getCrdListSumPage?current=1&size=10&userNum=&customerName=&orgNum=&certNum=&certType=&customerType=1&r=1584362159615", 
		"Resource=1", 
		"RecContentType=application/json", 
		"Referer=http://127.0.0.1:9528/", 
		"Snapshot=t22.inf", 
		"LAST");

	web_custom_request("info_9", 
		"URL=http://127.0.0.1:9528/dev-api/git-user/info", 
		"Method=POST", 
		"Resource=0", 
		"RecContentType=application/json", 
		"Referer=http://127.0.0.1:9528/", 
		"Snapshot=t23.inf", 
		"Mode=HTML", 
		"EncType=", 
		"EXTRARES", 
		"Url=../git-chart/customer-chart/getCrdListSumPage?current=1&size=99999999&userNum=&customerName=&orgNum=&certNum=&certType=&customerType=1&r=1584362159615", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"Url=../git-chart/customer-chart/getCrdListSumPage?current=1&size=10&userNum=&customerName=&orgNum=01000&certNum=&certType=&customerType=1&r=1584362160500", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"Url=../git-chart/customer-chart/getCrdListSumPage?current=1&size=10&userNum=&customerName=%E9%99%86%E5%B0%8F%E5%87%A4&orgNum=01000&certNum=&certType=&customerType=1&r=1584362170564", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"LAST");

	web_custom_request("info_10", 
		"URL=http://127.0.0.1:9528/dev-api/git-user/info", 
		"Method=POST", 
		"Resource=0", 
		"RecContentType=application/json", 
		"Referer=http://127.0.0.1:9528/", 
		"Snapshot=t24.inf", 
		"Mode=HTML", 
		"EncType=", 
		"EXTRARES", 
		"Url=../git-chart/customer-chart/getCrdListSumPage?current=1&size=10&userNum=&customerName=&orgNum=01000&certNum=&certType=&customerType=1&r=1584362175731", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"LAST");

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
		"EXTRARES", 
		"Url=../git-chart/customer-chart/getCrdListSumPage?current=1&size=10&userNum=&customerName=&orgNum=01000&certNum=&certType=&customerType=1&r=1584362196579", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"Url=../git-chart/customer-chart/getCrdListSumPage?current=1&size=10&userNum=&customerName=&orgNum=01000&certNum=420984199910103300&certType=&customerType=1&r=1584362207317", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"LAST");

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
		"EXTRARES", 
		"Url=../git-system/dict/dictTranslate?code=org&r=1584362214698", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"LAST");

	web_custom_request("getList_3", 
		"URL=http://127.0.0.1:9528/dev-api/git-system/dept/getList?current=1&size=10&deptName=&fullName=&orgType=", 
		"Method=POST", 
		"Resource=0", 
		"RecContentType=application/json", 
		"Referer=http://127.0.0.1:9528/", 
		"Snapshot=t27.inf", 
		"Mode=HTML", 
		"EncType=", 
		"EXTRARES", 
		"Url=/dev-api/git-chart/customer-chart/getCrdListSumPage?current=1&size=10&userNum=&customerName=&orgNum=01000&certNum=&certType=&customerType=1&r=1584362214931", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"LAST");

	web_custom_request("getList_4", 
		"URL=http://127.0.0.1:9528/dev-api/git-system/dept/getList?current=1&size=10&deptName=%E6%96%B0%E5%BB%BA%E5%86%9C%E5%95%86%E9%93%B6%E8%A1%8C&fullName=&orgType=", 
		"Method=POST", 
		"Resource=0", 
		"RecContentType=application/json", 
		"Referer=http://127.0.0.1:9528/", 
		"Snapshot=t28.inf", 
		"Mode=HTML", 
		"EncType=", 
		"EXTRARES", 
		"Url=/dev-api/git-chart/customer-chart/getCrdListSumPage?current=1&size=10&userNum=&customerName=&orgNum=10200&certNum=&certType=&customerType=1&r=1584362225064", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"LAST");

	web_custom_request("info_13", 
		"URL=http://127.0.0.1:9528/dev-api/git-user/info", 
		"Method=POST", 
		"Resource=0", 
		"RecContentType=application/json", 
		"Referer=http://127.0.0.1:9528/", 
		"Snapshot=t29.inf", 
		"Mode=HTML", 
		"EncType=", 
		"EXTRARES", 
		"Url=../git-chart/customer-chart/getCrdListSumPage?current=1&size=10&userNum=&customerName=&orgNum=01000&certNum=&certType=&customerType=1&r=1584362229385", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"Url=../git-system/dict/dictTranslate?code=org&r=1584362240844", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"Url=../git-chart/customer-chart/getOrgByCust?customerNum=C0016&r=1584362240844", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"Url=../git-chart/customer-chart/sumCsmCrd?customerNum=C0016&orgNum=01000&r=1584362242906", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"Url=../git-chart/customer-chart/listCrdDetail?customerNum=C0016&orgNum=01000&r=1584362242906", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"Url=../git-chart/customer-chart/getCrdListSumPage?current=1&size=10&userNum=&customerName=&orgNum=&certNum=&certType=&customerType=1&r=1584362248048", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"LAST");

	web_custom_request("info_14", 
		"URL=http://127.0.0.1:9528/dev-api/git-user/info", 
		"Method=POST", 
		"Resource=0", 
		"RecContentType=application/json", 
		"Referer=http://127.0.0.1:9528/", 
		"Snapshot=t30.inf", 
		"Mode=HTML", 
		"EncType=", 
		"EXTRARES", 
		"Url=../git-chart/customer-chart/getCrdListSumPage?current=1&size=99999999&userNum=&customerName=&orgNum=&certNum=&certType=&customerType=1&r=1584362248048", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"Url=../git-chart/customer-chart/getCrdListSumPage?current=1&size=10&userNum=&customerName=&orgNum=01000&certNum=&certType=&customerType=1&r=1584362248847", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"Url=../git-csm/csmindividual/getCsmIndividualPageByCustNum?customerNum=C0016&r=1584362252783", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"Url=../git-csm/csmaddressinfo/page?current=1&size=5&customerNum=C0016&r=1584362252783", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"Url=../git-csm/csmrelation/page?current=1&size=5&customerNum=C0016&r=1584362252783", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"Url=../git-csm/csmmanageteam/getCsmManageTeamPageByCusNum?current=1&size=5&customerNum=C0016&r=1584362252783", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"LAST");

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
		"EXTRARES", 
		"Url=../git-chart/customer-chart/getCrdListSumPage?current=1&size=10&userNum=&customerName=&orgNum=&certNum=&certType=&customerType=1&r=1584362258050", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"Url=../git-chart/customer-chart/getCrdListSumPage?current=1&size=99999999&userNum=&customerName=&orgNum=&certNum=&certType=&customerType=1&r=1584362258050", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"Url=../git-chart/customer-chart/getCrdListSumPage?current=1&size=10&userNum=&customerName=&orgNum=01000&certNum=&certType=&customerType=1&r=1584362258382", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"LAST");

	return 0;
}
# 5 "d:\\\323\303\273\247\304\277\302\274\\desktop\\aaa\\\321\271\301\246\262\342\312\324\\\275\305\261\276\\20200317\270\264\326\306\\20200316\\\\combined_20200316.c" 2

# 1 "ledger_interbankCustomer.c" 1
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
		"EXTRARES", 
		"Url=../git-chart/customer-chart/getCrdListSumPage?current=1&size=10&userNum=&customerName=&orgNum=&certNum=&certType=&customerType=3&r=1584362283340", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"Url=../git-chart/customer-chart/getCrdListSumPage?current=1&size=99999999&userNum=&customerName=&orgNum=&certNum=&certType=&customerType=3&r=1584362283340", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"Url=../git-chart/customer-chart/getCrdListSumPage?current=1&size=10&userNum=&customerName=&orgNum=01000&certNum=&certType=&customerType=3&r=1584362283732", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"Url=../git-chart/customer-chart/getCrdListSumPage?current=1&size=10&userNum=&customerName=%E5%B7%A8%E4%BA%BA&orgNum=01000&certNum=&certType=&customerType=3&r=1584362301114", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"LAST");

	web_custom_request("info_17", 
		"URL=http://127.0.0.1:9528/dev-api/git-user/info", 
		"Method=POST", 
		"Resource=0", 
		"RecContentType=application/json", 
		"Referer=http://127.0.0.1:9528/", 
		"Snapshot=t33.inf", 
		"Mode=HTML", 
		"EncType=", 
		"EXTRARES", 
		"Url=../git-chart/customer-chart/getCrdListSumPage?current=1&size=10&userNum=&customerName=&orgNum=01000&certNum=&certType=&customerType=3&r=1584362304479", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"LAST");

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
		"EXTRARES", 
		"Url=../git-chart/customer-chart/getCrdListSumPage?current=1&size=10&userNum=&customerName=&orgNum=01000&certNum=&certType=&customerType=3&r=1584362331725", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"Url=../git-chart/customer-chart/getCrdListSumPage?current=1&size=10&userNum=&customerName=&orgNum=01000&certNum=420984199910103210&certType=&customerType=3&r=1584362347692", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"LAST");

	web_custom_request("info_19", 
		"URL=http://127.0.0.1:9528/dev-api/git-user/info", 
		"Method=POST", 
		"Resource=0", 
		"RecContentType=application/json", 
		"Referer=http://127.0.0.1:9528/", 
		"Snapshot=t35.inf", 
		"Mode=HTML", 
		"EncType=", 
		"EXTRARES", 
		"Url=../git-chart/customer-chart/getCrdListSumPage?current=1&size=10&userNum=&customerName=&orgNum=01000&certNum=&certType=&customerType=3&r=1584362352972", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"Url=../git-system/dict/dictTranslate?code=org&r=1584362363301", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"LAST");

	web_custom_request("getList_5", 
		"URL=http://127.0.0.1:9528/dev-api/git-system/dept/getList?current=1&size=10&deptName=&fullName=&orgType=", 
		"Method=POST", 
		"Resource=0", 
		"RecContentType=application/json", 
		"Referer=http://127.0.0.1:9528/", 
		"Snapshot=t36.inf", 
		"Mode=HTML", 
		"EncType=", 
		"LAST");

	web_custom_request("getList_6", 
		"URL=http://127.0.0.1:9528/dev-api/git-system/dept/getList?current=1&size=10&deptName=%E7%8E%89%E5%B1%B1%E5%86%9C%E5%95%86%E9%93%B6%E8%A1%8C&fullName=&orgType=", 
		"Method=POST", 
		"Resource=0", 
		"RecContentType=application/json", 
		"Referer=http://127.0.0.1:9528/", 
		"Snapshot=t37.inf", 
		"Mode=HTML", 
		"EncType=", 
		"EXTRARES", 
		"Url=/dev-api/git-chart/customer-chart/getCrdListSumPage?current=1&size=10&userNum=&customerName=&orgNum=16200&certNum=&certType=&customerType=3&r=1584362375243", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"LAST");

	web_custom_request("info_20", 
		"URL=http://127.0.0.1:9528/dev-api/git-user/info", 
		"Method=POST", 
		"Resource=0", 
		"RecContentType=application/json", 
		"Referer=http://127.0.0.1:9528/", 
		"Snapshot=t38.inf", 
		"Mode=HTML", 
		"EncType=", 
		"EXTRARES", 
		"Url=../git-chart/customer-chart/getCrdListSumPage?current=1&size=10&userNum=&customerName=&orgNum=01000&certNum=&certType=&customerType=3&r=1584362379498", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"Url=../git-chart/customer-chart/getOrgByCust?customerNum=C002&r=1584362388620", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"Url=../git-chart/ledger-chart/queryLedgerDeatilByOrgType?customerNum=C0027&r=1584362388620", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"Url=../git-chart/ledger-chart/queryLedgerDeatilByOrgTypeThree?customerNum=C0027&crdGrantOrgNum=&r=1584362388620", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"Url=../git-chart/ledger-chart/queryLedgerDeatilByOrgType?customerNum=C008&r=1584362389054", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"Url=../git-chart/ledger-chart/queryLedgerDeatilByOrgTypeThree?customerNum=C008&crdGrantOrgNum=10800&r=1584362389054", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"LAST");

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
		"EXTRARES", 
		"Url=../git-chart/customer-chart/getCrdListSumPage?current=1&size=10&userNum=&customerName=&orgNum=&certNum=&certType=&customerType=3&r=1584362395383", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"Url=../git-chart/customer-chart/getCrdListSumPage?current=1&size=99999999&userNum=&customerName=&orgNum=&certNum=&certType=&customerType=3&r=1584362395383", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"Url=../git-chart/customer-chart/getCrdListSumPage?current=1&size=10&userNum=&customerName=&orgNum=01000&certNum=&certType=&customerType=3&r=1584362395731", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"Url=../git-csm/csmaddressinfo/page?current=1&size=5&customerNum=C0027&r=1584362400102", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"Url=../git-csm/csmcorporation/getCsmCorporationPageByCusNum?customerNum=C0027&r=1584362400102", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"Url=../git-csm/csmrelation/page?current=1&size=5&customerNum=C0027&r=1584362400102", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"Url=../git-csm/csmmanageteam/getCsmManageTeamPageByCusNum?current=1&size=5&customerNum=C0027&r=1584362400102", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"Url=../git-chart/customer-chart/getCrdListSumPage?current=1&size=10&userNum=&customerName=&orgNum=&certNum=&certType=&customerType=3&r=1584362405387", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"LAST");

	web_custom_request("info_22", 
		"URL=http://127.0.0.1:9528/dev-api/git-user/info", 
		"Method=POST", 
		"Resource=0", 
		"RecContentType=application/json", 
		"Referer=http://127.0.0.1:9528/", 
		"Snapshot=t40.inf", 
		"Mode=HTML", 
		"EncType=", 
		"EXTRARES", 
		"Url=../git-chart/customer-chart/getCrdListSumPage?current=1&size=99999999&userNum=&customerName=&orgNum=&certNum=&certType=&customerType=3&r=1584362405387", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"Url=../git-chart/customer-chart/getCrdListSumPage?current=1&size=10&userNum=&customerName=&orgNum=01000&certNum=&certType=&customerType=3&r=1584362406589", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"LAST");

	return 0;
}
# 6 "d:\\\323\303\273\247\304\277\302\274\\desktop\\aaa\\\321\271\301\246\262\342\312\324\\\275\305\261\276\\20200317\270\264\326\306\\20200316\\\\combined_20200316.c" 2

# 1 "ledger_groupCustomer.c" 1
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
		"EXTRARES", 
		"Url=../git-loan/csmGroupMember/listCsmGroupMemberPage?current=1&size=10&orgNum=01000&customerName=&userNum=&r=1584362428085", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"Url=../git-loan/csmGroupMember/findCsmGroupMemberPage?current=1&size=10&memberCustomerNum=&orgNum=01000&r=1584362428085", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"Url=../git-loan/csmGroupMember/listCsmGroupMemberPage?current=1&size=99999999&orgNum=01000&customerName=&userNum=&r=1584362428085", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"Url=../git-loan/csmGroupMember/findCsmGroupMemberPage?current=1&size=10&memberCustomerNum=C0034&orgNum=14103&r=1584362434354", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"LAST");

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
		"EXTRARES", 
		"Url=../dict/dictTranslate?code=org&r=1584362440333", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"LAST");

	web_custom_request("getList_8", 
		"URL=http://127.0.0.1:9528/dev-api/git-system/dept/getList?current=1&size=10&deptName=%E5%9F%8E%E5%8C%BA%E4%BF%A1%E7%94%A8%E7%A4%BE&fullName=&orgType=", 
		"Method=POST", 
		"Resource=0", 
		"RecContentType=application/json", 
		"Referer=http://127.0.0.1:9528/", 
		"Snapshot=t43.inf", 
		"Mode=HTML", 
		"EncType=", 
		"EXTRARES", 
		"Url=/dev-api/git-loan/csmGroupMember/listCsmGroupMemberPage?current=1&size=10&orgNum=14103&customerName=&userNum=&r=1584362452820", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"Url=/dev-api/git-loan/csmGroupMember/findCsmGroupMemberPage?current=1&size=10&memberCustomerNum=C0034&orgNum=14103&r=1584362461001", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"Url=/dev-api/git-loan/csmGroupMember/listCsmGroupMemberPage?current=1&size=10&orgNum=14103&customerName=%E4%B8%AD%E5%85%B4&userNum=&r=1584362464247", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"Url=/dev-api/git-loan/csmGroupMember/findCsmGroupMemberPage?current=1&size=10&memberCustomerNum=C0034&orgNum=14103&r=1584362481918", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"Url=/dev-api/git-loan/csmGroupMember/listCsmGroupMemberPage?current=1&size=10&orgNum=14103&customerName=%E4%B8%AD%E5%85%B4&userNum=&r=1584362490509", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"Url=/dev-api/git-loan/csmGroupMember/listCsmGroupMemberPage?current=1&size=10&orgNum=&customerName=&userNum=&r=1584362498753", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"Url=/dev-api/git-loan/csmGroupMember/listCsmGroupMemberPage?current=1&size=10&orgNum=&customerName=&userNum=&r=1584362506694", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"LAST");

	return 0;
}
# 7 "d:\\\323\303\273\247\304\277\302\274\\desktop\\aaa\\\321\271\301\246\262\342\312\324\\\275\305\261\276\\20200317\270\264\326\306\\20200316\\\\combined_20200316.c" 2

# 1 "ledger_guaranteeLedger.c" 1
ledger_guaranteeLedger()
{

	lr_think_time(53);

	web_custom_request("info_24", 
		"URL=http://127.0.0.1:9528/dev-api/git-user/info", 
		"Method=POST", 
		"Resource=0", 
		"RecContentType=application/json", 
		"Referer=http://127.0.0.1:9528/", 
		"Snapshot=t44.inf", 
		"Mode=HTML", 
		"EncType=", 
		"EXTRARES", 
		"Url=../git-demo/tbcrdsum/getTbCrdGuaranteeSumPage?current=1&size=10&userNum=&customerName=&orgNum=&certNum=&certType=&r=1584362561246", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"Url=../git-demo/tbcrdsum/getTbCrdGuaranteeSumPage?current=1&size=99999999&userNum=&customerName=&orgNum=&certNum=&certType=&r=1584362561246", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"Url=../git-demo/tbcrdsum/getTbCrdGuaranteeSumPage?current=1&size=10&userNum=&customerName=&orgNum=01000&certNum=&certType=&r=1584362561656", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"Url=../git-demo/tbcrdsum/getTbCrdGuaranteeSumPage?current=1&size=10&userNum=&customerName=%E9%BB%84%E7%9B%96&orgNum=01000&certNum=&certType=&r=1584362574422", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"Url=../git-demo/tbcrdsum/getTbCrdGuaranteeSumPage?current=1&size=10&userNum=&customerName=%E9%BB%84%E7%9B%96&orgNum=01000&customerNum=C0017&certNum=&certType=&r=1584362578907", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"Url=../git-demo/tbcrdsum/getTbCrdGuaranteeSumPage?current=1&size=10&userNum=&customerName=%E9%BB%84%E7%9B%96&orgNum=01000&customerNum=C0017&certNum=420984199910102300&certType=&r=1584362585881", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"Url=../git-system/dict/dictTranslate?code=org&r=1584362589003", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"LAST");

	web_custom_request("getList_9", 
		"URL=http://127.0.0.1:9528/dev-api/git-system/dept/getList?current=1&size=10&deptName=&fullName=&orgType=", 
		"Method=POST", 
		"Resource=0", 
		"RecContentType=application/json", 
		"Referer=http://127.0.0.1:9528/", 
		"Snapshot=t45.inf", 
		"Mode=HTML", 
		"EncType=", 
		"LAST");

	web_custom_request("getList_10", 
		"URL=http://127.0.0.1:9528/dev-api/git-system/dept/getList?current=1&size=10&deptName=%E8%B5%A3%E6%98%8C%E5%86%9C%E5%95%86%E9%93%B6%E8%A1%8C&fullName=&orgType=", 
		"Method=POST", 
		"Resource=0", 
		"RecContentType=application/json", 
		"Referer=http://127.0.0.1:9528/", 
		"Snapshot=t46.inf", 
		"Mode=HTML", 
		"EncType=", 
		"EXTRARES", 
		"Url=/dev-api/git-demo/tbcrdsum/getTbCrdGuaranteeSumPage?current=1&size=10&userNum=&customerName=%E9%BB%84%E7%9B%96&orgNum=10100&customerNum=C0017&certNum=420984199910102300&certType=&r=1584362596554", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"Url=/dev-api/git-demo/tbcrdsum/getTbCrdGuaranteeSumPage?current=1&size=10&userNum=&customerName=%E9%BB%84%E7%9B%96&orgNum=10100&customerNum=C00171&certNum=420984199910102300&certType=&r=1584362604467", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"LAST");

	web_custom_request("info_25", 
		"URL=http://127.0.0.1:9528/dev-api/git-user/info", 
		"Method=POST", 
		"Resource=0", 
		"RecContentType=application/json", 
		"Referer=http://127.0.0.1:9528/", 
		"Snapshot=t47.inf", 
		"Mode=HTML", 
		"EncType=", 
		"EXTRARES", 
		"Url=../git-demo/tbcrdsum/getTbCrdGuaranteeSumPage?current=1&size=10&userNum=&customerName=&orgNum=01000&certNum=&certType=&r=1584362608416", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"Url=../git-chart/customer-chart/getOrgByCust?customerNum=C0017&r=1584362613037", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"Url=../git-system/dict/dictTranslate?code=org&r=1584362613037", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"Url=../git-system/dict/dictTranslate?code=CD000209&r=1584362613037", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"Url=../git-system/dict/dictTranslate?code=CD000102&r=1584362613037", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"Url=../git-system/dict/dictTranslate?code=CD000019&r=1584362613037", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"Url=../git-chart/customer-chart/listGuaranteeCrd?customerNum=C0017&orgNum=01000&r=1584362615141", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"Url=../git-chart/customer-chart/listGrtPage?current=1&size=999&customerNum=C002&orgNum=01000&r=1584362615141", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"Url=../git-chart/customer-chart/listGrtPage?current=1&size=999&customerNum=C002&orgNum=01000&r=1584362620595", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"Url=../git-demo/tbcrdsum/getTbCrdGuaranteeSumPage?current=1&size=10&userNum=&customerName=&orgNum=&certNum=&certType=&r=1584362627858", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"LAST");

	web_custom_request("info_26", 
		"URL=http://127.0.0.1:9528/dev-api/git-user/info", 
		"Method=POST", 
		"Resource=0", 
		"RecContentType=application/json", 
		"Referer=http://127.0.0.1:9528/", 
		"Snapshot=t48.inf", 
		"Mode=HTML", 
		"EncType=", 
		"EXTRARES", 
		"Url=../git-demo/tbcrdsum/getTbCrdGuaranteeSumPage?current=1&size=99999999&userNum=&customerName=&orgNum=&certNum=&certType=&r=1584362627858", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"Url=../git-demo/tbcrdsum/getTbCrdGuaranteeSumPage?current=1&size=10&userNum=&customerName=&orgNum=01000&certNum=&certType=&r=1584362628323", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"Url=../git-csm/csmaddressinfo/page?current=1&size=5&customerNum=C0017&r=1584362631923", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"Url=../git-csm/csmcorporation/getCsmCorporationPageByCusNum?customerNum=C0017&r=1584362631923", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"Url=../git-csm/csmrelation/page?current=1&size=5&customerNum=C0017&r=1584362631923", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"Url=../git-csm/csmmanageteam/getCsmManageTeamPageByCusNum?current=1&size=5&customerNum=C0017&r=1584362631923", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"Url=../git-demo/tbcrdsum/getTbCrdGuaranteeSumPage?current=1&size=10&userNum=&customerName=&orgNum=&certNum=&certType=&r=1584362638078", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"LAST");

	web_custom_request("info_27", 
		"URL=http://127.0.0.1:9528/dev-api/git-user/info", 
		"Method=POST", 
		"Resource=0", 
		"RecContentType=application/json", 
		"Referer=http://127.0.0.1:9528/", 
		"Snapshot=t49.inf", 
		"Mode=HTML", 
		"EncType=", 
		"EXTRARES", 
		"Url=../git-demo/tbcrdsum/getTbCrdGuaranteeSumPage?current=1&size=99999999&userNum=&customerName=&orgNum=&certNum=&certType=&r=1584362638078", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"Url=../git-demo/tbcrdsum/getTbCrdGuaranteeSumPage?current=1&size=10&userNum=&customerName=&orgNum=01000&certNum=&certType=&r=1584362638558", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"LAST");

	return 0;
}
# 8 "d:\\\323\303\273\247\304\277\302\274\\desktop\\aaa\\\321\271\301\246\262\342\312\324\\\275\305\261\276\\20200317\270\264\326\306\\20200316\\\\combined_20200316.c" 2

# 1 "ledger_thirdPartyAccount.c" 1
ledger_thirdPartyAccount()
{

	lr_think_time(19);

	web_custom_request("info_28", 
		"URL=http://127.0.0.1:9528/dev-api/git-user/info", 
		"Method=POST", 
		"Resource=0", 
		"RecContentType=application/json", 
		"Referer=http://127.0.0.1:9528/", 
		"Snapshot=t50.inf", 
		"Mode=HTML", 
		"EncType=", 
		"EXTRARES", 
		"Url=../git-credit/crdsum/findThirdPartyCrdSumPage?current=1&size=10&certType=&certNum=&customerName=&userNum=&orgNum=&r=1584362657819", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"Url=../git-credit/crdsum/findThirdPartyCrdSumPage?current=1&size=99999999&certType=&certNum=&customerName=&userNum=&orgNum=&r=1584362657819", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"Url=../git-credit/crdsum/findThirdPartyCrdSumPage?current=1&size=10&certType=&certNum=&customerName=&userNum=&orgNum=01000&r=1584362658214", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"Url=../git-credit/crdsum/findThirdPartyCrdSumPage?current=1&size=10&certType=&certNum=&customerName=%E9%99%88%E5%A4%A7%E5%B7%9D%E5%BC%80%E4%B8%AA%E5%85%AC%E5%8F%B8&userNum=&orgNum=01000&r=1584362668283", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"Url=../git-chart/customer-chart/getOrgByCust?customerNum=C002&r=1584362673535", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"Url=../git-demo/crdDetail/findThirdPartyCrdDetailPage?current=1&size=5&customerNum=C002&orgNum=01000&r=1584362673535", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"Url=../git-demo/crdapplyserial/getApplySerialPage?current=1&size=5&customerNum=23412&orgNum=10101&r=1584362673535", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"Url=../git-demo/tbcrdapprove/findThirdPartyCrdApprovePage?current=1&size=5&customerNum=C005&orgNum=01000&r=1584362673535", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"Url=../git-chart/customer-chart/listGrtPage?current=1&size=5&customerNum=C002&orgNum=01000&r=1584362673535", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"LAST");

	web_custom_request("info_29", 
		"URL=http://127.0.0.1:9528/dev-api/git-user/info", 
		"Method=POST", 
		"Resource=0", 
		"RecContentType=application/json", 
		"Referer=http://127.0.0.1:9528/", 
		"Snapshot=t51.inf", 
		"Mode=HTML", 
		"EncType=", 
		"EXTRARES", 
		"Url=../git-credit/crdsum/findThirdPartyCrdSumPage?current=1&size=10&certType=&certNum=&customerName=&userNum=&orgNum=&r=1584362678819", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"Url=../git-credit/crdsum/findThirdPartyCrdSumPage?current=1&size=99999999&certType=&certNum=&customerName=&userNum=&orgNum=&r=1584362678819", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"Url=../git-credit/crdsum/findThirdPartyCrdSumPage?current=1&size=10&certType=&certNum=&customerName=&userNum=&orgNum=01000&r=1584362679183", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"Url=../git-credit/crdsum/findThirdPartyCrdSumPage?current=1&size=10&certType=&certNum=&customerName=&customerNum=C002&userNum=&orgNum=01000&r=1584362688299", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"Url=../git-credit/crdsum/findThirdPartyCrdSumPage?current=1&size=10&certType=&certNum=420984199910102111&customerName=&customerNum=C002&userNum=&orgNum=01000&r=1584362694636", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"Url=../git-system/dict/dictTranslate?code=org&r=1584362699037", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"LAST");

	web_custom_request("getList_11", 
		"URL=http://127.0.0.1:9528/dev-api/git-system/dept/getList?current=1&size=10&deptName=&fullName=&orgType=", 
		"Method=POST", 
		"Resource=0", 
		"RecContentType=application/json", 
		"Referer=http://127.0.0.1:9528/", 
		"Snapshot=t52.inf", 
		"Mode=HTML", 
		"EncType=", 
		"LAST");

	web_custom_request("getList_12", 
		"URL=http://127.0.0.1:9528/dev-api/git-system/dept/getList?current=1&size=10&deptName=%E8%BF%9B%E8%B4%A4%E5%86%9C%E5%95%86%E9%93%B6%E8%A1%8C&fullName=&orgType=", 
		"Method=POST", 
		"Resource=0", 
		"RecContentType=application/json", 
		"Referer=http://127.0.0.1:9528/", 
		"Snapshot=t53.inf", 
		"Mode=HTML", 
		"EncType=", 
		"EXTRARES", 
		"Url=/dev-api/git-credit/crdsum/findThirdPartyCrdSumPage?current=1&size=10&certType=&certNum=420984199910102111&customerName=&customerNum=C002&userNum=&orgNum=10300&r=1584362709401", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"Url=/dev-api/git-csm/csmcorporation/getCsmCorporationPageByCusNum?customerNum=C002&r=1584362718915", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"Url=/dev-api/git-csm/csmaddressinfo/page?current=1&size=5&customerNum=C002&r=1584362718915", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"Url=/dev-api/git-csm/csmrelation/page?current=1&size=5&customerNum=C002&r=1584362718915", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"Url=/dev-api/git-csm/csmmanageteam/getCsmManageTeamPageByCusNum?current=1&size=5&customerNum=C002&r=1584362718915", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"LAST");

	web_custom_request("info_30", 
		"URL=http://127.0.0.1:9528/dev-api/git-user/info", 
		"Method=POST", 
		"Resource=0", 
		"RecContentType=application/json", 
		"Referer=http://127.0.0.1:9528/", 
		"Snapshot=t54.inf", 
		"Mode=HTML", 
		"EncType=", 
		"EXTRARES", 
		"Url=../git-credit/crdsum/findThirdPartyCrdSumPage?current=1&size=10&certType=&certNum=&customerName=&userNum=&orgNum=&r=1584362723245", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"Url=../git-credit/crdsum/findThirdPartyCrdSumPage?current=1&size=99999999&certType=&certNum=&customerName=&userNum=&orgNum=&r=1584362723245", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"Url=../git-credit/crdsum/findThirdPartyCrdSumPage?current=1&size=10&certType=&certNum=&customerName=&userNum=&orgNum=01000&r=1584362723574", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"Url=../git-doc/excel-report/query/bankCreditTable?current=1&size=10&customerName=&r=1584362736826", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"LAST");

	return 0;
}
# 9 "d:\\\323\303\273\247\304\277\302\274\\desktop\\aaa\\\321\271\301\246\262\342\312\324\\\275\305\261\276\\20200317\270\264\326\306\\20200316\\\\combined_20200316.c" 2

# 1 "ledger_interbankCredit.c" 1
ledger_interbankCredit()
{

	lr_think_time(28);

	web_url("workDateTime", 
		"URL=http://127.0.0.1:9528/dev-api/git-system/sysdate/workDateTime?r=1584362766409", 
		"Resource=1", 
		"RecContentType=application/json", 
		"Referer=http://127.0.0.1:9528/", 
		"Snapshot=t55.inf", 
		"LAST");

	web_custom_request("info_31", 
		"URL=http://127.0.0.1:9528/dev-api/git-user/info", 
		"Method=POST", 
		"Resource=0", 
		"RecContentType=application/json", 
		"Referer=http://127.0.0.1:9528/", 
		"Snapshot=t56.inf", 
		"Mode=HTML", 
		"EncType=", 
		"EXTRARES", 
		"Url=../git-desk/notice/page?createDept=01000&current=1&size=999&r=1584362766830", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"Url=../git-chart/org-chart/getStatisOrg?orgNum=01000&r=1584362766832", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"Url=../git-rcm/ledger/home?useOrgNum=16200&r=1584362766832", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"Url=../git-doc/excel-report/query/bankCreditTable?current=1&size=10&customerName=&r=1584362768530", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"Url=../git-doc/excel-report/query/bankCreditTable?current=1&size=10&customerName=%E7%9C%81&r=1584362789626", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"Url=../git-doc/excel-report/query/bankCreditTable?current=1&size=10&customerName=&r=1584362793514", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"Url=../git-doc/excel-report/query/bankCreditTable?current=1&size=10&customerName=&r=1584362794734", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"LAST");

	web_url("bankCreditTable", 
		"URL=http://106.12.241.109:9080/git-doc/excel-report/download/bankCreditTable?customerName", 
		"Resource=0", 
		"Referer=http://127.0.0.1:9528/", 
		"Snapshot=t57.inf", 
		"Mode=HTML", 
		"LAST");

	return 0;
}
# 10 "d:\\\323\303\273\247\304\277\302\274\\desktop\\aaa\\\321\271\301\246\262\342\312\324\\\275\305\261\276\\20200317\270\264\326\306\\20200316\\\\combined_20200316.c" 2

# 1 "mechanismView.c" 1
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
		"LAST");

	web_custom_request("treeManage", 
		"URL=http://127.0.0.1:9528/dev-api/git-system/dept/treeManage?orgNum=01000", 
		"Method=POST", 
		"Resource=0", 
		"RecContentType=application/json", 
		"Referer=http://127.0.0.1:9528/", 
		"Snapshot=t59.inf", 
		"Mode=HTML", 
		"EncType=", 
		"EXTRARES", 
		"Url=/dev-api/git-chart/org-chart/getStatisOrg?orgNum=01000&r=1584362831209", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"Url=/dev-api/git-chart/org-chart/listStatis?dimension=1&orgNum=01000&r=1584362831209", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"Url=/dev-api/git-chart/org-chart/listStatis?dimension=2&orgNum=01000&r=1584362851418", "Referer=http://127.0.0.1:9528/", "ENDITEM", 
		"LAST");

	return 0;
}
# 11 "d:\\\323\303\273\247\304\277\302\274\\desktop\\aaa\\\321\271\301\246\262\342\312\324\\\275\305\261\276\\20200317\270\264\326\306\\20200316\\\\combined_20200316.c" 2

# 1 "vuser_end.c" 1
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
		"LAST");

	return 0;
}
# 12 "d:\\\323\303\273\247\304\277\302\274\\desktop\\aaa\\\321\271\301\246\262\342\312\324\\\275\305\261\276\\20200317\270\264\326\306\\20200316\\\\combined_20200316.c" 2

