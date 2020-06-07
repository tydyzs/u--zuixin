-----------------------------------------------------
-- Export file for user ZENGCHENG                  --
-- Created by Administrator on 2018/3/14, 19:20:07 --
-----------------------------------------------------

spool ttttt.log

prompt
prompt Creating table TT_CODESET
prompt =========================
prompt
create table ZENGCHENG.TT_CODESET
(
  CODESET_ID   NUMBER(16) not null,
  CODETABLE_ID NUMBER(16),
  TABLENAME    VARCHAR2(400),
  TABLENAME_E  VARCHAR2(100),
  COLNAME      VARCHAR2(400),
  COLNAME_E    VARCHAR2(50),
  IS_SHOW      NUMBER(2) default 0,
  IS_JOIN      NUMBER(2) default 0
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 3M
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on table ZENGCHENG.TT_CODESET
  is '代码表设置表(tt_codeSet)';
comment on column ZENGCHENG.TT_CODESET.TABLENAME
  is '代码表名称';
comment on column ZENGCHENG.TT_CODESET.TABLENAME_E
  is '代码表英文名称tableName_e';
comment on column ZENGCHENG.TT_CODESET.COLNAME
  is '代码表字段名称(colName)';
comment on column ZENGCHENG.TT_CODESET.COLNAME_E
  is '代码表字段英文名称(colName_e)';
comment on column ZENGCHENG.TT_CODESET.IS_SHOW
  is '是否显示字段(is_show)：0：不显示；1：显示';
comment on column ZENGCHENG.TT_CODESET.IS_JOIN
  is '是否关联字段(is_join):0：不关联；1：关联';
alter table ZENGCHENG.TT_CODESET
  add constraint PK_TT_CODESET primary key (CODESET_ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 384K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table TT_CODETABLE
prompt ===========================
prompt
create table ZENGCHENG.TT_CODETABLE
(
  CODETABLE_ID NUMBER(16) not null,
  TABLENAME    VARCHAR2(400),
  TABLENAME_E  VARCHAR2(100)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 192K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on table ZENGCHENG.TT_CODETABLE
  is '代码表(tt_codeTable)';
comment on column ZENGCHENG.TT_CODETABLE.TABLENAME
  is '代码表名称';
comment on column ZENGCHENG.TT_CODETABLE.TABLENAME_E
  is '代码表英文名称tableName_e';
alter table ZENGCHENG.TT_CODETABLE
  add constraint PK_TT_CODETABLE primary key (CODETABLE_ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 128K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table TT_CODE_NAME
prompt ===========================
prompt
create table ZENGCHENG.TT_CODE_NAME
(
  CODE_NAME_ID NUMBER(10) not null,
  TABLE_ID     NUMBER(10),
  COL_ID       NUMBER(10),
  SUBJECT_ID   NUMBER(10)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on column ZENGCHENG.TT_CODE_NAME.TABLE_ID
  is '表id';
comment on column ZENGCHENG.TT_CODE_NAME.COL_ID
  is '字段id';
comment on column ZENGCHENG.TT_CODE_NAME.SUBJECT_ID
  is '主题id';
alter table ZENGCHENG.TT_CODE_NAME
  add constraint PK_TT_CODE_NAME primary key (CODE_NAME_ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table TT_DEMO
prompt ======================
prompt
create table ZENGCHENG.TT_DEMO
(
  UUID      VARCHAR2(20),
  ZBDM      VARCHAR2(20),
  ZBMC      VARCHAR2(20),
  RESULTVAL VARCHAR2(20)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
  );

prompt
prompt Creating table TT_DEPARTMENT
prompt ============================
prompt
create table ZENGCHENG.TT_DEPARTMENT
(
  DEPARTMENT_ID   NUMBER(16) not null,
  DEPARTMENT_CODE VARCHAR2(50),
  DEPARTMENT_NAME VARCHAR2(100),
  PARENT_ID       NUMBER(16),
  REMARK          VARCHAR2(100),
  IS_DEL          NUMBER(2) default 0
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 640K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on table ZENGCHENG.TT_DEPARTMENT
  is '????????';
comment on column ZENGCHENG.TT_DEPARTMENT.DEPARTMENT_CODE
  is '????????';
comment on column ZENGCHENG.TT_DEPARTMENT.DEPARTMENT_NAME
  is '????????';
comment on column ZENGCHENG.TT_DEPARTMENT.PARENT_ID
  is '父id';
comment on column ZENGCHENG.TT_DEPARTMENT.REMARK
  is '????';
comment on column ZENGCHENG.TT_DEPARTMENT.IS_DEL
  is '是否删除（0：否；1：是）';
alter table ZENGCHENG.TT_DEPARTMENT
  add constraint PK_TT_DEPARTMENT primary key (DEPARTMENT_ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 128K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table TT_USER_NEW
prompt ==========================
prompt
create table ZENGCHENG.TT_USER_NEW
(
  USER_ID        NUMBER(16) not null,
  USER_CODE      VARCHAR2(50),
  USER_NAME      VARCHAR2(50),
  PASSWORD       VARCHAR2(50),
  EMAIL          VARCHAR2(50),
  TEL            VARCHAR2(50),
  MOBILE         VARCHAR2(50),
  STATION        NUMBER(1) default 0,
  REMARK         VARCHAR2(50),
  LOGIN_LASTTIME DATE,
  LOGIN_NUM      NUMBER(16),
  USER_IMAGE     VARCHAR2(100)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 384K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on table ZENGCHENG.TT_USER_NEW
  is '??????';
comment on column ZENGCHENG.TT_USER_NEW.USER_CODE
  is '????????????';
comment on column ZENGCHENG.TT_USER_NEW.USER_NAME
  is '????????????';
comment on column ZENGCHENG.TT_USER_NEW.PASSWORD
  is '????';
comment on column ZENGCHENG.TT_USER_NEW.EMAIL
  is 'EMAIL';
comment on column ZENGCHENG.TT_USER_NEW.TEL
  is '????';
comment on column ZENGCHENG.TT_USER_NEW.MOBILE
  is '????????';
comment on column ZENGCHENG.TT_USER_NEW.STATION
  is '??????0????????1????????';
comment on column ZENGCHENG.TT_USER_NEW.REMARK
  is '????';
comment on column ZENGCHENG.TT_USER_NEW.LOGIN_LASTTIME
  is '????????????';
comment on column ZENGCHENG.TT_USER_NEW.LOGIN_NUM
  is '????????';
comment on column ZENGCHENG.TT_USER_NEW.USER_IMAGE
  is '????';
alter table ZENGCHENG.TT_USER_NEW
  add constraint PK_TT_USER primary key (USER_ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 128K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table TT_DEP_USER
prompt ==========================
prompt
create table ZENGCHENG.TT_DEP_USER
(
  DEP_USER_ID   NUMBER(16) not null,
  DEPARTMENT_ID NUMBER(16),
  USER_ID       NUMBER(16),
  POSITION      VARCHAR2(50),
  DUTY          VARCHAR2(50),
  REMARK        VARCHAR2(100)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 192K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on table ZENGCHENG.TT_DEP_USER
  is '????????';
comment on column ZENGCHENG.TT_DEP_USER.POSITION
  is '????';
comment on column ZENGCHENG.TT_DEP_USER.DUTY
  is '????';
comment on column ZENGCHENG.TT_DEP_USER.REMARK
  is '????';
alter table ZENGCHENG.TT_DEP_USER
  add constraint PK_TT_DEP_USER primary key (DEP_USER_ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 128K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table ZENGCHENG.TT_DEP_USER
  add constraint FK_TT_DEP_U_REFERENCE_TT_DEPAR foreign key (DEPARTMENT_ID)
  references ZENGCHENG.TT_DEPARTMENT (DEPARTMENT_ID);
alter table ZENGCHENG.TT_DEP_USER
  add constraint FK_TT_DEP_U_REFERENCE_TT_USER foreign key (USER_ID)
  references ZENGCHENG.TT_USER_NEW (USER_ID)
  disable;

prompt
prompt Creating table TT_FXZB_ZBJG
prompt ===========================
prompt
create table ZENGCHENG.TT_FXZB_ZBJG
(
  ZBDM   VARCHAR2(100),
  ZBJSJG NUMBER,
  NSRSBH VARCHAR2(100),
  SJGXRQ DATE,
  SJZT   VARCHAR2(10),
  CKJGZ  VARCHAR2(100)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 200M
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on table ZENGCHENG.TT_FXZB_ZBJG
  is '风险指标结果表';
comment on column ZENGCHENG.TT_FXZB_ZBJG.ZBDM
  is '指标代码';
comment on column ZENGCHENG.TT_FXZB_ZBJG.ZBJSJG
  is '指标计数结果';
comment on column ZENGCHENG.TT_FXZB_ZBJG.NSRSBH
  is '登记序号';
comment on column ZENGCHENG.TT_FXZB_ZBJG.SJGXRQ
  is '数据更新日期';
comment on column ZENGCHENG.TT_FXZB_ZBJG.SJZT
  is '数据状态';
comment on column ZENGCHENG.TT_FXZB_ZBJG.CKJGZ
  is '处理结果描述';

prompt
prompt Creating table TT_TYPE
prompt ======================
prompt
create table ZENGCHENG.TT_TYPE
(
  T_TYPE_ID NUMBER(10) not null,
  TYPE_NAME VARCHAR2(100),
  TYPE_CODE VARCHAR2(10),
  PARENT_ID NUMBER(10),
  IS_DEL    NUMBER(10)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column ZENGCHENG.TT_TYPE.T_TYPE_ID
  is '分类id';
comment on column ZENGCHENG.TT_TYPE.TYPE_NAME
  is '分类名称';
comment on column ZENGCHENG.TT_TYPE.TYPE_CODE
  is '分类编码';
comment on column ZENGCHENG.TT_TYPE.PARENT_ID
  is '父ID';
comment on column ZENGCHENG.TT_TYPE.IS_DEL
  is '是否删除（0：否；1：是）';
alter table ZENGCHENG.TT_TYPE
  add constraint PK_TT_TYPE primary key (T_TYPE_ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table TT_TSUBJECT
prompt ==========================
prompt
create table ZENGCHENG.TT_TSUBJECT
(
  SUBJECT_ID         NUMBER(10) not null,
  SUBJECT_NAME       VARCHAR2(100),
  T_TYPE_ID          NUMBER(10),
  SETMAN             VARCHAR2(20),
  SETDATE            DATE default sysdate,
  MODIFY_DATE        DATE,
  IS_FUNCTION        NUMBER(1),
  IS_GROUPBY         NUMBER(1),
  IS_ORDER           NUMBER(1),
  IS_DEL             NUMBER(1),
  THEMEBZ            VARCHAR2(1000),
  CACHE_TABLE        VARCHAR2(50),
  JURISDICTION_WHERE VARCHAR2(1000)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 192K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on table ZENGCHENG.TT_TSUBJECT
  is '主题表下可以包括多个表';
comment on column ZENGCHENG.TT_TSUBJECT.SUBJECT_ID
  is '主题ID';
comment on column ZENGCHENG.TT_TSUBJECT.SUBJECT_NAME
  is '主题名称';
comment on column ZENGCHENG.TT_TSUBJECT.T_TYPE_ID
  is '主题类型id';
comment on column ZENGCHENG.TT_TSUBJECT.SETMAN
  is '创建人';
comment on column ZENGCHENG.TT_TSUBJECT.SETDATE
  is '创建时间';
comment on column ZENGCHENG.TT_TSUBJECT.MODIFY_DATE
  is '修改时间';
comment on column ZENGCHENG.TT_TSUBJECT.IS_FUNCTION
  is '是否function';
comment on column ZENGCHENG.TT_TSUBJECT.IS_GROUPBY
  is '是否groupby';
comment on column ZENGCHENG.TT_TSUBJECT.IS_ORDER
  is '是否order';
comment on column ZENGCHENG.TT_TSUBJECT.IS_DEL
  is '是否删除（0：否，1：是）';
comment on column ZENGCHENG.TT_TSUBJECT.THEMEBZ
  is '主题备注';
comment on column ZENGCHENG.TT_TSUBJECT.CACHE_TABLE
  is '主题的缓存表表名';
comment on column ZENGCHENG.TT_TSUBJECT.JURISDICTION_WHERE
  is '数据查询权限需要加的条件';
alter table ZENGCHENG.TT_TSUBJECT
  add constraint PK_TT_SUBJECT primary key (SUBJECT_ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table ZENGCHENG.TT_TSUBJECT
  add constraint FK_TT_SUBJE_REFERENCE_TT_TYPE foreign key (T_TYPE_ID)
  references ZENGCHENG.TT_TYPE (T_TYPE_ID);

prompt
prompt Creating table TT_INCLUDE_COL
prompt =============================
prompt
create table ZENGCHENG.TT_INCLUDE_COL
(
  INCLUDE_COL_ID   NUMBER(10) not null,
  S_TABLES_ID      NUMBER(10),
  COL_C_NAME       VARCHAR2(300),
  COL_E_NAME       VARCHAR2(100),
  SUBJECT_ID       NUMBER(10),
  IS_PROJECT       NUMBER(1),
  IS_WHERE         NUMBER(1),
  IS_CODE          NUMBER(1),
  IS_GROUP         NUMBER(1),
  COL_E_NAME_ALIAS VARCHAR2(50),
  TABLE_COL_E_NAME VARCHAR2(300)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 6M
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on table ZENGCHENG.TT_INCLUDE_COL
  is '包含表字段';
comment on column ZENGCHENG.TT_INCLUDE_COL.INCLUDE_COL_ID
  is '包含字段ID';
comment on column ZENGCHENG.TT_INCLUDE_COL.S_TABLES_ID
  is '表名称id';
comment on column ZENGCHENG.TT_INCLUDE_COL.COL_C_NAME
  is '字段中文名';
comment on column ZENGCHENG.TT_INCLUDE_COL.COL_E_NAME
  is '字段英文名';
comment on column ZENGCHENG.TT_INCLUDE_COL.SUBJECT_ID
  is '主题表ID';
comment on column ZENGCHENG.TT_INCLUDE_COL.IS_PROJECT
  is '是否项目';
comment on column ZENGCHENG.TT_INCLUDE_COL.IS_WHERE
  is '是否条件';
comment on column ZENGCHENG.TT_INCLUDE_COL.IS_CODE
  is '是否代码';
comment on column ZENGCHENG.TT_INCLUDE_COL.IS_GROUP
  is '是否分组';
comment on column ZENGCHENG.TT_INCLUDE_COL.COL_E_NAME_ALIAS
  is '????????';
comment on column ZENGCHENG.TT_INCLUDE_COL.TABLE_COL_E_NAME
  is '字段全名（包含表名）';
alter table ZENGCHENG.TT_INCLUDE_COL
  add constraint PK_TT_INCLUDE_COL primary key (INCLUDE_COL_ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 2M
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table ZENGCHENG.TT_INCLUDE_COL
  add constraint FK_TT_INCLU_REFERENCE_TT_SUBJE foreign key (SUBJECT_ID)
  references ZENGCHENG.TT_TSUBJECT (SUBJECT_ID);

prompt
prompt Creating table TT_LEDGER
prompt ========================
prompt
create table ZENGCHENG.TT_LEDGER
(
  LEDID       NUMBER(16) not null,
  TEMPLATEID  NUMBER(16),
  LED_NAME    VARCHAR2(255),
  CREATE_P    VARCHAR2(255),
  CREATE_DATE DATE,
  MODIFY_DATE DATE,
  MODIFY_P    VARCHAR2(50),
  DEL_P       VARCHAR2(50),
  IS_DEL      NUMBER(2) default 0,
  HEADER      CLOB,
  FILLINFORM  VARCHAR2(50),
  FILLINFORM1 VARCHAR2(50),
  USER_ID     NUMBER(16)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table TT_LEDTYPE
prompt =========================
prompt
create table ZENGCHENG.TT_LEDTYPE
(
  RETYPE_ID  NUMBER(16),
  PARENT_ID  NUMBER(16),
  TYPE_NAME  VARCHAR2(355),
  IS_DEL     NUMBER(2),
  HEADER     CLOB,
  TABLE_NAME VARCHAR2(50),
  EXCEL_NAME VARCHAR2(250)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table TT_MODULE
prompt ========================
prompt
create table ZENGCHENG.TT_MODULE
(
  MODULE_ID   NUMBER(16) not null,
  MODULE_NAME VARCHAR2(50),
  MODULE_URL  VARCHAR2(100),
  PARENT_ID   NUMBER(16),
  IS_DEL      NUMBER(2) default 0,
  PROJECT_ID  NUMBER(16)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on table ZENGCHENG.TT_MODULE
  is '??????';
comment on column ZENGCHENG.TT_MODULE.MODULE_NAME
  is '????????';
comment on column ZENGCHENG.TT_MODULE.MODULE_URL
  is '????URL';
comment on column ZENGCHENG.TT_MODULE.PARENT_ID
  is '父ID';
comment on column ZENGCHENG.TT_MODULE.IS_DEL
  is '是否删除（0：未删除；1：已删除）';
comment on column ZENGCHENG.TT_MODULE.PROJECT_ID
  is '项目ID';
alter table ZENGCHENG.TT_MODULE
  add constraint PK_TT_MODULE primary key (MODULE_ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table TT_OLD_TABLES
prompt ============================
prompt
create table ZENGCHENG.TT_OLD_TABLES
(
  S_TABLES_ID NUMBER(10) not null,
  C_NAME      VARCHAR2(4000),
  E_NAME      VARCHAR2(100)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 896K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column ZENGCHENG.TT_OLD_TABLES.S_TABLES_ID
  is '包含表id';
comment on column ZENGCHENG.TT_OLD_TABLES.C_NAME
  is '表中文名称';
comment on column ZENGCHENG.TT_OLD_TABLES.E_NAME
  is '表英文名称';
alter table ZENGCHENG.TT_OLD_TABLES
  add constraint PK_TT_OLD_TABLES2 primary key (S_TABLES_ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 256K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table TT_OLD_INC_COL
prompt =============================
prompt
create table ZENGCHENG.TT_OLD_INC_COL
(
  INCLUDE_COL_ID NUMBER(10) not null,
  S_TABLES_ID    NUMBER(10),
  COL_C_NAME     VARCHAR2(4000),
  COL_E_NAME     VARCHAR2(100)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 11M
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on table ZENGCHENG.TT_OLD_INC_COL
  is '包含表字段';
comment on column ZENGCHENG.TT_OLD_INC_COL.INCLUDE_COL_ID
  is '包含字段ID';
comment on column ZENGCHENG.TT_OLD_INC_COL.S_TABLES_ID
  is '表名称id';
comment on column ZENGCHENG.TT_OLD_INC_COL.COL_C_NAME
  is '字段中文名';
comment on column ZENGCHENG.TT_OLD_INC_COL.COL_E_NAME
  is '字段英文名';
alter table ZENGCHENG.TT_OLD_INC_COL
  add constraint PK_TT_OLD_INC_COL primary key (INCLUDE_COL_ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 4M
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table ZENGCHENG.TT_OLD_INC_COL
  add constraint FK_TT_OLD_I_REFERENCE_TT_OLD_T foreign key (S_TABLES_ID)
  references ZENGCHENG.TT_OLD_TABLES (S_TABLES_ID);

prompt
prompt Creating table TT_OLD_INC_COL_BAK
prompt =================================
prompt
create table ZENGCHENG.TT_OLD_INC_COL_BAK
(
  INCLUDE_COL_ID NUMBER(10) not null,
  S_TABLES_ID    NUMBER(10),
  COL_C_NAME     VARCHAR2(4000),
  COL_E_NAME     VARCHAR2(100)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table TT_OLD_TABLES_BAK
prompt ================================
prompt
create table ZENGCHENG.TT_OLD_TABLES_BAK
(
  S_TABLES_ID NUMBER(10) not null,
  C_NAME      VARCHAR2(4000),
  E_NAME      VARCHAR2(100)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table TT_PERCHANGERATE
prompt ===============================
prompt
create table ZENGCHENG.TT_PERCHANGERATE
(
  PERCHANGERATE_ID NUMBER(16) not null,
  IN_RATE          NUMBER(16,2),
  COST_RATE        NUMBER(16,2),
  IN_AREA_RATE     NUMBER(16,2),
  COST_AREA_RATE   NUMBER(16,2),
  创建人              CHAR(10)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on table ZENGCHENG.TT_PERCHANGERATE
  is '变动率表（tt_perchangeRate）暂定';
comment on column ZENGCHENG.TT_PERCHANGERATE.IN_RATE
  is '收入变动率in_rate';
comment on column ZENGCHENG.TT_PERCHANGERATE.COST_RATE
  is '成本变动率cost_rate';
comment on column ZENGCHENG.TT_PERCHANGERATE.IN_AREA_RATE
  is '收入面积变动率in_area_rate';
comment on column ZENGCHENG.TT_PERCHANGERATE.COST_AREA_RATE
  is '成本面积变动率cost_area_rate';
alter table ZENGCHENG.TT_PERCHANGERATE
  add constraint PK_TT_PERCHANGERATE primary key (PERCHANGERATE_ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table TT_PERSUBCOL
prompt ===========================
prompt
create table ZENGCHENG.TT_PERSUBCOL
(
  PERSUBCOL_ID     NUMBER(16) not null,
  PERSUBJECT_ID    NUMBER(16),
  PREINC_COL_ID    NUMBER(16),
  PERSUBJECT_NAME  VARCHAR2(100),
  PERSUBJECT_E     VARCHAR2(100),
  PERSUBCOL_NAME   VARCHAR2(100),
  PERSUBCOL_NAME_E VARCHAR2(50),
  SETMAN           VARCHAR2(50),
  SETMAN_ID        NUMBER(16)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 128K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on table ZENGCHENG.TT_PERSUBCOL
  is '一户选择主题列(tt_perSubCol)';
comment on column ZENGCHENG.TT_PERSUBCOL.PERSUBJECT_ID
  is '对应表tt_perSubject的perSubject_id';
comment on column ZENGCHENG.TT_PERSUBCOL.PREINC_COL_ID
  is '对应表tt_preInc_col的preInc_col_id';
comment on column ZENGCHENG.TT_PERSUBCOL.PERSUBJECT_NAME
  is '主题名称（perSubject）';
comment on column ZENGCHENG.TT_PERSUBCOL.PERSUBJECT_E
  is '主题名称_e（perSubject_e）';
comment on column ZENGCHENG.TT_PERSUBCOL.PERSUBCOL_NAME
  is '选择主题列(perSubCol_name)';
comment on column ZENGCHENG.TT_PERSUBCOL.PERSUBCOL_NAME_E
  is '选择主题列_e(perSubCol_name_e)';
comment on column ZENGCHENG.TT_PERSUBCOL.SETMAN
  is '创建人(setman)';
comment on column ZENGCHENG.TT_PERSUBCOL.SETMAN_ID
  is '创建人ID(setman_id)';
alter table ZENGCHENG.TT_PERSUBCOL
  add constraint PK_TT_PERSUBCOL primary key (PERSUBCOL_ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table TT_PERSUBJECT
prompt ============================
prompt
create table ZENGCHENG.TT_PERSUBJECT
(
  PERSUBJECT_ID   NUMBER(16) not null,
  PERSUBJECT_NAME VARCHAR2(300),
  PERSUBJECT_E    VARCHAR2(100),
  SETDATE         DATE default SYSDATE
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on table ZENGCHENG.TT_PERSUBJECT
  is '主题名称表(tt_perSubject))需要同步';
comment on column ZENGCHENG.TT_PERSUBJECT.PERSUBJECT_NAME
  is '主题名称（perSubject）';
comment on column ZENGCHENG.TT_PERSUBJECT.PERSUBJECT_E
  is '主题名称_e（perSubject_e）';
comment on column ZENGCHENG.TT_PERSUBJECT.SETDATE
  is '创建时间(setdate)';
alter table ZENGCHENG.TT_PERSUBJECT
  add constraint PK_TT_PERSUBJECT primary key (PERSUBJECT_ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table TT_PERSUB_DATECOL
prompt ================================
prompt
create table ZENGCHENG.TT_PERSUB_DATECOL
(
  PERSUB_DATECOL_ID NUMBER(16) not null,
  PERSUBJECT_ID     NUMBER(16),
  PREINC_COL_ID     NUMBER(16),
  SETDATE           DATE default SYSDATE
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on table ZENGCHENG.TT_PERSUB_DATECOL
  is '主题日期列(tt_persub_dateCol)需要同步';
comment on column ZENGCHENG.TT_PERSUB_DATECOL.SETDATE
  is '创建时间(setdate)';
alter table ZENGCHENG.TT_PERSUB_DATECOL
  add constraint PK_TT_PERSUB_DATECOL primary key (PERSUB_DATECOL_ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table TT_PERUSUALLY_SUB
prompt ================================
prompt
create table ZENGCHENG.TT_PERUSUALLY_SUB
(
  PERUSUALLY_SUB_ID NUMBER(16) not null,
  PERSUBJECT_ID     NUMBER(16),
  PERSUBJECT_NAME   VARCHAR2(300),
  PERSUBJECT_E      VARCHAR2(100),
  SETMAN            VARCHAR2(50),
  SETMAN_ID         NUMBER(16)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 640K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on table ZENGCHENG.TT_PERUSUALLY_SUB
  is '常用主题选择(tt_perusually_sub)';
comment on column ZENGCHENG.TT_PERUSUALLY_SUB.PERSUBJECT_ID
  is '对应主题表id';
comment on column ZENGCHENG.TT_PERUSUALLY_SUB.PERSUBJECT_NAME
  is '主题名称（perSubject）';
comment on column ZENGCHENG.TT_PERUSUALLY_SUB.PERSUBJECT_E
  is '主题名称_e（perSubject_e）';
comment on column ZENGCHENG.TT_PERUSUALLY_SUB.SETMAN
  is '创建人(setman)';
comment on column ZENGCHENG.TT_PERUSUALLY_SUB.SETMAN_ID
  is '创建人ID(setman_id)';
alter table ZENGCHENG.TT_PERUSUALLY_SUB
  add constraint PK_TT_PERUSUALLY_SUB primary key (PERUSUALLY_SUB_ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 192K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table TT_PERWHITE_BOARD
prompt ================================
prompt
create table ZENGCHENG.TT_PERWHITE_BOARD
(
  PERWHITE_BOARD_ID NUMBER(16) not null,
  PERSUBJECT_ID     NUMBER(16),
  PREINC_COL_ID     NUMBER(16),
  COL_NAME          VARCHAR2(50),
  COL_NAME_E        VARCHAR2(50),
  COL_ASNAME        VARCHAR2(50),
  COL_VALUE         VARCHAR2(50),
  SETMAN            VARCHAR2(50),
  SETMAN_ID         NUMBER(16),
  SETDATE           DATE default SYSDATE
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on table ZENGCHENG.TT_PERWHITE_BOARD
  is '自定义白板表(tt_perwhite_board)';
comment on column ZENGCHENG.TT_PERWHITE_BOARD.COL_NAME
  is '列名称(col_name)';
comment on column ZENGCHENG.TT_PERWHITE_BOARD.COL_NAME_E
  is '列名称_e(col_name_e)';
comment on column ZENGCHENG.TT_PERWHITE_BOARD.COL_ASNAME
  is '列别名(col_asName)';
comment on column ZENGCHENG.TT_PERWHITE_BOARD.COL_VALUE
  is '列值(col_value)';
comment on column ZENGCHENG.TT_PERWHITE_BOARD.SETMAN
  is '创建人(setman)';
comment on column ZENGCHENG.TT_PERWHITE_BOARD.SETMAN_ID
  is '创建人ID(setman_id)';
comment on column ZENGCHENG.TT_PERWHITE_BOARD.SETDATE
  is '创建时间(setdate)';
alter table ZENGCHENG.TT_PERWHITE_BOARD
  add constraint PK_TT_PERWHITE_BOARD primary key (PERWHITE_BOARD_ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table TT_PREINC_COL
prompt ============================
prompt
create table ZENGCHENG.TT_PREINC_COL
(
  PREINC_COL_ID NUMBER(16) not null,
  COL_NAME      VARCHAR2(100),
  COL_NAME_E    VARCHAR2(100),
  SETDATE       DATE default SYSDATE,
  PERSUBJECT_ID NUMBER(16)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 448K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on table ZENGCHENG.TT_PREINC_COL
  is '主题包含表(tt_preInc_col))需要同步';
comment on column ZENGCHENG.TT_PREINC_COL.COL_NAME
  is '列名称(col_name)';
comment on column ZENGCHENG.TT_PREINC_COL.COL_NAME_E
  is '列名称_e(col_name_e)';
comment on column ZENGCHENG.TT_PREINC_COL.SETDATE
  is '创建日期(setdate)';
alter table ZENGCHENG.TT_PREINC_COL
  add constraint PK_TT_PREINC_COL primary key (PREINC_COL_ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 128K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table TT_PROJECT
prompt =========================
prompt
create table ZENGCHENG.TT_PROJECT
(
  PROJECT_ID   NUMBER(16) not null,
  PROJECT_NAME VARCHAR2(50)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on table ZENGCHENG.TT_PROJECT
  is '应用名称表(tt_project)';
comment on column ZENGCHENG.TT_PROJECT.PROJECT_NAME
  is '应用名称(project_name)';
alter table ZENGCHENG.TT_PROJECT
  add constraint PK_TT_PROJECT primary key (PROJECT_ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table TT_REPORTCODESET
prompt ===============================
prompt
create table ZENGCHENG.TT_REPORTCODESET
(
  REPORTCODESET_ID NUMBER(16) not null,
  TREPORT_ID       NUMBER(16),
  CODETABLE_ID     NUMBER(16),
  CODESET_ID       NUMBER(16),
  TABLENAME        VARCHAR2(100),
  TABLENAME_E      VARCHAR2(50),
  COLNAME          VARCHAR2(100),
  COLNAME_E        VARCHAR2(50),
  IS_SHOW          NUMBER(2) default 0,
  IS_JOIN          NUMBER(2) default 0
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on table ZENGCHENG.TT_REPORTCODESET
  is '??????????????(tt_reportCodeSet)';
comment on column ZENGCHENG.TT_REPORTCODESET.TABLENAME
  is '??????????';
comment on column ZENGCHENG.TT_REPORTCODESET.TABLENAME_E
  is '??????????????tableName_e';
comment on column ZENGCHENG.TT_REPORTCODESET.COLNAME
  is '??????????????(colName)';
comment on column ZENGCHENG.TT_REPORTCODESET.COLNAME_E
  is '??????????????????(colName_e)';
comment on column ZENGCHENG.TT_REPORTCODESET.IS_SHOW
  is '????????????(is_show)??0??????????1??????';
comment on column ZENGCHENG.TT_REPORTCODESET.IS_JOIN
  is '????????????(is_join):0??????????1??????';
alter table ZENGCHENG.TT_REPORTCODESET
  add constraint PK_TT_REPORTCODESET primary key (REPORTCODESET_ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table TT_REPORT_WHERE
prompt ==============================
prompt
create table ZENGCHENG.TT_REPORT_WHERE
(
  REPORT_WHERE_ID NUMBER(16) not null,
  TREPORT_ID      NUMBER(16),
  C_VARNAME       VARCHAR2(100),
  SQL_NAME        VARCHAR2(50),
  T_COLNAME       VARCHAR2(50)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on table ZENGCHENG.TT_REPORT_WHERE
  is '报表条件表(tt_report_where)';
comment on column ZENGCHENG.TT_REPORT_WHERE.C_VARNAME
  is '查询常量中文名(c_varName)';
comment on column ZENGCHENG.TT_REPORT_WHERE.SQL_NAME
  is 'SQL别名(sql_name)';
comment on column ZENGCHENG.TT_REPORT_WHERE.T_COLNAME
  is '对应表字段名(t_colName)';
alter table ZENGCHENG.TT_REPORT_WHERE
  add constraint PK_TT_REPORT_WHERE primary key (REPORT_WHERE_ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table TT_RETYPE
prompt ========================
prompt
create table ZENGCHENG.TT_RETYPE
(
  RETYPE_ID NUMBER(16) not null,
  PARENT_ID NUMBER(16),
  TYPE_NAME VARCHAR2(255),
  IS_DEL    NUMBER(2) default 0
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on table ZENGCHENG.TT_RETYPE
  is '报表分类(tt_reType)';
comment on column ZENGCHENG.TT_RETYPE.PARENT_ID
  is '父IDparent_id';
comment on column ZENGCHENG.TT_RETYPE.TYPE_NAME
  is '分类名称type_name';
comment on column ZENGCHENG.TT_RETYPE.IS_DEL
  is '是否删除(is_del)：0：未删除；1：删除';
alter table ZENGCHENG.TT_RETYPE
  add constraint PK_TT_RETYPE primary key (RETYPE_ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table TT_ROLE
prompt ======================
prompt
create table ZENGCHENG.TT_ROLE
(
  ROLE_ID    NUMBER(16) not null,
  ROLE_NAME  VARCHAR2(50),
  REMARK     VARCHAR2(100),
  PROJECT_ID NUMBER(16)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on table ZENGCHENG.TT_ROLE
  is '????????';
comment on column ZENGCHENG.TT_ROLE.ROLE_NAME
  is '????????';
comment on column ZENGCHENG.TT_ROLE.REMARK
  is '????';
comment on column ZENGCHENG.TT_ROLE.PROJECT_ID
  is '对应项目ID';
alter table ZENGCHENG.TT_ROLE
  add constraint PK_TT_ROLE primary key (ROLE_ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table TT_ROLE_MODULE
prompt =============================
prompt
create table ZENGCHENG.TT_ROLE_MODULE
(
  ROLE_MODULE_ID NUMBER(16) not null,
  ROLE_ID        NUMBER(16),
  MODULE_ID      NUMBER(16)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on table ZENGCHENG.TT_ROLE_MODULE
  is '????????';
alter table ZENGCHENG.TT_ROLE_MODULE
  add constraint PK_TT_ROLE_MODULE primary key (ROLE_MODULE_ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table ZENGCHENG.TT_ROLE_MODULE
  add constraint FK_TT_ROLE__REFERENCE_TT_MODUL foreign key (MODULE_ID)
  references ZENGCHENG.TT_MODULE (MODULE_ID);
alter table ZENGCHENG.TT_ROLE_MODULE
  add constraint FK_TT_ROLE__REFERENCE_TT_ROLE foreign key (ROLE_ID)
  references ZENGCHENG.TT_ROLE (ROLE_ID);

prompt
prompt Creating table TT_ROLE_USER
prompt ===========================
prompt
create table ZENGCHENG.TT_ROLE_USER
(
  ROLE_USER_ID NUMBER(16) not null,
  ROLE_ID      NUMBER(16),
  USER_ID      NUMBER(16)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on table ZENGCHENG.TT_ROLE_USER
  is '????????';
alter table ZENGCHENG.TT_ROLE_USER
  add constraint PK_TT_ROLE_USER primary key (ROLE_USER_ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table ZENGCHENG.TT_ROLE_USER
  add constraint FK_TT_ROLE_TT_ROLE foreign key (ROLE_ID)
  references ZENGCHENG.TT_ROLE (ROLE_ID);
alter table ZENGCHENG.TT_ROLE_USER
  add constraint FK_TT_ROLE__REFERENCE_TT_USER foreign key (USER_ID)
  references ZENGCHENG.TT_USER_NEW (USER_ID);

prompt
prompt Creating table TT_S_TABLES
prompt ==========================
prompt
create table ZENGCHENG.TT_S_TABLES
(
  S_TABLES_ID NUMBER(10) not null,
  C_NAME      VARCHAR2(100),
  E_NAME      VARCHAR2(100),
  SUBJECT_ID  NUMBER(10)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 192K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column ZENGCHENG.TT_S_TABLES.S_TABLES_ID
  is '包含表id';
comment on column ZENGCHENG.TT_S_TABLES.C_NAME
  is '表中文名称';
comment on column ZENGCHENG.TT_S_TABLES.E_NAME
  is '表英文名称';
comment on column ZENGCHENG.TT_S_TABLES.SUBJECT_ID
  is '主题ID';
alter table ZENGCHENG.TT_S_TABLES
  add constraint PK_TT_S_TABLES primary key (S_TABLES_ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 128K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table ZENGCHENG.TT_S_TABLES
  add constraint FK_TT_S_TAB_REFERENCE_TT_SUBJE foreign key (SUBJECT_ID)
  references ZENGCHENG.TT_TSUBJECT (SUBJECT_ID);

prompt
prompt Creating table TT_TCON
prompt ======================
prompt
create table ZENGCHENG.TT_TCON
(
  CON_ID           NUMBER(10) not null,
  S_TABLES_ID_1    NUMBER(10),
  C_NAME_1         VARCHAR2(100),
  E_NAME_1         VARCHAR2(100),
  INCLUDE_COL_ID_1 NUMBER(10),
  COL_C_NAME       VARCHAR2(200),
  COL_E_NAME       VARCHAR2(100),
  S_TABLES_ID_2    NUMBER(10),
  C_NAME_2         VARCHAR2(100),
  E_NAME_2         VARCHAR2(100),
  INCLUDE_COL_ID_2 NUMBER(10),
  CON_WAY          VARCHAR2(50),
  SUBJECT_ID       NUMBER(10),
  SORT             NUMBER(5),
  COL_C_NAME2      VARCHAR2(100),
  COL_E_NAME2      VARCHAR2(100)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 192K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on table ZENGCHENG.TT_TCON
  is '关联表';
comment on column ZENGCHENG.TT_TCON.CON_ID
  is '关联id';
comment on column ZENGCHENG.TT_TCON.S_TABLES_ID_1
  is '表名称id1';
comment on column ZENGCHENG.TT_TCON.C_NAME_1
  is '表中文名称1';
comment on column ZENGCHENG.TT_TCON.E_NAME_1
  is '表英文名称1';
comment on column ZENGCHENG.TT_TCON.INCLUDE_COL_ID_1
  is '关联字段id_1';
comment on column ZENGCHENG.TT_TCON.COL_C_NAME
  is '关联字段中_1';
comment on column ZENGCHENG.TT_TCON.COL_E_NAME
  is '关联字段英_1';
comment on column ZENGCHENG.TT_TCON.S_TABLES_ID_2
  is '表名称id2';
comment on column ZENGCHENG.TT_TCON.C_NAME_2
  is '表中文名称2';
comment on column ZENGCHENG.TT_TCON.E_NAME_2
  is '表英文名称2';
comment on column ZENGCHENG.TT_TCON.INCLUDE_COL_ID_2
  is '关联字段id_2';
comment on column ZENGCHENG.TT_TCON.CON_WAY
  is '关联方式';
comment on column ZENGCHENG.TT_TCON.SUBJECT_ID
  is '主题id';
comment on column ZENGCHENG.TT_TCON.SORT
  is '顺序';
comment on column ZENGCHENG.TT_TCON.COL_C_NAME2
  is '关联字段中_2';
comment on column ZENGCHENG.TT_TCON.COL_E_NAME2
  is '关联字段英_2';
alter table ZENGCHENG.TT_TCON
  add constraint PK_TT_CON primary key (CON_ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table ZENGCHENG.TT_TCON
  add constraint FK_TT_CON_REFERENCE_TT_SUBJE foreign key (SUBJECT_ID)
  references ZENGCHENG.TT_TSUBJECT (SUBJECT_ID);

prompt
prompt Creating table TT_TCUSTOMSHOWR
prompt ==============================
prompt
create table ZENGCHENG.TT_TCUSTOMSHOWR
(
  TCUSTOMSHOWR_ID NUMBER(16) not null,
  RETYPE_ID       NUMBER(16),
  TREPORT_ID      NUMBER(16),
  SETMAN          VARCHAR2(50),
  SETDATE         DATE default SYSDATE
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 384K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on table ZENGCHENG.TT_TCUSTOMSHOWR
  is '??????????????(tt_tcustomShowR)';
comment on column ZENGCHENG.TT_TCUSTOMSHOWR.RETYPE_ID
  is '????????????ID';
comment on column ZENGCHENG.TT_TCUSTOMSHOWR.TREPORT_ID
  is '????????ID';
comment on column ZENGCHENG.TT_TCUSTOMSHOWR.SETMAN
  is '??????';
comment on column ZENGCHENG.TT_TCUSTOMSHOWR.SETDATE
  is '????????';
alter table ZENGCHENG.TT_TCUSTOMSHOWR
  add constraint PK_TT_TCUSTOMSHOWR primary key (TCUSTOMSHOWR_ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 256K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table TT_TEMPLATE
prompt ==========================
prompt
create table ZENGCHENG.TT_TEMPLATE
(
  TEMPLATE_ID NUMBER(16) not null,
  TREPORT_ID  NUMBER(16),
  rowNum      VARCHAR2(50),
  COLNUM      VARCHAR2(50),
  CONTENT     CLOB,
  IS_HEAD     NUMBER(2) default 0,
  SETMAN      VARCHAR2(50),
  SETDATE     DATE default SYSDATE
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 6M
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on table ZENGCHENG.TT_TEMPLATE
  is '模板表(tt_template)';
comment on column ZENGCHENG.TT_TEMPLATE.rowNum
  is '行号(rowNum)';
comment on column ZENGCHENG.TT_TEMPLATE.COLNUM
  is '列号(colNum)';
comment on column ZENGCHENG.TT_TEMPLATE.CONTENT
  is '内容(content)';
comment on column ZENGCHENG.TT_TEMPLATE.IS_HEAD
  is '是否表头(is_head)：0：不是表头；1：是表头';
comment on column ZENGCHENG.TT_TEMPLATE.SETMAN
  is '创建人(setman)';
comment on column ZENGCHENG.TT_TEMPLATE.SETDATE
  is '创建时间(setdate)';
alter table ZENGCHENG.TT_TEMPLATE
  add constraint PK_TT_TEMPLATE primary key (TEMPLATE_ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 1M
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table TT_TFUNCTION
prompt ===========================
prompt
create table ZENGCHENG.TT_TFUNCTION
(
  FUNCTION_ID      NUMBER(10) not null,
  FUNCTION_NAME    VARCHAR2(50),
  S_TABLES_ID      NUMBER(10),
  C_NAME           VARCHAR2(3000),
  E_NAME           VARCHAR2(1000),
  COL_ID           NUMBER(10),
  COL_C_NAME       VARCHAR2(300),
  COL_E_NAME       VARCHAR2(200),
  SUBJECT_ID       NUMBER(10),
  COL_E_NAME_ALIAS VARCHAR2(1000)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on table ZENGCHENG.TT_TFUNCTION
  is '函数表';
comment on column ZENGCHENG.TT_TFUNCTION.FUNCTION_ID
  is '函数id';
comment on column ZENGCHENG.TT_TFUNCTION.FUNCTION_NAME
  is '函数名称';
comment on column ZENGCHENG.TT_TFUNCTION.S_TABLES_ID
  is '表名称id';
comment on column ZENGCHENG.TT_TFUNCTION.C_NAME
  is '表中文名称';
comment on column ZENGCHENG.TT_TFUNCTION.E_NAME
  is '表英文名称';
comment on column ZENGCHENG.TT_TFUNCTION.COL_ID
  is '字段ID';
comment on column ZENGCHENG.TT_TFUNCTION.COL_C_NAME
  is '函数字段中';
comment on column ZENGCHENG.TT_TFUNCTION.COL_E_NAME
  is '函数字段英';
comment on column ZENGCHENG.TT_TFUNCTION.SUBJECT_ID
  is '主题ID';
comment on column ZENGCHENG.TT_TFUNCTION.COL_E_NAME_ALIAS
  is '别名';
alter table ZENGCHENG.TT_TFUNCTION
  add constraint PK_TT_FUNCTION primary key (FUNCTION_ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table ZENGCHENG.TT_TFUNCTION
  add constraint FK_TT_FUNCT_REFERENCE_TT_SUBJE foreign key (SUBJECT_ID)
  references ZENGCHENG.TT_TSUBJECT (SUBJECT_ID);

prompt
prompt Creating table TT_TGROUP
prompt ========================
prompt
create table ZENGCHENG.TT_TGROUP
(
  GROUP_ID         NUMBER(10) not null,
  S_TABLES_ID      NUMBER(10),
  C_NAME           VARCHAR2(3000),
  E_NAME           VARCHAR2(1000),
  GROUP_COL_ID     NUMBER(10),
  COL_C_NAME       VARCHAR2(300),
  COL_E_NAME       VARCHAR2(200),
  SUBJECT_ID       NUMBER(10),
  COL_E_NAME_ALIAS VARCHAR2(1000)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column ZENGCHENG.TT_TGROUP.GROUP_ID
  is '分组id';
comment on column ZENGCHENG.TT_TGROUP.S_TABLES_ID
  is '表名称id';
comment on column ZENGCHENG.TT_TGROUP.C_NAME
  is '表中文名称';
comment on column ZENGCHENG.TT_TGROUP.E_NAME
  is '表英文名称';
comment on column ZENGCHENG.TT_TGROUP.GROUP_COL_ID
  is '分组列id';
comment on column ZENGCHENG.TT_TGROUP.COL_C_NAME
  is '分组字段中';
comment on column ZENGCHENG.TT_TGROUP.COL_E_NAME
  is '分组字段英';
comment on column ZENGCHENG.TT_TGROUP.SUBJECT_ID
  is '主题id';
comment on column ZENGCHENG.TT_TGROUP.COL_E_NAME_ALIAS
  is '别名';
alter table ZENGCHENG.TT_TGROUP
  add constraint PK_TT_GROUP primary key (GROUP_ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table ZENGCHENG.TT_TGROUP
  add constraint FK_TT_GROUP_REFERENCE_TT_SUBJE foreign key (SUBJECT_ID)
  references ZENGCHENG.TT_TSUBJECT (SUBJECT_ID);

prompt
prompt Creating table TT_TORDER
prompt ========================
prompt
create table ZENGCHENG.TT_TORDER
(
  ORDER_ID     NUMBER(10) not null,
  TABLE_NAME   VARCHAR2(100),
  C_NAME       VARCHAR2(100),
  E_NAME       VARCHAR2(100),
  ORDER_COL_ID NUMBER(10),
  COL_C_NAME   VARCHAR2(200),
  COL_E_NAME   VARCHAR2(100),
  ORDER_DCT    VARCHAR2(10),
  SUBJECT_ID   NUMBER(10)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on table ZENGCHENG.TT_TORDER
  is '排序表';
comment on column ZENGCHENG.TT_TORDER.ORDER_ID
  is '排序ID';
comment on column ZENGCHENG.TT_TORDER.TABLE_NAME
  is '表名称id';
comment on column ZENGCHENG.TT_TORDER.C_NAME
  is '表中文名称';
comment on column ZENGCHENG.TT_TORDER.E_NAME
  is '表英文名称';
comment on column ZENGCHENG.TT_TORDER.ORDER_COL_ID
  is '排序字段id';
comment on column ZENGCHENG.TT_TORDER.COL_C_NAME
  is '排序字段中';
comment on column ZENGCHENG.TT_TORDER.COL_E_NAME
  is '排序字段英';
comment on column ZENGCHENG.TT_TORDER.ORDER_DCT
  is '排序方向';
comment on column ZENGCHENG.TT_TORDER.SUBJECT_ID
  is '主题ID';
alter table ZENGCHENG.TT_TORDER
  add constraint PK_TT_ORDER primary key (ORDER_ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table TT_TREPORT
prompt =========================
prompt
create table ZENGCHENG.TT_TREPORT
(
  TREPORT_ID  NUMBER(16) not null,
  REPORT_NAME VARCHAR2(200),
  RETYPE_ID   NUMBER(16),
  SETMAN      VARCHAR2(50),
  SETDATE     DATE default SYSDATE,
  IS_DEL      NUMBER(2) default 0,
  SQL_CODE    CLOB,
  MODIFYDATE  DATE default SYSDATE,
  IS_PRIVATE  VARCHAR2(5) default 0,
  USERID      NUMBER(16)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on table ZENGCHENG.TT_TREPORT
  is '报表（tt_treport）';
comment on column ZENGCHENG.TT_TREPORT.REPORT_NAME
  is '报表名称(report_name)';
comment on column ZENGCHENG.TT_TREPORT.RETYPE_ID
  is '分类(reType_id)';
comment on column ZENGCHENG.TT_TREPORT.SETMAN
  is '创建人(setman)';
comment on column ZENGCHENG.TT_TREPORT.SETDATE
  is '创建时间(setdate)';
comment on column ZENGCHENG.TT_TREPORT.IS_DEL
  is '是否删除(is_del)：0：未删除；1：删除';
comment on column ZENGCHENG.TT_TREPORT.SQL_CODE
  is 'SQL语句';
comment on column ZENGCHENG.TT_TREPORT.MODIFYDATE
  is '最后修改时间';
comment on column ZENGCHENG.TT_TREPORT.IS_PRIVATE
  is '私有/公开  0私有；1公开';
comment on column ZENGCHENG.TT_TREPORT.USERID
  is '创建人id';
alter table ZENGCHENG.TT_TREPORT
  add constraint PK_TT_TREPORT primary key (TREPORT_ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table TT_TSQL
prompt ======================
prompt
create table ZENGCHENG.TT_TSQL
(
  SQL_ID      NUMBER(10) not null,
  SQL_CONTENT CLOB,
  SUBJECT_ID  NUMBER(10)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 3M
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column ZENGCHENG.TT_TSQL.SQL_CONTENT
  is 'SQL内容';
comment on column ZENGCHENG.TT_TSQL.SUBJECT_ID
  is '主题ID';
alter table ZENGCHENG.TT_TSQL
  add constraint PK_TT_SQL primary key (SQL_ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table ZENGCHENG.TT_TSQL
  add constraint FK_TT_SQL_REFERENCE_TT_SUBJE foreign key (SUBJECT_ID)
  references ZENGCHENG.TT_TSUBJECT (SUBJECT_ID);

prompt
prompt Creating table TT_TUSESQL
prompt =========================
prompt
create table ZENGCHENG.TT_TUSESQL
(
  USESQL_ID      NUMBER(10) not null,
  SQL_CONTENT    CLOB,
  USE_SUBJECT_ID NUMBER(10)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 576K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column ZENGCHENG.TT_TUSESQL.SQL_CONTENT
  is 'SQL内容';
comment on column ZENGCHENG.TT_TUSESQL.USE_SUBJECT_ID
  is '使用主题ID';
alter table ZENGCHENG.TT_TUSESQL
  add constraint PK_TT_TUSESQL primary key (USESQL_ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table TT_TWHERE
prompt ========================
prompt
create table ZENGCHENG.TT_TWHERE
(
  WHERE_ID       NUMBER(10) not null,
  L_BRACKET      VARCHAR2(10),
  S_TABLES_ID    NUMBER(10),
  E_NAME         VARCHAR2(100),
  C_NAME         VARCHAR2(100),
  INCLUDE_COL_ID NUMBER(10) not null,
  COL_E_NAME     VARCHAR2(100),
  COL_C_NAME     VARCHAR2(200),
  OPERATOR       VARCHAR2(10),
  COL_VALUE      CLOB,
  R_BRACKET      VARCHAR2(10),
  CONNECTOR      VARCHAR2(20),
  SUBJECT_ID     NUMBER(10)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 576K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on table ZENGCHENG.TT_TWHERE
  is 'SQL条件';
comment on column ZENGCHENG.TT_TWHERE.WHERE_ID
  is '条件';
comment on column ZENGCHENG.TT_TWHERE.L_BRACKET
  is '左括号';
comment on column ZENGCHENG.TT_TWHERE.S_TABLES_ID
  is '表名称id';
comment on column ZENGCHENG.TT_TWHERE.E_NAME
  is '表英文名称';
comment on column ZENGCHENG.TT_TWHERE.C_NAME
  is '表中文名称';
comment on column ZENGCHENG.TT_TWHERE.INCLUDE_COL_ID
  is '字段ID';
comment on column ZENGCHENG.TT_TWHERE.COL_E_NAME
  is '列英名称';
comment on column ZENGCHENG.TT_TWHERE.COL_C_NAME
  is '列中名称';
comment on column ZENGCHENG.TT_TWHERE.OPERATOR
  is '操作符';
comment on column ZENGCHENG.TT_TWHERE.COL_VALUE
  is '条件值';
comment on column ZENGCHENG.TT_TWHERE.R_BRACKET
  is '右括号';
comment on column ZENGCHENG.TT_TWHERE.CONNECTOR
  is '连接符';
comment on column ZENGCHENG.TT_TWHERE.SUBJECT_ID
  is '主题ID';
alter table ZENGCHENG.TT_TWHERE
  add constraint PK_TT_WHERE primary key (WHERE_ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 128K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table ZENGCHENG.TT_TWHERE
  add constraint FK_TT_WHERE_REFERENCE_TT_SUBJE foreign key (SUBJECT_ID)
  references ZENGCHENG.TT_TSUBJECT (SUBJECT_ID);

prompt
prompt Creating table TT_USEFUNCTION
prompt =============================
prompt
create table ZENGCHENG.TT_USEFUNCTION
(
  FUNCTION_ID   NUMBER(10) not null,
  FUNCTION_NAME VARCHAR2(50),
  S_TABLES_ID   NUMBER(10),
  C_NAME        VARCHAR2(500),
  E_NAME        VARCHAR2(100),
  COL_ID        NUMBER(10),
  COL_C_NAME    VARCHAR2(1000),
  COL_E_NAME    VARCHAR2(300),
  USESUBJECT_ID NUMBER(10)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on table ZENGCHENG.TT_USEFUNCTION
  is '使用主题函数表';
comment on column ZENGCHENG.TT_USEFUNCTION.FUNCTION_ID
  is '函数id';
comment on column ZENGCHENG.TT_USEFUNCTION.FUNCTION_NAME
  is '函数名称';
comment on column ZENGCHENG.TT_USEFUNCTION.S_TABLES_ID
  is '表名称id';
comment on column ZENGCHENG.TT_USEFUNCTION.C_NAME
  is '表中文名称';
comment on column ZENGCHENG.TT_USEFUNCTION.E_NAME
  is '表英文名称';
comment on column ZENGCHENG.TT_USEFUNCTION.COL_ID
  is '字段ID';
comment on column ZENGCHENG.TT_USEFUNCTION.COL_C_NAME
  is '函数字段中';
comment on column ZENGCHENG.TT_USEFUNCTION.COL_E_NAME
  is '函数字段英';
comment on column ZENGCHENG.TT_USEFUNCTION.USESUBJECT_ID
  is '使用主题ID';
alter table ZENGCHENG.TT_USEFUNCTION
  add constraint PK_TT_USEFUNCTION primary key (FUNCTION_ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table TT_USEGROUP
prompt ==========================
prompt
create table ZENGCHENG.TT_USEGROUP
(
  GROUP_ID      NUMBER(10) not null,
  S_TABLES_ID   NUMBER(10),
  C_NAME        VARCHAR2(3000),
  E_NAME        VARCHAR2(1000),
  GROUP_COL_ID  NUMBER(10),
  COL_C_NAME    VARCHAR2(1000),
  COL_E_NAME    VARCHAR2(300),
  USESUBJECT_ID NUMBER(10)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on table ZENGCHENG.TT_USEGROUP
  is '使用主题分组表(tt_useGroup)';
comment on column ZENGCHENG.TT_USEGROUP.GROUP_ID
  is '分组id';
comment on column ZENGCHENG.TT_USEGROUP.S_TABLES_ID
  is '表名称id';
comment on column ZENGCHENG.TT_USEGROUP.C_NAME
  is '表中文名称';
comment on column ZENGCHENG.TT_USEGROUP.E_NAME
  is '表英文名称';
comment on column ZENGCHENG.TT_USEGROUP.GROUP_COL_ID
  is '分组列id';
comment on column ZENGCHENG.TT_USEGROUP.COL_C_NAME
  is '分组字段中';
comment on column ZENGCHENG.TT_USEGROUP.COL_E_NAME
  is '分组字段英';
comment on column ZENGCHENG.TT_USEGROUP.USESUBJECT_ID
  is '使用主题id';
alter table ZENGCHENG.TT_USEGROUP
  add constraint PK_TT_USEGROUP primary key (GROUP_ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table TT_USE_COL
prompt =========================
prompt
create table ZENGCHENG.TT_USE_COL
(
  USE_COL_ID     NUMBER(10) not null,
  S_TABLES_ID    NUMBER(10),
  COL_C_NAME     VARCHAR2(300),
  COL_E_NAME     VARCHAR2(100),
  SUBJECT_ID     NUMBER(10),
  INCLUDE_COL_ID NUMBER(10),
  USE_SUBJECT_ID NUMBER(10)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 832K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on table ZENGCHENG.TT_USE_COL
  is '使用主题字段表';
comment on column ZENGCHENG.TT_USE_COL.S_TABLES_ID
  is '表名称id';
comment on column ZENGCHENG.TT_USE_COL.COL_C_NAME
  is '字段中文名';
comment on column ZENGCHENG.TT_USE_COL.COL_E_NAME
  is '字段英文名';
comment on column ZENGCHENG.TT_USE_COL.SUBJECT_ID
  is '主题表ID';
comment on column ZENGCHENG.TT_USE_COL.INCLUDE_COL_ID
  is '主题字段ID';
comment on column ZENGCHENG.TT_USE_COL.USE_SUBJECT_ID
  is '使用主题id';
alter table ZENGCHENG.TT_USE_COL
  add constraint PK_TT_USE_COL primary key (USE_COL_ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 256K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table TT_USE_ORDER
prompt ===========================
prompt
create table ZENGCHENG.TT_USE_ORDER
(
  USE_ORDER_ID   NUMBER(10) not null,
  S_TABLES_ID    NUMBER(10),
  C_NAME         VARCHAR2(100),
  E_NAME         VARCHAR2(100),
  ORDER_COL_ID   NUMBER(10),
  COL_C_NAME     VARCHAR2(200),
  COL_E_NAME     VARCHAR2(100),
  ORDER_DCT      VARCHAR2(10),
  SUBJECT_ID     NUMBER(10),
  USE_SUBJECT_ID NUMBER(10)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on table ZENGCHENG.TT_USE_ORDER
  is '使用主题排序表';
comment on column ZENGCHENG.TT_USE_ORDER.USE_ORDER_ID
  is '排序ID';
comment on column ZENGCHENG.TT_USE_ORDER.S_TABLES_ID
  is '表名称id';
comment on column ZENGCHENG.TT_USE_ORDER.C_NAME
  is '表中文名称';
comment on column ZENGCHENG.TT_USE_ORDER.E_NAME
  is '表英文名称';
comment on column ZENGCHENG.TT_USE_ORDER.ORDER_COL_ID
  is '排序字段id';
comment on column ZENGCHENG.TT_USE_ORDER.COL_C_NAME
  is '排序字段中';
comment on column ZENGCHENG.TT_USE_ORDER.COL_E_NAME
  is '排序字段英';
comment on column ZENGCHENG.TT_USE_ORDER.ORDER_DCT
  is '排序方向';
comment on column ZENGCHENG.TT_USE_ORDER.SUBJECT_ID
  is '主题ID';
comment on column ZENGCHENG.TT_USE_ORDER.USE_SUBJECT_ID
  is '使用主题ID';
alter table ZENGCHENG.TT_USE_ORDER
  add constraint PK_TT_USE_ORDER primary key (USE_ORDER_ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table TT_USE_SUBJECT
prompt =============================
prompt
create table ZENGCHENG.TT_USE_SUBJECT
(
  USE_SUBJECT_ID   NUMBER(10) not null,
  TYPE_ID          NUMBER(10),
  SUBJECT_ID       NUMBER(10),
  USE_SUBJECT_NAME VARCHAR2(100),
  SETMAN           VARCHAR2(20),
  SETDATE          DATE,
  IS_DEL           NUMBER(1)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on table ZENGCHENG.TT_USE_SUBJECT
  is '使用主题表';
comment on column ZENGCHENG.TT_USE_SUBJECT.TYPE_ID
  is '主题分类ID';
comment on column ZENGCHENG.TT_USE_SUBJECT.SUBJECT_ID
  is '主题ID';
comment on column ZENGCHENG.TT_USE_SUBJECT.USE_SUBJECT_NAME
  is '使用主题名称';
comment on column ZENGCHENG.TT_USE_SUBJECT.SETMAN
  is '创建者';
comment on column ZENGCHENG.TT_USE_SUBJECT.SETDATE
  is '创建时间';
comment on column ZENGCHENG.TT_USE_SUBJECT.IS_DEL
  is '是否删除(0：否，1：是)';
alter table ZENGCHENG.TT_USE_SUBJECT
  add constraint PK_TT_USE_SUBJECT primary key (USE_SUBJECT_ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table TT_USE_WHERE
prompt ===========================
prompt
create table ZENGCHENG.TT_USE_WHERE
(
  USE_WHERE_ID   NUMBER(10) not null,
  L_BRACKET      VARCHAR2(10),
  S_TABLES_ID    NUMBER(10),
  E_NAME         VARCHAR2(100),
  C_NAME         VARCHAR2(100),
  INCLUDE_COL_ID NUMBER(10) not null,
  COL_E_NAME     VARCHAR2(100),
  COL_C_NAME     VARCHAR2(200),
  OPERATOR       VARCHAR2(50),
  COL_VALUE      CLOB,
  R_BRACKET      VARCHAR2(10),
  CONNECTOR      VARCHAR2(20),
  SUBJECT_ID     NUMBER(10),
  USE_SUBJECT_ID NUMBER(10)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 128K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on table ZENGCHENG.TT_USE_WHERE
  is '使用主题SQL条件';
comment on column ZENGCHENG.TT_USE_WHERE.USE_WHERE_ID
  is '条件';
comment on column ZENGCHENG.TT_USE_WHERE.L_BRACKET
  is '左括号';
comment on column ZENGCHENG.TT_USE_WHERE.S_TABLES_ID
  is '表名称id';
comment on column ZENGCHENG.TT_USE_WHERE.E_NAME
  is '表英文名称';
comment on column ZENGCHENG.TT_USE_WHERE.C_NAME
  is '表中文名称';
comment on column ZENGCHENG.TT_USE_WHERE.INCLUDE_COL_ID
  is '字段ID';
comment on column ZENGCHENG.TT_USE_WHERE.COL_E_NAME
  is '列英名称';
comment on column ZENGCHENG.TT_USE_WHERE.COL_C_NAME
  is '列中名称';
comment on column ZENGCHENG.TT_USE_WHERE.OPERATOR
  is '操作符';
comment on column ZENGCHENG.TT_USE_WHERE.COL_VALUE
  is '条件值';
comment on column ZENGCHENG.TT_USE_WHERE.R_BRACKET
  is '右括号';
comment on column ZENGCHENG.TT_USE_WHERE.CONNECTOR
  is '连接符';
comment on column ZENGCHENG.TT_USE_WHERE.SUBJECT_ID
  is '主题ID';
comment on column ZENGCHENG.TT_USE_WHERE.USE_SUBJECT_ID
  is '使用主题id';
alter table ZENGCHENG.TT_USE_WHERE
  add constraint PK_TT_USE_WHERE primary key (USE_WHERE_ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table TT_WHERE_COL
prompt ===========================
prompt
create table ZENGCHENG.TT_WHERE_COL
(
  WHERE_COL_ID     NUMBER(10) not null,
  S_TABLES_ID      NUMBER(10),
  E_NAME           VARCHAR2(100),
  C_NAME           VARCHAR2(100),
  INCLUDE_COL_ID   NUMBER(10) not null,
  COL_C_NAME       VARCHAR2(250),
  COL_E_NAME       VARCHAR2(100),
  SUBJECT_ID       NUMBER(10),
  COL_E_NAME_ALIAS VARCHAR2(50)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 10M
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on table ZENGCHENG.TT_WHERE_COL
  is '包含表字段';
comment on column ZENGCHENG.TT_WHERE_COL.WHERE_COL_ID
  is '条件字段ID';
comment on column ZENGCHENG.TT_WHERE_COL.S_TABLES_ID
  is '表名称id';
comment on column ZENGCHENG.TT_WHERE_COL.E_NAME
  is '表英文名称';
comment on column ZENGCHENG.TT_WHERE_COL.C_NAME
  is '表中文名称';
comment on column ZENGCHENG.TT_WHERE_COL.INCLUDE_COL_ID
  is '字段ID';
comment on column ZENGCHENG.TT_WHERE_COL.COL_C_NAME
  is '字段中文名';
comment on column ZENGCHENG.TT_WHERE_COL.COL_E_NAME
  is '字段英文名';
comment on column ZENGCHENG.TT_WHERE_COL.SUBJECT_ID
  is '主题表ID';
comment on column ZENGCHENG.TT_WHERE_COL.COL_E_NAME_ALIAS
  is '????';
alter table ZENGCHENG.TT_WHERE_COL
  add constraint PK_TT_WHERE_COL primary key (WHERE_COL_ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 3M
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table ZENGCHENG.TT_WHERE_COL
  add constraint FK_T2_WHERE_REFERENCE_TT_SUBJE foreign key (SUBJECT_ID)
  references ZENGCHENG.TT_TSUBJECT (SUBJECT_ID);

prompt
prompt Creating table TT_ZBTYPE
prompt ========================
prompt
create table ZENGCHENG.TT_ZBTYPE
(
  TYPE_ID   NUMBER(10),
  TYPE_PID  NUMBER(10),
  TYPE_NAME VARCHAR2(1000),
  WEIGHT    NUMBER(10,6),
  NCREATE   VARCHAR2(50),
  IS_DEL    NUMBER(10)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column ZENGCHENG.TT_ZBTYPE.TYPE_ID
  is '分类id';
comment on column ZENGCHENG.TT_ZBTYPE.TYPE_PID
  is '分类父id';
comment on column ZENGCHENG.TT_ZBTYPE.TYPE_NAME
  is '分类名称';
comment on column ZENGCHENG.TT_ZBTYPE.WEIGHT
  is '权重';
comment on column ZENGCHENG.TT_ZBTYPE.NCREATE
  is '创建人';
comment on column ZENGCHENG.TT_ZBTYPE.IS_DEL
  is '是否删除（1：删除。0未删除）';
create index ZENGCHENG.IDX_TT_ZBTYPE_TYPEID on ZENGCHENG.TT_ZBTYPE (TYPE_ID)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );


spool off
