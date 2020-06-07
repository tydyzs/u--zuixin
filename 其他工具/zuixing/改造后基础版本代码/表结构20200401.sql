----------------------------------------------------
-- Export file for user CLM                       --
-- Created by Administrator on 2020/4/1, 12:47:22 --
----------------------------------------------------

set define off
spool ��ṹ20200401.log

prompt
prompt Creating table ACT_APP_DEPLOYMENT
prompt =================================
prompt
create table CLM.ACT_APP_DEPLOYMENT
(
  id_          VARCHAR2(255) not null,
  name_        VARCHAR2(255),
  category_    VARCHAR2(255),
  key_         VARCHAR2(255),
  deploy_time_ TIMESTAMP(6),
  tenant_id_   VARCHAR2(255) default ''
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
alter table CLM.ACT_APP_DEPLOYMENT
  add constraint PK_ACT_APP_DEPLOYMENT primary key (ID_)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table ACT_APP_APPDEF
prompt =============================
prompt
create table CLM.ACT_APP_APPDEF
(
  id_            VARCHAR2(255) not null,
  rev_           INTEGER not null,
  name_          VARCHAR2(255),
  key_           VARCHAR2(255) not null,
  version_       INTEGER not null,
  category_      VARCHAR2(255),
  deployment_id_ VARCHAR2(255),
  resource_name_ VARCHAR2(4000),
  description_   VARCHAR2(4000),
  tenant_id_     VARCHAR2(255) default ''
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
create index CLM.ACT_IDX_APP_DEF_DPLY on CLM.ACT_APP_APPDEF (DEPLOYMENT_ID_)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
create unique index CLM.ACT_IDX_APP_DEF_UNIQ on CLM.ACT_APP_APPDEF (KEY_, VERSION_, TENANT_ID_)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
alter table CLM.ACT_APP_APPDEF
  add constraint PK_ACT_APP_APPDEF primary key (ID_)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
alter table CLM.ACT_APP_APPDEF
  add constraint ACT_FK_APP_DEF_DPLY foreign key (DEPLOYMENT_ID_)
  references CLM.ACT_APP_DEPLOYMENT (ID_);

prompt
prompt Creating table ACT_APP_DATABASECHANGELOG
prompt ========================================
prompt
create table CLM.ACT_APP_DATABASECHANGELOG
(
  id            VARCHAR2(255) not null,
  author        VARCHAR2(255) not null,
  filename      VARCHAR2(255) not null,
  dateexecuted  TIMESTAMP(6) not null,
  orderexecuted INTEGER not null,
  exectype      VARCHAR2(10) not null,
  md5sum        VARCHAR2(35),
  description   VARCHAR2(255),
  comments      VARCHAR2(255),
  tag           VARCHAR2(255),
  liquibase     VARCHAR2(20),
  contexts      VARCHAR2(255),
  labels        VARCHAR2(255),
  deployment_id VARCHAR2(10)
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
prompt Creating table ACT_APP_DATABASECHANGELOGLOCK
prompt ============================================
prompt
create table CLM.ACT_APP_DATABASECHANGELOGLOCK
(
  id          INTEGER not null,
  locked      NUMBER(1) not null,
  lockgranted TIMESTAMP(6),
  lockedby    VARCHAR2(255)
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
alter table CLM.ACT_APP_DATABASECHANGELOGLOCK
  add constraint PK_ACT_APP_DATABASECHANGELOGLO primary key (ID)
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
prompt Creating table ACT_APP_DEPLOYMENT_RESOURCE
prompt ==========================================
prompt
create table CLM.ACT_APP_DEPLOYMENT_RESOURCE
(
  id_             VARCHAR2(255) not null,
  name_           VARCHAR2(255),
  deployment_id_  VARCHAR2(255),
  resource_bytes_ BLOB
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
create index CLM.ACT_IDX_APP_RSRC_DPL on CLM.ACT_APP_DEPLOYMENT_RESOURCE (DEPLOYMENT_ID_)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
alter table CLM.ACT_APP_DEPLOYMENT_RESOURCE
  add constraint PK_APP_DEPLOYMENT_RESOURCE primary key (ID_)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
alter table CLM.ACT_APP_DEPLOYMENT_RESOURCE
  add constraint ACT_FK_APP_RSRC_DPL foreign key (DEPLOYMENT_ID_)
  references CLM.ACT_APP_DEPLOYMENT (ID_);

prompt
prompt Creating table ACT_CMMN_DEPLOYMENT
prompt ==================================
prompt
create table CLM.ACT_CMMN_DEPLOYMENT
(
  id_                   VARCHAR2(255) not null,
  name_                 VARCHAR2(255),
  category_             VARCHAR2(255),
  key_                  VARCHAR2(255),
  deploy_time_          TIMESTAMP(6),
  parent_deployment_id_ VARCHAR2(255),
  tenant_id_            VARCHAR2(255) default ''
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
alter table CLM.ACT_CMMN_DEPLOYMENT
  add constraint PK_ACT_CMMN_DEPLOYMENT primary key (ID_)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table ACT_CMMN_CASEDEF
prompt ===============================
prompt
create table CLM.ACT_CMMN_CASEDEF
(
  id_                     VARCHAR2(255) not null,
  rev_                    INTEGER not null,
  name_                   VARCHAR2(255),
  key_                    VARCHAR2(255) not null,
  version_                INTEGER not null,
  category_               VARCHAR2(255),
  deployment_id_          VARCHAR2(255),
  resource_name_          VARCHAR2(4000),
  description_            VARCHAR2(4000),
  has_graphical_notation_ NUMBER(1),
  tenant_id_              VARCHAR2(255) default '',
  dgrm_resource_name_     VARCHAR2(4000),
  has_start_form_key_     NUMBER(1)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
create index CLM.ACT_IDX_CASE_DEF_DPLY on CLM.ACT_CMMN_CASEDEF (DEPLOYMENT_ID_)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
create unique index CLM.ACT_IDX_CASE_DEF_UNIQ on CLM.ACT_CMMN_CASEDEF (KEY_, VERSION_, TENANT_ID_)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
alter table CLM.ACT_CMMN_CASEDEF
  add constraint PK_ACT_CMMN_CASEDEF primary key (ID_)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
alter table CLM.ACT_CMMN_CASEDEF
  add constraint ACT_FK_CASE_DEF_DPLY foreign key (DEPLOYMENT_ID_)
  references CLM.ACT_CMMN_DEPLOYMENT (ID_);

prompt
prompt Creating table ACT_CMMN_DATABASECHANGELOG
prompt =========================================
prompt
create table CLM.ACT_CMMN_DATABASECHANGELOG
(
  id            VARCHAR2(255) not null,
  author        VARCHAR2(255) not null,
  filename      VARCHAR2(255) not null,
  dateexecuted  TIMESTAMP(6) not null,
  orderexecuted INTEGER not null,
  exectype      VARCHAR2(10) not null,
  md5sum        VARCHAR2(35),
  description   VARCHAR2(255),
  comments      VARCHAR2(255),
  tag           VARCHAR2(255),
  liquibase     VARCHAR2(20),
  contexts      VARCHAR2(255),
  labels        VARCHAR2(255),
  deployment_id VARCHAR2(10)
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
prompt Creating table ACT_CMMN_DATABASECHANGELOGLOCK
prompt =============================================
prompt
create table CLM.ACT_CMMN_DATABASECHANGELOGLOCK
(
  id          INTEGER not null,
  locked      NUMBER(1) not null,
  lockgranted TIMESTAMP(6),
  lockedby    VARCHAR2(255)
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
alter table CLM.ACT_CMMN_DATABASECHANGELOGLOCK
  add constraint PK_ACT_CMMN_DATABASECHANGELOGL primary key (ID)
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
prompt Creating table ACT_CMMN_DEPLOYMENT_RESOURCE
prompt ===========================================
prompt
create table CLM.ACT_CMMN_DEPLOYMENT_RESOURCE
(
  id_             VARCHAR2(255) not null,
  name_           VARCHAR2(255),
  deployment_id_  VARCHAR2(255),
  resource_bytes_ BLOB,
  generated_      NUMBER(1)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
create index CLM.ACT_IDX_CMMN_RSRC_DPL on CLM.ACT_CMMN_DEPLOYMENT_RESOURCE (DEPLOYMENT_ID_)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
alter table CLM.ACT_CMMN_DEPLOYMENT_RESOURCE
  add constraint PK_CMMN_DEPLOYMENT_RESOURCE primary key (ID_)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
alter table CLM.ACT_CMMN_DEPLOYMENT_RESOURCE
  add constraint ACT_FK_CMMN_RSRC_DPL foreign key (DEPLOYMENT_ID_)
  references CLM.ACT_CMMN_DEPLOYMENT (ID_);

prompt
prompt Creating table ACT_CMMN_HI_CASE_INST
prompt ====================================
prompt
create table CLM.ACT_CMMN_HI_CASE_INST
(
  id_             VARCHAR2(255) not null,
  rev_            INTEGER not null,
  business_key_   VARCHAR2(255),
  name_           VARCHAR2(255),
  parent_id_      VARCHAR2(255),
  case_def_id_    VARCHAR2(255),
  state_          VARCHAR2(255),
  start_time_     TIMESTAMP(6),
  end_time_       TIMESTAMP(6),
  start_user_id_  VARCHAR2(255),
  callback_id_    VARCHAR2(255),
  callback_type_  VARCHAR2(255),
  tenant_id_      VARCHAR2(255) default '',
  reference_id_   VARCHAR2(255),
  reference_type_ VARCHAR2(255)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
alter table CLM.ACT_CMMN_HI_CASE_INST
  add constraint PK_ACT_CMMN_HI_CASE_INST primary key (ID_)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table ACT_CMMN_HI_MIL_INST
prompt ===================================
prompt
create table CLM.ACT_CMMN_HI_MIL_INST
(
  id_           VARCHAR2(255) not null,
  rev_          INTEGER not null,
  name_         VARCHAR2(255) not null,
  time_stamp_   TIMESTAMP(6) not null,
  case_inst_id_ VARCHAR2(255) not null,
  case_def_id_  VARCHAR2(255) not null,
  element_id_   VARCHAR2(255) not null,
  tenant_id_    VARCHAR2(255) default ''
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
alter table CLM.ACT_CMMN_HI_MIL_INST
  add constraint PK_ACT_CMMN_HI_MIL_INST primary key (ID_)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table ACT_CMMN_HI_PLAN_ITEM_INST
prompt =========================================
prompt
create table CLM.ACT_CMMN_HI_PLAN_ITEM_INST
(
  id_                   VARCHAR2(255) not null,
  rev_                  INTEGER not null,
  name_                 VARCHAR2(255),
  state_                VARCHAR2(255),
  case_def_id_          VARCHAR2(255),
  case_inst_id_         VARCHAR2(255),
  stage_inst_id_        VARCHAR2(255),
  is_stage_             NUMBER(1),
  element_id_           VARCHAR2(255),
  item_definition_id_   VARCHAR2(255),
  item_definition_type_ VARCHAR2(255),
  create_time_          TIMESTAMP(6),
  last_available_time_  TIMESTAMP(6),
  last_enabled_time_    TIMESTAMP(6),
  last_disabled_time_   TIMESTAMP(6),
  last_started_time_    TIMESTAMP(6),
  last_suspended_time_  TIMESTAMP(6),
  completed_time_       TIMESTAMP(6),
  occurred_time_        TIMESTAMP(6),
  terminated_time_      TIMESTAMP(6),
  exit_time_            TIMESTAMP(6),
  ended_time_           TIMESTAMP(6),
  last_updated_time_    TIMESTAMP(6),
  start_user_id_        VARCHAR2(255),
  reference_id_         VARCHAR2(255),
  reference_type_       VARCHAR2(255),
  tenant_id_            VARCHAR2(255) default '',
  entry_criterion_id_   VARCHAR2(255),
  exit_criterion_id_    VARCHAR2(255),
  show_in_overview_     NUMBER(1),
  extra_value_          VARCHAR2(255),
  derived_case_def_id_  VARCHAR2(255)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
alter table CLM.ACT_CMMN_HI_PLAN_ITEM_INST
  add constraint PK_ACT_CMMN_HI_PLAN_ITEM_INST primary key (ID_)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table ACT_CMMN_RU_CASE_INST
prompt ====================================
prompt
create table CLM.ACT_CMMN_RU_CASE_INST
(
  id_              VARCHAR2(255) not null,
  rev_             INTEGER not null,
  business_key_    VARCHAR2(255),
  name_            VARCHAR2(255),
  parent_id_       VARCHAR2(255),
  case_def_id_     VARCHAR2(255),
  state_           VARCHAR2(255),
  start_time_      TIMESTAMP(6),
  start_user_id_   VARCHAR2(255),
  callback_id_     VARCHAR2(255),
  callback_type_   VARCHAR2(255),
  tenant_id_       VARCHAR2(255) default '',
  lock_time_       TIMESTAMP(6),
  is_completeable_ NUMBER(1),
  reference_id_    VARCHAR2(255),
  reference_type_  VARCHAR2(255)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
create index CLM.ACT_IDX_CASE_INST_CASE_DEF on CLM.ACT_CMMN_RU_CASE_INST (CASE_DEF_ID_)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
create index CLM.ACT_IDX_CASE_INST_PARENT on CLM.ACT_CMMN_RU_CASE_INST (PARENT_ID_)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
create index CLM.ACT_IDX_CASE_INST_REF_ID_ on CLM.ACT_CMMN_RU_CASE_INST (REFERENCE_ID_)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
alter table CLM.ACT_CMMN_RU_CASE_INST
  add constraint PK_ACT_CMMN_RU_CASE_INST primary key (ID_)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
alter table CLM.ACT_CMMN_RU_CASE_INST
  add constraint ACT_FK_CASE_INST_CASE_DEF foreign key (CASE_DEF_ID_)
  references CLM.ACT_CMMN_CASEDEF (ID_);

prompt
prompt Creating table ACT_CMMN_RU_MIL_INST
prompt ===================================
prompt
create table CLM.ACT_CMMN_RU_MIL_INST
(
  id_           VARCHAR2(255) not null,
  name_         VARCHAR2(255) not null,
  time_stamp_   TIMESTAMP(6) not null,
  case_inst_id_ VARCHAR2(255) not null,
  case_def_id_  VARCHAR2(255) not null,
  element_id_   VARCHAR2(255) not null,
  tenant_id_    VARCHAR2(255) default ''
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
create index CLM.ACT_IDX_MIL_CASE_DEF on CLM.ACT_CMMN_RU_MIL_INST (CASE_DEF_ID_)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
create index CLM.ACT_IDX_MIL_CASE_INST on CLM.ACT_CMMN_RU_MIL_INST (CASE_INST_ID_)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
alter table CLM.ACT_CMMN_RU_MIL_INST
  add constraint PK_ACT_CMMN_RU_MIL_INST primary key (ID_)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
alter table CLM.ACT_CMMN_RU_MIL_INST
  add constraint ACT_FK_MIL_CASE_DEF foreign key (CASE_DEF_ID_)
  references CLM.ACT_CMMN_CASEDEF (ID_);
alter table CLM.ACT_CMMN_RU_MIL_INST
  add constraint ACT_FK_MIL_CASE_INST foreign key (CASE_INST_ID_)
  references CLM.ACT_CMMN_RU_CASE_INST (ID_);

prompt
prompt Creating table ACT_CMMN_RU_PLAN_ITEM_INST
prompt =========================================
prompt
create table CLM.ACT_CMMN_RU_PLAN_ITEM_INST
(
  id_                     VARCHAR2(255) not null,
  rev_                    INTEGER not null,
  case_def_id_            VARCHAR2(255),
  case_inst_id_           VARCHAR2(255),
  stage_inst_id_          VARCHAR2(255),
  is_stage_               NUMBER(1),
  element_id_             VARCHAR2(255),
  name_                   VARCHAR2(255),
  state_                  VARCHAR2(255),
  create_time_            TIMESTAMP(6),
  start_user_id_          VARCHAR2(255),
  reference_id_           VARCHAR2(255),
  reference_type_         VARCHAR2(255),
  tenant_id_              VARCHAR2(255) default '',
  item_definition_id_     VARCHAR2(255),
  item_definition_type_   VARCHAR2(255),
  is_completeable_        NUMBER(1),
  is_count_enabled_       NUMBER(1),
  var_count_              INTEGER,
  sentry_part_inst_count_ INTEGER,
  last_available_time_    TIMESTAMP(3),
  last_enabled_time_      TIMESTAMP(3),
  last_disabled_time_     TIMESTAMP(3),
  last_started_time_      TIMESTAMP(3),
  last_suspended_time_    TIMESTAMP(3),
  completed_time_         TIMESTAMP(3),
  occurred_time_          TIMESTAMP(3),
  terminated_time_        TIMESTAMP(3),
  exit_time_              TIMESTAMP(3),
  ended_time_             TIMESTAMP(3),
  entry_criterion_id_     VARCHAR2(255),
  exit_criterion_id_      VARCHAR2(255),
  extra_value_            VARCHAR2(255),
  derived_case_def_id_    VARCHAR2(255)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
create index CLM.ACT_IDX_PLAN_ITEM_CASE_DEF on CLM.ACT_CMMN_RU_PLAN_ITEM_INST (CASE_DEF_ID_)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
create index CLM.ACT_IDX_PLAN_ITEM_CASE_INST on CLM.ACT_CMMN_RU_PLAN_ITEM_INST (CASE_INST_ID_)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
create index CLM.ACT_IDX_PLAN_ITEM_STAGE_INST on CLM.ACT_CMMN_RU_PLAN_ITEM_INST (STAGE_INST_ID_)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
alter table CLM.ACT_CMMN_RU_PLAN_ITEM_INST
  add constraint PK_CMMN_PLAN_ITEM_INST primary key (ID_)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
alter table CLM.ACT_CMMN_RU_PLAN_ITEM_INST
  add constraint ACT_FK_PLAN_ITEM_CASE_DEF foreign key (CASE_DEF_ID_)
  references CLM.ACT_CMMN_CASEDEF (ID_);
alter table CLM.ACT_CMMN_RU_PLAN_ITEM_INST
  add constraint ACT_FK_PLAN_ITEM_CASE_INST foreign key (CASE_INST_ID_)
  references CLM.ACT_CMMN_RU_CASE_INST (ID_);

prompt
prompt Creating table ACT_CMMN_RU_SENTRY_PART_INST
prompt ===========================================
prompt
create table CLM.ACT_CMMN_RU_SENTRY_PART_INST
(
  id_                VARCHAR2(255) not null,
  rev_               INTEGER not null,
  case_def_id_       VARCHAR2(255),
  case_inst_id_      VARCHAR2(255),
  plan_item_inst_id_ VARCHAR2(255),
  on_part_id_        VARCHAR2(255),
  if_part_id_        VARCHAR2(255),
  time_stamp_        TIMESTAMP(6)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
create index CLM.ACT_IDX_SENTRY_CASE_DEF on CLM.ACT_CMMN_RU_SENTRY_PART_INST (CASE_DEF_ID_)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
create index CLM.ACT_IDX_SENTRY_CASE_INST on CLM.ACT_CMMN_RU_SENTRY_PART_INST (CASE_INST_ID_)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
create index CLM.ACT_IDX_SENTRY_PLAN_ITEM on CLM.ACT_CMMN_RU_SENTRY_PART_INST (PLAN_ITEM_INST_ID_)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
alter table CLM.ACT_CMMN_RU_SENTRY_PART_INST
  add constraint PK_CMMN_SENTRY_PART_INST primary key (ID_)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
alter table CLM.ACT_CMMN_RU_SENTRY_PART_INST
  add constraint ACT_FK_SENTRY_CASE_DEF foreign key (CASE_DEF_ID_)
  references CLM.ACT_CMMN_CASEDEF (ID_);
alter table CLM.ACT_CMMN_RU_SENTRY_PART_INST
  add constraint ACT_FK_SENTRY_CASE_INST foreign key (CASE_INST_ID_)
  references CLM.ACT_CMMN_RU_CASE_INST (ID_);
alter table CLM.ACT_CMMN_RU_SENTRY_PART_INST
  add constraint ACT_FK_SENTRY_PLAN_ITEM foreign key (PLAN_ITEM_INST_ID_)
  references CLM.ACT_CMMN_RU_PLAN_ITEM_INST (ID_);

prompt
prompt Creating table ACT_CO_CONTENT_ITEM
prompt ==================================
prompt
create table CLM.ACT_CO_CONTENT_ITEM
(
  id_                 VARCHAR2(255) not null,
  name_               VARCHAR2(255) not null,
  mime_type_          VARCHAR2(255),
  task_id_            VARCHAR2(255),
  proc_inst_id_       VARCHAR2(255),
  content_store_id_   VARCHAR2(255),
  content_store_name_ VARCHAR2(255),
  field_              VARCHAR2(400),
  content_available_  NUMBER(1) default 0,
  created_            TIMESTAMP(6),
  created_by_         VARCHAR2(255),
  last_modified_      TIMESTAMP(6),
  last_modified_by_   VARCHAR2(255),
  content_size_       NUMBER(38) default 0,
  tenant_id_          VARCHAR2(255),
  scope_id_           VARCHAR2(255),
  scope_type_         VARCHAR2(255)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
create index CLM.IDX_CONTITEM_PROCID on CLM.ACT_CO_CONTENT_ITEM (PROC_INST_ID_)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
create index CLM.IDX_CONTITEM_SCOPE on CLM.ACT_CO_CONTENT_ITEM (SCOPE_ID_, SCOPE_TYPE_)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
create index CLM.IDX_CONTITEM_TASKID on CLM.ACT_CO_CONTENT_ITEM (TASK_ID_)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
alter table CLM.ACT_CO_CONTENT_ITEM
  add constraint PK_ACT_CO_CONTENT_ITEM primary key (ID_)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table ACT_CO_DATABASECHANGELOG
prompt =======================================
prompt
create table CLM.ACT_CO_DATABASECHANGELOG
(
  id            VARCHAR2(255) not null,
  author        VARCHAR2(255) not null,
  filename      VARCHAR2(255) not null,
  dateexecuted  TIMESTAMP(6) not null,
  orderexecuted INTEGER not null,
  exectype      VARCHAR2(10) not null,
  md5sum        VARCHAR2(35),
  description   VARCHAR2(255),
  comments      VARCHAR2(255),
  tag           VARCHAR2(255),
  liquibase     VARCHAR2(20),
  contexts      VARCHAR2(255),
  labels        VARCHAR2(255),
  deployment_id VARCHAR2(10)
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
prompt Creating table ACT_CO_DATABASECHANGELOGLOCK
prompt ===========================================
prompt
create table CLM.ACT_CO_DATABASECHANGELOGLOCK
(
  id          INTEGER not null,
  locked      NUMBER(1) not null,
  lockgranted TIMESTAMP(6),
  lockedby    VARCHAR2(255)
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
alter table CLM.ACT_CO_DATABASECHANGELOGLOCK
  add constraint PK_ACT_CO_DATABASECHANGELOGLOC primary key (ID)
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
prompt Creating table ACT_DE_DATABASECHANGELOG
prompt =======================================
prompt
create table CLM.ACT_DE_DATABASECHANGELOG
(
  id            VARCHAR2(255) not null,
  author        VARCHAR2(255) not null,
  filename      VARCHAR2(255) not null,
  dateexecuted  TIMESTAMP(6) not null,
  orderexecuted INTEGER not null,
  exectype      VARCHAR2(10) not null,
  md5sum        VARCHAR2(35),
  description   VARCHAR2(255),
  comments      VARCHAR2(255),
  tag           VARCHAR2(255),
  liquibase     VARCHAR2(20),
  contexts      VARCHAR2(255),
  labels        VARCHAR2(255),
  deployment_id VARCHAR2(10)
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
prompt Creating table ACT_DE_DATABASECHANGELOGLOCK
prompt ===========================================
prompt
create table CLM.ACT_DE_DATABASECHANGELOGLOCK
(
  id          INTEGER not null,
  locked      NUMBER(1) not null,
  lockgranted TIMESTAMP(6),
  lockedby    VARCHAR2(255)
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
alter table CLM.ACT_DE_DATABASECHANGELOGLOCK
  add constraint PK_ACT_DE_DATABASECHANGELOGLOC primary key (ID)
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
prompt Creating table ACT_DE_MODEL
prompt ===========================
prompt
create table CLM.ACT_DE_MODEL
(
  id                VARCHAR2(255) not null,
  name              VARCHAR2(400) not null,
  model_key         VARCHAR2(400) not null,
  description       VARCHAR2(4000),
  model_comment     VARCHAR2(4000),
  created           TIMESTAMP(6),
  created_by        VARCHAR2(255),
  last_updated      TIMESTAMP(6),
  last_updated_by   VARCHAR2(255),
  version           INTEGER,
  model_editor_json CLOB,
  thumbnail         BLOB,
  model_type        INTEGER,
  tenant_id         VARCHAR2(255)
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
create index CLM.IDX_PROC_MOD_CREATED on CLM.ACT_DE_MODEL (CREATED_BY)
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
alter table CLM.ACT_DE_MODEL
  add constraint PK_ACT_DE_MODEL primary key (ID)
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
prompt Creating table ACT_DE_MODEL_HISTORY
prompt ===================================
prompt
create table CLM.ACT_DE_MODEL_HISTORY
(
  id                VARCHAR2(255) not null,
  name              VARCHAR2(400) not null,
  model_key         VARCHAR2(400) not null,
  description       VARCHAR2(4000),
  model_comment     VARCHAR2(4000),
  created           TIMESTAMP(6),
  created_by        VARCHAR2(255),
  last_updated      TIMESTAMP(6),
  last_updated_by   VARCHAR2(255),
  removal_date      TIMESTAMP(6),
  version           INTEGER,
  model_editor_json CLOB,
  model_id          VARCHAR2(255) not null,
  model_type        INTEGER,
  tenant_id         VARCHAR2(255)
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
create index CLM.IDX_PROC_MOD_HISTORY_PROC on CLM.ACT_DE_MODEL_HISTORY (MODEL_ID)
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
alter table CLM.ACT_DE_MODEL_HISTORY
  add constraint PK_ACT_DE_MODEL_HISTORY primary key (ID)
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
prompt Creating table ACT_DE_MODEL_RELATION
prompt ====================================
prompt
create table CLM.ACT_DE_MODEL_RELATION
(
  id              VARCHAR2(255) not null,
  parent_model_id VARCHAR2(255),
  model_id        VARCHAR2(255),
  relation_type   VARCHAR2(255)
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
alter table CLM.ACT_DE_MODEL_RELATION
  add constraint PK_ACT_DE_MODEL_RELATION primary key (ID)
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
alter table CLM.ACT_DE_MODEL_RELATION
  add constraint FK_RELATION_CHILD foreign key (MODEL_ID)
  references CLM.ACT_DE_MODEL (ID);
alter table CLM.ACT_DE_MODEL_RELATION
  add constraint FK_RELATION_PARENT foreign key (PARENT_MODEL_ID)
  references CLM.ACT_DE_MODEL (ID);

prompt
prompt Creating table ACT_DMN_DATABASECHANGELOG
prompt ========================================
prompt
create table CLM.ACT_DMN_DATABASECHANGELOG
(
  id            VARCHAR2(255) not null,
  author        VARCHAR2(255) not null,
  filename      VARCHAR2(255) not null,
  dateexecuted  TIMESTAMP(6) not null,
  orderexecuted INTEGER not null,
  exectype      VARCHAR2(10) not null,
  md5sum        VARCHAR2(35),
  description   VARCHAR2(255),
  comments      VARCHAR2(255),
  tag           VARCHAR2(255),
  liquibase     VARCHAR2(20),
  contexts      VARCHAR2(255),
  labels        VARCHAR2(255),
  deployment_id VARCHAR2(10)
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
prompt Creating table ACT_DMN_DATABASECHANGELOGLOCK
prompt ============================================
prompt
create table CLM.ACT_DMN_DATABASECHANGELOGLOCK
(
  id          INTEGER not null,
  locked      NUMBER(1) not null,
  lockgranted TIMESTAMP(6),
  lockedby    VARCHAR2(255)
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
alter table CLM.ACT_DMN_DATABASECHANGELOGLOCK
  add constraint PK_ACT_DMN_DATABASECHANGELOGLO primary key (ID)
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
prompt Creating table ACT_DMN_DECISION_TABLE
prompt =====================================
prompt
create table CLM.ACT_DMN_DECISION_TABLE
(
  id_            VARCHAR2(255) not null,
  name_          VARCHAR2(255),
  version_       INTEGER,
  key_           VARCHAR2(255),
  category_      VARCHAR2(255),
  deployment_id_ VARCHAR2(255),
  tenant_id_     VARCHAR2(255),
  resource_name_ VARCHAR2(255),
  description_   VARCHAR2(255)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
create unique index CLM.ACT_IDX_DEC_TBL_UNIQ on CLM.ACT_DMN_DECISION_TABLE (KEY_, VERSION_, TENANT_ID_)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
alter table CLM.ACT_DMN_DECISION_TABLE
  add constraint PK_ACT_DMN_DECISION_TABLE primary key (ID_)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table ACT_DMN_DEPLOYMENT
prompt =================================
prompt
create table CLM.ACT_DMN_DEPLOYMENT
(
  id_                   VARCHAR2(255) not null,
  name_                 VARCHAR2(255),
  category_             VARCHAR2(255),
  deploy_time_          TIMESTAMP(6),
  tenant_id_            VARCHAR2(255),
  parent_deployment_id_ VARCHAR2(255)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
alter table CLM.ACT_DMN_DEPLOYMENT
  add constraint PK_ACT_DMN_DEPLOYMENT primary key (ID_)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table ACT_DMN_DEPLOYMENT_RESOURCE
prompt ==========================================
prompt
create table CLM.ACT_DMN_DEPLOYMENT_RESOURCE
(
  id_             VARCHAR2(255) not null,
  name_           VARCHAR2(255),
  deployment_id_  VARCHAR2(255),
  resource_bytes_ BLOB
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
alter table CLM.ACT_DMN_DEPLOYMENT_RESOURCE
  add constraint PK_ACT_DMN_DEPLOYMENT_RESOURCE primary key (ID_)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table ACT_DMN_HI_DECISION_EXECUTION
prompt ============================================
prompt
create table CLM.ACT_DMN_HI_DECISION_EXECUTION
(
  id_                     VARCHAR2(255) not null,
  decision_definition_id_ VARCHAR2(255),
  deployment_id_          VARCHAR2(255),
  start_time_             TIMESTAMP(6),
  end_time_               TIMESTAMP(6),
  instance_id_            VARCHAR2(255),
  execution_id_           VARCHAR2(255),
  activity_id_            VARCHAR2(255),
  failed_                 NUMBER(1) default 0,
  tenant_id_              VARCHAR2(255),
  execution_json_         CLOB,
  scope_type_             VARCHAR2(255)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
alter table CLM.ACT_DMN_HI_DECISION_EXECUTION
  add constraint PK_ACT_DMN_HI_DECISION_EXECUTI primary key (ID_)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table ACT_EVT_LOG
prompt ==========================
prompt
create table CLM.ACT_EVT_LOG
(
  log_nr_       NUMBER(19) not null,
  type_         NVARCHAR2(64),
  proc_def_id_  NVARCHAR2(64),
  proc_inst_id_ NVARCHAR2(64),
  execution_id_ NVARCHAR2(64),
  task_id_      NVARCHAR2(64),
  time_stamp_   TIMESTAMP(6) not null,
  user_id_      NVARCHAR2(255),
  data_         BLOB,
  lock_owner_   NVARCHAR2(255),
  lock_time_    TIMESTAMP(6),
  is_processed_ NUMBER(3) default 0
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
alter table CLM.ACT_EVT_LOG
  add primary key (LOG_NR_)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table ACT_FO_DATABASECHANGELOG
prompt =======================================
prompt
create table CLM.ACT_FO_DATABASECHANGELOG
(
  id            VARCHAR2(255) not null,
  author        VARCHAR2(255) not null,
  filename      VARCHAR2(255) not null,
  dateexecuted  TIMESTAMP(6) not null,
  orderexecuted INTEGER not null,
  exectype      VARCHAR2(10) not null,
  md5sum        VARCHAR2(35),
  description   VARCHAR2(255),
  comments      VARCHAR2(255),
  tag           VARCHAR2(255),
  liquibase     VARCHAR2(20),
  contexts      VARCHAR2(255),
  labels        VARCHAR2(255),
  deployment_id VARCHAR2(10)
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
prompt Creating table ACT_FO_DATABASECHANGELOGLOCK
prompt ===========================================
prompt
create table CLM.ACT_FO_DATABASECHANGELOGLOCK
(
  id          INTEGER not null,
  locked      NUMBER(1) not null,
  lockgranted TIMESTAMP(6),
  lockedby    VARCHAR2(255)
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
alter table CLM.ACT_FO_DATABASECHANGELOGLOCK
  add constraint PK_ACT_FO_DATABASECHANGELOGLOC primary key (ID)
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
prompt Creating table ACT_FO_FORM_DEFINITION
prompt =====================================
prompt
create table CLM.ACT_FO_FORM_DEFINITION
(
  id_            VARCHAR2(255) not null,
  name_          VARCHAR2(255),
  version_       INTEGER,
  key_           VARCHAR2(255),
  category_      VARCHAR2(255),
  deployment_id_ VARCHAR2(255),
  tenant_id_     VARCHAR2(255),
  resource_name_ VARCHAR2(255),
  description_   VARCHAR2(255)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
create unique index CLM.ACT_IDX_FORM_DEF_UNIQ on CLM.ACT_FO_FORM_DEFINITION (KEY_, VERSION_, TENANT_ID_)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
alter table CLM.ACT_FO_FORM_DEFINITION
  add constraint PK_ACT_FO_FORM_DEFINITION primary key (ID_)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table ACT_FO_FORM_DEPLOYMENT
prompt =====================================
prompt
create table CLM.ACT_FO_FORM_DEPLOYMENT
(
  id_                   VARCHAR2(255) not null,
  name_                 VARCHAR2(255),
  category_             VARCHAR2(255),
  deploy_time_          TIMESTAMP(6),
  tenant_id_            VARCHAR2(255),
  parent_deployment_id_ VARCHAR2(255)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
alter table CLM.ACT_FO_FORM_DEPLOYMENT
  add constraint PK_ACT_FO_FORM_DEPLOYMENT primary key (ID_)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table ACT_FO_FORM_INSTANCE
prompt ===================================
prompt
create table CLM.ACT_FO_FORM_INSTANCE
(
  id_                  VARCHAR2(255) not null,
  form_definition_id_  VARCHAR2(255) not null,
  task_id_             VARCHAR2(255),
  proc_inst_id_        VARCHAR2(255),
  proc_def_id_         VARCHAR2(255),
  submitted_date_      TIMESTAMP(6),
  submitted_by_        VARCHAR2(255),
  form_values_id_      VARCHAR2(255),
  tenant_id_           VARCHAR2(255),
  scope_id_            VARCHAR2(255),
  scope_type_          VARCHAR2(255),
  scope_definition_id_ VARCHAR2(255)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
alter table CLM.ACT_FO_FORM_INSTANCE
  add constraint PK_ACT_FO_FORM_INSTANCE primary key (ID_)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table ACT_FO_FORM_RESOURCE
prompt ===================================
prompt
create table CLM.ACT_FO_FORM_RESOURCE
(
  id_             VARCHAR2(255) not null,
  name_           VARCHAR2(255),
  deployment_id_  VARCHAR2(255),
  resource_bytes_ BLOB
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
alter table CLM.ACT_FO_FORM_RESOURCE
  add constraint PK_ACT_FO_FORM_RESOURCE primary key (ID_)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table ACT_RE_DEPLOYMENT
prompt ================================
prompt
create table CLM.ACT_RE_DEPLOYMENT
(
  id_                   NVARCHAR2(64) not null,
  name_                 NVARCHAR2(255),
  category_             NVARCHAR2(255),
  key_                  NVARCHAR2(255),
  tenant_id_            NVARCHAR2(255) default '',
  deploy_time_          TIMESTAMP(6),
  derived_from_         NVARCHAR2(64),
  derived_from_root_    NVARCHAR2(64),
  parent_deployment_id_ NVARCHAR2(255),
  engine_version_       NVARCHAR2(255)
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
alter table CLM.ACT_RE_DEPLOYMENT
  add primary key (ID_)
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
prompt Creating table ACT_GE_BYTEARRAY
prompt ===============================
prompt
create table CLM.ACT_GE_BYTEARRAY
(
  id_            NVARCHAR2(64) not null,
  rev_           INTEGER,
  name_          NVARCHAR2(255),
  deployment_id_ NVARCHAR2(64),
  bytes_         BLOB,
  generated_     NUMBER(1)
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
create index CLM.ACT_IDX_BYTEAR_DEPL on CLM.ACT_GE_BYTEARRAY (DEPLOYMENT_ID_)
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
alter table CLM.ACT_GE_BYTEARRAY
  add primary key (ID_)
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
alter table CLM.ACT_GE_BYTEARRAY
  add constraint ACT_FK_BYTEARR_DEPL foreign key (DEPLOYMENT_ID_)
  references CLM.ACT_RE_DEPLOYMENT (ID_);
alter table CLM.ACT_GE_BYTEARRAY
  add check (GENERATED_ IN (1,0));

prompt
prompt Creating table ACT_GE_PROPERTY
prompt ==============================
prompt
create table CLM.ACT_GE_PROPERTY
(
  name_  NVARCHAR2(64) not null,
  value_ NVARCHAR2(300),
  rev_   INTEGER
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
alter table CLM.ACT_GE_PROPERTY
  add primary key (NAME_)
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
prompt Creating table ACT_HI_ACTINST
prompt =============================
prompt
create table CLM.ACT_HI_ACTINST
(
  id_                NVARCHAR2(64) not null,
  rev_               INTEGER default 1,
  proc_def_id_       NVARCHAR2(64) not null,
  proc_inst_id_      NVARCHAR2(64) not null,
  execution_id_      NVARCHAR2(64) not null,
  act_id_            NVARCHAR2(255) not null,
  task_id_           NVARCHAR2(64),
  call_proc_inst_id_ NVARCHAR2(64),
  act_name_          NVARCHAR2(255),
  act_type_          NVARCHAR2(255) not null,
  assignee_          NVARCHAR2(255),
  start_time_        TIMESTAMP(6) not null,
  end_time_          TIMESTAMP(6),
  duration_          NUMBER(19),
  delete_reason_     NVARCHAR2(2000),
  tenant_id_         NVARCHAR2(255) default ''
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
create index CLM.ACT_IDX_HI_ACT_INST_END on CLM.ACT_HI_ACTINST (END_TIME_)
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
create index CLM.ACT_IDX_HI_ACT_INST_EXEC on CLM.ACT_HI_ACTINST (EXECUTION_ID_, ACT_ID_)
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
create index CLM.ACT_IDX_HI_ACT_INST_PROCINST on CLM.ACT_HI_ACTINST (PROC_INST_ID_, ACT_ID_)
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
create index CLM.ACT_IDX_HI_ACT_INST_START on CLM.ACT_HI_ACTINST (START_TIME_)
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
alter table CLM.ACT_HI_ACTINST
  add primary key (ID_)
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
prompt Creating table ACT_HI_ATTACHMENT
prompt ================================
prompt
create table CLM.ACT_HI_ATTACHMENT
(
  id_           NVARCHAR2(64) not null,
  rev_          INTEGER,
  user_id_      NVARCHAR2(255),
  name_         NVARCHAR2(255),
  description_  NVARCHAR2(2000),
  type_         NVARCHAR2(255),
  task_id_      NVARCHAR2(64),
  proc_inst_id_ NVARCHAR2(64),
  url_          NVARCHAR2(2000),
  content_id_   NVARCHAR2(64),
  time_         TIMESTAMP(6)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
alter table CLM.ACT_HI_ATTACHMENT
  add primary key (ID_)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table ACT_HI_COMMENT
prompt =============================
prompt
create table CLM.ACT_HI_COMMENT
(
  id_           NVARCHAR2(64) not null,
  type_         NVARCHAR2(255),
  time_         TIMESTAMP(6) not null,
  user_id_      NVARCHAR2(255),
  task_id_      NVARCHAR2(64),
  proc_inst_id_ NVARCHAR2(64),
  action_       NVARCHAR2(255),
  message_      NVARCHAR2(2000),
  full_msg_     BLOB
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
alter table CLM.ACT_HI_COMMENT
  add primary key (ID_)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table ACT_HI_DETAIL
prompt ============================
prompt
create table CLM.ACT_HI_DETAIL
(
  id_           NVARCHAR2(64) not null,
  type_         NVARCHAR2(255) not null,
  proc_inst_id_ NVARCHAR2(64),
  execution_id_ NVARCHAR2(64),
  task_id_      NVARCHAR2(64),
  act_inst_id_  NVARCHAR2(64),
  name_         NVARCHAR2(255) not null,
  var_type_     NVARCHAR2(64),
  rev_          INTEGER,
  time_         TIMESTAMP(6) not null,
  bytearray_id_ NVARCHAR2(64),
  double_       NUMBER(*,10),
  long_         NUMBER(19),
  text_         NVARCHAR2(2000),
  text2_        NVARCHAR2(2000)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
create index CLM.ACT_IDX_HI_DETAIL_ACT_INST on CLM.ACT_HI_DETAIL (ACT_INST_ID_)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
create index CLM.ACT_IDX_HI_DETAIL_NAME on CLM.ACT_HI_DETAIL (NAME_)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
create index CLM.ACT_IDX_HI_DETAIL_PROC_INST on CLM.ACT_HI_DETAIL (PROC_INST_ID_)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
create index CLM.ACT_IDX_HI_DETAIL_TASK_ID on CLM.ACT_HI_DETAIL (TASK_ID_)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
create index CLM.ACT_IDX_HI_DETAIL_TIME on CLM.ACT_HI_DETAIL (TIME_)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
alter table CLM.ACT_HI_DETAIL
  add primary key (ID_)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table ACT_HI_ENTITYLINK
prompt ================================
prompt
create table CLM.ACT_HI_ENTITYLINK
(
  id_                      NVARCHAR2(64) not null,
  link_type_               NVARCHAR2(255),
  create_time_             TIMESTAMP(6),
  scope_id_                NVARCHAR2(255),
  scope_type_              NVARCHAR2(255),
  scope_definition_id_     NVARCHAR2(255),
  ref_scope_id_            NVARCHAR2(255),
  ref_scope_type_          NVARCHAR2(255),
  ref_scope_definition_id_ NVARCHAR2(255),
  hierarchy_type_          NVARCHAR2(255)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
create index CLM.ACT_IDX_HI_ENT_LNK_SCOPE on CLM.ACT_HI_ENTITYLINK (SCOPE_ID_, SCOPE_TYPE_, LINK_TYPE_)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
create index CLM.ACT_IDX_HI_ENT_LNK_SCOPE_DEF on CLM.ACT_HI_ENTITYLINK (SCOPE_DEFINITION_ID_, SCOPE_TYPE_, LINK_TYPE_)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
alter table CLM.ACT_HI_ENTITYLINK
  add primary key (ID_)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table ACT_HI_IDENTITYLINK
prompt ==================================
prompt
create table CLM.ACT_HI_IDENTITYLINK
(
  id_                  NVARCHAR2(64) not null,
  group_id_            NVARCHAR2(255),
  type_                NVARCHAR2(255),
  user_id_             NVARCHAR2(255),
  task_id_             NVARCHAR2(64),
  create_time_         TIMESTAMP(6),
  proc_inst_id_        NVARCHAR2(64),
  scope_id_            NVARCHAR2(255),
  scope_type_          NVARCHAR2(255),
  scope_definition_id_ NVARCHAR2(255),
  sub_scope_id_        NVARCHAR2(255)
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
create index CLM.ACT_IDX_HI_IDENT_LNK_PROCINST on CLM.ACT_HI_IDENTITYLINK (PROC_INST_ID_)
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
create index CLM.ACT_IDX_HI_IDENT_LNK_SCOPE on CLM.ACT_HI_IDENTITYLINK (SCOPE_ID_, SCOPE_TYPE_)
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
create index CLM.ACT_IDX_HI_IDENT_LNK_SCOPE_DEF on CLM.ACT_HI_IDENTITYLINK (SCOPE_DEFINITION_ID_, SCOPE_TYPE_)
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
create index CLM.ACT_IDX_HI_IDENT_LNK_SUB_SCOPE on CLM.ACT_HI_IDENTITYLINK (SUB_SCOPE_ID_, SCOPE_TYPE_)
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
create index CLM.ACT_IDX_HI_IDENT_LNK_TASK on CLM.ACT_HI_IDENTITYLINK (TASK_ID_)
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
create index CLM.ACT_IDX_HI_IDENT_LNK_USER on CLM.ACT_HI_IDENTITYLINK (USER_ID_)
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
alter table CLM.ACT_HI_IDENTITYLINK
  add primary key (ID_)
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
prompt Creating table ACT_HI_PROCINST
prompt ==============================
prompt
create table CLM.ACT_HI_PROCINST
(
  id_                        NVARCHAR2(64) not null,
  rev_                       INTEGER default 1,
  proc_inst_id_              NVARCHAR2(64) not null,
  business_key_              NVARCHAR2(255),
  proc_def_id_               NVARCHAR2(64) not null,
  start_time_                TIMESTAMP(6) not null,
  end_time_                  TIMESTAMP(6),
  duration_                  NUMBER(19),
  start_user_id_             NVARCHAR2(255),
  start_act_id_              NVARCHAR2(255),
  end_act_id_                NVARCHAR2(255),
  super_process_instance_id_ NVARCHAR2(64),
  delete_reason_             NVARCHAR2(2000),
  tenant_id_                 NVARCHAR2(255) default '',
  name_                      NVARCHAR2(255),
  callback_id_               NVARCHAR2(255),
  callback_type_             NVARCHAR2(255),
  reference_id_              NVARCHAR2(255),
  reference_type_            NVARCHAR2(255)
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
create index CLM.ACT_IDX_HI_PRO_INST_END on CLM.ACT_HI_PROCINST (END_TIME_)
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
create index CLM.ACT_IDX_HI_PRO_I_BUSKEY on CLM.ACT_HI_PROCINST (BUSINESS_KEY_)
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
alter table CLM.ACT_HI_PROCINST
  add primary key (ID_)
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
alter table CLM.ACT_HI_PROCINST
  add unique (PROC_INST_ID_)
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
prompt Creating table ACT_HI_TASKINST
prompt ==============================
prompt
create table CLM.ACT_HI_TASKINST
(
  id_                       NVARCHAR2(64) not null,
  rev_                      INTEGER default 1,
  proc_def_id_              NVARCHAR2(64),
  task_def_id_              NVARCHAR2(64),
  task_def_key_             NVARCHAR2(255),
  proc_inst_id_             NVARCHAR2(64),
  execution_id_             NVARCHAR2(64),
  scope_id_                 NVARCHAR2(255),
  sub_scope_id_             NVARCHAR2(255),
  scope_type_               NVARCHAR2(255),
  scope_definition_id_      NVARCHAR2(255),
  parent_task_id_           NVARCHAR2(64),
  name_                     NVARCHAR2(255),
  description_              NVARCHAR2(2000),
  owner_                    NVARCHAR2(255),
  assignee_                 NVARCHAR2(255),
  start_time_               TIMESTAMP(6) not null,
  claim_time_               TIMESTAMP(6),
  end_time_                 TIMESTAMP(6),
  duration_                 NUMBER(19),
  delete_reason_            NVARCHAR2(2000),
  priority_                 INTEGER,
  due_date_                 TIMESTAMP(6),
  form_key_                 NVARCHAR2(255),
  category_                 NVARCHAR2(255),
  tenant_id_                NVARCHAR2(255) default '',
  last_updated_time_        TIMESTAMP(6),
  propagated_stage_inst_id_ NVARCHAR2(255)
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
create index CLM.ACT_IDX_HI_TASK_INST_PROCINST on CLM.ACT_HI_TASKINST (PROC_INST_ID_)
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
create index CLM.ACT_IDX_HI_TASK_SCOPE on CLM.ACT_HI_TASKINST (SCOPE_ID_, SCOPE_TYPE_)
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
create index CLM.ACT_IDX_HI_TASK_SCOPE_DEF on CLM.ACT_HI_TASKINST (SCOPE_DEFINITION_ID_, SCOPE_TYPE_)
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
create index CLM.ACT_IDX_HI_TASK_SUB_SCOPE on CLM.ACT_HI_TASKINST (SUB_SCOPE_ID_, SCOPE_TYPE_)
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
alter table CLM.ACT_HI_TASKINST
  add primary key (ID_)
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
prompt Creating table ACT_HI_TSK_LOG
prompt =============================
prompt
create table CLM.ACT_HI_TSK_LOG
(
  id_                  NUMBER(19) not null,
  type_                NVARCHAR2(64),
  task_id_             NVARCHAR2(64) not null,
  time_stamp_          TIMESTAMP(6) not null,
  user_id_             NVARCHAR2(255),
  data_                NVARCHAR2(2000),
  execution_id_        NVARCHAR2(64),
  proc_inst_id_        NVARCHAR2(64),
  proc_def_id_         NVARCHAR2(64),
  scope_id_            NVARCHAR2(255),
  scope_definition_id_ NVARCHAR2(255),
  sub_scope_id_        NVARCHAR2(255),
  scope_type_          NVARCHAR2(255),
  tenant_id_           NVARCHAR2(255) default ''
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
alter table CLM.ACT_HI_TSK_LOG
  add primary key (ID_)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table ACT_HI_VARINST
prompt =============================
prompt
create table CLM.ACT_HI_VARINST
(
  id_                NVARCHAR2(64) not null,
  rev_               INTEGER default 1,
  proc_inst_id_      NVARCHAR2(64),
  execution_id_      NVARCHAR2(64),
  task_id_           NVARCHAR2(64),
  name_              NVARCHAR2(255) not null,
  var_type_          NVARCHAR2(100),
  scope_id_          NVARCHAR2(255),
  sub_scope_id_      NVARCHAR2(255),
  scope_type_        NVARCHAR2(255),
  bytearray_id_      NVARCHAR2(64),
  double_            NUMBER(*,10),
  long_              NUMBER(19),
  text_              NVARCHAR2(2000),
  text2_             NVARCHAR2(2000),
  create_time_       TIMESTAMP(6),
  last_updated_time_ TIMESTAMP(6)
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
create index CLM.ACT_IDX_HI_PROCVAR_EXE on CLM.ACT_HI_VARINST (EXECUTION_ID_)
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
create index CLM.ACT_IDX_HI_PROCVAR_NAME_TYPE on CLM.ACT_HI_VARINST (NAME_, VAR_TYPE_)
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
create index CLM.ACT_IDX_HI_PROCVAR_PROC_INST on CLM.ACT_HI_VARINST (PROC_INST_ID_)
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
create index CLM.ACT_IDX_HI_PROCVAR_TASK_ID on CLM.ACT_HI_VARINST (TASK_ID_)
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
create index CLM.ACT_IDX_HI_VAR_SCOPE_ID_TYPE on CLM.ACT_HI_VARINST (SCOPE_ID_, SCOPE_TYPE_)
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
create index CLM.ACT_IDX_HI_VAR_SUB_ID_TYPE on CLM.ACT_HI_VARINST (SUB_SCOPE_ID_, SCOPE_TYPE_)
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
alter table CLM.ACT_HI_VARINST
  add primary key (ID_)
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
prompt Creating table ACT_ID_BYTEARRAY
prompt ===============================
prompt
create table CLM.ACT_ID_BYTEARRAY
(
  id_    NVARCHAR2(64) not null,
  rev_   INTEGER,
  name_  NVARCHAR2(255),
  bytes_ BLOB
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
alter table CLM.ACT_ID_BYTEARRAY
  add primary key (ID_)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table ACT_ID_GROUP
prompt ===========================
prompt
create table CLM.ACT_ID_GROUP
(
  id_   NVARCHAR2(64) not null,
  rev_  INTEGER,
  name_ NVARCHAR2(255),
  type_ NVARCHAR2(255)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
alter table CLM.ACT_ID_GROUP
  add primary key (ID_)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table ACT_ID_INFO
prompt ==========================
prompt
create table CLM.ACT_ID_INFO
(
  id_        NVARCHAR2(64) not null,
  rev_       INTEGER,
  user_id_   NVARCHAR2(64),
  type_      NVARCHAR2(64),
  key_       NVARCHAR2(255),
  value_     NVARCHAR2(255),
  password_  BLOB,
  parent_id_ NVARCHAR2(255)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
alter table CLM.ACT_ID_INFO
  add primary key (ID_)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table ACT_ID_USER
prompt ==========================
prompt
create table CLM.ACT_ID_USER
(
  id_           NVARCHAR2(64) not null,
  rev_          INTEGER,
  first_        NVARCHAR2(255),
  last_         NVARCHAR2(255),
  display_name_ NVARCHAR2(255),
  email_        NVARCHAR2(255),
  pwd_          NVARCHAR2(255),
  picture_id_   NVARCHAR2(64),
  tenant_id_    NVARCHAR2(255) default ''
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
alter table CLM.ACT_ID_USER
  add primary key (ID_)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table ACT_ID_MEMBERSHIP
prompt ================================
prompt
create table CLM.ACT_ID_MEMBERSHIP
(
  user_id_  NVARCHAR2(64) not null,
  group_id_ NVARCHAR2(64) not null
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
create index CLM.ACT_IDX_MEMB_GROUP on CLM.ACT_ID_MEMBERSHIP (GROUP_ID_)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
create index CLM.ACT_IDX_MEMB_USER on CLM.ACT_ID_MEMBERSHIP (USER_ID_)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
alter table CLM.ACT_ID_MEMBERSHIP
  add primary key (USER_ID_, GROUP_ID_)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
alter table CLM.ACT_ID_MEMBERSHIP
  add constraint ACT_FK_MEMB_GROUP foreign key (GROUP_ID_)
  references CLM.ACT_ID_GROUP (ID_);
alter table CLM.ACT_ID_MEMBERSHIP
  add constraint ACT_FK_MEMB_USER foreign key (USER_ID_)
  references CLM.ACT_ID_USER (ID_);

prompt
prompt Creating table ACT_ID_PRIV
prompt ==========================
prompt
create table CLM.ACT_ID_PRIV
(
  id_   NVARCHAR2(64) not null,
  name_ NVARCHAR2(255) not null
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
alter table CLM.ACT_ID_PRIV
  add primary key (ID_)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
alter table CLM.ACT_ID_PRIV
  add constraint ACT_UNIQ_PRIV_NAME unique (NAME_)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table ACT_ID_PRIV_MAPPING
prompt ==================================
prompt
create table CLM.ACT_ID_PRIV_MAPPING
(
  id_       NVARCHAR2(64) not null,
  priv_id_  NVARCHAR2(64) not null,
  user_id_  NVARCHAR2(255),
  group_id_ NVARCHAR2(255)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
create index CLM.ACT_IDX_PRIV_GROUP on CLM.ACT_ID_PRIV_MAPPING (GROUP_ID_)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
create index CLM.ACT_IDX_PRIV_MAPPING on CLM.ACT_ID_PRIV_MAPPING (PRIV_ID_)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
create index CLM.ACT_IDX_PRIV_USER on CLM.ACT_ID_PRIV_MAPPING (USER_ID_)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
alter table CLM.ACT_ID_PRIV_MAPPING
  add primary key (ID_)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
alter table CLM.ACT_ID_PRIV_MAPPING
  add constraint ACT_FK_PRIV_MAPPING foreign key (PRIV_ID_)
  references CLM.ACT_ID_PRIV (ID_);

prompt
prompt Creating table ACT_ID_PROPERTY
prompt ==============================
prompt
create table CLM.ACT_ID_PROPERTY
(
  name_  NVARCHAR2(64) not null,
  value_ NVARCHAR2(300),
  rev_   INTEGER
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
alter table CLM.ACT_ID_PROPERTY
  add primary key (NAME_)
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
prompt Creating table ACT_ID_TOKEN
prompt ===========================
prompt
create table CLM.ACT_ID_TOKEN
(
  id_          NVARCHAR2(64) not null,
  rev_         INTEGER,
  token_value_ NVARCHAR2(255),
  token_date_  TIMESTAMP(6),
  ip_address_  NVARCHAR2(255),
  user_agent_  NVARCHAR2(255),
  user_id_     NVARCHAR2(255),
  token_data_  NVARCHAR2(2000)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
alter table CLM.ACT_ID_TOKEN
  add primary key (ID_)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table ACT_RE_PROCDEF
prompt =============================
prompt
create table CLM.ACT_RE_PROCDEF
(
  id_                     NVARCHAR2(64) not null,
  rev_                    INTEGER,
  category_               NVARCHAR2(255),
  name_                   NVARCHAR2(255),
  key_                    NVARCHAR2(255) not null,
  version_                INTEGER not null,
  deployment_id_          NVARCHAR2(64),
  resource_name_          NVARCHAR2(2000),
  dgrm_resource_name_     VARCHAR2(4000),
  description_            NVARCHAR2(2000),
  has_start_form_key_     NUMBER(1),
  has_graphical_notation_ NUMBER(1),
  suspension_state_       INTEGER,
  tenant_id_              NVARCHAR2(255) default '',
  derived_from_           NVARCHAR2(64),
  derived_from_root_      NVARCHAR2(64),
  derived_version_        INTEGER default 0 not null,
  engine_version_         NVARCHAR2(255)
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
alter table CLM.ACT_RE_PROCDEF
  add primary key (ID_)
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
alter table CLM.ACT_RE_PROCDEF
  add constraint ACT_UNIQ_PROCDEF unique (KEY_, VERSION_, DERIVED_VERSION_, TENANT_ID_)
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
alter table CLM.ACT_RE_PROCDEF
  add check (HAS_START_FORM_KEY_ IN (1,0));
alter table CLM.ACT_RE_PROCDEF
  add check (HAS_GRAPHICAL_NOTATION_ IN (1,0));

prompt
prompt Creating table ACT_PROCDEF_INFO
prompt ===============================
prompt
create table CLM.ACT_PROCDEF_INFO
(
  id_           NVARCHAR2(64) not null,
  proc_def_id_  NVARCHAR2(64) not null,
  rev_          INTEGER,
  info_json_id_ NVARCHAR2(64)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
create index CLM.ACT_IDX_PROCDEF_INFO_JSON on CLM.ACT_PROCDEF_INFO (INFO_JSON_ID_)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
create index CLM.ACT_IDX_PROCDEF_INFO_PROC on CLM.ACT_PROCDEF_INFO (PROC_DEF_ID_)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
alter table CLM.ACT_PROCDEF_INFO
  add primary key (ID_)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
alter table CLM.ACT_PROCDEF_INFO
  add constraint ACT_UNIQ_INFO_PROCDEF unique (PROC_DEF_ID_);
alter table CLM.ACT_PROCDEF_INFO
  add constraint ACT_FK_INFO_JSON_BA foreign key (INFO_JSON_ID_)
  references CLM.ACT_GE_BYTEARRAY (ID_);
alter table CLM.ACT_PROCDEF_INFO
  add constraint ACT_FK_INFO_PROCDEF foreign key (PROC_DEF_ID_)
  references CLM.ACT_RE_PROCDEF (ID_);

prompt
prompt Creating table ACT_RE_MODEL
prompt ===========================
prompt
create table CLM.ACT_RE_MODEL
(
  id_                           NVARCHAR2(64) not null,
  rev_                          INTEGER,
  name_                         NVARCHAR2(255),
  key_                          NVARCHAR2(255),
  category_                     NVARCHAR2(255),
  create_time_                  TIMESTAMP(6),
  last_update_time_             TIMESTAMP(6),
  version_                      INTEGER,
  meta_info_                    NVARCHAR2(2000),
  deployment_id_                NVARCHAR2(64),
  editor_source_value_id_       NVARCHAR2(64),
  editor_source_extra_value_id_ NVARCHAR2(64),
  tenant_id_                    NVARCHAR2(255) default ''
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
create index CLM.ACT_IDX_MODEL_DEPLOYMENT on CLM.ACT_RE_MODEL (DEPLOYMENT_ID_)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
create index CLM.ACT_IDX_MODEL_SOURCE on CLM.ACT_RE_MODEL (EDITOR_SOURCE_VALUE_ID_)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
create index CLM.ACT_IDX_MODEL_SOURCE_EXTRA on CLM.ACT_RE_MODEL (EDITOR_SOURCE_EXTRA_VALUE_ID_)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
alter table CLM.ACT_RE_MODEL
  add primary key (ID_)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
alter table CLM.ACT_RE_MODEL
  add constraint ACT_FK_MODEL_DEPLOYMENT foreign key (DEPLOYMENT_ID_)
  references CLM.ACT_RE_DEPLOYMENT (ID_);
alter table CLM.ACT_RE_MODEL
  add constraint ACT_FK_MODEL_SOURCE foreign key (EDITOR_SOURCE_VALUE_ID_)
  references CLM.ACT_GE_BYTEARRAY (ID_);
alter table CLM.ACT_RE_MODEL
  add constraint ACT_FK_MODEL_SOURCE_EXTRA foreign key (EDITOR_SOURCE_EXTRA_VALUE_ID_)
  references CLM.ACT_GE_BYTEARRAY (ID_);

prompt
prompt Creating table ACT_RU_ACTINST
prompt =============================
prompt
create table CLM.ACT_RU_ACTINST
(
  id_                NVARCHAR2(64) not null,
  rev_               INTEGER default 1,
  proc_def_id_       NVARCHAR2(64) not null,
  proc_inst_id_      NVARCHAR2(64) not null,
  execution_id_      NVARCHAR2(64) not null,
  act_id_            NVARCHAR2(255) not null,
  task_id_           NVARCHAR2(64),
  call_proc_inst_id_ NVARCHAR2(64),
  act_name_          NVARCHAR2(255),
  act_type_          NVARCHAR2(255) not null,
  assignee_          NVARCHAR2(255),
  start_time_        TIMESTAMP(6) not null,
  end_time_          TIMESTAMP(6),
  duration_          NUMBER(19),
  delete_reason_     NVARCHAR2(2000),
  tenant_id_         NVARCHAR2(255) default ''
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
create index CLM.ACT_IDX_RU_ACTI_END on CLM.ACT_RU_ACTINST (END_TIME_)
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
create index CLM.ACT_IDX_RU_ACTI_EXEC on CLM.ACT_RU_ACTINST (EXECUTION_ID_)
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
create index CLM.ACT_IDX_RU_ACTI_EXEC_ACT on CLM.ACT_RU_ACTINST (EXECUTION_ID_, ACT_ID_)
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
create index CLM.ACT_IDX_RU_ACTI_PROC on CLM.ACT_RU_ACTINST (PROC_INST_ID_)
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
create index CLM.ACT_IDX_RU_ACTI_PROC_ACT on CLM.ACT_RU_ACTINST (PROC_INST_ID_, ACT_ID_)
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
create index CLM.ACT_IDX_RU_ACTI_START on CLM.ACT_RU_ACTINST (START_TIME_)
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
alter table CLM.ACT_RU_ACTINST
  add primary key (ID_)
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
prompt Creating table ACT_RU_EXECUTION
prompt ===============================
prompt
create table CLM.ACT_RU_EXECUTION
(
  id_                       NVARCHAR2(64) not null,
  rev_                      INTEGER,
  proc_inst_id_             NVARCHAR2(64),
  business_key_             NVARCHAR2(255),
  parent_id_                NVARCHAR2(64),
  proc_def_id_              NVARCHAR2(64),
  super_exec_               NVARCHAR2(64),
  root_proc_inst_id_        NVARCHAR2(64),
  act_id_                   NVARCHAR2(255),
  is_active_                NUMBER(1),
  is_concurrent_            NUMBER(1),
  is_scope_                 NUMBER(1),
  is_event_scope_           NUMBER(1),
  is_mi_root_               NUMBER(1),
  suspension_state_         INTEGER,
  cached_ent_state_         INTEGER,
  tenant_id_                NVARCHAR2(255) default '',
  name_                     NVARCHAR2(255),
  start_act_id_             NVARCHAR2(255),
  start_time_               TIMESTAMP(6),
  start_user_id_            NVARCHAR2(255),
  lock_time_                TIMESTAMP(6),
  is_count_enabled_         NUMBER(1),
  evt_subscr_count_         INTEGER,
  task_count_               INTEGER,
  job_count_                INTEGER,
  timer_job_count_          INTEGER,
  susp_job_count_           INTEGER,
  deadletter_job_count_     INTEGER,
  var_count_                INTEGER,
  id_link_count_            INTEGER,
  callback_id_              NVARCHAR2(255),
  callback_type_            NVARCHAR2(255),
  reference_id_             NVARCHAR2(255),
  reference_type_           NVARCHAR2(255),
  propagated_stage_inst_id_ NVARCHAR2(255)
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
create index CLM.ACT_IDX_EXEC_BUSKEY on CLM.ACT_RU_EXECUTION (BUSINESS_KEY_)
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
create index CLM.ACT_IDX_EXEC_ROOT on CLM.ACT_RU_EXECUTION (ROOT_PROC_INST_ID_)
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
create index CLM.ACT_IDX_EXE_PARENT on CLM.ACT_RU_EXECUTION (PARENT_ID_)
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
create index CLM.ACT_IDX_EXE_PROCDEF on CLM.ACT_RU_EXECUTION (PROC_DEF_ID_)
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
create index CLM.ACT_IDX_EXE_PROCINST on CLM.ACT_RU_EXECUTION (PROC_INST_ID_)
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
create index CLM.ACT_IDX_EXE_SUPER on CLM.ACT_RU_EXECUTION (SUPER_EXEC_)
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
alter table CLM.ACT_RU_EXECUTION
  add primary key (ID_)
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
alter table CLM.ACT_RU_EXECUTION
  add constraint ACT_FK_EXE_PARENT foreign key (PARENT_ID_)
  references CLM.ACT_RU_EXECUTION (ID_);
alter table CLM.ACT_RU_EXECUTION
  add constraint ACT_FK_EXE_PROCDEF foreign key (PROC_DEF_ID_)
  references CLM.ACT_RE_PROCDEF (ID_);
alter table CLM.ACT_RU_EXECUTION
  add constraint ACT_FK_EXE_PROCINST foreign key (PROC_INST_ID_)
  references CLM.ACT_RU_EXECUTION (ID_);
alter table CLM.ACT_RU_EXECUTION
  add constraint ACT_FK_EXE_SUPER foreign key (SUPER_EXEC_)
  references CLM.ACT_RU_EXECUTION (ID_);
alter table CLM.ACT_RU_EXECUTION
  add check (IS_ACTIVE_ IN (1,0));
alter table CLM.ACT_RU_EXECUTION
  add check (IS_CONCURRENT_ IN (1,0));
alter table CLM.ACT_RU_EXECUTION
  add check (IS_SCOPE_ IN (1,0));
alter table CLM.ACT_RU_EXECUTION
  add check (IS_EVENT_SCOPE_ IN (1,0));
alter table CLM.ACT_RU_EXECUTION
  add check (IS_MI_ROOT_ IN (1,0));
alter table CLM.ACT_RU_EXECUTION
  add check (IS_COUNT_ENABLED_ IN (1,0));

prompt
prompt Creating table ACT_RU_DEADLETTER_JOB
prompt ====================================
prompt
create table CLM.ACT_RU_DEADLETTER_JOB
(
  id_                  NVARCHAR2(64) not null,
  rev_                 INTEGER,
  type_                NVARCHAR2(255) not null,
  exclusive_           NUMBER(1),
  execution_id_        NVARCHAR2(64),
  process_instance_id_ NVARCHAR2(64),
  proc_def_id_         NVARCHAR2(64),
  element_id_          NVARCHAR2(255),
  element_name_        NVARCHAR2(255),
  scope_id_            NVARCHAR2(255),
  sub_scope_id_        NVARCHAR2(255),
  scope_type_          NVARCHAR2(255),
  scope_definition_id_ NVARCHAR2(255),
  exception_stack_id_  NVARCHAR2(64),
  exception_msg_       NVARCHAR2(2000),
  duedate_             TIMESTAMP(6),
  repeat_              NVARCHAR2(255),
  handler_type_        NVARCHAR2(255),
  handler_cfg_         NVARCHAR2(2000),
  custom_values_id_    NVARCHAR2(64),
  create_time_         TIMESTAMP(6),
  tenant_id_           NVARCHAR2(255) default ''
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
create index CLM.ACT_IDX_DJOB_CUSTOM_VAL_ID on CLM.ACT_RU_DEADLETTER_JOB (CUSTOM_VALUES_ID_)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
create index CLM.ACT_IDX_DJOB_EXCEPTION on CLM.ACT_RU_DEADLETTER_JOB (EXCEPTION_STACK_ID_)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
create index CLM.ACT_IDX_DJOB_EXECUTION_ID on CLM.ACT_RU_DEADLETTER_JOB (EXECUTION_ID_)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
create index CLM.ACT_IDX_DJOB_PROC_DEF_ID on CLM.ACT_RU_DEADLETTER_JOB (PROC_DEF_ID_)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
create index CLM.ACT_IDX_DJOB_PROC_INST_ID on CLM.ACT_RU_DEADLETTER_JOB (PROCESS_INSTANCE_ID_)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
create index CLM.ACT_IDX_DJOB_SCOPE on CLM.ACT_RU_DEADLETTER_JOB (SCOPE_ID_, SCOPE_TYPE_)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
create index CLM.ACT_IDX_DJOB_SCOPE_DEF on CLM.ACT_RU_DEADLETTER_JOB (SCOPE_DEFINITION_ID_, SCOPE_TYPE_)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
create index CLM.ACT_IDX_DJOB_SUB_SCOPE on CLM.ACT_RU_DEADLETTER_JOB (SUB_SCOPE_ID_, SCOPE_TYPE_)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
alter table CLM.ACT_RU_DEADLETTER_JOB
  add primary key (ID_)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
alter table CLM.ACT_RU_DEADLETTER_JOB
  add constraint ACT_FK_DJOB_CUSTOM_VAL foreign key (CUSTOM_VALUES_ID_)
  references CLM.ACT_GE_BYTEARRAY (ID_);
alter table CLM.ACT_RU_DEADLETTER_JOB
  add constraint ACT_FK_DJOB_EXCEPTION foreign key (EXCEPTION_STACK_ID_)
  references CLM.ACT_GE_BYTEARRAY (ID_);
alter table CLM.ACT_RU_DEADLETTER_JOB
  add constraint ACT_FK_DJOB_EXECUTION foreign key (EXECUTION_ID_)
  references CLM.ACT_RU_EXECUTION (ID_);
alter table CLM.ACT_RU_DEADLETTER_JOB
  add constraint ACT_FK_DJOB_PROCESS_INSTANCE foreign key (PROCESS_INSTANCE_ID_)
  references CLM.ACT_RU_EXECUTION (ID_);
alter table CLM.ACT_RU_DEADLETTER_JOB
  add constraint ACT_FK_DJOB_PROC_DEF foreign key (PROC_DEF_ID_)
  references CLM.ACT_RE_PROCDEF (ID_);
alter table CLM.ACT_RU_DEADLETTER_JOB
  add check (EXCLUSIVE_ IN (1,0));

prompt
prompt Creating table ACT_RU_ENTITYLINK
prompt ================================
prompt
create table CLM.ACT_RU_ENTITYLINK
(
  id_                      NVARCHAR2(64) not null,
  rev_                     INTEGER,
  create_time_             TIMESTAMP(6),
  link_type_               NVARCHAR2(255),
  scope_id_                NVARCHAR2(255),
  scope_type_              NVARCHAR2(255),
  scope_definition_id_     NVARCHAR2(255),
  ref_scope_id_            NVARCHAR2(255),
  ref_scope_type_          NVARCHAR2(255),
  ref_scope_definition_id_ NVARCHAR2(255),
  hierarchy_type_          NVARCHAR2(255)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
create index CLM.ACT_IDX_ENT_LNK_SCOPE on CLM.ACT_RU_ENTITYLINK (SCOPE_ID_, SCOPE_TYPE_, LINK_TYPE_)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
create index CLM.ACT_IDX_ENT_LNK_SCOPE_DEF on CLM.ACT_RU_ENTITYLINK (SCOPE_DEFINITION_ID_, SCOPE_TYPE_, LINK_TYPE_)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
alter table CLM.ACT_RU_ENTITYLINK
  add primary key (ID_)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table ACT_RU_EVENT_SUBSCR
prompt ==================================
prompt
create table CLM.ACT_RU_EVENT_SUBSCR
(
  id_                  NVARCHAR2(64) not null,
  rev_                 INTEGER,
  event_type_          NVARCHAR2(255) not null,
  event_name_          NVARCHAR2(255),
  execution_id_        NVARCHAR2(64),
  proc_inst_id_        NVARCHAR2(64),
  activity_id_         NVARCHAR2(64),
  configuration_       NVARCHAR2(255),
  created_             TIMESTAMP(6) not null,
  proc_def_id_         NVARCHAR2(64),
  sub_scope_id_        NVARCHAR2(64),
  scope_id_            NVARCHAR2(64),
  scope_definition_id_ NVARCHAR2(64),
  scope_type_          NVARCHAR2(64),
  tenant_id_           NVARCHAR2(255) default ''
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
create index CLM.ACT_IDX_EVENT_SUBSCR on CLM.ACT_RU_EVENT_SUBSCR (EXECUTION_ID_)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
create index CLM.ACT_IDX_EVENT_SUBSCR_CONFIG_ on CLM.ACT_RU_EVENT_SUBSCR (CONFIGURATION_)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
alter table CLM.ACT_RU_EVENT_SUBSCR
  add primary key (ID_)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
alter table CLM.ACT_RU_EVENT_SUBSCR
  add constraint ACT_FK_EVENT_EXEC foreign key (EXECUTION_ID_)
  references CLM.ACT_RU_EXECUTION (ID_);

prompt
prompt Creating table ACT_RU_HISTORY_JOB
prompt =================================
prompt
create table CLM.ACT_RU_HISTORY_JOB
(
  id_                 NVARCHAR2(64) not null,
  rev_                INTEGER,
  lock_exp_time_      TIMESTAMP(6),
  lock_owner_         NVARCHAR2(255),
  retries_            INTEGER,
  exception_stack_id_ NVARCHAR2(64),
  exception_msg_      NVARCHAR2(2000),
  handler_type_       NVARCHAR2(255),
  handler_cfg_        NVARCHAR2(2000),
  custom_values_id_   NVARCHAR2(64),
  adv_handler_cfg_id_ NVARCHAR2(64),
  create_time_        TIMESTAMP(6),
  scope_type_         NVARCHAR2(255),
  tenant_id_          NVARCHAR2(255) default ''
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
alter table CLM.ACT_RU_HISTORY_JOB
  add primary key (ID_)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table ACT_RU_TASK
prompt ==========================
prompt
create table CLM.ACT_RU_TASK
(
  id_                       NVARCHAR2(64) not null,
  rev_                      INTEGER,
  execution_id_             NVARCHAR2(64),
  proc_inst_id_             NVARCHAR2(64),
  proc_def_id_              NVARCHAR2(64),
  task_def_id_              NVARCHAR2(64),
  scope_id_                 NVARCHAR2(255),
  sub_scope_id_             NVARCHAR2(255),
  scope_type_               NVARCHAR2(255),
  scope_definition_id_      NVARCHAR2(255),
  name_                     NVARCHAR2(255),
  parent_task_id_           NVARCHAR2(64),
  description_              NVARCHAR2(2000),
  task_def_key_             NVARCHAR2(255),
  owner_                    NVARCHAR2(255),
  assignee_                 NVARCHAR2(255),
  delegation_               NVARCHAR2(64),
  priority_                 INTEGER,
  create_time_              TIMESTAMP(6),
  due_date_                 TIMESTAMP(6),
  category_                 NVARCHAR2(255),
  suspension_state_         INTEGER,
  tenant_id_                NVARCHAR2(255) default '',
  form_key_                 NVARCHAR2(255),
  claim_time_               TIMESTAMP(6),
  is_count_enabled_         NUMBER(1),
  var_count_                INTEGER,
  id_link_count_            INTEGER,
  sub_task_count_           INTEGER,
  propagated_stage_inst_id_ NVARCHAR2(255)
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
create index CLM.ACT_IDX_TASK_CREATE on CLM.ACT_RU_TASK (CREATE_TIME_)
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
create index CLM.ACT_IDX_TASK_EXEC on CLM.ACT_RU_TASK (EXECUTION_ID_)
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
create index CLM.ACT_IDX_TASK_PROCDEF on CLM.ACT_RU_TASK (PROC_DEF_ID_)
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
create index CLM.ACT_IDX_TASK_PROCINST on CLM.ACT_RU_TASK (PROC_INST_ID_)
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
create index CLM.ACT_IDX_TASK_SCOPE on CLM.ACT_RU_TASK (SCOPE_ID_, SCOPE_TYPE_)
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
create index CLM.ACT_IDX_TASK_SCOPE_DEF on CLM.ACT_RU_TASK (SCOPE_DEFINITION_ID_, SCOPE_TYPE_)
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
create index CLM.ACT_IDX_TASK_SUB_SCOPE on CLM.ACT_RU_TASK (SUB_SCOPE_ID_, SCOPE_TYPE_)
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
alter table CLM.ACT_RU_TASK
  add primary key (ID_)
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
alter table CLM.ACT_RU_TASK
  add constraint ACT_FK_TASK_EXE foreign key (EXECUTION_ID_)
  references CLM.ACT_RU_EXECUTION (ID_);
alter table CLM.ACT_RU_TASK
  add constraint ACT_FK_TASK_PROCDEF foreign key (PROC_DEF_ID_)
  references CLM.ACT_RE_PROCDEF (ID_);
alter table CLM.ACT_RU_TASK
  add constraint ACT_FK_TASK_PROCINST foreign key (PROC_INST_ID_)
  references CLM.ACT_RU_EXECUTION (ID_);
alter table CLM.ACT_RU_TASK
  add check (IS_COUNT_ENABLED_ IN (1,0));

prompt
prompt Creating table ACT_RU_IDENTITYLINK
prompt ==================================
prompt
create table CLM.ACT_RU_IDENTITYLINK
(
  id_                  NVARCHAR2(64) not null,
  rev_                 INTEGER,
  group_id_            NVARCHAR2(255),
  type_                NVARCHAR2(255),
  user_id_             NVARCHAR2(255),
  task_id_             NVARCHAR2(64),
  proc_inst_id_        NVARCHAR2(64),
  proc_def_id_         NVARCHAR2(64),
  scope_id_            NVARCHAR2(255),
  scope_type_          NVARCHAR2(255),
  scope_definition_id_ NVARCHAR2(255),
  sub_scope_id_        NVARCHAR2(255)
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
create index CLM.ACT_IDX_ATHRZ_PROCEDEF on CLM.ACT_RU_IDENTITYLINK (PROC_DEF_ID_)
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
create index CLM.ACT_IDX_IDENT_LNK_GROUP on CLM.ACT_RU_IDENTITYLINK (GROUP_ID_)
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
create index CLM.ACT_IDX_IDENT_LNK_SCOPE on CLM.ACT_RU_IDENTITYLINK (SCOPE_ID_, SCOPE_TYPE_)
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
create index CLM.ACT_IDX_IDENT_LNK_SCOPE_DEF on CLM.ACT_RU_IDENTITYLINK (SCOPE_DEFINITION_ID_, SCOPE_TYPE_)
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
create index CLM.ACT_IDX_IDENT_LNK_SUB_SCOPE on CLM.ACT_RU_IDENTITYLINK (SUB_SCOPE_ID_, SCOPE_TYPE_)
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
create index CLM.ACT_IDX_IDENT_LNK_USER on CLM.ACT_RU_IDENTITYLINK (USER_ID_)
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
create index CLM.ACT_IDX_IDL_PROCINST on CLM.ACT_RU_IDENTITYLINK (PROC_INST_ID_)
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
create index CLM.ACT_IDX_TSKASS_TASK on CLM.ACT_RU_IDENTITYLINK (TASK_ID_)
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
alter table CLM.ACT_RU_IDENTITYLINK
  add primary key (ID_)
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
alter table CLM.ACT_RU_IDENTITYLINK
  add constraint ACT_FK_ATHRZ_PROCEDEF foreign key (PROC_DEF_ID_)
  references CLM.ACT_RE_PROCDEF (ID_);
alter table CLM.ACT_RU_IDENTITYLINK
  add constraint ACT_FK_IDL_PROCINST foreign key (PROC_INST_ID_)
  references CLM.ACT_RU_EXECUTION (ID_);
alter table CLM.ACT_RU_IDENTITYLINK
  add constraint ACT_FK_TSKASS_TASK foreign key (TASK_ID_)
  references CLM.ACT_RU_TASK (ID_);

prompt
prompt Creating table ACT_RU_JOB
prompt =========================
prompt
create table CLM.ACT_RU_JOB
(
  id_                  NVARCHAR2(64) not null,
  rev_                 INTEGER,
  type_                NVARCHAR2(255) not null,
  lock_exp_time_       TIMESTAMP(6),
  lock_owner_          NVARCHAR2(255),
  exclusive_           NUMBER(1),
  execution_id_        NVARCHAR2(64),
  process_instance_id_ NVARCHAR2(64),
  proc_def_id_         NVARCHAR2(64),
  element_id_          NVARCHAR2(255),
  element_name_        NVARCHAR2(255),
  scope_id_            NVARCHAR2(255),
  sub_scope_id_        NVARCHAR2(255),
  scope_type_          NVARCHAR2(255),
  scope_definition_id_ NVARCHAR2(255),
  retries_             INTEGER,
  exception_stack_id_  NVARCHAR2(64),
  exception_msg_       NVARCHAR2(2000),
  duedate_             TIMESTAMP(6),
  repeat_              NVARCHAR2(255),
  handler_type_        NVARCHAR2(255),
  handler_cfg_         NVARCHAR2(2000),
  custom_values_id_    NVARCHAR2(64),
  create_time_         TIMESTAMP(6),
  tenant_id_           NVARCHAR2(255) default ''
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
create index CLM.ACT_IDX_JOB_CUSTOM_VAL_ID on CLM.ACT_RU_JOB (CUSTOM_VALUES_ID_)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
create index CLM.ACT_IDX_JOB_EXCEPTION on CLM.ACT_RU_JOB (EXCEPTION_STACK_ID_)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
create index CLM.ACT_IDX_JOB_EXECUTION_ID on CLM.ACT_RU_JOB (EXECUTION_ID_)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
create index CLM.ACT_IDX_JOB_PROC_DEF_ID on CLM.ACT_RU_JOB (PROC_DEF_ID_)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
create index CLM.ACT_IDX_JOB_PROC_INST_ID on CLM.ACT_RU_JOB (PROCESS_INSTANCE_ID_)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
create index CLM.ACT_IDX_JOB_SCOPE on CLM.ACT_RU_JOB (SCOPE_ID_, SCOPE_TYPE_)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
create index CLM.ACT_IDX_JOB_SCOPE_DEF on CLM.ACT_RU_JOB (SCOPE_DEFINITION_ID_, SCOPE_TYPE_)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
create index CLM.ACT_IDX_JOB_SUB_SCOPE on CLM.ACT_RU_JOB (SUB_SCOPE_ID_, SCOPE_TYPE_)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
alter table CLM.ACT_RU_JOB
  add primary key (ID_)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
alter table CLM.ACT_RU_JOB
  add constraint ACT_FK_JOB_CUSTOM_VAL foreign key (CUSTOM_VALUES_ID_)
  references CLM.ACT_GE_BYTEARRAY (ID_);
alter table CLM.ACT_RU_JOB
  add constraint ACT_FK_JOB_EXCEPTION foreign key (EXCEPTION_STACK_ID_)
  references CLM.ACT_GE_BYTEARRAY (ID_);
alter table CLM.ACT_RU_JOB
  add constraint ACT_FK_JOB_EXECUTION foreign key (EXECUTION_ID_)
  references CLM.ACT_RU_EXECUTION (ID_);
alter table CLM.ACT_RU_JOB
  add constraint ACT_FK_JOB_PROCESS_INSTANCE foreign key (PROCESS_INSTANCE_ID_)
  references CLM.ACT_RU_EXECUTION (ID_);
alter table CLM.ACT_RU_JOB
  add constraint ACT_FK_JOB_PROC_DEF foreign key (PROC_DEF_ID_)
  references CLM.ACT_RE_PROCDEF (ID_);
alter table CLM.ACT_RU_JOB
  add check (EXCLUSIVE_ IN (1,0));

prompt
prompt Creating table ACT_RU_SUSPENDED_JOB
prompt ===================================
prompt
create table CLM.ACT_RU_SUSPENDED_JOB
(
  id_                  NVARCHAR2(64) not null,
  rev_                 INTEGER,
  type_                NVARCHAR2(255) not null,
  exclusive_           NUMBER(1),
  execution_id_        NVARCHAR2(64),
  process_instance_id_ NVARCHAR2(64),
  proc_def_id_         NVARCHAR2(64),
  element_id_          NVARCHAR2(255),
  element_name_        NVARCHAR2(255),
  scope_id_            NVARCHAR2(255),
  sub_scope_id_        NVARCHAR2(255),
  scope_type_          NVARCHAR2(255),
  scope_definition_id_ NVARCHAR2(255),
  retries_             INTEGER,
  exception_stack_id_  NVARCHAR2(64),
  exception_msg_       NVARCHAR2(2000),
  duedate_             TIMESTAMP(6),
  repeat_              NVARCHAR2(255),
  handler_type_        NVARCHAR2(255),
  handler_cfg_         NVARCHAR2(2000),
  custom_values_id_    NVARCHAR2(64),
  create_time_         TIMESTAMP(6),
  tenant_id_           NVARCHAR2(255) default ''
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
create index CLM.ACT_IDX_SJOB_CUSTOM_VAL_ID on CLM.ACT_RU_SUSPENDED_JOB (CUSTOM_VALUES_ID_)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
create index CLM.ACT_IDX_SJOB_EXCEPTION on CLM.ACT_RU_SUSPENDED_JOB (EXCEPTION_STACK_ID_)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
create index CLM.ACT_IDX_SJOB_EXECUTION_ID on CLM.ACT_RU_SUSPENDED_JOB (EXECUTION_ID_)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
create index CLM.ACT_IDX_SJOB_PROC_DEF_ID on CLM.ACT_RU_SUSPENDED_JOB (PROC_DEF_ID_)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
create index CLM.ACT_IDX_SJOB_PROC_INST_ID on CLM.ACT_RU_SUSPENDED_JOB (PROCESS_INSTANCE_ID_)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
create index CLM.ACT_IDX_SJOB_SCOPE on CLM.ACT_RU_SUSPENDED_JOB (SCOPE_ID_, SCOPE_TYPE_)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
create index CLM.ACT_IDX_SJOB_SCOPE_DEF on CLM.ACT_RU_SUSPENDED_JOB (SCOPE_DEFINITION_ID_, SCOPE_TYPE_)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
create index CLM.ACT_IDX_SJOB_SUB_SCOPE on CLM.ACT_RU_SUSPENDED_JOB (SUB_SCOPE_ID_, SCOPE_TYPE_)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
alter table CLM.ACT_RU_SUSPENDED_JOB
  add primary key (ID_)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
alter table CLM.ACT_RU_SUSPENDED_JOB
  add constraint ACT_FK_SJOB_CUSTOM_VAL foreign key (CUSTOM_VALUES_ID_)
  references CLM.ACT_GE_BYTEARRAY (ID_);
alter table CLM.ACT_RU_SUSPENDED_JOB
  add constraint ACT_FK_SJOB_EXCEPTION foreign key (EXCEPTION_STACK_ID_)
  references CLM.ACT_GE_BYTEARRAY (ID_);
alter table CLM.ACT_RU_SUSPENDED_JOB
  add constraint ACT_FK_SJOB_EXECUTION foreign key (EXECUTION_ID_)
  references CLM.ACT_RU_EXECUTION (ID_);
alter table CLM.ACT_RU_SUSPENDED_JOB
  add constraint ACT_FK_SJOB_PROCESS_INSTANCE foreign key (PROCESS_INSTANCE_ID_)
  references CLM.ACT_RU_EXECUTION (ID_);
alter table CLM.ACT_RU_SUSPENDED_JOB
  add constraint ACT_FK_SJOB_PROC_DEF foreign key (PROC_DEF_ID_)
  references CLM.ACT_RE_PROCDEF (ID_);
alter table CLM.ACT_RU_SUSPENDED_JOB
  add check (EXCLUSIVE_ IN (1,0));

prompt
prompt Creating table ACT_RU_TIMER_JOB
prompt ===============================
prompt
create table CLM.ACT_RU_TIMER_JOB
(
  id_                  NVARCHAR2(64) not null,
  rev_                 INTEGER,
  type_                NVARCHAR2(255) not null,
  lock_exp_time_       TIMESTAMP(6),
  lock_owner_          NVARCHAR2(255),
  exclusive_           NUMBER(1),
  execution_id_        NVARCHAR2(64),
  process_instance_id_ NVARCHAR2(64),
  proc_def_id_         NVARCHAR2(64),
  element_id_          NVARCHAR2(255),
  element_name_        NVARCHAR2(255),
  scope_id_            NVARCHAR2(255),
  sub_scope_id_        NVARCHAR2(255),
  scope_type_          NVARCHAR2(255),
  scope_definition_id_ NVARCHAR2(255),
  retries_             INTEGER,
  exception_stack_id_  NVARCHAR2(64),
  exception_msg_       NVARCHAR2(2000),
  duedate_             TIMESTAMP(6),
  repeat_              NVARCHAR2(255),
  handler_type_        NVARCHAR2(255),
  handler_cfg_         NVARCHAR2(2000),
  custom_values_id_    NVARCHAR2(64),
  create_time_         TIMESTAMP(6),
  tenant_id_           NVARCHAR2(255) default ''
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
create index CLM.ACT_IDX_TJOB_CUSTOM_VAL_ID on CLM.ACT_RU_TIMER_JOB (CUSTOM_VALUES_ID_)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
create index CLM.ACT_IDX_TJOB_EXCEPTION on CLM.ACT_RU_TIMER_JOB (EXCEPTION_STACK_ID_)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
create index CLM.ACT_IDX_TJOB_EXECUTION_ID on CLM.ACT_RU_TIMER_JOB (EXECUTION_ID_)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
create index CLM.ACT_IDX_TJOB_PROC_DEF_ID on CLM.ACT_RU_TIMER_JOB (PROC_DEF_ID_)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
create index CLM.ACT_IDX_TJOB_PROC_INST_ID on CLM.ACT_RU_TIMER_JOB (PROCESS_INSTANCE_ID_)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
create index CLM.ACT_IDX_TJOB_SCOPE on CLM.ACT_RU_TIMER_JOB (SCOPE_ID_, SCOPE_TYPE_)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
create index CLM.ACT_IDX_TJOB_SCOPE_DEF on CLM.ACT_RU_TIMER_JOB (SCOPE_DEFINITION_ID_, SCOPE_TYPE_)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
create index CLM.ACT_IDX_TJOB_SUB_SCOPE on CLM.ACT_RU_TIMER_JOB (SUB_SCOPE_ID_, SCOPE_TYPE_)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
alter table CLM.ACT_RU_TIMER_JOB
  add primary key (ID_)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
alter table CLM.ACT_RU_TIMER_JOB
  add constraint ACT_FK_TJOB_CUSTOM_VAL foreign key (CUSTOM_VALUES_ID_)
  references CLM.ACT_GE_BYTEARRAY (ID_);
alter table CLM.ACT_RU_TIMER_JOB
  add constraint ACT_FK_TJOB_EXCEPTION foreign key (EXCEPTION_STACK_ID_)
  references CLM.ACT_GE_BYTEARRAY (ID_);
alter table CLM.ACT_RU_TIMER_JOB
  add constraint ACT_FK_TJOB_EXECUTION foreign key (EXECUTION_ID_)
  references CLM.ACT_RU_EXECUTION (ID_);
alter table CLM.ACT_RU_TIMER_JOB
  add constraint ACT_FK_TJOB_PROCESS_INSTANCE foreign key (PROCESS_INSTANCE_ID_)
  references CLM.ACT_RU_EXECUTION (ID_);
alter table CLM.ACT_RU_TIMER_JOB
  add constraint ACT_FK_TJOB_PROC_DEF foreign key (PROC_DEF_ID_)
  references CLM.ACT_RE_PROCDEF (ID_);
alter table CLM.ACT_RU_TIMER_JOB
  add check (EXCLUSIVE_ IN (1,0));

prompt
prompt Creating table ACT_RU_VARIABLE
prompt ==============================
prompt
create table CLM.ACT_RU_VARIABLE
(
  id_           NVARCHAR2(64) not null,
  rev_          INTEGER,
  type_         NVARCHAR2(255) not null,
  name_         NVARCHAR2(255) not null,
  execution_id_ NVARCHAR2(64),
  proc_inst_id_ NVARCHAR2(64),
  task_id_      NVARCHAR2(64),
  scope_id_     NVARCHAR2(255),
  sub_scope_id_ NVARCHAR2(255),
  scope_type_   NVARCHAR2(255),
  bytearray_id_ NVARCHAR2(64),
  double_       NUMBER(*,10),
  long_         NUMBER(19),
  text_         NVARCHAR2(2000),
  text2_        NVARCHAR2(2000)
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
create index CLM.ACT_IDX_RU_VAR_SCOPE_ID_TYPE on CLM.ACT_RU_VARIABLE (SCOPE_ID_, SCOPE_TYPE_)
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
create index CLM.ACT_IDX_RU_VAR_SUB_ID_TYPE on CLM.ACT_RU_VARIABLE (SUB_SCOPE_ID_, SCOPE_TYPE_)
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
create index CLM.ACT_IDX_VARIABLE_TASK_ID on CLM.ACT_RU_VARIABLE (TASK_ID_)
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
create index CLM.ACT_IDX_VAR_BYTEARRAY on CLM.ACT_RU_VARIABLE (BYTEARRAY_ID_)
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
create index CLM.ACT_IDX_VAR_EXE on CLM.ACT_RU_VARIABLE (EXECUTION_ID_)
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
create index CLM.ACT_IDX_VAR_PROCINST on CLM.ACT_RU_VARIABLE (PROC_INST_ID_)
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
alter table CLM.ACT_RU_VARIABLE
  add primary key (ID_)
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
alter table CLM.ACT_RU_VARIABLE
  add constraint ACT_FK_VAR_BYTEARRAY foreign key (BYTEARRAY_ID_)
  references CLM.ACT_GE_BYTEARRAY (ID_);
alter table CLM.ACT_RU_VARIABLE
  add constraint ACT_FK_VAR_EXE foreign key (EXECUTION_ID_)
  references CLM.ACT_RU_EXECUTION (ID_);
alter table CLM.ACT_RU_VARIABLE
  add constraint ACT_FK_VAR_PROCINST foreign key (PROC_INST_ID_)
  references CLM.ACT_RU_EXECUTION (ID_);

prompt
prompt Creating table CHAIN_CLIENT
prompt ===========================
prompt
create table CLM.CHAIN_CLIENT
(
  id                      VARCHAR2(32) not null,
  client_id               VARCHAR2(48),
  client_secret           VARCHAR2(256),
  resource_ids            VARCHAR2(256),
  scope                   VARCHAR2(256),
  authorized_grant_types  VARCHAR2(256),
  web_server_redirect_uri VARCHAR2(256),
  authorities             VARCHAR2(256),
  access_token_validity   INTEGER,
  refresh_token_validity  INTEGER,
  additional_information  VARCHAR2(3000),
  autoapprove             VARCHAR2(256),
  create_user             VARCHAR2(32),
  create_dept             VARCHAR2(32),
  create_time             DATE,
  update_user             VARCHAR2(32),
  update_time             DATE,
  status                  INTEGER,
  is_deleted              INTEGER
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
comment on table CLM.CHAIN_CLIENT
  is '�ͻ��˱�';
comment on column CLM.CHAIN_CLIENT.id
  is '����';
comment on column CLM.CHAIN_CLIENT.client_id
  is '�ͻ���id';
comment on column CLM.CHAIN_CLIENT.client_secret
  is '�ͻ�����Կ';
comment on column CLM.CHAIN_CLIENT.resource_ids
  is '��Դ����';
comment on column CLM.CHAIN_CLIENT.scope
  is '��Ȩ��Χ';
comment on column CLM.CHAIN_CLIENT.authorized_grant_types
  is '��Ȩ����';
comment on column CLM.CHAIN_CLIENT.web_server_redirect_uri
  is '�ص���ַ';
comment on column CLM.CHAIN_CLIENT.authorities
  is 'Ȩ��';
comment on column CLM.CHAIN_CLIENT.access_token_validity
  is '���ƹ�������';
comment on column CLM.CHAIN_CLIENT.refresh_token_validity
  is 'ˢ�����ƹ�������';
comment on column CLM.CHAIN_CLIENT.additional_information
  is '����˵��';
comment on column CLM.CHAIN_CLIENT.autoapprove
  is '�Զ���Ȩ';
comment on column CLM.CHAIN_CLIENT.create_user
  is '������';
comment on column CLM.CHAIN_CLIENT.create_dept
  is '��������';
comment on column CLM.CHAIN_CLIENT.create_time
  is '����ʱ��';
comment on column CLM.CHAIN_CLIENT.update_user
  is '�޸���';
comment on column CLM.CHAIN_CLIENT.update_time
  is '�޸�ʱ��';
comment on column CLM.CHAIN_CLIENT.status
  is '״̬';
comment on column CLM.CHAIN_CLIENT.is_deleted
  is '�Ƿ���ɾ��';
alter table CLM.CHAIN_CLIENT
  add primary key (ID)
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
prompt Creating table CHAIN_CODE
prompt =========================
prompt
create table CLM.CHAIN_CODE
(
  id            VARCHAR2(32) not null,
  datasource_id VARCHAR2(32),
  service_name  VARCHAR2(64),
  code_name     VARCHAR2(64),
  table_name    VARCHAR2(64),
  table_prefix  VARCHAR2(64),
  pk_name       VARCHAR2(32),
  package_name  VARCHAR2(500),
  base_mode     INTEGER,
  wrap_mode     INTEGER,
  api_path      VARCHAR2(2000),
  web_path      VARCHAR2(2000),
  is_deleted    INTEGER
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
comment on table CLM.CHAIN_CODE
  is '�������ɱ�';
comment on column CLM.CHAIN_CODE.id
  is '����';
comment on column CLM.CHAIN_CODE.datasource_id
  is '����Դ����';
comment on column CLM.CHAIN_CODE.service_name
  is '��������';
comment on column CLM.CHAIN_CODE.code_name
  is 'ģ������';
comment on column CLM.CHAIN_CODE.table_name
  is '����';
comment on column CLM.CHAIN_CODE.table_prefix
  is '��ǰ׺';
comment on column CLM.CHAIN_CODE.pk_name
  is '������';
comment on column CLM.CHAIN_CODE.package_name
  is '��˰���';
comment on column CLM.CHAIN_CODE.base_mode
  is '����ҵ��ģʽ';
comment on column CLM.CHAIN_CODE.wrap_mode
  is '��װ��ģʽ';
comment on column CLM.CHAIN_CODE.api_path
  is '���·��';
comment on column CLM.CHAIN_CODE.web_path
  is 'ǰ��·��';
comment on column CLM.CHAIN_CODE.is_deleted
  is '�Ƿ���ɾ��';
alter table CLM.CHAIN_CODE
  add primary key (ID)
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
prompt Creating table CHAIN_DATASOURCE
prompt ===============================
prompt
create table CLM.CHAIN_DATASOURCE
(
  id           VARCHAR2(32) not null,
  name         VARCHAR2(100),
  driver_class VARCHAR2(100),
  url          VARCHAR2(500),
  username     VARCHAR2(50),
  password     VARCHAR2(50),
  remark       VARCHAR2(255),
  create_user  VARCHAR2(32),
  create_dept  VARCHAR2(32),
  create_time  DATE,
  update_user  VARCHAR2(32),
  update_time  DATE,
  status       INTEGER,
  is_deleted   INTEGER
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
comment on table CLM.CHAIN_DATASOURCE
  is '����Դ���ñ�';
comment on column CLM.CHAIN_DATASOURCE.id
  is '����';
comment on column CLM.CHAIN_DATASOURCE.name
  is '����';
comment on column CLM.CHAIN_DATASOURCE.driver_class
  is '������';
comment on column CLM.CHAIN_DATASOURCE.url
  is '���ӵ�ַ';
comment on column CLM.CHAIN_DATASOURCE.username
  is '�û���';
comment on column CLM.CHAIN_DATASOURCE.password
  is '����';
comment on column CLM.CHAIN_DATASOURCE.remark
  is '��ע';
comment on column CLM.CHAIN_DATASOURCE.create_user
  is '������';
comment on column CLM.CHAIN_DATASOURCE.create_dept
  is '��������';
comment on column CLM.CHAIN_DATASOURCE.create_time
  is '����ʱ��';
comment on column CLM.CHAIN_DATASOURCE.update_user
  is '�޸���';
comment on column CLM.CHAIN_DATASOURCE.update_time
  is '�޸�ʱ��';
comment on column CLM.CHAIN_DATASOURCE.status
  is '״̬';
comment on column CLM.CHAIN_DATASOURCE.is_deleted
  is '�Ƿ���ɾ��';
alter table CLM.CHAIN_DATASOURCE
  add primary key (ID)
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
prompt Creating table CHAIN_DEPT
prompt =========================
prompt
create table CLM.CHAIN_DEPT
(
  id               VARCHAR2(32) not null,
  tenant_id        VARCHAR2(12),
  parent_id        VARCHAR2(32),
  ancestors        VARCHAR2(2000),
  dept_category    VARCHAR2(2),
  dept_name        VARCHAR2(200),
  full_name        VARCHAR2(200),
  corp_org_code    VARCHAR2(5),
  dept_level       VARCHAR2(5),
  org_state        VARCHAR2(1),
  org_attr         VARCHAR2(2),
  manage_org_type  VARCHAR2(10),
  org_type         VARCHAR2(10),
  org_code_certifi VARCHAR2(20),
  pb_org_lc        VARCHAR2(20),
  start_date       VARCHAR2(30),
  end_date         VARCHAR2(30),
  province_code    VARCHAR2(5),
  aera_code        VARCHAR2(10),
  org_address      VARCHAR2(100),
  tel_num          VARCHAR2(30),
  zip_code         VARCHAR2(10),
  sort             INTEGER,
  remark           VARCHAR2(255),
  create_time      DATE,
  update_time      DATE,
  is_deleted       NUMBER
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
comment on table CLM.CHAIN_DEPT
  is '������';
comment on column CLM.CHAIN_DEPT.id
  is '����';
comment on column CLM.CHAIN_DEPT.tenant_id
  is '�⻧ID';
comment on column CLM.CHAIN_DEPT.parent_id
  is '������';
comment on column CLM.CHAIN_DEPT.ancestors
  is '�漶�б�';
comment on column CLM.CHAIN_DEPT.dept_category
  is '��������';
comment on column CLM.CHAIN_DEPT.dept_name
  is '������';
comment on column CLM.CHAIN_DEPT.full_name
  is '����ȫ��';
comment on column CLM.CHAIN_DEPT.corp_org_code
  is '���˻���';
comment on column CLM.CHAIN_DEPT.dept_level
  is '��������';
comment on column CLM.CHAIN_DEPT.org_state
  is '����״̬';
comment on column CLM.CHAIN_DEPT.org_attr
  is '��������';
comment on column CLM.CHAIN_DEPT.manage_org_type
  is '�����������';
comment on column CLM.CHAIN_DEPT.org_type
  is '�������ͣ�CD000214��';
comment on column CLM.CHAIN_DEPT.org_code_certifi
  is '��֯��������';
comment on column CLM.CHAIN_DEPT.pb_org_lc
  is '���л�������֤';
comment on column CLM.CHAIN_DEPT.start_date
  is '��ҵ����';
comment on column CLM.CHAIN_DEPT.end_date
  is '��ҵ����';
comment on column CLM.CHAIN_DEPT.province_code
  is 'ʡ������';
comment on column CLM.CHAIN_DEPT.aera_code
  is '��������';
comment on column CLM.CHAIN_DEPT.org_address
  is '������ַ';
comment on column CLM.CHAIN_DEPT.tel_num
  is '��ϵ�绰';
comment on column CLM.CHAIN_DEPT.zip_code
  is '��������';
comment on column CLM.CHAIN_DEPT.sort
  is '����';
comment on column CLM.CHAIN_DEPT.remark
  is '��ע';
comment on column CLM.CHAIN_DEPT.create_time
  is '����ʱ��';
comment on column CLM.CHAIN_DEPT.update_time
  is '����ʱ��';
alter table CLM.CHAIN_DEPT
  add constraint PK_CHAIN_DEPT primary key (ID)
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
prompt Creating table CHAIN_DEPT_NAME
prompt ==============================
prompt
create table CLM.CHAIN_DEPT_NAME
(
  dept_id      VARCHAR2(20) not null,
  dept_oldname VARCHAR2(100),
  dept_newname VARCHAR2(100)
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
comment on column CLM.CHAIN_DEPT_NAME.dept_id
  is '����ID';
comment on column CLM.CHAIN_DEPT_NAME.dept_oldname
  is '����������';
comment on column CLM.CHAIN_DEPT_NAME.dept_newname
  is '����������';

prompt
prompt Creating table CHAIN_DICT
prompt =========================
prompt
create table CLM.CHAIN_DICT
(
  id            VARCHAR2(32) not null,
  parent_id     VARCHAR2(32) default '0',
  code          VARCHAR2(255),
  dict_key      VARCHAR2(20),
  dict_value    VARCHAR2(255),
  sort          INTEGER,
  remark        VARCHAR2(255),
  is_deleted    INTEGER,
  code_cn       VARCHAR2(30),
  dict_value_en VARCHAR2(10)
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
comment on table CLM.CHAIN_DICT
  is '�ֵ��';
comment on column CLM.CHAIN_DICT.id
  is '����';
comment on column CLM.CHAIN_DICT.parent_id
  is '������';
comment on column CLM.CHAIN_DICT.code
  is '�ֵ���';
comment on column CLM.CHAIN_DICT.dict_key
  is '�ֵ�ֵ';
comment on column CLM.CHAIN_DICT.dict_value
  is '�ֵ�����';
comment on column CLM.CHAIN_DICT.sort
  is '����';
comment on column CLM.CHAIN_DICT.remark
  is '�ֵ䱸ע';
comment on column CLM.CHAIN_DICT.is_deleted
  is '�Ƿ���ɾ��';
comment on column CLM.CHAIN_DICT.code_cn
  is '�ֵ���������';
comment on column CLM.CHAIN_DICT.dict_value_en
  is '�ֵ�ֵ';
alter table CLM.CHAIN_DICT
  add primary key (ID)
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
prompt Creating table CHAIN_DROOLS_CONSTANT
prompt ====================================
prompt
create table CLM.CHAIN_DROOLS_CONSTANT
(
  id          VARCHAR2(50) not null,
  rule_id     VARCHAR2(50),
  const_code  VARCHAR2(30),
  const_name  VARCHAR2(50),
  const_type  VARCHAR2(200),
  const_value VARCHAR2(200),
  is_deleted  NUMBER
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
comment on table CLM.CHAIN_DROOLS_CONSTANT
  is '��������';
alter table CLM.CHAIN_DROOLS_CONSTANT
  add constraint PK_CHAIN_DROOLS_CONSTANT primary key (ID)
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
prompt Creating table CHAIN_DROOLS_DETAIL
prompt ==================================
prompt
create table CLM.CHAIN_DROOLS_DETAIL
(
  id              NVARCHAR2(50) not null,
  rule_id         NVARCHAR2(50),
  rule_name       NVARCHAR2(100),
  rule_priority   NVARCHAR2(5),
  rule_condition  NVARCHAR2(1000),
  rule_expression NVARCHAR2(1000),
  expression_cn   NVARCHAR2(1000),
  is_deleted      NUMBER,
  condition_cn    VARCHAR2(1000)
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
comment on table CLM.CHAIN_DROOLS_DETAIL
  is '������ϸ��';
alter table CLM.CHAIN_DROOLS_DETAIL
  add constraint PK_CHAIN_DROOLS_DETAIL primary key (ID)
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
prompt Creating table CHAIN_DROOLS_RULES
prompt =================================
prompt
create table CLM.CHAIN_DROOLS_RULES
(
  id             VARCHAR2(32) not null,
  name           VARCHAR2(50),
  rules          CLOB,
  is_deleted     NUMBER default 0,
  code           VARCHAR2(50),
  biz_class_path VARCHAR2(200),
  biz_class_name VARCHAR2(50),
  biz_name       VARCHAR2(50),
  biz_explain    VARCHAR2(1000)
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
alter table CLM.CHAIN_DROOLS_RULES
  add constraint PK_CHAIN_DROOLS_RULES primary key (ID)
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
prompt Creating table CHAIN_LOG_API
prompt ============================
prompt
create table CLM.CHAIN_LOG_API
(
  id           VARCHAR2(32) not null,
  tenant_id    VARCHAR2(12),
  service_id   VARCHAR2(32),
  server_host  VARCHAR2(255),
  server_ip    VARCHAR2(255),
  env          VARCHAR2(255),
  type         CHAR(1),
  title        VARCHAR2(255),
  method       VARCHAR2(10),
  request_uri  VARCHAR2(255),
  user_agent   VARCHAR2(1000),
  remote_ip    VARCHAR2(255),
  method_class VARCHAR2(255),
  method_name  VARCHAR2(255),
  params       CLOB,
  time         VARCHAR2(64),
  create_by    VARCHAR2(64),
  create_time  DATE
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
comment on table CLM.CHAIN_LOG_API
  is '�ӿ���־��';
comment on column CLM.CHAIN_LOG_API.id
  is '���';
comment on column CLM.CHAIN_LOG_API.tenant_id
  is '�⻧ID';
comment on column CLM.CHAIN_LOG_API.service_id
  is '����ID';
comment on column CLM.CHAIN_LOG_API.server_host
  is '��������';
comment on column CLM.CHAIN_LOG_API.server_ip
  is '������IP��ַ';
comment on column CLM.CHAIN_LOG_API.env
  is '����������';
comment on column CLM.CHAIN_LOG_API.type
  is '��־����';
comment on column CLM.CHAIN_LOG_API.title
  is '��־����';
comment on column CLM.CHAIN_LOG_API.method
  is '������ʽ';
comment on column CLM.CHAIN_LOG_API.request_uri
  is '����URI';
comment on column CLM.CHAIN_LOG_API.user_agent
  is '�û�����';
comment on column CLM.CHAIN_LOG_API.remote_ip
  is '����IP��ַ';
comment on column CLM.CHAIN_LOG_API.method_class
  is '������';
comment on column CLM.CHAIN_LOG_API.method_name
  is '������';
comment on column CLM.CHAIN_LOG_API.params
  is '�����ύ������';
comment on column CLM.CHAIN_LOG_API.time
  is 'ִ��ʱ��';
comment on column CLM.CHAIN_LOG_API.create_by
  is '������';
alter table CLM.CHAIN_LOG_API
  add primary key (ID)
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
prompt Creating table CHAIN_LOG_ERROR
prompt ==============================
prompt
create table CLM.CHAIN_LOG_ERROR
(
  id             VARCHAR2(32) not null,
  tenant_id      VARCHAR2(12),
  service_id     VARCHAR2(32),
  server_host    VARCHAR2(255),
  server_ip      VARCHAR2(255),
  env            VARCHAR2(255),
  method         VARCHAR2(10),
  request_uri    VARCHAR2(255),
  user_agent     VARCHAR2(1000),
  exception_name VARCHAR2(255),
  message        VARCHAR2(2000),
  line_number    NUMBER,
  method_class   VARCHAR2(255),
  file_name      VARCHAR2(1000),
  method_name    VARCHAR2(255),
  create_by      VARCHAR2(64),
  create_time    DATE,
  stack_trace    CLOB,
  params         CLOB
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
alter table CLM.CHAIN_LOG_ERROR
  add primary key (ID)
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
prompt Creating table CHAIN_LOG_USUAL
prompt ==============================
prompt
create table CLM.CHAIN_LOG_USUAL
(
  id          VARCHAR2(32) not null,
  tenant_id   VARCHAR2(12),
  service_id  VARCHAR2(32),
  server_host VARCHAR2(255),
  server_ip   VARCHAR2(255),
  env         VARCHAR2(255),
  log_level   VARCHAR2(10),
  log_id      VARCHAR2(100),
  log_data    VARCHAR2(2000),
  method      VARCHAR2(10),
  request_uri VARCHAR2(255),
  user_agent  VARCHAR2(1000),
  params      VARCHAR2(2000),
  create_by   VARCHAR2(64),
  create_time DATE
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on table CLM.CHAIN_LOG_USUAL
  is 'ͨ����־��';
comment on column CLM.CHAIN_LOG_USUAL.id
  is '���';
comment on column CLM.CHAIN_LOG_USUAL.tenant_id
  is '�⻧ID';
comment on column CLM.CHAIN_LOG_USUAL.service_id
  is '����ID';
comment on column CLM.CHAIN_LOG_USUAL.server_host
  is '��������';
comment on column CLM.CHAIN_LOG_USUAL.server_ip
  is '������IP��ַ';
comment on column CLM.CHAIN_LOG_USUAL.env
  is 'ϵͳ����';
comment on column CLM.CHAIN_LOG_USUAL.log_level
  is '��־����';
comment on column CLM.CHAIN_LOG_USUAL.log_id
  is '��־ҵ��id';
comment on column CLM.CHAIN_LOG_USUAL.log_data
  is '��־����';
comment on column CLM.CHAIN_LOG_USUAL.method
  is '������ʽ';
comment on column CLM.CHAIN_LOG_USUAL.request_uri
  is '����URI';
comment on column CLM.CHAIN_LOG_USUAL.user_agent
  is '�û�����';
comment on column CLM.CHAIN_LOG_USUAL.params
  is '�����ύ������';
comment on column CLM.CHAIN_LOG_USUAL.create_by
  is '������';
comment on column CLM.CHAIN_LOG_USUAL.create_time
  is '����ʱ��';
alter table CLM.CHAIN_LOG_USUAL
  add primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table CHAIN_MENU
prompt =========================
prompt
create table CLM.CHAIN_MENU
(
  id         VARCHAR2(32) not null,
  parent_id  VARCHAR2(32) default '0',
  code       VARCHAR2(255),
  name       VARCHAR2(255),
  alias      VARCHAR2(255),
  path       VARCHAR2(255),
  source     VARCHAR2(255),
  sort       INTEGER not null,
  category   VARCHAR2(2),
  action     INTEGER,
  is_open    INTEGER,
  remark     VARCHAR2(255),
  is_deleted INTEGER default 0
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
comment on table CLM.CHAIN_MENU
  is '�˵���';
comment on column CLM.CHAIN_MENU.id
  is '����';
comment on column CLM.CHAIN_MENU.parent_id
  is '�����˵�';
comment on column CLM.CHAIN_MENU.code
  is '�˵����';
comment on column CLM.CHAIN_MENU.name
  is '�˵�����';
comment on column CLM.CHAIN_MENU.alias
  is '�˵�����';
comment on column CLM.CHAIN_MENU.path
  is '�����ַ';
comment on column CLM.CHAIN_MENU.source
  is '�˵���Դ';
comment on column CLM.CHAIN_MENU.sort
  is '����';
comment on column CLM.CHAIN_MENU.category
  is '�˵�����';
comment on column CLM.CHAIN_MENU.action
  is '������ť����';
comment on column CLM.CHAIN_MENU.is_open
  is '�Ƿ����ҳ��';
comment on column CLM.CHAIN_MENU.remark
  is '��ע';
comment on column CLM.CHAIN_MENU.is_deleted
  is '�Ƿ���ɾ��';
alter table CLM.CHAIN_MENU
  add primary key (ID)
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
prompt Creating table CHAIN_NOTICE
prompt ===========================
prompt
create table CLM.CHAIN_NOTICE
(
  id           VARCHAR2(32) not null,
  tenant_id    VARCHAR2(12),
  title        VARCHAR2(255),
  category     VARCHAR2(2),
  release_time VARCHAR2(20),
  content      VARCHAR2(2000),
  create_user  VARCHAR2(32),
  create_dept  VARCHAR2(32),
  create_time  DATE,
  update_user  VARCHAR2(32),
  update_time  DATE,
  status       INTEGER,
  is_deleted   INTEGER
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
comment on table CLM.CHAIN_NOTICE
  is '֪ͨ�����';
comment on column CLM.CHAIN_NOTICE.id
  is '����';
comment on column CLM.CHAIN_NOTICE.tenant_id
  is '�⻧ID';
comment on column CLM.CHAIN_NOTICE.title
  is '����';
comment on column CLM.CHAIN_NOTICE.category
  is '����';
comment on column CLM.CHAIN_NOTICE.release_time
  is '����ʱ��';
comment on column CLM.CHAIN_NOTICE.content
  is '����';
comment on column CLM.CHAIN_NOTICE.create_user
  is '������';
comment on column CLM.CHAIN_NOTICE.create_dept
  is '��������';
comment on column CLM.CHAIN_NOTICE.create_time
  is '����ʱ��';
comment on column CLM.CHAIN_NOTICE.update_user
  is '�޸���';
comment on column CLM.CHAIN_NOTICE.update_time
  is '�޸�ʱ��';
comment on column CLM.CHAIN_NOTICE.status
  is '״̬';
comment on column CLM.CHAIN_NOTICE.is_deleted
  is '�Ƿ���ɾ��';
alter table CLM.CHAIN_NOTICE
  add primary key (ID)
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
prompt Creating table CHAIN_OSS
prompt ========================
prompt
create table CLM.CHAIN_OSS
(
  id          VARCHAR2(32) not null,
  tenant_id   VARCHAR2(12),
  category    INTEGER,
  endpoint    VARCHAR2(255),
  access_key  VARCHAR2(255),
  secret_key  VARCHAR2(255),
  bucket_name VARCHAR2(255),
  remark      VARCHAR2(255),
  create_user VARCHAR2(32),
  create_dept VARCHAR2(32),
  create_time DATE,
  update_user VARCHAR2(32),
  update_time DATE,
  status      INTEGER,
  is_deleted  INTEGER
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
comment on table CLM.CHAIN_OSS
  is '����洢��';
comment on column CLM.CHAIN_OSS.id
  is '����';
comment on column CLM.CHAIN_OSS.tenant_id
  is '�⻧ID';
comment on column CLM.CHAIN_OSS.category
  is '����';
comment on column CLM.CHAIN_OSS.endpoint
  is '��Դ��ַ';
comment on column CLM.CHAIN_OSS.access_key
  is 'accessKey';
comment on column CLM.CHAIN_OSS.secret_key
  is 'secretKey';
comment on column CLM.CHAIN_OSS.bucket_name
  is '�ռ���';
comment on column CLM.CHAIN_OSS.remark
  is '��ע';
comment on column CLM.CHAIN_OSS.create_user
  is '������';
comment on column CLM.CHAIN_OSS.create_dept
  is '��������';
comment on column CLM.CHAIN_OSS.create_time
  is '����ʱ��';
comment on column CLM.CHAIN_OSS.update_user
  is '�޸���';
comment on column CLM.CHAIN_OSS.update_time
  is '�޸�ʱ��';
comment on column CLM.CHAIN_OSS.status
  is '״̬';
comment on column CLM.CHAIN_OSS.is_deleted
  is '�Ƿ���ɾ��';
alter table CLM.CHAIN_OSS
  add primary key (ID)
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
prompt Creating table CHAIN_PARAM
prompt ==========================
prompt
create table CLM.CHAIN_PARAM
(
  id          VARCHAR2(32) not null,
  param_name  VARCHAR2(255),
  param_key   VARCHAR2(255),
  param_value VARCHAR2(255),
  remark      VARCHAR2(255),
  create_user VARCHAR2(32),
  create_dept VARCHAR2(32),
  create_time DATE,
  update_user VARCHAR2(32),
  update_time DATE,
  status      INTEGER,
  is_deleted  INTEGER
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
comment on table CLM.CHAIN_PARAM
  is '������';
comment on column CLM.CHAIN_PARAM.id
  is '����';
comment on column CLM.CHAIN_PARAM.param_name
  is '������';
comment on column CLM.CHAIN_PARAM.param_key
  is '������';
comment on column CLM.CHAIN_PARAM.param_value
  is '����ֵ';
comment on column CLM.CHAIN_PARAM.remark
  is '��ע';
comment on column CLM.CHAIN_PARAM.create_user
  is '������';
comment on column CLM.CHAIN_PARAM.create_dept
  is '��������';
comment on column CLM.CHAIN_PARAM.create_time
  is '����ʱ��';
comment on column CLM.CHAIN_PARAM.update_user
  is '�޸���';
comment on column CLM.CHAIN_PARAM.update_time
  is '�޸�ʱ��';
comment on column CLM.CHAIN_PARAM.status
  is '״̬';
comment on column CLM.CHAIN_PARAM.is_deleted
  is '�Ƿ���ɾ��';
alter table CLM.CHAIN_PARAM
  add primary key (ID)
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
prompt Creating table CHAIN_PROCESS_LEAVE
prompt ==================================
prompt
create table CLM.CHAIN_PROCESS_LEAVE
(
  id                    VARCHAR2(32) not null,
  process_definition_id VARCHAR2(64),
  process_instance_id   VARCHAR2(64),
  start_time            DATE,
  end_time              DATE,
  reason                VARCHAR2(255),
  task_user             VARCHAR2(255),
  apply_time            DATE,
  create_user           VARCHAR2(32),
  create_dept           VARCHAR2(32),
  create_time           DATE,
  update_user           VARCHAR2(32),
  update_time           DATE,
  status                INTEGER,
  is_deleted            INTEGER
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
comment on table CLM.CHAIN_PROCESS_LEAVE
  is '�������ҵ���';
comment on column CLM.CHAIN_PROCESS_LEAVE.id
  is '���';
comment on column CLM.CHAIN_PROCESS_LEAVE.process_definition_id
  is '���̶�������';
comment on column CLM.CHAIN_PROCESS_LEAVE.process_instance_id
  is '����ʵ������';
comment on column CLM.CHAIN_PROCESS_LEAVE.start_time
  is '��ʼʱ��';
comment on column CLM.CHAIN_PROCESS_LEAVE.end_time
  is '����ʱ��';
comment on column CLM.CHAIN_PROCESS_LEAVE.reason
  is '�������';
comment on column CLM.CHAIN_PROCESS_LEAVE.task_user
  is '��һ��������';
comment on column CLM.CHAIN_PROCESS_LEAVE.apply_time
  is '����ʱ��';
comment on column CLM.CHAIN_PROCESS_LEAVE.create_user
  is '������';
comment on column CLM.CHAIN_PROCESS_LEAVE.create_dept
  is '��������';
comment on column CLM.CHAIN_PROCESS_LEAVE.create_time
  is '����ʱ��';
comment on column CLM.CHAIN_PROCESS_LEAVE.update_user
  is '�޸���';
comment on column CLM.CHAIN_PROCESS_LEAVE.update_time
  is '�޸�ʱ��';
comment on column CLM.CHAIN_PROCESS_LEAVE.status
  is '״̬';
comment on column CLM.CHAIN_PROCESS_LEAVE.is_deleted
  is '�Ƿ���ɾ��';
alter table CLM.CHAIN_PROCESS_LEAVE
  add primary key (ID)
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
prompt Creating table CHAIN_ROLE
prompt =========================
prompt
create table CLM.CHAIN_ROLE
(
  id            VARCHAR2(32) not null,
  tenant_id     VARCHAR2(12),
  parent_id     VARCHAR2(32),
  role_name     VARCHAR2(255),
  sort          INTEGER,
  role_alias    VARCHAR2(255),
  is_deleted    INTEGER,
  dept_category VARCHAR2(2),
  dept_level    VARCHAR2(2)
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
comment on table CLM.CHAIN_ROLE
  is '��ɫ��';
comment on column CLM.CHAIN_ROLE.id
  is '����';
comment on column CLM.CHAIN_ROLE.tenant_id
  is '�⻧ID';
comment on column CLM.CHAIN_ROLE.parent_id
  is '������';
comment on column CLM.CHAIN_ROLE.role_name
  is '��ɫ��';
comment on column CLM.CHAIN_ROLE.sort
  is '����';
comment on column CLM.CHAIN_ROLE.role_alias
  is '��ɫ����';
comment on column CLM.CHAIN_ROLE.is_deleted
  is '�Ƿ���ɾ��';
alter table CLM.CHAIN_ROLE
  add primary key (ID)
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
prompt Creating table CHAIN_ROLE_MENU
prompt ==============================
prompt
create table CLM.CHAIN_ROLE_MENU
(
  id      VARCHAR2(32) not null,
  menu_id VARCHAR2(32),
  role_id VARCHAR2(32)
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
comment on table CLM.CHAIN_ROLE_MENU
  is '��ɫ�˵�������';
comment on column CLM.CHAIN_ROLE_MENU.id
  is '����';
comment on column CLM.CHAIN_ROLE_MENU.menu_id
  is '�˵�id';
comment on column CLM.CHAIN_ROLE_MENU.role_id
  is '��ɫid';
alter table CLM.CHAIN_ROLE_MENU
  add primary key (ID)
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
prompt Creating table CHAIN_ROLE_SCOPE
prompt ===============================
prompt
create table CLM.CHAIN_ROLE_SCOPE
(
  id             VARCHAR2(32) not null,
  scope_category INTEGER,
  scope_id       VARCHAR2(32),
  role_id        VARCHAR2(32)
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
comment on table CLM.CHAIN_ROLE_SCOPE
  is '��ɫ����Ȩ�޹�����';
comment on column CLM.CHAIN_ROLE_SCOPE.id
  is '����';
comment on column CLM.CHAIN_ROLE_SCOPE.scope_category
  is 'Ȩ������(1:����Ȩ�ޡ�2:�ӿ�Ȩ��)';
comment on column CLM.CHAIN_ROLE_SCOPE.scope_id
  is 'Ȩ��id';
alter table CLM.CHAIN_ROLE_SCOPE
  add primary key (ID)
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
prompt Creating table CHAIN_SCOPE_API
prompt ==============================
prompt
create table CLM.CHAIN_SCOPE_API
(
  id            VARCHAR2(32) not null,
  menu_id       VARCHAR2(32),
  resource_code VARCHAR2(255),
  scope_name    VARCHAR2(255),
  scope_path    VARCHAR2(255),
  scope_type    INTEGER,
  remark        VARCHAR2(255),
  create_user   VARCHAR2(32),
  create_dept   VARCHAR2(32),
  create_time   DATE,
  update_user   VARCHAR2(32),
  update_time   DATE,
  status        INTEGER,
  is_deleted    INTEGER
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
comment on table CLM.CHAIN_SCOPE_API
  is '�ӿ�Ȩ�ޱ�';
comment on column CLM.CHAIN_SCOPE_API.id
  is '����';
comment on column CLM.CHAIN_SCOPE_API.menu_id
  is '�˵�����';
comment on column CLM.CHAIN_SCOPE_API.resource_code
  is '��Դ���';
comment on column CLM.CHAIN_SCOPE_API.scope_name
  is '�ӿ�Ȩ����';
comment on column CLM.CHAIN_SCOPE_API.scope_path
  is '�ӿ�Ȩ�޵�ַ';
comment on column CLM.CHAIN_SCOPE_API.scope_type
  is '�ӿ�Ȩ������';
comment on column CLM.CHAIN_SCOPE_API.remark
  is '�ӿ�Ȩ�ޱ�ע';
comment on column CLM.CHAIN_SCOPE_API.create_user
  is '������';
comment on column CLM.CHAIN_SCOPE_API.create_dept
  is '��������';
comment on column CLM.CHAIN_SCOPE_API.create_time
  is '����ʱ��';
comment on column CLM.CHAIN_SCOPE_API.update_user
  is '�޸���';
comment on column CLM.CHAIN_SCOPE_API.update_time
  is '�޸�ʱ��';
comment on column CLM.CHAIN_SCOPE_API.status
  is '״̬';
comment on column CLM.CHAIN_SCOPE_API.is_deleted
  is '�Ƿ���ɾ��';
alter table CLM.CHAIN_SCOPE_API
  add primary key (ID)
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
prompt Creating table CHAIN_SCOPE_DATA
prompt ===============================
prompt
create table CLM.CHAIN_SCOPE_DATA
(
  id            VARCHAR2(32) not null,
  menu_id       VARCHAR2(32),
  resource_code VARCHAR2(255),
  scope_name    VARCHAR2(255),
  scope_field   VARCHAR2(255),
  scope_class   VARCHAR2(500),
  scope_column  VARCHAR2(255),
  scope_type    INTEGER,
  scope_value   VARCHAR2(2000),
  remark        VARCHAR2(255),
  create_user   VARCHAR2(32),
  create_dept   VARCHAR2(32),
  create_time   DATE,
  update_user   VARCHAR2(32),
  update_time   DATE,
  status        INTEGER,
  is_deleted    INTEGER
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
comment on table CLM.CHAIN_SCOPE_DATA
  is '����Ȩ�ޱ�';
comment on column CLM.CHAIN_SCOPE_DATA.id
  is '����';
comment on column CLM.CHAIN_SCOPE_DATA.menu_id
  is '�˵�����';
comment on column CLM.CHAIN_SCOPE_DATA.resource_code
  is '��Դ���';
comment on column CLM.CHAIN_SCOPE_DATA.scope_name
  is '����Ȩ������';
comment on column CLM.CHAIN_SCOPE_DATA.scope_field
  is '����Ȩ���ֶ�';
comment on column CLM.CHAIN_SCOPE_DATA.scope_class
  is '����Ȩ������';
comment on column CLM.CHAIN_SCOPE_DATA.scope_column
  is '����Ȩ����';
comment on column CLM.CHAIN_SCOPE_DATA.scope_type
  is '����Ȩ������';
comment on column CLM.CHAIN_SCOPE_DATA.scope_value
  is '����Ȩ��ֵ��';
comment on column CLM.CHAIN_SCOPE_DATA.remark
  is '����Ȩ�ޱ�ע';
comment on column CLM.CHAIN_SCOPE_DATA.create_user
  is '������';
comment on column CLM.CHAIN_SCOPE_DATA.create_dept
  is '��������';
comment on column CLM.CHAIN_SCOPE_DATA.create_time
  is '����ʱ��';
comment on column CLM.CHAIN_SCOPE_DATA.update_user
  is '�޸���';
comment on column CLM.CHAIN_SCOPE_DATA.update_time
  is '�޸�ʱ��';
alter table CLM.CHAIN_SCOPE_DATA
  add primary key (ID)
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
prompt Creating table CHAIN_TENANT
prompt ===========================
prompt
create table CLM.CHAIN_TENANT
(
  id             VARCHAR2(32) not null,
  tenant_id      VARCHAR2(12),
  tenant_name    VARCHAR2(50),
  linkman        VARCHAR2(20),
  contact_number VARCHAR2(20),
  address        VARCHAR2(255),
  create_user    VARCHAR2(32),
  create_dept    VARCHAR2(32),
  create_time    DATE,
  update_user    VARCHAR2(32),
  update_time    DATE,
  status         INTEGER,
  is_deleted     INTEGER
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
comment on table CLM.CHAIN_TENANT
  is '�⻧��';
comment on column CLM.CHAIN_TENANT.id
  is '����';
comment on column CLM.CHAIN_TENANT.tenant_id
  is '�⻧ID';
comment on column CLM.CHAIN_TENANT.tenant_name
  is '�⻧����';
comment on column CLM.CHAIN_TENANT.linkman
  is '��ϵ��';
comment on column CLM.CHAIN_TENANT.contact_number
  is '��ϵ�绰';
comment on column CLM.CHAIN_TENANT.address
  is '��ϵ��ַ';
comment on column CLM.CHAIN_TENANT.create_user
  is '������';
comment on column CLM.CHAIN_TENANT.create_dept
  is '��������';
comment on column CLM.CHAIN_TENANT.create_time
  is '����ʱ��';
comment on column CLM.CHAIN_TENANT.update_user
  is '�޸���';
comment on column CLM.CHAIN_TENANT.update_time
  is '�޸�ʱ��';
comment on column CLM.CHAIN_TENANT.status
  is '״̬';
comment on column CLM.CHAIN_TENANT.is_deleted
  is '�Ƿ���ɾ��';
alter table CLM.CHAIN_TENANT
  add primary key (ID)
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
prompt Creating table CHAIN_TOP_MENU
prompt =============================
prompt
create table CLM.CHAIN_TOP_MENU
(
  id          VARCHAR2(32) not null,
  tenant_id   VARCHAR2(12),
  code        VARCHAR2(255),
  name        VARCHAR2(255),
  source      VARCHAR2(255),
  sort        INTEGER,
  create_user VARCHAR2(32),
  create_dept VARCHAR2(32),
  create_time DATE,
  update_user VARCHAR2(32),
  update_time DATE,
  status      INTEGER,
  is_deleted  INTEGER
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
comment on table CLM.CHAIN_TOP_MENU
  is '�����˵���';
comment on column CLM.CHAIN_TOP_MENU.id
  is '����';
comment on column CLM.CHAIN_TOP_MENU.tenant_id
  is '�⻧id';
comment on column CLM.CHAIN_TOP_MENU.code
  is '�����˵����';
comment on column CLM.CHAIN_TOP_MENU.name
  is '�����˵���';
comment on column CLM.CHAIN_TOP_MENU.source
  is '�����˵���Դ';
comment on column CLM.CHAIN_TOP_MENU.sort
  is '�����˵�����';
comment on column CLM.CHAIN_TOP_MENU.create_user
  is '������';
comment on column CLM.CHAIN_TOP_MENU.create_dept
  is '��������';
comment on column CLM.CHAIN_TOP_MENU.create_time
  is '����ʱ��';
comment on column CLM.CHAIN_TOP_MENU.update_user
  is '�޸���';
comment on column CLM.CHAIN_TOP_MENU.update_time
  is '�޸�ʱ��';
comment on column CLM.CHAIN_TOP_MENU.status
  is '״̬';
comment on column CLM.CHAIN_TOP_MENU.is_deleted
  is '�Ƿ���ɾ��';
alter table CLM.CHAIN_TOP_MENU
  add primary key (ID)
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
prompt Creating table CHAIN_TOP_MENU_SETTING
prompt =====================================
prompt
create table CLM.CHAIN_TOP_MENU_SETTING
(
  id          VARCHAR2(32) not null,
  top_menu_id VARCHAR2(32),
  menu_id     VARCHAR2(32)
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
comment on table CLM.CHAIN_TOP_MENU_SETTING
  is '�����˵����ñ�';
comment on column CLM.CHAIN_TOP_MENU_SETTING.id
  is '����';
comment on column CLM.CHAIN_TOP_MENU_SETTING.top_menu_id
  is '�����˵�����';
comment on column CLM.CHAIN_TOP_MENU_SETTING.menu_id
  is '�˵�����';
alter table CLM.CHAIN_TOP_MENU_SETTING
  add primary key (ID)
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
prompt Creating table CHAIN_USER
prompt =========================
prompt
create table CLM.CHAIN_USER
(
  id          VARCHAR2(32) not null,
  tenant_id   VARCHAR2(12),
  account     VARCHAR2(45),
  password    VARCHAR2(45),
  name        VARCHAR2(50),
  real_name   VARCHAR2(30),
  avatar      VARCHAR2(500),
  email       VARCHAR2(45),
  phone       VARCHAR2(45),
  birthday    DATE,
  sex         VARCHAR2(1),
  role_id     VARCHAR2(1000),
  dept_id     VARCHAR2(1000),
  create_user VARCHAR2(32),
  create_dept VARCHAR2(32),
  create_time DATE,
  update_user VARCHAR2(32),
  update_time DATE,
  status      INTEGER,
  is_deleted  INTEGER
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
comment on table CLM.CHAIN_USER
  is '�û���';
comment on column CLM.CHAIN_USER.id
  is '����';
comment on column CLM.CHAIN_USER.tenant_id
  is '�⻧ID';
comment on column CLM.CHAIN_USER.account
  is '�˺�';
comment on column CLM.CHAIN_USER.password
  is '����';
comment on column CLM.CHAIN_USER.name
  is '�ǳ�';
comment on column CLM.CHAIN_USER.real_name
  is '����';
comment on column CLM.CHAIN_USER.avatar
  is 'ͷ��';
comment on column CLM.CHAIN_USER.email
  is '����';
comment on column CLM.CHAIN_USER.phone
  is '�ֻ�';
comment on column CLM.CHAIN_USER.birthday
  is '����';
comment on column CLM.CHAIN_USER.sex
  is '�Ա�';
comment on column CLM.CHAIN_USER.role_id
  is '��ɫid';
comment on column CLM.CHAIN_USER.dept_id
  is '����id';
comment on column CLM.CHAIN_USER.create_user
  is '������';
comment on column CLM.CHAIN_USER.create_dept
  is '��������';
comment on column CLM.CHAIN_USER.create_time
  is '����ʱ��';
comment on column CLM.CHAIN_USER.update_user
  is '�޸���';
comment on column CLM.CHAIN_USER.update_time
  is '�޸�ʱ��';
comment on column CLM.CHAIN_USER.status
  is '״̬';
comment on column CLM.CHAIN_USER.is_deleted
  is '�Ƿ���ɾ��';
alter table CLM.CHAIN_USER
  add primary key (ID)
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
prompt Creating table DB2_ERROR_INFO
prompt =============================
prompt
create table CLM.DB2_ERROR_INFO
(
  error_code  VARCHAR2(10),
  error_statu VARCHAR2(15),
  error_desc  VARCHAR2(300)
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
prompt Creating table EXPLAIN_INSTANCE
prompt ===============================
prompt
create table CLM.EXPLAIN_INSTANCE
(
  explain_requester VARCHAR2(128) not null,
  explain_time      DATE not null,
  source_name       VARCHAR2(128) not null,
  source_schema     VARCHAR2(128) not null,
  source_version    VARCHAR2(64) not null,
  explain_option    CHAR(1) not null,
  snapshot_taken    CHAR(1) not null,
  db2_version       CHAR(7) not null,
  sql_type          CHAR(1) not null,
  queryopt          INTEGER not null,
  block             CHAR(1) not null,
  isolation         CHAR(2) not null,
  buffpage          INTEGER not null,
  avg_appls         INTEGER not null,
  sortheap          INTEGER not null,
  locklist          INTEGER not null,
  maxlocks          INTEGER not null,
  locks_avail       INTEGER not null,
  cpu_speed         NUMBER not null,
  remarks           VARCHAR2(254),
  dbheap            INTEGER not null,
  comm_speed        NUMBER not null,
  parallelism       CHAR(2) not null,
  datajoiner        CHAR(1) not null,
  executable_id     VARCHAR2(32),
  execution_time    DATE
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
alter table CLM.EXPLAIN_INSTANCE
  add primary key (EXPLAIN_REQUESTER, EXPLAIN_TIME, SOURCE_NAME, SOURCE_SCHEMA, SOURCE_VERSION)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table EXPLAIN_STATEMENT
prompt ================================
prompt
create table CLM.EXPLAIN_STATEMENT
(
  explain_requester VARCHAR2(128) not null,
  explain_time      DATE not null,
  source_name       VARCHAR2(128) not null,
  source_schema     VARCHAR2(128) not null,
  source_version    VARCHAR2(64) not null,
  explain_level     CHAR(1) not null,
  stmtno            INTEGER not null,
  sectno            INTEGER not null,
  queryno           INTEGER not null,
  querytag          CHAR(20) not null,
  statement_type    CHAR(2) not null,
  updatable         CHAR(1) not null,
  deletable         CHAR(1) not null,
  total_cost        NUMBER not null,
  statement_text    CLOB not null,
  snapshot          BLOB,
  query_degree      INTEGER not null
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
alter table CLM.EXPLAIN_STATEMENT
  add primary key (EXPLAIN_REQUESTER, EXPLAIN_TIME, SOURCE_NAME, SOURCE_SCHEMA, SOURCE_VERSION, EXPLAIN_LEVEL, STMTNO, SECTNO)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
alter table CLM.EXPLAIN_STATEMENT
  add foreign key (EXPLAIN_REQUESTER, EXPLAIN_TIME, SOURCE_NAME, SOURCE_SCHEMA, SOURCE_VERSION)
  references CLM.EXPLAIN_INSTANCE (EXPLAIN_REQUESTER, EXPLAIN_TIME, SOURCE_NAME, SOURCE_SCHEMA, SOURCE_VERSION);

prompt
prompt Creating table EXPLAIN_ARGUMENT
prompt ===============================
prompt
create table CLM.EXPLAIN_ARGUMENT
(
  explain_requester   VARCHAR2(128) not null,
  explain_time        DATE not null,
  source_name         VARCHAR2(128) not null,
  source_schema       VARCHAR2(128) not null,
  source_version      VARCHAR2(64) not null,
  explain_level       CHAR(1) not null,
  stmtno              NUMBER not null,
  sectno              NUMBER not null,
  operator_id         NUMBER not null,
  argument_type       CHAR(8) not null,
  argument_value      VARCHAR2(1024),
  long_argument_value CLOB
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
alter table CLM.EXPLAIN_ARGUMENT
  add foreign key (EXPLAIN_REQUESTER, EXPLAIN_TIME, SOURCE_NAME, SOURCE_SCHEMA, SOURCE_VERSION, EXPLAIN_LEVEL, STMTNO, SECTNO)
  references CLM.EXPLAIN_STATEMENT (EXPLAIN_REQUESTER, EXPLAIN_TIME, SOURCE_NAME, SOURCE_SCHEMA, SOURCE_VERSION, EXPLAIN_LEVEL, STMTNO, SECTNO);

prompt
prompt Creating table EXPLAIN_OBJECT
prompt =============================
prompt
create table CLM.EXPLAIN_OBJECT
(
  explain_requester            VARCHAR2(128) not null,
  explain_time                 DATE not null,
  source_name                  VARCHAR2(128) not null,
  source_schema                VARCHAR2(128) not null,
  source_version               VARCHAR2(64) not null,
  explain_level                CHAR(1) not null,
  stmtno                       NUMBER not null,
  sectno                       NUMBER not null,
  object_schema                VARCHAR2(128) not null,
  object_name                  VARCHAR2(128) not null,
  object_type                  CHAR(2) not null,
  create_time                  DATE,
  statistics_time              DATE,
  column_count                 NUMBER not null,
  row_count                    NUMBER not null,
  width                        NUMBER not null,
  pages                        NUMBER not null,
  distinct                     CHAR(1) not null,
  tablespace_name              VARCHAR2(128),
  overhead                     NUMBER not null,
  transfer_rate                NUMBER not null,
  prefetchsize                 NUMBER not null,
  extentsize                   NUMBER not null,
  cluster                      NUMBER not null,
  nleaf                        NUMBER not null,
  nlevels                      NUMBER not null,
  fullkeycard                  NUMBER not null,
  overflow                     NUMBER not null,
  firstkeycard                 NUMBER not null,
  first2keycard                NUMBER not null,
  first3keycard                NUMBER not null,
  first4keycard                NUMBER not null,
  sequential_pages             NUMBER not null,
  density                      NUMBER not null,
  stats_src                    CHAR(1) not null,
  average_sequence_gap         NUMBER not null,
  average_sequence_fetch_gap   NUMBER not null,
  average_sequence_pages       NUMBER not null,
  average_sequence_fetch_pages NUMBER not null,
  average_random_pages         NUMBER not null,
  average_random_fetch_pages   NUMBER not null,
  numrids                      NUMBER not null,
  numrids_deleted              NUMBER not null,
  num_empty_leafs              NUMBER not null,
  active_blocks                NUMBER not null,
  num_data_parts               NUMBER not null,
  nullkeys                     CHAR(1)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
alter table CLM.EXPLAIN_OBJECT
  add foreign key (EXPLAIN_REQUESTER, EXPLAIN_TIME, SOURCE_NAME, SOURCE_SCHEMA, SOURCE_VERSION, EXPLAIN_LEVEL, STMTNO, SECTNO)
  references CLM.EXPLAIN_STATEMENT (EXPLAIN_REQUESTER, EXPLAIN_TIME, SOURCE_NAME, SOURCE_SCHEMA, SOURCE_VERSION, EXPLAIN_LEVEL, STMTNO, SECTNO);

prompt
prompt Creating table EXPLAIN_OPERATOR
prompt ===============================
prompt
create table CLM.EXPLAIN_OPERATOR
(
  explain_requester VARCHAR2(128) not null,
  explain_time      DATE not null,
  source_name       VARCHAR2(128) not null,
  source_schema     VARCHAR2(128) not null,
  source_version    VARCHAR2(64) not null,
  explain_level     CHAR(1) not null,
  stmtno            INTEGER not null,
  sectno            INTEGER not null,
  operator_id       INTEGER not null,
  operator_type     CHAR(6) not null,
  total_cost        NUMBER not null,
  io_cost           NUMBER not null,
  cpu_cost          NUMBER not null,
  first_row_cost    NUMBER not null,
  re_total_cost     NUMBER not null,
  re_io_cost        NUMBER not null,
  re_cpu_cost       NUMBER not null,
  comm_cost         NUMBER not null,
  first_comm_cost   NUMBER not null,
  buffers           NUMBER not null,
  remote_total_cost NUMBER not null,
  remote_comm_cost  NUMBER not null
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
alter table CLM.EXPLAIN_OPERATOR
  add primary key (EXPLAIN_REQUESTER, EXPLAIN_TIME, SOURCE_NAME, SOURCE_SCHEMA, SOURCE_VERSION, EXPLAIN_LEVEL, STMTNO, SECTNO, OPERATOR_ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
alter table CLM.EXPLAIN_OPERATOR
  add foreign key (EXPLAIN_REQUESTER, EXPLAIN_TIME, SOURCE_NAME, SOURCE_SCHEMA, SOURCE_VERSION, EXPLAIN_LEVEL, STMTNO, SECTNO)
  references CLM.EXPLAIN_STATEMENT (EXPLAIN_REQUESTER, EXPLAIN_TIME, SOURCE_NAME, SOURCE_SCHEMA, SOURCE_VERSION, EXPLAIN_LEVEL, STMTNO, SECTNO);

prompt
prompt Creating table EXPLAIN_PREDICATE
prompt ================================
prompt
create table CLM.EXPLAIN_PREDICATE
(
  explain_requester VARCHAR2(128) not null,
  explain_time      DATE not null,
  source_name       VARCHAR2(128) not null,
  source_schema     VARCHAR2(128) not null,
  source_version    VARCHAR2(64) not null,
  explain_level     CHAR(1) not null,
  stmtno            INTEGER not null,
  sectno            INTEGER not null,
  operator_id       INTEGER not null,
  predicate_id      INTEGER not null,
  how_applied       CHAR(10) not null,
  when_evaluated    CHAR(3) not null,
  relop_type        CHAR(2) not null,
  subquery          CHAR(1) not null,
  filter_factor     NUMBER not null,
  predicate_text    CLOB,
  range_num         INTEGER,
  index_colseq      INTEGER not null
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
alter table CLM.EXPLAIN_PREDICATE
  add foreign key (EXPLAIN_REQUESTER, EXPLAIN_TIME, SOURCE_NAME, SOURCE_SCHEMA, SOURCE_VERSION, EXPLAIN_LEVEL, STMTNO, SECTNO)
  references CLM.EXPLAIN_STATEMENT (EXPLAIN_REQUESTER, EXPLAIN_TIME, SOURCE_NAME, SOURCE_SCHEMA, SOURCE_VERSION, EXPLAIN_LEVEL, STMTNO, SECTNO);

prompt
prompt Creating table EXPLAIN_STREAM
prompt =============================
prompt
create table CLM.EXPLAIN_STREAM
(
  explain_requester VARCHAR2(128) not null,
  explain_time      DATE not null,
  source_name       VARCHAR2(128) not null,
  source_schema     VARCHAR2(128) not null,
  source_version    VARCHAR2(64) not null,
  explain_level     CHAR(1) not null,
  stmtno            INTEGER not null,
  sectno            INTEGER not null,
  stream_id         INTEGER not null,
  source_type       CHAR(1) not null,
  source_id         INTEGER not null,
  target_type       CHAR(1) not null,
  target_id         INTEGER not null,
  object_schema     VARCHAR2(128),
  object_name       VARCHAR2(128),
  stream_count      NUMBER not null,
  column_count      INTEGER not null,
  predicate_id      INTEGER not null,
  column_names      CLOB,
  pmid              INTEGER not null,
  single_node       CHAR(5),
  partition_columns CLOB,
  sequence_sizes    CLOB
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
alter table CLM.EXPLAIN_STREAM
  add foreign key (EXPLAIN_REQUESTER, EXPLAIN_TIME, SOURCE_NAME, SOURCE_SCHEMA, SOURCE_VERSION, EXPLAIN_LEVEL, STMTNO, SECTNO)
  references CLM.EXPLAIN_STATEMENT (EXPLAIN_REQUESTER, EXPLAIN_TIME, SOURCE_NAME, SOURCE_SCHEMA, SOURCE_VERSION, EXPLAIN_LEVEL, STMTNO, SECTNO);

prompt
prompt Creating table E_AREA_INFO
prompt ==========================
prompt
create table CLM.E_AREA_INFO
(
  data_date         VARCHAR2(40),
  area_inf_id       VARCHAR2(40) not null,
  district_num      VARCHAR2(40),
  district_name     VARCHAR2(40),
  district_org      VARCHAR2(40),
  village_num       VARCHAR2(40),
  village_name      VARCHAR2(40),
  is_credit_village VARCHAR2(40),
  village_org       VARCHAR2(40),
  rural_num         VARCHAR2(40),
  rural_name        VARCHAR2(40),
  is_credit_rural   VARCHAR2(40),
  farmer_numbser    NUMBER(20,2),
  rural_org         VARCHAR2(40)
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
prompt Creating table E_BUSINESS_INF
prompt =============================
prompt
create table CLM.E_BUSINESS_INF
(
  info_id           VARCHAR2(40) not null,
  datadate          VARCHAR2(20),
  biz_num           VARCHAR2(40),
  customer_num      VARCHAR2(40),
  customer_name     VARCHAR2(100),
  biz_apply_date    VARCHAR2(20),
  biz_status_cd     VARCHAR2(20),
  handing_org       VARCHAR2(40),
  handing_person    VARCHAR2(40),
  total_amt_apply   NUMBER(20,2),
  credit_product_cd VARCHAR2(20),
  contract_num      VARCHAR2(40)
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
prompt Creating table E_CREDIT_INF
prompt ===========================
prompt
create table CLM.E_CREDIT_INF
(
  credit_inf_id          VARCHAR2(40) not null,
  contract_num           VARCHAR2(40),
  data_date              VARCHAR2(20),
  customer_num           VARCHAR2(40),
  customer_name          VARCHAR2(100),
  credit_product_cd      VARCHAR2(20),
  contract_cycle_ind     CHAR(1),
  currenty_cd            VARCHAR2(20),
  contract_total_amt     NUMBER(20,2),
  available_amt          NUMBER(20,2),
  cumulative_payout_amt  NUMBER(20,2),
  start_date             DATE,
  expiration_date        DATE,
  original_amt           NUMBER(20,2),
  contract_status_cd     VARCHAR2(20),
  handling_org_cd        VARCHAR2(20),
  surety_amt             NUMBER(20,2),
  contract_nature_cd     VARCHAR2(20),
  project_capital_amount NUMBER(20,2),
  project_total_amt      NUMBER(20,2),
  house_case_cd          VARCHAR2(20),
  house_area             NUMBER(20,2),
  year_income_amount     NUMBER(20,2),
  year_margin            NUMBER(20,2),
  per_capita_margin      NUMBER(20,2)
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
prompt Creating table E_CUSTOM_INF
prompt ===========================
prompt
create table CLM.E_CUSTOM_INF
(
  custom_inf_id         VARCHAR2(40) not null,
  customer_num          VARCHAR2(40),
  party_name            VARCHAR2(100),
  short_name            VARCHAR2(40),
  english_name          VARCHAR2(100),
  party_type_cd         VARCHAR2(20),
  customer_type         VARCHAR2(20),
  certificate_type      VARCHAR2(20),
  certificate_code      VARCHAR2(40),
  education_level       VARCHAR2(20),
  marital_status        VARCHAR2(20),
  occupation            VARCHAR2(20),
  work_unit             VARCHAR2(100),
  is_in_system          CHAR(1),
  custom_sign           VARCHAR2(20),
  stockholder_ind       CHAR(1),
  stock_rate            NUMBER(16,8),
  orgn_num              VARCHAR2(30),
  lawyer_name           VARCHAR2(40),
  lawyer_cd             VARCHAR2(20),
  lawyer_num            VARCHAR2(40),
  eval_result           VARCHAR2(20),
  user_num              VARCHAR2(20),
  org_cd                VARCHAR2(20),
  build_date            DATE,
  asset_total_amt       NUMBER(20,2),
  asset_only_amt        NUMBER(20,2),
  bus_check_year        VARCHAR2(20),
  listed_company_ind    CHAR(1),
  listed_area           VARCHAR2(20),
  listed_cd             VARCHAR2(20),
  industry_cd           VARCHAR2(20),
  custom_area           VARCHAR2(20),
  customer_size_cd      VARCHAR2(20),
  currency_cd           VARCHAR2(20),
  regist_capital        NUMBER(20,2),
  founded_date          DATE,
  group_num             VARCHAR2(20),
  farming_industry_sign VARCHAR2(20),
  data_date             VARCHAR2(20),
  credit_finance_type   VARCHAR2(20),
  gover_finance_type    VARCHAR2(20),
  control_stock_type    VARCHAR2(20),
  farm_cooperation_type VARCHAR2(20),
  is_agriculture        VARCHAR2(20),
  is_town               VARCHAR2(20),
  is_cooperative_mem    VARCHAR2(20),
  funds_demand          NUMBER(20,2),
  credit_card_num       VARCHAR2(40),
  approve_credit_limit  NUMBER(20,2),
  approved_used_limit   NUMBER(20,2),
  approved_free_limit   NUMBER(20,2),
  credit_grade          VARCHAR2(20),
  certification_date    DATE,
  card_state            VARCHAR2(20),
  village_num           VARCHAR2(20),
  gover_manage_type     VARCHAR2(20)
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
prompt Creating table E_GUARANTEE_INF
prompt ==============================
prompt
create table CLM.E_GUARANTEE_INF
(
  guarantee_inf_id      VARCHAR2(40) not null,
  collateral_num        VARCHAR2(40),
  data_date             VARCHAR2(20),
  collateral_catalog_cd VARCHAR2(20),
  collateral_name       VARCHAR2(100),
  inter_date            DATE,
  expire_date           DATE,
  currency_cd           VARCHAR2(20),
  ccb_assessed_value    NUMBER(20,8),
  guaranty_rate         NUMBER(20,8),
  subcontract_num       VARCHAR2(40),
  contract_num          VARCHAR2(40),
  contract_num_x        VARCHAR2(40),
  res_type              VARCHAR2(20),
  data_creator_org_cd   VARCHAR2(20),
  collateral_status_cd  VARCHAR2(20)
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
prompt Creating table E_LOAN_INFO
prompt ==========================
prompt
create table CLM.E_LOAN_INFO
(
  loan_info_id          VARCHAR2(40) not null,
  borrow_num            VARCHAR2(40),
  data_date             VARCHAR2(20),
  contract_num          VARCHAR2(40),
  customer_num          VARCHAR2(40),
  borrow_accounts       VARCHAR2(40),
  party_name            VARCHAR2(100),
  card_num              VARCHAR2(40),
  account_subject       VARCHAR2(20),
  party_type_cd         VARCHAR2(20),
  customer_type         VARCHAR2(20),
  is_group_bank         VARCHAR2(20),
  loan_natrue           VARCHAR2(20),
  product_type_cd       VARCHAR2(20),
  credit_product_cd     VARCHAR2(20),
  term_unit_cd          VARCHAR2(20),
  currency_cd           VARCHAR2(20),
  amt                   NUMBER(20,2),
  extend_date           DATE,
  expiration_date       DATE,
  term                  NUMBER(8),
  ir_type_cd            VARCHAR2(20),
  benchmark_ir_rate     NUMBER(10,8),
  ir_rate_year          NUMBER(10,8),
  ir_nego_rate          NUMBER(10,8),
  ir_adjust_cyc         VARCHAR2(20),
  loan_use_sub_cd       VARCHAR2(20),
  revert_cd             VARCHAR2(20),
  biz_status            VARCHAR2(20),
  write_off_date        DATE,
  subcontract_num       VARCHAR2(40),
  main_surety_mode      VARCHAR2(20),
  collateral_type       VARCHAR2(20),
  guaranty_amt          NUMBER(20,2),
  credit_balance        NUMBER(20,2),
  in_gear_balance       NUMBER(20,2),
  overdue_balance       NUMBER(20,2),
  primness_balance      NUMBER(20,2),
  reduce_ready          NUMBER(20,2),
  expiration_balance    NUMBER(20,2),
  overdue_interest      NUMBER(20,2),
  overdue_term          NUMBER(8),
  surety_amt            NUMBER(20,2),
  classify_result       VARCHAR2(20),
  classify_reason       VARCHAR2(20),
  exceeding_ind         VARCHAR2(20),
  exceeding_start       DATE,
  exceeding_expir       DATE,
  micro_interest_cd     VARCHAR2(20),
  handling_org_cd       VARCHAR2(20),
  area_cd               VARCHAR2(20),
  group_num             VARCHAR2(40),
  group_name            VARCHAR2(100),
  out_table_ind         VARCHAR2(20),
  pay_type_cd           VARCHAR2(20),
  village_mode_cd       VARCHAR2(20),
  gover_finance_inpitch VARCHAR2(20),
  gover_finance_repay   VARCHAR2(20),
  funds_toward          VARCHAR2(20),
  disinterest_type      VARCHAR2(20),
  is_house_loan         VARCHAR2(20),
  house_loan_type       VARCHAR2(20),
  is_combination        VARCHAR2(20),
  guaranty_num          VARCHAR2(500),
  amt_proxy_pay         NUMBER(20,2),
  amt_self_pay          NUMBER(20,2)
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
prompt Creating table E_OFFASSET_INF
prompt =============================
prompt
create table CLM.E_OFFASSET_INF
(
  offasset_inf_id  VARCHAR2(40) not null,
  debt_asset_no    VARCHAR2(50),
  debt_asset_name  VARCHAR2(100),
  debt_asset_type  VARCHAR2(20),
  in_account_date  DATE,
  currency_cd      VARCHAR2(20),
  account_value    NUMBER(20,2),
  market_value     NUMBER(20,2),
  handle_stutation VARCHAR2(100),
  devalue_amt      NUMBER(20,2),
  contract_num     VARCHAR2(50),
  data_date        VARCHAR2(20)
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
prompt Creating table FLW_CHANNEL_DEFINITION
prompt =====================================
prompt
create table CLM.FLW_CHANNEL_DEFINITION
(
  id_            VARCHAR2(255) not null,
  name_          VARCHAR2(255),
  version_       INTEGER,
  key_           VARCHAR2(255),
  category_      VARCHAR2(255),
  deployment_id_ VARCHAR2(255),
  create_time_   TIMESTAMP(3),
  tenant_id_     VARCHAR2(255),
  resource_name_ VARCHAR2(255),
  description_   VARCHAR2(255)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
create unique index CLM.ACT_IDX_CHANNEL_DEF_UNIQ on CLM.FLW_CHANNEL_DEFINITION (KEY_, VERSION_, TENANT_ID_)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
alter table CLM.FLW_CHANNEL_DEFINITION
  add constraint PK_FLW_CHANNEL_DEFINITION primary key (ID_)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table FLW_EVENT_DEFINITION
prompt ===================================
prompt
create table CLM.FLW_EVENT_DEFINITION
(
  id_            VARCHAR2(255) not null,
  name_          VARCHAR2(255),
  version_       INTEGER,
  key_           VARCHAR2(255),
  category_      VARCHAR2(255),
  deployment_id_ VARCHAR2(255),
  tenant_id_     VARCHAR2(255),
  resource_name_ VARCHAR2(255),
  description_   VARCHAR2(255)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
create unique index CLM.ACT_IDX_EVENT_DEF_UNIQ on CLM.FLW_EVENT_DEFINITION (KEY_, VERSION_, TENANT_ID_)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
alter table CLM.FLW_EVENT_DEFINITION
  add constraint PK_FLW_EVENT_DEFINITION primary key (ID_)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table FLW_EVENT_DEPLOYMENT
prompt ===================================
prompt
create table CLM.FLW_EVENT_DEPLOYMENT
(
  id_                   VARCHAR2(255) not null,
  name_                 VARCHAR2(255),
  category_             VARCHAR2(255),
  deploy_time_          TIMESTAMP(3),
  tenant_id_            VARCHAR2(255),
  parent_deployment_id_ VARCHAR2(255)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
alter table CLM.FLW_EVENT_DEPLOYMENT
  add constraint PK_FLW_EVENT_DEPLOYMENT primary key (ID_)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table FLW_EVENT_RESOURCE
prompt =================================
prompt
create table CLM.FLW_EVENT_RESOURCE
(
  id_             VARCHAR2(255) not null,
  name_           VARCHAR2(255),
  deployment_id_  VARCHAR2(255),
  resource_bytes_ BLOB
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
alter table CLM.FLW_EVENT_RESOURCE
  add constraint PK_FLW_EVENT_RESOURCE primary key (ID_)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table FLW_EV_DATABASECHANGELOG
prompt =======================================
prompt
create table CLM.FLW_EV_DATABASECHANGELOG
(
  id            VARCHAR2(255) not null,
  author        VARCHAR2(255) not null,
  filename      VARCHAR2(255) not null,
  dateexecuted  TIMESTAMP(6) not null,
  orderexecuted INTEGER not null,
  exectype      VARCHAR2(10) not null,
  md5sum        VARCHAR2(35),
  description   VARCHAR2(255),
  comments      VARCHAR2(255),
  tag           VARCHAR2(255),
  liquibase     VARCHAR2(20),
  contexts      VARCHAR2(255),
  labels        VARCHAR2(255),
  deployment_id VARCHAR2(10)
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
prompt Creating table FLW_EV_DATABASECHANGELOGLOCK
prompt ===========================================
prompt
create table CLM.FLW_EV_DATABASECHANGELOGLOCK
(
  id          INTEGER not null,
  locked      NUMBER(1) not null,
  lockgranted TIMESTAMP(6),
  lockedby    VARCHAR2(255)
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
alter table CLM.FLW_EV_DATABASECHANGELOGLOCK
  add constraint PK_FLW_EV_DATABASECHANGELOGLOC primary key (ID)
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
prompt Creating table FLW_RU_BATCH
prompt ===========================
prompt
create table CLM.FLW_RU_BATCH
(
  id_            NVARCHAR2(64) not null,
  rev_           INTEGER,
  type_          NVARCHAR2(64) not null,
  search_key_    NVARCHAR2(255),
  search_key2_   NVARCHAR2(255),
  create_time_   TIMESTAMP(6) not null,
  complete_time_ TIMESTAMP(6),
  status_        NVARCHAR2(255),
  batch_doc_id_  NVARCHAR2(64),
  tenant_id_     NVARCHAR2(255) default ''
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
alter table CLM.FLW_RU_BATCH
  add primary key (ID_)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table FLW_RU_BATCH_PART
prompt ================================
prompt
create table CLM.FLW_RU_BATCH_PART
(
  id_            NVARCHAR2(64) not null,
  rev_           INTEGER,
  batch_id_      NVARCHAR2(64),
  type_          NVARCHAR2(64) not null,
  scope_id_      NVARCHAR2(64),
  sub_scope_id_  NVARCHAR2(64),
  scope_type_    NVARCHAR2(64),
  search_key_    NVARCHAR2(255),
  search_key2_   NVARCHAR2(255),
  create_time_   TIMESTAMP(6) not null,
  complete_time_ TIMESTAMP(6),
  status_        NVARCHAR2(255),
  result_doc_id_ NVARCHAR2(64),
  tenant_id_     NVARCHAR2(255) default ''
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
create index CLM.FLW_IDX_BATCH_PART on CLM.FLW_RU_BATCH_PART (BATCH_ID_)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
alter table CLM.FLW_RU_BATCH_PART
  add primary key (ID_)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
alter table CLM.FLW_RU_BATCH_PART
  add constraint FLW_FK_BATCH_PART_PARENT foreign key (BATCH_ID_)
  references CLM.FLW_RU_BATCH (ID_);

prompt
prompt Creating table TB_BATCH_SCHEDULE_LOG
prompt ====================================
prompt
create table CLM.TB_BATCH_SCHEDULE_LOG
(
  schedule_log_id   VARCHAR2(50) not null,
  batch_file        VARCHAR2(100) not null,
  data_sum          INTEGER,
  task_status       VARCHAR2(10),
  file_check_status VARCHAR2(1),
  exec_time         DATE,
  exec_end_time     DATE,
  batch_date        DATE
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on table CLM.TB_BATCH_SCHEDULE_LOG
  is '����������־';
comment on column CLM.TB_BATCH_SCHEDULE_LOG.schedule_log_id
  is '������־ID';
comment on column CLM.TB_BATCH_SCHEDULE_LOG.batch_file
  is '�����ļ���';
comment on column CLM.TB_BATCH_SCHEDULE_LOG.data_sum
  is '�����ļ�ֵ';
comment on column CLM.TB_BATCH_SCHEDULE_LOG.task_status
  is '����״̬';
comment on column CLM.TB_BATCH_SCHEDULE_LOG.file_check_status
  is '��Դ�ļ����״��';
comment on column CLM.TB_BATCH_SCHEDULE_LOG.exec_time
  is 'ִ��ʱ��';
comment on column CLM.TB_BATCH_SCHEDULE_LOG.exec_end_time
  is 'ִ�н���ʱ��';
comment on column CLM.TB_BATCH_SCHEDULE_LOG.batch_date
  is '��������';

prompt
prompt Creating table TB_BAT_BATCH_BRANCH_DATE_ACT
prompt ===========================================
prompt
create table CLM.TB_BAT_BATCH_BRANCH_DATE_ACT
(
  prov_code  VARCHAR2(11),
  batch_date CHAR(8)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;

prompt
prompt Creating table TB_BAT_BATCH_DEPEND_ON
prompt =====================================
prompt
create table CLM.TB_BAT_BATCH_DEPEND_ON
(
  id          VARCHAR2(32) not null,
  job_cd      VARCHAR2(32),
  depend      VARCHAR2(32),
  instance_id VARCHAR2(32) not null
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;

prompt
prompt Creating table TB_BAT_BATCH_JOB
prompt ===============================
prompt
create table CLM.TB_BAT_BATCH_JOB
(
  other_name   VARCHAR2(100),
  job_id       VARCHAR2(32) not null,
  job_name     VARCHAR2(100),
  branch_no    VARCHAR2(20),
  father_id    VARCHAR2(32),
  depends      VARCHAR2(3000),
  seduler_date VARCHAR2(20),
  valid_date   DATE,
  expire_date  DATE,
  is_valid     VARCHAR2(2),
  java_class   VARCHAR2(100),
  job_path     VARCHAR2(200),
  job_group    VARCHAR2(100),
  remarks      VARCHAR2(100),
  job_type     VARCHAR2(2)
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
prompt Creating table TB_BAT_DATA_RECORD
prompt =================================
prompt
create table CLM.TB_BAT_DATA_RECORD
(
  record_id   VARCHAR2(32) not null,
  biz_num     VARCHAR2(50),
  biz_type    VARCHAR2(10),
  op_type     VARCHAR2(2),
  status      VARCHAR2(10),
  code        VARCHAR2(10),
  msg         VARCHAR2(100),
  tran_date   VARCHAR2(20),
  create_time DATE,
  update_time DATE
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
comment on table CLM.TB_BAT_DATA_RECORD
  is '�������ݴ����¼';
comment on column CLM.TB_BAT_DATA_RECORD.record_id
  is '��¼ID��������';
comment on column CLM.TB_BAT_DATA_RECORD.biz_num
  is 'ҵ����';
comment on column CLM.TB_BAT_DATA_RECORD.biz_type
  is 'ҵ������';
comment on column CLM.TB_BAT_DATA_RECORD.op_type
  is '��������';
comment on column CLM.TB_BAT_DATA_RECORD.status
  is '����״̬';
comment on column CLM.TB_BAT_DATA_RECORD.code
  is '����״̬��';
comment on column CLM.TB_BAT_DATA_RECORD.msg
  is '״̬����';
comment on column CLM.TB_BAT_DATA_RECORD.tran_date
  is '��������';
comment on column CLM.TB_BAT_DATA_RECORD.create_time
  is '����ʱ��';
comment on column CLM.TB_BAT_DATA_RECORD.update_time
  is '����ʱ��';
alter table CLM.TB_BAT_DATA_RECORD
  add constraint PK_TB_BAT_DATA_RECORD primary key (RECORD_ID)
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
prompt Creating table TB_BAT_JOB_INSTANCE
prompt ==================================
prompt
create table CLM.TB_BAT_JOB_INSTANCE
(
  name           VARCHAR2(100),
  batch_seq_no   INTEGER,
  alias_name     VARCHAR2(100),
  job_group      VARCHAR2(4),
  type           VARCHAR2(2),
  start_time     DATE,
  end_time       DATE,
  status         VARCHAR2(2),
  progress       VARCHAR2(20),
  is_sub_job     VARCHAR2(2),
  parent_job_id  VARCHAR2(32),
  branch_no      VARCHAR2(20),
  data_file_type VARCHAR2(2),
  param          VARCHAR2(100),
  comments       VARCHAR2(3000),
  total_progress VARCHAR2(20),
  memo           VARCHAR2(1000),
  instance_id    VARCHAR2(32) not null,
  job_id         VARCHAR2(32),
  batch_no       VARCHAR2(10)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;

prompt
prompt Creating table TB_BAT_JOB_LOG
prompt =============================
prompt
create table CLM.TB_BAT_JOB_LOG
(
  task_instance_id VARCHAR2(32),
  log_content      VARCHAR2(3000),
  remarks          VARCHAR2(200),
  instance_id      VARCHAR2(32) not null,
  sys_create_time  DATE,
  exception_msg    VARCHAR2(1000),
  exception        VARCHAR2(1000)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;

prompt
prompt Creating table TB_BAT_JOB_PARAM
prompt ===============================
prompt
create table CLM.TB_BAT_JOB_PARAM
(
  param_key   VARCHAR2(40),
  param_value VARCHAR2(40),
  param_type  VARCHAR2(2),
  memo        VARCHAR2(40),
  job_cd      VARCHAR2(32),
  par_id      VARCHAR2(32) not null
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;

prompt
prompt Creating table TB_BAT_PBC_LOAN_TOTAL
prompt ====================================
prompt
create table CLM.TB_BAT_PBC_LOAN_TOTAL
(
  op_date               VARCHAR2(20) not null,
  org_cd                CHAR(30),
  customer_type         VARCHAR2(20),
  certificate_code      VARCHAR2(80),
  industry_level_one_cd VARCHAR2(30),
  unit_address          VARCHAR2(30),
  control_stock_type    VARCHAR2(30),
  customer_size_cd      VARCHAR2(30),
  credit_product_cd     VARCHAR2(30),
  industry_pitch_cd     VARCHAR2(30),
  extend_date           VARCHAR2(20),
  expiration_date       VARCHAR2(20),
  write_off_date        VARCHAR2(20),
  currency_cd           VARCHAR2(80),
  amt                   NUMBER(20,2),
  ir_nego_rate          VARCHAR2(30),
  interest_rate         NUMBER(20,6),
  main_surety_mode      VARCHAR2(30),
  loan_type             VARCHAR2(30),
  loan_sign             VARCHAR2(30),
  brrow_num             VARCHAR2(40) not null,
  add_period_end_date   VARCHAR2(20),
  loan_balance          NUMBER(20,2),
  class_level           VARCHAR2(30),
  report_sign           VARCHAR2(2) not null
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
prompt Creating table TB_BAT_PRC_TEMP_LOG
prompt ==================================
prompt
create table CLM.TB_BAT_PRC_TEMP_LOG
(
  prc_name  VARCHAR2(30),
  val_name  VARCHAR2(30),
  val_value VARCHAR2(100)
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
prompt Creating table TB_BILL_EVENT_DETAIL
prompt ===================================
prompt
create table CLM.TB_BILL_EVENT_DETAIL
(
  event_detailed_id       VARCHAR2(32) not null,
  event_main_id           VARCHAR2(32) not null,
  tran_seq_sn             VARCHAR2(40) not null,
  tran_date               VARCHAR2(20) not null,
  busi_deal_num           VARCHAR2(40) not null,
  busi_prd_num            VARCHAR2(10),
  busi_deal_desc          VARCHAR2(50),
  busi_deal_org_num       VARCHAR2(40),
  busi_deal_org_name      VARCHAR2(100),
  busi_oppt_org_num       VARCHAR2(40),
  busi_oppt_org_name      VARCHAR2(100),
  busi_sum_amt            NUMBER(18,2),
  busi_cert_cnt           NUMBER(24),
  cert_num                VARCHAR2(40),
  cert_type_cd            VARCHAR2(40),
  cert_ppt_cd             VARCHAR2(40),
  cert_interest_period    VARCHAR2(40),
  cert_interest_rate      NUMBER(10,6),
  cert_currency_cd        VARCHAR2(10),
  cert_seq_amt            NUMBER(18,2),
  cert_apply_amt          NUMBER(18,2),
  cert_apply_balance      NUMBER(18,2),
  cert_status             VARCHAR2(10),
  cert_begin_date         VARCHAR2(20),
  cert_end_date           VARCHAR2(20),
  cert_finish_date        VARCHAR2(20),
  cert_drawer_cust_num    VARCHAR2(50),
  cert_drawer_name        VARCHAR2(200),
  cert_drawer_bank_num    VARCHAR2(50),
  cert_drawer_bank_name   VARCHAR2(200),
  cert_drawer_bank_legal  VARCHAR2(40),
  cert_guaranty_type      VARCHAR2(40),
  cert_guaranty_person    VARCHAR2(40),
  cert_busi_remark        VARCHAR2(1000),
  cert_interest_peri_type VARCHAR2(10),
  cert_interest_rate_type VARCHAR2(10),
  cert_is_my_bank         VARCHAR2(1)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on table CLM.TB_BILL_EVENT_DETAIL
  is 'Ʊ�������¼���ϸ��';
comment on column CLM.TB_BILL_EVENT_DETAIL.event_detailed_id
  is '�¼���ϸid';
comment on column CLM.TB_BILL_EVENT_DETAIL.tran_seq_sn
  is '������ˮ��';
comment on column CLM.TB_BILL_EVENT_DETAIL.tran_date
  is '��������';
comment on column CLM.TB_BILL_EVENT_DETAIL.busi_deal_num
  is 'ҵ��������';
comment on column CLM.TB_BILL_EVENT_DETAIL.busi_prd_num
  is 'ҵ���Ʒ���';
comment on column CLM.TB_BILL_EVENT_DETAIL.busi_deal_desc
  is 'ҵ��������';
comment on column CLM.TB_BILL_EVENT_DETAIL.busi_deal_org_num
  is '��������';
comment on column CLM.TB_BILL_EVENT_DETAIL.busi_deal_org_name
  is '������������';
comment on column CLM.TB_BILL_EVENT_DETAIL.busi_oppt_org_num
  is '���ֻ���';
comment on column CLM.TB_BILL_EVENT_DETAIL.busi_oppt_org_name
  is '���ֻ�������';
comment on column CLM.TB_BILL_EVENT_DETAIL.busi_sum_amt
  is '�����ܽ��';
comment on column CLM.TB_BILL_EVENT_DETAIL.busi_cert_cnt
  is 'ƾ֤����';
comment on column CLM.TB_BILL_EVENT_DETAIL.cert_num
  is 'ƾ֤���';
comment on column CLM.TB_BILL_EVENT_DETAIL.cert_type_cd
  is 'ƾ֤Ʒ��';
comment on column CLM.TB_BILL_EVENT_DETAIL.cert_ppt_cd
  is 'ƾ֤����';
comment on column CLM.TB_BILL_EVENT_DETAIL.cert_interest_period
  is 'ƾ֤��Ϣ����';
comment on column CLM.TB_BILL_EVENT_DETAIL.cert_interest_rate
  is '������/����';
comment on column CLM.TB_BILL_EVENT_DETAIL.cert_currency_cd
  is '����';
comment on column CLM.TB_BILL_EVENT_DETAIL.cert_seq_amt
  is 'ƾ֤ԭʼ���';
comment on column CLM.TB_BILL_EVENT_DETAIL.cert_apply_amt
  is 'ƾ֤���Ž��';
comment on column CLM.TB_BILL_EVENT_DETAIL.cert_apply_balance
  is 'ƾ֤�������';
comment on column CLM.TB_BILL_EVENT_DETAIL.cert_status
  is 'ƾ֤״̬';
comment on column CLM.TB_BILL_EVENT_DETAIL.cert_begin_date
  is 'ƾ֤����';
comment on column CLM.TB_BILL_EVENT_DETAIL.cert_end_date
  is 'ƾֹ֤��';
comment on column CLM.TB_BILL_EVENT_DETAIL.cert_finish_date
  is 'ƾ֤��������';
comment on column CLM.TB_BILL_EVENT_DETAIL.cert_drawer_cust_num
  is '�����˿ͻ���';
comment on column CLM.TB_BILL_EVENT_DETAIL.cert_drawer_name
  is '�����˿ͻ�����';
comment on column CLM.TB_BILL_EVENT_DETAIL.cert_drawer_bank_num
  is '�����˴���/�ж��к�';
comment on column CLM.TB_BILL_EVENT_DETAIL.cert_drawer_bank_name
  is '�����˴���/�ж�����';
comment on column CLM.TB_BILL_EVENT_DETAIL.cert_drawer_bank_legal
  is '�����˴���/�ж��з��˿ͻ���';
comment on column CLM.TB_BILL_EVENT_DETAIL.cert_guaranty_type
  is '������ʽ';
comment on column CLM.TB_BILL_EVENT_DETAIL.cert_guaranty_person
  is '������';
comment on column CLM.TB_BILL_EVENT_DETAIL.cert_busi_remark
  is '��ע��Ϣ';
comment on column CLM.TB_BILL_EVENT_DETAIL.cert_interest_peri_type
  is 'ƾ֤��Ϣ��������';
comment on column CLM.TB_BILL_EVENT_DETAIL.cert_interest_rate_type
  is '������/��������';
comment on column CLM.TB_BILL_EVENT_DETAIL.cert_is_my_bank
  is '�Ƿ񱾷����� 1:�Ǳ��У�0�Ǳ���';
alter table CLM.TB_BILL_EVENT_DETAIL
  add constraint P_KEY_111 primary key (EVENT_DETAILED_ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table TB_BILL_EVENT_DETAIL_MIDDLE
prompt ==========================================
prompt
create table CLM.TB_BILL_EVENT_DETAIL_MIDDLE
(
  tran_seq_sn           VARCHAR2(40) not null,
  tran_date             VARCHAR2(20) not null,
  busi_deal_num         VARCHAR2(40) not null,
  busi_prd_num          VARCHAR2(10),
  busi_deal_desc        VARCHAR2(50),
  busi_deal_org_num     VARCHAR2(40),
  busi_deal_org_name    VARCHAR2(100),
  busi_oppt_org_num     VARCHAR2(40),
  busi_oppt_org_name    VARCHAR2(100),
  busi_sum_amt          NUMBER(18,2),
  busi_cert_cnt         NUMBER(24),
  cert_num              VARCHAR2(40) not null,
  cert_type_cd          VARCHAR2(40),
  cert_ppt_cd           VARCHAR2(40),
  cert_interest_period  VARCHAR2(40),
  cert_interest_rate    NUMBER(10,6),
  cert_currency_cd      VARCHAR2(10),
  cert_seq_amt          NUMBER(18,2),
  cert_apply_amt        NUMBER(18,2),
  cert_apply_balance    NUMBER(18,2),
  cert_status           VARCHAR2(10),
  cert_begin_date       VARCHAR2(20),
  cert_end_date         VARCHAR2(20),
  cert_finish_date      VARCHAR2(20),
  cert_drawer_cust_num  VARCHAR2(50),
  cert_drawer_name      VARCHAR2(200),
  cert_drawer_bank_num  VARCHAR2(50),
  cert_drawer_bank_name VARCHAR2(200),
  cert_guaranty_type    VARCHAR2(40),
  cert_guaranty_person  VARCHAR2(40),
  cert_busi_remark      VARCHAR2(1000)
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
comment on table CLM.TB_BILL_EVENT_DETAIL_MIDDLE
  is 'Ʊ�������¼���ϸ��';
comment on column CLM.TB_BILL_EVENT_DETAIL_MIDDLE.tran_seq_sn
  is '������ˮ��';
comment on column CLM.TB_BILL_EVENT_DETAIL_MIDDLE.tran_date
  is '��������';
comment on column CLM.TB_BILL_EVENT_DETAIL_MIDDLE.busi_deal_num
  is 'ҵ����';
comment on column CLM.TB_BILL_EVENT_DETAIL_MIDDLE.busi_prd_num
  is 'ҵ���Ʒ���';
comment on column CLM.TB_BILL_EVENT_DETAIL_MIDDLE.busi_deal_desc
  is 'ҵ��������';
comment on column CLM.TB_BILL_EVENT_DETAIL_MIDDLE.busi_deal_org_num
  is '��������';
comment on column CLM.TB_BILL_EVENT_DETAIL_MIDDLE.busi_deal_org_name
  is '������������';
comment on column CLM.TB_BILL_EVENT_DETAIL_MIDDLE.busi_oppt_org_num
  is '���ֻ���';
comment on column CLM.TB_BILL_EVENT_DETAIL_MIDDLE.busi_oppt_org_name
  is '���ֻ�������';
comment on column CLM.TB_BILL_EVENT_DETAIL_MIDDLE.busi_sum_amt
  is '�����ܽ��';
comment on column CLM.TB_BILL_EVENT_DETAIL_MIDDLE.busi_cert_cnt
  is 'ƾ֤����';
comment on column CLM.TB_BILL_EVENT_DETAIL_MIDDLE.cert_num
  is 'ƾ֤���';
comment on column CLM.TB_BILL_EVENT_DETAIL_MIDDLE.cert_type_cd
  is 'ƾ֤Ʒ��';
comment on column CLM.TB_BILL_EVENT_DETAIL_MIDDLE.cert_ppt_cd
  is 'ƾ֤����';
comment on column CLM.TB_BILL_EVENT_DETAIL_MIDDLE.cert_interest_period
  is 'ƾ֤��Ϣ����';
comment on column CLM.TB_BILL_EVENT_DETAIL_MIDDLE.cert_interest_rate
  is '������/����';
comment on column CLM.TB_BILL_EVENT_DETAIL_MIDDLE.cert_currency_cd
  is '����';
comment on column CLM.TB_BILL_EVENT_DETAIL_MIDDLE.cert_seq_amt
  is 'ƾ֤ԭʼ���';
comment on column CLM.TB_BILL_EVENT_DETAIL_MIDDLE.cert_apply_amt
  is 'ƾ֤���Ž��';
comment on column CLM.TB_BILL_EVENT_DETAIL_MIDDLE.cert_apply_balance
  is 'ƾ֤�������';
comment on column CLM.TB_BILL_EVENT_DETAIL_MIDDLE.cert_status
  is 'ƾ֤״̬';
comment on column CLM.TB_BILL_EVENT_DETAIL_MIDDLE.cert_begin_date
  is 'ƾ֤����';
comment on column CLM.TB_BILL_EVENT_DETAIL_MIDDLE.cert_end_date
  is 'ƾֹ֤��';
comment on column CLM.TB_BILL_EVENT_DETAIL_MIDDLE.cert_finish_date
  is 'ƾ֤��������';
comment on column CLM.TB_BILL_EVENT_DETAIL_MIDDLE.cert_drawer_cust_num
  is '�����˿ͻ���';
comment on column CLM.TB_BILL_EVENT_DETAIL_MIDDLE.cert_drawer_name
  is '�����˿ͻ�����';
comment on column CLM.TB_BILL_EVENT_DETAIL_MIDDLE.cert_drawer_bank_num
  is '�����˴���/�ж��к�';
comment on column CLM.TB_BILL_EVENT_DETAIL_MIDDLE.cert_drawer_bank_name
  is '�����˴���/�ж�����';
comment on column CLM.TB_BILL_EVENT_DETAIL_MIDDLE.cert_guaranty_type
  is '������ʽ';
comment on column CLM.TB_BILL_EVENT_DETAIL_MIDDLE.cert_guaranty_person
  is '������';
comment on column CLM.TB_BILL_EVENT_DETAIL_MIDDLE.cert_busi_remark
  is '��ע��Ϣ';

prompt
prompt Creating table TB_BILL_EVENT_MAIN
prompt =================================
prompt
create table CLM.TB_BILL_EVENT_MAIN
(
  event_main_id     VARCHAR2(32) not null,
  tran_seq_sn       VARCHAR2(40),
  tran_date         VARCHAR2(20),
  busi_deal_num     VARCHAR2(40),
  tran_type_cd      VARCHAR2(2),
  cert_currency_cd  VARCHAR2(10),
  crd_apply_amt     NUMBER(18,2),
  tran_event_status VARCHAR2(2),
  tran_event_info   VARCHAR2(200),
  tran_acct_status  VARCHAR2(2),
  adjust_flag       VARCHAR2(1),
  adjust_direction  VARCHAR2(1),
  adjust_desc       VARCHAR2(100),
  adjust_status     VARCHAR2(1),
  tran_system       VARCHAR2(12),
  user_num          VARCHAR2(12)
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
comment on table CLM.TB_BILL_EVENT_MAIN
  is 'Ʊ�������¼�����';
comment on column CLM.TB_BILL_EVENT_MAIN.event_main_id
  is '�¼�����id';
comment on column CLM.TB_BILL_EVENT_MAIN.tran_seq_sn
  is '������ˮ��';
comment on column CLM.TB_BILL_EVENT_MAIN.tran_date
  is '��������';
comment on column CLM.TB_BILL_EVENT_MAIN.busi_deal_num
  is 'ҵ����';
comment on column CLM.TB_BILL_EVENT_MAIN.tran_type_cd
  is '�������ͣ�03 ռ�ã�04 ռ�ó�����05 �ָ������ڻָ�ʱ��Ʊ�ţ���06 �ָ�������';
comment on column CLM.TB_BILL_EVENT_MAIN.cert_currency_cd
  is '����';
comment on column CLM.TB_BILL_EVENT_MAIN.crd_apply_amt
  is '���Ž��';
comment on column CLM.TB_BILL_EVENT_MAIN.tran_event_status
  is '��������״̬��0 δ����  1 ����ɹ� 2 ����ʧ�� ��';
comment on column CLM.TB_BILL_EVENT_MAIN.tran_event_info
  is '�¼�������Ϣ';
comment on column CLM.TB_BILL_EVENT_MAIN.tran_acct_status
  is '�Է�����״̬��0 δ����  1 ����ɹ� 2 ����ʧ�ܣ�';
comment on column CLM.TB_BILL_EVENT_MAIN.adjust_flag
  is '�Ƿ���Ҫ������ʶ��1 ��Ҫ 0 ����Ҫ';
comment on column CLM.TB_BILL_EVENT_MAIN.adjust_direction
  is '��������1 ���� 0 ���';
comment on column CLM.TB_BILL_EVENT_MAIN.adjust_desc
  is '��������';
comment on column CLM.TB_BILL_EVENT_MAIN.adjust_status
  is '1�������ɹ� 0������ʧ��';
comment on column CLM.TB_BILL_EVENT_MAIN.tran_system
  is '�������';
comment on column CLM.TB_BILL_EVENT_MAIN.user_num
  is '������';

prompt
prompt Creating table TB_BILL_EVENT_MAIN_MIDDLE
prompt ========================================
prompt
create table CLM.TB_BILL_EVENT_MAIN_MIDDLE
(
  tran_seq_sn     VARCHAR2(40),
  tran_date       VARCHAR2(20),
  busi_deal_num   VARCHAR2(40),
  tran_type_cd    VARCHAR2(2),
  crd_apply_amt   NUMBER(18,2),
  crd_currency_cd VARCHAR2(10),
  tran_system     VARCHAR2(12),
  user_num        VARCHAR2(12)
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
comment on table CLM.TB_BILL_EVENT_MAIN_MIDDLE
  is 'Ʊ�������¼�����';
comment on column CLM.TB_BILL_EVENT_MAIN_MIDDLE.tran_seq_sn
  is '������ˮ��';
comment on column CLM.TB_BILL_EVENT_MAIN_MIDDLE.tran_date
  is '��������';
comment on column CLM.TB_BILL_EVENT_MAIN_MIDDLE.busi_deal_num
  is 'ҵ����';
comment on column CLM.TB_BILL_EVENT_MAIN_MIDDLE.tran_type_cd
  is '�������ͣ�03 ռ�ã�04 ռ�ó�����05 �ָ������ڻָ�ʱ��Ʊ�ţ���06 �ָ�������';
comment on column CLM.TB_BILL_EVENT_MAIN_MIDDLE.crd_apply_amt
  is '���Ž��';
comment on column CLM.TB_BILL_EVENT_MAIN_MIDDLE.crd_currency_cd
  is '����(CD000019)';
comment on column CLM.TB_BILL_EVENT_MAIN_MIDDLE.tran_system
  is '�������';
comment on column CLM.TB_BILL_EVENT_MAIN_MIDDLE.user_num
  is '������';

prompt
prompt Creating table TB_CRD_APPLY_SERIAL
prompt ==================================
prompt
create table CLM.TB_CRD_APPLY_SERIAL
(
  serial_id         VARCHAR2(32) not null,
  tran_seq_sn       VARCHAR2(40),
  tran_date         VARCHAR2(20),
  busi_deal_num     VARCHAR2(40),
  tran_type_cd      VARCHAR2(10),
  crd_detail_num    VARCHAR2(32),
  crd_grant_org_num VARCHAR2(5),
  customer_num      VARCHAR2(10),
  crd_detail_prd    VARCHAR2(10),
  limit_credit_amt  NUMBER(24,2),
  exp_credit_amt    NUMBER(24,2),
  currency_cd       VARCHAR2(3),
  is_mix            VARCHAR2(1),
  mix_credit        NUMBER(24,2),
  tran_system       VARCHAR2(12),
  org_num           VARCHAR2(5),
  user_num          VARCHAR2(12),
  create_time       DATE,
  update_time       DATE
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
comment on table CLM.TB_CRD_APPLY_SERIAL
  is '���ʹ����ˮ';
comment on column CLM.TB_CRD_APPLY_SERIAL.serial_id
  is '����';
comment on column CLM.TB_CRD_APPLY_SERIAL.tran_seq_sn
  is '������ˮ��';
comment on column CLM.TB_CRD_APPLY_SERIAL.tran_date
  is '��������';
comment on column CLM.TB_CRD_APPLY_SERIAL.busi_deal_num
  is 'ҵ���ţ���Ų�ͬ��ҵ�񳡾��µ�ҵ���ţ�';
comment on column CLM.TB_CRD_APPLY_SERIAL.tran_type_cd
  is '��������(CD000197)';
comment on column CLM.TB_CRD_APPLY_SERIAL.crd_detail_num
  is '������ȱ��';
comment on column CLM.TB_CRD_APPLY_SERIAL.crd_grant_org_num
  is '���Ż���';
comment on column CLM.TB_CRD_APPLY_SERIAL.customer_num
  is '���ſͻ���';
comment on column CLM.TB_CRD_APPLY_SERIAL.crd_detail_prd
  is '������Ȳ�Ʒ';
comment on column CLM.TB_CRD_APPLY_SERIAL.limit_credit_amt
  is 'ռ��/�ָ���Ƚ��';
comment on column CLM.TB_CRD_APPLY_SERIAL.exp_credit_amt
  is 'ռ��/�ָ����ڽ��';
comment on column CLM.TB_CRD_APPLY_SERIAL.currency_cd
  is '����(CD000019)';
comment on column CLM.TB_CRD_APPLY_SERIAL.is_mix
  is '�Ƿ���';
comment on column CLM.TB_CRD_APPLY_SERIAL.mix_credit
  is '���ö��';
comment on column CLM.TB_CRD_APPLY_SERIAL.tran_system
  is '����ϵͳ';
comment on column CLM.TB_CRD_APPLY_SERIAL.org_num
  is '�������';
comment on column CLM.TB_CRD_APPLY_SERIAL.user_num
  is '������';
comment on column CLM.TB_CRD_APPLY_SERIAL.create_time
  is '����ʱ��';
comment on column CLM.TB_CRD_APPLY_SERIAL.update_time
  is '�޸�ʱ��';
alter table CLM.TB_CRD_APPLY_SERIAL
  add constraint P_KEY_11 primary key (SERIAL_ID)
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
prompt Creating table TB_CRD_APPROVE
prompt =============================
prompt
create table CLM.TB_CRD_APPROVE
(
  approve_id            VARCHAR2(32) not null,
  customer_num          VARCHAR2(40),
  approve_num           VARCHAR2(30),
  crd_main_prd          VARCHAR2(40),
  crd_main_num          VARCHAR2(40),
  crd_detail_prd        VARCHAR2(10),
  crd_detail_num        VARCHAR2(40),
  is_joint_guarantee    VARCHAR2(6),
  biz_type              VARCHAR2(6),
  is_low_risk           VARCHAR2(6),
  low_risk_type         VARCHAR2(200),
  biz_happen_type       VARCHAR2(6),
  product_num           VARCHAR2(10),
  product_type          VARCHAR2(30),
  is_cycle              VARCHAR2(1),
  industry              VARCHAR2(10),
  guarantee_type        VARCHAR2(10),
  main_guarantee_type   VARCHAR2(10),
  guarantee_type_detail VARCHAR2(10),
  term                  NUMBER(24,2),
  term_unit             VARCHAR2(10),
  term_type             VARCHAR2(10),
  approve_status        VARCHAR2(6),
  currency_cd           VARCHAR2(10),
  exchange_rate         NUMBER(24,2),
  total_amt             NUMBER(24,2),
  approve_amt           NUMBER(24,2),
  approve_used          NUMBER(24,2),
  approve_avi           NUMBER(24,2),
  approve_exp_amt       NUMBER(24,2),
  approve_exp_used      NUMBER(24,2),
  approve_exp_avi       NUMBER(24,2),
  approve_pre_amt       NUMBER(24,2),
  approve_pre_exp       NUMBER(24,2),
  deposit_ratio         NUMBER(10,6),
  begin_date            VARCHAR2(20),
  end_date              VARCHAR2(20),
  old_summary_num       VARCHAR2(40),
  project_num           VARCHAR2(40),
  tran_date             VARCHAR2(20),
  org_num               VARCHAR2(10),
  user_num              VARCHAR2(10),
  tran_system           VARCHAR2(10),
  create_time           DATE,
  update_time           DATE
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
comment on table CLM.TB_CRD_APPROVE
  is '������Ϣ��';
comment on column CLM.TB_CRD_APPROVE.approve_id
  is '����ID';
comment on column CLM.TB_CRD_APPROVE.customer_num
  is '�ͻ����';
comment on column CLM.TB_CRD_APPROVE.approve_num
  is '�������';
comment on column CLM.TB_CRD_APPROVE.crd_main_prd
  is '��ȶ������';
comment on column CLM.TB_CRD_APPROVE.crd_main_num
  is '��ȶ������';
comment on column CLM.TB_CRD_APPROVE.crd_detail_prd
  is '��ȶ������';
comment on column CLM.TB_CRD_APPROVE.crd_detail_num
  is '��ȶ������';
comment on column CLM.TB_CRD_APPROVE.is_joint_guarantee
  is '�Ƿ�������CD000167��';
comment on column CLM.TB_CRD_APPROVE.biz_type
  is 'ҵ�����ͣ�CD000170��';
comment on column CLM.TB_CRD_APPROVE.is_low_risk
  is '�Ƿ�ͷ��գ�CD000167��';
comment on column CLM.TB_CRD_APPROVE.low_risk_type
  is '�ͷ���ҵ�����';
comment on column CLM.TB_CRD_APPROVE.biz_happen_type
  is 'ҵ������ʽ(CD000168)';
comment on column CLM.TB_CRD_APPROVE.product_num
  is 'ҵ��Ʒ��(:tb_par_product)';
comment on column CLM.TB_CRD_APPROVE.product_type
  is 'ҵ�����ࣨCD000061��';
comment on column CLM.TB_CRD_APPROVE.is_cycle
  is '�Ƿ��ѭ����CD000167��';
comment on column CLM.TB_CRD_APPROVE.industry
  is '��ҵͶ��CD000015��';
comment on column CLM.TB_CRD_APPROVE.guarantee_type
  is '������ʽ��CD000100��';
comment on column CLM.TB_CRD_APPROVE.main_guarantee_type
  is '��������ʽ��CD000100��';
comment on column CLM.TB_CRD_APPROVE.guarantee_type_detail
  is '������ʽ���ࣨCD000101��';
comment on column CLM.TB_CRD_APPROVE.term
  is '����';
comment on column CLM.TB_CRD_APPROVE.term_unit
  is '���޵�λ��CD000169��';
comment on column CLM.TB_CRD_APPROVE.term_type
  is '�������ͣ�CD000210��';
comment on column CLM.TB_CRD_APPROVE.approve_status
  is '����״̬��CD000109��';
comment on column CLM.TB_CRD_APPROVE.currency_cd
  is '���֣�CD000019��';
comment on column CLM.TB_CRD_APPROVE.exchange_rate
  is '����';
comment on column CLM.TB_CRD_APPROVE.total_amt
  is '�����ܽ��';
comment on column CLM.TB_CRD_APPROVE.approve_amt
  is '�������';
comment on column CLM.TB_CRD_APPROVE.approve_used
  is '��������';
comment on column CLM.TB_CRD_APPROVE.approve_avi
  is '��������';
comment on column CLM.TB_CRD_APPROVE.approve_exp_amt
  is '�������ڽ��';
comment on column CLM.TB_CRD_APPROVE.approve_exp_used
  is '������������';
comment on column CLM.TB_CRD_APPROVE.approve_exp_avi
  is '�������ڿ���';
comment on column CLM.TB_CRD_APPROVE.approve_pre_amt
  is '����Ԥռ�ö��';
comment on column CLM.TB_CRD_APPROVE.approve_pre_exp
  is '����Ԥռ�ó���';
comment on column CLM.TB_CRD_APPROVE.deposit_ratio
  is '��֤�����';
comment on column CLM.TB_CRD_APPROVE.begin_date
  is '��������';
comment on column CLM.TB_CRD_APPROVE.end_date
  is '����ֹ��';
comment on column CLM.TB_CRD_APPROVE.old_summary_num
  is '���»��ɽ�ݱ��';
comment on column CLM.TB_CRD_APPROVE.project_num
  is '��ĿЭ����';
comment on column CLM.TB_CRD_APPROVE.tran_date
  is '��������';
comment on column CLM.TB_CRD_APPROVE.org_num
  is '�������';
comment on column CLM.TB_CRD_APPROVE.user_num
  is '������';
comment on column CLM.TB_CRD_APPROVE.tran_system
  is '����ϵͳ';
comment on column CLM.TB_CRD_APPROVE.create_time
  is '����ʱ��';
comment on column CLM.TB_CRD_APPROVE.update_time
  is '����ʱ��';
alter table CLM.TB_CRD_APPROVE
  add constraint PK_2996 primary key (APPROVE_ID)
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
prompt Creating table TB_CRD_APPROVE_EVENT
prompt ===================================
prompt
create table CLM.TB_CRD_APPROVE_EVENT
(
  event_id              VARCHAR2(32) not null,
  tran_seq_sn           VARCHAR2(50),
  op_type               VARCHAR2(2),
  approve_id            VARCHAR2(32),
  customer_num          VARCHAR2(40),
  approve_num           VARCHAR2(30),
  crd_main_prd          VARCHAR2(40),
  crd_main_num          VARCHAR2(40),
  crd_detail_prd        VARCHAR2(10),
  crd_detail_num        VARCHAR2(40),
  is_joint_guarantee    VARCHAR2(6),
  biz_type              VARCHAR2(6),
  is_low_risk           VARCHAR2(6),
  low_risk_type         VARCHAR2(200),
  biz_happen_type       VARCHAR2(6),
  product_num           VARCHAR2(10),
  product_type          VARCHAR2(30),
  is_cycle              VARCHAR2(1),
  industry              VARCHAR2(10),
  guarantee_type        VARCHAR2(10),
  main_guarantee_type   VARCHAR2(10),
  guarantee_type_detail VARCHAR2(10),
  term                  NUMBER(24,2),
  term_unit             VARCHAR2(10),
  term_type             VARCHAR2(10),
  approve_status        VARCHAR2(6),
  currency_cd           VARCHAR2(10),
  exchange_rate         NUMBER(24,2),
  total_amt             NUMBER(24,2),
  approve_amt           NUMBER(24,2),
  approve_used          NUMBER(24,2),
  approve_avi           NUMBER(24,2),
  approve_exp_amt       NUMBER(24,2),
  approve_exp_used      NUMBER(24,2),
  approve_exp_avi       NUMBER(24,2),
  approve_pre_amt       NUMBER(24,2),
  approve_pre_exp       NUMBER(24,2),
  deposit_ratio         NUMBER(10,6),
  begin_date            VARCHAR2(20),
  end_date              VARCHAR2(20),
  old_summary_num       VARCHAR2(40),
  project_num           VARCHAR2(40),
  tran_date             VARCHAR2(20),
  org_num               VARCHAR2(10),
  user_num              VARCHAR2(10),
  tran_system           VARCHAR2(10),
  create_time           DATE,
  update_time           DATE,
  biz_scene             VARCHAR2(2),
  biz_action            VARCHAR2(2)
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
comment on table CLM.TB_CRD_APPROVE_EVENT
  is '�Ŵ�ʵʱ-������Ϣ';
comment on column CLM.TB_CRD_APPROVE_EVENT.event_id
  is '����';
comment on column CLM.TB_CRD_APPROVE_EVENT.tran_seq_sn
  is '������ˮ��';
comment on column CLM.TB_CRD_APPROVE_EVENT.op_type
  is '�������ͣ�01 ����02 ���� 03ɾ����';
comment on column CLM.TB_CRD_APPROVE_EVENT.approve_id
  is '����ID';
comment on column CLM.TB_CRD_APPROVE_EVENT.customer_num
  is '�ͻ����';
comment on column CLM.TB_CRD_APPROVE_EVENT.approve_num
  is '�������';
comment on column CLM.TB_CRD_APPROVE_EVENT.crd_main_prd
  is '��ȶ������';
comment on column CLM.TB_CRD_APPROVE_EVENT.crd_main_num
  is '��ȶ������';
comment on column CLM.TB_CRD_APPROVE_EVENT.crd_detail_prd
  is '��ȶ������';
comment on column CLM.TB_CRD_APPROVE_EVENT.crd_detail_num
  is '��ȶ������';
comment on column CLM.TB_CRD_APPROVE_EVENT.is_joint_guarantee
  is '�Ƿ�������CD000167��';
comment on column CLM.TB_CRD_APPROVE_EVENT.biz_type
  is 'ҵ�����ͣ�CD000170��';
comment on column CLM.TB_CRD_APPROVE_EVENT.is_low_risk
  is '�Ƿ�ͷ��գ�CD000167��';
comment on column CLM.TB_CRD_APPROVE_EVENT.low_risk_type
  is '�ͷ���ҵ�����';
comment on column CLM.TB_CRD_APPROVE_EVENT.biz_happen_type
  is 'ҵ������ʽ(CD000168)';
comment on column CLM.TB_CRD_APPROVE_EVENT.product_num
  is 'ҵ��Ʒ��(:tb_par_product)';
comment on column CLM.TB_CRD_APPROVE_EVENT.product_type
  is 'ҵ�����ࣨCD000061��';
comment on column CLM.TB_CRD_APPROVE_EVENT.is_cycle
  is '�Ƿ��ѭ����CD000167��';
comment on column CLM.TB_CRD_APPROVE_EVENT.industry
  is '��ҵͶ��CD000015��';
comment on column CLM.TB_CRD_APPROVE_EVENT.guarantee_type
  is '������ʽ��CD000100��';
comment on column CLM.TB_CRD_APPROVE_EVENT.main_guarantee_type
  is '��������ʽ��CD000100��';
comment on column CLM.TB_CRD_APPROVE_EVENT.guarantee_type_detail
  is '������ʽ���ࣨCD000101��';
comment on column CLM.TB_CRD_APPROVE_EVENT.term
  is '����';
comment on column CLM.TB_CRD_APPROVE_EVENT.term_unit
  is '���޵�λ��CD000169��';
comment on column CLM.TB_CRD_APPROVE_EVENT.term_type
  is '�������ͣ�CD000210��';
comment on column CLM.TB_CRD_APPROVE_EVENT.approve_status
  is '����״̬��CD000109��';
comment on column CLM.TB_CRD_APPROVE_EVENT.currency_cd
  is '���֣�CD000019��';
comment on column CLM.TB_CRD_APPROVE_EVENT.exchange_rate
  is '����';
comment on column CLM.TB_CRD_APPROVE_EVENT.total_amt
  is '�����ܽ��';
comment on column CLM.TB_CRD_APPROVE_EVENT.approve_amt
  is '�������';
comment on column CLM.TB_CRD_APPROVE_EVENT.approve_used
  is '��������';
comment on column CLM.TB_CRD_APPROVE_EVENT.approve_avi
  is '��������';
comment on column CLM.TB_CRD_APPROVE_EVENT.approve_exp_amt
  is '�������ڽ��';
comment on column CLM.TB_CRD_APPROVE_EVENT.approve_exp_used
  is '������������';
comment on column CLM.TB_CRD_APPROVE_EVENT.approve_exp_avi
  is '�������ڿ���';
comment on column CLM.TB_CRD_APPROVE_EVENT.approve_pre_amt
  is '����Ԥռ�ö��';
comment on column CLM.TB_CRD_APPROVE_EVENT.approve_pre_exp
  is '����Ԥռ�ó���';
comment on column CLM.TB_CRD_APPROVE_EVENT.deposit_ratio
  is '��֤�����';
comment on column CLM.TB_CRD_APPROVE_EVENT.begin_date
  is '��������';
comment on column CLM.TB_CRD_APPROVE_EVENT.end_date
  is '����ֹ��';
comment on column CLM.TB_CRD_APPROVE_EVENT.old_summary_num
  is '���»��ɽ�ݱ��';
comment on column CLM.TB_CRD_APPROVE_EVENT.project_num
  is '��ĿЭ����';
comment on column CLM.TB_CRD_APPROVE_EVENT.tran_date
  is '��������';
comment on column CLM.TB_CRD_APPROVE_EVENT.org_num
  is '�������';
comment on column CLM.TB_CRD_APPROVE_EVENT.user_num
  is '������';
comment on column CLM.TB_CRD_APPROVE_EVENT.tran_system
  is '����ϵͳ';
comment on column CLM.TB_CRD_APPROVE_EVENT.create_time
  is '����ʱ��';
comment on column CLM.TB_CRD_APPROVE_EVENT.update_time
  is '����ʱ��';
comment on column CLM.TB_CRD_APPROVE_EVENT.biz_scene
  is 'ҵ�񳡾�';
comment on column CLM.TB_CRD_APPROVE_EVENT.biz_action
  is '���̽ڵ�';
alter table CLM.TB_CRD_APPROVE_EVENT
  add constraint PK_29961 primary key (EVENT_ID)
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
prompt Creating table TB_CRD_BILL
prompt ==========================
prompt
create table CLM.TB_CRD_BILL
(
  summary_num        VARCHAR2(40) not null,
  customer_num       VARCHAR2(40),
  bill_num           VARCHAR2(40),
  bill_type          VARCHAR2(10),
  ebill_num          VARCHAR2(40),
  deposit_ratio      NUMBER(10,6),
  currency_cd        VARCHAR2(10),
  bill_amt           NUMBER(18,2),
  payee_name         VARCHAR2(2500),
  payee_acct         VARCHAR2(50),
  payee_bank_num     VARCHAR2(50),
  payee_bank_name    VARCHAR2(250),
  pay_name           VARCHAR2(250),
  pay_acct           VARCHAR2(100),
  drawer_name        VARCHAR2(250),
  drawer_acct        VARCHAR2(50),
  drawer_bank_num    VARCHAR2(50),
  drawer_bank_name   VARCHAR2(250),
  acceptor_ecif_num  VARCHAR2(50),
  acceptor_name      VARCHAR2(250),
  acceptor_acct      VARCHAR2(50),
  acceptor_bank_num  VARCHAR2(50),
  acceptor_bank_name VARCHAR2(250),
  bill_status        VARCHAR2(10),
  begin_date         VARCHAR2(20),
  end_date           VARCHAR2(20),
  close_date         VARCHAR2(20),
  bill_source        VARCHAR2(10),
  user_num           VARCHAR2(12),
  org_num            VARCHAR2(12),
  create_time        DATE,
  update_time        DATE
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on table CLM.TB_CRD_BILL
  is 'Ʊ����Ϣ��';
comment on column CLM.TB_CRD_BILL.summary_num
  is '��ݺ�';
comment on column CLM.TB_CRD_BILL.customer_num
  is '�ͻ����';
comment on column CLM.TB_CRD_BILL.bill_num
  is 'Ʊ�ݱ��';
comment on column CLM.TB_CRD_BILL.bill_type
  is 'Ʊ�����ࣨCD000080��';
comment on column CLM.TB_CRD_BILL.ebill_num
  is '����Ʊ��ƾ֤��';
comment on column CLM.TB_CRD_BILL.deposit_ratio
  is '��֤�����';
comment on column CLM.TB_CRD_BILL.currency_cd
  is '����';
comment on column CLM.TB_CRD_BILL.bill_amt
  is 'Ʊ����';
comment on column CLM.TB_CRD_BILL.payee_name
  is '�տ�������';
comment on column CLM.TB_CRD_BILL.payee_acct
  is '�տ����˺�';
comment on column CLM.TB_CRD_BILL.payee_bank_num
  is '�տ��˿������к�';
comment on column CLM.TB_CRD_BILL.payee_bank_name
  is '�տ��˿���������';
comment on column CLM.TB_CRD_BILL.pay_name
  is '����������';
comment on column CLM.TB_CRD_BILL.pay_acct
  is '�������к�';
comment on column CLM.TB_CRD_BILL.drawer_name
  is '��Ʊ������';
comment on column CLM.TB_CRD_BILL.drawer_acct
  is '��Ʊ���˺�';
comment on column CLM.TB_CRD_BILL.drawer_bank_num
  is '��Ʊ�˿������к�';
comment on column CLM.TB_CRD_BILL.drawer_bank_name
  is '��Ʊ�˿���������';
comment on column CLM.TB_CRD_BILL.acceptor_ecif_num
  is '�ж���ECIF�ͻ���';
comment on column CLM.TB_CRD_BILL.acceptor_name
  is '�ж�������';
comment on column CLM.TB_CRD_BILL.acceptor_acct
  is '�ж����˺�';
comment on column CLM.TB_CRD_BILL.acceptor_bank_num
  is '�ж��˿������к�';
comment on column CLM.TB_CRD_BILL.acceptor_bank_name
  is '�ж��˿���������';
comment on column CLM.TB_CRD_BILL.bill_status
  is 'Ʊ��״̬��CD000078��';
comment on column CLM.TB_CRD_BILL.begin_date
  is 'Ʊ������';
comment on column CLM.TB_CRD_BILL.end_date
  is '���ֹ��';
comment on column CLM.TB_CRD_BILL.close_date
  is '��������';
comment on column CLM.TB_CRD_BILL.bill_source
  is 'Ʊ����Դ';
comment on column CLM.TB_CRD_BILL.user_num
  is '������';
comment on column CLM.TB_CRD_BILL.org_num
  is '�������';
comment on column CLM.TB_CRD_BILL.create_time
  is '����ʱ��';
comment on column CLM.TB_CRD_BILL.update_time
  is '�޸�ʱ��';
alter table CLM.TB_CRD_BILL
  add constraint P_KEY_12 primary key (SUMMARY_NUM)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table TB_CRD_BORROW_DETAIL
prompt ===================================
prompt
create table CLM.TB_CRD_BORROW_DETAIL
(
  lstg_detail_id VARCHAR2(40) not null,
  lstg_id        VARCHAR2(40),
  biz_num        VARCHAR2(40),
  customer_num   VARCHAR2(20),
  borrow_amt     NUMBER(20,2),
  borrow_balance NUMBER(20,2),
  borrow_date    VARCHAR2(10)
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
comment on table CLM.TB_CRD_BORROW_DETAIL
  is '������ˮ��ϸ��';
comment on column CLM.TB_CRD_BORROW_DETAIL.lstg_detail_id
  is '������ˮ��ϸID';
comment on column CLM.TB_CRD_BORROW_DETAIL.lstg_id
  is '������ID';
comment on column CLM.TB_CRD_BORROW_DETAIL.biz_num
  is '����ҵ����';
comment on column CLM.TB_CRD_BORROW_DETAIL.customer_num
  is '�ͻ����';
comment on column CLM.TB_CRD_BORROW_DETAIL.borrow_amt
  is '���ý��';
comment on column CLM.TB_CRD_BORROW_DETAIL.borrow_balance
  is '�������';
comment on column CLM.TB_CRD_BORROW_DETAIL.borrow_date
  is '��������';
alter table CLM.TB_CRD_BORROW_DETAIL
  add constraint PK_TB_CRD_BORROW_DETAIL primary key (LSTG_DETAIL_ID)
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
prompt Creating table TB_CRD_BUSI_CERT_INFO
prompt ====================================
prompt
create table CLM.TB_CRD_BUSI_CERT_INFO
(
  cret_info_id            VARCHAR2(32) not null,
  crd_detail_num          VARCHAR2(32) not null,
  busi_deal_num           VARCHAR2(40) not null,
  busi_prd_num            VARCHAR2(10) not null,
  busi_deal_desc          VARCHAR2(50),
  busi_deal_org_num       VARCHAR2(5),
  busi_deal_org_name      VARCHAR2(90),
  busi_oppt_org_num       VARCHAR2(40),
  busi_oppt_org_name      VARCHAR2(100),
  busi_sum_amt            NUMBER(24,2),
  busi_cert_cnt           INTEGER,
  cert_num                VARCHAR2(40) not null,
  cert_type_cd            VARCHAR2(40),
  cert_ppt_cd             VARCHAR2(40),
  cert_interest_peri_type VARCHAR2(10),
  cert_interest_period    VARCHAR2(40),
  cert_interest_rate_type VARCHAR2(10),
  cert_interest_rate      NUMBER(24,2),
  cert_currency_cd        VARCHAR2(3),
  cert_seq_amt            NUMBER(24,2),
  cert_apply_amt          NUMBER(24,2),
  cert_apply_balance      NUMBER(24,2),
  cert_status             VARCHAR2(10),
  cert_begin_date         VARCHAR2(20),
  cert_end_date           VARCHAR2(20),
  cert_finish_date        VARCHAR2(20),
  cert_drawer_cust_num    VARCHAR2(50),
  cert_drawer_name        VARCHAR2(200),
  cert_drawer_bank_num    VARCHAR2(14),
  cert_drawer_bank_name   VARCHAR2(200),
  cert_guaranty_type      VARCHAR2(40),
  cert_guaranty_person    VARCHAR2(40),
  last_summary_bal        NUMBER(24,2),
  user_num                VARCHAR2(12),
  cert_busi_remark        VARCHAR2(1000),
  crd_detail_prd          VARCHAR2(10),
  crd_grant_org_num       VARCHAR2(5),
  customer_num            VARCHAR2(10),
  cert_drawer_bank_legal  VARCHAR2(40)
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
comment on table CLM.TB_CRD_BUSI_CERT_INFO
  is 'ҵ���Ʒƾ֤��Ϣ��';
comment on column CLM.TB_CRD_BUSI_CERT_INFO.cret_info_id
  is 'ƾ֤��Ϣid';
comment on column CLM.TB_CRD_BUSI_CERT_INFO.crd_detail_num
  is '������ȱ��';
comment on column CLM.TB_CRD_BUSI_CERT_INFO.busi_deal_num
  is 'ҵ����';
comment on column CLM.TB_CRD_BUSI_CERT_INFO.busi_prd_num
  is 'ҵ���Ʒ���';
comment on column CLM.TB_CRD_BUSI_CERT_INFO.busi_deal_desc
  is '��������';
comment on column CLM.TB_CRD_BUSI_CERT_INFO.busi_deal_org_num
  is '��������';
comment on column CLM.TB_CRD_BUSI_CERT_INFO.busi_deal_org_name
  is '������������';
comment on column CLM.TB_CRD_BUSI_CERT_INFO.busi_oppt_org_num
  is '���ֻ���';
comment on column CLM.TB_CRD_BUSI_CERT_INFO.busi_oppt_org_name
  is '���ֻ�������';
comment on column CLM.TB_CRD_BUSI_CERT_INFO.busi_sum_amt
  is '�����ܽ��';
comment on column CLM.TB_CRD_BUSI_CERT_INFO.busi_cert_cnt
  is 'ƾ֤����';
comment on column CLM.TB_CRD_BUSI_CERT_INFO.cert_num
  is 'ƾ֤���';
comment on column CLM.TB_CRD_BUSI_CERT_INFO.cert_type_cd
  is 'ƾ֤Ʒ��';
comment on column CLM.TB_CRD_BUSI_CERT_INFO.cert_ppt_cd
  is 'ƾ֤����';
comment on column CLM.TB_CRD_BUSI_CERT_INFO.cert_interest_peri_type
  is 'ƾ֤��Ϣ��������';
comment on column CLM.TB_CRD_BUSI_CERT_INFO.cert_interest_period
  is 'ƾ֤��Ϣ����';
comment on column CLM.TB_CRD_BUSI_CERT_INFO.cert_interest_rate_type
  is '������/��������';
comment on column CLM.TB_CRD_BUSI_CERT_INFO.cert_interest_rate
  is '������/����';
comment on column CLM.TB_CRD_BUSI_CERT_INFO.cert_currency_cd
  is '����(CD000019)';
comment on column CLM.TB_CRD_BUSI_CERT_INFO.cert_seq_amt
  is 'ƾ֤������';
comment on column CLM.TB_CRD_BUSI_CERT_INFO.cert_apply_amt
  is 'ƾ֤���Ž��';
comment on column CLM.TB_CRD_BUSI_CERT_INFO.cert_apply_balance
  is 'ƾ֤�������';
comment on column CLM.TB_CRD_BUSI_CERT_INFO.cert_status
  is 'ƾ֤״̬��CD000201��';
comment on column CLM.TB_CRD_BUSI_CERT_INFO.cert_begin_date
  is 'ƾ֤����';
comment on column CLM.TB_CRD_BUSI_CERT_INFO.cert_end_date
  is 'ƾֹ֤��';
comment on column CLM.TB_CRD_BUSI_CERT_INFO.cert_finish_date
  is 'ƾ֤��������';
comment on column CLM.TB_CRD_BUSI_CERT_INFO.cert_drawer_cust_num
  is '�����˿ͻ���';
comment on column CLM.TB_CRD_BUSI_CERT_INFO.cert_drawer_name
  is '�����˿ͻ�����';
comment on column CLM.TB_CRD_BUSI_CERT_INFO.cert_drawer_bank_num
  is '�����˴���/�ж��к�';
comment on column CLM.TB_CRD_BUSI_CERT_INFO.cert_drawer_bank_name
  is '�����˴���/�ж�����';
comment on column CLM.TB_CRD_BUSI_CERT_INFO.cert_guaranty_type
  is '������ʽ';
comment on column CLM.TB_CRD_BUSI_CERT_INFO.cert_guaranty_person
  is '������';
comment on column CLM.TB_CRD_BUSI_CERT_INFO.last_summary_bal
  is '����ƾ֤���';
comment on column CLM.TB_CRD_BUSI_CERT_INFO.user_num
  is '������';
comment on column CLM.TB_CRD_BUSI_CERT_INFO.cert_busi_remark
  is '��ע��Ϣ';
comment on column CLM.TB_CRD_BUSI_CERT_INFO.crd_detail_prd
  is '������Ȳ�Ʒ';
comment on column CLM.TB_CRD_BUSI_CERT_INFO.crd_grant_org_num
  is '���Ż���';
comment on column CLM.TB_CRD_BUSI_CERT_INFO.customer_num
  is '�ͻ����';
comment on column CLM.TB_CRD_BUSI_CERT_INFO.cert_drawer_bank_legal
  is '�����˴���/�ж��з�����';
create unique index CLM.AK_UQ_TB_CRD_B on CLM.TB_CRD_BUSI_CERT_INFO (CRD_DETAIL_NUM, BUSI_DEAL_NUM, CERT_NUM)
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
alter table CLM.TB_CRD_BUSI_CERT_INFO
  add constraint PK_TB_CRD_BUSI_CERT_INFO primary key (CRET_INFO_ID)
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
prompt Creating table TB_CRD_CC_INFO
prompt =============================
prompt
create table CLM.TB_CRD_CC_INFO
(
  acct_num              VARCHAR2(32) not null,
  customer_num          VARCHAR2(10),
  cc_customer_num       VARCHAR2(40),
  customer_name         VARCHAR2(200),
  cert_type             VARCHAR2(10),
  cert_num              VARCHAR2(40),
  crd_main_prd          VARCHAR2(10),
  crd_main_num          VARCHAR2(40),
  crd_detail_prd        VARCHAR2(10),
  crd_detail_num        VARCHAR2(40),
  product_num           VARCHAR2(10),
  currency_cd           VARCHAR2(10),
  credit_limit          NUMBER(24,2),
  temp_limit            NUMBER(24,2),
  temp_limit_begin_date VARCHAR2(20),
  temp_limit_end_date   VARCHAR2(20),
  cash_limit_rt         NUMBER(10,6),
  ovrlmt_rate           NUMBER(10,6),
  loan_limit_rt         NUMBER(10,6),
  curr_bal              NUMBER(24,2),
  cash_bal              NUMBER(24,2),
  principal_bal         NUMBER(24,2),
  loan_bal              NUMBER(24,2),
  qual_grace_bal        NUMBER(24,2),
  actual_payment_amt    NUMBER(24,2),
  charge_off_amt        NUMBER(24,2),
  unstmt_bal            NUMBER(24,2),
  ctd_reail_prin_bal    NUMBER(24,2),
  stmt_reail_prin_bal   NUMBER(24,2),
  ctd_cash_prin_bal     NUMBER(24,2),
  stmt_cash_prin_bal    NUMBER(24,2),
  ctd_loan_prin_bal     NUMBER(24,2),
  stmt_loan_prin_bal    NUMBER(24,2),
  large_loan_bal_xfrout NUMBER(24,2),
  unmatch_db_amt        NUMBER(24,2),
  unmatch_cr_amt        NUMBER(24,2),
  overlimit_amt         NUMBER(24,2),
  remain_grace_bal      NUMBER(24,2),
  grace_days_full_ind   NUMBER(24,2),
  org_num               VARCHAR2(10),
  billing_cycle         VARCHAR2(10),
  create_time           DATE,
  update_time           DATE
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
comment on table CLM.TB_CRD_CC_INFO
  is '���ÿ�ϵͳ��Ϣ';
comment on column CLM.TB_CRD_CC_INFO.acct_num
  is '�˻����';
comment on column CLM.TB_CRD_CC_INFO.customer_num
  is '�ͻ����';
comment on column CLM.TB_CRD_CC_INFO.cc_customer_num
  is '�Է��ͻ���';
comment on column CLM.TB_CRD_CC_INFO.customer_name
  is '�ͻ�����';
comment on column CLM.TB_CRD_CC_INFO.cert_type
  is '֤������';
comment on column CLM.TB_CRD_CC_INFO.cert_num
  is '֤������';
comment on column CLM.TB_CRD_CC_INFO.crd_main_prd
  is '��ȶ�����Ʒ';
comment on column CLM.TB_CRD_CC_INFO.crd_main_num
  is '��ȶ������';
comment on column CLM.TB_CRD_CC_INFO.crd_detail_prd
  is '���������Ʒ';
comment on column CLM.TB_CRD_CC_INFO.crd_detail_num
  is '����������';
comment on column CLM.TB_CRD_CC_INFO.product_num
  is '��Ʒ����';
comment on column CLM.TB_CRD_CC_INFO.currency_cd
  is '����';
comment on column CLM.TB_CRD_CC_INFO.credit_limit
  is '���ö��';
comment on column CLM.TB_CRD_CC_INFO.temp_limit
  is '��ʱ���';
comment on column CLM.TB_CRD_CC_INFO.temp_limit_begin_date
  is '��ʱ��ȿ�ʼ����';
comment on column CLM.TB_CRD_CC_INFO.temp_limit_end_date
  is '��ʱ��Ƚ�������';
comment on column CLM.TB_CRD_CC_INFO.cash_limit_rt
  is 'ȡ�ֶ�ȱ���';
comment on column CLM.TB_CRD_CC_INFO.ovrlmt_rate
  is '��Ȩ���ޱ���';
comment on column CLM.TB_CRD_CC_INFO.loan_limit_rt
  is '����ڷ��ڶ�ȱ���';
comment on column CLM.TB_CRD_CC_INFO.curr_bal
  is '��ǰ���';
comment on column CLM.TB_CRD_CC_INFO.cash_bal
  is 'ȡ�����';
comment on column CLM.TB_CRD_CC_INFO.principal_bal
  is '�������';
comment on column CLM.TB_CRD_CC_INFO.loan_bal
  is '����ڷ������';
comment on column CLM.TB_CRD_CC_INFO.qual_grace_bal
  is 'ȫ��Ӧ�����';
comment on column CLM.TB_CRD_CC_INFO.actual_payment_amt
  is '����ʵ�ʻ�����';
comment on column CLM.TB_CRD_CC_INFO.charge_off_amt
  is '�������';
comment on column CLM.TB_CRD_CC_INFO.unstmt_bal
  is 'δ���˵����';
comment on column CLM.TB_CRD_CC_INFO.ctd_reail_prin_bal
  is '�������ѱ������';
comment on column CLM.TB_CRD_CC_INFO.stmt_reail_prin_bal
  is '�ѳ��˵����ѱ������';
comment on column CLM.TB_CRD_CC_INFO.ctd_cash_prin_bal
  is '����ȡ�ֱ������';
comment on column CLM.TB_CRD_CC_INFO.stmt_cash_prin_bal
  is '�ѳ��˵�ȡ�ֱ������';
comment on column CLM.TB_CRD_CC_INFO.ctd_loan_prin_bal
  is '���ڷ���Ӧ���������';
comment on column CLM.TB_CRD_CC_INFO.stmt_loan_prin_bal
  is '�ѳ��˵�����Ӧ���������';
comment on column CLM.TB_CRD_CC_INFO.large_loan_bal_xfrout
  is '�����������';
comment on column CLM.TB_CRD_CC_INFO.unmatch_db_amt
  is 'δƥ���ǽ��';
comment on column CLM.TB_CRD_CC_INFO.unmatch_cr_amt
  is 'δƥ����ǽ��';
comment on column CLM.TB_CRD_CC_INFO.overlimit_amt
  is '���޽��';
comment on column CLM.TB_CRD_CC_INFO.remain_grace_bal
  is '����Ƿ�����';
comment on column CLM.TB_CRD_CC_INFO.grace_days_full_ind
  is '�Ƿ�ȫ���';
comment on column CLM.TB_CRD_CC_INFO.org_num
  is '�������';
comment on column CLM.TB_CRD_CC_INFO.billing_cycle
  is '�˵�����';
comment on column CLM.TB_CRD_CC_INFO.create_time
  is '����ʱ��';
comment on column CLM.TB_CRD_CC_INFO.update_time
  is '����ʱ��';
alter table CLM.TB_CRD_CC_INFO
  add constraint PK_TB_CRD_CC_INFO primary key (ACCT_NUM)
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
prompt Creating table TB_CRD_CONTRACT
prompt ==============================
prompt
create table CLM.TB_CRD_CONTRACT
(
  contract_num          VARCHAR2(40) not null,
  approve_id            VARCHAR2(32),
  customer_num          VARCHAR2(40),
  product_num           VARCHAR2(10),
  currency_cd           VARCHAR2(10),
  exchange_rate         NUMBER(10,6),
  contract_amt          NUMBER(24,2),
  contract_used         NUMBER(24,2),
  contract_avi          NUMBER(24,2),
  contract_bal          NUMBER(24,2),
  begin_date            VARCHAR2(20),
  end_date              VARCHAR2(20),
  is_cycle              VARCHAR2(1),
  deposit_ratio         NUMBER(10,6),
  industry              VARCHAR2(10),
  guarantee_type        VARCHAR2(10),
  main_guarantee_type   VARCHAR2(10),
  guarantee_type_detail VARCHAR2(10),
  classify_result       VARCHAR2(20),
  close_date            VARCHAR2(20),
  contract_status       VARCHAR2(10),
  tran_date             VARCHAR2(20),
  tran_system           VARCHAR2(10),
  org_num               VARCHAR2(10),
  user_num              VARCHAR2(10),
  create_time           DATE,
  update_time           DATE
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
comment on table CLM.TB_CRD_CONTRACT
  is '��ͬ��Ϣ��';
comment on column CLM.TB_CRD_CONTRACT.contract_num
  is '��ͬ���';
comment on column CLM.TB_CRD_CONTRACT.approve_id
  is '����ID';
comment on column CLM.TB_CRD_CONTRACT.customer_num
  is '�ͻ����';
comment on column CLM.TB_CRD_CONTRACT.product_num
  is 'ҵ��Ʒ��';
comment on column CLM.TB_CRD_CONTRACT.currency_cd
  is '���֣�CD000019��';
comment on column CLM.TB_CRD_CONTRACT.exchange_rate
  is '����';
comment on column CLM.TB_CRD_CONTRACT.contract_amt
  is '��ͬ���';
comment on column CLM.TB_CRD_CONTRACT.contract_used
  is '��ͬ����';
comment on column CLM.TB_CRD_CONTRACT.contract_avi
  is '��ͬ����';
comment on column CLM.TB_CRD_CONTRACT.contract_bal
  is '��ͬ���';
comment on column CLM.TB_CRD_CONTRACT.begin_date
  is '��ͬ����';
comment on column CLM.TB_CRD_CONTRACT.end_date
  is '��ֹͬ��';
comment on column CLM.TB_CRD_CONTRACT.is_cycle
  is '�Ƿ��ѭ����CD000167��';
comment on column CLM.TB_CRD_CONTRACT.deposit_ratio
  is '��֤�����';
comment on column CLM.TB_CRD_CONTRACT.industry
  is 'Ͷ����ҵ���루CD000015��';
comment on column CLM.TB_CRD_CONTRACT.guarantee_type
  is '������ʽ��CD000100��';
comment on column CLM.TB_CRD_CONTRACT.main_guarantee_type
  is '��Ҫ������ʽ��CD000100��';
comment on column CLM.TB_CRD_CONTRACT.guarantee_type_detail
  is '������ʽ���ࣨCD000101��';
comment on column CLM.TB_CRD_CONTRACT.classify_result
  is '�弶��������CD000171��';
comment on column CLM.TB_CRD_CONTRACT.close_date
  is '�ս�����';
comment on column CLM.TB_CRD_CONTRACT.contract_status
  is '��ͬ״̬��CD000094��';
comment on column CLM.TB_CRD_CONTRACT.tran_date
  is '��������';
comment on column CLM.TB_CRD_CONTRACT.tran_system
  is '����ϵͳ';
comment on column CLM.TB_CRD_CONTRACT.org_num
  is '�������';
comment on column CLM.TB_CRD_CONTRACT.user_num
  is '������';
comment on column CLM.TB_CRD_CONTRACT.create_time
  is '����ʱ��';
comment on column CLM.TB_CRD_CONTRACT.update_time
  is '�޸�ʱ��';
alter table CLM.TB_CRD_CONTRACT
  add constraint P_KEY_13 primary key (CONTRACT_NUM)
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
prompt Creating table TB_CRD_CONTRACT_EVENT
prompt ====================================
prompt
create table CLM.TB_CRD_CONTRACT_EVENT
(
  tran_seq_sn           VARCHAR2(50) not null,
  op_type               VARCHAR2(2),
  contract_num          VARCHAR2(40),
  approve_id            VARCHAR2(32),
  customer_num          VARCHAR2(40),
  product_num           VARCHAR2(10),
  currency_cd           VARCHAR2(10),
  exchange_rate         NUMBER(10,6),
  contract_amt          NUMBER(24,2),
  contract_used         NUMBER(24,2),
  contract_avi          NUMBER(24,2),
  contract_bal          NUMBER(24,2),
  is_cycle              VARCHAR2(1),
  begin_date            VARCHAR2(20),
  end_date              VARCHAR2(20),
  deposit_ratio         NUMBER(10,6),
  industry              VARCHAR2(10),
  guarantee_type        VARCHAR2(10),
  main_guarantee_type   VARCHAR2(10),
  guarantee_type_detail VARCHAR2(10),
  classify_result       VARCHAR2(20),
  close_date            VARCHAR2(20),
  contract_status       VARCHAR2(10),
  tran_date             VARCHAR2(20),
  tran_system           VARCHAR2(10),
  org_num               VARCHAR2(10),
  user_num              VARCHAR2(10),
  create_time           DATE,
  update_time           DATE,
  biz_scene             VARCHAR2(2),
  biz_action            VARCHAR2(2)
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
comment on table CLM.TB_CRD_CONTRACT_EVENT
  is '�Ŵ�ʵʱ-��ͬ��Ϣ';
comment on column CLM.TB_CRD_CONTRACT_EVENT.tran_seq_sn
  is '������ˮ��';
comment on column CLM.TB_CRD_CONTRACT_EVENT.op_type
  is '�������ͣ�01 ����02 ���� 03ɾ����';
comment on column CLM.TB_CRD_CONTRACT_EVENT.contract_num
  is '��ͬ���';
comment on column CLM.TB_CRD_CONTRACT_EVENT.approve_id
  is '����ID';
comment on column CLM.TB_CRD_CONTRACT_EVENT.customer_num
  is '�ͻ����';
comment on column CLM.TB_CRD_CONTRACT_EVENT.product_num
  is 'ҵ��Ʒ��';
comment on column CLM.TB_CRD_CONTRACT_EVENT.currency_cd
  is '���֣�CD000019��';
comment on column CLM.TB_CRD_CONTRACT_EVENT.exchange_rate
  is '����';
comment on column CLM.TB_CRD_CONTRACT_EVENT.contract_amt
  is '��ͬ���';
comment on column CLM.TB_CRD_CONTRACT_EVENT.contract_used
  is '��ͬ����';
comment on column CLM.TB_CRD_CONTRACT_EVENT.contract_avi
  is '��ͬ����';
comment on column CLM.TB_CRD_CONTRACT_EVENT.contract_bal
  is '��ͬ���';
comment on column CLM.TB_CRD_CONTRACT_EVENT.is_cycle
  is '�Ƿ��ѭ����CD000167��';
comment on column CLM.TB_CRD_CONTRACT_EVENT.begin_date
  is '��ͬ����';
comment on column CLM.TB_CRD_CONTRACT_EVENT.end_date
  is '��ֹͬ��';
comment on column CLM.TB_CRD_CONTRACT_EVENT.deposit_ratio
  is '��֤�����';
comment on column CLM.TB_CRD_CONTRACT_EVENT.industry
  is 'Ͷ����ҵ���루CD000015��';
comment on column CLM.TB_CRD_CONTRACT_EVENT.guarantee_type
  is '������ʽ��CD000100��';
comment on column CLM.TB_CRD_CONTRACT_EVENT.main_guarantee_type
  is '��Ҫ������ʽ��CD000100��';
comment on column CLM.TB_CRD_CONTRACT_EVENT.guarantee_type_detail
  is '������ʽ���ࣨCD000101��';
comment on column CLM.TB_CRD_CONTRACT_EVENT.classify_result
  is '�弶��������CD000171��';
comment on column CLM.TB_CRD_CONTRACT_EVENT.close_date
  is '�ս�����';
comment on column CLM.TB_CRD_CONTRACT_EVENT.contract_status
  is '��ͬ״̬��CD000094��';
comment on column CLM.TB_CRD_CONTRACT_EVENT.tran_date
  is '��������';
comment on column CLM.TB_CRD_CONTRACT_EVENT.tran_system
  is '����ϵͳ';
comment on column CLM.TB_CRD_CONTRACT_EVENT.org_num
  is '�������';
comment on column CLM.TB_CRD_CONTRACT_EVENT.user_num
  is '������';
comment on column CLM.TB_CRD_CONTRACT_EVENT.create_time
  is '����ʱ��';
comment on column CLM.TB_CRD_CONTRACT_EVENT.update_time
  is '�޸�ʱ��';
comment on column CLM.TB_CRD_CONTRACT_EVENT.biz_scene
  is 'ҵ�񳡾�';
comment on column CLM.TB_CRD_CONTRACT_EVENT.biz_action
  is '���̽ڵ�';
alter table CLM.TB_CRD_CONTRACT_EVENT
  add constraint P_KEY_14 primary key (TRAN_SEQ_SN)
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
prompt Creating table TB_CRD_DETAIL
prompt ============================
prompt
create table CLM.TB_CRD_DETAIL
(
  crd_detail_num     VARCHAR2(32) not null,
  crd_main_num       VARCHAR2(40),
  crd_detail_prd     VARCHAR2(10),
  crd_product_type   VARCHAR2(6),
  crd_grant_org_num  VARCHAR2(5),
  customer_num       VARCHAR2(10),
  crd_admit_flag     VARCHAR2(10),
  currency_cd        VARCHAR2(3),
  exchange_rate      NUMBER(18,2),
  begin_date         VARCHAR2(20),
  end_date           VARCHAR2(20),
  limit_credit       NUMBER(24,2),
  limit_avi          NUMBER(24,2),
  limit_used         NUMBER(24,2),
  exp_credit         NUMBER(24,2),
  exp_used           NUMBER(24,2),
  exp_avi            NUMBER(24,2),
  limit_pre          NUMBER(24,2),
  exp_pre            NUMBER(24,2),
  limit_earmark      NUMBER(24,2),
  limit_earmark_used NUMBER(24,2),
  earmark_begin_date VARCHAR2(20),
  earmark_end_date   VARCHAR2(20),
  limit_frozen       NUMBER(24,2),
  exp_frozen         NUMBER(24,2),
  is_cycle           VARCHAR2(1),
  is_mix             VARCHAR2(1),
  mix_credit         NUMBER(18,2),
  mix_used           NUMBER(18,2),
  mixremark          VARCHAR2(250),
  close_date         VARCHAR2(20),
  close_reason       VARCHAR2(250),
  is_continue        VARCHAR2(1),
  tran_system        VARCHAR2(10),
  user_num           VARCHAR2(12),
  org_num            VARCHAR2(5),
  create_time        DATE,
  update_time        DATE
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
comment on table CLM.TB_CRD_DETAIL
  is '�����ϸ���ͻ�+������Ȳ�Ʒ+������';
comment on column CLM.TB_CRD_DETAIL.crd_detail_num
  is '������ȱ��';
comment on column CLM.TB_CRD_DETAIL.crd_main_num
  is '������ȱ��';
comment on column CLM.TB_CRD_DETAIL.crd_detail_prd
  is '�������Ʒ��';
comment on column CLM.TB_CRD_DETAIL.crd_product_type
  is '������ͣ�CD000211��';
comment on column CLM.TB_CRD_DETAIL.crd_grant_org_num
  is '���Ż�����';
comment on column CLM.TB_CRD_DETAIL.customer_num
  is '�ͻ����';
comment on column CLM.TB_CRD_DETAIL.crd_admit_flag
  is '�ͻ�׼��״̬ 0����ֹ 1��׼��';
comment on column CLM.TB_CRD_DETAIL.currency_cd
  is '����(CD000019)';
comment on column CLM.TB_CRD_DETAIL.exchange_rate
  is '����';
comment on column CLM.TB_CRD_DETAIL.begin_date
  is '�������';
comment on column CLM.TB_CRD_DETAIL.end_date
  is '���ֹ��';
comment on column CLM.TB_CRD_DETAIL.limit_credit
  is '���Ŷ��';
comment on column CLM.TB_CRD_DETAIL.limit_avi
  is '���ö��';
comment on column CLM.TB_CRD_DETAIL.limit_used
  is '���ö��';
comment on column CLM.TB_CRD_DETAIL.exp_credit
  is '���ų���';
comment on column CLM.TB_CRD_DETAIL.exp_used
  is '���ó���';
comment on column CLM.TB_CRD_DETAIL.exp_avi
  is '���ó���';
comment on column CLM.TB_CRD_DETAIL.limit_pre
  is '���ö��';
comment on column CLM.TB_CRD_DETAIL.exp_pre
  is 'Ԥռ�ó���';
comment on column CLM.TB_CRD_DETAIL.limit_earmark
  is '���ö��';
comment on column CLM.TB_CRD_DETAIL.limit_earmark_used
  is 'Ȧ�����ö��';
comment on column CLM.TB_CRD_DETAIL.earmark_begin_date
  is 'Ȧ�濪ʼ��';
comment on column CLM.TB_CRD_DETAIL.earmark_end_date
  is 'Ȧ�浽����';
comment on column CLM.TB_CRD_DETAIL.limit_frozen
  is '������';
comment on column CLM.TB_CRD_DETAIL.exp_frozen
  is '���᳨��';
comment on column CLM.TB_CRD_DETAIL.is_cycle
  is '�Ƿ��ѭ��';
comment on column CLM.TB_CRD_DETAIL.is_mix
  is '�Ƿ�ɴ���';
comment on column CLM.TB_CRD_DETAIL.mixremark
  is '����˵��';
comment on column CLM.TB_CRD_DETAIL.close_date
  is '�ս�����';
comment on column CLM.TB_CRD_DETAIL.close_reason
  is '�ս�ԭ��';
comment on column CLM.TB_CRD_DETAIL.is_continue
  is '������־';
comment on column CLM.TB_CRD_DETAIL.tran_system
  is '����ϵͳ';
comment on column CLM.TB_CRD_DETAIL.user_num
  is '������';
comment on column CLM.TB_CRD_DETAIL.org_num
  is '�������';
comment on column CLM.TB_CRD_DETAIL.create_time
  is '����ʱ��';
comment on column CLM.TB_CRD_DETAIL.update_time
  is '�޸�ʱ��';
create unique index CLM.UQ_CRD_DETAIL on CLM.TB_CRD_DETAIL (CRD_DETAIL_PRD, CRD_GRANT_ORG_NUM, CUSTOMER_NUM)
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
alter table CLM.TB_CRD_DETAIL
  add constraint P_KEY_15 primary key (CRD_DETAIL_NUM)
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
prompt Creating table TB_CRD_DETAIL_HS
prompt ===============================
prompt
create table CLM.TB_CRD_DETAIL_HS
(
  statis_id          VARCHAR2(32) not null,
  crd_detail_num     VARCHAR2(32),
  crd_main_num       VARCHAR2(40),
  crd_detail_prd     VARCHAR2(10),
  crd_product_type   VARCHAR2(6) not null,
  crd_grant_org_num  VARCHAR2(12),
  customer_num       VARCHAR2(40),
  crd_admit_flag     VARCHAR2(10),
  currency_cd        VARCHAR2(10),
  exchange_rate      NUMBER(24,2),
  begin_date         VARCHAR2(20),
  end_date           VARCHAR2(20),
  limit_credit       NUMBER(24,2),
  limit_avi          NUMBER(24,2),
  limit_used         NUMBER(24,2),
  exp_credit         NUMBER(24,2),
  exp_used           NUMBER(24,2),
  exp_avi            NUMBER(24,2),
  limit_pre          NUMBER(24,2),
  exp_pre            NUMBER(24,2),
  limit_earmark      NUMBER(24,2),
  earmark_begin_date NUMBER(24,2),
  earmark_end_date   VARCHAR2(20),
  limit_frozen       NUMBER(24,2),
  exp_frozen         NUMBER(24,2),
  is_cycle           VARCHAR2(1),
  is_mix             VARCHAR2(1),
  mixremark          VARCHAR2(250),
  close_date         VARCHAR2(20),
  close_reason       VARCHAR2(250),
  is_continue        VARCHAR2(1),
  tran_system        VARCHAR2(10) not null,
  user_num           VARCHAR2(12),
  org_num            VARCHAR2(12),
  year               VARCHAR2(6),
  month              VARCHAR2(2),
  date               VARCHAR2(2),
  create_time        DATE,
  update_time        DATE
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
comment on table CLM.TB_CRD_DETAIL_HS
  is '�����ϸ��-��ʷ';
comment on column CLM.TB_CRD_DETAIL_HS.statis_id
  is 'ͳ��ID';
comment on column CLM.TB_CRD_DETAIL_HS.crd_detail_num
  is '������ȱ��';
comment on column CLM.TB_CRD_DETAIL_HS.crd_main_num
  is '������ȱ��';
comment on column CLM.TB_CRD_DETAIL_HS.crd_detail_prd
  is '������Ȳ�Ʒ';
comment on column CLM.TB_CRD_DETAIL_HS.crd_product_type
  is '������ͣ�CD000211��';
comment on column CLM.TB_CRD_DETAIL_HS.crd_grant_org_num
  is '���Ż�����';
comment on column CLM.TB_CRD_DETAIL_HS.customer_num
  is '�ͻ����';
comment on column CLM.TB_CRD_DETAIL_HS.crd_admit_flag
  is '�ͻ�׼��״̬ 0����ֹ 1��׼��';
comment on column CLM.TB_CRD_DETAIL_HS.currency_cd
  is '����';
comment on column CLM.TB_CRD_DETAIL_HS.exchange_rate
  is '����';
comment on column CLM.TB_CRD_DETAIL_HS.begin_date
  is '�������';
comment on column CLM.TB_CRD_DETAIL_HS.end_date
  is '���ֹ��';
comment on column CLM.TB_CRD_DETAIL_HS.limit_credit
  is '���Ŷ��';
comment on column CLM.TB_CRD_DETAIL_HS.limit_avi
  is '���ö��';
comment on column CLM.TB_CRD_DETAIL_HS.limit_used
  is '���ö��';
comment on column CLM.TB_CRD_DETAIL_HS.exp_credit
  is '���ų���';
comment on column CLM.TB_CRD_DETAIL_HS.exp_used
  is '���ó���';
comment on column CLM.TB_CRD_DETAIL_HS.exp_avi
  is '���ó���';
comment on column CLM.TB_CRD_DETAIL_HS.limit_pre
  is '���ö��';
comment on column CLM.TB_CRD_DETAIL_HS.exp_pre
  is 'Ԥռ�ó���';
comment on column CLM.TB_CRD_DETAIL_HS.limit_earmark
  is 'Ȧ����';
comment on column CLM.TB_CRD_DETAIL_HS.earmark_begin_date
  is 'Ȧ�濪ʼ��';
comment on column CLM.TB_CRD_DETAIL_HS.earmark_end_date
  is 'Ȧ�浽����';
comment on column CLM.TB_CRD_DETAIL_HS.limit_frozen
  is '������';
comment on column CLM.TB_CRD_DETAIL_HS.exp_frozen
  is '���᳨��';
comment on column CLM.TB_CRD_DETAIL_HS.is_cycle
  is '�Ƿ��ѭ��';
comment on column CLM.TB_CRD_DETAIL_HS.is_mix
  is '�Ƿ�ɴ���';
comment on column CLM.TB_CRD_DETAIL_HS.mixremark
  is '����˵��';
comment on column CLM.TB_CRD_DETAIL_HS.close_date
  is '�ս�����';
comment on column CLM.TB_CRD_DETAIL_HS.close_reason
  is '�ս�ԭ��';
comment on column CLM.TB_CRD_DETAIL_HS.is_continue
  is '������־';
comment on column CLM.TB_CRD_DETAIL_HS.tran_system
  is '����ϵͳ';
comment on column CLM.TB_CRD_DETAIL_HS.user_num
  is '������';
comment on column CLM.TB_CRD_DETAIL_HS.org_num
  is '�������';
comment on column CLM.TB_CRD_DETAIL_HS.year
  is '���';
comment on column CLM.TB_CRD_DETAIL_HS.month
  is '�·�';
alter table CLM.TB_CRD_DETAIL_HS
  add constraint PK_TB_CRD_DETAIL_HS primary key (STATIS_ID)
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
prompt Creating table TB_CRD_GRANTING_SERIAL
prompt =====================================
prompt
create table CLM.TB_CRD_GRANTING_SERIAL
(
  granting_serial_id VARCHAR2(32) not null,
  tran_seq_sn        VARCHAR2(32) not null,
  tran_date          VARCHAR2(20),
  busi_deal_num      VARCHAR2(40),
  tran_type_cd       VARCHAR2(2),
  crd_grant_org_num  VARCHAR2(5),
  customer_num       VARCHAR2(10),
  crd_detail_prd     VARCHAR2(10),
  crd_detail_num     VARCHAR2(40) not null,
  crd_currency_cd    VARCHAR2(3),
  crd_detail_amt     NUMBER(24,2),
  crd_eark_amt       NUMBER(24,2),
  crd_begin_date     VARCHAR2(20),
  crd_end_date       VARCHAR2(20),
  crd_status         VARCHAR2(2),
  crd_admit_flag     VARCHAR2(2),
  tran_system        VARCHAR2(5),
  user_num           VARCHAR2(12),
  create_time        DATE,
  update_time        DATE
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
comment on table CLM.TB_CRD_GRANTING_SERIAL
  is '���������ˮ';
comment on column CLM.TB_CRD_GRANTING_SERIAL.granting_serial_id
  is '������ˮid';
comment on column CLM.TB_CRD_GRANTING_SERIAL.tran_seq_sn
  is '������ˮ��';
comment on column CLM.TB_CRD_GRANTING_SERIAL.tran_date
  is '��������';
comment on column CLM.TB_CRD_GRANTING_SERIAL.busi_deal_num
  is 'ҵ����';
comment on column CLM.TB_CRD_GRANTING_SERIAL.tran_type_cd
  is '��������';
comment on column CLM.TB_CRD_GRANTING_SERIAL.crd_grant_org_num
  is '�������';
comment on column CLM.TB_CRD_GRANTING_SERIAL.customer_num
  is '�ͻ����';
comment on column CLM.TB_CRD_GRANTING_SERIAL.crd_detail_prd
  is '��Ȳ�Ʒ��';
comment on column CLM.TB_CRD_GRANTING_SERIAL.crd_detail_num
  is '��ȱ��';
comment on column CLM.TB_CRD_GRANTING_SERIAL.crd_currency_cd
  is '����(CD000019)';
comment on column CLM.TB_CRD_GRANTING_SERIAL.crd_detail_amt
  is '���Ŷ��';
comment on column CLM.TB_CRD_GRANTING_SERIAL.crd_eark_amt
  is 'Ȧ����';
comment on column CLM.TB_CRD_GRANTING_SERIAL.crd_begin_date
  is '��ʼ����';
comment on column CLM.TB_CRD_GRANTING_SERIAL.crd_end_date
  is '��������';
comment on column CLM.TB_CRD_GRANTING_SERIAL.crd_status
  is '���״̬��01 ���� 02 ���ᣩ';
comment on column CLM.TB_CRD_GRANTING_SERIAL.crd_admit_flag
  is '�ͻ�׼��';
comment on column CLM.TB_CRD_GRANTING_SERIAL.tran_system
  is '����ϵͳ';
comment on column CLM.TB_CRD_GRANTING_SERIAL.user_num
  is '������';
comment on column CLM.TB_CRD_GRANTING_SERIAL.create_time
  is '����ʱ��';
comment on column CLM.TB_CRD_GRANTING_SERIAL.update_time
  is '�޸�ʱ��';
alter table CLM.TB_CRD_GRANTING_SERIAL
  add constraint P_KEY_21 primary key (GRANTING_SERIAL_ID)
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
prompt Creating table TB_CRD_MAIN
prompt ==========================
prompt
create table CLM.TB_CRD_MAIN
(
  crd_main_num       VARCHAR2(40) not null,
  crd_main_prd       VARCHAR2(10),
  crd_product_type   VARCHAR2(6),
  crd_grant_org_num  VARCHAR2(5),
  customer_num       VARCHAR2(10),
  currency_cd        VARCHAR2(3),
  exchange_rate      NUMBER(24,2),
  credit_status      VARCHAR2(10),
  limit_credit       NUMBER(24,2),
  limit_used         NUMBER(24,2),
  limit_avi          NUMBER(24,2),
  exp_credit         NUMBER(24,2),
  exp_used           NUMBER(24,2),
  exp_avi            NUMBER(24,2),
  limit_pre          NUMBER(24,2),
  exp_pre            NUMBER(24,2),
  limit_frozen       NUMBER(24,2),
  exp_frozen         NUMBER(24,2),
  begin_date         VARCHAR2(20),
  end_date           VARCHAR2(20),
  frozen_date        VARCHAR2(20),
  over_date          VARCHAR2(20),
  limit_earmark      NUMBER(24,2),
  limit_earmark_used NUMBER(24,2),
  earmark_begin_date VARCHAR2(20),
  earmark_end_date   VARCHAR2(20),
  tran_system        VARCHAR2(10),
  org_num            VARCHAR2(5),
  user_num           VARCHAR2(10),
  create_time        DATE,
  update_time        DATE
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
comment on table CLM.TB_CRD_MAIN
  is '��������ͻ�+������Ȳ�Ʒ+������';
comment on column CLM.TB_CRD_MAIN.crd_main_num
  is '��ȱ��';
comment on column CLM.TB_CRD_MAIN.crd_main_prd
  is '��Ȳ�Ʒ���';
comment on column CLM.TB_CRD_MAIN.crd_product_type
  is '������ͣ�CD000211��';
comment on column CLM.TB_CRD_MAIN.crd_grant_org_num
  is '���Ż���';
comment on column CLM.TB_CRD_MAIN.customer_num
  is '�ͻ����';
comment on column CLM.TB_CRD_MAIN.currency_cd
  is '����(CD000019)';
comment on column CLM.TB_CRD_MAIN.exchange_rate
  is '����';
comment on column CLM.TB_CRD_MAIN.credit_status
  is '���״̬';
comment on column CLM.TB_CRD_MAIN.limit_credit
  is '���Ŷ��';
comment on column CLM.TB_CRD_MAIN.limit_used
  is '���ö��';
comment on column CLM.TB_CRD_MAIN.limit_avi
  is '���ö��';
comment on column CLM.TB_CRD_MAIN.exp_credit
  is '���ų���';
comment on column CLM.TB_CRD_MAIN.exp_used
  is '���ó���';
comment on column CLM.TB_CRD_MAIN.exp_avi
  is '���ó���';
comment on column CLM.TB_CRD_MAIN.limit_pre
  is '���ö��';
comment on column CLM.TB_CRD_MAIN.exp_pre
  is 'Ԥռ�ó���';
comment on column CLM.TB_CRD_MAIN.limit_frozen
  is '������';
comment on column CLM.TB_CRD_MAIN.exp_frozen
  is '���᳨��';
comment on column CLM.TB_CRD_MAIN.begin_date
  is '�����Ч��';
comment on column CLM.TB_CRD_MAIN.end_date
  is '��ȵ�����';
comment on column CLM.TB_CRD_MAIN.frozen_date
  is '��������';
comment on column CLM.TB_CRD_MAIN.over_date
  is '��ֹ����';
comment on column CLM.TB_CRD_MAIN.limit_earmark
  is 'Ȧ����';
comment on column CLM.TB_CRD_MAIN.limit_earmark_used
  is 'Ȧ�����ö��';
comment on column CLM.TB_CRD_MAIN.earmark_begin_date
  is 'Ȧ�濪ʼ��';
comment on column CLM.TB_CRD_MAIN.earmark_end_date
  is 'Ȧ�浽����';
comment on column CLM.TB_CRD_MAIN.tran_system
  is '����ϵͳ';
comment on column CLM.TB_CRD_MAIN.org_num
  is '�������';
comment on column CLM.TB_CRD_MAIN.user_num
  is '������';
comment on column CLM.TB_CRD_MAIN.create_time
  is '����ʱ��';
comment on column CLM.TB_CRD_MAIN.update_time
  is '�޸�ʱ��';
alter table CLM.TB_CRD_MAIN
  add constraint P_KEY_22 primary key (CRD_MAIN_NUM)
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
prompt Creating table TB_CRD_MAIN_HS
prompt =============================
prompt
create table CLM.TB_CRD_MAIN_HS
(
  statis_id         VARCHAR2(32) not null,
  crd_main_num      VARCHAR2(40),
  crd_main_prd      VARCHAR2(10),
  crd_product_type  VARCHAR2(6) not null,
  crd_grant_org_num VARCHAR2(12),
  customer_num      VARCHAR2(40),
  currency_cd       VARCHAR2(10),
  exchange_rate     NUMBER(18,2),
  credit_status     VARCHAR2(10),
  limit_credit      NUMBER(18,2),
  limit_used        NUMBER(18,2),
  limit_avi         NUMBER(18,2),
  exp_credit        NUMBER(18,2),
  exp_used          NUMBER(18,2),
  exp_avi           NUMBER(18,2),
  limit_pre         NUMBER(18,2),
  exp_pre           NUMBER(18,2),
  limit_frozen      NUMBER(18,2),
  exp_frozen        NUMBER(18,2),
  begin_date        VARCHAR2(20),
  end_date          VARCHAR2(20),
  frozen_date       VARCHAR2(20),
  over_date         VARCHAR2(20),
  tran_system       VARCHAR2(10) not null,
  org_num           VARCHAR2(12),
  user_num          VARCHAR2(12),
  year              NUMBER(5),
  month             NUMBER(2),
  date              NUMBER(2),
  create_time       DATE,
  update_time       DATE
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
comment on table CLM.TB_CRD_MAIN_HS
  is '�������-��ʷ';
comment on column CLM.TB_CRD_MAIN_HS.statis_id
  is 'ͳ��ID';
comment on column CLM.TB_CRD_MAIN_HS.crd_main_num
  is '��ȶ������';
comment on column CLM.TB_CRD_MAIN_HS.crd_main_prd
  is '��ȶ�����Ʒ';
comment on column CLM.TB_CRD_MAIN_HS.crd_product_type
  is '������ͣ�CD000211��';
comment on column CLM.TB_CRD_MAIN_HS.crd_grant_org_num
  is '���Ż���';
comment on column CLM.TB_CRD_MAIN_HS.customer_num
  is '�ͻ����';
comment on column CLM.TB_CRD_MAIN_HS.currency_cd
  is '����';
comment on column CLM.TB_CRD_MAIN_HS.exchange_rate
  is '����';
comment on column CLM.TB_CRD_MAIN_HS.credit_status
  is '���״̬';
comment on column CLM.TB_CRD_MAIN_HS.limit_credit
  is '���Ŷ��';
comment on column CLM.TB_CRD_MAIN_HS.limit_used
  is '���ö��';
comment on column CLM.TB_CRD_MAIN_HS.limit_avi
  is '���ö��';
comment on column CLM.TB_CRD_MAIN_HS.exp_credit
  is '���ų���';
comment on column CLM.TB_CRD_MAIN_HS.exp_used
  is '���ó���';
comment on column CLM.TB_CRD_MAIN_HS.exp_avi
  is '���ó���';
comment on column CLM.TB_CRD_MAIN_HS.limit_pre
  is '���ö��';
comment on column CLM.TB_CRD_MAIN_HS.exp_pre
  is 'Ԥռ�ó���';
comment on column CLM.TB_CRD_MAIN_HS.limit_frozen
  is '������';
comment on column CLM.TB_CRD_MAIN_HS.exp_frozen
  is '���᳨��';
comment on column CLM.TB_CRD_MAIN_HS.begin_date
  is '�����Ч��';
comment on column CLM.TB_CRD_MAIN_HS.end_date
  is '��ȵ�����';
comment on column CLM.TB_CRD_MAIN_HS.frozen_date
  is '��������';
comment on column CLM.TB_CRD_MAIN_HS.over_date
  is '��ֹ����';
comment on column CLM.TB_CRD_MAIN_HS.tran_system
  is '����ϵͳ';
comment on column CLM.TB_CRD_MAIN_HS.org_num
  is '�������';
comment on column CLM.TB_CRD_MAIN_HS.user_num
  is '������';
comment on column CLM.TB_CRD_MAIN_HS.year
  is '���';
comment on column CLM.TB_CRD_MAIN_HS.month
  is '�·�';
comment on column CLM.TB_CRD_MAIN_HS.create_time
  is '����ʱ��';
comment on column CLM.TB_CRD_MAIN_HS.update_time
  is '�޸�ʱ��';
alter table CLM.TB_CRD_MAIN_HS
  add constraint P_KEY_23 primary key (STATIS_ID)
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
prompt Creating table TB_CRD_PROJECT
prompt =============================
prompt
create table CLM.TB_CRD_PROJECT
(
  project_num         VARCHAR2(40) not null,
  customer_num        VARCHAR2(40),
  crd_main_prd        VARCHAR2(40),
  crd_main_num        VARCHAR2(40),
  crd_detail_prd      VARCHAR2(10),
  crd_detail_num      VARCHAR2(40),
  project_name        VARCHAR2(200),
  project_type        VARCHAR2(10),
  currency_cd         VARCHAR2(10),
  total_amt           NUMBER(18,2),
  used_amt            NUMBER(18,2),
  avi_amt             NUMBER(18,2),
  limit_control_type  VARCHAR2(10),
  agreement_term      NUMBER(18,2),
  agreement_term_unit VARCHAR2(10),
  project_status      VARCHAR2(10),
  tran_date           VARCHAR2(20),
  tran_system         VARCHAR2(10),
  user_num            VARCHAR2(10),
  org_num             VARCHAR2(10),
  create_time         DATE,
  update_time         DATE
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
comment on table CLM.TB_CRD_PROJECT
  is '��ĿЭ���';
comment on column CLM.TB_CRD_PROJECT.project_num
  is '��ĿЭ����';
comment on column CLM.TB_CRD_PROJECT.customer_num
  is '�ͻ����';
comment on column CLM.TB_CRD_PROJECT.crd_main_prd
  is '��ȶ�����Ʒ��';
comment on column CLM.TB_CRD_PROJECT.crd_main_num
  is '����������';
comment on column CLM.TB_CRD_PROJECT.crd_detail_prd
  is '���������Ʒ��';
comment on column CLM.TB_CRD_PROJECT.crd_detail_num
  is '����������';
comment on column CLM.TB_CRD_PROJECT.project_name
  is '��Ŀ����';
comment on column CLM.TB_CRD_PROJECT.project_type
  is '��Ŀ���ͣ�CD000172��';
comment on column CLM.TB_CRD_PROJECT.currency_cd
  is '����';
comment on column CLM.TB_CRD_PROJECT.total_amt
  is '�ܽ��';
comment on column CLM.TB_CRD_PROJECT.used_amt
  is '���ý��';
comment on column CLM.TB_CRD_PROJECT.avi_amt
  is '���ý��';
comment on column CLM.TB_CRD_PROJECT.limit_control_type
  is '��ȿ��Ʒ�ʽ��CD000173��';
comment on column CLM.TB_CRD_PROJECT.agreement_term
  is 'Э������';
comment on column CLM.TB_CRD_PROJECT.agreement_term_unit
  is 'Э�����޵�λ��CD000169��';
comment on column CLM.TB_CRD_PROJECT.project_status
  is '��Ŀ״̬';
comment on column CLM.TB_CRD_PROJECT.tran_date
  is '��������';
comment on column CLM.TB_CRD_PROJECT.tran_system
  is '����ϵͳ';
comment on column CLM.TB_CRD_PROJECT.user_num
  is '�ͻ�����';
comment on column CLM.TB_CRD_PROJECT.org_num
  is '�������';
comment on column CLM.TB_CRD_PROJECT.create_time
  is '����ʱ��';
comment on column CLM.TB_CRD_PROJECT.update_time
  is '�޸�ʱ��';
alter table CLM.TB_CRD_PROJECT
  add constraint P_KEY_24 primary key (PROJECT_NUM)
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
prompt Creating table TB_CRD_PROJECT_EVENT
prompt ===================================
prompt
create table CLM.TB_CRD_PROJECT_EVENT
(
  tran_seq_sn         VARCHAR2(50) not null,
  op_type             VARCHAR2(2),
  project_num         VARCHAR2(40),
  customer_num        VARCHAR2(40),
  crd_main_prd        VARCHAR2(40),
  crd_main_num        VARCHAR2(40),
  crd_detail_prd      VARCHAR2(10),
  crd_detail_num      VARCHAR2(40),
  project_name        VARCHAR2(200),
  project_type        VARCHAR2(10),
  currency_cd         VARCHAR2(10),
  total_amt           NUMBER(18,2),
  used_amt            NUMBER(18,2),
  avi_amt             NUMBER(18,2),
  limit_control_type  VARCHAR2(10),
  agreement_term      NUMBER(18,2),
  agreement_term_unit VARCHAR2(10),
  project_status      VARCHAR2(10),
  tran_date           VARCHAR2(20),
  tran_system         VARCHAR2(10),
  user_num            VARCHAR2(10),
  org_num             VARCHAR2(10),
  create_time         DATE,
  update_time         DATE,
  biz_scene           VARCHAR2(2),
  biz_action          VARCHAR2(2)
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
comment on table CLM.TB_CRD_PROJECT_EVENT
  is '�Ŵ�ʵʱ-��ĿЭ���';
comment on column CLM.TB_CRD_PROJECT_EVENT.tran_seq_sn
  is '������ˮ��';
comment on column CLM.TB_CRD_PROJECT_EVENT.op_type
  is '�������ͣ�01 ����02 ���� 03ɾ����';
comment on column CLM.TB_CRD_PROJECT_EVENT.project_num
  is '��ĿЭ����';
comment on column CLM.TB_CRD_PROJECT_EVENT.customer_num
  is '�ͻ����';
comment on column CLM.TB_CRD_PROJECT_EVENT.crd_main_num
  is '����������';
comment on column CLM.TB_CRD_PROJECT_EVENT.crd_detail_prd
  is '���������Ʒ��';
comment on column CLM.TB_CRD_PROJECT_EVENT.crd_detail_num
  is '����������';
comment on column CLM.TB_CRD_PROJECT_EVENT.project_name
  is '��ĿЭ������';
comment on column CLM.TB_CRD_PROJECT_EVENT.project_type
  is '��Ŀ���ͣ�CD000172��';
comment on column CLM.TB_CRD_PROJECT_EVENT.currency_cd
  is '����';
comment on column CLM.TB_CRD_PROJECT_EVENT.total_amt
  is '�ܽ��';
comment on column CLM.TB_CRD_PROJECT_EVENT.used_amt
  is '���ý��';
comment on column CLM.TB_CRD_PROJECT_EVENT.avi_amt
  is '���ý��';
comment on column CLM.TB_CRD_PROJECT_EVENT.limit_control_type
  is '��ȿ��Ʒ�ʽ��CD000173��';
comment on column CLM.TB_CRD_PROJECT_EVENT.agreement_term
  is 'Э������';
comment on column CLM.TB_CRD_PROJECT_EVENT.agreement_term_unit
  is 'Э�����޵�λ��CD000169��';
comment on column CLM.TB_CRD_PROJECT_EVENT.project_status
  is '��Ŀ״̬';
comment on column CLM.TB_CRD_PROJECT_EVENT.tran_date
  is '��������';
comment on column CLM.TB_CRD_PROJECT_EVENT.tran_system
  is '����ϵͳ';
comment on column CLM.TB_CRD_PROJECT_EVENT.user_num
  is '�ͻ�����';
comment on column CLM.TB_CRD_PROJECT_EVENT.org_num
  is '�������';
comment on column CLM.TB_CRD_PROJECT_EVENT.create_time
  is '����ʱ��';
comment on column CLM.TB_CRD_PROJECT_EVENT.update_time
  is '�޸�ʱ��';
comment on column CLM.TB_CRD_PROJECT_EVENT.biz_scene
  is 'ҵ�񳡾�';
comment on column CLM.TB_CRD_PROJECT_EVENT.biz_action
  is '���̽ڵ�';
alter table CLM.TB_CRD_PROJECT_EVENT
  add constraint PK_CRD_PROJECT_EVENT primary key (TRAN_SEQ_SN)
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
prompt Creating table TB_CRD_RECOVERY_EVENT
prompt ====================================
prompt
create table CLM.TB_CRD_RECOVERY_EVENT
(
  tran_seq_sn VARCHAR2(32) not null,
  op_type     VARCHAR2(2),
  summary_num VARCHAR2(32),
  date_source VARCHAR2(1),
  currency_cd NUMBER(18,2),
  repay_amt   NUMBER(18,2),
  user_num    VARCHAR2(40),
  org_num     VARCHAR2(40),
  repay_date  VARCHAR2(20),
  create_time TIMESTAMP(6),
  update_time TIMESTAMP(6),
  biz_scene   VARCHAR2(2),
  biz_action  VARCHAR2(2)
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
comment on table CLM.TB_CRD_RECOVERY_EVENT
  is '�Ŵ�ʵʱ-�������Ϣ';
comment on column CLM.TB_CRD_RECOVERY_EVENT.tran_seq_sn
  is '������ˮ��';
comment on column CLM.TB_CRD_RECOVERY_EVENT.op_type
  is '�������ͣ�01 ����02 ���� 03ɾ����';
comment on column CLM.TB_CRD_RECOVERY_EVENT.summary_num
  is '��ݱ��';
comment on column CLM.TB_CRD_RECOVERY_EVENT.date_source
  is '������Դ';
comment on column CLM.TB_CRD_RECOVERY_EVENT.currency_cd
  is '����';
comment on column CLM.TB_CRD_RECOVERY_EVENT.repay_amt
  is '�����';
comment on column CLM.TB_CRD_RECOVERY_EVENT.user_num
  is '������';
comment on column CLM.TB_CRD_RECOVERY_EVENT.org_num
  is '�������';
comment on column CLM.TB_CRD_RECOVERY_EVENT.repay_date
  is '��������';
comment on column CLM.TB_CRD_RECOVERY_EVENT.create_time
  is '����ʱ��';
comment on column CLM.TB_CRD_RECOVERY_EVENT.update_time
  is '�޸�ʱ��';
comment on column CLM.TB_CRD_RECOVERY_EVENT.biz_scene
  is 'ҵ�񳡾�';
comment on column CLM.TB_CRD_RECOVERY_EVENT.biz_action
  is '���̽ڵ�';
alter table CLM.TB_CRD_RECOVERY_EVENT
  add constraint TB_CRD_RECOVERY_EVENT_PK primary key (TRAN_SEQ_SN)
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
prompt Creating table TB_CRD_STATIS
prompt ============================
prompt
create table CLM.TB_CRD_STATIS
(
  statis_id          VARCHAR2(50) not null,
  customer_num       VARCHAR2(10),
  currency_cd        VARCHAR2(3),
  approve_count      NUMBER(18),
  approve_exp_amount NUMBER(24,2),
  credit_exp_balance NUMBER(24,2),
  loan_exp_balance   NUMBER(24,2),
  limit_credit       NUMBER(24,2),
  limit_avi          NUMBER(24,2),
  limit_used         NUMBER(24,2),
  exp_used           NUMBER(24,2),
  exp_avi            NUMBER(24,2),
  product_num        VARCHAR2(10),
  crd_detail_prd     VARCHAR2(10),
  org_num            VARCHAR2(5),
  industry           VARCHAR2(5),
  customer_type      VARCHAR2(1),
  guarantee_type     VARCHAR2(10),
  unit_scale         VARCHAR2(1),
  create_time        DATE,
  update_time        DATE
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
comment on table CLM.TB_CRD_STATIS
  is '���ͳ�Ʊ�ʵʱ��';
comment on column CLM.TB_CRD_STATIS.statis_id
  is 'ͳ��ID';
comment on column CLM.TB_CRD_STATIS.customer_num
  is '�ͻ����';
comment on column CLM.TB_CRD_STATIS.currency_cd
  is '����(CD000019)';
comment on column CLM.TB_CRD_STATIS.approve_count
  is '��������';
comment on column CLM.TB_CRD_STATIS.approve_exp_amount
  is '�������ڽ��';
comment on column CLM.TB_CRD_STATIS.credit_exp_balance
  is '���ų������';
comment on column CLM.TB_CRD_STATIS.loan_exp_balance
  is '��������';
comment on column CLM.TB_CRD_STATIS.limit_credit
  is '���Ŷ��';
comment on column CLM.TB_CRD_STATIS.limit_avi
  is '���ö��';
comment on column CLM.TB_CRD_STATIS.limit_used
  is '���ö��';
comment on column CLM.TB_CRD_STATIS.exp_used
  is '���ó���';
comment on column CLM.TB_CRD_STATIS.exp_avi
  is '���ó���';
comment on column CLM.TB_CRD_STATIS.product_num
  is 'ҵ��Ʒ��';
comment on column CLM.TB_CRD_STATIS.crd_detail_prd
  is '��Ȳ�Ʒ���';
comment on column CLM.TB_CRD_STATIS.org_num
  is '�������';
comment on column CLM.TB_CRD_STATIS.industry
  is '��ҵ(CD000015)';
comment on column CLM.TB_CRD_STATIS.customer_type
  is '�ͻ�����(CD000212)';
comment on column CLM.TB_CRD_STATIS.guarantee_type
  is '������ʽ��CD000100��';
comment on column CLM.TB_CRD_STATIS.unit_scale
  is '��ҵ��ģ��CD000020��';
comment on column CLM.TB_CRD_STATIS.create_time
  is '����ʱ��';
comment on column CLM.TB_CRD_STATIS.update_time
  is '�޸�ʱ��';
alter table CLM.TB_CRD_STATIS
  add constraint P_KEY_25 primary key (STATIS_ID)
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
prompt Creating table TB_CRD_STATIS_CRDPT
prompt ==================================
prompt
create table CLM.TB_CRD_STATIS_CRDPT
(
  statis_id          VARCHAR2(32) not null,
  approve_count      NUMBER(18),
  approve_exp_amount NUMBER(18,2),
  credit_exp_balance NUMBER(18,2),
  loan_exp_balance   NUMBER(18,2),
  limit_credit       NUMBER(18,2),
  limit_avi          NUMBER(18,2),
  limit_used         NUMBER(18,2),
  exp_used           NUMBER(18,2),
  exp_avi            NUMBER(18,2),
  crd_detail_prd     VARCHAR2(10),
  org_num            VARCHAR2(10),
  data_type          VARCHAR2(1),
  year               VARCHAR2(6),
  month              VARCHAR2(2),
  date               VARCHAR2(2),
  create_time        DATE,
  update_time        DATE
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
comment on table CLM.TB_CRD_STATIS_CRDPT
  is '���ͳ�Ʊ�-���Ʒ�֣���ʷ+ʵʱ��';
comment on column CLM.TB_CRD_STATIS_CRDPT.statis_id
  is 'ͳ��ID';
comment on column CLM.TB_CRD_STATIS_CRDPT.approve_count
  is '��������';
comment on column CLM.TB_CRD_STATIS_CRDPT.approve_exp_amount
  is '�������ڽ��';
comment on column CLM.TB_CRD_STATIS_CRDPT.credit_exp_balance
  is '���ų������';
comment on column CLM.TB_CRD_STATIS_CRDPT.loan_exp_balance
  is '��������';
comment on column CLM.TB_CRD_STATIS_CRDPT.limit_credit
  is '���Ŷ��';
comment on column CLM.TB_CRD_STATIS_CRDPT.limit_avi
  is '���ö��';
comment on column CLM.TB_CRD_STATIS_CRDPT.limit_used
  is '���ö��';
comment on column CLM.TB_CRD_STATIS_CRDPT.exp_used
  is '���ó���';
comment on column CLM.TB_CRD_STATIS_CRDPT.exp_avi
  is '���ó���';
comment on column CLM.TB_CRD_STATIS_CRDPT.crd_detail_prd
  is '��Ȳ�Ʒ���';
comment on column CLM.TB_CRD_STATIS_CRDPT.org_num
  is '�������';
comment on column CLM.TB_CRD_STATIS_CRDPT.data_type
  is '�������ͣ�1��ǰʵʱ���ݣ�2��ʷ���ݣ�';
comment on column CLM.TB_CRD_STATIS_CRDPT.year
  is '���';
comment on column CLM.TB_CRD_STATIS_CRDPT.month
  is '�·�';
comment on column CLM.TB_CRD_STATIS_CRDPT.create_time
  is '����ʱ��';
comment on column CLM.TB_CRD_STATIS_CRDPT.update_time
  is '�޸�ʱ��';
alter table CLM.TB_CRD_STATIS_CRDPT
  add constraint P_KEY_112 primary key (STATIS_ID)
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
prompt Creating table TB_CRD_STATIS_CSM
prompt ================================
prompt
create table CLM.TB_CRD_STATIS_CSM
(
  statis_id          VARCHAR2(32) not null,
  customer_num       VARCHAR2(40),
  approve_count      NUMBER(18),
  approve_exp_amount NUMBER(18,2),
  credit_exp_balance NUMBER(18,2),
  loan_exp_balance   NUMBER(18,2),
  limit_credit       NUMBER(18,2),
  limit_avi          NUMBER(18,2),
  limit_used         NUMBER(18,2),
  exp_used           NUMBER(18,2),
  exp_avi            NUMBER(18,2),
  org_num            VARCHAR2(10),
  create_time        DATE,
  update_time        DATE
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
comment on table CLM.TB_CRD_STATIS_CSM
  is '���ͳ�Ʊ�-�ͻ���ʵʱ��';
comment on column CLM.TB_CRD_STATIS_CSM.statis_id
  is 'ͳ��ID';
comment on column CLM.TB_CRD_STATIS_CSM.customer_num
  is '�ͻ����';
comment on column CLM.TB_CRD_STATIS_CSM.approve_count
  is '��������';
comment on column CLM.TB_CRD_STATIS_CSM.approve_exp_amount
  is '�������ڽ��';
comment on column CLM.TB_CRD_STATIS_CSM.credit_exp_balance
  is '���ų������';
comment on column CLM.TB_CRD_STATIS_CSM.loan_exp_balance
  is '��������';
comment on column CLM.TB_CRD_STATIS_CSM.limit_credit
  is '���Ŷ��';
comment on column CLM.TB_CRD_STATIS_CSM.limit_avi
  is '���ö��';
comment on column CLM.TB_CRD_STATIS_CSM.limit_used
  is '���ö��';
comment on column CLM.TB_CRD_STATIS_CSM.exp_used
  is '���ó���';
comment on column CLM.TB_CRD_STATIS_CSM.exp_avi
  is '���ó���';
comment on column CLM.TB_CRD_STATIS_CSM.org_num
  is '�������';
comment on column CLM.TB_CRD_STATIS_CSM.create_time
  is '����ʱ��';
comment on column CLM.TB_CRD_STATIS_CSM.update_time
  is '�޸�ʱ��';
alter table CLM.TB_CRD_STATIS_CSM
  add constraint P_KEY_26 primary key (STATIS_ID)
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
prompt Creating table TB_CRD_STATIS_CSM_HS
prompt ===================================
prompt
create table CLM.TB_CRD_STATIS_CSM_HS
(
  statis_id          VARCHAR2(32) not null,
  customer_num       VARCHAR2(40),
  approve_count      NUMBER(18),
  approve_exp_amount NUMBER(24,2),
  credit_exp_balance NUMBER(24,2),
  loan_exp_balance   NUMBER(24,2),
  limit_credit       NUMBER(24,2),
  limit_avi          NUMBER(24,2),
  limit_used         NUMBER(24,2),
  exp_used           NUMBER(24,2),
  exp_avi            NUMBER(24,2),
  org_num            VARCHAR2(10),
  year               VARCHAR2(6),
  month              VARCHAR2(2),
  date               VARCHAR2(2),
  create_time        DATE,
  update_time        DATE
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
comment on table CLM.TB_CRD_STATIS_CSM_HS
  is '���ͳ�Ʊ�-�ͻ�-��ʷ';
comment on column CLM.TB_CRD_STATIS_CSM_HS.statis_id
  is 'ͳ��ID';
comment on column CLM.TB_CRD_STATIS_CSM_HS.customer_num
  is '�ͻ����';
comment on column CLM.TB_CRD_STATIS_CSM_HS.approve_count
  is '��������';
comment on column CLM.TB_CRD_STATIS_CSM_HS.approve_exp_amount
  is '�������ڽ��';
comment on column CLM.TB_CRD_STATIS_CSM_HS.credit_exp_balance
  is '���ų������';
comment on column CLM.TB_CRD_STATIS_CSM_HS.loan_exp_balance
  is '��������';
comment on column CLM.TB_CRD_STATIS_CSM_HS.limit_credit
  is '���Ŷ��';
comment on column CLM.TB_CRD_STATIS_CSM_HS.limit_avi
  is '���ö��';
comment on column CLM.TB_CRD_STATIS_CSM_HS.limit_used
  is '���ö��';
comment on column CLM.TB_CRD_STATIS_CSM_HS.exp_used
  is '���ó���';
comment on column CLM.TB_CRD_STATIS_CSM_HS.exp_avi
  is '���ó���';
comment on column CLM.TB_CRD_STATIS_CSM_HS.org_num
  is '�������';
comment on column CLM.TB_CRD_STATIS_CSM_HS.year
  is '���';
comment on column CLM.TB_CRD_STATIS_CSM_HS.month
  is '�·�';
alter table CLM.TB_CRD_STATIS_CSM_HS
  add constraint P_KEY_113 primary key (STATIS_ID)
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
prompt Creating table TB_CRD_STATIS_CUSTYPE
prompt ====================================
prompt
create table CLM.TB_CRD_STATIS_CUSTYPE
(
  statis_id          VARCHAR2(32) not null,
  approve_count      NUMBER(18),
  approve_exp_amount NUMBER(18,2),
  credit_exp_balance NUMBER(18,2),
  loan_exp_balance   NUMBER(18,2),
  limit_credit       NUMBER(18,2),
  limit_avi          NUMBER(18,2),
  limit_used         NUMBER(18,2),
  exp_used           NUMBER(18,2),
  exp_avi            NUMBER(18,2),
  org_num            VARCHAR2(10),
  customer_type      VARCHAR2(10),
  data_type          VARCHAR2(1),
  year               VARCHAR2(6),
  month              VARCHAR2(2),
  date               VARCHAR2(2),
  create_time        DATE,
  update_time        DATE
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
comment on table CLM.TB_CRD_STATIS_CUSTYPE
  is '���ͳ�Ʊ�-�ͻ����ͣ���ʷ+ʵʱ��';
comment on column CLM.TB_CRD_STATIS_CUSTYPE.statis_id
  is 'ͳ��ID';
comment on column CLM.TB_CRD_STATIS_CUSTYPE.approve_count
  is '��������';
comment on column CLM.TB_CRD_STATIS_CUSTYPE.approve_exp_amount
  is '�������ڽ��';
comment on column CLM.TB_CRD_STATIS_CUSTYPE.credit_exp_balance
  is '���ų������';
comment on column CLM.TB_CRD_STATIS_CUSTYPE.loan_exp_balance
  is '��������';
comment on column CLM.TB_CRD_STATIS_CUSTYPE.limit_credit
  is '���Ŷ��';
comment on column CLM.TB_CRD_STATIS_CUSTYPE.limit_avi
  is '���ö��';
comment on column CLM.TB_CRD_STATIS_CUSTYPE.limit_used
  is '���ö��';
comment on column CLM.TB_CRD_STATIS_CUSTYPE.exp_used
  is '���ó���';
comment on column CLM.TB_CRD_STATIS_CUSTYPE.exp_avi
  is '���ó���';
comment on column CLM.TB_CRD_STATIS_CUSTYPE.org_num
  is '�������';
comment on column CLM.TB_CRD_STATIS_CUSTYPE.customer_type
  is '�ͻ�����';
comment on column CLM.TB_CRD_STATIS_CUSTYPE.data_type
  is '�������ͣ�1��ǰʵʱ���ݣ�2��ʷ���ݣ�';
comment on column CLM.TB_CRD_STATIS_CUSTYPE.year
  is '���';
comment on column CLM.TB_CRD_STATIS_CUSTYPE.month
  is '�·�';
comment on column CLM.TB_CRD_STATIS_CUSTYPE.create_time
  is '����ʱ��';
comment on column CLM.TB_CRD_STATIS_CUSTYPE.update_time
  is '�޸�ʱ��';
alter table CLM.TB_CRD_STATIS_CUSTYPE
  add constraint P_KEY_31 primary key (STATIS_ID)
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
prompt Creating table TB_CRD_STATIS_GTYPE
prompt ==================================
prompt
create table CLM.TB_CRD_STATIS_GTYPE
(
  statis_id          VARCHAR2(32) not null,
  approve_count      NUMBER(18),
  approve_exp_amount NUMBER(18,2),
  credit_exp_balance NUMBER(18,2),
  loan_exp_balance   NUMBER(18,2),
  limit_credit       NUMBER(18,2),
  limit_avi          NUMBER(18,2),
  limit_used         NUMBER(18,2),
  exp_used           NUMBER(18,2),
  exp_avi            NUMBER(18,2),
  org_num            VARCHAR2(10),
  guarantee_type     VARCHAR2(10),
  data_type          VARCHAR2(1),
  year               VARCHAR2(6),
  month              VARCHAR2(2),
  date               VARCHAR2(2),
  create_time        DATE,
  update_time        DATE
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
comment on table CLM.TB_CRD_STATIS_GTYPE
  is '���ͳ�Ʊ�-������ʽ����ʷ+ʵʱ��';
comment on column CLM.TB_CRD_STATIS_GTYPE.statis_id
  is 'ͳ��ID';
comment on column CLM.TB_CRD_STATIS_GTYPE.approve_count
  is '��������';
comment on column CLM.TB_CRD_STATIS_GTYPE.approve_exp_amount
  is '�������ڽ��';
comment on column CLM.TB_CRD_STATIS_GTYPE.credit_exp_balance
  is '���ų������';
comment on column CLM.TB_CRD_STATIS_GTYPE.loan_exp_balance
  is '��������';
comment on column CLM.TB_CRD_STATIS_GTYPE.limit_credit
  is '���Ŷ��';
comment on column CLM.TB_CRD_STATIS_GTYPE.limit_avi
  is '���ö��';
comment on column CLM.TB_CRD_STATIS_GTYPE.limit_used
  is '���ö��';
comment on column CLM.TB_CRD_STATIS_GTYPE.exp_used
  is '���ó���';
comment on column CLM.TB_CRD_STATIS_GTYPE.exp_avi
  is '���ó���';
comment on column CLM.TB_CRD_STATIS_GTYPE.org_num
  is '�������';
comment on column CLM.TB_CRD_STATIS_GTYPE.guarantee_type
  is '������ʽ��CD000100��';
comment on column CLM.TB_CRD_STATIS_GTYPE.data_type
  is '�������ͣ�1��ǰʵʱ���ݣ�2��ʷ���ݣ�';
comment on column CLM.TB_CRD_STATIS_GTYPE.year
  is '���';
comment on column CLM.TB_CRD_STATIS_GTYPE.month
  is '�·�';
comment on column CLM.TB_CRD_STATIS_GTYPE.create_time
  is '����ʱ��';
comment on column CLM.TB_CRD_STATIS_GTYPE.update_time
  is '�޸�ʱ��';
alter table CLM.TB_CRD_STATIS_GTYPE
  add constraint P_KEY_114 primary key (STATIS_ID)
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
prompt Creating table TB_CRD_STATIS_INDUSTRY
prompt =====================================
prompt
create table CLM.TB_CRD_STATIS_INDUSTRY
(
  statis_id          VARCHAR2(32) not null,
  approve_count      NUMBER(18),
  approve_exp_amount NUMBER(18,2),
  credit_exp_balance NUMBER(18,2),
  loan_exp_balance   NUMBER(18,2),
  limit_credit       NUMBER(18,2),
  limit_avi          NUMBER(18,2),
  limit_used         NUMBER(18,2),
  exp_used           NUMBER(18,2),
  exp_avi            NUMBER(18,2),
  industry           VARCHAR2(10),
  data_type          VARCHAR2(1),
  org_num            VARCHAR2(10),
  year               VARCHAR2(6),
  month              VARCHAR2(2),
  date               VARCHAR2(2),
  create_time        DATE,
  update_time        DATE
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
comment on table CLM.TB_CRD_STATIS_INDUSTRY
  is '���ͳ�Ʊ�-��ҵ����ʷ+ʵʱ��';
comment on column CLM.TB_CRD_STATIS_INDUSTRY.statis_id
  is 'ͳ��ID';
comment on column CLM.TB_CRD_STATIS_INDUSTRY.approve_count
  is '��������';
comment on column CLM.TB_CRD_STATIS_INDUSTRY.approve_exp_amount
  is '�������ڽ��';
comment on column CLM.TB_CRD_STATIS_INDUSTRY.credit_exp_balance
  is '���ų������';
comment on column CLM.TB_CRD_STATIS_INDUSTRY.loan_exp_balance
  is '��������';
comment on column CLM.TB_CRD_STATIS_INDUSTRY.limit_credit
  is '���Ŷ��';
comment on column CLM.TB_CRD_STATIS_INDUSTRY.limit_avi
  is '���ö��';
comment on column CLM.TB_CRD_STATIS_INDUSTRY.limit_used
  is '���ö��';
comment on column CLM.TB_CRD_STATIS_INDUSTRY.exp_used
  is '���ó���';
comment on column CLM.TB_CRD_STATIS_INDUSTRY.exp_avi
  is '���ó���';
comment on column CLM.TB_CRD_STATIS_INDUSTRY.industry
  is '��ҵ';
comment on column CLM.TB_CRD_STATIS_INDUSTRY.data_type
  is '�������ͣ�1��ǰʵʱ���ݣ�2��ʷ���ݣ�';
comment on column CLM.TB_CRD_STATIS_INDUSTRY.org_num
  is '�������';
comment on column CLM.TB_CRD_STATIS_INDUSTRY.year
  is '���';
comment on column CLM.TB_CRD_STATIS_INDUSTRY.month
  is '�·�';
comment on column CLM.TB_CRD_STATIS_INDUSTRY.create_time
  is '����ʱ��';
comment on column CLM.TB_CRD_STATIS_INDUSTRY.update_time
  is '�޸�ʱ��';
alter table CLM.TB_CRD_STATIS_INDUSTRY
  add constraint P_KEY_115 primary key (STATIS_ID)
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
prompt Creating table TB_CRD_STATIS_ORG
prompt ================================
prompt
create table CLM.TB_CRD_STATIS_ORG
(
  statis_id          VARCHAR2(32) not null,
  approve_exp_amount NUMBER(24,2),
  credit_exp_balance NUMBER(24,2),
  loan_exp_balance   NUMBER(24,2),
  limit_credit       NUMBER(24,2),
  limit_avi          NUMBER(24,2),
  limit_used         NUMBER(24,2),
  exp_used           NUMBER(24,2),
  exp_avi            NUMBER(24,2),
  individual_count   NUMBER(18),
  corporation_count  NUMBER(18),
  bank_count         NUMBER(18),
  org_num            VARCHAR2(10),
  data_type          VARCHAR2(1),
  year               VARCHAR2(6),
  month              VARCHAR2(2),
  date               VARCHAR2(2),
  create_time        DATE,
  update_time        DATE
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
comment on table CLM.TB_CRD_STATIS_ORG
  is '���ͳ�Ʊ�-��������ʷ+ʵʱ��';
comment on column CLM.TB_CRD_STATIS_ORG.statis_id
  is 'ͳ��ID';
comment on column CLM.TB_CRD_STATIS_ORG.approve_exp_amount
  is '�������ڽ��';
comment on column CLM.TB_CRD_STATIS_ORG.credit_exp_balance
  is '���ų������';
comment on column CLM.TB_CRD_STATIS_ORG.loan_exp_balance
  is '��������';
comment on column CLM.TB_CRD_STATIS_ORG.limit_credit
  is '���Ŷ��';
comment on column CLM.TB_CRD_STATIS_ORG.limit_avi
  is '���ö��';
comment on column CLM.TB_CRD_STATIS_ORG.limit_used
  is '���ö��';
comment on column CLM.TB_CRD_STATIS_ORG.exp_used
  is '���ó���';
comment on column CLM.TB_CRD_STATIS_ORG.exp_avi
  is '���ó���';
comment on column CLM.TB_CRD_STATIS_ORG.individual_count
  is '���˿ͻ�����';
comment on column CLM.TB_CRD_STATIS_ORG.corporation_count
  is '��˾�ͻ�����';
comment on column CLM.TB_CRD_STATIS_ORG.bank_count
  is 'ͬҵ�ͻ�����';
comment on column CLM.TB_CRD_STATIS_ORG.org_num
  is '�������';
comment on column CLM.TB_CRD_STATIS_ORG.data_type
  is '�������ͣ�1��ǰʵʱ���ݣ�2��ʷ���ݣ�';
comment on column CLM.TB_CRD_STATIS_ORG.year
  is '���';
comment on column CLM.TB_CRD_STATIS_ORG.month
  is '�·�';
comment on column CLM.TB_CRD_STATIS_ORG.create_time
  is '����ʱ��';
comment on column CLM.TB_CRD_STATIS_ORG.update_time
  is '�޸�ʱ��';
alter table CLM.TB_CRD_STATIS_ORG
  add constraint PK_TB_CRD_STATIS_ORG primary key (STATIS_ID)
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
prompt Creating table TB_CRD_STATIS_PRODUCT
prompt ====================================
prompt
create table CLM.TB_CRD_STATIS_PRODUCT
(
  statis_id          VARCHAR2(32) not null,
  approve_count      NUMBER(18),
  approve_exp_amount NUMBER(18,2),
  credit_exp_balance NUMBER(18,2),
  loan_exp_balance   NUMBER(18,2),
  limit_credit       NUMBER(18,2),
  limit_avi          NUMBER(18,2),
  limit_used         NUMBER(18,2),
  exp_used           NUMBER(18,2),
  exp_avi            NUMBER(18,2),
  data_type          VARCHAR2(1),
  product_num        VARCHAR2(10),
  org_num            VARCHAR2(10),
  year               VARCHAR2(6),
  month              VARCHAR2(2),
  date               VARCHAR2(2),
  create_time        DATE,
  update_time        DATE
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
comment on table CLM.TB_CRD_STATIS_PRODUCT
  is '���ͳ�Ʊ�-ҵ��Ʒ�֣���ʷ+ʵʱ��';
comment on column CLM.TB_CRD_STATIS_PRODUCT.statis_id
  is 'ͳ��ID';
comment on column CLM.TB_CRD_STATIS_PRODUCT.approve_count
  is '��������';
comment on column CLM.TB_CRD_STATIS_PRODUCT.approve_exp_amount
  is '�������ڽ��';
comment on column CLM.TB_CRD_STATIS_PRODUCT.credit_exp_balance
  is '���ų������';
comment on column CLM.TB_CRD_STATIS_PRODUCT.loan_exp_balance
  is '��������';
comment on column CLM.TB_CRD_STATIS_PRODUCT.limit_credit
  is '���Ŷ��';
comment on column CLM.TB_CRD_STATIS_PRODUCT.limit_avi
  is '���ö��';
comment on column CLM.TB_CRD_STATIS_PRODUCT.limit_used
  is '���ö��';
comment on column CLM.TB_CRD_STATIS_PRODUCT.exp_used
  is '���ó���';
comment on column CLM.TB_CRD_STATIS_PRODUCT.exp_avi
  is '���ó���';
comment on column CLM.TB_CRD_STATIS_PRODUCT.data_type
  is '�������ͣ�1��ǰʵʱ���ݣ�2��ʷ���ݣ�';
comment on column CLM.TB_CRD_STATIS_PRODUCT.product_num
  is 'ҵ��Ʒ��';
comment on column CLM.TB_CRD_STATIS_PRODUCT.org_num
  is '�������';
comment on column CLM.TB_CRD_STATIS_PRODUCT.year
  is '���';
comment on column CLM.TB_CRD_STATIS_PRODUCT.month
  is '�·�';
comment on column CLM.TB_CRD_STATIS_PRODUCT.create_time
  is '����ʱ��';
comment on column CLM.TB_CRD_STATIS_PRODUCT.update_time
  is '�޸�ʱ��';
alter table CLM.TB_CRD_STATIS_PRODUCT
  add constraint P_KEY_116 primary key (STATIS_ID)
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
prompt Creating table TB_CRD_STATIS_USCALE
prompt ===================================
prompt
create table CLM.TB_CRD_STATIS_USCALE
(
  statis_id          VARCHAR2(32) not null,
  approve_count      NUMBER(18),
  approve_exp_amount NUMBER(18,2),
  credit_exp_balance NUMBER(18,2),
  loan_exp_balance   NUMBER(18,2),
  limit_credit       NUMBER(18,2),
  limit_avi          NUMBER(18,2),
  limit_used         NUMBER(18,2),
  exp_used           NUMBER(18,2),
  exp_avi            NUMBER(18,2),
  org_num            VARCHAR2(10),
  unit_scale         VARCHAR2(10),
  data_type          VARCHAR2(1),
  year               VARCHAR2(6),
  month              VARCHAR2(2),
  date               VARCHAR2(2),
  create_time        DATE,
  update_time        DATE
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
comment on table CLM.TB_CRD_STATIS_USCALE
  is '���ͳ�Ʊ�-��ҵ��ģ����ʷ+ʵʱ��';
comment on column CLM.TB_CRD_STATIS_USCALE.statis_id
  is 'ͳ��ID';
comment on column CLM.TB_CRD_STATIS_USCALE.approve_count
  is '��������';
comment on column CLM.TB_CRD_STATIS_USCALE.approve_exp_amount
  is '�������ڽ��';
comment on column CLM.TB_CRD_STATIS_USCALE.credit_exp_balance
  is '���ų������';
comment on column CLM.TB_CRD_STATIS_USCALE.loan_exp_balance
  is '��������';
comment on column CLM.TB_CRD_STATIS_USCALE.limit_credit
  is '���Ŷ��';
comment on column CLM.TB_CRD_STATIS_USCALE.limit_avi
  is '���ö��';
comment on column CLM.TB_CRD_STATIS_USCALE.limit_used
  is '���ö��';
comment on column CLM.TB_CRD_STATIS_USCALE.exp_used
  is '���ó���';
comment on column CLM.TB_CRD_STATIS_USCALE.exp_avi
  is '���ó���';
comment on column CLM.TB_CRD_STATIS_USCALE.org_num
  is '�������';
comment on column CLM.TB_CRD_STATIS_USCALE.unit_scale
  is '��ҵ��ģ��CD000020��';
comment on column CLM.TB_CRD_STATIS_USCALE.data_type
  is '�������ͣ�1��ǰʵʱ���ݣ�2��ʷ���ݣ�';
comment on column CLM.TB_CRD_STATIS_USCALE.year
  is '���';
comment on column CLM.TB_CRD_STATIS_USCALE.month
  is '�·�';
comment on column CLM.TB_CRD_STATIS_USCALE.create_time
  is '����ʱ��';
comment on column CLM.TB_CRD_STATIS_USCALE.update_time
  is '�޸�ʱ��';
alter table CLM.TB_CRD_STATIS_USCALE
  add constraint P_KEY_117 primary key (STATIS_ID)
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
prompt Creating table TB_CRD_SUBCONTRACT
prompt =================================
prompt
create table CLM.TB_CRD_SUBCONTRACT
(
  subcontract_num     VARCHAR2(40) not null,
  con_customer_num    VARCHAR2(32),
  subcontract_type    VARCHAR2(10),
  is_top              VARCHAR2(10),
  is_group            VARCHAR2(10),
  subcontract_amt     NUMBER(18,2),
  surety_customer_num VARCHAR2(40),
  currency_cd         VARCHAR2(10),
  exchange_rate       NUMBER(10,6),
  begin_date          VARCHAR2(20),
  end_date            VARCHAR2(20),
  subcontract_staus   VARCHAR2(10),
  org_num             VARCHAR2(40),
  user_num            VARCHAR2(40),
  create_time         DATE,
  update_time         DATE
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
comment on table CLM.TB_CRD_SUBCONTRACT
  is '������ͬ��Ϣ��';
comment on column CLM.TB_CRD_SUBCONTRACT.subcontract_num
  is '������ͬ���';
comment on column CLM.TB_CRD_SUBCONTRACT.con_customer_num
  is '����˿ͻ����';
comment on column CLM.TB_CRD_SUBCONTRACT.subcontract_type
  is '������ͬ���ͣ�CD000102��';
comment on column CLM.TB_CRD_SUBCONTRACT.is_top
  is '�Ƿ���߶CD000167��';
comment on column CLM.TB_CRD_SUBCONTRACT.is_group
  is '�Ƿ�����С�鵣����CD000167��';
comment on column CLM.TB_CRD_SUBCONTRACT.subcontract_amt
  is '������ͬ���';
comment on column CLM.TB_CRD_SUBCONTRACT.surety_customer_num
  is '�����˿ͻ����';
comment on column CLM.TB_CRD_SUBCONTRACT.currency_cd
  is '����';
comment on column CLM.TB_CRD_SUBCONTRACT.exchange_rate
  is '����';
comment on column CLM.TB_CRD_SUBCONTRACT.begin_date
  is '��ʼ��';
comment on column CLM.TB_CRD_SUBCONTRACT.end_date
  is '������';
comment on column CLM.TB_CRD_SUBCONTRACT.subcontract_staus
  is '������ͬ״̬��CD000109��';
comment on column CLM.TB_CRD_SUBCONTRACT.org_num
  is '�������';
comment on column CLM.TB_CRD_SUBCONTRACT.user_num
  is '������';
comment on column CLM.TB_CRD_SUBCONTRACT.create_time
  is '����ʱ��';
comment on column CLM.TB_CRD_SUBCONTRACT.update_time
  is '�޸�ʱ��';
alter table CLM.TB_CRD_SUBCONTRACT
  add constraint P_KEY_118 primary key (SUBCONTRACT_NUM)
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
prompt Creating table TB_CRD_SUBCONTRACT_CON
prompt =====================================
prompt
create table CLM.TB_CRD_SUBCONTRACT_CON
(
  relation_id     VARCHAR2(32) not null,
  subcontract_num VARCHAR2(40),
  contract_num    VARCHAR2(40),
  surety_amt      NUMBER(18,2),
  create_time     DATE,
  update_time     DATE
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
comment on table CLM.TB_CRD_SUBCONTRACT_CON
  is '������ͬ��ҵ���ͬ������ϵ';
comment on column CLM.TB_CRD_SUBCONTRACT_CON.relation_id
  is '����ID';
comment on column CLM.TB_CRD_SUBCONTRACT_CON.subcontract_num
  is '������ͬ���';
comment on column CLM.TB_CRD_SUBCONTRACT_CON.contract_num
  is '��ͬ���';
comment on column CLM.TB_CRD_SUBCONTRACT_CON.surety_amt
  is 'ռ�ý��';
comment on column CLM.TB_CRD_SUBCONTRACT_CON.create_time
  is '����ʱ��';
comment on column CLM.TB_CRD_SUBCONTRACT_CON.update_time
  is '�޸�ʱ��';
alter table CLM.TB_CRD_SUBCONTRACT_CON
  add constraint P_KEY_119 primary key (RELATION_ID)
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
prompt Creating table TB_CRD_SUBCONTRACT_SURETY
prompt ========================================
prompt
create table CLM.TB_CRD_SUBCONTRACT_SURETY
(
  relation_id     VARCHAR2(32) not null,
  subcontract_num VARCHAR2(40),
  surety_num      VARCHAR2(40),
  rel_type        VARCHAR2(1),
  surety_amt      NUMBER(18,2),
  create_time     DATE,
  update_time     DATE
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
comment on table CLM.TB_CRD_SUBCONTRACT_SURETY
  is '������ͬ��ѺƷ������ϵ��';
comment on column CLM.TB_CRD_SUBCONTRACT_SURETY.relation_id
  is '����ID';
comment on column CLM.TB_CRD_SUBCONTRACT_SURETY.subcontract_num
  is '������ͬ���';
comment on column CLM.TB_CRD_SUBCONTRACT_SURETY.surety_num
  is '����Ѻ����';
comment on column CLM.TB_CRD_SUBCONTRACT_SURETY.rel_type
  is '�������ͣ�1������ͬ���� 2ҵ�������������';
comment on column CLM.TB_CRD_SUBCONTRACT_SURETY.surety_amt
  is 'ռ�ý��';
comment on column CLM.TB_CRD_SUBCONTRACT_SURETY.create_time
  is '����ʱ��';
comment on column CLM.TB_CRD_SUBCONTRACT_SURETY.update_time
  is '�޸�ʱ��';
alter table CLM.TB_CRD_SUBCONTRACT_SURETY
  add constraint P_KEY_120 primary key (RELATION_ID)
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
prompt Creating table TB_CRD_SUM
prompt =========================
prompt
create table CLM.TB_CRD_SUM
(
  statis_id          VARCHAR2(32) not null,
  customer_num       VARCHAR2(40),
  crd_product_type   VARCHAR2(6),
  currency_cd        VARCHAR2(10),
  limit_credit       NUMBER(24,2),
  limit_used         NUMBER(24,2),
  limit_avi          NUMBER(24,2),
  exp_credit         NUMBER(24,2),
  exp_used           NUMBER(24,2),
  exp_avi            NUMBER(24,2),
  limit_pre          NUMBER(24,2),
  exp_pre            NUMBER(24,2),
  limit_frozen       NUMBER(24,2),
  exp_frozen         NUMBER(24,2),
  org_num            VARCHAR2(10),
  create_time        DATE,
  update_time        DATE,
  limit_earmark      NUMBER(24,2),
  limit_earmark_used NUMBER(24,2),
  limit_earmark_avi  NUMBER(24,2)
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
comment on table CLM.TB_CRD_SUM
  is '��Ȼ��ܱ�ʵʱ��';
comment on column CLM.TB_CRD_SUM.statis_id
  is 'ͳ��ID';
comment on column CLM.TB_CRD_SUM.customer_num
  is '�ͻ����';
comment on column CLM.TB_CRD_SUM.crd_product_type
  is '������ͣ�CD000211��';
comment on column CLM.TB_CRD_SUM.currency_cd
  is '����';
comment on column CLM.TB_CRD_SUM.limit_credit
  is '���Ŷ��';
comment on column CLM.TB_CRD_SUM.limit_used
  is '���ö��';
comment on column CLM.TB_CRD_SUM.limit_avi
  is '���ö��';
comment on column CLM.TB_CRD_SUM.exp_credit
  is '���ų���';
comment on column CLM.TB_CRD_SUM.exp_used
  is '���ó���';
comment on column CLM.TB_CRD_SUM.exp_avi
  is '���ó���';
comment on column CLM.TB_CRD_SUM.limit_pre
  is '���ö��';
comment on column CLM.TB_CRD_SUM.exp_pre
  is 'Ԥռ�ó���';
comment on column CLM.TB_CRD_SUM.limit_frozen
  is '������';
comment on column CLM.TB_CRD_SUM.exp_frozen
  is '���᳨��';
comment on column CLM.TB_CRD_SUM.org_num
  is '�������';
comment on column CLM.TB_CRD_SUM.create_time
  is '����ʱ��';
comment on column CLM.TB_CRD_SUM.update_time
  is '�޸�ʱ��';
comment on column CLM.TB_CRD_SUM.limit_earmark
  is 'Ȧ����';
comment on column CLM.TB_CRD_SUM.limit_earmark_used
  is 'Ȧ�����ö��';
comment on column CLM.TB_CRD_SUM.limit_earmark_avi
  is 'Ȧ����ö��';
alter table CLM.TB_CRD_SUM
  add constraint P_KEY_121 primary key (STATIS_ID)
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
prompt Creating table TB_CRD_SUMMARY
prompt =============================
prompt
create table CLM.TB_CRD_SUMMARY
(
  summary_id          VARCHAR2(32) not null,
  summary_num         VARCHAR2(40),
  contract_num        VARCHAR2(40),
  approve_id          VARCHAR2(32),
  customer_num        VARCHAR2(40),
  product_num         VARCHAR2(10),
  currency_cd         VARCHAR2(10),
  exchange_rate       NUMBER(10,6),
  summary_amt         NUMBER(18,2),
  summary_bal         NUMBER(18,2),
  last_summary_bal    NUMBER(18,2),
  begin_date          VARCHAR2(20),
  end_date            VARCHAR2(20),
  summary_status      VARCHAR2(10),
  classify_result     VARCHAR2(20),
  industry            VARCHAR2(10),
  guarantee_type      VARCHAR2(10),
  main_guarantee_type VARCHAR2(10),
  deposit_ratio       NUMBER(10,6),
  bill_num            VARCHAR2(40),
  bill_type           VARCHAR2(10),
  acceptor_ecif_num   VARCHAR2(40),
  payee_name          VARCHAR2(2500),
  payee_acct          VARCHAR2(50),
  payee_bank_num      VARCHAR2(50),
  payee_bank_name     VARCHAR2(250),
  pay_name            VARCHAR2(250),
  pay_acct            VARCHAR2(100),
  drawer_name         VARCHAR2(250),
  drawer_acct         VARCHAR2(50),
  drawer_bank_num     VARCHAR2(50),
  drawer_bank_name    VARCHAR2(250),
  bill_status         VARCHAR2(10),
  loan_org            VARCHAR2(20),
  tran_date           VARCHAR2(20),
  tran_system         VARCHAR2(10),
  user_num            VARCHAR2(10),
  org_num             VARCHAR2(10),
  create_time         DATE,
  update_time         DATE
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
comment on table CLM.TB_CRD_SUMMARY
  is '�����Ϣ��';
comment on column CLM.TB_CRD_SUMMARY.summary_id
  is '���ID';
comment on column CLM.TB_CRD_SUMMARY.summary_num
  is '��ݺ�';
comment on column CLM.TB_CRD_SUMMARY.contract_num
  is '��ͬ���';
comment on column CLM.TB_CRD_SUMMARY.approve_id
  is '����ID';
comment on column CLM.TB_CRD_SUMMARY.customer_num
  is '�ͻ����';
comment on column CLM.TB_CRD_SUMMARY.product_num
  is 'ҵ��Ʒ��';
comment on column CLM.TB_CRD_SUMMARY.currency_cd
  is '����';
comment on column CLM.TB_CRD_SUMMARY.exchange_rate
  is '����';
comment on column CLM.TB_CRD_SUMMARY.summary_amt
  is '��ݽ��';
comment on column CLM.TB_CRD_SUMMARY.summary_bal
  is '������';
comment on column CLM.TB_CRD_SUMMARY.last_summary_bal
  is '���½�����';
comment on column CLM.TB_CRD_SUMMARY.begin_date
  is '�������';
comment on column CLM.TB_CRD_SUMMARY.end_date
  is '���ֹ��';
comment on column CLM.TB_CRD_SUMMARY.summary_status
  is '���״̬��CD000175��';
comment on column CLM.TB_CRD_SUMMARY.classify_result
  is '�弶��������CD000171��';
comment on column CLM.TB_CRD_SUMMARY.industry
  is 'Ͷ����ҵ���루CD000015��';
comment on column CLM.TB_CRD_SUMMARY.guarantee_type
  is '������ʽ';
comment on column CLM.TB_CRD_SUMMARY.main_guarantee_type
  is '��Ҫ������ʽ';
comment on column CLM.TB_CRD_SUMMARY.deposit_ratio
  is '��֤�����';
comment on column CLM.TB_CRD_SUMMARY.bill_num
  is 'Ʊ�ݱ��';
comment on column CLM.TB_CRD_SUMMARY.bill_type
  is 'Ʊ�����ࣨCD000080��';
comment on column CLM.TB_CRD_SUMMARY.acceptor_ecif_num
  is '�ж���ECIF�ͻ���';
comment on column CLM.TB_CRD_SUMMARY.payee_name
  is '�տ�������';
comment on column CLM.TB_CRD_SUMMARY.payee_acct
  is '�տ����˺�';
comment on column CLM.TB_CRD_SUMMARY.payee_bank_num
  is '�տ��˿������к�';
comment on column CLM.TB_CRD_SUMMARY.payee_bank_name
  is '�տ��˿���������';
comment on column CLM.TB_CRD_SUMMARY.pay_name
  is '����������';
comment on column CLM.TB_CRD_SUMMARY.pay_acct
  is '�������к�';
comment on column CLM.TB_CRD_SUMMARY.drawer_name
  is '��Ʊ������';
comment on column CLM.TB_CRD_SUMMARY.drawer_acct
  is '��Ʊ���˺�';
comment on column CLM.TB_CRD_SUMMARY.drawer_bank_num
  is '��Ʊ�˿������к�';
comment on column CLM.TB_CRD_SUMMARY.drawer_bank_name
  is '��Ʊ�˿���������';
comment on column CLM.TB_CRD_SUMMARY.bill_status
  is 'Ʊ��״̬��CD000078��';
comment on column CLM.TB_CRD_SUMMARY.loan_org
  is '���˻���';
comment on column CLM.TB_CRD_SUMMARY.tran_date
  is '��������';
comment on column CLM.TB_CRD_SUMMARY.tran_system
  is '����ϵͳ';
comment on column CLM.TB_CRD_SUMMARY.user_num
  is '������';
comment on column CLM.TB_CRD_SUMMARY.org_num
  is '�������';
comment on column CLM.TB_CRD_SUMMARY.create_time
  is '����ʱ��';
comment on column CLM.TB_CRD_SUMMARY.update_time
  is '�޸�ʱ��';
alter table CLM.TB_CRD_SUMMARY
  add constraint PK_TB_CRD_SUMMARY primary key (SUMMARY_ID)
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
prompt Creating table TB_CRD_SUMMARY_EVENT
prompt ===================================
prompt
create table CLM.TB_CRD_SUMMARY_EVENT
(
  event_id            VARCHAR2(32) not null,
  tran_seq_sn         VARCHAR2(50),
  op_type             VARCHAR2(2),
  summary_id          VARCHAR2(32),
  summary_num         VARCHAR2(40),
  contract_num        VARCHAR2(40),
  approve_id          VARCHAR2(32),
  customer_num        VARCHAR2(40),
  product_num         VARCHAR2(10),
  currency_cd         VARCHAR2(10),
  exchange_rate       NUMBER(10,6),
  summary_amt         NUMBER(18,2),
  summary_bal         NUMBER(18,2),
  last_summary_bal    NUMBER(18,2),
  begin_date          VARCHAR2(20),
  end_date            VARCHAR2(20),
  summary_status      VARCHAR2(10),
  classify_result     VARCHAR2(20),
  industry            VARCHAR2(10),
  guarantee_type      VARCHAR2(10),
  main_guarantee_type VARCHAR2(10),
  deposit_ratio       NUMBER(10,6),
  bill_num            VARCHAR2(40),
  bill_type           VARCHAR2(10),
  acceptor_ecif_num   VARCHAR2(40),
  payee_name          VARCHAR2(2500),
  payee_acct          VARCHAR2(50),
  payee_bank_num      VARCHAR2(50),
  payee_bank_name     VARCHAR2(250),
  pay_name            VARCHAR2(250),
  pay_acct            VARCHAR2(100),
  drawer_name         VARCHAR2(250),
  drawer_acct         VARCHAR2(50),
  drawer_bank_num     VARCHAR2(50),
  drawer_bank_name    VARCHAR2(250),
  bill_status         VARCHAR2(10),
  loan_org            VARCHAR2(20),
  tran_date           VARCHAR2(20),
  tran_system         VARCHAR2(10),
  user_num            VARCHAR2(10),
  org_num             VARCHAR2(10),
  create_time         DATE,
  update_time         DATE,
  biz_scene           VARCHAR2(2),
  biz_action          VARCHAR2(2)
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
comment on table CLM.TB_CRD_SUMMARY_EVENT
  is '�Ŵ�ʵʱ-�����Ϣ��';
comment on column CLM.TB_CRD_SUMMARY_EVENT.event_id
  is '����';
comment on column CLM.TB_CRD_SUMMARY_EVENT.tran_seq_sn
  is '������ˮ��';
comment on column CLM.TB_CRD_SUMMARY_EVENT.op_type
  is '�������ͣ�01 ����02 ���� 03ɾ����';
comment on column CLM.TB_CRD_SUMMARY_EVENT.summary_id
  is '���ID';
comment on column CLM.TB_CRD_SUMMARY_EVENT.summary_num
  is '��ݺ�';
comment on column CLM.TB_CRD_SUMMARY_EVENT.contract_num
  is '��ͬ���';
comment on column CLM.TB_CRD_SUMMARY_EVENT.approve_id
  is '����ID';
comment on column CLM.TB_CRD_SUMMARY_EVENT.customer_num
  is '�ͻ����';
comment on column CLM.TB_CRD_SUMMARY_EVENT.product_num
  is 'ҵ��Ʒ��';
comment on column CLM.TB_CRD_SUMMARY_EVENT.currency_cd
  is '����';
comment on column CLM.TB_CRD_SUMMARY_EVENT.exchange_rate
  is '����';
comment on column CLM.TB_CRD_SUMMARY_EVENT.summary_amt
  is '��ݽ��';
comment on column CLM.TB_CRD_SUMMARY_EVENT.summary_bal
  is '������';
comment on column CLM.TB_CRD_SUMMARY_EVENT.last_summary_bal
  is '���½�����';
comment on column CLM.TB_CRD_SUMMARY_EVENT.begin_date
  is '�������';
comment on column CLM.TB_CRD_SUMMARY_EVENT.end_date
  is '���ֹ��';
comment on column CLM.TB_CRD_SUMMARY_EVENT.summary_status
  is '���״̬��CD000175��';
comment on column CLM.TB_CRD_SUMMARY_EVENT.classify_result
  is '�弶��������CD000171��';
comment on column CLM.TB_CRD_SUMMARY_EVENT.industry
  is 'Ͷ����ҵ���루CD000015��';
comment on column CLM.TB_CRD_SUMMARY_EVENT.guarantee_type
  is '������ʽ';
comment on column CLM.TB_CRD_SUMMARY_EVENT.main_guarantee_type
  is '��Ҫ������ʽ';
comment on column CLM.TB_CRD_SUMMARY_EVENT.deposit_ratio
  is '��֤�����';
comment on column CLM.TB_CRD_SUMMARY_EVENT.bill_num
  is 'Ʊ�ݱ��';
comment on column CLM.TB_CRD_SUMMARY_EVENT.bill_type
  is 'Ʊ�����ࣨCD000080��';
comment on column CLM.TB_CRD_SUMMARY_EVENT.acceptor_ecif_num
  is '�ж���ECIF�ͻ���';
comment on column CLM.TB_CRD_SUMMARY_EVENT.payee_name
  is '�տ�������';
comment on column CLM.TB_CRD_SUMMARY_EVENT.payee_acct
  is '�տ����˺�';
comment on column CLM.TB_CRD_SUMMARY_EVENT.payee_bank_num
  is '�տ��˿������к�';
comment on column CLM.TB_CRD_SUMMARY_EVENT.payee_bank_name
  is '�տ��˿���������';
comment on column CLM.TB_CRD_SUMMARY_EVENT.pay_name
  is '����������';
comment on column CLM.TB_CRD_SUMMARY_EVENT.pay_acct
  is '�������к�';
comment on column CLM.TB_CRD_SUMMARY_EVENT.drawer_name
  is '��Ʊ������';
comment on column CLM.TB_CRD_SUMMARY_EVENT.drawer_acct
  is '��Ʊ���˺�';
comment on column CLM.TB_CRD_SUMMARY_EVENT.drawer_bank_num
  is '��Ʊ�˿������к�';
comment on column CLM.TB_CRD_SUMMARY_EVENT.drawer_bank_name
  is '��Ʊ�˿���������';
comment on column CLM.TB_CRD_SUMMARY_EVENT.bill_status
  is 'Ʊ��״̬��CD000078��';
comment on column CLM.TB_CRD_SUMMARY_EVENT.loan_org
  is '���˻���';
comment on column CLM.TB_CRD_SUMMARY_EVENT.tran_date
  is '��������';
comment on column CLM.TB_CRD_SUMMARY_EVENT.tran_system
  is '����ϵͳ';
comment on column CLM.TB_CRD_SUMMARY_EVENT.user_num
  is '������';
comment on column CLM.TB_CRD_SUMMARY_EVENT.org_num
  is '�������';
comment on column CLM.TB_CRD_SUMMARY_EVENT.create_time
  is '����ʱ��';
comment on column CLM.TB_CRD_SUMMARY_EVENT.update_time
  is '�޸�ʱ��';
comment on column CLM.TB_CRD_SUMMARY_EVENT.biz_scene
  is 'ҵ�񳡾�';
comment on column CLM.TB_CRD_SUMMARY_EVENT.biz_action
  is '���̽ڵ�';
alter table CLM.TB_CRD_SUMMARY_EVENT
  add constraint PK_TB_CRD_SUMMARY_EVENT primary key (EVENT_ID)
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
prompt Creating table TB_CRD_SURETY
prompt ============================
prompt
create table CLM.TB_CRD_SURETY
(
  surety_num     VARCHAR2(40) not null,
  crd_main_prd   VARCHAR2(40),
  crd_main_num   VARCHAR2(40),
  crd_detail_prd VARCHAR2(40),
  crd_detail_num VARCHAR2(40),
  customer_num   VARCHAR2(40),
  guarantee_type VARCHAR2(10),
  pledge_type    VARCHAR2(10),
  pledge_name    VARCHAR2(80),
  currency_cd    VARCHAR2(10),
  exchange_rate  NUMBER(10,6),
  amt_asses      NUMBER(18,2),
  amt_actual     NUMBER(18,2),
  amt_used       NUMBER(18,2),
  amt_avi        NUMBER(18,2),
  pledge_rate    NUMBER(10,6),
  pledge_status  VARCHAR2(20),
  tran_date      VARCHAR2(20),
  tran_system    VARCHAR2(10),
  create_time    DATE,
  update_time    DATE,
  user_num       VARCHAR2(12),
  org_num        VARCHAR2(12)
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
comment on table CLM.TB_CRD_SURETY
  is '����Ѻ��/��֤����Ϣ��';
comment on column CLM.TB_CRD_SURETY.surety_num
  is '��������';
comment on column CLM.TB_CRD_SURETY.crd_main_prd
  is '��ȶ���Ʒ��';
comment on column CLM.TB_CRD_SURETY.crd_main_num
  is '��ȶ������';
comment on column CLM.TB_CRD_SURETY.crd_detail_prd
  is '�������Ʒ��';
comment on column CLM.TB_CRD_SURETY.crd_detail_num
  is '����������';
comment on column CLM.TB_CRD_SURETY.customer_num
  is '�ͻ���';
comment on column CLM.TB_CRD_SURETY.guarantee_type
  is '������ʽ��CD000100��';
comment on column CLM.TB_CRD_SURETY.pledge_type
  is '����������';
comment on column CLM.TB_CRD_SURETY.pledge_name
  is '����������';
comment on column CLM.TB_CRD_SURETY.currency_cd
  is '����';
comment on column CLM.TB_CRD_SURETY.exchange_rate
  is '����';
comment on column CLM.TB_CRD_SURETY.amt_asses
  is '������ֵ';
comment on column CLM.TB_CRD_SURETY.amt_actual
  is 'Ȩ����ֵ';
comment on column CLM.TB_CRD_SURETY.amt_used
  is '���ý��';
comment on column CLM.TB_CRD_SURETY.amt_avi
  is '���ý��';
comment on column CLM.TB_CRD_SURETY.pledge_rate
  is '����Ѻ��';
comment on column CLM.TB_CRD_SURETY.pledge_status
  is 'ѺƷ״̬��CD000062��';
comment on column CLM.TB_CRD_SURETY.tran_date
  is '��������';
comment on column CLM.TB_CRD_SURETY.tran_system
  is '����ϵͳ';
comment on column CLM.TB_CRD_SURETY.create_time
  is '����ʱ��';
comment on column CLM.TB_CRD_SURETY.update_time
  is '�޸�ʱ��';
comment on column CLM.TB_CRD_SURETY.user_num
  is '������';
comment on column CLM.TB_CRD_SURETY.org_num
  is '�������';
alter table CLM.TB_CRD_SURETY
  add constraint P_KEY_122 primary key (SURETY_NUM)
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
prompt Creating table TB_CSM_ADDRESS_INFO
prompt ==================================
prompt
create table CLM.TB_CSM_ADDRESS_INFO
(
  addr_id      VARCHAR2(32) not null,
  customer_num VARCHAR2(10),
  conn_type    VARCHAR2(3),
  coun_regi    VARCHAR2(3),
  province     VARCHAR2(6),
  city         VARCHAR2(6),
  county       VARCHAR2(6),
  street       VARCHAR2(60),
  detail_addr  VARCHAR2(256),
  eng_addr     VARCHAR2(256),
  post_code    VARCHAR2(6),
  create_time  DATE,
  update_time  DATE
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
comment on table CLM.TB_CSM_ADDRESS_INFO
  is '��ַ��Ϣ';
comment on column CLM.TB_CSM_ADDRESS_INFO.addr_id
  is '�����ַID';
comment on column CLM.TB_CSM_ADDRESS_INFO.customer_num
  is '�ͻ����';
comment on column CLM.TB_CSM_ADDRESS_INFO.conn_type
  is '��ϵ����(CD000031)';
comment on column CLM.TB_CSM_ADDRESS_INFO.coun_regi
  is '��ϵ��ַ����/����(CD000001)';
comment on column CLM.TB_CSM_ADDRESS_INFO.province
  is 'ʡ����(CD000002)';
comment on column CLM.TB_CSM_ADDRESS_INFO.city
  is '�д���(CD000002)';
comment on column CLM.TB_CSM_ADDRESS_INFO.county
  is '�ش���(CD000002)';
comment on column CLM.TB_CSM_ADDRESS_INFO.street
  is '�ֵ���ַ';
comment on column CLM.TB_CSM_ADDRESS_INFO.detail_addr
  is '��ϸ��ַ';
comment on column CLM.TB_CSM_ADDRESS_INFO.eng_addr
  is 'Ӣ�ĵ�ַ';
comment on column CLM.TB_CSM_ADDRESS_INFO.post_code
  is '��������';
comment on column CLM.TB_CSM_ADDRESS_INFO.create_time
  is '����ʱ��';
comment on column CLM.TB_CSM_ADDRESS_INFO.update_time
  is '����ʱ��';
alter table CLM.TB_CSM_ADDRESS_INFO
  add constraint P_KEY_124 primary key (ADDR_ID)
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
prompt Creating table TB_CSM_CERT_INFO
prompt ===============================
prompt
create table CLM.TB_CSM_CERT_INFO
(
  cert_id         VARCHAR2(32) not null,
  customer_num    VARCHAR2(10),
  cert_flag       VARCHAR2(2),
  cert_type       VARCHAR2(2),
  cert_num        VARCHAR2(60),
  issued_inst     VARCHAR2(120),
  cert_start_date VARCHAR2(20),
  cert_end_date   VARCHAR2(20),
  create_time     DATE,
  update_time     DATE
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
comment on table CLM.TB_CSM_CERT_INFO
  is '֤����Ϣ��';
comment on column CLM.TB_CSM_CERT_INFO.cert_id
  is '֤��id';
comment on column CLM.TB_CSM_CERT_INFO.customer_num
  is '�ͻ����';
comment on column CLM.TB_CSM_CERT_INFO.cert_flag
  is '����֤����ʶ(00Ϊ��֤��01Ϊ��֤��)';
comment on column CLM.TB_CSM_CERT_INFO.cert_type
  is '֤������(CD000003)';
comment on column CLM.TB_CSM_CERT_INFO.cert_num
  is '֤������';
comment on column CLM.TB_CSM_CERT_INFO.issued_inst
  is '֤�����Ż���';
comment on column CLM.TB_CSM_CERT_INFO.cert_start_date
  is '֤����Ч����(yyyy-MM-dd)';
comment on column CLM.TB_CSM_CERT_INFO.cert_end_date
  is '֤����������(yyyy-MM-dd)';
comment on column CLM.TB_CSM_CERT_INFO.create_time
  is '����ʱ��';
comment on column CLM.TB_CSM_CERT_INFO.update_time
  is '����ʱ��';
alter table CLM.TB_CSM_CERT_INFO
  add constraint P_KEY_125 primary key (CERT_ID)
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
prompt Creating table TB_CSM_CORPORATION
prompt =================================
prompt
create table CLM.TB_CSM_CORPORATION
(
  customer_num             VARCHAR2(10) not null,
  customer_type            VARCHAR2(2),
  cust_status              VARCHAR2(1),
  bank_cust_flag           VARCHAR2(1),
  cust_manager_no          VARCHAR2(6),
  cust_name                VARCHAR2(200),
  org_short_name           VARCHAR2(200),
  cust_eng_name            VARCHAR2(200),
  org_rng_short_name       VARCHAR2(100),
  national_economy_type    VARCHAR2(3),
  national_economy_depart1 VARCHAR2(6),
  national_economy_depart2 VARCHAR2(6),
  national_economy_depart3 VARCHAR2(6),
  national_economy_depart4 VARCHAR2(6),
  found_date               VARCHAR2(20),
  reg_capital              NUMBER(18,2),
  reg_cptl_curr            VARCHAR2(3),
  unit_scale               VARCHAR2(1),
  emp_number               VARCHAR2(8),
  pay_credit_flag          VARCHAR2(1),
  country_code             VARCHAR2(3),
  credit_organ_code        VARCHAR2(18),
  busin_scope              VARCHAR2(256),
  bank_cust_type1          VARCHAR2(4),
  bank_cust_type2          VARCHAR2(4),
  bank_pay_sys_num         VARCHAR2(14),
  group_credit_indicator   VARCHAR2(1),
  bank_indicator           VARCHAR2(1),
  rel_party_ind            VARCHAR2(1),
  swift_code               VARCHAR2(11),
  bene_cust_type           VARCHAR2(1),
  remarks                  VARCHAR2(64),
  created_ts               VARCHAR2(10),
  last_updated_org         VARCHAR2(5),
  last_updated_te          VARCHAR2(6),
  create_time              DATE,
  update_time              DATE
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
comment on table CLM.TB_CSM_CORPORATION
  is '��˾�ͻ�������Ϣ';
comment on column CLM.TB_CSM_CORPORATION.customer_num
  is '�ͻ����';
comment on column CLM.TB_CSM_CORPORATION.customer_type
  is '�ͻ�����(CD000212)';
comment on column CLM.TB_CSM_CORPORATION.cust_status
  is '�ͻ�״̬(CD000032)';
comment on column CLM.TB_CSM_CORPORATION.bank_cust_flag
  is 'ͬҵ�ͻ����ױ�־(1 -  ������Ϣ 2 -  ��ϸ��Ϣ )';
comment on column CLM.TB_CSM_CORPORATION.cust_manager_no
  is '�ͻ�������';
comment on column CLM.TB_CSM_CORPORATION.cust_name
  is '�ͻ�����';
comment on column CLM.TB_CSM_CORPORATION.org_short_name
  is '��֯���ļ��';
comment on column CLM.TB_CSM_CORPORATION.cust_eng_name
  is '�ͻ�Ӣ������';
comment on column CLM.TB_CSM_CORPORATION.org_rng_short_name
  is '��֯Ӣ�ļ��';
comment on column CLM.TB_CSM_CORPORATION.national_economy_type
  is '���񾭼ò���(CD000039)';
comment on column CLM.TB_CSM_CORPORATION.national_economy_depart1
  is '���񾭼���ҵ1(CD000015)';
comment on column CLM.TB_CSM_CORPORATION.national_economy_depart2
  is '���񾭼���ҵ2(CD000015)';
comment on column CLM.TB_CSM_CORPORATION.national_economy_depart3
  is '���񾭼���ҵ3(CD000015)';
comment on column CLM.TB_CSM_CORPORATION.national_economy_depart4
  is '���񾭼���ҵ4(CD000015)';
comment on column CLM.TB_CSM_CORPORATION.found_date
  is '��������';
comment on column CLM.TB_CSM_CORPORATION.reg_capital
  is 'ע���ʱ�';
comment on column CLM.TB_CSM_CORPORATION.reg_cptl_curr
  is 'ע���ʱ�����(CD000019)';
comment on column CLM.TB_CSM_CORPORATION.unit_scale
  is '��ҵ��ģ(CD000020)';
comment on column CLM.TB_CSM_CORPORATION.emp_number
  is '��ҵԱ������';
comment on column CLM.TB_CSM_CORPORATION.pay_credit_flag
  is '�Ƿ��������(CD000167)';
comment on column CLM.TB_CSM_CORPORATION.country_code
  is '�������(CD000001)';
comment on column CLM.TB_CSM_CORPORATION.credit_organ_code
  is '�������ô���';
comment on column CLM.TB_CSM_CORPORATION.busin_scope
  is '��Ӫ��Χ';
comment on column CLM.TB_CSM_CORPORATION.bank_cust_type1
  is 'ͬҵ�ͻ�����1(CD000218)';
comment on column CLM.TB_CSM_CORPORATION.bank_cust_type2
  is 'ͬҵ�ͻ�����2(CD000218)';
comment on column CLM.TB_CSM_CORPORATION.bank_pay_sys_num
  is '�����ִ���֧��ϵͳ�����к�';
comment on column CLM.TB_CSM_CORPORATION.group_credit_indicator
  is '�������ű�־(CD000167)';
comment on column CLM.TB_CSM_CORPORATION.bank_indicator
  is '���к�������־(CD000167)';
comment on column CLM.TB_CSM_CORPORATION.rel_party_ind
  is '���й�������־(CD000167)';
comment on column CLM.TB_CSM_CORPORATION.swift_code
  is 'SWIFT����';
comment on column CLM.TB_CSM_CORPORATION.bene_cust_type
  is '�Թ��ͻ�����(1- ��ҵ 2- ��˾ 3- ����  4- ��ʶ��ͻ�)';
comment on column CLM.TB_CSM_CORPORATION.remarks
  is '��ע';
comment on column CLM.TB_CSM_CORPORATION.created_ts
  is '����ECIF����';
comment on column CLM.TB_CSM_CORPORATION.last_updated_org
  is '����������';
comment on column CLM.TB_CSM_CORPORATION.last_updated_te
  is '��������Ա';
comment on column CLM.TB_CSM_CORPORATION.create_time
  is '����ʱ��';
comment on column CLM.TB_CSM_CORPORATION.update_time
  is '����ʱ��';
alter table CLM.TB_CSM_CORPORATION
  add constraint P_KEY_126 primary key (CUSTOMER_NUM)
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
prompt Creating table TB_CSM_GROUP_COMPANY
prompt ===================================
prompt
create table CLM.TB_CSM_GROUP_COMPANY
(
  customer_num     VARCHAR2(10) not null,
  register_num     VARCHAR2(50),
  total_assets     NUMBER(18,2),
  liability_sum    NUMBER(18,2),
  cust_status      VARCHAR2(1),
  group_member_num NUMBER(8),
  status           VARCHAR2(100),
  channel          VARCHAR2(18),
  entmark          VARCHAR2(100),
  tmpentmark       VARCHAR2(100),
  in_src           VARCHAR2(18),
  create_time      DATE,
  update_time      DATE
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
comment on table CLM.TB_CSM_GROUP_COMPANY
  is '���ſͻ�';
comment on column CLM.TB_CSM_GROUP_COMPANY.customer_num
  is '�ͻ����';
comment on column CLM.TB_CSM_GROUP_COMPANY.register_num
  is 'ע��ǼǺ���';
comment on column CLM.TB_CSM_GROUP_COMPANY.total_assets
  is '�ʲ��ܶ�';
comment on column CLM.TB_CSM_GROUP_COMPANY.liability_sum
  is '��ծ�ܶ�';
comment on column CLM.TB_CSM_GROUP_COMPANY.cust_status
  is '�ͻ�״̬';
comment on column CLM.TB_CSM_GROUP_COMPANY.group_member_num
  is '���ų�Ա��';
comment on column CLM.TB_CSM_GROUP_COMPANY.status
  is '״̬��:XD_KHCD0231��';
comment on column CLM.TB_CSM_GROUP_COMPANY.channel
  is '����';
comment on column CLM.TB_CSM_GROUP_COMPANY.entmark
  is '�̺�';
comment on column CLM.TB_CSM_GROUP_COMPANY.tmpentmark
  is 'tmp�̺�';
comment on column CLM.TB_CSM_GROUP_COMPANY.in_src
  is '��Դϵͳ';
comment on column CLM.TB_CSM_GROUP_COMPANY.create_time
  is '����ʱ��';
comment on column CLM.TB_CSM_GROUP_COMPANY.update_time
  is '����ʱ��';
alter table CLM.TB_CSM_GROUP_COMPANY
  add constraint P_KEY_127 primary key (CUSTOMER_NUM)
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
prompt Creating table TB_CSM_GROUP_MEMBER
prompt ==================================
prompt
create table CLM.TB_CSM_GROUP_MEMBER
(
  id                  VARCHAR2(32) not null,
  customer_num        VARCHAR2(10) not null,
  member_customer_num VARCHAR2(32) not null,
  status              VARCHAR2(6),
  update_time         DATE,
  create_time         DATE,
  member_rel_type     VARCHAR2(6)
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
comment on table CLM.TB_CSM_GROUP_MEMBER
  is '���ų�Ա��';
comment on column CLM.TB_CSM_GROUP_MEMBER.id
  is '����ID';
comment on column CLM.TB_CSM_GROUP_MEMBER.customer_num
  is '�ͻ����';
comment on column CLM.TB_CSM_GROUP_MEMBER.member_customer_num
  is '��Ա�ͻ����';
comment on column CLM.TB_CSM_GROUP_MEMBER.status
  is '������ϵ״̬';
comment on column CLM.TB_CSM_GROUP_MEMBER.update_time
  is '����ʱ��';
comment on column CLM.TB_CSM_GROUP_MEMBER.create_time
  is '����ʱ��';
comment on column CLM.TB_CSM_GROUP_MEMBER.member_rel_type
  is '��Ա��ϵ���ͣ�CD000213��';
alter table CLM.TB_CSM_GROUP_MEMBER
  add constraint P_KEY_128 primary key (ID)
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
prompt Creating table TB_CSM_GUAR_GROUP
prompt ================================
prompt
create table CLM.TB_CSM_GUAR_GROUP
(
  customer_num           VARCHAR2(10) not null,
  joint_guarantee_type   VARCHAR2(6),
  manage_way             VARCHAR2(30),
  joint_guarantee_status VARCHAR2(20),
  is_dif_org_guarantee   VARCHAR2(1),
  create_date            DATE,
  update_date            DATE
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on table CLM.TB_CSM_GUAR_GROUP
  is '����С��';
comment on column CLM.TB_CSM_GUAR_GROUP.customer_num
  is '�ͻ����';
comment on column CLM.TB_CSM_GUAR_GROUP.joint_guarantee_type
  is '����С������(CD000083';
comment on column CLM.TB_CSM_GUAR_GROUP.manage_way
  is 'ְ��С�����ʽ';
comment on column CLM.TB_CSM_GUAR_GROUP.joint_guarantee_status
  is '����С��״̬(CD000084';
comment on column CLM.TB_CSM_GUAR_GROUP.is_dif_org_guarantee
  is '�Ƿ�����������(�ǣ�1����0)';
comment on column CLM.TB_CSM_GUAR_GROUP.create_date
  is '����ʱ��';
comment on column CLM.TB_CSM_GUAR_GROUP.update_date
  is '����ʱ��';
alter table CLM.TB_CSM_GUAR_GROUP
  add constraint P_KEY_129 primary key (CUSTOMER_NUM)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table TB_CSM_GUAR_MEMEBER
prompt ==================================
prompt
create table CLM.TB_CSM_GUAR_MEMEBER
(
  id                  VARCHAR2(32) not null,
  customer_num        VARCHAR2(10) not null,
  member_customer_num VARCHAR2(32) not null,
  status              VARCHAR2(20),
  create_time         DATE,
  update_time         DATE
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on table CLM.TB_CSM_GUAR_MEMEBER
  is '����С���Ա';
comment on column CLM.TB_CSM_GUAR_MEMEBER.id
  is '����';
comment on column CLM.TB_CSM_GUAR_MEMEBER.customer_num
  is '�ͻ����';
comment on column CLM.TB_CSM_GUAR_MEMEBER.member_customer_num
  is '��Ա�ͻ����';
comment on column CLM.TB_CSM_GUAR_MEMEBER.status
  is '��Ա״̬';
comment on column CLM.TB_CSM_GUAR_MEMEBER.create_time
  is '����ʱ��';
comment on column CLM.TB_CSM_GUAR_MEMEBER.update_time
  is '����ʱ��';
alter table CLM.TB_CSM_GUAR_MEMEBER
  add constraint P_KEY_130 primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table TB_CSM_INDIVIDUAL
prompt ================================
prompt
create table CLM.TB_CSM_INDIVIDUAL
(
  customer_num       VARCHAR2(10) not null,
  customer_type      VARCHAR2(2),
  cust_status        VARCHAR2(1),
  cust_name          VARCHAR2(200),
  pinyin_name        VARCHAR2(200),
  gender             VARCHAR2(1),
  nation             VARCHAR2(3),
  race               VARCHAR2(3),
  birth_date         VARCHAR2(20),
  poli_status        VARCHAR2(2),
  marr_status        VARCHAR2(2),
  emp_stat           VARCHAR2(2),
  house_cicts        VARCHAR2(6),
  house_type         VARCHAR2(1),
  healthy_status     VARCHAR2(1),
  family_num         VARCHAR2(2),
  education          VARCHAR2(2),
  high_acade_degree  VARCHAR2(3),
  cust_manager_no    VARCHAR2(6),
  work_unit_name     VARCHAR2(200),
  work_industry      VARCHAR2(8),
  unit_character     VARCHAR2(9),
  duty               VARCHAR2(1),
  occupation1        VARCHAR2(5),
  occupation2        VARCHAR2(5),
  occupation3        VARCHAR2(5),
  occupation_explain VARCHAR2(30),
  tech_tiyle_level   VARCHAR2(1),
  pay_credit_flag    VARCHAR2(1),
  is_blank_flag      VARCHAR2(1),
  employee_flag      VARCHAR2(1),
  agri_related_ind   VARCHAR2(1),
  seior_execu_ind    VARCHAR2(1),
  rel_party_ind      VARCHAR2(1),
  per_year_income    NUMBER(18,2),
  tax_res_type       VARCHAR2(1),
  resid_situat       VARCHAR2(1),
  cust_grade         VARCHAR2(1),
  cust_satis         VARCHAR2(1),
  per_total_asset    NUMBER(18,2),
  liability_balance  NUMBER(18,2),
  per_assest_type    VARCHAR2(2),
  per_liab_type      VARCHAR2(2),
  resid_non_resid    VARCHAR2(2),
  created_ts         VARCHAR2(10),
  last_updated_org   VARCHAR2(5),
  last_updated_te    VARCHAR2(6),
  create_time        DATE,
  update_time        DATE
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
comment on table CLM.TB_CSM_INDIVIDUAL
  is '���˿ͻ�������Ϣ';
comment on column CLM.TB_CSM_INDIVIDUAL.customer_num
  is '�ͻ����';
comment on column CLM.TB_CSM_INDIVIDUAL.customer_type
  is '�ͻ�����(CD000212)';
comment on column CLM.TB_CSM_INDIVIDUAL.cust_status
  is '�ͻ�״̬(CD000032)';
comment on column CLM.TB_CSM_INDIVIDUAL.cust_name
  is '�ͻ�����';
comment on column CLM.TB_CSM_INDIVIDUAL.pinyin_name
  is '�ͻ�ƴ������';
comment on column CLM.TB_CSM_INDIVIDUAL.gender
  is '�Ա�(CD000004)';
comment on column CLM.TB_CSM_INDIVIDUAL.nation
  is '����(CD000001)';
comment on column CLM.TB_CSM_INDIVIDUAL.race
  is '����(CD000005)';
comment on column CLM.TB_CSM_INDIVIDUAL.birth_date
  is '��������';
comment on column CLM.TB_CSM_INDIVIDUAL.poli_status
  is '������ò(CD000006)';
comment on column CLM.TB_CSM_INDIVIDUAL.marr_status
  is '����״��(CD000007)';
comment on column CLM.TB_CSM_INDIVIDUAL.emp_stat
  is '��ҵ״��(CD000008)';
comment on column CLM.TB_CSM_INDIVIDUAL.house_cicts
  is '�������ڳ���(CD000002)';
comment on column CLM.TB_CSM_INDIVIDUAL.house_type
  is '��������(CD000215)';
comment on column CLM.TB_CSM_INDIVIDUAL.healthy_status
  is '����״��(CD000009)';
comment on column CLM.TB_CSM_INDIVIDUAL.family_num
  is '��ͥ��Ա����';
comment on column CLM.TB_CSM_INDIVIDUAL.education
  is '���ѧ��(CD000011)';
comment on column CLM.TB_CSM_INDIVIDUAL.high_acade_degree
  is '���ѧλ(CD000010)';
comment on column CLM.TB_CSM_INDIVIDUAL.cust_manager_no
  is '�ͻ�������';
comment on column CLM.TB_CSM_INDIVIDUAL.work_unit_name
  is '������λȫ��';
comment on column CLM.TB_CSM_INDIVIDUAL.work_industry
  is '������λ������ҵ(CD000015)';
comment on column CLM.TB_CSM_INDIVIDUAL.unit_character
  is '������λ����(CD000026)';
comment on column CLM.TB_CSM_INDIVIDUAL.duty
  is 'ְ��(CD000013)';
comment on column CLM.TB_CSM_INDIVIDUAL.occupation1
  is 'ְҵ1(CD000012)';
comment on column CLM.TB_CSM_INDIVIDUAL.occupation2
  is 'ְҵ2(CD000012)';
comment on column CLM.TB_CSM_INDIVIDUAL.occupation3
  is 'ְҵ3(CD000012)';
comment on column CLM.TB_CSM_INDIVIDUAL.occupation_explain
  is 'ְҵ˵��';
comment on column CLM.TB_CSM_INDIVIDUAL.tech_tiyle_level
  is 'ְ��(CD000014)';
comment on column CLM.TB_CSM_INDIVIDUAL.pay_credit_flag
  is '�Ƿ��������(CD000167)';
comment on column CLM.TB_CSM_INDIVIDUAL.is_blank_flag
  is '���˿ͻ���������־';
comment on column CLM.TB_CSM_INDIVIDUAL.employee_flag
  is 'Ա����־';
comment on column CLM.TB_CSM_INDIVIDUAL.agri_related_ind
  is '�Ƿ���ũ';
comment on column CLM.TB_CSM_INDIVIDUAL.seior_execu_ind
  is '�Ƿ��и߹�';
comment on column CLM.TB_CSM_INDIVIDUAL.rel_party_ind
  is '���й�������־';
comment on column CLM.TB_CSM_INDIVIDUAL.per_year_income
  is '����������';
comment on column CLM.TB_CSM_INDIVIDUAL.tax_res_type
  is '˰�վ������(CD000017)';
comment on column CLM.TB_CSM_INDIVIDUAL.resid_situat
  is '��ס״��(CD000035)';
comment on column CLM.TB_CSM_INDIVIDUAL.cust_grade
  is '�ͻ��ȼ�(CD000216)';
comment on column CLM.TB_CSM_INDIVIDUAL.cust_satis
  is '�ͻ������(CD000217)';
comment on column CLM.TB_CSM_INDIVIDUAL.per_total_asset
  is '�������ʲ�';
comment on column CLM.TB_CSM_INDIVIDUAL.liability_balance
  is '�����ܸ�ծ';
comment on column CLM.TB_CSM_INDIVIDUAL.per_assest_type
  is '�����ʲ�����(CD000046)';
comment on column CLM.TB_CSM_INDIVIDUAL.per_liab_type
  is '���˸�ծ����(CD000045)';
comment on column CLM.TB_CSM_INDIVIDUAL.resid_non_resid
  is '����/�Ǿ���(CD000167)';
comment on column CLM.TB_CSM_INDIVIDUAL.created_ts
  is '��������';
comment on column CLM.TB_CSM_INDIVIDUAL.last_updated_org
  is '��������';
comment on column CLM.TB_CSM_INDIVIDUAL.last_updated_te
  is '������Ա';
comment on column CLM.TB_CSM_INDIVIDUAL.create_time
  is '����ʱ��';
comment on column CLM.TB_CSM_INDIVIDUAL.update_time
  is '�޸�ʱ��';
alter table CLM.TB_CSM_INDIVIDUAL
  add constraint P_KEY_131 primary key (CUSTOMER_NUM)
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
prompt Creating table TB_CSM_MANAGE_TEAM
prompt =================================
prompt
create table CLM.TB_CSM_MANAGE_TEAM
(
  uuid            VARCHAR2(32) not null,
  customer_num    VARCHAR2(10) not null,
  user_num        VARCHAR2(10),
  org_num         VARCHAR2(10),
  user_placing_cd VARCHAR2(6),
  update_time     DATE,
  create_time     DATE
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
comment on table CLM.TB_CSM_MANAGE_TEAM
  is '�����Ŷ�';
comment on column CLM.TB_CSM_MANAGE_TEAM.uuid
  is '�ͻ�����С���Ա��Ψһ��ʶ��һ���û���һ����ɫ���ܶ�Ӧ�����ID(���ڶ���ͻ������Ŷ�)';
comment on column CLM.TB_CSM_MANAGE_TEAM.customer_num
  is '�ͻ����';
comment on column CLM.TB_CSM_MANAGE_TEAM.user_num
  is '�����û�';
comment on column CLM.TB_CSM_MANAGE_TEAM.org_num
  is '�������';
comment on column CLM.TB_CSM_MANAGE_TEAM.user_placing_cd
  is 'Ȩ������';
comment on column CLM.TB_CSM_MANAGE_TEAM.update_time
  is '����ʱ��';
comment on column CLM.TB_CSM_MANAGE_TEAM.create_time
  is '����ʱ��';
alter table CLM.TB_CSM_MANAGE_TEAM
  add constraint P_KEY_132 primary key (UUID)
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
prompt Creating table TB_CSM_PARTY
prompt ===========================
prompt
create table CLM.TB_CSM_PARTY
(
  customer_num  VARCHAR2(10) not null,
  is_bank_rel   VARCHAR2(1),
  customer_type VARCHAR2(1),
  customer_name VARCHAR2(200),
  if_data_move  VARCHAR2(5),
  grade         VARCHAR2(4),
  tran_system   VARCHAR2(12),
  create_time   DATE,
  update_time   DATE
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
comment on table CLM.TB_CSM_PARTY
  is '�ͻ�����';
comment on column CLM.TB_CSM_PARTY.customer_num
  is '�ͻ����';
comment on column CLM.TB_CSM_PARTY.is_bank_rel
  is '�Ƿ����й�����(:YesOrNo)';
comment on column CLM.TB_CSM_PARTY.customer_type
  is '�ͻ�����(CD000212)';
comment on column CLM.TB_CSM_PARTY.customer_name
  is '�ͻ�����';
comment on column CLM.TB_CSM_PARTY.if_data_move
  is '�Ƿ�Ǩ������';
comment on column CLM.TB_CSM_PARTY.grade
  is '������Ϣ';
comment on column CLM.TB_CSM_PARTY.tran_system
  is '����ϵͳ';
comment on column CLM.TB_CSM_PARTY.create_time
  is '����ʱ��';
comment on column CLM.TB_CSM_PARTY.update_time
  is '����ʱ��';
alter table CLM.TB_CSM_PARTY
  add constraint P_KEY_133 primary key (CUSTOMER_NUM)
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
prompt Creating table TB_CSM_PHONE_INFO
prompt ================================
prompt
create table CLM.TB_CSM_PHONE_INFO
(
  phone_id      VARCHAR2(32) not null,
  customer_num  VARCHAR2(10),
  conn_type     VARCHAR2(3),
  inter_code    VARCHAR2(3),
  inland_code   VARCHAR2(4),
  tel_number    VARCHAR2(13),
  exten_num     VARCHAR2(256),
  is_check_flag VARCHAR2(1),
  create_time   DATE,
  update_time   DATE
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
comment on table CLM.TB_CSM_PHONE_INFO
  is '�绰������Ϣ��';
comment on column CLM.TB_CSM_PHONE_INFO.phone_id
  is '�绰ID';
comment on column CLM.TB_CSM_PHONE_INFO.customer_num
  is '�ͻ����';
comment on column CLM.TB_CSM_PHONE_INFO.conn_type
  is '��ϵ����(CD000031)';
comment on column CLM.TB_CSM_PHONE_INFO.inter_code
  is '���ʳ�;����';
comment on column CLM.TB_CSM_PHONE_INFO.inland_code
  is '���ڳ�;����';
comment on column CLM.TB_CSM_PHONE_INFO.tel_number
  is '��ϵ����';
comment on column CLM.TB_CSM_PHONE_INFO.exten_num
  is '�ֻ���';
comment on column CLM.TB_CSM_PHONE_INFO.is_check_flag
  is '�Ƿ��Ѻ�ʵ';
comment on column CLM.TB_CSM_PHONE_INFO.create_time
  is '����ʱ��';
comment on column CLM.TB_CSM_PHONE_INFO.update_time
  is '����ʱ��';
alter table CLM.TB_CSM_PHONE_INFO
  add constraint P_KEY_134 primary key (PHONE_ID)
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
prompt Creating table TB_CSM_RELATION
prompt ==============================
prompt
create table CLM.TB_CSM_RELATION
(
  rel_id              VARCHAR2(32) not null,
  rel_mark            VARCHAR2(2),
  settle_bank_num     VARCHAR2(14),
  sup_settle_bank_num VARCHAR2(14),
  customer_num        VARCHAR2(40),
  rel_customer_num    VARCHAR2(40),
  rel_customer_type   VARCHAR2(2),
  rel_type            VARCHAR2(3),
  cust_name           VARCHAR2(200),
  cert_type           VARCHAR2(2),
  cert_num            VARCHAR2(60),
  gender              VARCHAR2(1),
  unit_scale          VARCHAR2(1),
  create_time         DATE,
  update_time         DATE
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
comment on table CLM.TB_CSM_RELATION
  is '��ϵ��Ϣ��';
comment on column CLM.TB_CSM_RELATION.rel_id
  is '��ϵID';
comment on column CLM.TB_CSM_RELATION.rel_mark
  is '�����������־';
comment on column CLM.TB_CSM_RELATION.settle_bank_num
  is '����֧�������к�';
comment on column CLM.TB_CSM_RELATION.sup_settle_bank_num
  is '�ϼ�����֧�������к�';
comment on column CLM.TB_CSM_RELATION.customer_num
  is '�ͻ����';
comment on column CLM.TB_CSM_RELATION.rel_customer_num
  is '��ϵ�ͻ����';
comment on column CLM.TB_CSM_RELATION.rel_customer_type
  is '��ϵ�ͻ����ͣ�CD000016��';
comment on column CLM.TB_CSM_RELATION.rel_type
  is '�ͻ���ϵ����';
comment on column CLM.TB_CSM_RELATION.cust_name
  is '��ϵ������';
comment on column CLM.TB_CSM_RELATION.cert_type
  is '֤������';
comment on column CLM.TB_CSM_RELATION.cert_num
  is '֤������';
comment on column CLM.TB_CSM_RELATION.gender
  is '�Ա�';
comment on column CLM.TB_CSM_RELATION.unit_scale
  is '��ҵ��ģ';
comment on column CLM.TB_CSM_RELATION.create_time
  is '����ʱ��';
comment on column CLM.TB_CSM_RELATION.update_time
  is '����ʱ��';
alter table CLM.TB_CSM_RELATION
  add constraint P_KEY_135 primary key (REL_ID)
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
prompt Creating table TB_DOC_RELEASE
prompt =============================
prompt
create table CLM.TB_DOC_RELEASE
(
  id            VARCHAR2(36) not null,
  doc_name      VARCHAR2(100),
  doc_root_name VARCHAR2(100),
  doc_type_code VARCHAR2(10),
  doc_type_name VARCHAR2(100),
  doc_suffix    VARCHAR2(10),
  doc_bz        VARCHAR2(200),
  doc_auth      VARCHAR2(10),
  user_num      VARCHAR2(64),
  org_num       VARCHAR2(64),
  create_time   DATE,
  is_release    VARCHAR2(4) default '0',
  is_delete     NUMBER(1) default 0
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
comment on table CLM.TB_DOC_RELEASE
  is '�ĵ������';
comment on column CLM.TB_DOC_RELEASE.id
  is '����';
comment on column CLM.TB_DOC_RELEASE.doc_name
  is '�ĵ�����';
comment on column CLM.TB_DOC_RELEASE.doc_root_name
  is '�ĵ���Ŀ¼����';
comment on column CLM.TB_DOC_RELEASE.doc_type_code
  is '�ĵ�������루�ֵ䣺docCatalog��';
comment on column CLM.TB_DOC_RELEASE.doc_type_name
  is '�ĵ���������';
comment on column CLM.TB_DOC_RELEASE.doc_suffix
  is '�ĵ����ͣ���׺��';
comment on column CLM.TB_DOC_RELEASE.doc_bz
  is '��ע';
comment on column CLM.TB_DOC_RELEASE.doc_auth
  is '�ĵ�Ȩ�ޣ��ֵ䣺docAuth��';
comment on column CLM.TB_DOC_RELEASE.user_num
  is '������id';
comment on column CLM.TB_DOC_RELEASE.org_num
  is '��������id';
comment on column CLM.TB_DOC_RELEASE.create_time
  is '����ʱ��';
comment on column CLM.TB_DOC_RELEASE.is_release
  is '�Ƿ񷢲���0δ������1�ѷ�����';

prompt
prompt Creating table TB_ECIF_ADDR_INFO_MIDDLE
prompt =======================================
prompt
create table CLM.TB_ECIF_ADDR_INFO_MIDDLE
(
  customer_num VARCHAR2(10),
  conn_type    VARCHAR2(3),
  coun_regi    VARCHAR2(3),
  province     VARCHAR2(6),
  city         VARCHAR2(6),
  county       VARCHAR2(6),
  street       VARCHAR2(60),
  detail_addr  VARCHAR2(256),
  eng_addr     VARCHAR2(256),
  post_code    VARCHAR2(6)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on table CLM.TB_ECIF_ADDR_INFO_MIDDLE
  is 'ECIF�ͻ���ַ��Ϣ�м䴦���';
comment on column CLM.TB_ECIF_ADDR_INFO_MIDDLE.customer_num
  is '�ͻ����';
comment on column CLM.TB_ECIF_ADDR_INFO_MIDDLE.conn_type
  is '��ϵ����(CD000031)';
comment on column CLM.TB_ECIF_ADDR_INFO_MIDDLE.coun_regi
  is '��ϵ��ַ����/����(CD000001)';
comment on column CLM.TB_ECIF_ADDR_INFO_MIDDLE.province
  is 'ʡ����(CD000002)';
comment on column CLM.TB_ECIF_ADDR_INFO_MIDDLE.city
  is '�д���(CD000002)';
comment on column CLM.TB_ECIF_ADDR_INFO_MIDDLE.county
  is '�ش���(CD000002)';
comment on column CLM.TB_ECIF_ADDR_INFO_MIDDLE.street
  is '�ֵ���ַ';
comment on column CLM.TB_ECIF_ADDR_INFO_MIDDLE.detail_addr
  is '��ϸ��ַ';
comment on column CLM.TB_ECIF_ADDR_INFO_MIDDLE.eng_addr
  is 'Ӣ�ĵ�ַ';
comment on column CLM.TB_ECIF_ADDR_INFO_MIDDLE.post_code
  is '��������';

prompt
prompt Creating table TB_ECIF_BASE_PER_MIDDLE
prompt ======================================
prompt
create table CLM.TB_ECIF_BASE_PER_MIDDLE
(
  cust_no            VARCHAR2(10),
  cust_type          VARCHAR2(2),
  cust_status        VARCHAR2(1),
  cust_name          VARCHAR2(200),
  pinyin_name        VARCHAR2(200),
  gender             VARCHAR2(1),
  nation             VARCHAR2(2),
  race               VARCHAR2(3),
  birth_date         VARCHAR2(20),
  poli_status        VARCHAR2(2),
  marr_status        VARCHAR2(2),
  emp_stat           VARCHAR2(2),
  house_cicts        VARCHAR2(6),
  house_type         VARCHAR2(1),
  healthy_status     VARCHAR2(1),
  family_num         VARCHAR2(2),
  education          VARCHAR2(2),
  high_acade_degree  VARCHAR2(3),
  cust_manager_no    VARCHAR2(6),
  work_unit_name     VARCHAR2(200),
  work_industry      VARCHAR2(8),
  unit_character     VARCHAR2(9),
  duty               VARCHAR2(1),
  occupation1        VARCHAR2(5),
  occupation2        VARCHAR2(5),
  occupation3        VARCHAR2(5),
  occupation_explain VARCHAR2(30),
  tech_tiyle_level   VARCHAR2(1),
  pay_credit_flag    VARCHAR2(1),
  is_blank_flag      VARCHAR2(1),
  employee_flag      VARCHAR2(1),
  agri_related_ind   VARCHAR2(1),
  seior_execu_ind    VARCHAR2(1),
  rel_party_ind      VARCHAR2(1),
  per_year_income    NUMBER(24,2),
  tax_res_type       VARCHAR2(1),
  resid_situat       VARCHAR2(1),
  cust_grade         VARCHAR2(1),
  cust_satis         VARCHAR2(1),
  per_total_asset    NUMBER(24,2),
  liability_balance  NUMBER(24,2),
  per_assest_type    VARCHAR2(2),
  per_liab_type      VARCHAR2(2),
  resid_non_resid    VARCHAR2(2),
  created_ts         DATE,
  last_updated_org   VARCHAR2(5),
  last_updated_te    VARCHAR2(6)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on table CLM.TB_ECIF_BASE_PER_MIDDLE
  is '��˽�ͻ�������Ϣ�м䴦���';
comment on column CLM.TB_ECIF_BASE_PER_MIDDLE.cust_no
  is '�ͻ����';
comment on column CLM.TB_ECIF_BASE_PER_MIDDLE.cust_type
  is '�ͻ�����';
comment on column CLM.TB_ECIF_BASE_PER_MIDDLE.cust_status
  is '�ͻ�״̬';
comment on column CLM.TB_ECIF_BASE_PER_MIDDLE.cust_name
  is '�ͻ�����';
comment on column CLM.TB_ECIF_BASE_PER_MIDDLE.pinyin_name
  is '�ͻ�ƴ������';
comment on column CLM.TB_ECIF_BASE_PER_MIDDLE.gender
  is '�Ա�';
comment on column CLM.TB_ECIF_BASE_PER_MIDDLE.nation
  is '����';
comment on column CLM.TB_ECIF_BASE_PER_MIDDLE.race
  is '����';
comment on column CLM.TB_ECIF_BASE_PER_MIDDLE.birth_date
  is '��������';
comment on column CLM.TB_ECIF_BASE_PER_MIDDLE.poli_status
  is '������ò';
comment on column CLM.TB_ECIF_BASE_PER_MIDDLE.marr_status
  is '����״��';
comment on column CLM.TB_ECIF_BASE_PER_MIDDLE.emp_stat
  is '��ҵ״��';
comment on column CLM.TB_ECIF_BASE_PER_MIDDLE.house_cicts
  is '�������ڳ���';
comment on column CLM.TB_ECIF_BASE_PER_MIDDLE.house_type
  is '��������';
comment on column CLM.TB_ECIF_BASE_PER_MIDDLE.healthy_status
  is '����״��';
comment on column CLM.TB_ECIF_BASE_PER_MIDDLE.family_num
  is '��ͥ��Ա����';
comment on column CLM.TB_ECIF_BASE_PER_MIDDLE.education
  is '���ѧ��';
comment on column CLM.TB_ECIF_BASE_PER_MIDDLE.high_acade_degree
  is '���ѧλ';
comment on column CLM.TB_ECIF_BASE_PER_MIDDLE.cust_manager_no
  is '�ͻ�������';
comment on column CLM.TB_ECIF_BASE_PER_MIDDLE.work_unit_name
  is '������λȫ��';
comment on column CLM.TB_ECIF_BASE_PER_MIDDLE.work_industry
  is '������λ������ҵ';
comment on column CLM.TB_ECIF_BASE_PER_MIDDLE.unit_character
  is '������λ����';
comment on column CLM.TB_ECIF_BASE_PER_MIDDLE.duty
  is 'ְ��';
comment on column CLM.TB_ECIF_BASE_PER_MIDDLE.occupation1
  is 'ְҵ1';
comment on column CLM.TB_ECIF_BASE_PER_MIDDLE.occupation2
  is 'ְҵ2';
comment on column CLM.TB_ECIF_BASE_PER_MIDDLE.occupation3
  is 'ְҵ3';
comment on column CLM.TB_ECIF_BASE_PER_MIDDLE.occupation_explain
  is 'ְҵ˵��';
comment on column CLM.TB_ECIF_BASE_PER_MIDDLE.tech_tiyle_level
  is 'ְ��';
comment on column CLM.TB_ECIF_BASE_PER_MIDDLE.pay_credit_flag
  is '�Ƿ��������';
comment on column CLM.TB_ECIF_BASE_PER_MIDDLE.is_blank_flag
  is '���˿ͻ���������־';
comment on column CLM.TB_ECIF_BASE_PER_MIDDLE.employee_flag
  is 'Ա����־';
comment on column CLM.TB_ECIF_BASE_PER_MIDDLE.agri_related_ind
  is '�Ƿ���ũ';
comment on column CLM.TB_ECIF_BASE_PER_MIDDLE.seior_execu_ind
  is '�Ƿ��и߹�';
comment on column CLM.TB_ECIF_BASE_PER_MIDDLE.rel_party_ind
  is '���й�������־';
comment on column CLM.TB_ECIF_BASE_PER_MIDDLE.per_year_income
  is '����������';
comment on column CLM.TB_ECIF_BASE_PER_MIDDLE.tax_res_type
  is '˰�վ������';
comment on column CLM.TB_ECIF_BASE_PER_MIDDLE.resid_situat
  is '��ס״��';
comment on column CLM.TB_ECIF_BASE_PER_MIDDLE.cust_grade
  is '�ͻ��ȼ�';
comment on column CLM.TB_ECIF_BASE_PER_MIDDLE.cust_satis
  is '�ͻ������';
comment on column CLM.TB_ECIF_BASE_PER_MIDDLE.per_total_asset
  is '�������ʲ�';
comment on column CLM.TB_ECIF_BASE_PER_MIDDLE.liability_balance
  is '�����ܸ�ծ';
comment on column CLM.TB_ECIF_BASE_PER_MIDDLE.per_assest_type
  is '�����ʲ�����';
comment on column CLM.TB_ECIF_BASE_PER_MIDDLE.per_liab_type
  is '���˸�ծ����';
comment on column CLM.TB_ECIF_BASE_PER_MIDDLE.resid_non_resid
  is '����/�Ǿ���';
comment on column CLM.TB_ECIF_BASE_PER_MIDDLE.created_ts
  is '��������';
comment on column CLM.TB_ECIF_BASE_PER_MIDDLE.last_updated_org
  is '��������';
comment on column CLM.TB_ECIF_BASE_PER_MIDDLE.last_updated_te
  is '������Ա';

prompt
prompt Creating table TB_ECIF_CERT_INFO_MIDDLE
prompt =======================================
prompt
create table CLM.TB_ECIF_CERT_INFO_MIDDLE
(
  customer_num    VARCHAR2(10),
  cert_flag       VARCHAR2(2),
  cert_type       VARCHAR2(2),
  cert_num        VARCHAR2(60),
  issued_inst     VARCHAR2(120),
  cert_start_date VARCHAR2(20),
  cert_end_date   VARCHAR2(20)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on table CLM.TB_ECIF_CERT_INFO_MIDDLE
  is 'ECIF֤����Ϣ�м䴦���';
comment on column CLM.TB_ECIF_CERT_INFO_MIDDLE.customer_num
  is '�ͻ����';
comment on column CLM.TB_ECIF_CERT_INFO_MIDDLE.cert_flag
  is '����֤����ʶ(00Ϊ��֤��01Ϊ��֤��)';
comment on column CLM.TB_ECIF_CERT_INFO_MIDDLE.cert_type
  is '֤������(CD000003)';
comment on column CLM.TB_ECIF_CERT_INFO_MIDDLE.cert_num
  is '֤������';
comment on column CLM.TB_ECIF_CERT_INFO_MIDDLE.issued_inst
  is '֤�����Ż���';
comment on column CLM.TB_ECIF_CERT_INFO_MIDDLE.cert_start_date
  is '֤����Ч����(yyyy-MM-dd)';
comment on column CLM.TB_ECIF_CERT_INFO_MIDDLE.cert_end_date
  is '֤����������(yyyy-MM-dd)';

prompt
prompt Creating table TB_ECIF_CONNECT_INFO_MIDDLE
prompt ==========================================
prompt
create table CLM.TB_ECIF_CONNECT_INFO_MIDDLE
(
  customer_num  VARCHAR2(10),
  conn_type     VARCHAR2(3),
  inter_code    VARCHAR2(3),
  inland_code   VARCHAR2(4),
  tel_number    VARCHAR2(13),
  exten_num     VARCHAR2(256),
  is_check_flag VARCHAR2(1)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on table CLM.TB_ECIF_CONNECT_INFO_MIDDLE
  is 'ECIF�ͻ���ϵ��Ϣ�м䴦���';
comment on column CLM.TB_ECIF_CONNECT_INFO_MIDDLE.customer_num
  is '�ͻ����';
comment on column CLM.TB_ECIF_CONNECT_INFO_MIDDLE.conn_type
  is '��ϵ����(CD000031)';
comment on column CLM.TB_ECIF_CONNECT_INFO_MIDDLE.inter_code
  is '���ʳ�;����';
comment on column CLM.TB_ECIF_CONNECT_INFO_MIDDLE.inland_code
  is '���ڳ�;����';
comment on column CLM.TB_ECIF_CONNECT_INFO_MIDDLE.tel_number
  is '��ϵ����';
comment on column CLM.TB_ECIF_CONNECT_INFO_MIDDLE.exten_num
  is '�ֻ���';
comment on column CLM.TB_ECIF_CONNECT_INFO_MIDDLE.is_check_flag
  is '�Ƿ��Ѻ�ʵ';

prompt
prompt Creating table TB_ECIF_CORPORATION_MIDDLE
prompt =========================================
prompt
create table CLM.TB_ECIF_CORPORATION_MIDDLE
(
  cust_no                  VARCHAR2(10),
  cust_type                VARCHAR2(2),
  cust_status              VARCHAR2(1),
  bank_cust_flag           VARCHAR2(1),
  cust_manager_no          VARCHAR2(6),
  cust_name                VARCHAR2(200),
  org_short_name           VARCHAR2(200),
  cust_eng_name            VARCHAR2(200),
  org_rng_short_name       VARCHAR2(100),
  national_economy_type    VARCHAR2(3),
  national_economy_depart1 VARCHAR2(4),
  national_economy_depart2 VARCHAR2(4),
  national_economy_depart3 VARCHAR2(4),
  national_economy_depart4 VARCHAR2(4),
  found_date               VARCHAR2(20),
  reg_capital              VARCHAR2(24),
  reg_cptl_curr            VARCHAR2(3),
  unit_scale               VARCHAR2(1),
  emp_number               VARCHAR2(8),
  country_code             VARCHAR2(3),
  credit_organ_code        VARCHAR2(18),
  busin_scope              VARCHAR2(256),
  bank_cust_type1          VARCHAR2(4),
  bank_cust_type2          VARCHAR2(4),
  bank_pay_sys_num         VARCHAR2(14),
  group_credit_indicator   VARCHAR2(1),
  bank_indicator           VARCHAR2(1),
  rel_party_ind            VARCHAR2(1),
  swift_code               VARCHAR2(11),
  bene_cust_type           VARCHAR2(1),
  remarks                  VARCHAR2(64),
  created_ts               DATE,
  last_updated_org         VARCHAR2(5),
  last_updated_te          VARCHAR2(6)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on table CLM.TB_ECIF_CORPORATION_MIDDLE
  is '�Թ��ͻ�������Ϣ�м䴦���';
comment on column CLM.TB_ECIF_CORPORATION_MIDDLE.cust_no
  is '�ͻ����';
comment on column CLM.TB_ECIF_CORPORATION_MIDDLE.cust_type
  is '�ͻ�����';
comment on column CLM.TB_ECIF_CORPORATION_MIDDLE.cust_status
  is '�ͻ�״̬';
comment on column CLM.TB_ECIF_CORPORATION_MIDDLE.bank_cust_flag
  is 'ͬҵ�ͻ����ױ�־';
comment on column CLM.TB_ECIF_CORPORATION_MIDDLE.cust_manager_no
  is '�ͻ�������';
comment on column CLM.TB_ECIF_CORPORATION_MIDDLE.cust_name
  is '�ͻ�����';
comment on column CLM.TB_ECIF_CORPORATION_MIDDLE.org_short_name
  is '��֯���ļ��';
comment on column CLM.TB_ECIF_CORPORATION_MIDDLE.cust_eng_name
  is '�ͻ�Ӣ������';
comment on column CLM.TB_ECIF_CORPORATION_MIDDLE.org_rng_short_name
  is '��֯Ӣ�ļ��';
comment on column CLM.TB_ECIF_CORPORATION_MIDDLE.national_economy_type
  is '���񾭼ò���';
comment on column CLM.TB_ECIF_CORPORATION_MIDDLE.national_economy_depart1
  is '���񾭼���ҵ1';
comment on column CLM.TB_ECIF_CORPORATION_MIDDLE.national_economy_depart2
  is '���񾭼���ҵ2';
comment on column CLM.TB_ECIF_CORPORATION_MIDDLE.national_economy_depart3
  is '���񾭼���ҵ3';
comment on column CLM.TB_ECIF_CORPORATION_MIDDLE.national_economy_depart4
  is '���񾭼���ҵ4';
comment on column CLM.TB_ECIF_CORPORATION_MIDDLE.found_date
  is '���Ľ�������';
comment on column CLM.TB_ECIF_CORPORATION_MIDDLE.reg_capital
  is 'ע���ʱ�';
comment on column CLM.TB_ECIF_CORPORATION_MIDDLE.reg_cptl_curr
  is 'ע���ʱ�����';
comment on column CLM.TB_ECIF_CORPORATION_MIDDLE.unit_scale
  is '��ҵ��ģ';
comment on column CLM.TB_ECIF_CORPORATION_MIDDLE.emp_number
  is '��ҵԱ������';
comment on column CLM.TB_ECIF_CORPORATION_MIDDLE.country_code
  is '�������';
comment on column CLM.TB_ECIF_CORPORATION_MIDDLE.credit_organ_code
  is '�������ô���';
comment on column CLM.TB_ECIF_CORPORATION_MIDDLE.busin_scope
  is '��Ӫ��Χ';
comment on column CLM.TB_ECIF_CORPORATION_MIDDLE.bank_cust_type1
  is 'ͬҵ�ͻ�����1';
comment on column CLM.TB_ECIF_CORPORATION_MIDDLE.bank_cust_type2
  is 'ͬҵ�ͻ�����2';
comment on column CLM.TB_ECIF_CORPORATION_MIDDLE.bank_pay_sys_num
  is '�����ִ���֧��ϵͳ�����к�';
comment on column CLM.TB_ECIF_CORPORATION_MIDDLE.group_credit_indicator
  is '�������ű�־';
comment on column CLM.TB_ECIF_CORPORATION_MIDDLE.bank_indicator
  is '���к�������־';
comment on column CLM.TB_ECIF_CORPORATION_MIDDLE.rel_party_ind
  is '���й�������־';
comment on column CLM.TB_ECIF_CORPORATION_MIDDLE.swift_code
  is 'SWIFT����';
comment on column CLM.TB_ECIF_CORPORATION_MIDDLE.bene_cust_type
  is '�Թ��ͻ�����';
comment on column CLM.TB_ECIF_CORPORATION_MIDDLE.remarks
  is '��ע';
comment on column CLM.TB_ECIF_CORPORATION_MIDDLE.created_ts
  is '����ECIF����';
comment on column CLM.TB_ECIF_CORPORATION_MIDDLE.last_updated_org
  is '����������';
comment on column CLM.TB_ECIF_CORPORATION_MIDDLE.last_updated_te
  is '��������Ա';

prompt
prompt Creating table TB_ECIF_RELATION_INFO_MIDDLE
prompt ===========================================
prompt
create table CLM.TB_ECIF_RELATION_INFO_MIDDLE
(
  rel_mark            VARCHAR2(2),
  settle_bank_num     VARCHAR2(14),
  sup_settle_bank_num VARCHAR2(14),
  customer_num        VARCHAR2(40),
  rel_customer_num    VARCHAR2(40),
  rel_customer_type   VARCHAR2(2),
  rel_type            VARCHAR2(3),
  cust_name           VARCHAR2(200),
  cert_type           VARCHAR2(2),
  cert_num            VARCHAR2(60),
  gender              VARCHAR2(1),
  unit_scale          VARCHAR2(1)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on table CLM.TB_ECIF_RELATION_INFO_MIDDLE
  is 'ECIF��ϵ��Ϣ�м䴦���';
comment on column CLM.TB_ECIF_RELATION_INFO_MIDDLE.rel_mark
  is '�����������־';
comment on column CLM.TB_ECIF_RELATION_INFO_MIDDLE.settle_bank_num
  is '����֧�������к�';
comment on column CLM.TB_ECIF_RELATION_INFO_MIDDLE.sup_settle_bank_num
  is '�ϼ�����֧�������к�';
comment on column CLM.TB_ECIF_RELATION_INFO_MIDDLE.customer_num
  is '�ͻ����';
comment on column CLM.TB_ECIF_RELATION_INFO_MIDDLE.rel_customer_num
  is '��ϵ�ͻ����';
comment on column CLM.TB_ECIF_RELATION_INFO_MIDDLE.rel_customer_type
  is '��ϵ�ͻ����ͣ�CD000016��';
comment on column CLM.TB_ECIF_RELATION_INFO_MIDDLE.rel_type
  is '�ͻ���ϵ����';
comment on column CLM.TB_ECIF_RELATION_INFO_MIDDLE.cust_name
  is '��ϵ������';
comment on column CLM.TB_ECIF_RELATION_INFO_MIDDLE.cert_type
  is '֤������';
comment on column CLM.TB_ECIF_RELATION_INFO_MIDDLE.cert_num
  is '֤������';
comment on column CLM.TB_ECIF_RELATION_INFO_MIDDLE.gender
  is '�Ա�';
comment on column CLM.TB_ECIF_RELATION_INFO_MIDDLE.unit_scale
  is '��ҵ��ģ';

prompt
prompt Creating table TB_FLOW_BIZ
prompt ==========================
prompt
create table CLM.TB_FLOW_BIZ
(
  id                    VARCHAR2(32) not null,
  process_definition_id VARCHAR2(64),
  process_instance_id   VARCHAR2(64),
  customer_num          VARCHAR2(32),
  customer_name         VARCHAR2(32),
  biz_num               VARCHAR2(32),
  biz_type              VARCHAR2(10),
  biz_desc              VARCHAR2(255),
  amount                NUMBER(18,2),
  task_user             VARCHAR2(255),
  apply_time            DATE,
  create_user           VARCHAR2(32),
  create_dept           VARCHAR2(32),
  create_time           DATE,
  update_user           VARCHAR2(32),
  update_time           DATE,
  status                NUMBER,
  is_deleted            NUMBER
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on table CLM.TB_FLOW_BIZ
  is '����ҵ���¼��';
comment on column CLM.TB_FLOW_BIZ.id
  is '���';
comment on column CLM.TB_FLOW_BIZ.process_definition_id
  is '���̶�������';
comment on column CLM.TB_FLOW_BIZ.process_instance_id
  is '����ʵ������';
comment on column CLM.TB_FLOW_BIZ.customer_num
  is '�ͻ����';
comment on column CLM.TB_FLOW_BIZ.customer_name
  is '�ͻ�����';
comment on column CLM.TB_FLOW_BIZ.biz_num
  is 'ҵ����';
comment on column CLM.TB_FLOW_BIZ.biz_type
  is 'ҵ������';
comment on column CLM.TB_FLOW_BIZ.biz_desc
  is 'ҵ������';
comment on column CLM.TB_FLOW_BIZ.amount
  is '���';
comment on column CLM.TB_FLOW_BIZ.task_user
  is '��һ��������';
comment on column CLM.TB_FLOW_BIZ.apply_time
  is '����ʱ��';
comment on column CLM.TB_FLOW_BIZ.create_user
  is '������';
comment on column CLM.TB_FLOW_BIZ.create_dept
  is '��������';
comment on column CLM.TB_FLOW_BIZ.create_time
  is '����ʱ��';
comment on column CLM.TB_FLOW_BIZ.update_user
  is '�޸���';
comment on column CLM.TB_FLOW_BIZ.update_time
  is '�޸�ʱ��';
comment on column CLM.TB_FLOW_BIZ.status
  is '״̬';
comment on column CLM.TB_FLOW_BIZ.is_deleted
  is '�Ƿ���ɾ��';
alter table CLM.TB_FLOW_BIZ
  add primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table TB_FRONT_SERVICE_CONFIG
prompt ======================================
prompt
create table CLM.TB_FRONT_SERVICE_CONFIG
(
  id               VARCHAR2(32) not null,
  terminal_code    VARCHAR2(32) default 'NULL',
  service_role     VARCHAR2(10) default 'NULL',
  service_code     VARCHAR2(50) not null,
  service_name     VARCHAR2(100) not null,
  service_adapter  VARCHAR2(100) default 'NULL',
  invoke_mode      VARCHAR2(10) default 'NULL',
  invoke_api       VARCHAR2(200) default 'NULL',
  encode_mode      VARCHAR2(10) default 'NULL',
  message_style    VARCHAR2(10) default 'NULL',
  timeout          NUMBER,
  transaction_mode VARCHAR2(10) default 'NULL',
  version          VARCHAR2(10) default 'NULL',
  status           INTEGER not null,
  remark           VARCHAR2(200) default 'NULL',
  create_dept      VARCHAR2(32) default 'NULL',
  create_user      VARCHAR2(32) default 'NULL',
  create_time      DATE,
  update_user      VARCHAR2(32) default 'NULL',
  update_time      DATE,
  tenant_id        VARCHAR2(12) default 'NULL',
  is_deleted       INTEGER
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
comment on table CLM.TB_FRONT_SERVICE_CONFIG
  is 'ǰ�÷������ñ�';
comment on column CLM.TB_FRONT_SERVICE_CONFIG.id
  is '����';
comment on column CLM.TB_FRONT_SERVICE_CONFIG.terminal_code
  is '�ն˴���';
comment on column CLM.TB_FRONT_SERVICE_CONFIG.service_role
  is '�����ɫ';
comment on column CLM.TB_FRONT_SERVICE_CONFIG.service_code
  is '�������';
comment on column CLM.TB_FRONT_SERVICE_CONFIG.service_name
  is '��������';
comment on column CLM.TB_FRONT_SERVICE_CONFIG.service_adapter
  is '����������';
comment on column CLM.TB_FRONT_SERVICE_CONFIG.invoke_mode
  is '���÷�ʽ';
comment on column CLM.TB_FRONT_SERVICE_CONFIG.invoke_api
  is '���ýӿ�';
comment on column CLM.TB_FRONT_SERVICE_CONFIG.encode_mode
  is '���뷽ʽ';
comment on column CLM.TB_FRONT_SERVICE_CONFIG.message_style
  is '���ķ��';
comment on column CLM.TB_FRONT_SERVICE_CONFIG.timeout
  is '��ʱ����';
comment on column CLM.TB_FRONT_SERVICE_CONFIG.transaction_mode
  is '����ʽ';
comment on column CLM.TB_FRONT_SERVICE_CONFIG.version
  is '�汾��';
comment on column CLM.TB_FRONT_SERVICE_CONFIG.status
  is '�Ƿ�����';
comment on column CLM.TB_FRONT_SERVICE_CONFIG.remark
  is '��ע';
comment on column CLM.TB_FRONT_SERVICE_CONFIG.create_dept
  is '��������';
comment on column CLM.TB_FRONT_SERVICE_CONFIG.create_user
  is '������';
comment on column CLM.TB_FRONT_SERVICE_CONFIG.create_time
  is '����ʱ��';
comment on column CLM.TB_FRONT_SERVICE_CONFIG.update_user
  is '������';
comment on column CLM.TB_FRONT_SERVICE_CONFIG.update_time
  is '����ʱ��';
comment on column CLM.TB_FRONT_SERVICE_CONFIG.tenant_id
  is '�⻧���';
comment on column CLM.TB_FRONT_SERVICE_CONFIG.is_deleted
  is '�Ƿ�ɾ��';
alter table CLM.TB_FRONT_SERVICE_CONFIG
  add primary key (ID)
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
prompt Creating table TB_FRONT_SERVICE_RECORD
prompt ======================================
prompt
create table CLM.TB_FRONT_SERVICE_RECORD
(
  id               VARCHAR2(32) not null,
  group_id         VARCHAR2(32) default 'NULL',
  requestor_code   VARCHAR2(10) not null,
  responder_code   VARCHAR2(10) not null,
  request_message  CLOB,
  response_message CLOB,
  status           INTEGER,
  create_time      DATE,
  update_time      DATE,
  tenant_id        VARCHAR2(12) default 'NULL',
  remark           VARCHAR2(200) default 'NULL',
  service_code     VARCHAR2(50) default 'NULL',
  service_sn       VARCHAR2(50) default 'NULL',
  service_time     DATE,
  biz_sn           VARCHAR2(50) default 'NULL',
  retry_count      INTEGER
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
comment on table CLM.TB_FRONT_SERVICE_RECORD
  is 'ǰ�÷����¼��';
comment on column CLM.TB_FRONT_SERVICE_RECORD.id
  is '��¼ID';
comment on column CLM.TB_FRONT_SERVICE_RECORD.group_id
  is '����ID';
comment on column CLM.TB_FRONT_SERVICE_RECORD.requestor_code
  is '�����ն�';
comment on column CLM.TB_FRONT_SERVICE_RECORD.responder_code
  is '��Ӧ�ն�';
comment on column CLM.TB_FRONT_SERVICE_RECORD.request_message
  is '������';
comment on column CLM.TB_FRONT_SERVICE_RECORD.response_message
  is '��Ӧ����';
comment on column CLM.TB_FRONT_SERVICE_RECORD.status
  is '����״̬';
comment on column CLM.TB_FRONT_SERVICE_RECORD.create_time
  is '����ʱ��';
comment on column CLM.TB_FRONT_SERVICE_RECORD.update_time
  is '�޸�ʱ��';
comment on column CLM.TB_FRONT_SERVICE_RECORD.tenant_id
  is '�⻧ID';
comment on column CLM.TB_FRONT_SERVICE_RECORD.remark
  is '��ע';
comment on column CLM.TB_FRONT_SERVICE_RECORD.service_code
  is '�������';
comment on column CLM.TB_FRONT_SERVICE_RECORD.service_sn
  is '������ˮ��';
comment on column CLM.TB_FRONT_SERVICE_RECORD.service_time
  is '����ʱ��';
comment on column CLM.TB_FRONT_SERVICE_RECORD.biz_sn
  is 'ҵ����ˮ��';
comment on column CLM.TB_FRONT_SERVICE_RECORD.retry_count
  is '���Դ���';
alter table CLM.TB_FRONT_SERVICE_RECORD
  add primary key (ID)
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
prompt Creating table TB_FRONT_TERMINAL_CONFIG
prompt =======================================
prompt
create table CLM.TB_FRONT_TERMINAL_CONFIG
(
  id                  VARCHAR2(32) not null,
  terminal_code       VARCHAR2(20),
  terminal_name       VARCHAR2(100),
  terminal_short_name VARCHAR2(50),
  terminal_role       VARCHAR2(10),
  send_address        VARCHAR2(100),
  receive_address     VARCHAR2(100),
  connect_mode        VARCHAR2(10),
  is_auth             NUMBER,
  token               VARCHAR2(200),
  remark              VARCHAR2(200),
  parent_terminal_id  VARCHAR2(32),
  create_dept         VARCHAR2(32),
  create_user         VARCHAR2(32),
  create_time         DATE,
  update_user         VARCHAR2(32),
  update_time         DATE,
  tenant_id           VARCHAR2(12),
  is_deleted          INTEGER,
  status              NUMBER
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
comment on table CLM.TB_FRONT_TERMINAL_CONFIG
  is 'ǰ���ն����ñ�';
comment on column CLM.TB_FRONT_TERMINAL_CONFIG.id
  is '����';
comment on column CLM.TB_FRONT_TERMINAL_CONFIG.terminal_code
  is '�ն˴���';
comment on column CLM.TB_FRONT_TERMINAL_CONFIG.terminal_name
  is '�ն�����';
comment on column CLM.TB_FRONT_TERMINAL_CONFIG.terminal_short_name
  is '�ն���д';
comment on column CLM.TB_FRONT_TERMINAL_CONFIG.send_address
  is '���͵�ַ';
comment on column CLM.TB_FRONT_TERMINAL_CONFIG.receive_address
  is '���յ�ַ';
comment on column CLM.TB_FRONT_TERMINAL_CONFIG.connect_mode
  is '���ӷ�ʽ';
comment on column CLM.TB_FRONT_TERMINAL_CONFIG.is_auth
  is '�Ƿ���Ȩ';
comment on column CLM.TB_FRONT_TERMINAL_CONFIG.token
  is 'У����';
comment on column CLM.TB_FRONT_TERMINAL_CONFIG.remark
  is '��ע';
comment on column CLM.TB_FRONT_TERMINAL_CONFIG.parent_terminal_id
  is '�����ն�';
comment on column CLM.TB_FRONT_TERMINAL_CONFIG.create_dept
  is '��������';
comment on column CLM.TB_FRONT_TERMINAL_CONFIG.create_user
  is '������';
comment on column CLM.TB_FRONT_TERMINAL_CONFIG.create_time
  is '����ʱ��';
comment on column CLM.TB_FRONT_TERMINAL_CONFIG.update_user
  is '�޸���';
comment on column CLM.TB_FRONT_TERMINAL_CONFIG.update_time
  is '�޸�ʱ��';
comment on column CLM.TB_FRONT_TERMINAL_CONFIG.tenant_id
  is '�⻧ID';
comment on column CLM.TB_FRONT_TERMINAL_CONFIG.is_deleted
  is '�Ƿ���ɾ��';
alter table CLM.TB_FRONT_TERMINAL_CONFIG
  add primary key (ID)
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
prompt Creating table TB_FUND_ADMIT_DETAIL
prompt ===================================
prompt
create table CLM.TB_FUND_ADMIT_DETAIL
(
  event_detail_id   VARCHAR2(32) not null,
  event_main_id     VARCHAR2(32) not null,
  tran_seq_sn       VARCHAR2(40) not null,
  tran_date         VARCHAR2(20) not null,
  customer_num      VARCHAR2(40),
  crd_status        VARCHAR2(10),
  crd_detail_prd    VARCHAR2(10),
  crd_admit_flag    VARCHAR2(10),
  frozen_req_date   VARCHAR2(20),
  frozen_begin_date VARCHAR2(20),
  frozen_end_date   VARCHAR2(20),
  crd_grant_org_num VARCHAR2(10)
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
comment on table CLM.TB_FUND_ADMIT_DETAIL
  is '�ʽ�ͻ�״̬ά����ϸ';
comment on column CLM.TB_FUND_ADMIT_DETAIL.event_detail_id
  is '����ID';
comment on column CLM.TB_FUND_ADMIT_DETAIL.event_main_id
  is '����ID';
comment on column CLM.TB_FUND_ADMIT_DETAIL.tran_seq_sn
  is '������ˮ��';
comment on column CLM.TB_FUND_ADMIT_DETAIL.tran_date
  is '��������';
comment on column CLM.TB_FUND_ADMIT_DETAIL.customer_num
  is 'ECIF�ͻ���';
comment on column CLM.TB_FUND_ADMIT_DETAIL.crd_status
  is '���״̬';
comment on column CLM.TB_FUND_ADMIT_DETAIL.crd_detail_prd
  is '������Ȳ�Ʒ';
comment on column CLM.TB_FUND_ADMIT_DETAIL.crd_admit_flag
  is '�ͻ�׼���ʶ';
comment on column CLM.TB_FUND_ADMIT_DETAIL.frozen_req_date
  is '������������';
comment on column CLM.TB_FUND_ADMIT_DETAIL.frozen_begin_date
  is '���Ὺʼ����';
comment on column CLM.TB_FUND_ADMIT_DETAIL.frozen_end_date
  is '�����������';
comment on column CLM.TB_FUND_ADMIT_DETAIL.crd_grant_org_num
  is '���Ż���';

prompt
prompt Creating table TB_FUND_ADMIT_DETAIL_MIDDLE
prompt ==========================================
prompt
create table CLM.TB_FUND_ADMIT_DETAIL_MIDDLE
(
  tran_seq_sn       VARCHAR2(40),
  tran_date         VARCHAR2(20),
  customer_num      VARCHAR2(40),
  crd_status        VARCHAR2(10),
  frozen_req_date   VARCHAR2(20),
  frozen_begin_date VARCHAR2(20),
  frozen_over_date  VARCHAR2(20),
  crd_detail_prd    VARCHAR2(10),
  crd_admit_flag    VARCHAR2(10)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on table CLM.TB_FUND_ADMIT_DETAIL_MIDDLE
  is '�ʽ�ͻ�״̬ά����ϸ';
comment on column CLM.TB_FUND_ADMIT_DETAIL_MIDDLE.tran_seq_sn
  is '������ˮ��';
comment on column CLM.TB_FUND_ADMIT_DETAIL_MIDDLE.tran_date
  is '��������';
comment on column CLM.TB_FUND_ADMIT_DETAIL_MIDDLE.customer_num
  is 'ECIF�ͻ���';
comment on column CLM.TB_FUND_ADMIT_DETAIL_MIDDLE.crd_status
  is '���״̬';
comment on column CLM.TB_FUND_ADMIT_DETAIL_MIDDLE.frozen_req_date
  is '������������';
comment on column CLM.TB_FUND_ADMIT_DETAIL_MIDDLE.frozen_begin_date
  is '���Ὺʼ����';
comment on column CLM.TB_FUND_ADMIT_DETAIL_MIDDLE.frozen_over_date
  is '�����������';
comment on column CLM.TB_FUND_ADMIT_DETAIL_MIDDLE.crd_detail_prd
  is '������Ȳ�Ʒ';
comment on column CLM.TB_FUND_ADMIT_DETAIL_MIDDLE.crd_admit_flag
  is '�ͻ�׼���ʶ';

prompt
prompt Creating table TB_FUND_ADMIT_MAIN
prompt =================================
prompt
create table CLM.TB_FUND_ADMIT_MAIN
(
  event_main_id     VARCHAR2(32) not null,
  tran_seq_sn       VARCHAR2(40) not null,
  tran_date         VARCHAR2(20) not null,
  busi_deal_num     VARCHAR2(40),
  tran_type_cd      VARCHAR2(2),
  tran_event_status VARCHAR2(2),
  tran_event_info   VARCHAR2(200),
  tran_acct_status  VARCHAR2(2),
  adjust_flag       VARCHAR2(1),
  adjust_direction  VARCHAR2(1),
  adjust_desc       VARCHAR2(100),
  adjust_status     VARCHAR2(1),
  order_seq_sn      NUMBER,
  tran_system       VARCHAR2(12),
  user_num          VARCHAR2(12)
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
comment on table CLM.TB_FUND_ADMIT_MAIN
  is '�ʽ�ͻ�״̬ά������';
comment on column CLM.TB_FUND_ADMIT_MAIN.event_main_id
  is '�¼�����id';
comment on column CLM.TB_FUND_ADMIT_MAIN.tran_seq_sn
  is 'Ӧ��Ψһȷ�Ͻ���';
comment on column CLM.TB_FUND_ADMIT_MAIN.tran_date
  is '��������';
comment on column CLM.TB_FUND_ADMIT_MAIN.busi_deal_num
  is 'Ӧ��Ψһȷ��ҵ��';
comment on column CLM.TB_FUND_ADMIT_MAIN.tran_type_cd
  is '01 Ȧ��';
comment on column CLM.TB_FUND_ADMIT_MAIN.tran_event_status
  is '0 δ����  1 ����ɹ� 2 ����ʧ��';
comment on column CLM.TB_FUND_ADMIT_MAIN.tran_event_info
  is '�����¼���Ϣ';
comment on column CLM.TB_FUND_ADMIT_MAIN.tran_acct_status
  is '0 δ����  1 ����ɹ� 2 ����ʧ��';
comment on column CLM.TB_FUND_ADMIT_MAIN.adjust_flag
  is '�Ƿ���Ҫ������ʶ��1 ��Ҫ 0 ����Ҫ';
comment on column CLM.TB_FUND_ADMIT_MAIN.adjust_direction
  is '��������1 ���� 0 ���';
comment on column CLM.TB_FUND_ADMIT_MAIN.adjust_desc
  is '��������';
comment on column CLM.TB_FUND_ADMIT_MAIN.adjust_status
  is '1�������ɹ� 0������ʧ��';
comment on column CLM.TB_FUND_ADMIT_MAIN.order_seq_sn
  is '�����:��������ˮ�Ŵӵ���λ��ʼ��ȡ�����һλ����ת��λINTEGER��ȡ��';
comment on column CLM.TB_FUND_ADMIT_MAIN.tran_system
  is '�������';
comment on column CLM.TB_FUND_ADMIT_MAIN.user_num
  is '������';

prompt
prompt Creating table TB_FUND_ADMIT_MAIN_MIDDLE
prompt ========================================
prompt
create table CLM.TB_FUND_ADMIT_MAIN_MIDDLE
(
  tran_seq_sn   VARCHAR2(40),
  tran_date     VARCHAR2(20),
  busi_deal_num VARCHAR2(40),
  tran_type_cd  VARCHAR2(2),
  tran_system   VARCHAR2(12),
  user_num      VARCHAR2(12)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on table CLM.TB_FUND_ADMIT_MAIN_MIDDLE
  is '�ʽ�ͻ�״̬ά������';
comment on column CLM.TB_FUND_ADMIT_MAIN_MIDDLE.tran_seq_sn
  is 'Ӧ��Ψһȷ�Ͻ���';
comment on column CLM.TB_FUND_ADMIT_MAIN_MIDDLE.tran_date
  is '��������';
comment on column CLM.TB_FUND_ADMIT_MAIN_MIDDLE.busi_deal_num
  is 'Ӧ��Ψһȷ��ҵ��';
comment on column CLM.TB_FUND_ADMIT_MAIN_MIDDLE.tran_type_cd
  is '01 Ȧ��';
comment on column CLM.TB_FUND_ADMIT_MAIN_MIDDLE.tran_system
  is '�������';
comment on column CLM.TB_FUND_ADMIT_MAIN_MIDDLE.user_num
  is '������';

prompt
prompt Creating table TB_FUND_EARMARK_ALLOT
prompt ====================================
prompt
create table CLM.TB_FUND_EARMARK_ALLOT
(
  event_detail_id    VARCHAR2(32) not null,
  event_main_id      VARCHAR2(32) not null,
  tran_seq_sn        VARCHAR2(40) not null,
  tran_date          VARCHAR2(20) not null,
  customer_num       VARCHAR2(40),
  crd_detail_prd     VARCHAR2(10),
  crd_currency_cd    VARCHAR2(10),
  crd_allot_org_num  VARCHAR2(6),
  crd_alloc_amt      NUMBER(24,6),
  earmark_begin_date VARCHAR2(20),
  earmark_end_date   VARCHAR2(20)
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
comment on table CLM.TB_FUND_EARMARK_ALLOT
  is '�ʽ�����Ȧ�����';
comment on column CLM.TB_FUND_EARMARK_ALLOT.event_detail_id
  is '����ID';
comment on column CLM.TB_FUND_EARMARK_ALLOT.event_main_id
  is '����ID';
comment on column CLM.TB_FUND_EARMARK_ALLOT.tran_seq_sn
  is '������ˮ��';
comment on column CLM.TB_FUND_EARMARK_ALLOT.tran_date
  is '��������';
comment on column CLM.TB_FUND_EARMARK_ALLOT.customer_num
  is 'ECIF�ͻ���';
comment on column CLM.TB_FUND_EARMARK_ALLOT.crd_detail_prd
  is '������Ȳ�Ʒ';
comment on column CLM.TB_FUND_EARMARK_ALLOT.crd_currency_cd
  is '����';
comment on column CLM.TB_FUND_EARMARK_ALLOT.crd_allot_org_num
  is '�����Ա��';
comment on column CLM.TB_FUND_EARMARK_ALLOT.crd_alloc_amt
  is '������';
comment on column CLM.TB_FUND_EARMARK_ALLOT.earmark_begin_date
  is 'Ȧ�濪ʼ��';
comment on column CLM.TB_FUND_EARMARK_ALLOT.earmark_end_date
  is 'Ȧ�浽����';

prompt
prompt Creating table TB_FUND_EARMARK_ALLOT_MIDDLE
prompt ===========================================
prompt
create table CLM.TB_FUND_EARMARK_ALLOT_MIDDLE
(
  tran_seq_sn        VARCHAR2(40),
  tran_date          VARCHAR2(20),
  customer_num       VARCHAR2(40),
  crd_detail_prd     VARCHAR2(10),
  crd_currency_cd    VARCHAR2(10),
  crd_allot_org_num  VARCHAR2(6),
  crd_alloc_amt      NUMBER(24,6),
  earmark_begin_date VARCHAR2(20),
  earmark_end_date   VARCHAR2(20)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on table CLM.TB_FUND_EARMARK_ALLOT_MIDDLE
  is '�ʽ�����Ȧ�����-�м��';
comment on column CLM.TB_FUND_EARMARK_ALLOT_MIDDLE.tran_seq_sn
  is '������ˮ��';
comment on column CLM.TB_FUND_EARMARK_ALLOT_MIDDLE.tran_date
  is '��������';
comment on column CLM.TB_FUND_EARMARK_ALLOT_MIDDLE.customer_num
  is 'ECIF�ͻ���';
comment on column CLM.TB_FUND_EARMARK_ALLOT_MIDDLE.crd_detail_prd
  is '���������Ʒ��';
comment on column CLM.TB_FUND_EARMARK_ALLOT_MIDDLE.crd_currency_cd
  is '����';
comment on column CLM.TB_FUND_EARMARK_ALLOT_MIDDLE.crd_allot_org_num
  is '�����Ա��';
comment on column CLM.TB_FUND_EARMARK_ALLOT_MIDDLE.crd_alloc_amt
  is '������';
comment on column CLM.TB_FUND_EARMARK_ALLOT_MIDDLE.earmark_begin_date
  is 'Ȧ�濪ʼ��';
comment on column CLM.TB_FUND_EARMARK_ALLOT_MIDDLE.earmark_end_date
  is 'Ȧ�浽����';

prompt
prompt Creating table TB_FUND_EARMARK_MAIN
prompt ===================================
prompt
create table CLM.TB_FUND_EARMARK_MAIN
(
  event_main_id     VARCHAR2(32) not null,
  tran_seq_sn       VARCHAR2(40) not null,
  tran_date         VARCHAR2(20) not null,
  busi_deal_num     VARCHAR2(40),
  tran_type_cd      VARCHAR2(2),
  crd_eark_amt      NUMBER(18,2),
  crd_currency_cd   VARCHAR2(10),
  tran_event_status VARCHAR2(1),
  tran_event_info   VARCHAR2(100),
  tran_acct_status  VARCHAR2(1),
  adjust_flag       VARCHAR2(1),
  adjust_direction  VARCHAR2(1),
  adjust_desc       VARCHAR2(100),
  adjust_status     VARCHAR2(1),
  tran_system       VARCHAR2(12),
  user_num          VARCHAR2(12),
  order_seq_sn      NUMBER
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
comment on table CLM.TB_FUND_EARMARK_MAIN
  is '�ʽ�����Ȧ������';
comment on column CLM.TB_FUND_EARMARK_MAIN.event_main_id
  is '����ID';
comment on column CLM.TB_FUND_EARMARK_MAIN.tran_seq_sn
  is 'Ӧ��Ψһȷ�Ͻ���';
comment on column CLM.TB_FUND_EARMARK_MAIN.tran_date
  is '��������';
comment on column CLM.TB_FUND_EARMARK_MAIN.busi_deal_num
  is 'Ӧ��Ψһȷ��ҵ��';
comment on column CLM.TB_FUND_EARMARK_MAIN.tran_type_cd
  is '01 Ȧ��';
comment on column CLM.TB_FUND_EARMARK_MAIN.crd_eark_amt
  is 'Ȧ����';
comment on column CLM.TB_FUND_EARMARK_MAIN.crd_currency_cd
  is '����(CD000019)';
comment on column CLM.TB_FUND_EARMARK_MAIN.tran_event_status
  is '��������״̬:0 δ����  1 ����ɹ� 2 ����ʧ��';
comment on column CLM.TB_FUND_EARMARK_MAIN.tran_event_info
  is '�¼�������Ϣ';
comment on column CLM.TB_FUND_EARMARK_MAIN.tran_acct_status
  is '�Է�����״̬:0 δ����  1 ����ɹ� 2 ����ʧ��';
comment on column CLM.TB_FUND_EARMARK_MAIN.adjust_flag
  is '�Ƿ���Ҫ������ʶ��1 ��Ҫ 0 ����Ҫ';
comment on column CLM.TB_FUND_EARMARK_MAIN.adjust_direction
  is '��������1 ���� 0 ���';
comment on column CLM.TB_FUND_EARMARK_MAIN.adjust_desc
  is '��������';
comment on column CLM.TB_FUND_EARMARK_MAIN.adjust_status
  is '1�������ɹ� 0������ʧ��';
comment on column CLM.TB_FUND_EARMARK_MAIN.tran_system
  is '�������';
comment on column CLM.TB_FUND_EARMARK_MAIN.user_num
  is '������';
comment on column CLM.TB_FUND_EARMARK_MAIN.order_seq_sn
  is 'ͨ��TRAN_SEQ_SN ������� ��������INTEGER(( SUBSTR( T1.TRAN_SEQ_SN,3,LENGTH(T1.TRAN_SEQ_SN) - 2)))';

prompt
prompt Creating table TB_FUND_EARMARK_MAIN_MIDDLE
prompt ==========================================
prompt
create table CLM.TB_FUND_EARMARK_MAIN_MIDDLE
(
  tran_seq_sn     VARCHAR2(40),
  tran_date       VARCHAR2(20),
  busi_deal_num   VARCHAR2(40),
  tran_type_cd    VARCHAR2(2),
  crd_eark_amt    NUMBER(18,2),
  crd_currency_cd VARCHAR2(10),
  tran_system     VARCHAR2(12),
  user_num        VARCHAR2(12)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on table CLM.TB_FUND_EARMARK_MAIN_MIDDLE
  is '�ʽ�����Ȧ������-�м��';
comment on column CLM.TB_FUND_EARMARK_MAIN_MIDDLE.tran_seq_sn
  is 'Ӧ��Ψһȷ�Ͻ���';
comment on column CLM.TB_FUND_EARMARK_MAIN_MIDDLE.tran_date
  is '��������';
comment on column CLM.TB_FUND_EARMARK_MAIN_MIDDLE.busi_deal_num
  is 'Ӧ��Ψһȷ��ҵ��';
comment on column CLM.TB_FUND_EARMARK_MAIN_MIDDLE.tran_type_cd
  is '01 Ȧ��';
comment on column CLM.TB_FUND_EARMARK_MAIN_MIDDLE.crd_eark_amt
  is 'Ȧ����';
comment on column CLM.TB_FUND_EARMARK_MAIN_MIDDLE.crd_currency_cd
  is '����(CD000019)';
comment on column CLM.TB_FUND_EARMARK_MAIN_MIDDLE.tran_system
  is '�������';
comment on column CLM.TB_FUND_EARMARK_MAIN_MIDDLE.user_num
  is '������';

prompt
prompt Creating table TB_FUND_EVENT_DETAIL
prompt ===================================
prompt
create table CLM.TB_FUND_EVENT_DETAIL
(
  event_detailed_id       VARCHAR2(32) not null,
  event_main_id           VARCHAR2(32) not null,
  tran_seq_sn             VARCHAR2(40) not null,
  tran_date               VARCHAR2(20) not null,
  crd_grant_org_num       VARCHAR2(12),
  customer_num            VARCHAR2(40) not null,
  crd_detail_prd          VARCHAR2(10) not null,
  busi_deal_num           VARCHAR2(40) not null,
  busi_prd_num            VARCHAR2(10),
  busi_deal_desc          VARCHAR2(50),
  busi_deal_org_num       VARCHAR2(40),
  busi_deal_org_name      VARCHAR2(100),
  busi_oppt_org_num       VARCHAR2(40),
  busi_oppt_org_name      VARCHAR2(100),
  busi_sum_amt            NUMBER(18,2),
  busi_cert_cnt           NUMBER(24),
  cert_num                VARCHAR2(40) not null,
  cert_type_cd            VARCHAR2(40),
  cert_ppt_cd             VARCHAR2(40),
  cert_interest_period    VARCHAR2(40),
  cert_interest_rate      NUMBER(18,2),
  cert_currency_cd        VARCHAR2(10),
  cert_seq_amt            NUMBER(18,2),
  cert_apply_amt          NUMBER(18,2),
  cert_apply_balance      NUMBER(18,2),
  cert_status             VARCHAR2(10),
  cert_begin_date         VARCHAR2(20),
  cert_end_date           VARCHAR2(20),
  cert_finish_date        VARCHAR2(20),
  cert_drawer_cust_num    VARCHAR2(50),
  cert_drawer_name        VARCHAR2(200),
  cert_drawer_bank_num    VARCHAR2(50),
  cert_drawer_bank_name   VARCHAR2(200),
  cert_guaranty_type      VARCHAR2(40),
  cert_guaranty_person    VARCHAR2(40),
  cert_busi_remark        VARCHAR2(200),
  cert_interest_peri_type VARCHAR2(10),
  cert_interest_rate_type VARCHAR2(10)
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
comment on table CLM.TB_FUND_EVENT_DETAIL
  is '�ʽ������¼���ϸ';
comment on column CLM.TB_FUND_EVENT_DETAIL.event_detailed_id
  is '�¼���ϸid';
comment on column CLM.TB_FUND_EVENT_DETAIL.event_main_id
  is '����ID';
comment on column CLM.TB_FUND_EVENT_DETAIL.tran_seq_sn
  is '������ˮ��';
comment on column CLM.TB_FUND_EVENT_DETAIL.tran_date
  is '��������';
comment on column CLM.TB_FUND_EVENT_DETAIL.crd_grant_org_num
  is '���Ż���';
comment on column CLM.TB_FUND_EVENT_DETAIL.customer_num
  is '���ſͻ���';
comment on column CLM.TB_FUND_EVENT_DETAIL.crd_detail_prd
  is '��ϸ��Ȳ�Ʒ';
comment on column CLM.TB_FUND_EVENT_DETAIL.busi_deal_num
  is 'ҵ����';
comment on column CLM.TB_FUND_EVENT_DETAIL.busi_prd_num
  is 'ҵ���Ʒ���';
comment on column CLM.TB_FUND_EVENT_DETAIL.busi_deal_desc
  is 'ҵ��������';
comment on column CLM.TB_FUND_EVENT_DETAIL.busi_deal_org_num
  is '��������';
comment on column CLM.TB_FUND_EVENT_DETAIL.busi_deal_org_name
  is '������������';
comment on column CLM.TB_FUND_EVENT_DETAIL.busi_oppt_org_num
  is '���ֻ���';
comment on column CLM.TB_FUND_EVENT_DETAIL.busi_oppt_org_name
  is '���ֻ�������';
comment on column CLM.TB_FUND_EVENT_DETAIL.busi_sum_amt
  is '�����ܽ��';
comment on column CLM.TB_FUND_EVENT_DETAIL.busi_cert_cnt
  is 'ƾ֤����';
comment on column CLM.TB_FUND_EVENT_DETAIL.cert_num
  is 'ƾ֤���';
comment on column CLM.TB_FUND_EVENT_DETAIL.cert_type_cd
  is 'ƾ֤Ʒ��';
comment on column CLM.TB_FUND_EVENT_DETAIL.cert_ppt_cd
  is 'ƾ֤����';
comment on column CLM.TB_FUND_EVENT_DETAIL.cert_interest_period
  is 'ƾ֤��Ϣ����';
comment on column CLM.TB_FUND_EVENT_DETAIL.cert_interest_rate
  is '������/����';
comment on column CLM.TB_FUND_EVENT_DETAIL.cert_currency_cd
  is '����';
comment on column CLM.TB_FUND_EVENT_DETAIL.cert_seq_amt
  is 'ƾ֤ԭʼ���';
comment on column CLM.TB_FUND_EVENT_DETAIL.cert_apply_amt
  is 'ƾ֤���Ž��';
comment on column CLM.TB_FUND_EVENT_DETAIL.cert_apply_balance
  is 'ƾ֤�������';
comment on column CLM.TB_FUND_EVENT_DETAIL.cert_status
  is 'ƾ֤״̬';
comment on column CLM.TB_FUND_EVENT_DETAIL.cert_begin_date
  is 'ƾ֤����';
comment on column CLM.TB_FUND_EVENT_DETAIL.cert_end_date
  is 'ƾֹ֤��';
comment on column CLM.TB_FUND_EVENT_DETAIL.cert_finish_date
  is 'ƾ֤��������';
comment on column CLM.TB_FUND_EVENT_DETAIL.cert_drawer_cust_num
  is '�����˿ͻ���';
comment on column CLM.TB_FUND_EVENT_DETAIL.cert_drawer_name
  is '�����˿ͻ�����';
comment on column CLM.TB_FUND_EVENT_DETAIL.cert_drawer_bank_num
  is '�����˴���/�ж��к�';
comment on column CLM.TB_FUND_EVENT_DETAIL.cert_drawer_bank_name
  is '�����˴���/�ж�����';
comment on column CLM.TB_FUND_EVENT_DETAIL.cert_guaranty_type
  is '������ʽ';
comment on column CLM.TB_FUND_EVENT_DETAIL.cert_guaranty_person
  is '������';
comment on column CLM.TB_FUND_EVENT_DETAIL.cert_busi_remark
  is '��ע��Ϣ';
comment on column CLM.TB_FUND_EVENT_DETAIL.cert_interest_peri_type
  is 'ƾ֤��Ϣ��������';
comment on column CLM.TB_FUND_EVENT_DETAIL.cert_interest_rate_type
  is '������/��������';

prompt
prompt Creating table TB_FUND_EVENT_DETAIL_MIDDLE
prompt ==========================================
prompt
create table CLM.TB_FUND_EVENT_DETAIL_MIDDLE
(
  tran_seq_sn           VARCHAR2(40) not null,
  tran_date             VARCHAR2(20) not null,
  crd_grant_org_num     VARCHAR2(12),
  customer_num          VARCHAR2(40) not null,
  crd_detail_prd        VARCHAR2(10) not null,
  busi_deal_num         VARCHAR2(40) not null,
  busi_prd_num          VARCHAR2(10),
  busi_deal_desc        VARCHAR2(50),
  busi_deal_org_num     VARCHAR2(40),
  busi_deal_org_name    VARCHAR2(100),
  busi_oppt_org_num     VARCHAR2(40),
  busi_oppt_org_name    VARCHAR2(100),
  busi_sum_amt          NUMBER(18,2),
  busi_cert_cnt         NUMBER(24),
  cert_num              VARCHAR2(40) not null,
  cert_type_cd          VARCHAR2(40),
  cert_ppt_cd           VARCHAR2(40),
  cert_interest_period  VARCHAR2(40),
  cert_interest_rate    NUMBER(18,2),
  cert_currency_cd      VARCHAR2(10),
  cert_seq_amt          NUMBER(18,2),
  cert_apply_amt        NUMBER(18,2),
  cert_apply_balance    NUMBER(18,2),
  cert_status           VARCHAR2(10),
  cert_begin_date       VARCHAR2(20),
  cert_end_date         VARCHAR2(20),
  cert_finish_date      VARCHAR2(20),
  cert_drawer_cust_num  VARCHAR2(50),
  cert_drawer_name      VARCHAR2(200),
  cert_drawer_bank_num  VARCHAR2(50),
  cert_drawer_bank_name VARCHAR2(200),
  cert_guaranty_type    VARCHAR2(40),
  cert_guaranty_person  VARCHAR2(40),
  cert_busi_remark      VARCHAR2(200)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on table CLM.TB_FUND_EVENT_DETAIL_MIDDLE
  is '�ʽ������¼���ϸ';
comment on column CLM.TB_FUND_EVENT_DETAIL_MIDDLE.tran_seq_sn
  is '������ˮ��';
comment on column CLM.TB_FUND_EVENT_DETAIL_MIDDLE.tran_date
  is '��������';
comment on column CLM.TB_FUND_EVENT_DETAIL_MIDDLE.crd_grant_org_num
  is '���Ż���';
comment on column CLM.TB_FUND_EVENT_DETAIL_MIDDLE.customer_num
  is '���ſͻ���';
comment on column CLM.TB_FUND_EVENT_DETAIL_MIDDLE.crd_detail_prd
  is '��ϸ��Ȳ�Ʒ';
comment on column CLM.TB_FUND_EVENT_DETAIL_MIDDLE.busi_deal_num
  is 'ҵ����';
comment on column CLM.TB_FUND_EVENT_DETAIL_MIDDLE.busi_prd_num
  is 'ҵ���Ʒ���';
comment on column CLM.TB_FUND_EVENT_DETAIL_MIDDLE.busi_deal_desc
  is 'ҵ��������';
comment on column CLM.TB_FUND_EVENT_DETAIL_MIDDLE.busi_deal_org_num
  is '��������';
comment on column CLM.TB_FUND_EVENT_DETAIL_MIDDLE.busi_deal_org_name
  is '������������';
comment on column CLM.TB_FUND_EVENT_DETAIL_MIDDLE.busi_oppt_org_num
  is '���ֻ���';
comment on column CLM.TB_FUND_EVENT_DETAIL_MIDDLE.busi_oppt_org_name
  is '���ֻ�������';
comment on column CLM.TB_FUND_EVENT_DETAIL_MIDDLE.busi_sum_amt
  is '�����ܽ��';
comment on column CLM.TB_FUND_EVENT_DETAIL_MIDDLE.busi_cert_cnt
  is 'ƾ֤����';
comment on column CLM.TB_FUND_EVENT_DETAIL_MIDDLE.cert_num
  is 'ƾ֤���';
comment on column CLM.TB_FUND_EVENT_DETAIL_MIDDLE.cert_type_cd
  is 'ƾ֤Ʒ��';
comment on column CLM.TB_FUND_EVENT_DETAIL_MIDDLE.cert_ppt_cd
  is 'ƾ֤����';
comment on column CLM.TB_FUND_EVENT_DETAIL_MIDDLE.cert_interest_period
  is 'ƾ֤��Ϣ����';
comment on column CLM.TB_FUND_EVENT_DETAIL_MIDDLE.cert_interest_rate
  is '������/����';
comment on column CLM.TB_FUND_EVENT_DETAIL_MIDDLE.cert_currency_cd
  is '����';
comment on column CLM.TB_FUND_EVENT_DETAIL_MIDDLE.cert_seq_amt
  is 'ƾ֤ԭʼ���';
comment on column CLM.TB_FUND_EVENT_DETAIL_MIDDLE.cert_apply_amt
  is 'ƾ֤���Ž��';
comment on column CLM.TB_FUND_EVENT_DETAIL_MIDDLE.cert_apply_balance
  is 'ƾ֤�������';
comment on column CLM.TB_FUND_EVENT_DETAIL_MIDDLE.cert_status
  is 'ƾ֤״̬';
comment on column CLM.TB_FUND_EVENT_DETAIL_MIDDLE.cert_begin_date
  is 'ƾ֤����';
comment on column CLM.TB_FUND_EVENT_DETAIL_MIDDLE.cert_end_date
  is 'ƾֹ֤��';
comment on column CLM.TB_FUND_EVENT_DETAIL_MIDDLE.cert_finish_date
  is 'ƾ֤��������';
comment on column CLM.TB_FUND_EVENT_DETAIL_MIDDLE.cert_drawer_cust_num
  is '�����˿ͻ���';
comment on column CLM.TB_FUND_EVENT_DETAIL_MIDDLE.cert_drawer_name
  is '�����˿ͻ�����';
comment on column CLM.TB_FUND_EVENT_DETAIL_MIDDLE.cert_drawer_bank_num
  is '�����˴���/�ж��к�';
comment on column CLM.TB_FUND_EVENT_DETAIL_MIDDLE.cert_drawer_bank_name
  is '�����˴���/�ж�����';
comment on column CLM.TB_FUND_EVENT_DETAIL_MIDDLE.cert_guaranty_type
  is '������ʽ';
comment on column CLM.TB_FUND_EVENT_DETAIL_MIDDLE.cert_guaranty_person
  is '������';
comment on column CLM.TB_FUND_EVENT_DETAIL_MIDDLE.cert_busi_remark
  is '��ע��Ϣ';

prompt
prompt Creating table TB_FUND_EVENT_MAIN
prompt =================================
prompt
create table CLM.TB_FUND_EVENT_MAIN
(
  event_main_id     VARCHAR2(32) not null,
  tran_seq_sn       VARCHAR2(40) not null,
  tran_date         VARCHAR2(20) not null,
  busi_deal_num     VARCHAR2(40),
  tran_type_cd      VARCHAR2(2),
  crd_apply_amt     NUMBER(18,2),
  tran_event_status VARCHAR2(2),
  tran_event_info   VARCHAR2(200),
  tran_acct_status  VARCHAR2(2),
  crd_currency_cd   VARCHAR2(10),
  adjust_flag       VARCHAR2(1),
  adjust_direction  VARCHAR2(1),
  adjust_desc       VARCHAR2(100),
  adjust_status     VARCHAR2(1),
  tran_system       VARCHAR2(12),
  user_num          VARCHAR2(12),
  order_seq_sn      NUMBER
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
comment on table CLM.TB_FUND_EVENT_MAIN
  is '�ʽ������¼�����';
comment on column CLM.TB_FUND_EVENT_MAIN.event_main_id
  is '�¼�����id';
comment on column CLM.TB_FUND_EVENT_MAIN.tran_seq_sn
  is 'Ӧ��Ψһȷ�Ͻ���';
comment on column CLM.TB_FUND_EVENT_MAIN.tran_date
  is '��������';
comment on column CLM.TB_FUND_EVENT_MAIN.busi_deal_num
  is 'Ӧ��Ψһȷ��ҵ��';
comment on column CLM.TB_FUND_EVENT_MAIN.tran_type_cd
  is '03 ռ��,04 ռ�ó���,05 �ָ������ڻָ�ʱ��Ʊ�ţ�,06 �ָ�����';
comment on column CLM.TB_FUND_EVENT_MAIN.crd_apply_amt
  is '���׽��';
comment on column CLM.TB_FUND_EVENT_MAIN.tran_event_status
  is '0 δ����  1 ����ɹ� 2 ����ʧ��';
comment on column CLM.TB_FUND_EVENT_MAIN.tran_event_info
  is '�¼���Ϣ';
comment on column CLM.TB_FUND_EVENT_MAIN.tran_acct_status
  is '0 δ����  1 ����ɹ� 2 ����ʧ��';
comment on column CLM.TB_FUND_EVENT_MAIN.crd_currency_cd
  is '����(CD000019)';
comment on column CLM.TB_FUND_EVENT_MAIN.adjust_flag
  is '�Ƿ���Ҫ������ʶ��1 ��Ҫ 0 ����Ҫ';
comment on column CLM.TB_FUND_EVENT_MAIN.adjust_direction
  is '��������1 ���� 0 ���';
comment on column CLM.TB_FUND_EVENT_MAIN.adjust_desc
  is '��������';
comment on column CLM.TB_FUND_EVENT_MAIN.adjust_status
  is '1�������ɹ� 0������ʧ��';
comment on column CLM.TB_FUND_EVENT_MAIN.tran_system
  is '�������';
comment on column CLM.TB_FUND_EVENT_MAIN.user_num
  is '������';
comment on column CLM.TB_FUND_EVENT_MAIN.order_seq_sn
  is 'ͨ��TRAN_SEQ_SN ������� ��������INTEGER(( SUBSTR( T1.TRAN_SEQ_SN,3,LENGTH(T1.TRAN_SEQ_SN) - 2)))';

prompt
prompt Creating table TB_FUND_EVENT_MAIN_MIDDLE
prompt ========================================
prompt
create table CLM.TB_FUND_EVENT_MAIN_MIDDLE
(
  tran_seq_sn     VARCHAR2(40),
  tran_date       VARCHAR2(20),
  busi_deal_num   VARCHAR2(40),
  tran_type_cd    VARCHAR2(2),
  crd_apply_amt   NUMBER(18,2),
  crd_currency_cd VARCHAR2(10),
  tran_system     VARCHAR2(12),
  user_num        VARCHAR2(12)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on table CLM.TB_FUND_EVENT_MAIN_MIDDLE
  is '�ʽ������¼�����';
comment on column CLM.TB_FUND_EVENT_MAIN_MIDDLE.tran_seq_sn
  is 'Ӧ��Ψһȷ�Ͻ���';
comment on column CLM.TB_FUND_EVENT_MAIN_MIDDLE.tran_date
  is '��������';
comment on column CLM.TB_FUND_EVENT_MAIN_MIDDLE.busi_deal_num
  is 'Ӧ��Ψһȷ��ҵ��';
comment on column CLM.TB_FUND_EVENT_MAIN_MIDDLE.tran_type_cd
  is '03 ռ��
04 ռ�ó���
05 �ָ������ڻָ�ʱ��Ʊ�ţ�
06 �ָ�����';
comment on column CLM.TB_FUND_EVENT_MAIN_MIDDLE.crd_apply_amt
  is '���׽��';
comment on column CLM.TB_FUND_EVENT_MAIN_MIDDLE.crd_currency_cd
  is '����(CD000019)';
comment on column CLM.TB_FUND_EVENT_MAIN_MIDDLE.tran_system
  is '�������';
comment on column CLM.TB_FUND_EVENT_MAIN_MIDDLE.user_num
  is '������';

prompt
prompt Creating table TB_FUND_GRANT_DETAIL
prompt ===================================
prompt
create table CLM.TB_FUND_GRANT_DETAIL
(
  event_detail_id   VARCHAR2(32) not null,
  event_main_id     VARCHAR2(32) not null,
  tran_seq_sn       VARCHAR2(40),
  tran_date         VARCHAR2(20),
  crd_grant_org_num VARCHAR2(12),
  customer_num      VARCHAR2(40),
  crd_main_prd      VARCHAR2(10),
  crd_currency_cd   VARCHAR2(10),
  crd_sum_amt       NUMBER(18,2),
  crd_begin_date    VARCHAR2(20),
  crd_end_date      VARCHAR2(20),
  busi_segm_amt     NUMBER(18,2),
  busi_segm_cnt     NUMBER(5),
  crd_detail_prd    VARCHAR2(10),
  crd_detail_amt    NUMBER(18,2)
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
comment on table CLM.TB_FUND_GRANT_DETAIL
  is '�ʽ������¼���ϸ';
comment on column CLM.TB_FUND_GRANT_DETAIL.event_detail_id
  is '����ID';
comment on column CLM.TB_FUND_GRANT_DETAIL.event_main_id
  is '����ID';
comment on column CLM.TB_FUND_GRANT_DETAIL.tran_seq_sn
  is '������ˮ��';
comment on column CLM.TB_FUND_GRANT_DETAIL.tran_date
  is '��������';
comment on column CLM.TB_FUND_GRANT_DETAIL.crd_grant_org_num
  is '���Ż���';
comment on column CLM.TB_FUND_GRANT_DETAIL.customer_num
  is 'ECIF�ͻ���';
comment on column CLM.TB_FUND_GRANT_DETAIL.crd_main_prd
  is '��ȶ�����Ʒ';
comment on column CLM.TB_FUND_GRANT_DETAIL.crd_currency_cd
  is '����';
comment on column CLM.TB_FUND_GRANT_DETAIL.crd_sum_amt
  is '��Ƚ��';
comment on column CLM.TB_FUND_GRANT_DETAIL.crd_begin_date
  is '�����Ч����';
comment on column CLM.TB_FUND_GRANT_DETAIL.crd_end_date
  is '��Ƚ�������';
comment on column CLM.TB_FUND_GRANT_DETAIL.busi_segm_amt
  is '�з��ܶ�';
comment on column CLM.TB_FUND_GRANT_DETAIL.busi_segm_cnt
  is '�з���';
comment on column CLM.TB_FUND_GRANT_DETAIL.crd_detail_prd
  is '���������Ʒ��';
comment on column CLM.TB_FUND_GRANT_DETAIL.crd_detail_amt
  is '��ϸ���';

prompt
prompt Creating table TB_FUND_GRANT_DETAIL_MIDDLE
prompt ==========================================
prompt
create table CLM.TB_FUND_GRANT_DETAIL_MIDDLE
(
  tran_seq_sn       VARCHAR2(40),
  tran_date         VARCHAR2(20),
  crd_grant_org_num VARCHAR2(12),
  customer_num      VARCHAR2(40),
  crd_main_prd      VARCHAR2(10),
  crd_currency_cd   VARCHAR2(10),
  crd_sum_amt       NUMBER(18,2),
  crd_begin_date    VARCHAR2(20),
  crd_end_date      VARCHAR2(20),
  busi_segm_amt     NUMBER(18,2),
  busi_segm_cnt     NUMBER(5),
  crd_detail_prd    VARCHAR2(10),
  crd_detail_amt    NUMBER(18,2)
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
comment on table CLM.TB_FUND_GRANT_DETAIL_MIDDLE
  is '�ʽ������¼���ϸ';
comment on column CLM.TB_FUND_GRANT_DETAIL_MIDDLE.tran_seq_sn
  is '������ˮ��';
comment on column CLM.TB_FUND_GRANT_DETAIL_MIDDLE.tran_date
  is '��������';
comment on column CLM.TB_FUND_GRANT_DETAIL_MIDDLE.crd_grant_org_num
  is '���Ż���';
comment on column CLM.TB_FUND_GRANT_DETAIL_MIDDLE.customer_num
  is 'ECIF�ͻ���';
comment on column CLM.TB_FUND_GRANT_DETAIL_MIDDLE.crd_main_prd
  is '��ȶ�����Ʒ';
comment on column CLM.TB_FUND_GRANT_DETAIL_MIDDLE.crd_currency_cd
  is '����';
comment on column CLM.TB_FUND_GRANT_DETAIL_MIDDLE.crd_sum_amt
  is '��Ƚ��';
comment on column CLM.TB_FUND_GRANT_DETAIL_MIDDLE.crd_begin_date
  is '�����Ч����';
comment on column CLM.TB_FUND_GRANT_DETAIL_MIDDLE.crd_end_date
  is '��Ƚ�������';
comment on column CLM.TB_FUND_GRANT_DETAIL_MIDDLE.busi_segm_amt
  is '�з��ܶ�';
comment on column CLM.TB_FUND_GRANT_DETAIL_MIDDLE.busi_segm_cnt
  is '�з���';
comment on column CLM.TB_FUND_GRANT_DETAIL_MIDDLE.crd_detail_prd
  is '���������Ʒ��';
comment on column CLM.TB_FUND_GRANT_DETAIL_MIDDLE.crd_detail_amt
  is '��ϸ���';

prompt
prompt Creating table TB_FUND_GRANT_MAIN
prompt =================================
prompt
create table CLM.TB_FUND_GRANT_MAIN
(
  event_main_id     VARCHAR2(32) not null,
  tran_seq_sn       VARCHAR2(40) not null,
  tran_date         VARCHAR2(20) not null,
  busi_deal_num     VARCHAR2(40),
  tran_type_cd      VARCHAR2(2),
  crd_apply_amt     NUMBER(18,2),
  tran_event_status VARCHAR2(2),
  tran_event_info   VARCHAR2(200),
  tran_acct_status  VARCHAR2(2),
  crd_currency_cd   VARCHAR2(10),
  adjust_flag       VARCHAR2(1),
  adjust_direction  VARCHAR2(1),
  adjust_desc       VARCHAR2(100),
  adjust_status     VARCHAR2(1),
  tran_system       VARCHAR2(12),
  user_num          VARCHAR2(12),
  order_seq_sn      NUMBER
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
comment on table CLM.TB_FUND_GRANT_MAIN
  is '�ʽ��������¼���';
comment on column CLM.TB_FUND_GRANT_MAIN.event_main_id
  is '�¼�����id';
comment on column CLM.TB_FUND_GRANT_MAIN.tran_seq_sn
  is '������ˮ�� Ӧ��Ψһȷ�Ͻ���';
comment on column CLM.TB_FUND_GRANT_MAIN.tran_date
  is '��������';
comment on column CLM.TB_FUND_GRANT_MAIN.busi_deal_num
  is 'ҵ���� Ӧ��Ψһȷ��ҵ��';
comment on column CLM.TB_FUND_GRANT_MAIN.tran_type_cd
  is '�������� 01 Ȧ��';
comment on column CLM.TB_FUND_GRANT_MAIN.crd_apply_amt
  is '���׽��';
comment on column CLM.TB_FUND_GRANT_MAIN.tran_event_status
  is '��������״̬ 0 δ����  1 ����ɹ� 2 ����ʧ��';
comment on column CLM.TB_FUND_GRANT_MAIN.tran_event_info
  is '�¼�������Ϣ';
comment on column CLM.TB_FUND_GRANT_MAIN.tran_acct_status
  is '�Է�����״̬ 0δ����  1 ����ɹ� 2 ����ʧ��';
comment on column CLM.TB_FUND_GRANT_MAIN.crd_currency_cd
  is '����(CD000019)';
comment on column CLM.TB_FUND_GRANT_MAIN.adjust_flag
  is '�Ƿ���Ҫ������ʶ��1 ��Ҫ 0 ����Ҫ';
comment on column CLM.TB_FUND_GRANT_MAIN.adjust_direction
  is '��������1 ���� 0 ���';
comment on column CLM.TB_FUND_GRANT_MAIN.adjust_desc
  is '��������';
comment on column CLM.TB_FUND_GRANT_MAIN.adjust_status
  is '1�������ɹ� 0������ʧ��';
comment on column CLM.TB_FUND_GRANT_MAIN.tran_system
  is '�������';
comment on column CLM.TB_FUND_GRANT_MAIN.user_num
  is '������';
comment on column CLM.TB_FUND_GRANT_MAIN.order_seq_sn
  is 'ͨ��TRAN_SEQ_SN ������� ��������INTEGER(( SUBSTR( T1.TRAN_SEQ_SN,3,LENGTH(T1.TRAN_SEQ_SN) - 2)))';

prompt
prompt Creating table TB_FUND_GRANT_MAIN_MIDDLE
prompt ========================================
prompt
create table CLM.TB_FUND_GRANT_MAIN_MIDDLE
(
  tran_seq_sn     VARCHAR2(40),
  tran_date       VARCHAR2(20),
  busi_deal_num   VARCHAR2(40),
  tran_type_cd    VARCHAR2(2),
  crd_apply_amt   NUMBER(18,2),
  crd_currency_cd VARCHAR2(10),
  tran_system     VARCHAR2(12),
  user_num        VARCHAR2(12)
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
comment on table CLM.TB_FUND_GRANT_MAIN_MIDDLE
  is '�ʽ��������¼���';
comment on column CLM.TB_FUND_GRANT_MAIN_MIDDLE.tran_seq_sn
  is 'Ӧ��Ψһȷ�Ͻ���';
comment on column CLM.TB_FUND_GRANT_MAIN_MIDDLE.tran_date
  is '��������';
comment on column CLM.TB_FUND_GRANT_MAIN_MIDDLE.busi_deal_num
  is 'Ӧ��Ψһȷ��ҵ��';
comment on column CLM.TB_FUND_GRANT_MAIN_MIDDLE.tran_type_cd
  is '01 Ȧ��';
comment on column CLM.TB_FUND_GRANT_MAIN_MIDDLE.crd_apply_amt
  is '���׽��';
comment on column CLM.TB_FUND_GRANT_MAIN_MIDDLE.crd_currency_cd
  is '����(CD000019)';
comment on column CLM.TB_FUND_GRANT_MAIN_MIDDLE.tran_system
  is '�������';
comment on column CLM.TB_FUND_GRANT_MAIN_MIDDLE.user_num
  is '������';

prompt
prompt Creating table TB_FUND_TRANSFER_IN
prompt ==================================
prompt
create table CLM.TB_FUND_TRANSFER_IN
(
  transfer_in_id    VARCHAR2(32) not null,
  event_main_id     VARCHAR2(32) not null,
  tran_seq_sn       VARCHAR2(40),
  tran_date         VARCHAR2(20),
  crd_in_org_num    VARCHAR2(12),
  busi_prd_num      VARCHAR2(3),
  busi_newl_req_num VARCHAR2(40),
  currency_cd       VARCHAR2(3),
  crd_apply_in_amt  NUMBER(24,2)
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
comment on table CLM.TB_FUND_TRANSFER_IN
  is '�ʽ���ת��-ת��';
comment on column CLM.TB_FUND_TRANSFER_IN.transfer_in_id
  is '�ʽ�ϵͳ���ת��-ת��id';
comment on column CLM.TB_FUND_TRANSFER_IN.event_main_id
  is '�ʽ�ϵͳ���ת���¼�����id';
comment on column CLM.TB_FUND_TRANSFER_IN.tran_seq_sn
  is '������ˮ��';
comment on column CLM.TB_FUND_TRANSFER_IN.tran_date
  is '��������';
comment on column CLM.TB_FUND_TRANSFER_IN.crd_in_org_num
  is 'ת�����(��Ա��)';
comment on column CLM.TB_FUND_TRANSFER_IN.busi_prd_num
  is '��Ʒ����';
comment on column CLM.TB_FUND_TRANSFER_IN.busi_newl_req_num
  is 'ҵ����(��Ψһ)';
comment on column CLM.TB_FUND_TRANSFER_IN.currency_cd
  is '����(cd000019)';
comment on column CLM.TB_FUND_TRANSFER_IN.crd_apply_in_amt
  is 'ת����';
alter table CLM.TB_FUND_TRANSFER_IN
  add constraint P_KEY_136 primary key (TRANSFER_IN_ID)
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
prompt Creating table TB_FUND_TRANSFER_IN_MIDDLE
prompt =========================================
prompt
create table CLM.TB_FUND_TRANSFER_IN_MIDDLE
(
  tran_seq_sn       VARCHAR2(40),
  tran_date         VARCHAR2(20),
  crd_in_org_num    VARCHAR2(6),
  busi_prd_num      VARCHAR2(3),
  busi_newl_req_num VARCHAR2(40),
  currency_cd       VARCHAR2(3),
  crd_apply_in_amt  NUMBER(24,6)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on table CLM.TB_FUND_TRANSFER_IN_MIDDLE
  is '�ʽ���ת��-ת��';
comment on column CLM.TB_FUND_TRANSFER_IN_MIDDLE.tran_seq_sn
  is '������ˮ��';
comment on column CLM.TB_FUND_TRANSFER_IN_MIDDLE.tran_date
  is '��������';
comment on column CLM.TB_FUND_TRANSFER_IN_MIDDLE.crd_in_org_num
  is 'ת�����(��Ա��)';
comment on column CLM.TB_FUND_TRANSFER_IN_MIDDLE.busi_prd_num
  is '��Ʒ����';
comment on column CLM.TB_FUND_TRANSFER_IN_MIDDLE.busi_newl_req_num
  is 'ҵ����(��Ψһ)';
comment on column CLM.TB_FUND_TRANSFER_IN_MIDDLE.currency_cd
  is '����(CD000019)';
comment on column CLM.TB_FUND_TRANSFER_IN_MIDDLE.crd_apply_in_amt
  is 'ת����';

prompt
prompt Creating table TB_FUND_TRANSFER_MAIN
prompt ====================================
prompt
create table CLM.TB_FUND_TRANSFER_MAIN
(
  event_main_id     VARCHAR2(32) not null,
  tran_seq_sn       VARCHAR2(40) not null,
  tran_date         VARCHAR2(20) not null,
  busi_deal_num     VARCHAR2(40),
  tran_type_cd      VARCHAR2(2),
  crd_apply_amt     NUMBER(18,2),
  tran_event_status VARCHAR2(2),
  tran_event_info   VARCHAR2(200),
  tran_acct_status  VARCHAR2(2),
  crd_currency_cd   VARCHAR2(10),
  adjust_flag       VARCHAR2(1),
  adjust_direction  VARCHAR2(1),
  adjust_desc       VARCHAR2(100),
  adjust_status     VARCHAR2(1),
  tran_system       VARCHAR2(12),
  user_num          VARCHAR2(12),
  order_seq_sn      NUMBER,
  tran_direction    VARCHAR2(2) not null
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
comment on table CLM.TB_FUND_TRANSFER_MAIN
  is '�ʽ�����ת���¼�����';
comment on column CLM.TB_FUND_TRANSFER_MAIN.event_main_id
  is '�¼�����id';
comment on column CLM.TB_FUND_TRANSFER_MAIN.tran_seq_sn
  is 'Ӧ��Ψһȷ�Ͻ���';
comment on column CLM.TB_FUND_TRANSFER_MAIN.tran_date
  is '��������';
comment on column CLM.TB_FUND_TRANSFER_MAIN.busi_deal_num
  is 'Ӧ��Ψһȷ��ҵ��';
comment on column CLM.TB_FUND_TRANSFER_MAIN.tran_type_cd
  is '03 ռ��
04 ռ�ó���
05 �ָ������ڻָ�ʱ��Ʊ�ţ�
06 �ָ�����';
comment on column CLM.TB_FUND_TRANSFER_MAIN.crd_apply_amt
  is '���׽��';
comment on column CLM.TB_FUND_TRANSFER_MAIN.tran_event_status
  is '0 δ����  1 ����ɹ� 2 ����ʧ��';
comment on column CLM.TB_FUND_TRANSFER_MAIN.tran_event_info
  is '�¼���ϸ';
comment on column CLM.TB_FUND_TRANSFER_MAIN.tran_acct_status
  is '0 δ����  1 ����ɹ� 2 ����ʧ��';
comment on column CLM.TB_FUND_TRANSFER_MAIN.crd_currency_cd
  is '����(CD000019)';
comment on column CLM.TB_FUND_TRANSFER_MAIN.adjust_flag
  is '�Ƿ���Ҫ������ʶ��1 ��Ҫ 0 ����Ҫ';
comment on column CLM.TB_FUND_TRANSFER_MAIN.adjust_direction
  is '��������1 ���� 0 ���';
comment on column CLM.TB_FUND_TRANSFER_MAIN.adjust_desc
  is '��������';
comment on column CLM.TB_FUND_TRANSFER_MAIN.adjust_status
  is '1�������ɹ� 0������ʧ��';
comment on column CLM.TB_FUND_TRANSFER_MAIN.tran_system
  is '�������';
comment on column CLM.TB_FUND_TRANSFER_MAIN.user_num
  is '������';
comment on column CLM.TB_FUND_TRANSFER_MAIN.order_seq_sn
  is 'ͨ��TRAN_SEQ_SN ������� ��������INTEGER(( SUBSTR( T1.TRAN_SEQ_SN,3,LENGTH(T1.TRAN_SEQ_SN) - 2)))';
comment on column CLM.TB_FUND_TRANSFER_MAIN.tran_direction
  is '���׷���CD000269��';

prompt
prompt Creating table TB_FUND_TRANSFER_MAIN_MIDDLE
prompt ===========================================
prompt
create table CLM.TB_FUND_TRANSFER_MAIN_MIDDLE
(
  tran_seq_sn     VARCHAR2(40),
  tran_date       VARCHAR2(20),
  busi_deal_num   VARCHAR2(40),
  tran_type_cd    VARCHAR2(2),
  crd_apply_amt   NUMBER(18,2),
  crd_currency_cd VARCHAR2(10),
  tran_system     VARCHAR2(12),
  user_num        VARCHAR2(12)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on table CLM.TB_FUND_TRANSFER_MAIN_MIDDLE
  is '�ʽ�����ת���¼�����';
comment on column CLM.TB_FUND_TRANSFER_MAIN_MIDDLE.tran_seq_sn
  is 'Ӧ��Ψһȷ�Ͻ���';
comment on column CLM.TB_FUND_TRANSFER_MAIN_MIDDLE.tran_date
  is '��������';
comment on column CLM.TB_FUND_TRANSFER_MAIN_MIDDLE.busi_deal_num
  is 'Ӧ��Ψһȷ��ҵ��';
comment on column CLM.TB_FUND_TRANSFER_MAIN_MIDDLE.tran_type_cd
  is '03 ռ��
04 ռ�ó���
05 �ָ������ڻָ�ʱ��Ʊ�ţ�
06 �ָ�����';
comment on column CLM.TB_FUND_TRANSFER_MAIN_MIDDLE.crd_apply_amt
  is '���׽��';
comment on column CLM.TB_FUND_TRANSFER_MAIN_MIDDLE.crd_currency_cd
  is '����';
comment on column CLM.TB_FUND_TRANSFER_MAIN_MIDDLE.tran_system
  is '�������';
comment on column CLM.TB_FUND_TRANSFER_MAIN_MIDDLE.user_num
  is '������';

prompt
prompt Creating table TB_FUND_TRANSFER_OUT
prompt ===================================
prompt
create table CLM.TB_FUND_TRANSFER_OUT
(
  transfer_out_id     VARCHAR2(32) not null,
  event_main_id       VARCHAR2(32) not null,
  tran_seq_sn         VARCHAR2(40) not null,
  tran_date           VARCHAR2(20),
  crd_out_org_num     VARCHAR2(12),
  busi_source_req_num VARCHAR2(40),
  currency_cd         VARCHAR2(3),
  crd_apply_out_amt   NUMBER(24,2)
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
comment on table CLM.TB_FUND_TRANSFER_OUT
  is '�ʽ�ϵͳ���ת��-ת��';
comment on column CLM.TB_FUND_TRANSFER_OUT.transfer_out_id
  is '�ʽ�ϵͳ���ת��-ת��id';
comment on column CLM.TB_FUND_TRANSFER_OUT.event_main_id
  is '�¼�����id';
comment on column CLM.TB_FUND_TRANSFER_OUT.tran_seq_sn
  is '������ˮ��';
comment on column CLM.TB_FUND_TRANSFER_OUT.tran_date
  is '��������';
comment on column CLM.TB_FUND_TRANSFER_OUT.crd_out_org_num
  is 'ת������';
comment on column CLM.TB_FUND_TRANSFER_OUT.busi_source_req_num
  is 'ҵ����';
comment on column CLM.TB_FUND_TRANSFER_OUT.currency_cd
  is '����';
comment on column CLM.TB_FUND_TRANSFER_OUT.crd_apply_out_amt
  is 'ת�����';
alter table CLM.TB_FUND_TRANSFER_OUT
  add constraint P_KEY_137 primary key (TRANSFER_OUT_ID)
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
prompt Creating table TB_FUND_TRANSFER_OUT_MIDDLE
prompt ==========================================
prompt
create table CLM.TB_FUND_TRANSFER_OUT_MIDDLE
(
  tran_seq_sn         VARCHAR2(10) not null,
  tran_date           VARCHAR2(20),
  crd_out_org_num     VARCHAR2(6),
  busi_source_req_num VARCHAR2(40),
  currency_cd         VARCHAR2(3),
  crd_apply_out_amt   NUMBER(24,6)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on table CLM.TB_FUND_TRANSFER_OUT_MIDDLE
  is '�ʽ�ϵͳ���ת��-ת��';
comment on column CLM.TB_FUND_TRANSFER_OUT_MIDDLE.tran_seq_sn
  is '������ˮ��';
comment on column CLM.TB_FUND_TRANSFER_OUT_MIDDLE.tran_date
  is '��������';
comment on column CLM.TB_FUND_TRANSFER_OUT_MIDDLE.crd_out_org_num
  is 'ת������';
comment on column CLM.TB_FUND_TRANSFER_OUT_MIDDLE.busi_source_req_num
  is 'ҵ����';
comment on column CLM.TB_FUND_TRANSFER_OUT_MIDDLE.currency_cd
  is '����';
comment on column CLM.TB_FUND_TRANSFER_OUT_MIDDLE.crd_apply_out_amt
  is 'ת�����';

prompt
prompt Creating table TB_LOGIN_LOG
prompt ===========================
prompt
create table CLM.TB_LOGIN_LOG
(
  id               VARCHAR2(32) not null,
  account          VARCHAR2(32) not null,
  user_name        VARCHAR2(50) not null,
  org_name         VARCHAR2(100),
  action_datetime  VARCHAR2(20) not null,
  action_client_ip VARCHAR2(30),
  action_type      VARCHAR2(1) not null
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
comment on table CLM.TB_LOGIN_LOG
  is '�û���¼�˳���¼��';
comment on column CLM.TB_LOGIN_LOG.id
  is '����';
comment on column CLM.TB_LOGIN_LOG.account
  is '��¼�ʺ�';
comment on column CLM.TB_LOGIN_LOG.user_name
  is '�û�����';
comment on column CLM.TB_LOGIN_LOG.org_name
  is '��¼����';
comment on column CLM.TB_LOGIN_LOG.action_datetime
  is '����ʱ��';
comment on column CLM.TB_LOGIN_LOG.action_client_ip
  is '������IP';
comment on column CLM.TB_LOGIN_LOG.action_type
  is '��������(1 ��¼ 2 �����˳� 3 ǿ���˳�)';
alter table CLM.TB_LOGIN_LOG
  add primary key (ID)
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
prompt Creating table TB_ORG_INFO
prompt ==========================
prompt
create table CLM.TB_ORG_INFO
(
  org_id           VARCHAR2(6) not null,
  org_short_name   VARCHAR2(80),
  org_name         VARCHAR2(200),
  org_state        VARCHAR2(1),
  org_type         VARCHAR2(1),
  org_attr         VARCHAR2(1),
  manage_org_type  VARCHAR2(1),
  manage_org       VARCHAR2(6),
  corp_org_code    VARCHAR2(20),
  org_code_certifi VARCHAR2(20),
  pb_org_lc        VARCHAR2(20),
  start_date       VARCHAR2(6),
  end_date         VARCHAR2(6),
  province_code    VARCHAR2(6),
  aera_code        VARCHAR2(6),
  org_address      VARCHAR2(200),
  tel_num          VARCHAR2(20),
  zip_code         VARCHAR2(6),
  org_level        VARCHAR2(1),
  whether_del      VARCHAR2(1),
  create_time      DATE,
  upate_time       DATE
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on table CLM.TB_ORG_INFO
  is '������Ϣ��';
comment on column CLM.TB_ORG_INFO.org_id
  is '������ ';
comment on column CLM.TB_ORG_INFO.org_short_name
  is '������� ';
comment on column CLM.TB_ORG_INFO.org_name
  is '�������� ';
comment on column CLM.TB_ORG_INFO.org_state
  is '�Ƿ�����';
comment on column CLM.TB_ORG_INFO.org_type
  is '��������';
comment on column CLM.TB_ORG_INFO.org_attr
  is '�������� ';
comment on column CLM.TB_ORG_INFO.manage_org_type
  is '����������� ';
comment on column CLM.TB_ORG_INFO.manage_org
  is '�ϼ�������� ';
comment on column CLM.TB_ORG_INFO.corp_org_code
  is '���˻�������';
comment on column CLM.TB_ORG_INFO.org_code_certifi
  is '��֯��������';
comment on column CLM.TB_ORG_INFO.pb_org_lc
  is '���л�������֤ ';
comment on column CLM.TB_ORG_INFO.start_date
  is '��ҵ���� ';
comment on column CLM.TB_ORG_INFO.end_date
  is '��ҵ���� ';
comment on column CLM.TB_ORG_INFO.province_code
  is 'ʡ������';
comment on column CLM.TB_ORG_INFO.aera_code
  is '�������� ';
comment on column CLM.TB_ORG_INFO.org_address
  is '������ַ ';
comment on column CLM.TB_ORG_INFO.zip_code
  is '��������';
comment on column CLM.TB_ORG_INFO.org_level
  is '��������';
comment on column CLM.TB_ORG_INFO.whether_del
  is '�Ƿ�ɾ���ı�ʶ';
comment on column CLM.TB_ORG_INFO.create_time
  is '����ʱ��';
comment on column CLM.TB_ORG_INFO.upate_time
  is 'ά��ʱ��';
alter table CLM.TB_ORG_INFO
  add constraint P_KEY_138 primary key (ORG_ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table TB_PAR_BORROW
prompt ============================
prompt
create table CLM.TB_PAR_BORROW
(
  lstg_id        VARCHAR2(40) not null,
  lstg_name      VARCHAR2(100),
  lstg_type      VARCHAR2(2),
  customer_num   VARCHAR2(20),
  customer_name  VARCHAR2(100),
  crd_detail_prd VARCHAR2(20),
  lstg_prd       VARCHAR2(20),
  pro_limit      NUMBER(8,6),
  remark         VARCHAR2(300),
  user_num       VARCHAR2(20),
  org_num        VARCHAR2(20),
  create_time    TIMESTAMP(6),
  update_time    TIMESTAMP(6),
  is_deleted     INTEGER default 0
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
comment on table CLM.TB_PAR_BORROW
  is '��������Ϣ��';
comment on column CLM.TB_PAR_BORROW.lstg_id
  is 'ҵ��Ʒ�ֱ��';
comment on column CLM.TB_PAR_BORROW.lstg_name
  is '����������';
comment on column CLM.TB_PAR_BORROW.lstg_type
  is '����������';
comment on column CLM.TB_PAR_BORROW.customer_num
  is '�ͻ����';
comment on column CLM.TB_PAR_BORROW.customer_name
  is '�ͻ�����';
comment on column CLM.TB_PAR_BORROW.crd_detail_prd
  is '������Ȳ�Ʒ';
comment on column CLM.TB_PAR_BORROW.lstg_prd
  is '�����������';
comment on column CLM.TB_PAR_BORROW.pro_limit
  is '���ñ�������';
comment on column CLM.TB_PAR_BORROW.remark
  is '��ע';
comment on column CLM.TB_PAR_BORROW.user_num
  is '������';
comment on column CLM.TB_PAR_BORROW.org_num
  is '������';
comment on column CLM.TB_PAR_BORROW.create_time
  is '����ʱ��';
comment on column CLM.TB_PAR_BORROW.update_time
  is '����ʱ��';
alter table CLM.TB_PAR_BORROW
  add constraint PK_TB_PAR_BORROW primary key (LSTG_ID)
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
prompt Creating table TB_PAR_CRD
prompt =========================
prompt
create table CLM.TB_PAR_CRD
(
  crd_product_num  VARCHAR2(36) not null,
  crd_product_name VARCHAR2(50),
  super_crd_num    VARCHAR2(50),
  super_crd_name   VARCHAR2(50),
  crd_lower_limit  VARCHAR2(50),
  crd_upper_limit  VARCHAR2(50),
  open_lower_limit VARCHAR2(50),
  open_upper_limit VARCHAR2(50),
  currency_cd      VARCHAR2(10),
  crd_sys_status   VARCHAR2(1),
  crd_descr        VARCHAR2(300),
  crd_level        VARCHAR2(4),
  user_num         VARCHAR2(20),
  org_num          VARCHAR2(20),
  update_user_num  VARCHAR2(20),
  update_org_num   VARCHAR2(20),
  create_time      DATE,
  update_time      DATE,
  is_deleted       NUMBER default 0,
  crd_product_type VARCHAR2(1),
  is_low_risk      VARCHAR2(1)
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
comment on table CLM.TB_PAR_CRD
  is '��ȱ�';
comment on column CLM.TB_PAR_CRD.crd_product_num
  is '���Ʒ�ֱ��';
comment on column CLM.TB_PAR_CRD.crd_product_name
  is '�����ϵ����';
comment on column CLM.TB_PAR_CRD.super_crd_num
  is '��ȸ�����';
comment on column CLM.TB_PAR_CRD.super_crd_name
  is '��ȸ�������';
comment on column CLM.TB_PAR_CRD.crd_lower_limit
  is '�������';
comment on column CLM.TB_PAR_CRD.crd_upper_limit
  is '�������';
comment on column CLM.TB_PAR_CRD.open_lower_limit
  is '��������';
comment on column CLM.TB_PAR_CRD.open_upper_limit
  is '��������';
comment on column CLM.TB_PAR_CRD.currency_cd
  is '����';
comment on column CLM.TB_PAR_CRD.crd_sys_status
  is '��Ʒ״̬��1����Ч 2����Ч';
comment on column CLM.TB_PAR_CRD.crd_descr
  is '��Ȳ�Ʒ����';
comment on column CLM.TB_PAR_CRD.crd_level
  is '��Ȳ�Ʒ����';
comment on column CLM.TB_PAR_CRD.user_num
  is '�����˱��';
comment on column CLM.TB_PAR_CRD.org_num
  is '����������';
comment on column CLM.TB_PAR_CRD.update_user_num
  is '�޸��˱��';
comment on column CLM.TB_PAR_CRD.update_org_num
  is '�޸��˻������';
comment on column CLM.TB_PAR_CRD.create_time
  is '����ʱ��';
comment on column CLM.TB_PAR_CRD.update_time
  is '����ʱ��';
comment on column CLM.TB_PAR_CRD.is_deleted
  is '�Ƿ���ɾ��';
comment on column CLM.TB_PAR_CRD.crd_product_type
  is '���Ʒ�����ͣ�CD000211��';
comment on column CLM.TB_PAR_CRD.is_low_risk
  is '�Ƿ�ͷ��ն�ȣ�CD000167��';
alter table CLM.TB_PAR_CRD
  add constraint P_KEY_139 primary key (CRD_PRODUCT_NUM)
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
prompt Creating table TB_PAR_CRD_PRODUCT
prompt =================================
prompt
create table CLM.TB_PAR_CRD_PRODUCT
(
  id                  VARCHAR2(36) not null,
  crd_product_num     VARCHAR2(30),
  product_num         VARCHAR2(30),
  cust_type           VARCHAR2(10),
  main_guarantee_type VARCHAR2(50),
  product_type        VARCHAR2(50),
  project_type        VARCHAR2(50),
  user_num            VARCHAR2(20),
  org_num             VARCHAR2(20),
  create_time         DATE,
  update_time         DATE,
  is_deleted          NUMBER default 0
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
comment on table CLM.TB_PAR_CRD_PRODUCT
  is '��Ȳ�Ʒҵ��Ʒ�ֹ�����ϵ��';
comment on column CLM.TB_PAR_CRD_PRODUCT.id
  is '����';
comment on column CLM.TB_PAR_CRD_PRODUCT.crd_product_num
  is '��Ȳ�Ʒ���';
comment on column CLM.TB_PAR_CRD_PRODUCT.product_num
  is 'ҵ��Ʒ�ֱ��';
comment on column CLM.TB_PAR_CRD_PRODUCT.cust_type
  is '�ͻ�����';
comment on column CLM.TB_PAR_CRD_PRODUCT.main_guarantee_type
  is '��Ҫ������ʽ';
comment on column CLM.TB_PAR_CRD_PRODUCT.product_type
  is 'ҵ�����ࣨ�������� ���˾�Ӫ ���� �̴���';
comment on column CLM.TB_PAR_CRD_PRODUCT.project_type
  is '��Ŀ����';
comment on column CLM.TB_PAR_CRD_PRODUCT.user_num
  is '������id';
comment on column CLM.TB_PAR_CRD_PRODUCT.org_num
  is '��������id';
comment on column CLM.TB_PAR_CRD_PRODUCT.create_time
  is '����ʱ��';
comment on column CLM.TB_PAR_CRD_PRODUCT.update_time
  is '����ʱ��';
comment on column CLM.TB_PAR_CRD_PRODUCT.is_deleted
  is '�Ƿ���ɾ��';
alter table CLM.TB_PAR_CRD_PRODUCT
  add constraint P_KEY_140 primary key (ID)
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
prompt Creating table TB_PAR_CRD_RULE_CTRL
prompt ===================================
prompt
create table CLM.TB_PAR_CRD_RULE_CTRL
(
  serial_id     VARCHAR2(32) not null,
  event_type_cd VARCHAR2(40) not null,
  tran_type_cd  VARCHAR2(10),
  check_item    VARCHAR2(100) not null,
  check_flag    VARCHAR2(10) not null,
  check_method  VARCHAR2(100) not null,
  create_time   DATE,
  update_time   DATE
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
comment on table CLM.TB_PAR_CRD_RULE_CTRL
  is '��ȹܿع����';
comment on column CLM.TB_PAR_CRD_RULE_CTRL.serial_id
  is '����';
comment on column CLM.TB_PAR_CRD_RULE_CTRL.event_type_cd
  is '205��302�����յ��ڣ����ն���';
comment on column CLM.TB_PAR_CRD_RULE_CTRL.tran_type_cd
  is '��������(cd000197)';
comment on column CLM.TB_PAR_CRD_RULE_CTRL.check_item
  is '�����';
comment on column CLM.TB_PAR_CRD_RULE_CTRL.check_flag
  is '�Ƿ��� 0����飬1���';
comment on column CLM.TB_PAR_CRD_RULE_CTRL.check_method
  is '��鷽��';
comment on column CLM.TB_PAR_CRD_RULE_CTRL.create_time
  is '����ʱ��';
comment on column CLM.TB_PAR_CRD_RULE_CTRL.update_time
  is '�޸�ʱ��';
alter table CLM.TB_PAR_CRD_RULE_CTRL
  add constraint P_KEY_141 primary key (SERIAL_ID)
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
prompt Creating table TB_PAR_PRODUCT
prompt =============================
prompt
create table CLM.TB_PAR_PRODUCT
(
  product_num        VARCHAR2(36) not null,
  sys_product_num    VARCHAR2(40),
  product_name       VARCHAR2(200),
  super_product_num  VARCHAR2(15),
  super_product_name VARCHAR2(50),
  product_type       VARCHAR2(100),
  cust_type          VARCHAR2(200),
  guarantee_type     VARCHAR2(150),
  product_descr      VARCHAR2(1000),
  product_status_cd  VARCHAR2(1),
  limit_used_type    VARCHAR2(1),
  credit_system      VARCHAR2(50),
  risk_exposure_type VARCHAR2(10),
  product_targer     VARCHAR2(10),
  inout_table        VARCHAR2(2),
  vaild_time         DATE,
  user_num           VARCHAR2(20),
  org_num            VARCHAR2(20),
  update_user_num    VARCHAR2(20),
  update_org_num     VARCHAR2(20),
  create_time        DATE,
  update_time        DATE,
  use_system         VARCHAR2(50),
  is_deleted         NUMBER default 0
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
comment on table CLM.TB_PAR_PRODUCT
  is 'ҵ��Ʒ�ֱ�';
comment on column CLM.TB_PAR_PRODUCT.product_num
  is 'ҵ��Ʒ�ֱ��';
comment on column CLM.TB_PAR_PRODUCT.sys_product_num
  is '��Դϵͳ��Ʒ���';
comment on column CLM.TB_PAR_PRODUCT.product_name
  is 'ҵ��Ʒ������';
comment on column CLM.TB_PAR_PRODUCT.super_product_num
  is 'ҵ��Ʒ�ָ����Ʒ���';
comment on column CLM.TB_PAR_PRODUCT.super_product_name
  is 'ҵ��Ʒ�ָ����Ʒ����';
comment on column CLM.TB_PAR_PRODUCT.product_type
  is 'ҵ���������';
comment on column CLM.TB_PAR_PRODUCT.cust_type
  is '�ͻ��������';
comment on column CLM.TB_PAR_PRODUCT.guarantee_type
  is '������ʽ����';
comment on column CLM.TB_PAR_PRODUCT.product_descr
  is 'ҵ��Ʒ������';
comment on column CLM.TB_PAR_PRODUCT.product_status_cd
  is 'ҵ��Ʒ��״̬';
comment on column CLM.TB_PAR_PRODUCT.limit_used_type
  is '��Ʒ���ռ�÷�ʽ';
comment on column CLM.TB_PAR_PRODUCT.credit_system
  is '����ϵͳ';
comment on column CLM.TB_PAR_PRODUCT.risk_exposure_type
  is '���ձ�¶����';
comment on column CLM.TB_PAR_PRODUCT.product_targer
  is '1���Ŵ����Ʒ��2��ͬҵ���Ʒ��3��ͬ�в�Ʒ��';
comment on column CLM.TB_PAR_PRODUCT.inout_table
  is '�������־��CD000187��';
comment on column CLM.TB_PAR_PRODUCT.vaild_time
  is '��������';
comment on column CLM.TB_PAR_PRODUCT.user_num
  is '�����˱��';
comment on column CLM.TB_PAR_PRODUCT.org_num
  is '����������';
comment on column CLM.TB_PAR_PRODUCT.update_user_num
  is '�޸��˱��';
comment on column CLM.TB_PAR_PRODUCT.update_org_num
  is '�޸��˻������';
comment on column CLM.TB_PAR_PRODUCT.create_time
  is '����ʱ��';
comment on column CLM.TB_PAR_PRODUCT.update_time
  is '����ʱ��';
comment on column CLM.TB_PAR_PRODUCT.use_system
  is '����ϵͳ';
comment on column CLM.TB_PAR_PRODUCT.is_deleted
  is '�Ƿ���ɾ��
';
alter table CLM.TB_PAR_PRODUCT
  add constraint P_KEY_142 primary key (PRODUCT_NUM)
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
prompt Creating table TB_PROCEDURE_EXEC_LOG
prompt ====================================
prompt
create table CLM.TB_PROCEDURE_EXEC_LOG
(
  proc_exec_id VARCHAR2(32) not null,
  schema_type  VARCHAR2(10),
  proc_name    VARCHAR2(200),
  status       VARCHAR2(20),
  exec_date    DATE,
  exec_time    DATE,
  effect_count NUMBER,
  sql_code     NUMBER,
  remark       VARCHAR2(100)
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
comment on table CLM.TB_PROCEDURE_EXEC_LOG
  is '�洢����ִ����־';
comment on column CLM.TB_PROCEDURE_EXEC_LOG.proc_exec_id
  is 'ID����';
comment on column CLM.TB_PROCEDURE_EXEC_LOG.schema_type
  is '���ݿ�����';
comment on column CLM.TB_PROCEDURE_EXEC_LOG.proc_name
  is '�洢��������';
comment on column CLM.TB_PROCEDURE_EXEC_LOG.status
  is 'ִ��״̬';
comment on column CLM.TB_PROCEDURE_EXEC_LOG.exec_date
  is 'ִ������';
comment on column CLM.TB_PROCEDURE_EXEC_LOG.exec_time
  is '��ʼʱ��';
comment on column CLM.TB_PROCEDURE_EXEC_LOG.effect_count
  is 'Ӱ������';
comment on column CLM.TB_PROCEDURE_EXEC_LOG.sql_code
  is '�������';
comment on column CLM.TB_PROCEDURE_EXEC_LOG.remark
  is '������Ϣ';
alter table CLM.TB_PROCEDURE_EXEC_LOG
  add constraint P_KEY_143 primary key (PROC_EXEC_ID)
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
prompt Creating table TB_RCM_ANONYMITY_RISKEXPOSURE
prompt ============================================
prompt
create table CLM.TB_RCM_ANONYMITY_RISKEXPOSURE
(
  info_num               VARCHAR2(40) not null,
  crd_balance            NUMBER(24,2),
  crd_balance_last_month NUMBER(10,6),
  total_month            VARCHAR2(10),
  total_year             VARCHAR2(10),
  use_org_num            VARCHAR2(20),
  user_num               VARCHAR2(20),
  org_num                VARCHAR2(20),
  create_time            DATE,
  update_time            DATE,
  remark                 VARCHAR2(100)
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
comment on table CLM.TB_RCM_ANONYMITY_RISKEXPOSURE
  is '�����ͻ����ձ�¶���䶯ͼ';
comment on column CLM.TB_RCM_ANONYMITY_RISKEXPOSURE.info_num
  is '��Ϣ���';
comment on column CLM.TB_RCM_ANONYMITY_RISKEXPOSURE.crd_balance
  is '���';
comment on column CLM.TB_RCM_ANONYMITY_RISKEXPOSURE.crd_balance_last_month
  is '�����±仯';
comment on column CLM.TB_RCM_ANONYMITY_RISKEXPOSURE.total_month
  is '�·�';
comment on column CLM.TB_RCM_ANONYMITY_RISKEXPOSURE.total_year
  is '���';
comment on column CLM.TB_RCM_ANONYMITY_RISKEXPOSURE.use_org_num
  is '��Ч����';
comment on column CLM.TB_RCM_ANONYMITY_RISKEXPOSURE.user_num
  is 'ά����';
comment on column CLM.TB_RCM_ANONYMITY_RISKEXPOSURE.org_num
  is 'ά������';
comment on column CLM.TB_RCM_ANONYMITY_RISKEXPOSURE.create_time
  is '����ʱ��';
comment on column CLM.TB_RCM_ANONYMITY_RISKEXPOSURE.update_time
  is 'ά��ʱ��';
comment on column CLM.TB_RCM_ANONYMITY_RISKEXPOSURE.remark
  is '��ע';
alter table CLM.TB_RCM_ANONYMITY_RISKEXPOSURE
  add constraint PK_TB_RCM_ANONYMITY_RISK_EXPOS primary key (INFO_NUM)
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
prompt Creating table TB_RCM_BANK_RISK_EXPOSURE_RPT
prompt ============================================
prompt
create table CLM.TB_RCM_BANK_RISK_EXPOSURE_RPT
(
  info_num      VARCHAR2(40) not null,
  customer_name VARCHAR2(200),
  customer_num  VARCHAR2(40),
  crd_balance   NUMBER(24,2),
  crd_ratio     NUMBER(10,6),
  total_month   VARCHAR2(10),
  total_year    VARCHAR2(10),
  use_org_num   VARCHAR2(20),
  user_num      VARCHAR2(20),
  org_num       VARCHAR2(20),
  create_time   DATE,
  update_time   DATE,
  remark        VARCHAR2(100)
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
comment on table CLM.TB_RCM_BANK_RISK_EXPOSURE_RPT
  is 'ͬҵ�ͻ����ձ�¶��ϸ��';
comment on column CLM.TB_RCM_BANK_RISK_EXPOSURE_RPT.info_num
  is '��Ϣ���';
comment on column CLM.TB_RCM_BANK_RISK_EXPOSURE_RPT.customer_name
  is '�ͻ�����';
comment on column CLM.TB_RCM_BANK_RISK_EXPOSURE_RPT.customer_num
  is '�ͻ����';
comment on column CLM.TB_RCM_BANK_RISK_EXPOSURE_RPT.crd_balance
  is '�������';
comment on column CLM.TB_RCM_BANK_RISK_EXPOSURE_RPT.crd_ratio
  is 'ռ��';
comment on column CLM.TB_RCM_BANK_RISK_EXPOSURE_RPT.total_month
  is '�·�';
comment on column CLM.TB_RCM_BANK_RISK_EXPOSURE_RPT.total_year
  is '���';
comment on column CLM.TB_RCM_BANK_RISK_EXPOSURE_RPT.use_org_num
  is '��Ч����';
comment on column CLM.TB_RCM_BANK_RISK_EXPOSURE_RPT.user_num
  is 'ά����';
comment on column CLM.TB_RCM_BANK_RISK_EXPOSURE_RPT.org_num
  is 'ά������';
comment on column CLM.TB_RCM_BANK_RISK_EXPOSURE_RPT.create_time
  is '����ʱ��';
comment on column CLM.TB_RCM_BANK_RISK_EXPOSURE_RPT.update_time
  is 'ά��ʱ��';
comment on column CLM.TB_RCM_BANK_RISK_EXPOSURE_RPT.remark
  is '��ע';
alter table CLM.TB_RCM_BANK_RISK_EXPOSURE_RPT
  add constraint PK_TB_RCM_BANK_RISK_EXPOSURE_R primary key (INFO_NUM)
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
prompt Creating table TB_RCM_CONFIG
prompt ============================
prompt
create table CLM.TB_RCM_CONFIG
(
  quota_num        VARCHAR2(40) not null,
  quota_name       VARCHAR2(100),
  quota_index_num  VARCHAR2(40),
  use_org_num      VARCHAR2(20),
  quota_used_amt   NUMBER(18,2),
  quota_free_amt   NUMBER(18,2),
  quota_used_ratio NUMBER(10,6),
  quota_free_ratio NUMBER(10,6),
  quota_total_sum  NUMBER(18,2),
  quota_total_type VARCHAR2(10),
  start_date       VARCHAR2(20),
  invalid_date     VARCHAR2(20),
  quota_state      VARCHAR2(10),
  his_frequency_a  NUMBER(8),
  his_frequency_b  NUMBER(8),
  his_frequency_c  NUMBER(8),
  his_frequency    NUMBER(8),
  explain_info     VARCHAR2(400),
  inspect_user_num VARCHAR2(20),
  inspect_org_num  VARCHAR2(20),
  inspect_time     DATE,
  apply_state      VARCHAR2(10),
  user_num         VARCHAR2(20),
  org_num          VARCHAR2(20),
  create_time      DATE,
  update_time      DATE,
  remark           VARCHAR2(100)
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
comment on table CLM.TB_RCM_CONFIG
  is '�޶����ñ�';
comment on column CLM.TB_RCM_CONFIG.quota_num
  is '���ж��޶���';
comment on column CLM.TB_RCM_CONFIG.quota_name
  is '�޶�����';
comment on column CLM.TB_RCM_CONFIG.quota_index_num
  is '�޶�ָ����';
comment on column CLM.TB_RCM_CONFIG.use_org_num
  is '��Ч����';
comment on column CLM.TB_RCM_CONFIG.quota_used_amt
  is '�޶����ý��';
comment on column CLM.TB_RCM_CONFIG.quota_free_amt
  is '�޶���ý��';
comment on column CLM.TB_RCM_CONFIG.quota_used_ratio
  is '�޶����ñ���';
comment on column CLM.TB_RCM_CONFIG.quota_free_ratio
  is '�޶���ñ���';
comment on column CLM.TB_RCM_CONFIG.quota_total_sum
  is '�޶��ܶ�';
comment on column CLM.TB_RCM_CONFIG.quota_total_type
  is '�޶��ܶ�����:CD000263';
comment on column CLM.TB_RCM_CONFIG.start_date
  is '�޶���Ч����';
comment on column CLM.TB_RCM_CONFIG.invalid_date
  is '�޶�ʧЧ����';
comment on column CLM.TB_RCM_CONFIG.quota_state
  is '�޶�״̬:CD000261';
comment on column CLM.TB_RCM_CONFIG.his_frequency_a
  is '�۲�ֵ��ʷ��������';
comment on column CLM.TB_RCM_CONFIG.his_frequency_b
  is 'Ԥ��ֵ��ʷ��������';
comment on column CLM.TB_RCM_CONFIG.his_frequency_c
  is '����ֵ��ʷ��������';
comment on column CLM.TB_RCM_CONFIG.his_frequency
  is '��ʷ��������';
comment on column CLM.TB_RCM_CONFIG.explain_info
  is '����˵��';
comment on column CLM.TB_RCM_CONFIG.inspect_user_num
  is '������';
comment on column CLM.TB_RCM_CONFIG.inspect_org_num
  is '���˻���';
comment on column CLM.TB_RCM_CONFIG.inspect_time
  is '��������';
comment on column CLM.TB_RCM_CONFIG.apply_state
  is '����״̬:CD**';
comment on column CLM.TB_RCM_CONFIG.user_num
  is '������';
comment on column CLM.TB_RCM_CONFIG.org_num
  is '�������';
comment on column CLM.TB_RCM_CONFIG.create_time
  is '����ʱ��';
comment on column CLM.TB_RCM_CONFIG.update_time
  is '����ʱ��';
comment on column CLM.TB_RCM_CONFIG.remark
  is '��ע';
create unique index CLM.TB_RCM_CONFIG_PK on CLM.TB_RCM_CONFIG (QUOTA_NUM)
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
prompt Creating table TB_RCM_CONFIGURATION_INFO
prompt ========================================
prompt
create table CLM.TB_RCM_CONFIGURATION_INFO
(
  quota_num        VARCHAR2(40) not null,
  quota_name       VARCHAR2(100),
  quota_index_num  VARCHAR2(40),
  use_org_num      VARCHAR2(20),
  quota_used_amt   NUMBER(18,2),
  quota_free_amt   NUMBER(18,2),
  quota_used_ratio NUMBER(10,6),
  quota_free_ratio NUMBER(10,6),
  quota_total_sum  NUMBER(18,2),
  quota_total_type VARCHAR2(10),
  start_date       VARCHAR2(20),
  invalid_date     VARCHAR2(20),
  quota_state      VARCHAR2(10),
  his_frequency_a  NUMBER(8),
  his_frequency_b  NUMBER(8),
  his_frequency_c  NUMBER(8),
  his_frequency    NUMBER(8),
  explain_info     VARCHAR2(400),
  mod_user_num     VARCHAR2(20),
  mod_org_num      VARCHAR2(20),
  modify_time      DATE,
  inspect_user_num VARCHAR2(20),
  inspect_org_num  VARCHAR2(20),
  inspect_time     DATE,
  apply_state      VARCHAR2(10),
  remark1          VARCHAR2(50),
  remark2          VARCHAR2(50),
  remark3          VARCHAR2(50),
  remark4          VARCHAR2(50),
  remark5          VARCHAR2(50)
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
comment on table CLM.TB_RCM_CONFIGURATION_INFO
  is '�޶���ϸ��Ϣ��';
comment on column CLM.TB_RCM_CONFIGURATION_INFO.quota_num
  is '���ж��޶���';
comment on column CLM.TB_RCM_CONFIGURATION_INFO.quota_name
  is '�޶�����';
comment on column CLM.TB_RCM_CONFIGURATION_INFO.quota_index_num
  is '�޶�ָ����';
comment on column CLM.TB_RCM_CONFIGURATION_INFO.use_org_num
  is '��Ч����
ѡ��ʡũ�����ȫʡ��Ա����Ч��
ѡ��ĳһ��Ա�У���ֻ��Գ�Ա����Ч���ɶ�ѡ��
Ĭ��ȫʡ��Ч';
comment on column CLM.TB_RCM_CONFIGURATION_INFO.quota_used_amt
  is '�޶����ý��';
comment on column CLM.TB_RCM_CONFIGURATION_INFO.quota_free_amt
  is '�޶���ý��';
comment on column CLM.TB_RCM_CONFIGURATION_INFO.quota_used_ratio
  is '�޶����ñ���';
comment on column CLM.TB_RCM_CONFIGURATION_INFO.quota_free_ratio
  is '�޶���ñ���';
comment on column CLM.TB_RCM_CONFIGURATION_INFO.quota_total_sum
  is '�޶��ܶ�';
comment on column CLM.TB_RCM_CONFIGURATION_INFO.quota_total_type
  is '�޶��ܶ�����(1-�ʱ����2-һ���ʱ����3-���������ܶ)';
comment on column CLM.TB_RCM_CONFIGURATION_INFO.start_date
  is '�޶���Ч����';
comment on column CLM.TB_RCM_CONFIGURATION_INFO.invalid_date
  is '�޶�ʧЧ����';
comment on column CLM.TB_RCM_CONFIGURATION_INFO.quota_state
  is '�޶�״̬(0-δ��Ч��1-��Ч��2ȡ��)
';
comment on column CLM.TB_RCM_CONFIGURATION_INFO.his_frequency_a
  is '�۲�ֵ��ʷ��������';
comment on column CLM.TB_RCM_CONFIGURATION_INFO.his_frequency_b
  is 'Ԥ��ֵ��ʷ��������';
comment on column CLM.TB_RCM_CONFIGURATION_INFO.his_frequency_c
  is '����ֵ��ʷ��������';
comment on column CLM.TB_RCM_CONFIGURATION_INFO.his_frequency
  is '��ʷ��������';
comment on column CLM.TB_RCM_CONFIGURATION_INFO.explain_info
  is '����˵��';
comment on column CLM.TB_RCM_CONFIGURATION_INFO.mod_user_num
  is 'ά����';
comment on column CLM.TB_RCM_CONFIGURATION_INFO.mod_org_num
  is 'ά������';
comment on column CLM.TB_RCM_CONFIGURATION_INFO.modify_time
  is 'ά��ʱ��';
comment on column CLM.TB_RCM_CONFIGURATION_INFO.inspect_user_num
  is '������';
comment on column CLM.TB_RCM_CONFIGURATION_INFO.inspect_org_num
  is '���ϻ���';
comment on column CLM.TB_RCM_CONFIGURATION_INFO.inspect_time
  is '��������';
comment on column CLM.TB_RCM_CONFIGURATION_INFO.apply_state
  is '����״̬(1-�Ѵ�����2-���ύ��3-��ȡ����4-������)
Ŀǰ�����̣�û��2���״̬';
comment on column CLM.TB_RCM_CONFIGURATION_INFO.remark1
  is '�����ֶ�1';
comment on column CLM.TB_RCM_CONFIGURATION_INFO.remark2
  is '�����ֶ�2';
comment on column CLM.TB_RCM_CONFIGURATION_INFO.remark3
  is '�����ֶ�3';
comment on column CLM.TB_RCM_CONFIGURATION_INFO.remark4
  is '�����ֶ�4';
comment on column CLM.TB_RCM_CONFIGURATION_INFO.remark5
  is '�����ֶ�5';
alter table CLM.TB_RCM_CONFIGURATION_INFO
  add constraint P_KEY_144 primary key (QUOTA_NUM)
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
prompt Creating table TB_RCM_CONFIGURATION_INFO_HIS
prompt ============================================
prompt
create table CLM.TB_RCM_CONFIGURATION_INFO_HIS
(
  id               VARCHAR2(40) not null,
  quota_num        VARCHAR2(40) not null,
  quota_name       VARCHAR2(100),
  quota_index_num  VARCHAR2(40),
  use_org_num      VARCHAR2(20),
  quota_used_amt   NUMBER(18,2),
  quota_free_amt   NUMBER(18,2),
  quota_used_ratio NUMBER(10,6),
  quota_free_ratio NUMBER(10,6),
  quota_total_sum  NUMBER(18,2),
  quota_total_type VARCHAR2(10),
  start_date       VARCHAR2(20),
  invalid_date     VARCHAR2(20),
  quota_state      VARCHAR2(10),
  his_frequency_a  NUMBER(8),
  his_frequency_b  NUMBER(8),
  his_frequency_c  NUMBER(8),
  his_frequency    NUMBER(8),
  explain_info     VARCHAR2(400),
  mod_user_num     VARCHAR2(20),
  mod_org_num      VARCHAR2(20),
  modify_time      DATE,
  inspect_user_num VARCHAR2(20),
  inspect_org_num  VARCHAR2(20),
  inspect_time     DATE,
  apply_state      VARCHAR2(10),
  remark1          VARCHAR2(50),
  remark2          VARCHAR2(50),
  remark3          VARCHAR2(50),
  remark4          VARCHAR2(50),
  remark5          VARCHAR2(50)
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
comment on table CLM.TB_RCM_CONFIGURATION_INFO_HIS
  is '�޶���ϸ��Ϣ��ʷ��';
comment on column CLM.TB_RCM_CONFIGURATION_INFO_HIS.id
  is '�޶����������ʷ��Ϣ���޸�ID';
comment on column CLM.TB_RCM_CONFIGURATION_INFO_HIS.quota_num
  is '���ж��޶���';
comment on column CLM.TB_RCM_CONFIGURATION_INFO_HIS.quota_name
  is '�޶�����';
comment on column CLM.TB_RCM_CONFIGURATION_INFO_HIS.quota_index_num
  is '�޶�ָ����';
comment on column CLM.TB_RCM_CONFIGURATION_INFO_HIS.use_org_num
  is '��Ч����
ѡ��ʡũ�����ȫʡ��Ա����Ч��
ѡ��ĳһ��Ա�У���ֻ��Գ�Ա����Ч���ɶ�ѡ��
Ĭ��ȫʡ��Ч';
comment on column CLM.TB_RCM_CONFIGURATION_INFO_HIS.quota_used_amt
  is '�޶����ý��';
comment on column CLM.TB_RCM_CONFIGURATION_INFO_HIS.quota_free_amt
  is '�޶���ý��';
comment on column CLM.TB_RCM_CONFIGURATION_INFO_HIS.quota_used_ratio
  is '�޶����ñ���';
comment on column CLM.TB_RCM_CONFIGURATION_INFO_HIS.quota_free_ratio
  is '�޶���ñ���';
comment on column CLM.TB_RCM_CONFIGURATION_INFO_HIS.quota_total_sum
  is '�޶��ܶ�';
comment on column CLM.TB_RCM_CONFIGURATION_INFO_HIS.quota_total_type
  is '�޶��ܶ�����(1-�ʱ����2-һ���ʱ����3-���������ܶ)';
comment on column CLM.TB_RCM_CONFIGURATION_INFO_HIS.start_date
  is '�޶���Ч����';
comment on column CLM.TB_RCM_CONFIGURATION_INFO_HIS.invalid_date
  is '�޶�ʧЧ����';
comment on column CLM.TB_RCM_CONFIGURATION_INFO_HIS.quota_state
  is '�޶�״̬(0-δ��Ч��1-��Ч��2ȡ��)
';
comment on column CLM.TB_RCM_CONFIGURATION_INFO_HIS.his_frequency_a
  is '�۲�ֵ��ʷ��������';
comment on column CLM.TB_RCM_CONFIGURATION_INFO_HIS.his_frequency_b
  is 'Ԥ��ֵ��ʷ��������';
comment on column CLM.TB_RCM_CONFIGURATION_INFO_HIS.his_frequency_c
  is '����ֵ��ʷ��������';
comment on column CLM.TB_RCM_CONFIGURATION_INFO_HIS.his_frequency
  is '��ʷ��������';
comment on column CLM.TB_RCM_CONFIGURATION_INFO_HIS.explain_info
  is '����˵��';
comment on column CLM.TB_RCM_CONFIGURATION_INFO_HIS.mod_user_num
  is 'ά����';
comment on column CLM.TB_RCM_CONFIGURATION_INFO_HIS.mod_org_num
  is 'ά������';
comment on column CLM.TB_RCM_CONFIGURATION_INFO_HIS.modify_time
  is 'ά��ʱ��';
comment on column CLM.TB_RCM_CONFIGURATION_INFO_HIS.inspect_user_num
  is '������';
comment on column CLM.TB_RCM_CONFIGURATION_INFO_HIS.inspect_org_num
  is '���ϻ���';
comment on column CLM.TB_RCM_CONFIGURATION_INFO_HIS.inspect_time
  is '��������';
comment on column CLM.TB_RCM_CONFIGURATION_INFO_HIS.apply_state
  is '����״̬(1-�Ѵ�����2-���ύ��3-��ȡ����4-������)
Ŀǰ�����̣�û��2���״̬';
comment on column CLM.TB_RCM_CONFIGURATION_INFO_HIS.remark1
  is '�����ֶ�1';
comment on column CLM.TB_RCM_CONFIGURATION_INFO_HIS.remark2
  is '�����ֶ�2';
comment on column CLM.TB_RCM_CONFIGURATION_INFO_HIS.remark3
  is '�����ֶ�3';
comment on column CLM.TB_RCM_CONFIGURATION_INFO_HIS.remark4
  is '�����ֶ�4';
comment on column CLM.TB_RCM_CONFIGURATION_INFO_HIS.remark5
  is '�����ֶ�5';
alter table CLM.TB_RCM_CONFIGURATION_INFO_HIS
  add primary key (ID)
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
prompt Creating table TB_RCM_CONFIGURATION_PARA
prompt ========================================
prompt
create table CLM.TB_RCM_CONFIGURATION_PARA
(
  sub_para_num        VARCHAR2(40) not null,
  quota_num           VARCHAR2(40),
  quota_index_num     VARCHAR2(40),
  use_org_num         VARCHAR2(20),
  quota_level         VARCHAR2(10),
  quota_control_amt   NUMBER(18,2),
  quota_control_ratio NUMBER(10,6),
  quota_control_type  VARCHAR2(10),
  control_node        VARCHAR2(10),
  node_measure        VARCHAR2(10),
  measure_level       VARCHAR2(10),
  explain_info        VARCHAR2(400),
  user_num            VARCHAR2(20),
  mod_org_num         VARCHAR2(20),
  modify_time         DATE,
  remark1             VARCHAR2(50),
  remark2             VARCHAR2(50),
  remark3             VARCHAR2(50),
  remark4             VARCHAR2(50),
  remark5             VARCHAR2(50)
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
comment on table CLM.TB_RCM_CONFIGURATION_PARA
  is '�޶����������Ϣ��';
comment on column CLM.TB_RCM_CONFIGURATION_PARA.sub_para_num
  is '����������';
comment on column CLM.TB_RCM_CONFIGURATION_PARA.quota_num
  is '���ж��޶���';
comment on column CLM.TB_RCM_CONFIGURATION_PARA.quota_index_num
  is '�޶�ָ����';
comment on column CLM.TB_RCM_CONFIGURATION_PARA.use_org_num
  is '��Ч����';
comment on column CLM.TB_RCM_CONFIGURATION_PARA.quota_level
  is '��ֵ�㼶(1������ֵ��2��Ԥ��ֵ��3���۲�ֵ)';
comment on column CLM.TB_RCM_CONFIGURATION_PARA.quota_control_amt
  is '��ֵ����';
comment on column CLM.TB_RCM_CONFIGURATION_PARA.quota_control_ratio
  is '��ֵ��ռ�ȣ�';
comment on column CLM.TB_RCM_CONFIGURATION_PARA.quota_control_type
  is '��ֵ���� 1.��� 2.�ٷֱ�';
comment on column CLM.TB_RCM_CONFIGURATION_PARA.control_node
  is '�޶�ܿؽڵ�(0�����н׶Σ�
1�����������ύ��
2���������������У�
3������������
4����ͬ�����ύ��
5����ͬ��������
6���ſ������ύ
ҳ��֧�ֶ�ѡ����ȫѡ��������������¼)';
comment on column CLM.TB_RCM_CONFIGURATION_PARA.node_measure
  is '�ܿؽڵ��Ӧ�Դ�ʩ(1-��ʾ��2-����������3-��ֹ����)';
comment on column CLM.TB_RCM_CONFIGURATION_PARA.measure_level
  is 'Ӧ�Դ�ʩ�ȼ�(1-һ����2-������3������)';
comment on column CLM.TB_RCM_CONFIGURATION_PARA.explain_info
  is '����˵��';
comment on column CLM.TB_RCM_CONFIGURATION_PARA.user_num
  is 'ά����';
comment on column CLM.TB_RCM_CONFIGURATION_PARA.mod_org_num
  is 'ά������';
comment on column CLM.TB_RCM_CONFIGURATION_PARA.modify_time
  is 'ά��ʱ��';
comment on column CLM.TB_RCM_CONFIGURATION_PARA.remark1
  is '�����ֶ�1';
comment on column CLM.TB_RCM_CONFIGURATION_PARA.remark2
  is '�����ֶ�2';
comment on column CLM.TB_RCM_CONFIGURATION_PARA.remark3
  is '�����ֶ�3';
comment on column CLM.TB_RCM_CONFIGURATION_PARA.remark4
  is '�����ֶ�4';
comment on column CLM.TB_RCM_CONFIGURATION_PARA.remark5
  is '�����ֶ�5';
alter table CLM.TB_RCM_CONFIGURATION_PARA
  add primary key (SUB_PARA_NUM)
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
alter table CLM.TB_RCM_CONFIGURATION_PARA
  add constraint F_REFERE foreign key (QUOTA_NUM)
  references CLM.TB_RCM_CONFIGURATION_INFO (QUOTA_NUM);

prompt
prompt Creating table TB_RCM_CONFIGURATION_PARA_HIS
prompt ============================================
prompt
create table CLM.TB_RCM_CONFIGURATION_PARA_HIS
(
  sub_para_num        VARCHAR2(40) not null,
  id                  VARCHAR2(40) not null,
  quota_num           VARCHAR2(40),
  quota_index_num     VARCHAR2(40),
  use_org_num         VARCHAR2(20),
  quota_level         VARCHAR2(10),
  quota_control_amt   NUMBER(18,2),
  quota_control_ratio NUMBER(10,6),
  quota_control_type  VARCHAR2(10),
  control_node        VARCHAR2(10),
  node_measure        VARCHAR2(10),
  measure_level       VARCHAR2(10),
  explain_info        VARCHAR2(400),
  user_num            VARCHAR2(20),
  mod_org_num         VARCHAR2(20),
  modify_time         DATE,
  remark1             VARCHAR2(50),
  remark2             VARCHAR2(50),
  remark3             VARCHAR2(50),
  remark4             VARCHAR2(50),
  remark5             VARCHAR2(50)
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
comment on table CLM.TB_RCM_CONFIGURATION_PARA_HIS
  is '�޶����������ʷ��Ϣ��';
comment on column CLM.TB_RCM_CONFIGURATION_PARA_HIS.sub_para_num
  is '����������';
comment on column CLM.TB_RCM_CONFIGURATION_PARA_HIS.id
  is '��Ӧ�޶���ϸ��Ϣ��ʷ���޸�ID';
comment on column CLM.TB_RCM_CONFIGURATION_PARA_HIS.quota_num
  is '���ж��޶���';
comment on column CLM.TB_RCM_CONFIGURATION_PARA_HIS.quota_index_num
  is '�޶�ָ����';
comment on column CLM.TB_RCM_CONFIGURATION_PARA_HIS.use_org_num
  is '��Ч����';
comment on column CLM.TB_RCM_CONFIGURATION_PARA_HIS.quota_level
  is '��ֵ�㼶(1������ֵ��2��Ԥ��ֵ��3���۲�ֵ)';
comment on column CLM.TB_RCM_CONFIGURATION_PARA_HIS.quota_control_amt
  is '��ֵ����';
comment on column CLM.TB_RCM_CONFIGURATION_PARA_HIS.quota_control_ratio
  is '��ֵ��ռ�ȣ�';
comment on column CLM.TB_RCM_CONFIGURATION_PARA_HIS.quota_control_type
  is '��ֵ���� 1.��� 2.�ٷֱ�';
comment on column CLM.TB_RCM_CONFIGURATION_PARA_HIS.control_node
  is '�޶�ܿؽڵ�(0�����н׶Σ�
1�����������ύ��
2���������������У�
3������������
4����ͬ�����ύ��
5����ͬ��������
6���ſ������ύ
ҳ��֧�ֶ�ѡ����ȫѡ��������������¼)';
comment on column CLM.TB_RCM_CONFIGURATION_PARA_HIS.node_measure
  is '�ܿؽڵ��Ӧ�Դ�ʩ(1-��ʾ��2-����������3-��ֹ����)';
comment on column CLM.TB_RCM_CONFIGURATION_PARA_HIS.measure_level
  is 'Ӧ�Դ�ʩ�ȼ�(1-һ����2-������3������)';
comment on column CLM.TB_RCM_CONFIGURATION_PARA_HIS.explain_info
  is '����˵��';
comment on column CLM.TB_RCM_CONFIGURATION_PARA_HIS.user_num
  is 'ά����';
comment on column CLM.TB_RCM_CONFIGURATION_PARA_HIS.mod_org_num
  is 'ά������';
comment on column CLM.TB_RCM_CONFIGURATION_PARA_HIS.modify_time
  is 'ά��ʱ��';
comment on column CLM.TB_RCM_CONFIGURATION_PARA_HIS.remark1
  is '�����ֶ�1';
comment on column CLM.TB_RCM_CONFIGURATION_PARA_HIS.remark2
  is '�����ֶ�2';
comment on column CLM.TB_RCM_CONFIGURATION_PARA_HIS.remark3
  is '�����ֶ�3';
comment on column CLM.TB_RCM_CONFIGURATION_PARA_HIS.remark4
  is '�����ֶ�4';
comment on column CLM.TB_RCM_CONFIGURATION_PARA_HIS.remark5
  is '�����ֶ�5';
alter table CLM.TB_RCM_CONFIGURATION_PARA_HIS
  add primary key (SUB_PARA_NUM)
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
prompt Creating table TB_RCM_CONFIG_HIS
prompt ================================
prompt
create table CLM.TB_RCM_CONFIG_HIS
(
  his_id           VARCHAR2(40) not null,
  quota_num        VARCHAR2(40) not null,
  quota_name       VARCHAR2(100),
  quota_index_num  VARCHAR2(40),
  use_org_num      VARCHAR2(20),
  quota_used_amt   NUMBER(18,2),
  quota_free_amt   NUMBER(18,2),
  quota_used_ratio NUMBER(10,6),
  quota_free_ratio NUMBER(10,6),
  quota_total_sum  NUMBER(18,2),
  quota_total_type VARCHAR2(10),
  start_date       VARCHAR2(20),
  invalid_date     VARCHAR2(20),
  quota_state      VARCHAR2(10),
  his_frequency_a  NUMBER(8),
  his_frequency_b  NUMBER(8),
  his_frequency_c  NUMBER(8),
  his_frequency    NUMBER(8),
  explain_info     VARCHAR2(400),
  inspect_user_num VARCHAR2(20),
  inspect_org_num  VARCHAR2(20),
  inspect_time     DATE,
  apply_state      VARCHAR2(10),
  user_num         VARCHAR2(20),
  org_num          VARCHAR2(20),
  create_time      DATE,
  update_time      DATE,
  remark           VARCHAR2(100)
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
comment on table CLM.TB_RCM_CONFIG_HIS
  is '�޶�������ʷ��';
comment on column CLM.TB_RCM_CONFIG_HIS.his_id
  is '��ʷ������';
comment on column CLM.TB_RCM_CONFIG_HIS.quota_num
  is '���ж��޶���';
comment on column CLM.TB_RCM_CONFIG_HIS.quota_name
  is '�޶�����';
comment on column CLM.TB_RCM_CONFIG_HIS.quota_index_num
  is '�޶�ָ����';
comment on column CLM.TB_RCM_CONFIG_HIS.use_org_num
  is '��Ч����';
comment on column CLM.TB_RCM_CONFIG_HIS.quota_used_amt
  is '�޶����ý��';
comment on column CLM.TB_RCM_CONFIG_HIS.quota_free_amt
  is '�޶���ý��';
comment on column CLM.TB_RCM_CONFIG_HIS.quota_used_ratio
  is '�޶����ñ���';
comment on column CLM.TB_RCM_CONFIG_HIS.quota_free_ratio
  is '�޶���ñ���';
comment on column CLM.TB_RCM_CONFIG_HIS.quota_total_sum
  is '�޶��ܶ�';
comment on column CLM.TB_RCM_CONFIG_HIS.quota_total_type
  is '�޶��ܶ�����:CD000263';
comment on column CLM.TB_RCM_CONFIG_HIS.start_date
  is '�޶���Ч����';
comment on column CLM.TB_RCM_CONFIG_HIS.invalid_date
  is '�޶�ʧЧ����';
comment on column CLM.TB_RCM_CONFIG_HIS.quota_state
  is '�޶�״̬:CD000261';
comment on column CLM.TB_RCM_CONFIG_HIS.his_frequency_a
  is '�۲�ֵ��ʷ��������';
comment on column CLM.TB_RCM_CONFIG_HIS.his_frequency_b
  is 'Ԥ��ֵ��ʷ��������';
comment on column CLM.TB_RCM_CONFIG_HIS.his_frequency_c
  is '����ֵ��ʷ��������';
comment on column CLM.TB_RCM_CONFIG_HIS.his_frequency
  is '��ʷ��������';
comment on column CLM.TB_RCM_CONFIG_HIS.explain_info
  is '����˵��';
comment on column CLM.TB_RCM_CONFIG_HIS.inspect_user_num
  is '������';
comment on column CLM.TB_RCM_CONFIG_HIS.inspect_org_num
  is '���˻���';
comment on column CLM.TB_RCM_CONFIG_HIS.inspect_time
  is '��������';
comment on column CLM.TB_RCM_CONFIG_HIS.apply_state
  is '����״̬:CD**';
comment on column CLM.TB_RCM_CONFIG_HIS.user_num
  is '������';
comment on column CLM.TB_RCM_CONFIG_HIS.org_num
  is '�������';
comment on column CLM.TB_RCM_CONFIG_HIS.create_time
  is '����ʱ��';
comment on column CLM.TB_RCM_CONFIG_HIS.update_time
  is '����ʱ��';
comment on column CLM.TB_RCM_CONFIG_HIS.remark
  is '��ע';
create unique index CLM.TB_RCM_CONFIG_HIS_PK on CLM.TB_RCM_CONFIG_HIS (HIS_ID)
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
prompt Creating table TB_RCM_CONFIG_PARA
prompt =================================
prompt
create table CLM.TB_RCM_CONFIG_PARA
(
  sub_para_num        VARCHAR2(40) not null,
  quota_num           VARCHAR2(40),
  quota_index_num     VARCHAR2(40),
  use_org_num         VARCHAR2(20),
  quota_level         VARCHAR2(10),
  quota_control_amt   NUMBER(18,2),
  quota_control_ratio NUMBER(10,6),
  quota_control_type  VARCHAR2(10),
  control_node        VARCHAR2(10),
  node_measure        VARCHAR2(10),
  measure_level       VARCHAR2(10),
  explain_info        VARCHAR2(400),
  user_num            VARCHAR2(20),
  org_num             VARCHAR2(20),
  create_time         DATE,
  update_time         DATE,
  remark              VARCHAR2(50)
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
comment on table CLM.TB_RCM_CONFIG_PARA
  is '�޶�ܿز�����';
comment on column CLM.TB_RCM_CONFIG_PARA.sub_para_num
  is '����������';
comment on column CLM.TB_RCM_CONFIG_PARA.quota_num
  is '���ж��޶���';
comment on column CLM.TB_RCM_CONFIG_PARA.quota_index_num
  is '�޶�ָ����';
comment on column CLM.TB_RCM_CONFIG_PARA.use_org_num
  is '��Ч����';
comment on column CLM.TB_RCM_CONFIG_PARA.quota_level
  is '��ֵ�㼶:CD000223';
comment on column CLM.TB_RCM_CONFIG_PARA.quota_control_amt
  is '��ֵ����';
comment on column CLM.TB_RCM_CONFIG_PARA.quota_control_ratio
  is '��ֵ��ռ�ȣ�';
comment on column CLM.TB_RCM_CONFIG_PARA.quota_control_type
  is '��ֵ����:CD000258';
comment on column CLM.TB_RCM_CONFIG_PARA.control_node
  is '�޶�ܿؽڵ�:CD000259';
comment on column CLM.TB_RCM_CONFIG_PARA.node_measure
  is '�ܿؽڵ��Ӧ�Դ�ʩ:CD000260';
comment on column CLM.TB_RCM_CONFIG_PARA.measure_level
  is 'Ӧ�Դ�ʩ�ȼ�:CD000265';
comment on column CLM.TB_RCM_CONFIG_PARA.explain_info
  is '����˵��';
comment on column CLM.TB_RCM_CONFIG_PARA.user_num
  is '������';
comment on column CLM.TB_RCM_CONFIG_PARA.org_num
  is '�������';
comment on column CLM.TB_RCM_CONFIG_PARA.create_time
  is '����ʱ��';
comment on column CLM.TB_RCM_CONFIG_PARA.update_time
  is '����ʱ��';
comment on column CLM.TB_RCM_CONFIG_PARA.remark
  is '��ע';
create unique index CLM.TB_RCM_CONFIG_PARA_PK on CLM.TB_RCM_CONFIG_PARA (SUB_PARA_NUM)
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
prompt Creating table TB_RCM_CONFIG_PARA_HIS
prompt =====================================
prompt
create table CLM.TB_RCM_CONFIG_PARA_HIS
(
  his_id              VARCHAR2(40) not null,
  sub_para_num        VARCHAR2(40) not null,
  quota_num           VARCHAR2(40),
  quota_index_num     VARCHAR2(40),
  use_org_num         VARCHAR2(20),
  quota_level         VARCHAR2(10),
  quota_control_amt   NUMBER(18,2),
  quota_control_ratio NUMBER(10,6),
  quota_control_type  VARCHAR2(10),
  control_node        VARCHAR2(10),
  node_measure        VARCHAR2(10),
  measure_level       VARCHAR2(10),
  explain_info        VARCHAR2(400),
  user_num            VARCHAR2(20),
  org_num             VARCHAR2(20),
  create_time         DATE,
  update_time         DATE,
  remark              VARCHAR2(50),
  main_his_id         VARCHAR2(40)
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
comment on table CLM.TB_RCM_CONFIG_PARA_HIS
  is '�޶�ܿز�����ʷ��';
comment on column CLM.TB_RCM_CONFIG_PARA_HIS.his_id
  is '��ʷ������';
comment on column CLM.TB_RCM_CONFIG_PARA_HIS.sub_para_num
  is '����������';
comment on column CLM.TB_RCM_CONFIG_PARA_HIS.quota_num
  is '���ж��޶���';
comment on column CLM.TB_RCM_CONFIG_PARA_HIS.quota_index_num
  is '�޶�ָ����';
comment on column CLM.TB_RCM_CONFIG_PARA_HIS.use_org_num
  is '��Ч����';
comment on column CLM.TB_RCM_CONFIG_PARA_HIS.quota_level
  is '��ֵ�㼶:CD000223';
comment on column CLM.TB_RCM_CONFIG_PARA_HIS.quota_control_amt
  is '��ֵ����';
comment on column CLM.TB_RCM_CONFIG_PARA_HIS.quota_control_ratio
  is '��ֵ��ռ�ȣ�';
comment on column CLM.TB_RCM_CONFIG_PARA_HIS.quota_control_type
  is '��ֵ����:CD000258';
comment on column CLM.TB_RCM_CONFIG_PARA_HIS.control_node
  is '�޶�ܿؽڵ�:CD000259';
comment on column CLM.TB_RCM_CONFIG_PARA_HIS.node_measure
  is '�ܿؽڵ��Ӧ�Դ�ʩ:CD000260';
comment on column CLM.TB_RCM_CONFIG_PARA_HIS.measure_level
  is 'Ӧ�Դ�ʩ�ȼ�:CD000265';
comment on column CLM.TB_RCM_CONFIG_PARA_HIS.explain_info
  is '����˵��';
comment on column CLM.TB_RCM_CONFIG_PARA_HIS.user_num
  is '������';
comment on column CLM.TB_RCM_CONFIG_PARA_HIS.org_num
  is '�������';
comment on column CLM.TB_RCM_CONFIG_PARA_HIS.create_time
  is '����ʱ��';
comment on column CLM.TB_RCM_CONFIG_PARA_HIS.update_time
  is '����ʱ��';
comment on column CLM.TB_RCM_CONFIG_PARA_HIS.remark
  is '��ע';
comment on column CLM.TB_RCM_CONFIG_PARA_HIS.main_his_id
  is '���������';
create unique index CLM.TB_RCM_CONFIG_PARA_HIS_PK on CLM.TB_RCM_CONFIG_PARA_HIS (HIS_ID)
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
prompt Creating table TB_RCM_CONFIG_PARA_TOTAL
prompt =======================================
prompt
create table CLM.TB_RCM_CONFIG_PARA_TOTAL
(
  sub_para_num        VARCHAR2(40) not null,
  quota_num           VARCHAR2(40),
  quota_index_num     VARCHAR2(40),
  use_org_num         VARCHAR2(20),
  quota_level         VARCHAR2(10),
  quota_control_amt   NUMBER(24,2),
  quota_control_ratio NUMBER(10,6),
  quota_control_type  VARCHAR2(10),
  control_node        VARCHAR2(10),
  node_measure        VARCHAR2(10),
  measure_level       VARCHAR2(10),
  explain_info        VARCHAR2(400),
  total_month         VARCHAR2(10),
  total_year          VARCHAR2(10),
  user_num            VARCHAR2(20),
  org_num             VARCHAR2(20),
  create_time         DATE,
  update_time         DATE,
  remark              VARCHAR2(100)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on table CLM.TB_RCM_CONFIG_PARA_TOTAL
  is '�޶����������Ϣͳ�Ʊ�';
comment on column CLM.TB_RCM_CONFIG_PARA_TOTAL.sub_para_num
  is '����������';
comment on column CLM.TB_RCM_CONFIG_PARA_TOTAL.quota_num
  is '���ж��޶���';
comment on column CLM.TB_RCM_CONFIG_PARA_TOTAL.quota_index_num
  is '�޶�ָ����';
comment on column CLM.TB_RCM_CONFIG_PARA_TOTAL.use_org_num
  is '��Ч����';
comment on column CLM.TB_RCM_CONFIG_PARA_TOTAL.quota_level
  is '��ֵ�㼶';
comment on column CLM.TB_RCM_CONFIG_PARA_TOTAL.quota_control_amt
  is '��ֵ����';
comment on column CLM.TB_RCM_CONFIG_PARA_TOTAL.quota_control_ratio
  is '��ֵ��ռ�ȣ�';
comment on column CLM.TB_RCM_CONFIG_PARA_TOTAL.quota_control_type
  is '��ֵ����';
comment on column CLM.TB_RCM_CONFIG_PARA_TOTAL.control_node
  is '�޶�ܿؽڵ�';
comment on column CLM.TB_RCM_CONFIG_PARA_TOTAL.node_measure
  is '�ܿؽڵ��Ӧ�Դ�ʩ';
comment on column CLM.TB_RCM_CONFIG_PARA_TOTAL.measure_level
  is 'Ӧ�Դ�ʩ�ȼ�';
comment on column CLM.TB_RCM_CONFIG_PARA_TOTAL.explain_info
  is '����˵��';
comment on column CLM.TB_RCM_CONFIG_PARA_TOTAL.total_month
  is '�·�';
comment on column CLM.TB_RCM_CONFIG_PARA_TOTAL.total_year
  is '���';
comment on column CLM.TB_RCM_CONFIG_PARA_TOTAL.user_num
  is '������';
comment on column CLM.TB_RCM_CONFIG_PARA_TOTAL.org_num
  is '�������';
comment on column CLM.TB_RCM_CONFIG_PARA_TOTAL.create_time
  is '����ʱ��';
comment on column CLM.TB_RCM_CONFIG_PARA_TOTAL.update_time
  is '����ʱ��';
comment on column CLM.TB_RCM_CONFIG_PARA_TOTAL.remark
  is '��ע';
create unique index CLM.TB_RCM_CONFIG_PARA_TOTAL_PK on CLM.TB_RCM_CONFIG_PARA_TOTAL (SUB_PARA_NUM)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table TB_RCM_CONFIG_TOTAL
prompt ==================================
prompt
create table CLM.TB_RCM_CONFIG_TOTAL
(
  total_month          VARCHAR2(10) not null,
  total_year           VARCHAR2(10) not null,
  quota_num            VARCHAR2(40) not null,
  quota_used_amt       NUMBER(24,2),
  quota_free_amt       NUMBER(24,2),
  quota_used_ratio     NUMBER(10,6),
  quota_free_ratio     NUMBER(10,6),
  quota_total_sum      NUMBER(24,2),
  quota_total_type     VARCHAR2(10),
  year_to_year_amt     NUMBER(24,2),
  year_to_year_ratio   NUMBER(10,6),
  last_year_amt        NUMBER(24,2),
  last_year_ratio      NUMBER(10,6),
  month_to_month_amt   NUMBER(24,2),
  month_to_month_ratio NUMBER(10,6),
  his_frequency_a      NUMBER(8),
  his_frequency_b      NUMBER(8),
  his_frequency_c      NUMBER(8),
  his_frequency        NUMBER(8),
  his_frequency_a2     NUMBER(8),
  his_frequency_b2     NUMBER(8),
  his_frequency_c2     NUMBER(8),
  his_frequency_year   NUMBER(8),
  his_frequency_a3     NUMBER(8),
  his_frequency_b3     NUMBER(8),
  his_frequency_c3     NUMBER(8),
  his_frequency_month  NUMBER(8),
  net_capital          NUMBER(24,2),
  net_primary_capital  NUMBER(24,2),
  net_assets           NUMBER(24,2),
  use_org_num          VARCHAR2(20),
  user_num             VARCHAR2(20),
  org_num              VARCHAR2(20),
  create_time          DATE,
  update_time          DATE,
  remark               VARCHAR2(100),
  observe_value        NUMBER(30,6),
  warn_value           NUMBER(30,6),
  control_value        NUMBER(30,6),
  observe_value_type   VARCHAR2(10),
  warn_value_type      VARCHAR2(10),
  control_value_type   VARCHAR2(10),
  observe_node_measure VARCHAR2(10),
  warn_node_measure    VARCHAR2(10),
  control_node_measure VARCHAR2(10),
  quota_index_num      VARCHAR2(40),
  quota_index_name     VARCHAR2(100),
  quota_name           VARCHAR2(100)
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
comment on table CLM.TB_RCM_CONFIG_TOTAL
  is '�޶���ϸͳ�Ʊ�';
comment on column CLM.TB_RCM_CONFIG_TOTAL.total_month
  is '�·�';
comment on column CLM.TB_RCM_CONFIG_TOTAL.total_year
  is '���';
comment on column CLM.TB_RCM_CONFIG_TOTAL.quota_num
  is '���ж��޶���';
comment on column CLM.TB_RCM_CONFIG_TOTAL.quota_used_amt
  is '�޶����ý��';
comment on column CLM.TB_RCM_CONFIG_TOTAL.quota_free_amt
  is '�޶���ý��';
comment on column CLM.TB_RCM_CONFIG_TOTAL.quota_used_ratio
  is '�޶����ñ���';
comment on column CLM.TB_RCM_CONFIG_TOTAL.quota_free_ratio
  is '�޶���ñ���';
comment on column CLM.TB_RCM_CONFIG_TOTAL.quota_total_sum
  is '�޶��ܶ�';
comment on column CLM.TB_RCM_CONFIG_TOTAL.quota_total_type
  is '�޶��ܶ�����';
comment on column CLM.TB_RCM_CONFIG_TOTAL.year_to_year_amt
  is '��ͬ����������ͬ�ȣ�';
comment on column CLM.TB_RCM_CONFIG_TOTAL.year_to_year_ratio
  is '��ͬ�������ʣ�ͬ�ȣ�';
comment on column CLM.TB_RCM_CONFIG_TOTAL.last_year_amt
  is '�����������';
comment on column CLM.TB_RCM_CONFIG_TOTAL.last_year_ratio
  is '�����������';
comment on column CLM.TB_RCM_CONFIG_TOTAL.month_to_month_amt
  is '�����������������ȣ�';
comment on column CLM.TB_RCM_CONFIG_TOTAL.month_to_month_ratio
  is '�����������ʣ����ȣ�';
comment on column CLM.TB_RCM_CONFIG_TOTAL.his_frequency_a
  is '�۲�ֵ��ʷ��������';
comment on column CLM.TB_RCM_CONFIG_TOTAL.his_frequency_b
  is 'Ԥ��ֵ��ʷ��������';
comment on column CLM.TB_RCM_CONFIG_TOTAL.his_frequency_c
  is '����ֵ��ʷ��������';
comment on column CLM.TB_RCM_CONFIG_TOTAL.his_frequency
  is '��ʷ�ۼƴ�������';
comment on column CLM.TB_RCM_CONFIG_TOTAL.his_frequency_a2
  is '�۲�ֵ���괥������';
comment on column CLM.TB_RCM_CONFIG_TOTAL.his_frequency_b2
  is 'Ԥ��ֵ���괥������';
comment on column CLM.TB_RCM_CONFIG_TOTAL.his_frequency_c2
  is '����ֵ���괥������';
comment on column CLM.TB_RCM_CONFIG_TOTAL.his_frequency_year
  is '�����ۼƴ�������';
comment on column CLM.TB_RCM_CONFIG_TOTAL.his_frequency_a3
  is '�۲�ֵ���´�������';
comment on column CLM.TB_RCM_CONFIG_TOTAL.his_frequency_b3
  is 'Ԥ��ֵ���´�������';
comment on column CLM.TB_RCM_CONFIG_TOTAL.his_frequency_c3
  is '����ֵ���´�������';
comment on column CLM.TB_RCM_CONFIG_TOTAL.his_frequency_month
  is '�����ۼƴ�������';
comment on column CLM.TB_RCM_CONFIG_TOTAL.net_capital
  is '�����ʱ�����';
comment on column CLM.TB_RCM_CONFIG_TOTAL.net_primary_capital
  is '����һ���ʱ�����';
comment on column CLM.TB_RCM_CONFIG_TOTAL.net_assets
  is '���¾��ʲ�';
comment on column CLM.TB_RCM_CONFIG_TOTAL.use_org_num
  is '��Ч����';
comment on column CLM.TB_RCM_CONFIG_TOTAL.user_num
  is '������';
comment on column CLM.TB_RCM_CONFIG_TOTAL.org_num
  is '�������';
comment on column CLM.TB_RCM_CONFIG_TOTAL.create_time
  is '����ʱ��';
comment on column CLM.TB_RCM_CONFIG_TOTAL.update_time
  is '����ʱ��';
comment on column CLM.TB_RCM_CONFIG_TOTAL.remark
  is '��ע';
comment on column CLM.TB_RCM_CONFIG_TOTAL.observe_value
  is '�۲�ֵ';
comment on column CLM.TB_RCM_CONFIG_TOTAL.warn_value
  is 'Ԥ��ֵ';
comment on column CLM.TB_RCM_CONFIG_TOTAL.control_value
  is '����ֵ';
comment on column CLM.TB_RCM_CONFIG_TOTAL.observe_value_type
  is '�۲�ֵ����';
comment on column CLM.TB_RCM_CONFIG_TOTAL.warn_value_type
  is 'Ԥ��ֵ����';
comment on column CLM.TB_RCM_CONFIG_TOTAL.control_value_type
  is '����ֵ����';
comment on column CLM.TB_RCM_CONFIG_TOTAL.observe_node_measure
  is '�۲�ֵӦ�Դ�ʩ';
comment on column CLM.TB_RCM_CONFIG_TOTAL.warn_node_measure
  is 'Ԥ��ֵӦ�Դ�ʩ';
comment on column CLM.TB_RCM_CONFIG_TOTAL.control_node_measure
  is '����ֵӦ�Դ�ʩ';
comment on column CLM.TB_RCM_CONFIG_TOTAL.quota_index_num
  is '�޶�ָ����';
comment on column CLM.TB_RCM_CONFIG_TOTAL.quota_index_name
  is '�޶�ָ������';
comment on column CLM.TB_RCM_CONFIG_TOTAL.quota_name
  is '�޶�����';
alter table CLM.TB_RCM_CONFIG_TOTAL
  add constraint PK_TB_RCM_CONFIG_TOTAL primary key (QUOTA_NUM, TOTAL_YEAR, TOTAL_MONTH)
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
prompt Creating table TB_RCM_CREDIT_TEN_CUS_RPT
prompt ========================================
prompt
create table CLM.TB_RCM_CREDIT_TEN_CUS_RPT
(
  info_num               VARCHAR2(40) not null,
  customer_name          VARCHAR2(200),
  customer_num           VARCHAR2(40),
  crd_balance            NUMBER(24,2),
  crd_balance_last_month NUMBER(24,2),
  total_month            VARCHAR2(10),
  total_year             VARCHAR2(10),
  use_org_num            VARCHAR2(20),
  user_num               VARCHAR2(20),
  org_num                VARCHAR2(20),
  create_time            DATE,
  update_time            DATE,
  remark                 VARCHAR2(100)
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
comment on table CLM.TB_RCM_CREDIT_TEN_CUS_RPT
  is '���ʮ�ҿͻ����ż��ж���ϸ��';
comment on column CLM.TB_RCM_CREDIT_TEN_CUS_RPT.info_num
  is '��Ϣ���';
comment on column CLM.TB_RCM_CREDIT_TEN_CUS_RPT.customer_name
  is '�ͻ�����';
comment on column CLM.TB_RCM_CREDIT_TEN_CUS_RPT.customer_num
  is '�ͻ����';
comment on column CLM.TB_RCM_CREDIT_TEN_CUS_RPT.crd_balance
  is '�������';
comment on column CLM.TB_RCM_CREDIT_TEN_CUS_RPT.crd_balance_last_month
  is '�����������';
comment on column CLM.TB_RCM_CREDIT_TEN_CUS_RPT.total_month
  is '�·�';
comment on column CLM.TB_RCM_CREDIT_TEN_CUS_RPT.total_year
  is '���';
comment on column CLM.TB_RCM_CREDIT_TEN_CUS_RPT.use_org_num
  is '��Ч����';
comment on column CLM.TB_RCM_CREDIT_TEN_CUS_RPT.user_num
  is 'ά����';
comment on column CLM.TB_RCM_CREDIT_TEN_CUS_RPT.org_num
  is 'ά������';
comment on column CLM.TB_RCM_CREDIT_TEN_CUS_RPT.create_time
  is '����ʱ��';
comment on column CLM.TB_RCM_CREDIT_TEN_CUS_RPT.update_time
  is 'ά��ʱ��';
comment on column CLM.TB_RCM_CREDIT_TEN_CUS_RPT.remark
  is '��ע';
alter table CLM.TB_RCM_CREDIT_TEN_CUS_RPT
  add constraint PK_TB_RCM_CREDIT_TEN_CUS_RPT primary key (INFO_NUM)
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
prompt Creating table TB_RCM_CREDIT_TEN_GROUP_CUS
prompt ==========================================
prompt
create table CLM.TB_RCM_CREDIT_TEN_GROUP_CUS
(
  info_num               VARCHAR2(40) not null,
  customer_name          VARCHAR2(200),
  customer_num           VARCHAR2(40),
  crd_balance            NUMBER(24,2),
  crd_balance_last_month NUMBER(24,2),
  total_month            VARCHAR2(10),
  total_year             VARCHAR2(10),
  use_org_num            VARCHAR2(20),
  user_num               VARCHAR2(20),
  org_num                VARCHAR2(20),
  create_time            DATE,
  update_time            DATE,
  remark                 VARCHAR2(100)
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
comment on table CLM.TB_RCM_CREDIT_TEN_GROUP_CUS
  is '���ʮ�Ҽ��ſͻ����ż��ж���ϸ��';
comment on column CLM.TB_RCM_CREDIT_TEN_GROUP_CUS.info_num
  is '��Ϣ���';
comment on column CLM.TB_RCM_CREDIT_TEN_GROUP_CUS.customer_name
  is '�ͻ�����';
comment on column CLM.TB_RCM_CREDIT_TEN_GROUP_CUS.customer_num
  is '�ͻ����';
comment on column CLM.TB_RCM_CREDIT_TEN_GROUP_CUS.crd_balance
  is '�������';
comment on column CLM.TB_RCM_CREDIT_TEN_GROUP_CUS.crd_balance_last_month
  is '�����������';
comment on column CLM.TB_RCM_CREDIT_TEN_GROUP_CUS.total_month
  is '�·�';
comment on column CLM.TB_RCM_CREDIT_TEN_GROUP_CUS.total_year
  is '���';
comment on column CLM.TB_RCM_CREDIT_TEN_GROUP_CUS.use_org_num
  is '��Ч����';
comment on column CLM.TB_RCM_CREDIT_TEN_GROUP_CUS.user_num
  is 'ά����';
comment on column CLM.TB_RCM_CREDIT_TEN_GROUP_CUS.org_num
  is 'ά������';
comment on column CLM.TB_RCM_CREDIT_TEN_GROUP_CUS.create_time
  is '����ʱ��';
comment on column CLM.TB_RCM_CREDIT_TEN_GROUP_CUS.update_time
  is 'ά��ʱ��';
comment on column CLM.TB_RCM_CREDIT_TEN_GROUP_CUS.remark
  is '��ע';
alter table CLM.TB_RCM_CREDIT_TEN_GROUP_CUS
  add constraint PK_TB_RCM_CREDIT_TEN_GROUP_CUS primary key (INFO_NUM)
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
prompt Creating table TB_RCM_CUS_QUOTA_RPT
prompt ===================================
prompt
create table CLM.TB_RCM_CUS_QUOTA_RPT
(
  info_num            VARCHAR2(40) not null,
  quota_type          VARCHAR2(40),
  amt                 NUMBER(24,2),
  ratio               NUMBER(10,6),
  quota_level_a_amt   NUMBER(24,2),
  quota_level_a_ratio NUMBER(10,6),
  quota_level_b_amt   NUMBER(24,2),
  quota_level_b_ratio NUMBER(10,6),
  quota_level_c_amt   NUMBER(24,2),
  quota_level_c_ratio NUMBER(10,6),
  total_month         VARCHAR2(10),
  total_year          VARCHAR2(10),
  use_org_num         VARCHAR2(20),
  user_num            VARCHAR2(20),
  org_num             VARCHAR2(20),
  create_time         DATE,
  update_time         DATE,
  remark              VARCHAR2(100)
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
comment on table CLM.TB_RCM_CUS_QUOTA_RPT
  is '�ͻ����ż��жȼ��';
comment on column CLM.TB_RCM_CUS_QUOTA_RPT.info_num
  is '��Ϣ���';
comment on column CLM.TB_RCM_CUS_QUOTA_RPT.quota_type
  is '���ж�ָ��';
comment on column CLM.TB_RCM_CUS_QUOTA_RPT.amt
  is 'ʵ���������(���)';
comment on column CLM.TB_RCM_CUS_QUOTA_RPT.ratio
  is 'ʵ���������(ռ��)';
comment on column CLM.TB_RCM_CUS_QUOTA_RPT.quota_level_a_amt
  is '�۲�ֵ(���)';
comment on column CLM.TB_RCM_CUS_QUOTA_RPT.quota_level_a_ratio
  is '�۲�ֵ(ռ��)';
comment on column CLM.TB_RCM_CUS_QUOTA_RPT.quota_level_b_amt
  is 'Ԥ��ֵ(���)';
comment on column CLM.TB_RCM_CUS_QUOTA_RPT.quota_level_b_ratio
  is 'Ԥ��ֵ(ռ��)';
comment on column CLM.TB_RCM_CUS_QUOTA_RPT.quota_level_c_amt
  is '����ֵ(���)';
comment on column CLM.TB_RCM_CUS_QUOTA_RPT.quota_level_c_ratio
  is '����ֵ(ռ��)';
comment on column CLM.TB_RCM_CUS_QUOTA_RPT.total_month
  is '�·�';
comment on column CLM.TB_RCM_CUS_QUOTA_RPT.total_year
  is '���';
comment on column CLM.TB_RCM_CUS_QUOTA_RPT.use_org_num
  is '��Ч����';
comment on column CLM.TB_RCM_CUS_QUOTA_RPT.user_num
  is 'ά����';
comment on column CLM.TB_RCM_CUS_QUOTA_RPT.org_num
  is 'ά������';
comment on column CLM.TB_RCM_CUS_QUOTA_RPT.create_time
  is '����ʱ��';
comment on column CLM.TB_RCM_CUS_QUOTA_RPT.update_time
  is 'ά��ʱ��';
comment on column CLM.TB_RCM_CUS_QUOTA_RPT.remark
  is '��ע';
alter table CLM.TB_RCM_CUS_QUOTA_RPT
  add constraint PK_TB_RCM_CUS_QUOTA_RPT primary key (INFO_NUM)
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
prompt Creating table TB_RCM_INDEX
prompt ===========================
prompt
create table CLM.TB_RCM_INDEX
(
  quota_index_num     VARCHAR2(40) not null,
  quota_index_name    VARCHAR2(100),
  quota_index_type    VARCHAR2(10),
  quota_index_state   VARCHAR2(10),
  quota_type          VARCHAR2(10),
  quota_index_caliber VARCHAR2(10),
  quota_index_range   VARCHAR2(10),
  computing_method    VARCHAR2(10),
  computing_target    VARCHAR2(10),
  explain_info        VARCHAR2(400),
  user_num            VARCHAR2(20),
  org_num             VARCHAR2(20),
  create_time         DATE,
  update_time         DATE,
  remark              VARCHAR2(50),
  is_deleted          VARCHAR2(1) default '0',
  is_delete           VARCHAR2(1) default '0'
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
comment on table CLM.TB_RCM_INDEX
  is '�޶����ָ���';
comment on column CLM.TB_RCM_INDEX.quota_index_num
  is '�޶�ָ����';
comment on column CLM.TB_RCM_INDEX.quota_index_name
  is '�޶�ָ������';
comment on column CLM.TB_RCM_INDEX.quota_index_type
  is '�޶�ָ������(1,ͬҵ�޶�ָ��; 2,��ͬҵ�޶�ָ��)';
comment on column CLM.TB_RCM_INDEX.quota_index_state
  is 'ָ��״̬(1������ ��2��ͣ��)';
comment on column CLM.TB_RCM_INDEX.quota_type
  is '�޶�����(1-����޶�;2-�����޶�)';
comment on column CLM.TB_RCM_INDEX.quota_index_caliber
  is 'ͳ�ƿھ�(1-�������2-������3-�������ڽ��)';
comment on column CLM.TB_RCM_INDEX.quota_index_range
  is '����ά��(0-ȫά�� 1-������Χ)';
comment on column CLM.TB_RCM_INDEX.computing_method
  is '�޶���㷽ʽ1��ͳ�ƿھ�/�ʱ����2��ͳ�ƿھ�/һ���ʱ����3��ͳ�ƿھ�/���������ܶ4���������';
comment on column CLM.TB_RCM_INDEX.computing_target
  is '�޶�������';
comment on column CLM.TB_RCM_INDEX.explain_info
  is '����˵��';
comment on column CLM.TB_RCM_INDEX.user_num
  is '������';
comment on column CLM.TB_RCM_INDEX.org_num
  is '�������';
comment on column CLM.TB_RCM_INDEX.create_time
  is '����ʱ��';
comment on column CLM.TB_RCM_INDEX.update_time
  is '����ʱ��';
comment on column CLM.TB_RCM_INDEX.remark
  is '��ע';
comment on column CLM.TB_RCM_INDEX.is_deleted
  is '�߼�ɾ����ʶ';
comment on column CLM.TB_RCM_INDEX.is_delete
  is '�߼�ɾ����ʶ';
alter table CLM.TB_RCM_INDEX
  add constraint PK_RCM_INDEX primary key (QUOTA_INDEX_NUM)
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
prompt Creating table TB_RCM_INDEX_BANK
prompt ================================
prompt
create table CLM.TB_RCM_INDEX_BANK
(
  quota_index_num VARCHAR2(40) not null,
  business_type   VARCHAR2(10),
  buss_scene      VARCHAR2(10),
  range_customer  VARCHAR2(10),
  currency        VARCHAR2(400),
  range_country   VARCHAR2(400),
  range_product   VARCHAR2(400),
  create_time     DATE,
  update_time     DATE,
  remark          VARCHAR2(50),
  is_delete       VARCHAR2(1) default '0'
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
comment on table CLM.TB_RCM_INDEX_BANK
  is '�Ŵ�ҵ���޶����ָ��';
comment on column CLM.TB_RCM_INDEX_BANK.quota_index_num
  is '�޶�ָ����';
comment on column CLM.TB_RCM_INDEX_BANK.business_type
  is 'ҵ������';
comment on column CLM.TB_RCM_INDEX_BANK.buss_scene
  is 'ҵ�񳡾�';
comment on column CLM.TB_RCM_INDEX_BANK.range_customer
  is '�ͻ�����(ͬҵ�ͻ�) ˵����Ŀǰֻ��ͬҵ�ͻ�����̿��ܻ���ϸ�ֻ���ͬҵ���ſͻ�';
comment on column CLM.TB_RCM_INDEX_BANK.currency
  is '����(�ɶ�ѡ�������ֶδ��ö��ŷָ���Ϊ��Ĭ�������)';
comment on column CLM.TB_RCM_INDEX_BANK.range_country
  is '����(�ɶ�ѡ�������ֶδ��ö��ŷָ���Ϊ�մ������ǹ������)';
comment on column CLM.TB_RCM_INDEX_BANK.range_product
  is '��Ʒ(�ɶ�ѡ�������ֶδ��ö��ŷָ��������������Ʒ��ţ�Ϊ�մ���ȫ��Ʒ) ';
comment on column CLM.TB_RCM_INDEX_BANK.create_time
  is '����ʱ��';
comment on column CLM.TB_RCM_INDEX_BANK.update_time
  is '����ʱ��';
comment on column CLM.TB_RCM_INDEX_BANK.remark
  is '��ע';
comment on column CLM.TB_RCM_INDEX_BANK.is_delete
  is '�߼�ɾ����ʶ';
alter table CLM.TB_RCM_INDEX_BANK
  add constraint PK_RCM_INDEX_BANK primary key (QUOTA_INDEX_NUM)
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
prompt Creating table TB_RCM_INDEX_CREDIT
prompt ==================================
prompt
create table CLM.TB_RCM_INDEX_CREDIT
(
  quota_index_num        VARCHAR2(40) not null,
  range_region           VARCHAR2(10),
  range_customer         VARCHAR2(10),
  currency               VARCHAR2(400),
  range_country          VARCHAR2(400),
  range_industry         VARCHAR2(400),
  range_product          VARCHAR2(400),
  range_term             VARCHAR2(400),
  ranger_risk_mitigation VARCHAR2(10),
  create_time            DATE,
  update_time            DATE,
  remark                 VARCHAR2(50),
  is_delete              VARCHAR2(1) default '0'
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
comment on table CLM.TB_RCM_INDEX_CREDIT
  is 'ͬҵҵ���޶����ָ���';
comment on column CLM.TB_RCM_INDEX_CREDIT.quota_index_num
  is '�޶�ָ����';
comment on column CLM.TB_RCM_INDEX_CREDIT.range_region
  is '����(1��������,2�������ڿͻ�,3��������ͻ�)';
comment on column CLM.TB_RCM_INDEX_CREDIT.range_customer
  is '�ͻ�����(���˿ͻ������˿ͻ������пͻ�)';
comment on column CLM.TB_RCM_INDEX_CREDIT.currency
  is '����(�ɶ�ѡ�������ֶδ��ö��ŷָ���Ϊ��Ĭ�������)';
comment on column CLM.TB_RCM_INDEX_CREDIT.range_country
  is '����(�ɶ�ѡ�������ֶδ��ö��ŷָ���Ϊ�մ������ǹ������)';
comment on column CLM.TB_RCM_INDEX_CREDIT.range_industry
  is '��ҵ(�ɶ�ѡ�������ֶδ��ö��ŷָ���������ҵС�࣬Ϊ�մ���ȫ��ҵ)';
comment on column CLM.TB_RCM_INDEX_CREDIT.range_product
  is '��Ʒ(�ɶ�ѡ�������ֶδ��ö��ŷָ��������������Ʒ��ţ�Ϊ�մ���ȫ��Ʒ) ';
comment on column CLM.TB_RCM_INDEX_CREDIT.range_term
  is '���޷�Χ';
comment on column CLM.TB_RCM_INDEX_CREDIT.ranger_risk_mitigation
  is '���ջ���(0��������1������2����֤3����Ѻ4����Ѻ5����֤����)';
comment on column CLM.TB_RCM_INDEX_CREDIT.create_time
  is '����ʱ��';
comment on column CLM.TB_RCM_INDEX_CREDIT.update_time
  is '����ʱ��';
comment on column CLM.TB_RCM_INDEX_CREDIT.remark
  is '��ע';
comment on column CLM.TB_RCM_INDEX_CREDIT.is_delete
  is '�߼�ɾ����ʶ';
alter table CLM.TB_RCM_INDEX_CREDIT
  add constraint PK_RCM_INDEX_CREDIT primary key (QUOTA_INDEX_NUM)
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
prompt Creating table TB_RCM_INDUSTRY_QUOTA_BASE_RPT
prompt =============================================
prompt
create table CLM.TB_RCM_INDUSTRY_QUOTA_BASE_RPT
(
  info_num            VARCHAR2(40) not null,
  quota_num           VARCHAR2(40),
  industry            VARCHAR2(10),
  crd_balance         NUMBER(24,2),
  crd_ratio           NUMBER(10,6),
  total_month         VARCHAR2(10),
  total_year          VARCHAR2(10),
  use_org_num         VARCHAR2(20),
  user_num            VARCHAR2(20),
  org_num             VARCHAR2(20),
  create_time         DATE,
  update_time         DATE,
  remark              VARCHAR2(100),
  quota_level_a_amt   NUMBER(24,2),
  quota_level_a_ratio NUMBER(10,6),
  quota_level_b_amt   NUMBER(24,2),
  quota_level_b_ratio NUMBER(10,6),
  quota_level_c_amt   NUMBER(24,2),
  quota_level_c_ratio NUMBER(10,6)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on table CLM.TB_RCM_INDUSTRY_QUOTA_BASE_RPT
  is '��ҵ���ż��жȼ��';
comment on column CLM.TB_RCM_INDUSTRY_QUOTA_BASE_RPT.info_num
  is '��Ϣ���';
comment on column CLM.TB_RCM_INDUSTRY_QUOTA_BASE_RPT.quota_num
  is '���ж��޶���';
comment on column CLM.TB_RCM_INDUSTRY_QUOTA_BASE_RPT.industry
  is '��ҵ';
comment on column CLM.TB_RCM_INDUSTRY_QUOTA_BASE_RPT.crd_balance
  is '���';
comment on column CLM.TB_RCM_INDUSTRY_QUOTA_BASE_RPT.crd_ratio
  is 'ռ��';
comment on column CLM.TB_RCM_INDUSTRY_QUOTA_BASE_RPT.total_month
  is '�·�';
comment on column CLM.TB_RCM_INDUSTRY_QUOTA_BASE_RPT.total_year
  is '���';
comment on column CLM.TB_RCM_INDUSTRY_QUOTA_BASE_RPT.use_org_num
  is '��Ч����';
comment on column CLM.TB_RCM_INDUSTRY_QUOTA_BASE_RPT.user_num
  is 'ά����';
comment on column CLM.TB_RCM_INDUSTRY_QUOTA_BASE_RPT.org_num
  is 'ά������';
comment on column CLM.TB_RCM_INDUSTRY_QUOTA_BASE_RPT.create_time
  is '����ʱ��';
comment on column CLM.TB_RCM_INDUSTRY_QUOTA_BASE_RPT.update_time
  is 'ά��ʱ��';
comment on column CLM.TB_RCM_INDUSTRY_QUOTA_BASE_RPT.remark
  is '��ע';
comment on column CLM.TB_RCM_INDUSTRY_QUOTA_BASE_RPT.quota_level_a_amt
  is '�۲�ֵ(���)';
comment on column CLM.TB_RCM_INDUSTRY_QUOTA_BASE_RPT.quota_level_a_ratio
  is '�۲�ֵ(ռ��)';
comment on column CLM.TB_RCM_INDUSTRY_QUOTA_BASE_RPT.quota_level_b_amt
  is 'Ԥ��ֵ(���)';
comment on column CLM.TB_RCM_INDUSTRY_QUOTA_BASE_RPT.quota_level_b_ratio
  is 'Ԥ��ֵ(ռ��)';
comment on column CLM.TB_RCM_INDUSTRY_QUOTA_BASE_RPT.quota_level_c_amt
  is '����ֵ(���)';
comment on column CLM.TB_RCM_INDUSTRY_QUOTA_BASE_RPT.quota_level_c_ratio
  is '����ֵ(ռ��)';
alter table CLM.TB_RCM_INDUSTRY_QUOTA_BASE_RPT
  add constraint PK_TB_RCM_INDUSTRY_QUOTA_DETAI primary key (INFO_NUM)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table TB_RCM_INDUSTRY_QUOTA_DETAIL
prompt ===========================================
prompt
create table CLM.TB_RCM_INDUSTRY_QUOTA_DETAIL
(
  info_num            VARCHAR2(40) not null,
  industry            VARCHAR2(10),
  biz_type            VARCHAR2(10),
  biz_balance         NUMBER(24,2),
  industry_quota      NUMBER(10,6),
  total_month         VARCHAR2(10),
  total_year          VARCHAR2(10),
  use_org_num         VARCHAR2(20),
  user_num            VARCHAR2(20),
  org_num             VARCHAR2(20),
  create_time         DATE,
  update_time         DATE,
  remark              VARCHAR2(100),
  quota_num           VARCHAR2(40),
  quota_level_a_amt   NUMBER(24,2),
  quota_level_a_ratio NUMBER(10,6),
  quota_level_b_amt   NUMBER(24,2),
  quota_level_b_ratio NUMBER(10,6),
  quota_level_c_amt   NUMBER(24,2),
  quota_level_c_ratio NUMBER(10,6)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on table CLM.TB_RCM_INDUSTRY_QUOTA_DETAIL
  is '��ҵ���ż��ж���ϸ��';
comment on column CLM.TB_RCM_INDUSTRY_QUOTA_DETAIL.info_num
  is '��Ϣ���';
comment on column CLM.TB_RCM_INDUSTRY_QUOTA_DETAIL.industry
  is '��ҵ';
comment on column CLM.TB_RCM_INDUSTRY_QUOTA_DETAIL.biz_type
  is 'ҵ�����';
comment on column CLM.TB_RCM_INDUSTRY_QUOTA_DETAIL.biz_balance
  is 'ҵ�����';
comment on column CLM.TB_RCM_INDUSTRY_QUOTA_DETAIL.industry_quota
  is '��ҵ���ж�';
comment on column CLM.TB_RCM_INDUSTRY_QUOTA_DETAIL.total_month
  is '�·�';
comment on column CLM.TB_RCM_INDUSTRY_QUOTA_DETAIL.total_year
  is '���';
comment on column CLM.TB_RCM_INDUSTRY_QUOTA_DETAIL.use_org_num
  is '��Ч����';
comment on column CLM.TB_RCM_INDUSTRY_QUOTA_DETAIL.user_num
  is 'ά����';
comment on column CLM.TB_RCM_INDUSTRY_QUOTA_DETAIL.org_num
  is 'ά������';
comment on column CLM.TB_RCM_INDUSTRY_QUOTA_DETAIL.create_time
  is '����ʱ��';
comment on column CLM.TB_RCM_INDUSTRY_QUOTA_DETAIL.update_time
  is 'ά��ʱ��';
comment on column CLM.TB_RCM_INDUSTRY_QUOTA_DETAIL.remark
  is '��ע';
comment on column CLM.TB_RCM_INDUSTRY_QUOTA_DETAIL.quota_num
  is '���ж��޶���';
comment on column CLM.TB_RCM_INDUSTRY_QUOTA_DETAIL.quota_level_a_amt
  is '�۲�ֵ(���)';
comment on column CLM.TB_RCM_INDUSTRY_QUOTA_DETAIL.quota_level_a_ratio
  is '�۲�ֵ(ռ��)';
comment on column CLM.TB_RCM_INDUSTRY_QUOTA_DETAIL.quota_level_b_amt
  is 'Ԥ��ֵ(���)';
comment on column CLM.TB_RCM_INDUSTRY_QUOTA_DETAIL.quota_level_b_ratio
  is 'Ԥ��ֵ(ռ��)';
comment on column CLM.TB_RCM_INDUSTRY_QUOTA_DETAIL.quota_level_c_amt
  is '����ֵ(���)';
comment on column CLM.TB_RCM_INDUSTRY_QUOTA_DETAIL.quota_level_c_ratio
  is '����ֵ(ռ��)';
alter table CLM.TB_RCM_INDUSTRY_QUOTA_DETAIL
  add constraint PK_TB_RCM_INDUSTRY_QUOTA_BASE_ primary key (INFO_NUM)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table TB_RCM_LOAN_TEN_CUS_RPT
prompt ======================================
prompt
create table CLM.TB_RCM_LOAN_TEN_CUS_RPT
(
  info_num                VARCHAR2(40) not null,
  customer_name           VARCHAR2(200),
  customer_num            VARCHAR2(40),
  loan_balance            NUMBER(24,2),
  loan_balance_last_month NUMBER(24,2),
  total_month             VARCHAR2(10),
  total_year              VARCHAR2(10),
  use_org_num             VARCHAR2(20),
  user_num                VARCHAR2(20),
  org_num                 VARCHAR2(20),
  create_time             DATE,
  update_time             DATE,
  remark                  VARCHAR2(100)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on table CLM.TB_RCM_LOAN_TEN_CUS_RPT
  is '���ʮ�ҿͻ�����ж���ϸ��';
comment on column CLM.TB_RCM_LOAN_TEN_CUS_RPT.info_num
  is '��Ϣ���';
comment on column CLM.TB_RCM_LOAN_TEN_CUS_RPT.customer_name
  is '�ͻ�����';
comment on column CLM.TB_RCM_LOAN_TEN_CUS_RPT.customer_num
  is '�ͻ����';
comment on column CLM.TB_RCM_LOAN_TEN_CUS_RPT.loan_balance
  is '�������';
comment on column CLM.TB_RCM_LOAN_TEN_CUS_RPT.loan_balance_last_month
  is '���´������';
comment on column CLM.TB_RCM_LOAN_TEN_CUS_RPT.total_month
  is '�·�';
comment on column CLM.TB_RCM_LOAN_TEN_CUS_RPT.total_year
  is '���';
comment on column CLM.TB_RCM_LOAN_TEN_CUS_RPT.use_org_num
  is '��Ч����';
comment on column CLM.TB_RCM_LOAN_TEN_CUS_RPT.user_num
  is 'ά����';
comment on column CLM.TB_RCM_LOAN_TEN_CUS_RPT.org_num
  is 'ά������';
comment on column CLM.TB_RCM_LOAN_TEN_CUS_RPT.create_time
  is '����ʱ��';
comment on column CLM.TB_RCM_LOAN_TEN_CUS_RPT.update_time
  is 'ά��ʱ��';
comment on column CLM.TB_RCM_LOAN_TEN_CUS_RPT.remark
  is '��ע';
alter table CLM.TB_RCM_LOAN_TEN_CUS_RPT
  add constraint PK_TB_RCM_LOAN_TEN_CUS_RPT primary key (INFO_NUM)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table TB_RCM_NET_CAPITAL
prompt =================================
prompt
create table CLM.TB_RCM_NET_CAPITAL
(
  net_capital_num     VARCHAR2(32) not null,
  use_org_num         VARCHAR2(20) not null,
  use_date            VARCHAR2(20) not null,
  net_capital         NUMBER(18,2),
  net_primary_capital NUMBER(18,2),
  net_assets          NUMBER(18,2),
  net_state           VARCHAR2(10) default '2',
  remark              VARCHAR2(400),
  user_num            VARCHAR2(20),
  org_num             VARCHAR2(20),
  create_time         DATE,
  update_time         DATE
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
comment on table CLM.TB_RCM_NET_CAPITAL
  is '�ʱ���Ϣ���ñ�';
comment on column CLM.TB_RCM_NET_CAPITAL.net_capital_num
  is '����';
comment on column CLM.TB_RCM_NET_CAPITAL.use_org_num
  is '��Ч����';
comment on column CLM.TB_RCM_NET_CAPITAL.use_date
  is '��Ч����';
comment on column CLM.TB_RCM_NET_CAPITAL.net_capital
  is '�ʱ�����';
comment on column CLM.TB_RCM_NET_CAPITAL.net_primary_capital
  is 'һ���ʱ�����';
comment on column CLM.TB_RCM_NET_CAPITAL.net_assets
  is '���ʲ�';
comment on column CLM.TB_RCM_NET_CAPITAL.net_state
  is '��Ч״̬��CD000251��1:��Ч 2:ʧЧ��';
comment on column CLM.TB_RCM_NET_CAPITAL.remark
  is '��ע';
comment on column CLM.TB_RCM_NET_CAPITAL.user_num
  is '������';
comment on column CLM.TB_RCM_NET_CAPITAL.org_num
  is '�������';
comment on column CLM.TB_RCM_NET_CAPITAL.create_time
  is '����ʱ��';
comment on column CLM.TB_RCM_NET_CAPITAL.update_time
  is '����ʱ��';
create unique index CLM.IDX_NET_CAPITAL on CLM.TB_RCM_NET_CAPITAL (USE_ORG_NUM, USE_DATE)
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
alter table CLM.TB_RCM_NET_CAPITAL
  add constraint PK_NET_CAPITAL primary key (NET_CAPITAL_NUM)
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
prompt Creating table TB_RCM_RELATION_QUOTA_BASE_RPT
prompt =============================================
prompt
create table CLM.TB_RCM_RELATION_QUOTA_BASE_RPT
(
  info_num          VARCHAR2(40) not null,
  quota_num         VARCHAR2(40) not null,
  customer_name     VARCHAR2(200),
  customer_num      VARCHAR2(40),
  crd_balance_amt   NUMBER(24,2),
  crd_balance_ratio NUMBER(10,6),
  total_month       VARCHAR2(10),
  total_year        VARCHAR2(10),
  use_org_num       VARCHAR2(20),
  user_num          VARCHAR2(20),
  org_num           VARCHAR2(20),
  create_time       DATE,
  update_time       DATE,
  remark            VARCHAR2(100)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on table CLM.TB_RCM_RELATION_QUOTA_BASE_RPT
  is '�����ͻ����ż��жȼ��';
comment on column CLM.TB_RCM_RELATION_QUOTA_BASE_RPT.info_num
  is '��Ϣ���';
comment on column CLM.TB_RCM_RELATION_QUOTA_BASE_RPT.quota_num
  is '���ж��޶���';
comment on column CLM.TB_RCM_RELATION_QUOTA_BASE_RPT.customer_name
  is '�ͻ�����';
comment on column CLM.TB_RCM_RELATION_QUOTA_BASE_RPT.customer_num
  is '�ͻ����';
comment on column CLM.TB_RCM_RELATION_QUOTA_BASE_RPT.crd_balance_amt
  is '�������';
comment on column CLM.TB_RCM_RELATION_QUOTA_BASE_RPT.crd_balance_ratio
  is '����ռ��';
comment on column CLM.TB_RCM_RELATION_QUOTA_BASE_RPT.total_month
  is '�·�';
comment on column CLM.TB_RCM_RELATION_QUOTA_BASE_RPT.total_year
  is '���';
comment on column CLM.TB_RCM_RELATION_QUOTA_BASE_RPT.use_org_num
  is '��Ч����';
comment on column CLM.TB_RCM_RELATION_QUOTA_BASE_RPT.user_num
  is 'ά����';
comment on column CLM.TB_RCM_RELATION_QUOTA_BASE_RPT.org_num
  is 'ά������';
comment on column CLM.TB_RCM_RELATION_QUOTA_BASE_RPT.create_time
  is '����ʱ��';
comment on column CLM.TB_RCM_RELATION_QUOTA_BASE_RPT.update_time
  is 'ά��ʱ��';
comment on column CLM.TB_RCM_RELATION_QUOTA_BASE_RPT.remark
  is '��ע';
alter table CLM.TB_RCM_RELATION_QUOTA_BASE_RPT
  add constraint PK_TB_RCM_RELATION_QUOTA_BASE_ primary key (INFO_NUM)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table TB_RCM_RELATION_QUOTA_DETAIL
prompt ===========================================
prompt
create table CLM.TB_RCM_RELATION_QUOTA_DETAIL
(
  info_num                     VARCHAR2(40) not null,
  customer_name                VARCHAR2(200),
  customer_num                 VARCHAR2(40),
  crd_balance                  NUMBER(24,2),
  crd_ratio                    NUMBER(10,6),
  crd_balance_last_month       NUMBER(24,2),
  group_cus_name               VARCHAR2(200),
  group_cus_num                VARCHAR2(40),
  group_crd_balance            NUMBER(24,2),
  group_crd_ratio              NUMBER(10,6),
  group_crd_balance_last_month NUMBER(24,2),
  total_month                  VARCHAR2(10),
  total_year                   VARCHAR2(10),
  use_org_num                  VARCHAR2(20),
  user_num                     VARCHAR2(20),
  org_num                      VARCHAR2(20),
  create_time                  DATE,
  update_time                  DATE,
  remark                       VARCHAR2(100)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on table CLM.TB_RCM_RELATION_QUOTA_DETAIL
  is '�����ͻ����ż��ж���ϸ��';
comment on column CLM.TB_RCM_RELATION_QUOTA_DETAIL.info_num
  is '��Ϣ���';
comment on column CLM.TB_RCM_RELATION_QUOTA_DETAIL.customer_name
  is '�ͻ�����';
comment on column CLM.TB_RCM_RELATION_QUOTA_DETAIL.customer_num
  is '�ͻ����';
comment on column CLM.TB_RCM_RELATION_QUOTA_DETAIL.crd_balance
  is '�������';
comment on column CLM.TB_RCM_RELATION_QUOTA_DETAIL.crd_ratio
  is 'ռ�ʱ��������';
comment on column CLM.TB_RCM_RELATION_QUOTA_DETAIL.crd_balance_last_month
  is '�����������';
comment on column CLM.TB_RCM_RELATION_QUOTA_DETAIL.group_cus_name
  is '�������ſͻ�����';
comment on column CLM.TB_RCM_RELATION_QUOTA_DETAIL.group_cus_num
  is '�������ſͻ����';
comment on column CLM.TB_RCM_RELATION_QUOTA_DETAIL.group_crd_balance
  is '���������������';
comment on column CLM.TB_RCM_RELATION_QUOTA_DETAIL.group_crd_ratio
  is '��������ռ�ʱ��������';
comment on column CLM.TB_RCM_RELATION_QUOTA_DETAIL.group_crd_balance_last_month
  is '�������������������';
comment on column CLM.TB_RCM_RELATION_QUOTA_DETAIL.total_month
  is '�·�';
comment on column CLM.TB_RCM_RELATION_QUOTA_DETAIL.total_year
  is '���';
comment on column CLM.TB_RCM_RELATION_QUOTA_DETAIL.use_org_num
  is '��Ч����';
comment on column CLM.TB_RCM_RELATION_QUOTA_DETAIL.user_num
  is 'ά����';
comment on column CLM.TB_RCM_RELATION_QUOTA_DETAIL.org_num
  is 'ά������';
comment on column CLM.TB_RCM_RELATION_QUOTA_DETAIL.create_time
  is '����ʱ��';
comment on column CLM.TB_RCM_RELATION_QUOTA_DETAIL.update_time
  is 'ά��ʱ��';
comment on column CLM.TB_RCM_RELATION_QUOTA_DETAIL.remark
  is '��ע';
alter table CLM.TB_RCM_RELATION_QUOTA_DETAIL
  add constraint PK_TB_RCM_RELATION_QUOTA_DETAI primary key (INFO_NUM)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table TB_RCM_RISK_EXPOSURE_RPT
prompt =======================================
prompt
create table CLM.TB_RCM_RISK_EXPOSURE_RPT
(
  info_num            VARCHAR2(40) not null,
  quota_type          VARCHAR2(40),
  amt                 NUMBER(24,2),
  ratio               NUMBER(10,6),
  quota_level_c_amt   NUMBER(24,2),
  quota_level_c_ratio NUMBER(10,6),
  total_month         VARCHAR2(10),
  total_year          VARCHAR2(10),
  use_org_num         VARCHAR2(20),
  user_num            VARCHAR2(20),
  org_num             VARCHAR2(20),
  create_time         DATE,
  update_time         DATE,
  remark              VARCHAR2(100)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on table CLM.TB_RCM_RISK_EXPOSURE_RPT
  is '���ձ�¶������';
comment on column CLM.TB_RCM_RISK_EXPOSURE_RPT.quota_type
  is '���ж�ָ��';
comment on column CLM.TB_RCM_RISK_EXPOSURE_RPT.amt
  is 'ʵ���������(���)';
comment on column CLM.TB_RCM_RISK_EXPOSURE_RPT.ratio
  is 'ʵ���������(ռ��)';
comment on column CLM.TB_RCM_RISK_EXPOSURE_RPT.quota_level_c_amt
  is '����ֵ(���)';
comment on column CLM.TB_RCM_RISK_EXPOSURE_RPT.quota_level_c_ratio
  is '����ֵ(ռ��)';
comment on column CLM.TB_RCM_RISK_EXPOSURE_RPT.total_month
  is '�·�';
comment on column CLM.TB_RCM_RISK_EXPOSURE_RPT.total_year
  is '���';
comment on column CLM.TB_RCM_RISK_EXPOSURE_RPT.use_org_num
  is '��Ч����';
comment on column CLM.TB_RCM_RISK_EXPOSURE_RPT.user_num
  is 'ά����';
comment on column CLM.TB_RCM_RISK_EXPOSURE_RPT.org_num
  is 'ά������';
comment on column CLM.TB_RCM_RISK_EXPOSURE_RPT.create_time
  is '����ʱ��';
comment on column CLM.TB_RCM_RISK_EXPOSURE_RPT.update_time
  is 'ά��ʱ��';
comment on column CLM.TB_RCM_RISK_EXPOSURE_RPT.remark
  is '��ע';
alter table CLM.TB_RCM_RISK_EXPOSURE_RPT
  add constraint PK_TB_RCM_RISK_EXPOSURE_RPT primary key (INFO_NUM)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table TB_RCM_WARN_INFO
prompt ===============================
prompt
create table CLM.TB_RCM_WARN_INFO
(
  warn_num             VARCHAR2(40) not null,
  quota_num            VARCHAR2(40),
  quota_name           VARCHAR2(200),
  quota_index_num      VARCHAR2(40),
  quota_used_amt       NUMBER(18,2),
  quota_free_amt       NUMBER(18,2),
  quota_used_ratio     NUMBER(10,6),
  quota_free_ratio     NUMBER(10,6),
  quota_total_sum      NUMBER(18,2),
  quota_total_type     VARCHAR2(10),
  use_org_num          VARCHAR2(20),
  trigger_time         DATE,
  trigger_level        VARCHAR2(20),
  quota_control_amt    NUMBER(18,2),
  quota_control_ratio  NUMBER(10,6),
  trigger_amt          NUMBER(18,2),
  trigger_ratio        NUMBER(10,6),
  trigger_control_node VARCHAR2(20),
  node_measure         VARCHAR2(20),
  measure_level        VARCHAR2(20),
  tran_seq_sn          VARCHAR2(40),
  biz_num              VARCHAR2(40),
  biz_type             VARCHAR2(20),
  user_num             VARCHAR2(40),
  org_num              VARCHAR2(40),
  customer_num         VARCHAR2(40),
  party_name           VARCHAR2(200),
  product_num          VARCHAR2(10),
  amt                  NUMBER(18,2),
  currency_cd          VARCHAR2(10),
  reco_year            VARCHAR2(10),
  reco_month           VARCHAR2(10),
  create_time          DATE,
  update_time          DATE,
  remark               VARCHAR2(100)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on table CLM.TB_RCM_WARN_INFO
  is '�޶�Ԥ����Ϣ��';
comment on column CLM.TB_RCM_WARN_INFO.warn_num
  is 'Ԥ����Ϣ���';
comment on column CLM.TB_RCM_WARN_INFO.quota_num
  is '���ж��޶���';
comment on column CLM.TB_RCM_WARN_INFO.quota_name
  is '�޶�����';
comment on column CLM.TB_RCM_WARN_INFO.quota_index_num
  is '�޶�ָ����';
comment on column CLM.TB_RCM_WARN_INFO.quota_used_amt
  is '�޶����ý��-Ԥ��ʱ����';
comment on column CLM.TB_RCM_WARN_INFO.quota_free_amt
  is '�޶���ý��-Ԥ��ʱ����';
comment on column CLM.TB_RCM_WARN_INFO.quota_used_ratio
  is '�޶����ñ���-Ԥ��ʱ����';
comment on column CLM.TB_RCM_WARN_INFO.quota_free_ratio
  is '�޶���ñ���-Ԥ��ʱ����';
comment on column CLM.TB_RCM_WARN_INFO.quota_total_sum
  is '�޶��ܶ�';
comment on column CLM.TB_RCM_WARN_INFO.quota_total_type
  is '�޶��ܶ�����(1-�ʱ����2-һ���ʱ����3-���������ܶ)';
comment on column CLM.TB_RCM_WARN_INFO.use_org_num
  is '�޶���Ч����';
comment on column CLM.TB_RCM_WARN_INFO.trigger_time
  is '����ʱ��';
comment on column CLM.TB_RCM_WARN_INFO.trigger_level
  is '��ֵ�㼶(1���۲죻2��Ԥ����3������)';
comment on column CLM.TB_RCM_WARN_INFO.quota_control_amt
  is 'Ԥ����ֵ(���)';
comment on column CLM.TB_RCM_WARN_INFO.quota_control_ratio
  is 'Ԥ����ֵ(����)';
comment on column CLM.TB_RCM_WARN_INFO.trigger_amt
  is '������ǰֵ(���)';
comment on column CLM.TB_RCM_WARN_INFO.trigger_ratio
  is '������ǰֵ(ռ��)';
comment on column CLM.TB_RCM_WARN_INFO.trigger_control_node
  is '�����ܿؽڵ�';
comment on column CLM.TB_RCM_WARN_INFO.node_measure
  is 'Ӧ�Դ�ʩ(1-��ʾ��2-����������3-��ֹ����)';
comment on column CLM.TB_RCM_WARN_INFO.measure_level
  is '��Ӧ��ʩ�ȼ�(1-һ����2-������3������)';
comment on column CLM.TB_RCM_WARN_INFO.tran_seq_sn
  is '����ҵ����ˮ��';
comment on column CLM.TB_RCM_WARN_INFO.biz_num
  is '����ҵ����';
comment on column CLM.TB_RCM_WARN_INFO.biz_type
  is 'ҵ������(1���������   2����ͬ����   3���ſ�����   4��ͬҵҵ������)';
comment on column CLM.TB_RCM_WARN_INFO.user_num
  is 'ҵ��ͻ�����';
comment on column CLM.TB_RCM_WARN_INFO.org_num
  is 'ҵ���������';
comment on column CLM.TB_RCM_WARN_INFO.customer_num
  is '�ͻ����';
comment on column CLM.TB_RCM_WARN_INFO.party_name
  is '�ͻ�����';
comment on column CLM.TB_RCM_WARN_INFO.product_num
  is 'ҵ��Ʒ��';
comment on column CLM.TB_RCM_WARN_INFO.amt
  is '�������';
comment on column CLM.TB_RCM_WARN_INFO.currency_cd
  is '����';
comment on column CLM.TB_RCM_WARN_INFO.reco_year
  is '�������';
comment on column CLM.TB_RCM_WARN_INFO.reco_month
  is '�����·�';
comment on column CLM.TB_RCM_WARN_INFO.create_time
  is '�����ֶ�1';
comment on column CLM.TB_RCM_WARN_INFO.update_time
  is 'ά��ʱ��';
comment on column CLM.TB_RCM_WARN_INFO.remark
  is '��ע';
alter table CLM.TB_RCM_WARN_INFO
  add constraint P_KEY_145 primary key (WARN_NUM)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table TB_RCM_WARN_INFO_HIS
prompt ===================================
prompt
create table CLM.TB_RCM_WARN_INFO_HIS
(
  warn_num             VARCHAR2(40) not null,
  quota_num            VARCHAR2(40),
  quota_name           VARCHAR2(200),
  quota_index_num      VARCHAR2(40),
  quota_used_amt       NUMBER(18,2),
  quota_free_amt       NUMBER(18,2),
  quota_used_ratio     NUMBER(10,6),
  quota_free_ratio     NUMBER(10,6),
  quota_total_sum      NUMBER(18,2),
  quota_total_type     VARCHAR2(10),
  use_org_num          VARCHAR2(20),
  trigger_time         DATE,
  trigger_level        VARCHAR2(20),
  quota_control_amt    NUMBER(18,2),
  quota_control_ratio  NUMBER(10,6),
  trigger_amt          NUMBER(18,2),
  trigger_ratio        NUMBER(10,6),
  trigger_control_node VARCHAR2(20),
  node_measure         VARCHAR2(20),
  measure_level        VARCHAR2(20),
  tran_seq_sn          VARCHAR2(40),
  biz_num              VARCHAR2(40),
  biz_type             VARCHAR2(20),
  user_num             VARCHAR2(40),
  org_num              VARCHAR2(40),
  customer_num         VARCHAR2(40),
  party_name           VARCHAR2(200),
  product_num          VARCHAR2(10),
  amt                  NUMBER(18,2),
  currency_cd          VARCHAR2(10),
  reco_year            VARCHAR2(10),
  reco_month           VARCHAR2(10),
  create_time          DATE,
  update_time          DATE,
  remark               VARCHAR2(100)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on table CLM.TB_RCM_WARN_INFO_HIS
  is '�޶�Ԥ����ʷ��Ϣ��һ�����ϣ�';
comment on column CLM.TB_RCM_WARN_INFO_HIS.warn_num
  is 'Ԥ�����';
comment on column CLM.TB_RCM_WARN_INFO_HIS.quota_num
  is '���ж��޶���';
comment on column CLM.TB_RCM_WARN_INFO_HIS.quota_name
  is '�޶�����';
comment on column CLM.TB_RCM_WARN_INFO_HIS.quota_index_num
  is '�޶�ָ����';
comment on column CLM.TB_RCM_WARN_INFO_HIS.quota_used_amt
  is '�޶����ý��-Ԥ��ʱ����';
comment on column CLM.TB_RCM_WARN_INFO_HIS.quota_free_amt
  is '�޶���ý��-Ԥ��ʱ����';
comment on column CLM.TB_RCM_WARN_INFO_HIS.quota_used_ratio
  is '�޶����ñ���-Ԥ��ʱ����';
comment on column CLM.TB_RCM_WARN_INFO_HIS.quota_free_ratio
  is '�޶���ñ���-Ԥ��ʱ����';
comment on column CLM.TB_RCM_WARN_INFO_HIS.quota_total_sum
  is '�޶��ܶ�';
comment on column CLM.TB_RCM_WARN_INFO_HIS.quota_total_type
  is '�޶��ܶ�����(1-�ʱ����2-һ���ʱ����3-���������ܶ)';
comment on column CLM.TB_RCM_WARN_INFO_HIS.use_org_num
  is '�޶���Ч����';
comment on column CLM.TB_RCM_WARN_INFO_HIS.trigger_time
  is '����ʱ��';
comment on column CLM.TB_RCM_WARN_INFO_HIS.trigger_level
  is '��ֵ�㼶(1���۲죻2��Ԥ����3������)';
comment on column CLM.TB_RCM_WARN_INFO_HIS.quota_control_amt
  is 'Ԥ����ֵ(���)';
comment on column CLM.TB_RCM_WARN_INFO_HIS.quota_control_ratio
  is 'Ԥ����ֵ(����)';
comment on column CLM.TB_RCM_WARN_INFO_HIS.trigger_amt
  is '������ǰֵ(���)';
comment on column CLM.TB_RCM_WARN_INFO_HIS.trigger_ratio
  is '������ǰֵ(ռ��)';
comment on column CLM.TB_RCM_WARN_INFO_HIS.trigger_control_node
  is '�����ܿؽڵ�';
comment on column CLM.TB_RCM_WARN_INFO_HIS.node_measure
  is 'Ӧ�Դ�ʩ(1-��ʾ��2-����������3-��ֹ����)';
comment on column CLM.TB_RCM_WARN_INFO_HIS.measure_level
  is '��Ӧ��ʩ�ȼ�(1-һ����2-������3������)';
comment on column CLM.TB_RCM_WARN_INFO_HIS.tran_seq_sn
  is '����ҵ����ˮ��';
comment on column CLM.TB_RCM_WARN_INFO_HIS.biz_num
  is '����ҵ����';
comment on column CLM.TB_RCM_WARN_INFO_HIS.biz_type
  is 'ҵ������(1���������   2����ͬ����   3���ſ�����   4��ͬҵҵ������)';
comment on column CLM.TB_RCM_WARN_INFO_HIS.user_num
  is 'ҵ��ͻ�����';
comment on column CLM.TB_RCM_WARN_INFO_HIS.org_num
  is 'ҵ���������';
comment on column CLM.TB_RCM_WARN_INFO_HIS.customer_num
  is '�ͻ����';
comment on column CLM.TB_RCM_WARN_INFO_HIS.party_name
  is '�ͻ�����';
comment on column CLM.TB_RCM_WARN_INFO_HIS.product_num
  is 'ҵ��Ʒ��';
comment on column CLM.TB_RCM_WARN_INFO_HIS.amt
  is '�������';
comment on column CLM.TB_RCM_WARN_INFO_HIS.currency_cd
  is '����';
comment on column CLM.TB_RCM_WARN_INFO_HIS.reco_year
  is '�������';
comment on column CLM.TB_RCM_WARN_INFO_HIS.reco_month
  is '�����·�';
comment on column CLM.TB_RCM_WARN_INFO_HIS.create_time
  is '�����ֶ�1';
comment on column CLM.TB_RCM_WARN_INFO_HIS.update_time
  is 'ά��ʱ��';
comment on column CLM.TB_RCM_WARN_INFO_HIS.remark
  is '��ע';
alter table CLM.TB_RCM_WARN_INFO_HIS
  add constraint P_KEY_146 primary key (WARN_NUM)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table TB_SYS_DATE
prompt ==========================
prompt
create table CLM.TB_SYS_DATE
(
  work_date     VARCHAR2(20) not null,
  batch_date    VARCHAR2(20) not null,
  system_switch VARCHAR2(1) not null,
  id            VARCHAR2(32),
  branch_no     VARCHAR2(20),
  tx_close_ind  VARCHAR2(20)
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
comment on table CLM.TB_SYS_DATE
  is 'Ӫҵ����';
comment on column CLM.TB_SYS_DATE.work_date
  is '��ǰӪҵ����';
comment on column CLM.TB_SYS_DATE.batch_date
  is '��ǰ��������';
comment on column CLM.TB_SYS_DATE.system_switch
  is 'ϵͳ���أ�1�� 2�أ�';
alter table CLM.TB_SYS_DATE
  add constraint TB_SYS_DATE_PK primary key (WORK_DATE)
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
prompt Creating table TB_SYS_DEMO
prompt ==========================
prompt
create table CLM.TB_SYS_DEMO
(
  demo_id        VARCHAR2(50) not null,
  customer_num   VARCHAR2(50) not null,
  sex            VARCHAR2(1) not null,
  cert_no        VARCHAR2(50) not null,
  cert_type      VARCHAR2(10) not null,
  address        VARCHAR2(100) not null,
  phone_no       INTEGER not null,
  work_year      INTEGER not null,
  deposit_amount NUMBER(18,2),
  column_9       NUMBER(6,2)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on table CLM.TB_SYS_DEMO
  is '��ʾ��';
alter table CLM.TB_SYS_DEMO
  add constraint TB_SYS_DEMO_PK primary key (DEMO_ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table TB_TEST_TABLE
prompt ============================
prompt
create table CLM.TB_TEST_TABLE
(
  id  VARCHAR2(32) not null,
  ket VARCHAR2(1) not null
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
create unique index CLM.INDEX_TEST_TABLE on CLM.TB_TEST_TABLE (ID)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table TB_USER_ROLE
prompt ===========================
prompt
create table CLM.TB_USER_ROLE
(
  id            VARCHAR2(32) not null,
  user_id       VARCHAR2(32) not null,
  role_id       VARCHAR2(500) not null,
  dept_id       VARCHAR2(32) not null,
  is_master_org INTEGER default 0
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
comment on table CLM.TB_USER_ROLE
  is '�û���ɫ��';
comment on column CLM.TB_USER_ROLE.id
  is '����';
comment on column CLM.TB_USER_ROLE.user_id
  is '�û�ID';
comment on column CLM.TB_USER_ROLE.role_id
  is '��ɫID';
comment on column CLM.TB_USER_ROLE.dept_id
  is '����ID';
alter table CLM.TB_USER_ROLE
  add primary key (ID)
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
prompt Creating table TP_CMN_BUSINESS_DATE
prompt ===================================
prompt
create table CLM.TP_CMN_BUSINESS_DATE
(
  id           VARCHAR2(32) not null,
  branch_no    VARCHAR2(20),
  work_date    DATE,
  batch_date   DATE,
  tx_close_ind VARCHAR2(20)
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
prompt Creating table TP_CMN_CODES
prompt ===========================
prompt
create table CLM.TP_CMN_CODES
(
  code_id        VARCHAR2(32) not null,
  parent_code_id VARCHAR2(32),
  code_level_cd  CHAR(1),
  code_cd        VARCHAR2(50),
  code_key       VARCHAR2(50),
  code_name      VARCHAR2(255),
  code_type_cd   VARCHAR2(50) not null,
  order_no       VARCHAR2(10),
  default_ind    CHAR(1),
  ec_code        VARCHAR2(50),
  is_flag        CHAR(1) default '1'
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
prompt Creating table TP_SCU_ORGANIZATION
prompt ==================================
prompt
create table CLM.TP_SCU_ORGANIZATION
(
  org_id          VARCHAR2(32) not null,
  superior_id     VARCHAR2(32),
  org_cd          VARCHAR2(20) not null,
  org_name        VARCHAR2(50),
  org_level_cd    CHAR(1) not null,
  pbc_org_cd      VARCHAR2(20),
  org_license     VARCHAR2(30),
  biz_license     VARCHAR2(30),
  post_code       VARCHAR2(6),
  org_address     VARCHAR2(255),
  status          CHAR(1),
  supervisor      VARCHAR2(20),
  phone           VARCHAR2(20),
  remark          VARCHAR2(100),
  superior_cd     VARCHAR2(20),
  superior_name   VARCHAR2(50),
  fax             VARCHAR2(20),
  account_code    VARCHAR2(20),
  org_property    CHAR(1),
  org_area        CHAR(1),
  org_type        CHAR(1),
  org_region      VARCHAR2(50),
  org_internal_cd VARCHAR2(20),
  open_code       VARCHAR2(20),
  contact         VARCHAR2(20),
  bank_no         VARCHAR2(20),
  if_country      VARCHAR2(10),
  pic_key         VARCHAR2(20),
  org_type_cd     CHAR(1),
  real_org_cd     VARCHAR2(20),
  legal_person    VARCHAR2(20)
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
prompt Creating table TP_SCU_STRUCTURE
prompt ===============================
prompt
create table CLM.TP_SCU_STRUCTURE
(
  structure_id  VARCHAR2(32) not null,
  dpt_id        VARCHAR2(32) not null,
  position_id   VARCHAR2(32) not null,
  position_cd   VARCHAR2(20),
  position_name VARCHAR2(50),
  dpt_cd        VARCHAR2(20),
  dpt_name      VARCHAR2(50),
  org_cd        VARCHAR2(20),
  org_name      VARCHAR2(50),
  org_id        VARCHAR2(32),
  status        CHAR(1)
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
prompt Creating table TP_SCU_USER
prompt ==========================
prompt
create table CLM.TP_SCU_USER
(
  user_id               VARCHAR2(32) not null,
  user_cd               VARCHAR2(20) not null,
  user_name             VARCHAR2(20) not null,
  password              VARCHAR2(32),
  password_status       CHAR(1) default '0',
  status                CHAR(1),
  retry_level           CHAR(1),
  dpt_cd                VARCHAR2(20) not null,
  dpt_name              VARCHAR2(50),
  org_cd                VARCHAR2(20) not null,
  org_name              VARCHAR2(50),
  valid_date            DATE,
  invalid_date          DATE,
  transfer_ind          CHAR(1),
  remark                VARCHAR2(100),
  transfer_status       CHAR(1),
  org_id                VARCHAR2(32),
  dpt_id                VARCHAR2(32),
  email                 VARCHAR2(100),
  office_phone          VARCHAR2(20),
  mobile_phone          VARCHAR2(20),
  gender                CHAR(1),
  address               VARCHAR2(100),
  cert_type             VARCHAR2(2),
  cert_code             VARCHAR2(30),
  birthday              DATE,
  education             VARCHAR2(2),
  post_code             VARCHAR2(6),
  qualification_type    VARCHAR2(2),
  qualification_no      VARCHAR2(20),
  training_license_type VARCHAR2(2),
  training_license_no   VARCHAR2(20),
  is_mirco_team         VARCHAR2(2),
  province_cd           VARCHAR2(20),
  district              VARCHAR2(20),
  city_cd               VARCHAR2(20),
  street_address        VARCHAR2(100)
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
prompt Creating table TP_SCU_USER_BINDING
prompt ==================================
prompt
create table CLM.TP_SCU_USER_BINDING
(
  user_binding_id   VARCHAR2(32) not null,
  user_id           VARCHAR2(32) not null,
  structure_id      VARCHAR2(32) not null,
  user_cd           VARCHAR2(20),
  user_name         VARCHAR2(20),
  in_transfer_ind   CHAR(1) default '0',
  out_transfer_ind  CHAR(1),
  resource_cd_array VARCHAR2(1024)
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
prompt Creating table TT_BILL_CRD_TRAN_BUS_SOURCE
prompt ==========================================
prompt
create table CLM.TT_BILL_CRD_TRAN_BUS_SOURCE
(
  tran_seq_sn     VARCHAR2(40),
  tran_date       VARCHAR2(20),
  busi_deal_num   VARCHAR2(40),
  tran_type_cd    VARCHAR2(2),
  crd_apply_amt   NUMBER(24,6),
  crd_currency_cd VARCHAR2(10)
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
comment on table CLM.TT_BILL_CRD_TRAN_BUS_SOURCE
  is 'Ʊ��ϵͳ��Ƚ�����Ϣ';
comment on column CLM.TT_BILL_CRD_TRAN_BUS_SOURCE.tran_seq_sn
  is '������ˮ��';
comment on column CLM.TT_BILL_CRD_TRAN_BUS_SOURCE.tran_date
  is '��������';
comment on column CLM.TT_BILL_CRD_TRAN_BUS_SOURCE.busi_deal_num
  is 'ҵ����';
comment on column CLM.TT_BILL_CRD_TRAN_BUS_SOURCE.tran_type_cd
  is '��������';
comment on column CLM.TT_BILL_CRD_TRAN_BUS_SOURCE.crd_apply_amt
  is '���Ž��';
comment on column CLM.TT_BILL_CRD_TRAN_BUS_SOURCE.crd_currency_cd
  is '����(CD000019)';

prompt
prompt Creating table TT_BILL_CRD_TRAN_OPT_SOURCE
prompt ==========================================
prompt
create table CLM.TT_BILL_CRD_TRAN_OPT_SOURCE
(
  tran_seq_sn        VARCHAR2(40),
  tran_date          VARCHAR2(20),
  busi_prd_num       VARCHAR2(3),
  busi_deal_desc     VARCHAR2(100),
  busi_deal_org_num  VARCHAR2(6),
  busi_deal_org_name VARCHAR2(100),
  busi_oppt_org_num  VARCHAR2(6),
  busi_oppt_org_name VARCHAR2(100),
  busi_sum_amt       NUMBER(24,6),
  busi_cert_cnt      VARCHAR2(3)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on table CLM.TT_BILL_CRD_TRAN_OPT_SOURCE
  is 'Ʊ��ϵͳ���ʹ����Ϣ';
comment on column CLM.TT_BILL_CRD_TRAN_OPT_SOURCE.tran_seq_sn
  is '������ˮ��';
comment on column CLM.TT_BILL_CRD_TRAN_OPT_SOURCE.tran_date
  is '��������';
comment on column CLM.TT_BILL_CRD_TRAN_OPT_SOURCE.busi_prd_num
  is 'ҵ���Ʒ���';
comment on column CLM.TT_BILL_CRD_TRAN_OPT_SOURCE.busi_deal_desc
  is 'ҵ��������';
comment on column CLM.TT_BILL_CRD_TRAN_OPT_SOURCE.busi_deal_org_num
  is '��������';
comment on column CLM.TT_BILL_CRD_TRAN_OPT_SOURCE.busi_deal_org_name
  is '������������';
comment on column CLM.TT_BILL_CRD_TRAN_OPT_SOURCE.busi_oppt_org_num
  is '���ֻ���';
comment on column CLM.TT_BILL_CRD_TRAN_OPT_SOURCE.busi_oppt_org_name
  is '���ֻ�������';
comment on column CLM.TT_BILL_CRD_TRAN_OPT_SOURCE.busi_sum_amt
  is '�����ܽ��';
comment on column CLM.TT_BILL_CRD_TRAN_OPT_SOURCE.busi_cert_cnt
  is 'ƾ֤����';

prompt
prompt Creating table TT_BILL_OPT_CERT_SOURCE
prompt ======================================
prompt
create table CLM.TT_BILL_OPT_CERT_SOURCE
(
  tran_seq_sn           VARCHAR2(40),
  tran_date             VARCHAR2(20),
  crd_grant_org_num     VARCHAR2(12),
  customer_num          VARCHAR2(10),
  crd_detail_prd        VARCHAR2(10),
  crd_currency_cd       VARCHAR2(10),
  cert_num              VARCHAR2(40),
  cert_type_cd          VARCHAR2(40),
  cert_ppt_cd           VARCHAR2(2),
  cert_interest_period  VARCHAR2(40),
  cert_interest_rate    NUMBER(24,6),
  cert_currency_cd      VARCHAR2(3),
  cert_seq_amt          NUMBER(24,6),
  cert_apply_amt        NUMBER(24,6),
  cert_apply_balance    NUMBER(24,6),
  cert_status           VARCHAR2(1),
  cert_begin_date       VARCHAR2(20),
  cert_end_date         VARCHAR2(20),
  cert_finish_date      VARCHAR2(20),
  cert_drawer_cust_num  VARCHAR2(10),
  cert_drawer_name      VARCHAR2(100),
  cert_drawer_bank_num  VARCHAR2(50),
  cert_drawer_bank_name VARCHAR2(100),
  cert_guaranty_type    VARCHAR2(2),
  cert_guaranty_person  VARCHAR2(10),
  cert_busi_remark      VARCHAR2(100)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on table CLM.TT_BILL_OPT_CERT_SOURCE
  is 'ƾ֤��Ϣ';
comment on column CLM.TT_BILL_OPT_CERT_SOURCE.tran_seq_sn
  is '������ˮ';
comment on column CLM.TT_BILL_OPT_CERT_SOURCE.tran_date
  is '��������';
comment on column CLM.TT_BILL_OPT_CERT_SOURCE.crd_grant_org_num
  is '���Ż���';
comment on column CLM.TT_BILL_OPT_CERT_SOURCE.customer_num
  is 'ECIF�ͻ���';
comment on column CLM.TT_BILL_OPT_CERT_SOURCE.crd_detail_prd
  is '���������Ʒ';
comment on column CLM.TT_BILL_OPT_CERT_SOURCE.crd_currency_cd
  is '����';
comment on column CLM.TT_BILL_OPT_CERT_SOURCE.cert_num
  is 'ƾ֤���';
comment on column CLM.TT_BILL_OPT_CERT_SOURCE.cert_type_cd
  is 'ƾ֤����';
comment on column CLM.TT_BILL_OPT_CERT_SOURCE.cert_ppt_cd
  is 'ƾ֤����';
comment on column CLM.TT_BILL_OPT_CERT_SOURCE.cert_interest_period
  is 'ƾ֤��Ϣ����';
comment on column CLM.TT_BILL_OPT_CERT_SOURCE.cert_interest_rate
  is '������/����';
comment on column CLM.TT_BILL_OPT_CERT_SOURCE.cert_currency_cd
  is '����(CD000019)';
comment on column CLM.TT_BILL_OPT_CERT_SOURCE.cert_seq_amt
  is 'ƾ֤ԭʼ���';
comment on column CLM.TT_BILL_OPT_CERT_SOURCE.cert_apply_amt
  is 'ƾ֤���Ž��';
comment on column CLM.TT_BILL_OPT_CERT_SOURCE.cert_apply_balance
  is 'ƾ֤�������';
comment on column CLM.TT_BILL_OPT_CERT_SOURCE.cert_status
  is 'ƾ֤״̬';
comment on column CLM.TT_BILL_OPT_CERT_SOURCE.cert_begin_date
  is 'ƾ֤����';
comment on column CLM.TT_BILL_OPT_CERT_SOURCE.cert_end_date
  is 'ƾֹ֤��';
comment on column CLM.TT_BILL_OPT_CERT_SOURCE.cert_finish_date
  is 'ƾ֤��������';
comment on column CLM.TT_BILL_OPT_CERT_SOURCE.cert_drawer_cust_num
  is '�����˿ͻ���';
comment on column CLM.TT_BILL_OPT_CERT_SOURCE.cert_drawer_name
  is '�����˿ͻ�����';
comment on column CLM.TT_BILL_OPT_CERT_SOURCE.cert_drawer_bank_num
  is '�����˴���/�ж��к�';
comment on column CLM.TT_BILL_OPT_CERT_SOURCE.cert_drawer_bank_name
  is '�����˴���/�ж�������';
comment on column CLM.TT_BILL_OPT_CERT_SOURCE.cert_guaranty_type
  is '������ʽ(CD000100)';
comment on column CLM.TT_BILL_OPT_CERT_SOURCE.cert_guaranty_person
  is '������';
comment on column CLM.TT_BILL_OPT_CERT_SOURCE.cert_busi_remark
  is '��ע';

prompt
prompt Creating table TT_CRD_APPROVE_DETAIL_SOURCE
prompt ===========================================
prompt
create table CLM.TT_CRD_APPROVE_DETAIL_SOURCE
(
  approve_num           VARCHAR2(50),
  pf_num                VARCHAR2(50),
  biz_happen_type       VARCHAR2(2),
  is_low_risk           VARCHAR2(1),
  currency_cd           VARCHAR2(10),
  exchange_rete         NUMBER(24,2),
  approve_amt           NUMBER(24,2),
  product_num           VARCHAR2(50),
  product_type          VARCHAR2(50),
  is_circle             VARCHAR2(2),
  industry              VARCHAR2(10),
  guarantee_type        VARCHAR2(10),
  main_guarantee_type   VARCHAR2(10),
  guarantee_type_detail VARCHAR2(10),
  deposit_ratio         NUMBER(24,2),
  term                  NUMBER(24,2),
  term_unit             VARCHAR2(10),
  project_num           VARCHAR2(50),
  old_summary_num       VARCHAR2(50)
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
comment on table CLM.TT_CRD_APPROVE_DETAIL_SOURCE
  is '������ϸ��Ϣ��ر�';
comment on column CLM.TT_CRD_APPROVE_DETAIL_SOURCE.approve_num
  is '������';
comment on column CLM.TT_CRD_APPROVE_DETAIL_SOURCE.pf_num
  is '������';
comment on column CLM.TT_CRD_APPROVE_DETAIL_SOURCE.biz_happen_type
  is '���������';
comment on column CLM.TT_CRD_APPROVE_DETAIL_SOURCE.is_low_risk
  is '�Ƿ�ͷ���ҵ��';
comment on column CLM.TT_CRD_APPROVE_DETAIL_SOURCE.currency_cd
  is '����';
comment on column CLM.TT_CRD_APPROVE_DETAIL_SOURCE.exchange_rete
  is '����';
comment on column CLM.TT_CRD_APPROVE_DETAIL_SOURCE.approve_amt
  is '������ϸ���';
comment on column CLM.TT_CRD_APPROVE_DETAIL_SOURCE.product_num
  is '��Ʒ';
comment on column CLM.TT_CRD_APPROVE_DETAIL_SOURCE.product_type
  is 'ҵ������';
comment on column CLM.TT_CRD_APPROVE_DETAIL_SOURCE.is_circle
  is '���ѭ����־';
comment on column CLM.TT_CRD_APPROVE_DETAIL_SOURCE.industry
  is '������;����';
comment on column CLM.TT_CRD_APPROVE_DETAIL_SOURCE.guarantee_type
  is '������ʽ';
comment on column CLM.TT_CRD_APPROVE_DETAIL_SOURCE.main_guarantee_type
  is '��������ʽ';
comment on column CLM.TT_CRD_APPROVE_DETAIL_SOURCE.guarantee_type_detail
  is '������ʽ����';
comment on column CLM.TT_CRD_APPROVE_DETAIL_SOURCE.deposit_ratio
  is '��֤�����';
comment on column CLM.TT_CRD_APPROVE_DETAIL_SOURCE.term
  is '��������';
comment on column CLM.TT_CRD_APPROVE_DETAIL_SOURCE.term_unit
  is '�������޵�λ';
comment on column CLM.TT_CRD_APPROVE_DETAIL_SOURCE.project_num
  is '��ĿЭ���';
comment on column CLM.TT_CRD_APPROVE_DETAIL_SOURCE.old_summary_num
  is '�ɽ�ݱ��';

prompt
prompt Creating table TT_CRD_APPROVE_SOURCE
prompt ====================================
prompt
create table CLM.TT_CRD_APPROVE_SOURCE
(
  approve_num        VARCHAR2(50),
  pf_num             VARCHAR2(50),
  customer_num       VARCHAR2(50),
  customer_type      VARCHAR2(50),
  is_bank_rel        VARCHAR2(1),
  is_joint_guanantee VARCHAR2(1),
  total_amt          NUMBER(24,2),
  biz_type           VARCHAR2(2),
  tran_date          VARCHAR2(20),
  approve_status     VARCHAR2(1),
  user_num           VARCHAR2(50),
  org_num            VARCHAR2(50)
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
comment on table CLM.TT_CRD_APPROVE_SOURCE
  is '������Ϣ��ر�';
comment on column CLM.TT_CRD_APPROVE_SOURCE.approve_num
  is '������';
comment on column CLM.TT_CRD_APPROVE_SOURCE.pf_num
  is '������';
comment on column CLM.TT_CRD_APPROVE_SOURCE.customer_num
  is 'ECIF�ͻ���';
comment on column CLM.TT_CRD_APPROVE_SOURCE.customer_type
  is '�ͻ�����';
comment on column CLM.TT_CRD_APPROVE_SOURCE.is_bank_rel
  is '�Ƿ����й�����';
comment on column CLM.TT_CRD_APPROVE_SOURCE.is_joint_guanantee
  is '�Ƿ�����';
comment on column CLM.TT_CRD_APPROVE_SOURCE.total_amt
  is '�������';
comment on column CLM.TT_CRD_APPROVE_SOURCE.biz_type
  is 'ҵ������';
comment on column CLM.TT_CRD_APPROVE_SOURCE.tran_date
  is '��������';
comment on column CLM.TT_CRD_APPROVE_SOURCE.approve_status
  is '����״̬';
comment on column CLM.TT_CRD_APPROVE_SOURCE.user_num
  is '�ͻ�����';
comment on column CLM.TT_CRD_APPROVE_SOURCE.org_num
  is '������';

prompt
prompt Creating table TT_CRD_BILL_INFO_SOURCE
prompt ======================================
prompt
create table CLM.TT_CRD_BILL_INFO_SOURCE
(
  contract_num        VARCHAR2(50),
  currency_cd         VARCHAR2(10),
  exchange_rate       NUMBER(10,6),
  user_num            VARCHAR2(10),
  org_num             VARCHAR2(10),
  bill_num            VARCHAR2(50),
  summary_num         VARCHAR2(50),
  bill_type           VARCHAR2(10),
  bill_status         VARCHAR2(6),
  summary_amt         NUMBER(24,2),
  begin_date          VARCHAR2(20),
  end_date            VARCHAR2(20),
  deposit_ratio       NUMBER(10,6),
  guarantee_type      VARCHAR2(50),
  main_guarantee_type VARCHAR2(50),
  acceptor_ecif_num   VARCHAR2(40),
  drawer_name         VARCHAR2(200),
  drawer_acct         VARCHAR2(50),
  drawer_bank_num     VARCHAR2(50),
  drawer_bank_name    VARCHAR2(200),
  pay_name            VARCHAR2(200),
  pay_acct            VARCHAR2(50),
  payee_name          VARCHAR2(200),
  payee_acct          VARCHAR2(50),
  payee_bank_num      VARCHAR2(50),
  payee_bank_name     VARCHAR2(200)
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
comment on table CLM.TT_CRD_BILL_INFO_SOURCE
  is 'Ʊ����Ϣ��';
comment on column CLM.TT_CRD_BILL_INFO_SOURCE.contract_num
  is '��ͬ��';
comment on column CLM.TT_CRD_BILL_INFO_SOURCE.currency_cd
  is '����';
comment on column CLM.TT_CRD_BILL_INFO_SOURCE.exchange_rate
  is '����';
comment on column CLM.TT_CRD_BILL_INFO_SOURCE.user_num
  is '�ͻ�����';
comment on column CLM.TT_CRD_BILL_INFO_SOURCE.org_num
  is '������';
comment on column CLM.TT_CRD_BILL_INFO_SOURCE.bill_num
  is 'Ʊ�ݺ�';
comment on column CLM.TT_CRD_BILL_INFO_SOURCE.summary_num
  is '��ݺ�';
comment on column CLM.TT_CRD_BILL_INFO_SOURCE.bill_type
  is 'Ʊ������';
comment on column CLM.TT_CRD_BILL_INFO_SOURCE.bill_status
  is 'Ʊ��״̬';
comment on column CLM.TT_CRD_BILL_INFO_SOURCE.summary_amt
  is 'Ʊ����';
comment on column CLM.TT_CRD_BILL_INFO_SOURCE.begin_date
  is 'Ʊ������';
comment on column CLM.TT_CRD_BILL_INFO_SOURCE.end_date
  is 'Ʊ��ֹ��';
comment on column CLM.TT_CRD_BILL_INFO_SOURCE.deposit_ratio
  is '��֤�����';
comment on column CLM.TT_CRD_BILL_INFO_SOURCE.guarantee_type
  is '������ʽ';
comment on column CLM.TT_CRD_BILL_INFO_SOURCE.main_guarantee_type
  is '��������ʽ';
comment on column CLM.TT_CRD_BILL_INFO_SOURCE.acceptor_ecif_num
  is '�ж���ECIF�ͻ���';
comment on column CLM.TT_CRD_BILL_INFO_SOURCE.drawer_name
  is '��Ʊ������';
comment on column CLM.TT_CRD_BILL_INFO_SOURCE.drawer_acct
  is '��Ʊ���˺�';
comment on column CLM.TT_CRD_BILL_INFO_SOURCE.drawer_bank_num
  is '��Ʊ�˿������к�';
comment on column CLM.TT_CRD_BILL_INFO_SOURCE.drawer_bank_name
  is '��Ʊ�˿���������';
comment on column CLM.TT_CRD_BILL_INFO_SOURCE.pay_name
  is '����������';
comment on column CLM.TT_CRD_BILL_INFO_SOURCE.pay_acct
  is '�������к�';
comment on column CLM.TT_CRD_BILL_INFO_SOURCE.payee_name
  is '�տ�������';
comment on column CLM.TT_CRD_BILL_INFO_SOURCE.payee_acct
  is '�տ����˺�';
comment on column CLM.TT_CRD_BILL_INFO_SOURCE.payee_bank_num
  is '�տ��˿������к�';
comment on column CLM.TT_CRD_BILL_INFO_SOURCE.payee_bank_name
  is '�տ��˿���������';

prompt
prompt Creating table TT_CRD_CC_INFO_SOURCE
prompt ====================================
prompt
create table CLM.TT_CRD_CC_INFO_SOURCE
(
  acct_no                 VARCHAR2(9),
  cust_id                 VARCHAR2(9),
  product_cd              VARCHAR2(6),
  curr_cd                 VARCHAR2(3),
  credit_limit            VARCHAR2(13),
  temp_limit              VARCHAR2(13),
  temp_limit_begin_date   VARCHAR2(20),
  temp_limit_end_date     VARCHAR2(20),
  cash_limit_rt           NUMBER(5,2),
  ovrlmt_rate             NUMBER(5,2),
  loan_limit_rt           NUMBER(5,2),
  curr_bal                NUMBER(15,2),
  cash_bal                NUMBER(15,2),
  principal_bal           NUMBER(15,2),
  loan_bal                NUMBER(15,2),
  qual_grace_bal          NUMBER(15,2),
  point_bal               NUMBER(15,2),
  setup_date              VARCHAR2(20),
  billing_cycle           VARCHAR2(10),
  stmt_flag               VARCHAR2(1),
  stmt_mail_addr_ind      VARCHAR2(1),
  stmt_media_type         VARCHAR2(1),
  block_code              VARCHAR2(27),
  age_cd                  VARCHAR2(10),
  dd_ind                  VARCHAR2(1),
  dd_bank_name            VARCHAR2(80),
  dd_bank_branch          VARCHAR2(9),
  dd_bank_acct_no         VARCHAR2(40),
  dd_bank_acct_name       VARCHAR2(80),
  closed_date             VARCHAR2(20),
  cancel_date             VARCHAR2(20),
  tot_due_amt             NUMBER(15,2),
  payment_hist            VARCHAR2(24),
  ctd_payment_amt         NUMBER(15,2),
  last_trans_date         VARCHAR2(20),
  actual_payment_amt      NUMBER(15,2),
  charge_off_amt          NUMBER(15,2),
  charge_off_date         VARCHAR2(20),
  unstmt_bal              NUMBER(15,2),
  remark                  VARCHAR2(300),
  ytd_retail_amt          NUMBER(15,2),
  collect_times           VARCHAR2(2),
  collect_reason          VARCHAR2(2),
  acct_type               VARCHAR2(1),
  bank_customer_id        VARCHAR2(20),
  ctd_reail_prin_bal      NUMBER(15,2),
  stmt_reail_prin_bal     NUMBER(15,2),
  ctd_cash_prin_bal       NUMBER(15,2),
  stmt_cash_prin_bal      NUMBER(15,2),
  ctd_loan_prin_bal       NUMBER(15,2),
  stmt_loan_prin_bal      NUMBER(15,2),
  large_loan_bal_xfrout   NUMBER(15,2),
  deposit_bal             NUMBER(15,2),
  ctd_loan_txn_fee        NUMBER(15,2),
  stmt_loan_txn_fee       NUMBER(15,2),
  ctd_cash_txn_fee        NUMBER(15,2),
  stmt_cash_txn_fee       NUMBER(15,2),
  ctd_other_txn_fee       NUMBER(15,2),
  stmt_other_txn_fee      NUMBER(15,2),
  ctd_anual_fee           NUMBER(15,2),
  stmt_anual_fee          NUMBER(15,2),
  ctd_late_charge_fee     NUMBER(15,2),
  stmt_late_charge_fee    NUMBER(15,2),
  ctd_service_fee         NUMBER(15,2),
  stmt_service_fee        NUMBER(15,2),
  ctd_int                 NUMBER(15,2),
  stmt_int                NUMBER(15,2),
  owning_branch           VARCHAR2(9),
  unmatch_db_amt          NUMBER(15,2),
  unmatch_cr_amt          NUMBER(15,2),
  coll_rec_type           VARCHAR2(1),
  collect_date            VARCHAR2(20),
  santisfied_date         VARCHAR2(20),
  overlimit_amt           NUMBER(15,2),
  loan_ind                VARCHAR2(1),
  last_stmt_date          VARCHAR2(20),
  last_due_date           VARCHAR2(20),
  remain_grace_bal        NUMBER(15,2),
  past_due_amt_1          NUMBER(15,2),
  past_due_amt_2          NUMBER(15,2),
  past_due_amt_3          NUMBER(15,2),
  past_due_amt_4          NUMBER(15,2),
  past_due_amt_5          NUMBER(15,2),
  past_due_amt_6          NUMBER(15,2),
  past_due_amt_7          NUMBER(15,2),
  age_hist                VARCHAR2(24),
  ctd_cash_cnt            VARCHAR2(6),
  dd_other_bank_ind       VARCHAR2(1),
  default_logical_card_no VARCHAR2(19),
  retail_int              NUMBER(15,2),
  cash_int                NUMBER(15,2),
  loan_int                NUMBER(15,2),
  pending_int_bal         NUMBER(15,2),
  dd_bank_branch_2        VARCHAR2(20),
  grace_days_full_ind     VARCHAR2(1),
  glp_branch              VARCHAR2(9),
  filler                  VARCHAR2(115)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on column CLM.TT_CRD_CC_INFO_SOURCE.acct_no
  is '�˻����';
comment on column CLM.TT_CRD_CC_INFO_SOURCE.cust_id
  is 'ECIF�ͻ����';
comment on column CLM.TT_CRD_CC_INFO_SOURCE.product_cd
  is '��Ʒ����';
comment on column CLM.TT_CRD_CC_INFO_SOURCE.curr_cd
  is '����';
comment on column CLM.TT_CRD_CC_INFO_SOURCE.credit_limit
  is '���ö��';
comment on column CLM.TT_CRD_CC_INFO_SOURCE.temp_limit
  is '��ʱ���';
comment on column CLM.TT_CRD_CC_INFO_SOURCE.temp_limit_begin_date
  is '��ʱ��ȿ�ʼ����';
comment on column CLM.TT_CRD_CC_INFO_SOURCE.temp_limit_end_date
  is '��ʱ��Ƚ�������';
comment on column CLM.TT_CRD_CC_INFO_SOURCE.cash_limit_rt
  is 'ȡ�ֶ�ȱ���';
comment on column CLM.TT_CRD_CC_INFO_SOURCE.ovrlmt_rate
  is '��Ȩ���ޱ���';
comment on column CLM.TT_CRD_CC_INFO_SOURCE.loan_limit_rt
  is '����ڷ��ڶ�ȱ���';
comment on column CLM.TT_CRD_CC_INFO_SOURCE.curr_bal
  is '��ǰ���';
comment on column CLM.TT_CRD_CC_INFO_SOURCE.cash_bal
  is 'ȡ�����';
comment on column CLM.TT_CRD_CC_INFO_SOURCE.principal_bal
  is '�������';
comment on column CLM.TT_CRD_CC_INFO_SOURCE.loan_bal
  is '����ڷ������';
comment on column CLM.TT_CRD_CC_INFO_SOURCE.qual_grace_bal
  is 'ȫ��Ӧ�����';
comment on column CLM.TT_CRD_CC_INFO_SOURCE.point_bal
  is '�������';
comment on column CLM.TT_CRD_CC_INFO_SOURCE.setup_date
  is '��������';
comment on column CLM.TT_CRD_CC_INFO_SOURCE.billing_cycle
  is '�˵�����';
comment on column CLM.TT_CRD_CC_INFO_SOURCE.stmt_flag
  is '�����˵���־';
comment on column CLM.TT_CRD_CC_INFO_SOURCE.stmt_mail_addr_ind
  is '�˵����͵�ַ��־';
comment on column CLM.TT_CRD_CC_INFO_SOURCE.stmt_media_type
  is '�˵���������';
comment on column CLM.TT_CRD_CC_INFO_SOURCE.block_code
  is '������';
comment on column CLM.TT_CRD_CC_INFO_SOURCE.age_cd
  is '����';
comment on column CLM.TT_CRD_CC_INFO_SOURCE.dd_ind
  is 'Լ����������';
comment on column CLM.TT_CRD_CC_INFO_SOURCE.dd_bank_name
  is 'Լ��������������';
comment on column CLM.TT_CRD_CC_INFO_SOURCE.dd_bank_branch
  is 'Լ��������к�';
comment on column CLM.TT_CRD_CC_INFO_SOURCE.dd_bank_acct_no
  is 'Լ������ۿ��˺�';
comment on column CLM.TT_CRD_CC_INFO_SOURCE.dd_bank_acct_name
  is 'Լ������ۿ��˻�����';
comment on column CLM.TT_CRD_CC_INFO_SOURCE.closed_date
  is '������������';
comment on column CLM.TT_CRD_CC_INFO_SOURCE.cancel_date
  is 'Ԥ��������';
comment on column CLM.TT_CRD_CC_INFO_SOURCE.tot_due_amt
  is '��С�����';
comment on column CLM.TT_CRD_CC_INFO_SOURCE.payment_hist
  is '������ʷ��Ϣ';
comment on column CLM.TT_CRD_CC_INFO_SOURCE.ctd_payment_amt
  is '���ڻ�����';
comment on column CLM.TT_CRD_CC_INFO_SOURCE.last_trans_date
  is '�ͻ����������';
comment on column CLM.TT_CRD_CC_INFO_SOURCE.actual_payment_amt
  is '����ʵ�ʻ�����';
comment on column CLM.TT_CRD_CC_INFO_SOURCE.charge_off_amt
  is '�������';
comment on column CLM.TT_CRD_CC_INFO_SOURCE.charge_off_date
  is '��������';
comment on column CLM.TT_CRD_CC_INFO_SOURCE.unstmt_bal
  is 'δ���˵����';
comment on column CLM.TT_CRD_CC_INFO_SOURCE.remark
  is '��ע';
comment on column CLM.TT_CRD_CC_INFO_SOURCE.ytd_retail_amt
  is '�������ѽ��';
comment on column CLM.TT_CRD_CC_INFO_SOURCE.collect_times
  is '��ߴ���';
comment on column CLM.TT_CRD_CC_INFO_SOURCE.collect_reason
  is '���ԭ��';
comment on column CLM.TT_CRD_CC_INFO_SOURCE.acct_type
  is '�˻�����';
comment on column CLM.TT_CRD_CC_INFO_SOURCE.bank_customer_id
  is '���ڿͻ���';
comment on column CLM.TT_CRD_CC_INFO_SOURCE.ctd_reail_prin_bal
  is '�������ѱ������';
comment on column CLM.TT_CRD_CC_INFO_SOURCE.stmt_reail_prin_bal
  is '�ѳ��˵����ѱ������';
comment on column CLM.TT_CRD_CC_INFO_SOURCE.ctd_cash_prin_bal
  is '����ȡ�ֱ������';
comment on column CLM.TT_CRD_CC_INFO_SOURCE.stmt_cash_prin_bal
  is '�ѳ��˵�ȡ�ֱ������';
comment on column CLM.TT_CRD_CC_INFO_SOURCE.ctd_loan_prin_bal
  is '���ڷ���Ӧ���������';
comment on column CLM.TT_CRD_CC_INFO_SOURCE.stmt_loan_prin_bal
  is '�ѳ��˵�����Ӧ���������';
comment on column CLM.TT_CRD_CC_INFO_SOURCE.large_loan_bal_xfrout
  is '�����������';
comment on column CLM.TT_CRD_CC_INFO_SOURCE.deposit_bal
  is '��ɿ�';
comment on column CLM.TT_CRD_CC_INFO_SOURCE.ctd_loan_txn_fee
  is '���ڷ��ڽ��׷�';
comment on column CLM.TT_CRD_CC_INFO_SOURCE.stmt_loan_txn_fee
  is '�ѳ��˵����ڽ��׷�';
comment on column CLM.TT_CRD_CC_INFO_SOURCE.ctd_cash_txn_fee
  is '����ȡ�ֽ��׷�';
comment on column CLM.TT_CRD_CC_INFO_SOURCE.stmt_cash_txn_fee
  is '�ѳ��˵�ȡ�ֽ��׷�';
comment on column CLM.TT_CRD_CC_INFO_SOURCE.ctd_other_txn_fee
  is '�����������׷�';
comment on column CLM.TT_CRD_CC_INFO_SOURCE.stmt_other_txn_fee
  is '�ѳ��˵��������׷�';
comment on column CLM.TT_CRD_CC_INFO_SOURCE.ctd_anual_fee
  is '�������';
comment on column CLM.TT_CRD_CC_INFO_SOURCE.stmt_anual_fee
  is '�ѳ��˵����';
comment on column CLM.TT_CRD_CC_INFO_SOURCE.ctd_late_charge_fee
  is '����ΥԼ��';
comment on column CLM.TT_CRD_CC_INFO_SOURCE.stmt_late_charge_fee
  is '�ѳ��˵�ΥԼ��';
comment on column CLM.TT_CRD_CC_INFO_SOURCE.ctd_service_fee
  is '���ڷ����';
comment on column CLM.TT_CRD_CC_INFO_SOURCE.stmt_service_fee
  is '�ѳ��˵������';
comment on column CLM.TT_CRD_CC_INFO_SOURCE.ctd_int
  is '������Ϣ';
comment on column CLM.TT_CRD_CC_INFO_SOURCE.stmt_int
  is '�ѳ��˵���Ϣ';
comment on column CLM.TT_CRD_CC_INFO_SOURCE.owning_branch
  is '��������';
comment on column CLM.TT_CRD_CC_INFO_SOURCE.unmatch_db_amt
  is 'δƥ���ǽ��';
comment on column CLM.TT_CRD_CC_INFO_SOURCE.unmatch_cr_amt
  is 'δƥ����ǽ��';
comment on column CLM.TT_CRD_CC_INFO_SOURCE.coll_rec_type
  is '���ռ�¼����';
comment on column CLM.TT_CRD_CC_INFO_SOURCE.collect_date
  is '�����������';
comment on column CLM.TT_CRD_CC_INFO_SOURCE.santisfied_date
  is '��������';
comment on column CLM.TT_CRD_CC_INFO_SOURCE.overlimit_amt
  is '���޽��';
comment on column CLM.TT_CRD_CC_INFO_SOURCE.loan_ind
  is '���޷����˻�';
comment on column CLM.TT_CRD_CC_INFO_SOURCE.last_stmt_date
  is '��һ�˵���';
comment on column CLM.TT_CRD_CC_INFO_SOURCE.last_due_date
  is '���ڵ��ڻ�����';
comment on column CLM.TT_CRD_CC_INFO_SOURCE.remain_grace_bal
  is '����Ƿ�����';
comment on column CLM.TT_CRD_CC_INFO_SOURCE.past_due_amt_1
  is '30������Ƿ��';
comment on column CLM.TT_CRD_CC_INFO_SOURCE.past_due_amt_2
  is '30-59��Ƿ��';
comment on column CLM.TT_CRD_CC_INFO_SOURCE.past_due_amt_3
  is '60-89��Ƿ��';
comment on column CLM.TT_CRD_CC_INFO_SOURCE.past_due_amt_4
  is '90-119��Ƿ��';
comment on column CLM.TT_CRD_CC_INFO_SOURCE.past_due_amt_5
  is '120-149��Ƿ��';
comment on column CLM.TT_CRD_CC_INFO_SOURCE.past_due_amt_6
  is '150-179��Ƿ��';
comment on column CLM.TT_CRD_CC_INFO_SOURCE.past_due_amt_7
  is '180�켰����Ƿ��';
comment on column CLM.TT_CRD_CC_INFO_SOURCE.age_hist
  is '24����������ʷ��Ϣ';
comment on column CLM.TT_CRD_CC_INFO_SOURCE.ctd_cash_cnt
  is '������ȡ�ֱ���';
comment on column CLM.TT_CRD_CC_INFO_SOURCE.dd_other_bank_ind
  is 'Լ���������д��۱�ʶ';
comment on column CLM.TT_CRD_CC_INFO_SOURCE.default_logical_card_no
  is 'Ĭ���߼�����';
comment on column CLM.TT_CRD_CC_INFO_SOURCE.retail_int
  is '������Ϣ';
comment on column CLM.TT_CRD_CC_INFO_SOURCE.cash_int
  is 'ȡ����Ϣ';
comment on column CLM.TT_CRD_CC_INFO_SOURCE.loan_int
  is '������Ϣ';
comment on column CLM.TT_CRD_CC_INFO_SOURCE.pending_int_bal
  is '��Ϣ��Ӧ���˿����';
comment on column CLM.TT_CRD_CC_INFO_SOURCE.dd_bank_branch_2
  is 'Լ����������к�2';
comment on column CLM.TT_CRD_CC_INFO_SOURCE.grace_days_full_ind
  is '�Ƿ�ȫ���';
comment on column CLM.TT_CRD_CC_INFO_SOURCE.glp_branch
  is '�������';
comment on column CLM.TT_CRD_CC_INFO_SOURCE.filler
  is 'Ԥ���ֶ�';

prompt
prompt Creating table TT_CRD_CONTRACT_SOURCE
prompt =====================================
prompt
create table CLM.TT_CRD_CONTRACT_SOURCE
(
  contract_num          VARCHAR2(50),
  approve_num           VARCHAR2(50),
  product_num           VARCHAR2(50),
  product_type          VARCHAR2(50),
  currency_cd           VARCHAR2(10),
  exchange_rate         NUMBER(24,6),
  contract_amt          NUMBER(24,6),
  begin_date            VARCHAR2(20),
  end_date              VARCHAR2(20),
  is_cycle              VARCHAR2(2),
  industry              VARCHAR2(10),
  guarantee_type        VARCHAR2(50),
  main_guarantee_type   VARCHAR2(10),
  deposit_ratio         NUMBER(24,6),
  contract_status       VARCHAR2(2),
  user_num              VARCHAR2(50),
  org_num               VARCHAR2(50),
  guarantee_type_detail VARCHAR2(50)
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
comment on table CLM.TT_CRD_CONTRACT_SOURCE
  is '��ͬ��Ϣ��ر�';
comment on column CLM.TT_CRD_CONTRACT_SOURCE.contract_num
  is '��ͬ���';
comment on column CLM.TT_CRD_CONTRACT_SOURCE.approve_num
  is 'ҵ��������';
comment on column CLM.TT_CRD_CONTRACT_SOURCE.product_num
  is '��Ʒ';
comment on column CLM.TT_CRD_CONTRACT_SOURCE.product_type
  is 'ҵ������';
comment on column CLM.TT_CRD_CONTRACT_SOURCE.currency_cd
  is '����';
comment on column CLM.TT_CRD_CONTRACT_SOURCE.exchange_rate
  is '����';
comment on column CLM.TT_CRD_CONTRACT_SOURCE.contract_amt
  is '��ͬ���';
comment on column CLM.TT_CRD_CONTRACT_SOURCE.begin_date
  is '��ͬ����';
comment on column CLM.TT_CRD_CONTRACT_SOURCE.end_date
  is '��ֹͬ��';
comment on column CLM.TT_CRD_CONTRACT_SOURCE.is_cycle
  is '��ͬѭ����־';
comment on column CLM.TT_CRD_CONTRACT_SOURCE.industry
  is '������;����';
comment on column CLM.TT_CRD_CONTRACT_SOURCE.guarantee_type
  is '������ʽ';
comment on column CLM.TT_CRD_CONTRACT_SOURCE.main_guarantee_type
  is '��������ʽ';
comment on column CLM.TT_CRD_CONTRACT_SOURCE.deposit_ratio
  is '��֤�����';
comment on column CLM.TT_CRD_CONTRACT_SOURCE.contract_status
  is '��ͬ״̬';
comment on column CLM.TT_CRD_CONTRACT_SOURCE.user_num
  is '�ͻ�����';
comment on column CLM.TT_CRD_CONTRACT_SOURCE.org_num
  is '������';

prompt
prompt Creating table TT_CRD_PROJECT_SOURCE
prompt ====================================
prompt
create table CLM.TT_CRD_PROJECT_SOURCE
(
  customer_num        VARCHAR2(50),
  customer_type       VARCHAR2(10),
  project_num         VARCHAR2(50),
  project_name        VARCHAR2(500),
  project_type        VARCHAR2(10),
  currency_cd         VARCHAR2(10),
  total_amt           NUMBER(24,2),
  limit_control_type  VARCHAR2(10),
  apply_date          VARCHAR2(20),
  agreement_term      NUMBER(24,2),
  agreement_term_unit VARCHAR2(2),
  project_status      VARCHAR2(2),
  user_num            VARCHAR2(50),
  org_num             VARCHAR2(50)
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
comment on table CLM.TT_CRD_PROJECT_SOURCE
  is '��ĿЭ����Ϣ��ر�';
comment on column CLM.TT_CRD_PROJECT_SOURCE.customer_num
  is 'ECIF�ͻ����';
comment on column CLM.TT_CRD_PROJECT_SOURCE.customer_type
  is '�ͻ�����';
comment on column CLM.TT_CRD_PROJECT_SOURCE.project_num
  is '��ĿЭ����';
comment on column CLM.TT_CRD_PROJECT_SOURCE.project_name
  is '��Ŀ����';
comment on column CLM.TT_CRD_PROJECT_SOURCE.project_type
  is '��Ŀ����';
comment on column CLM.TT_CRD_PROJECT_SOURCE.currency_cd
  is '����';
comment on column CLM.TT_CRD_PROJECT_SOURCE.total_amt
  is '���';
comment on column CLM.TT_CRD_PROJECT_SOURCE.limit_control_type
  is '�����ģ��ȿ��Ʒ�ʽ';
comment on column CLM.TT_CRD_PROJECT_SOURCE.apply_date
  is 'Э����������';
comment on column CLM.TT_CRD_PROJECT_SOURCE.agreement_term
  is 'Э����Ч��';
comment on column CLM.TT_CRD_PROJECT_SOURCE.agreement_term_unit
  is 'Э����Ч�ڵ�λ';
comment on column CLM.TT_CRD_PROJECT_SOURCE.project_status
  is '��Ŀ״̬';
comment on column CLM.TT_CRD_PROJECT_SOURCE.user_num
  is '�ͻ�����';
comment on column CLM.TT_CRD_PROJECT_SOURCE.org_num
  is '������';

prompt
prompt Creating table TT_CRD_RECOVERY_EVENT_SOURCE
prompt ===========================================
prompt
create table CLM.TT_CRD_RECOVERY_EVENT_SOURCE
(
  tran_seq_sn VARCHAR2(50),
  date_source VARCHAR2(2),
  summary_num VARCHAR2(40),
  is_settle   VARCHAR2(2),
  repay_amt   NUMBER(24,2),
  summary_bal NUMBER(24,2),
  repay_date  VARCHAR2(20),
  user_num    VARCHAR2(50),
  org_num     VARCHAR2(50)
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
comment on table CLM.TT_CRD_RECOVERY_EVENT_SOURCE
  is '���л�����Ϣ��ر�';
comment on column CLM.TT_CRD_RECOVERY_EVENT_SOURCE.tran_seq_sn
  is '������ˮ��';
comment on column CLM.TT_CRD_RECOVERY_EVENT_SOURCE.date_source
  is '������Դ';
comment on column CLM.TT_CRD_RECOVERY_EVENT_SOURCE.summary_num
  is '��ݺ�';
comment on column CLM.TT_CRD_RECOVERY_EVENT_SOURCE.is_settle
  is '�Ƿ����';
comment on column CLM.TT_CRD_RECOVERY_EVENT_SOURCE.repay_amt
  is '�����';
comment on column CLM.TT_CRD_RECOVERY_EVENT_SOURCE.summary_bal
  is '������';
comment on column CLM.TT_CRD_RECOVERY_EVENT_SOURCE.repay_date
  is '��������';
comment on column CLM.TT_CRD_RECOVERY_EVENT_SOURCE.user_num
  is '�ͻ�����';
comment on column CLM.TT_CRD_RECOVERY_EVENT_SOURCE.org_num
  is '������';

prompt
prompt Creating table TT_CRD_SUBCONTRACT_CON_SOURCE
prompt ============================================
prompt
create table CLM.TT_CRD_SUBCONTRACT_CON_SOURCE
(
  relation_id     VARCHAR2(50),
  subcontract_num NUMBER(24,6),
  contract_num    VARCHAR2(50),
  surety_amt      NUMBER(24,6)
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
comment on table CLM.TT_CRD_SUBCONTRACT_CON_SOURCE
  is '������ҵ���ͬ������ϵ';
comment on column CLM.TT_CRD_SUBCONTRACT_CON_SOURCE.relation_id
  is '����ID';
comment on column CLM.TT_CRD_SUBCONTRACT_CON_SOURCE.subcontract_num
  is '������ͬ���';
comment on column CLM.TT_CRD_SUBCONTRACT_CON_SOURCE.contract_num
  is '����ͬ���';
comment on column CLM.TT_CRD_SUBCONTRACT_CON_SOURCE.surety_amt
  is '���ε������';

prompt
prompt Creating table TT_CRD_SUBCONTRACT_SOURCE
prompt ========================================
prompt
create table CLM.TT_CRD_SUBCONTRACT_SOURCE
(
  subcontract_num  VARCHAR2(50),
  subcontract_type VARCHAR2(10),
  is_top           VARCHAR2(2),
  currency_cd      VARCHAR2(10),
  exchange_rate    NUMBER(24,6),
  subcontract_amt  NUMBER(24,6),
  begin_date       VARCHAR2(20),
  end_date         VARCHAR2(20)
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
comment on table CLM.TT_CRD_SUBCONTRACT_SOURCE
  is '������ͬ��Ϣ��ر�';
comment on column CLM.TT_CRD_SUBCONTRACT_SOURCE.subcontract_num
  is '������ͬ���';
comment on column CLM.TT_CRD_SUBCONTRACT_SOURCE.subcontract_type
  is '������ͬ����';
comment on column CLM.TT_CRD_SUBCONTRACT_SOURCE.is_top
  is '�Ƿ���߶����ͬ';
comment on column CLM.TT_CRD_SUBCONTRACT_SOURCE.currency_cd
  is '����';
comment on column CLM.TT_CRD_SUBCONTRACT_SOURCE.exchange_rate
  is '����';
comment on column CLM.TT_CRD_SUBCONTRACT_SOURCE.subcontract_amt
  is '������ͬ���';
comment on column CLM.TT_CRD_SUBCONTRACT_SOURCE.begin_date
  is '������ͬ����';
comment on column CLM.TT_CRD_SUBCONTRACT_SOURCE.end_date
  is '������ֹͬ��';

prompt
prompt Creating table TT_CRD_SUBCONTRACT_SUR_SRC
prompt =========================================
prompt
create table CLM.TT_CRD_SUBCONTRACT_SUR_SRC
(
  relation_id     VARCHAR2(50),
  surety_num      VARCHAR2(50),
  customer_num    VARCHAR2(50),
  subcontract_num NUMBER(24,6),
  surety_amt      NUMBER(24,6)
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
comment on table CLM.TT_CRD_SUBCONTRACT_SUR_SRC
  is '������ͬ��ѺƷ������ϵ';
comment on column CLM.TT_CRD_SUBCONTRACT_SUR_SRC.relation_id
  is '����ID';
comment on column CLM.TT_CRD_SUBCONTRACT_SUR_SRC.surety_num
  is 'ѺƷ���';
comment on column CLM.TT_CRD_SUBCONTRACT_SUR_SRC.customer_num
  is '��֤��ECIF�ͻ���';
comment on column CLM.TT_CRD_SUBCONTRACT_SUR_SRC.subcontract_num
  is '������ͬ���';
comment on column CLM.TT_CRD_SUBCONTRACT_SUR_SRC.surety_amt
  is '���ε������';

prompt
prompt Creating table TT_CRD_SUMMARY_SOURCE
prompt ====================================
prompt
create table CLM.TT_CRD_SUMMARY_SOURCE
(
  summary_num         VARCHAR2(50),
  contract_num        VARCHAR2(50),
  user_num            VARCHAR2(50),
  org_num             VARCHAR2(50),
  currency_cd         VARCHAR2(10),
  exchange_rate       NUMBER(24,2),
  summary_amt         NUMBER(24,2),
  summary_bal         NUMBER(24,2),
  begin_date          VARCHAR2(20),
  end_date            VARCHAR2(20),
  summary_status      VARCHAR2(2),
  guarantee_type      VARCHAR2(50),
  main_guarantee_type VARCHAR2(10)
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
comment on table CLM.TT_CRD_SUMMARY_SOURCE
  is '�����Ϣ��ر�';
comment on column CLM.TT_CRD_SUMMARY_SOURCE.summary_num
  is '��ݱ�ţ������Ż�����������ҵ���ţ�';
comment on column CLM.TT_CRD_SUMMARY_SOURCE.contract_num
  is '��ͬ���';
comment on column CLM.TT_CRD_SUMMARY_SOURCE.user_num
  is '�ͻ�����';
comment on column CLM.TT_CRD_SUMMARY_SOURCE.org_num
  is '������';
comment on column CLM.TT_CRD_SUMMARY_SOURCE.currency_cd
  is '����';
comment on column CLM.TT_CRD_SUMMARY_SOURCE.exchange_rate
  is '����';
comment on column CLM.TT_CRD_SUMMARY_SOURCE.summary_amt
  is '��ݽ��';
comment on column CLM.TT_CRD_SUMMARY_SOURCE.summary_bal
  is '������';
comment on column CLM.TT_CRD_SUMMARY_SOURCE.begin_date
  is '�������';
comment on column CLM.TT_CRD_SUMMARY_SOURCE.end_date
  is '���ֹ��';
comment on column CLM.TT_CRD_SUMMARY_SOURCE.summary_status
  is '���״̬';
comment on column CLM.TT_CRD_SUMMARY_SOURCE.guarantee_type
  is '������ʽ';
comment on column CLM.TT_CRD_SUMMARY_SOURCE.main_guarantee_type
  is '��������ʽ';

prompt
prompt Creating table TT_CRD_SURETY_SOURCE
prompt ===================================
prompt
create table CLM.TT_CRD_SURETY_SOURCE
(
  surety_num     VARCHAR2(50),
  pledge_name    VARCHAR2(50),
  pledge_type    VARCHAR2(10),
  customer_num   VARCHAR2(50),
  pledge_rate    NUMBER(24,6),
  amt_asses      NUMBER(24,6),
  amt_actual     NUMBER(24,6),
  guarantee_type VARCHAR2(2),
  user_num       VARCHAR2(50),
  org_num        VARCHAR2(50),
  pledge_status  VARCHAR2(10),
  customer_type  VARCHAR2(10)
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
comment on table CLM.TT_CRD_SURETY_SOURCE
  is 'ѺƷ��Ϣ��ر�';
comment on column CLM.TT_CRD_SURETY_SOURCE.surety_num
  is 'ѺƷ���';
comment on column CLM.TT_CRD_SURETY_SOURCE.pledge_name
  is 'ѺƷ����';
comment on column CLM.TT_CRD_SURETY_SOURCE.pledge_type
  is 'ѺƷ����';
comment on column CLM.TT_CRD_SURETY_SOURCE.customer_num
  is 'ѺƷ������ECIF�ͻ���';
comment on column CLM.TT_CRD_SURETY_SOURCE.pledge_rate
  is '����Ѻ��';
comment on column CLM.TT_CRD_SURETY_SOURCE.amt_asses
  is 'ѺƷ������ֵ';
comment on column CLM.TT_CRD_SURETY_SOURCE.amt_actual
  is 'ѺƷȨ����ֵ';
comment on column CLM.TT_CRD_SURETY_SOURCE.guarantee_type
  is '������ʽ';
comment on column CLM.TT_CRD_SURETY_SOURCE.user_num
  is '�ͻ�����';
comment on column CLM.TT_CRD_SURETY_SOURCE.org_num
  is '������';
comment on column CLM.TT_CRD_SURETY_SOURCE.pledge_status
  is 'ѺƷ״̬';
comment on column CLM.TT_CRD_SURETY_SOURCE.customer_type
  is '�ͻ�����';

prompt
prompt Creating table TT_DATA_CUSTOMER_ORG_SOURCE
prompt ==========================================
prompt
create table CLM.TT_DATA_CUSTOMER_ORG_SOURCE
(
  cust_id              VARCHAR2(9),
  bank_customer_id     VARCHAR2(20),
  id_type              VARCHAR2(1),
  id_no                VARCHAR2(30),
  name                 VARCHAR2(80),
  gender               VARCHAR2(1),
  birthday             VARCHAR2(10),
  occupation           VARCHAR2(1),
  title                VARCHAR2(1),
  bankmember_no        VARCHAR2(20),
  nationality          VARCHAR2(3),
  pr_of_country        VARCHAR2(1),
  residency_country_cd VARCHAR2(3),
  marital_status       VARCHAR2(1),
  qualification        VARCHAR2(1),
  social_status        VARCHAR2(1),
  id_issuer_address    VARCHAR2(200),
  home_phone           VARCHAR2(20),
  house_ownership      VARCHAR2(1),
  house_type           VARCHAR2(1),
  home_stand_from      VARCHAR2(10),
  liquid_asset         VARCHAR2(1),
  mobile_no            VARCHAR2(20),
  email                VARCHAR2(80),
  emp_status           VARCHAR2(1),
  nbr_of_dependents    VARCHAR2(10),
  language_ind         VARCHAR2(4),
  setup_date           VARCHAR2(20),
  social_ins_amt       NUMBER(15,2),
  drive_license_id     VARCHAR2(20),
  drive_lic_reg_date   VARCHAR2(20),
  emp_stability        VARCHAR2(1),
  corp_name            VARCHAR2(80),
  cust_credit_limit    NUMBER(15,2),
  large_loan_crlimit   NUMBER(15,2),
  revolve_loan_crlimit NUMBER(15,2),
  reserved_question    VARCHAR2(40),
  reserved_answer      VARCHAR2(40),
  department           VARCHAR2(80),
  cert_expire_date     VARCHAR2(20),
  filler               VARCHAR2(115)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on column CLM.TT_DATA_CUSTOMER_ORG_SOURCE.cust_id
  is '�ͻ����';
comment on column CLM.TT_DATA_CUSTOMER_ORG_SOURCE.bank_customer_id
  is '���ڿͻ���';
comment on column CLM.TT_DATA_CUSTOMER_ORG_SOURCE.id_type
  is '֤������';
comment on column CLM.TT_DATA_CUSTOMER_ORG_SOURCE.id_no
  is '֤������';
comment on column CLM.TT_DATA_CUSTOMER_ORG_SOURCE.name
  is ' ����';
comment on column CLM.TT_DATA_CUSTOMER_ORG_SOURCE.gender
  is '�Ա�';
comment on column CLM.TT_DATA_CUSTOMER_ORG_SOURCE.birthday
  is '����';
comment on column CLM.TT_DATA_CUSTOMER_ORG_SOURCE.occupation
  is 'ְҵ';
comment on column CLM.TT_DATA_CUSTOMER_ORG_SOURCE.title
  is 'ְ��';
comment on column CLM.TT_DATA_CUSTOMER_ORG_SOURCE.bankmember_no
  is '����Ա����';
comment on column CLM.TT_DATA_CUSTOMER_ORG_SOURCE.nationality
  is '��������';
comment on column CLM.TT_DATA_CUSTOMER_ORG_SOURCE.pr_of_country
  is '�Ƿ����þ�ס';
comment on column CLM.TT_DATA_CUSTOMER_ORG_SOURCE.residency_country_cd
  is '���þ�ס�ع��Ҵ���';
comment on column CLM.TT_DATA_CUSTOMER_ORG_SOURCE.marital_status
  is '����״��';
comment on column CLM.TT_DATA_CUSTOMER_ORG_SOURCE.qualification
  is '����״��';
comment on column CLM.TT_DATA_CUSTOMER_ORG_SOURCE.social_status
  is '�������';
comment on column CLM.TT_DATA_CUSTOMER_ORG_SOURCE.id_issuer_address
  is '��֤�������ڵ�ַ';
comment on column CLM.TT_DATA_CUSTOMER_ORG_SOURCE.home_phone
  is '��ͥ�绰';
comment on column CLM.TT_DATA_CUSTOMER_ORG_SOURCE.house_ownership
  is '���ݳ�������';
comment on column CLM.TT_DATA_CUSTOMER_ORG_SOURCE.house_type
  is 'סլ����';
comment on column CLM.TT_DATA_CUSTOMER_ORG_SOURCE.home_stand_from
  is '��סַ��ס��ʼ����';
comment on column CLM.TT_DATA_CUSTOMER_ORG_SOURCE.liquid_asset
  is '�����ʲ�����';
comment on column CLM.TT_DATA_CUSTOMER_ORG_SOURCE.mobile_no
  is '�ƶ��绰';
comment on column CLM.TT_DATA_CUSTOMER_ORG_SOURCE.email
  is '��������';
comment on column CLM.TT_DATA_CUSTOMER_ORG_SOURCE.emp_status
  is '��ҵ״̬';
comment on column CLM.TT_DATA_CUSTOMER_ORG_SOURCE.nbr_of_dependents
  is '��������';
comment on column CLM.TT_DATA_CUSTOMER_ORG_SOURCE.language_ind
  is '���Դ���';
comment on column CLM.TT_DATA_CUSTOMER_ORG_SOURCE.setup_date
  is '��������';
comment on column CLM.TT_DATA_CUSTOMER_ORG_SOURCE.social_ins_amt
  is '�籣�ɴ���';
comment on column CLM.TT_DATA_CUSTOMER_ORG_SOURCE.drive_license_id
  is '��ʻ֤����';
comment on column CLM.TT_DATA_CUSTOMER_ORG_SOURCE.drive_lic_reg_date
  is '��ʻ֤�Ǽ�����';
comment on column CLM.TT_DATA_CUSTOMER_ORG_SOURCE.emp_stability
  is '�����ȶ���';
comment on column CLM.TT_DATA_CUSTOMER_ORG_SOURCE.corp_name
  is '��˾����';
comment on column CLM.TT_DATA_CUSTOMER_ORG_SOURCE.cust_credit_limit
  is '�ͻ����ö��';
comment on column CLM.TT_DATA_CUSTOMER_ORG_SOURCE.large_loan_crlimit
  is '�����ڶ��';
comment on column CLM.TT_DATA_CUSTOMER_ORG_SOURCE.revolve_loan_crlimit
  is 'ѭ��������';
comment on column CLM.TT_DATA_CUSTOMER_ORG_SOURCE.reserved_question
  is 'Ԥ������';
comment on column CLM.TT_DATA_CUSTOMER_ORG_SOURCE.reserved_answer
  is 'Ԥ����';
comment on column CLM.TT_DATA_CUSTOMER_ORG_SOURCE.department
  is '��ְ����';
comment on column CLM.TT_DATA_CUSTOMER_ORG_SOURCE.cert_expire_date
  is '֤��������';
comment on column CLM.TT_DATA_CUSTOMER_ORG_SOURCE.filler
  is 'Ԥ����';

prompt
prompt Creating table TT_ECIF_CORPORATION_ADDR_INFO
prompt ============================================
prompt
create table CLM.TT_ECIF_CORPORATION_ADDR_INFO
(
  cust_no     VARCHAR2(10),
  conn_type   VARCHAR2(3),
  coun_regi   VARCHAR2(3),
  province    VARCHAR2(6),
  city        VARCHAR2(6),
  county      VARCHAR2(6),
  street      VARCHAR2(60),
  detail_addr VARCHAR2(256),
  eng_addr    VARCHAR2(256),
  post_code   VARCHAR2(6)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on table CLM.TT_ECIF_CORPORATION_ADDR_INFO
  is '�Թ��ͻ���ַ��Ϣ��ر�';
comment on column CLM.TT_ECIF_CORPORATION_ADDR_INFO.cust_no
  is '�ͻ����';
comment on column CLM.TT_ECIF_CORPORATION_ADDR_INFO.conn_type
  is '��ϵ����';
comment on column CLM.TT_ECIF_CORPORATION_ADDR_INFO.coun_regi
  is '��ϵ��ַ����/����';
comment on column CLM.TT_ECIF_CORPORATION_ADDR_INFO.province
  is 'ʡ����';
comment on column CLM.TT_ECIF_CORPORATION_ADDR_INFO.city
  is '�д���';
comment on column CLM.TT_ECIF_CORPORATION_ADDR_INFO.county
  is '�ش���';
comment on column CLM.TT_ECIF_CORPORATION_ADDR_INFO.street
  is '�ֵ���ַ';
comment on column CLM.TT_ECIF_CORPORATION_ADDR_INFO.detail_addr
  is '��ϸ��ַ';
comment on column CLM.TT_ECIF_CORPORATION_ADDR_INFO.eng_addr
  is 'Ӣ�ĵ�ַ';
comment on column CLM.TT_ECIF_CORPORATION_ADDR_INFO.post_code
  is '��������';

prompt
prompt Creating table TT_ECIF_CORPORATION_CERT_INFO
prompt ============================================
prompt
create table CLM.TT_ECIF_CORPORATION_CERT_INFO
(
  cust_no         VARCHAR2(10),
  cert_flag       VARCHAR2(2),
  cert_type       VARCHAR2(2),
  cert_num        VARCHAR2(60),
  issued_inst     VARCHAR2(120),
  cert_start_date VARCHAR2(20),
  cert_end_date   VARCHAR2(20)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on table CLM.TT_ECIF_CORPORATION_CERT_INFO
  is '�Թ��ͻ�֤����Ϣ��ر�';
comment on column CLM.TT_ECIF_CORPORATION_CERT_INFO.cust_no
  is '�ͻ����';
comment on column CLM.TT_ECIF_CORPORATION_CERT_INFO.cert_flag
  is '����֤����ʶ';
comment on column CLM.TT_ECIF_CORPORATION_CERT_INFO.cert_type
  is '֤������';
comment on column CLM.TT_ECIF_CORPORATION_CERT_INFO.cert_num
  is '֤������';
comment on column CLM.TT_ECIF_CORPORATION_CERT_INFO.issued_inst
  is '֤�����Ż���';
comment on column CLM.TT_ECIF_CORPORATION_CERT_INFO.cert_start_date
  is '֤����Ч����';
comment on column CLM.TT_ECIF_CORPORATION_CERT_INFO.cert_end_date
  is '֤����������';

prompt
prompt Creating table TT_ECIF_CORPORATION_CO_INFO
prompt ==========================================
prompt
create table CLM.TT_ECIF_CORPORATION_CO_INFO
(
  cust_no     VARCHAR2(10),
  rel_cust_no VARCHAR2(10),
  rel_type    VARCHAR2(3),
  cust_name   VARCHAR2(200),
  cert_type   VARCHAR2(2),
  cert_num    VARCHAR2(60),
  unit_scale  VARCHAR2(1)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on table CLM.TT_ECIF_CORPORATION_CO_INFO
  is '�Թ��ͻ���ҵ��ϵ��Ϣ��ر�';
comment on column CLM.TT_ECIF_CORPORATION_CO_INFO.cust_no
  is '�ͻ����';
comment on column CLM.TT_ECIF_CORPORATION_CO_INFO.rel_cust_no
  is '������ϵ�ͻ���';
comment on column CLM.TT_ECIF_CORPORATION_CO_INFO.rel_type
  is '�ͻ���ϵ����';
comment on column CLM.TT_ECIF_CORPORATION_CO_INFO.cust_name
  is '��ϵ������';
comment on column CLM.TT_ECIF_CORPORATION_CO_INFO.cert_type
  is '֤������';
comment on column CLM.TT_ECIF_CORPORATION_CO_INFO.cert_num
  is '֤������';
comment on column CLM.TT_ECIF_CORPORATION_CO_INFO.unit_scale
  is '��ҵ��ģ';

prompt
prompt Creating table TT_ECIF_CORPORATION_INFO
prompt =======================================
prompt
create table CLM.TT_ECIF_CORPORATION_INFO
(
  cust_no                  VARCHAR2(10),
  cust_type                VARCHAR2(2),
  cust_status              VARCHAR2(1),
  bank_cust_flag           VARCHAR2(1),
  cust_manager_no          VARCHAR2(6),
  cust_name                VARCHAR2(200),
  org_short_name           VARCHAR2(200),
  cust_eng_name            VARCHAR2(200),
  org_rng_short_name       VARCHAR2(100),
  national_economy_type    VARCHAR2(3),
  national_economy_depart1 VARCHAR2(4),
  national_economy_depart2 VARCHAR2(4),
  national_economy_depart3 VARCHAR2(4),
  national_economy_depart4 VARCHAR2(4),
  found_date               VARCHAR2(20),
  reg_capital              VARCHAR2(24),
  reg_cptl_curr            VARCHAR2(3),
  unit_scale               VARCHAR2(1),
  emp_number               VARCHAR2(8),
  country_code             VARCHAR2(3),
  credit_organ_code        VARCHAR2(18),
  busin_scope              VARCHAR2(256),
  bank_cust_type1          VARCHAR2(4),
  bank_cust_type2          VARCHAR2(4),
  bank_pay_sys_num         VARCHAR2(14),
  group_credit_indicator   VARCHAR2(1),
  bank_indicator           VARCHAR2(1),
  rel_party_ind            VARCHAR2(1),
  swift_code               VARCHAR2(11),
  bene_cust_type           VARCHAR2(1),
  remarks                  VARCHAR2(64),
  created_ts               DATE,
  last_updated_org         VARCHAR2(5),
  last_updated_te          VARCHAR2(6)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on table CLM.TT_ECIF_CORPORATION_INFO
  is '�Թ��ͻ�������Ϣ��ر�';
comment on column CLM.TT_ECIF_CORPORATION_INFO.cust_no
  is '�ͻ����';
comment on column CLM.TT_ECIF_CORPORATION_INFO.cust_type
  is '�ͻ�����';
comment on column CLM.TT_ECIF_CORPORATION_INFO.cust_status
  is '�ͻ�״̬';
comment on column CLM.TT_ECIF_CORPORATION_INFO.bank_cust_flag
  is 'ͬҵ�ͻ����ױ�־';
comment on column CLM.TT_ECIF_CORPORATION_INFO.cust_manager_no
  is '�ͻ�������';
comment on column CLM.TT_ECIF_CORPORATION_INFO.cust_name
  is '�ͻ�����';
comment on column CLM.TT_ECIF_CORPORATION_INFO.org_short_name
  is '��֯���ļ��';
comment on column CLM.TT_ECIF_CORPORATION_INFO.cust_eng_name
  is '�ͻ�Ӣ������';
comment on column CLM.TT_ECIF_CORPORATION_INFO.org_rng_short_name
  is '��֯Ӣ�ļ��';
comment on column CLM.TT_ECIF_CORPORATION_INFO.national_economy_type
  is '���񾭼ò���';
comment on column CLM.TT_ECIF_CORPORATION_INFO.national_economy_depart1
  is '���񾭼���ҵ1';
comment on column CLM.TT_ECIF_CORPORATION_INFO.national_economy_depart2
  is '���񾭼���ҵ2';
comment on column CLM.TT_ECIF_CORPORATION_INFO.national_economy_depart3
  is '���񾭼���ҵ3';
comment on column CLM.TT_ECIF_CORPORATION_INFO.national_economy_depart4
  is '���񾭼���ҵ4';
comment on column CLM.TT_ECIF_CORPORATION_INFO.found_date
  is '���Ľ�������';
comment on column CLM.TT_ECIF_CORPORATION_INFO.reg_capital
  is 'ע���ʱ�';
comment on column CLM.TT_ECIF_CORPORATION_INFO.reg_cptl_curr
  is 'ע���ʱ�����';
comment on column CLM.TT_ECIF_CORPORATION_INFO.unit_scale
  is '��ҵ��ģ';
comment on column CLM.TT_ECIF_CORPORATION_INFO.emp_number
  is '��ҵԱ������';
comment on column CLM.TT_ECIF_CORPORATION_INFO.country_code
  is '�������';
comment on column CLM.TT_ECIF_CORPORATION_INFO.credit_organ_code
  is '�������ô���';
comment on column CLM.TT_ECIF_CORPORATION_INFO.busin_scope
  is '��Ӫ��Χ';
comment on column CLM.TT_ECIF_CORPORATION_INFO.bank_cust_type1
  is 'ͬҵ�ͻ�����1';
comment on column CLM.TT_ECIF_CORPORATION_INFO.bank_cust_type2
  is 'ͬҵ�ͻ�����2';
comment on column CLM.TT_ECIF_CORPORATION_INFO.bank_pay_sys_num
  is '�����ִ���֧��ϵͳ�����к�';
comment on column CLM.TT_ECIF_CORPORATION_INFO.group_credit_indicator
  is '�������ű�־';
comment on column CLM.TT_ECIF_CORPORATION_INFO.bank_indicator
  is '���к�������־';
comment on column CLM.TT_ECIF_CORPORATION_INFO.rel_party_ind
  is '���й�������־';
comment on column CLM.TT_ECIF_CORPORATION_INFO.swift_code
  is 'SWIFT����';
comment on column CLM.TT_ECIF_CORPORATION_INFO.bene_cust_type
  is '�Թ��ͻ�����';
comment on column CLM.TT_ECIF_CORPORATION_INFO.remarks
  is '��ע';
comment on column CLM.TT_ECIF_CORPORATION_INFO.created_ts
  is '����ECIF����';
comment on column CLM.TT_ECIF_CORPORATION_INFO.last_updated_org
  is '����������';
comment on column CLM.TT_ECIF_CORPORATION_INFO.last_updated_te
  is '��������Ա';

prompt
prompt Creating table TT_ECIF_CORPORATION_PPL_INFO
prompt ===========================================
prompt
create table CLM.TT_ECIF_CORPORATION_PPL_INFO
(
  cust_no       VARCHAR2(10),
  conn_type     VARCHAR2(3),
  inter_code    VARCHAR2(3),
  inland_code   VARCHAR2(4),
  tel_number    VARCHAR2(13),
  exten_num     VARCHAR2(256),
  is_check_flag VARCHAR2(1)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on table CLM.TT_ECIF_CORPORATION_PPL_INFO
  is '�Թ��ͻ���ϵ�绰��Ϣ��ر�';
comment on column CLM.TT_ECIF_CORPORATION_PPL_INFO.cust_no
  is '�ͻ����';
comment on column CLM.TT_ECIF_CORPORATION_PPL_INFO.conn_type
  is '��ϵ����';
comment on column CLM.TT_ECIF_CORPORATION_PPL_INFO.inter_code
  is '���ʳ�;����';
comment on column CLM.TT_ECIF_CORPORATION_PPL_INFO.inland_code
  is '���ڳ�;����';
comment on column CLM.TT_ECIF_CORPORATION_PPL_INFO.tel_number
  is '��ϵ����';
comment on column CLM.TT_ECIF_CORPORATION_PPL_INFO.exten_num
  is '�ֻ���';
comment on column CLM.TT_ECIF_CORPORATION_PPL_INFO.is_check_flag
  is '�Ƿ��Ѻ�ʵ';

prompt
prompt Creating table TT_ECIF_INDIVIDUAL_ADDR_INFO
prompt ===========================================
prompt
create table CLM.TT_ECIF_INDIVIDUAL_ADDR_INFO
(
  cust_no     VARCHAR2(40),
  conn_type   VARCHAR2(3),
  coun_regi   VARCHAR2(3),
  province    VARCHAR2(6),
  city        VARCHAR2(6),
  county      VARCHAR2(6),
  street      VARCHAR2(60),
  detail_addr VARCHAR2(256),
  eng_addr    VARCHAR2(256),
  post_code   VARCHAR2(6)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on table CLM.TT_ECIF_INDIVIDUAL_ADDR_INFO
  is '��˽�ͻ���ϵ��ַ��Ϣ��ر�';
comment on column CLM.TT_ECIF_INDIVIDUAL_ADDR_INFO.cust_no
  is '�ͻ����';
comment on column CLM.TT_ECIF_INDIVIDUAL_ADDR_INFO.conn_type
  is '��ϵ����';
comment on column CLM.TT_ECIF_INDIVIDUAL_ADDR_INFO.coun_regi
  is '��ϵ��ַ����/����';
comment on column CLM.TT_ECIF_INDIVIDUAL_ADDR_INFO.province
  is 'ʡ����';
comment on column CLM.TT_ECIF_INDIVIDUAL_ADDR_INFO.city
  is '�д���';
comment on column CLM.TT_ECIF_INDIVIDUAL_ADDR_INFO.county
  is '�ش���';
comment on column CLM.TT_ECIF_INDIVIDUAL_ADDR_INFO.street
  is '�ֵ���ַ';
comment on column CLM.TT_ECIF_INDIVIDUAL_ADDR_INFO.detail_addr
  is '��ϸ��ַ';
comment on column CLM.TT_ECIF_INDIVIDUAL_ADDR_INFO.eng_addr
  is 'Ӣ�ĵ�ַ';
comment on column CLM.TT_ECIF_INDIVIDUAL_ADDR_INFO.post_code
  is '��������';

prompt
prompt Creating table TT_ECIF_INDIVIDUAL_CERT_INFO
prompt ===========================================
prompt
create table CLM.TT_ECIF_INDIVIDUAL_CERT_INFO
(
  cust_no         VARCHAR2(10),
  cert_flag       VARCHAR2(2),
  cert_type       VARCHAR2(2),
  cert_num        VARCHAR2(60),
  issued_inst     VARCHAR2(120),
  cert_start_date VARCHAR2(20),
  cert_end_date   VARCHAR2(20)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on table CLM.TT_ECIF_INDIVIDUAL_CERT_INFO
  is '��˽�ͻ���֤����Ϣ��ر�';
comment on column CLM.TT_ECIF_INDIVIDUAL_CERT_INFO.cust_no
  is '�ͻ����';
comment on column CLM.TT_ECIF_INDIVIDUAL_CERT_INFO.cert_flag
  is '����֤����ʶ';
comment on column CLM.TT_ECIF_INDIVIDUAL_CERT_INFO.cert_type
  is '֤������';
comment on column CLM.TT_ECIF_INDIVIDUAL_CERT_INFO.cert_num
  is '֤������';
comment on column CLM.TT_ECIF_INDIVIDUAL_CERT_INFO.issued_inst
  is '֤�����Ż���';
comment on column CLM.TT_ECIF_INDIVIDUAL_CERT_INFO.cert_start_date
  is '֤����Ч����';
comment on column CLM.TT_ECIF_INDIVIDUAL_CERT_INFO.cert_end_date
  is '֤����������';

prompt
prompt Creating table TT_ECIF_INDIVIDUAL_INFO
prompt ======================================
prompt
create table CLM.TT_ECIF_INDIVIDUAL_INFO
(
  cust_no            VARCHAR2(10),
  cust_type          VARCHAR2(2),
  cust_status        VARCHAR2(1),
  cust_name          VARCHAR2(200),
  pinyin_name        VARCHAR2(200),
  gender             VARCHAR2(1),
  nation             VARCHAR2(2),
  race               VARCHAR2(3),
  birth_date         VARCHAR2(20),
  poli_status        VARCHAR2(2),
  marr_status        VARCHAR2(2),
  emp_stat           VARCHAR2(2),
  house_cicts        VARCHAR2(6),
  house_type         VARCHAR2(1),
  healthy_status     VARCHAR2(1),
  family_num         VARCHAR2(2),
  education          VARCHAR2(2),
  high_acade_degree  VARCHAR2(3),
  cust_manager_no    VARCHAR2(6),
  work_unit_name     VARCHAR2(200),
  work_industry      VARCHAR2(8),
  unit_character     VARCHAR2(9),
  duty               VARCHAR2(1),
  occupation1        VARCHAR2(5),
  occupation2        VARCHAR2(5),
  occupation3        VARCHAR2(5),
  occupation_explain VARCHAR2(30),
  tech_tiyle_level   VARCHAR2(1),
  pay_credit_flag    VARCHAR2(1),
  is_blank_flag      VARCHAR2(1),
  employee_flag      VARCHAR2(1),
  agri_related_ind   VARCHAR2(1),
  seior_execu_ind    VARCHAR2(1),
  rel_party_ind      VARCHAR2(1),
  per_year_income    NUMBER(24,2),
  tax_res_type       VARCHAR2(1),
  resid_situat       VARCHAR2(1),
  cust_grade         VARCHAR2(1),
  cust_satis         VARCHAR2(1),
  per_total_asset    NUMBER(24,2),
  liability_balance  NUMBER(24,2),
  per_assest_type    VARCHAR2(2),
  per_liab_type      VARCHAR2(2),
  resid_non_resid    VARCHAR2(2),
  created_ts         DATE,
  last_updated_org   VARCHAR2(5),
  last_updated_te    VARCHAR2(6)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on table CLM.TT_ECIF_INDIVIDUAL_INFO
  is '��˽�ͻ�������Ϣ��ر�';
comment on column CLM.TT_ECIF_INDIVIDUAL_INFO.cust_no
  is '�ͻ����';
comment on column CLM.TT_ECIF_INDIVIDUAL_INFO.cust_type
  is '�ͻ�����';
comment on column CLM.TT_ECIF_INDIVIDUAL_INFO.cust_status
  is '�ͻ�״̬';
comment on column CLM.TT_ECIF_INDIVIDUAL_INFO.cust_name
  is '�ͻ�����';
comment on column CLM.TT_ECIF_INDIVIDUAL_INFO.pinyin_name
  is '�ͻ�ƴ������';
comment on column CLM.TT_ECIF_INDIVIDUAL_INFO.gender
  is '�Ա�';
comment on column CLM.TT_ECIF_INDIVIDUAL_INFO.nation
  is '����';
comment on column CLM.TT_ECIF_INDIVIDUAL_INFO.race
  is '����';
comment on column CLM.TT_ECIF_INDIVIDUAL_INFO.birth_date
  is '��������';
comment on column CLM.TT_ECIF_INDIVIDUAL_INFO.poli_status
  is '������ò';
comment on column CLM.TT_ECIF_INDIVIDUAL_INFO.marr_status
  is '����״��';
comment on column CLM.TT_ECIF_INDIVIDUAL_INFO.emp_stat
  is '��ҵ״��';
comment on column CLM.TT_ECIF_INDIVIDUAL_INFO.house_cicts
  is '�������ڳ���';
comment on column CLM.TT_ECIF_INDIVIDUAL_INFO.house_type
  is '��������';
comment on column CLM.TT_ECIF_INDIVIDUAL_INFO.healthy_status
  is '����״��';
comment on column CLM.TT_ECIF_INDIVIDUAL_INFO.family_num
  is '��ͥ��Ա����';
comment on column CLM.TT_ECIF_INDIVIDUAL_INFO.education
  is '���ѧ��';
comment on column CLM.TT_ECIF_INDIVIDUAL_INFO.high_acade_degree
  is '���ѧλ';
comment on column CLM.TT_ECIF_INDIVIDUAL_INFO.cust_manager_no
  is '�ͻ�������';
comment on column CLM.TT_ECIF_INDIVIDUAL_INFO.work_unit_name
  is '������λȫ��';
comment on column CLM.TT_ECIF_INDIVIDUAL_INFO.work_industry
  is '������λ������ҵ';
comment on column CLM.TT_ECIF_INDIVIDUAL_INFO.unit_character
  is '������λ����';
comment on column CLM.TT_ECIF_INDIVIDUAL_INFO.duty
  is 'ְ��';
comment on column CLM.TT_ECIF_INDIVIDUAL_INFO.occupation1
  is 'ְҵ1';
comment on column CLM.TT_ECIF_INDIVIDUAL_INFO.occupation2
  is 'ְҵ2';
comment on column CLM.TT_ECIF_INDIVIDUAL_INFO.occupation3
  is 'ְҵ3';
comment on column CLM.TT_ECIF_INDIVIDUAL_INFO.occupation_explain
  is 'ְҵ˵��';
comment on column CLM.TT_ECIF_INDIVIDUAL_INFO.tech_tiyle_level
  is 'ְ��';
comment on column CLM.TT_ECIF_INDIVIDUAL_INFO.pay_credit_flag
  is '�Ƿ��������';
comment on column CLM.TT_ECIF_INDIVIDUAL_INFO.is_blank_flag
  is '���˿ͻ���������־';
comment on column CLM.TT_ECIF_INDIVIDUAL_INFO.employee_flag
  is 'Ա����־';
comment on column CLM.TT_ECIF_INDIVIDUAL_INFO.agri_related_ind
  is '�Ƿ���ũ';
comment on column CLM.TT_ECIF_INDIVIDUAL_INFO.seior_execu_ind
  is '�Ƿ��и߹�';
comment on column CLM.TT_ECIF_INDIVIDUAL_INFO.rel_party_ind
  is '���й�������־';
comment on column CLM.TT_ECIF_INDIVIDUAL_INFO.per_year_income
  is '����������';
comment on column CLM.TT_ECIF_INDIVIDUAL_INFO.tax_res_type
  is '˰�վ������';
comment on column CLM.TT_ECIF_INDIVIDUAL_INFO.resid_situat
  is '��ס״��';
comment on column CLM.TT_ECIF_INDIVIDUAL_INFO.cust_grade
  is '�ͻ��ȼ�';
comment on column CLM.TT_ECIF_INDIVIDUAL_INFO.cust_satis
  is '�ͻ������';
comment on column CLM.TT_ECIF_INDIVIDUAL_INFO.per_total_asset
  is '�������ʲ�';
comment on column CLM.TT_ECIF_INDIVIDUAL_INFO.liability_balance
  is '�����ܸ�ծ';
comment on column CLM.TT_ECIF_INDIVIDUAL_INFO.per_assest_type
  is '�����ʲ�����';
comment on column CLM.TT_ECIF_INDIVIDUAL_INFO.per_liab_type
  is '���˸�ծ����';
comment on column CLM.TT_ECIF_INDIVIDUAL_INFO.resid_non_resid
  is '����/�Ǿ���';
comment on column CLM.TT_ECIF_INDIVIDUAL_INFO.created_ts
  is '��������';
comment on column CLM.TT_ECIF_INDIVIDUAL_INFO.last_updated_org
  is '��������';
comment on column CLM.TT_ECIF_INDIVIDUAL_INFO.last_updated_te
  is '������Ա';

prompt
prompt Creating table TT_ECIF_INDIVIDUAL_PEOPLE_INFO
prompt =============================================
prompt
create table CLM.TT_ECIF_INDIVIDUAL_PEOPLE_INFO
(
  cust_no     VARCHAR2(10),
  rel_cust_no VARCHAR2(10),
  rel_type    VARCHAR2(3),
  cust_name   VARCHAR2(200),
  cert_type   VARCHAR2(2),
  cert_num    VARCHAR2(60),
  gender      VARCHAR2(1)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on table CLM.TT_ECIF_INDIVIDUAL_PEOPLE_INFO
  is '��˽�ͻ���ϵ����Ϣ��ر�';
comment on column CLM.TT_ECIF_INDIVIDUAL_PEOPLE_INFO.cust_no
  is '�ͻ����';
comment on column CLM.TT_ECIF_INDIVIDUAL_PEOPLE_INFO.rel_cust_no
  is '��ϵ�˿ͻ����';
comment on column CLM.TT_ECIF_INDIVIDUAL_PEOPLE_INFO.rel_type
  is '�ͻ���ϵ����';
comment on column CLM.TT_ECIF_INDIVIDUAL_PEOPLE_INFO.cust_name
  is '��ϵ������';
comment on column CLM.TT_ECIF_INDIVIDUAL_PEOPLE_INFO.cert_type
  is '��ϵ��֤������';
comment on column CLM.TT_ECIF_INDIVIDUAL_PEOPLE_INFO.cert_num
  is '��ϵ��֤������';
comment on column CLM.TT_ECIF_INDIVIDUAL_PEOPLE_INFO.gender
  is '��ϵ���Ա�';

prompt
prompt Creating table TT_ECIF_INDIVIDUAL_PHONE_INFO
prompt ============================================
prompt
create table CLM.TT_ECIF_INDIVIDUAL_PHONE_INFO
(
  cust_no       VARCHAR2(10),
  conn_type     VARCHAR2(3),
  inter_code    VARCHAR2(3),
  inland_code   VARCHAR2(4),
  tel_number    VARCHAR2(13),
  exten_num     VARCHAR2(256),
  is_check_flag VARCHAR2(1)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on table CLM.TT_ECIF_INDIVIDUAL_PHONE_INFO
  is '��˽�ͻ���ϵ�绰��Ϣ��ر�';
comment on column CLM.TT_ECIF_INDIVIDUAL_PHONE_INFO.cust_no
  is '�ͻ����';
comment on column CLM.TT_ECIF_INDIVIDUAL_PHONE_INFO.conn_type
  is '��ϵ����';
comment on column CLM.TT_ECIF_INDIVIDUAL_PHONE_INFO.inter_code
  is '���ʳ�;����';
comment on column CLM.TT_ECIF_INDIVIDUAL_PHONE_INFO.inland_code
  is '���ڳ�;����';
comment on column CLM.TT_ECIF_INDIVIDUAL_PHONE_INFO.tel_number
  is '��ϵ����';
comment on column CLM.TT_ECIF_INDIVIDUAL_PHONE_INFO.exten_num
  is '�ֻ���';
comment on column CLM.TT_ECIF_INDIVIDUAL_PHONE_INFO.is_check_flag
  is '�Ƿ��Ѻ�ʵ';

prompt
prompt Creating table TT_FUND_CRD_ADLIMT_SOURCE
prompt ========================================
prompt
create table CLM.TT_FUND_CRD_ADLIMT_SOURCE
(
  tran_seq_sn       VARCHAR2(40),
  tran_date         VARCHAR2(20),
  busi_deal_num     VARCHAR2(40),
  tran_type_cd      VARCHAR2(2),
  customer_num      VARCHAR2(10),
  crd_status        VARCHAR2(10),
  frozen_req_date   VARCHAR2(20),
  frozen_begin_date VARCHAR2(20),
  frozen_over_date  VARCHAR2(20)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on table CLM.TT_FUND_CRD_ADLIMT_SOURCE
  is '�ͻ����״̬ά��';
comment on column CLM.TT_FUND_CRD_ADLIMT_SOURCE.tran_seq_sn
  is '������ˮ��';
comment on column CLM.TT_FUND_CRD_ADLIMT_SOURCE.tran_date
  is '��������';
comment on column CLM.TT_FUND_CRD_ADLIMT_SOURCE.busi_deal_num
  is 'ҵ��������';
comment on column CLM.TT_FUND_CRD_ADLIMT_SOURCE.tran_type_cd
  is '��������';
comment on column CLM.TT_FUND_CRD_ADLIMT_SOURCE.customer_num
  is 'ECIF�ͻ���';
comment on column CLM.TT_FUND_CRD_ADLIMT_SOURCE.crd_status
  is '���״̬';
comment on column CLM.TT_FUND_CRD_ADLIMT_SOURCE.frozen_req_date
  is '������������';
comment on column CLM.TT_FUND_CRD_ADLIMT_SOURCE.frozen_begin_date
  is '������Ч����';
comment on column CLM.TT_FUND_CRD_ADLIMT_SOURCE.frozen_over_date
  is '�����������';

prompt
prompt Creating table TT_FUND_CRD_OPT_SOURCE
prompt =====================================
prompt
create table CLM.TT_FUND_CRD_OPT_SOURCE
(
  tran_seq_sn     VARCHAR2(40),
  tran_date       VARCHAR2(20),
  busi_deal_num   VARCHAR2(40),
  tran_type_cd    VARCHAR2(2),
  crd_apply_amt   NUMBER(24,6),
  crd_currency_cd VARCHAR2(10)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on table CLM.TT_FUND_CRD_OPT_SOURCE
  is '�ʽ���ʹ��';
comment on column CLM.TT_FUND_CRD_OPT_SOURCE.tran_seq_sn
  is '������ˮ��';
comment on column CLM.TT_FUND_CRD_OPT_SOURCE.tran_date
  is '��������';
comment on column CLM.TT_FUND_CRD_OPT_SOURCE.busi_deal_num
  is 'ҵ����';
comment on column CLM.TT_FUND_CRD_OPT_SOURCE.tran_type_cd
  is '��������(CD000197)';
comment on column CLM.TT_FUND_CRD_OPT_SOURCE.crd_apply_amt
  is '���Ž��';
comment on column CLM.TT_FUND_CRD_OPT_SOURCE.crd_currency_cd
  is '����(CD000019)';

prompt
prompt Creating table TT_FUND_CRD_OPT_TRAN_SOURCE
prompt ==========================================
prompt
create table CLM.TT_FUND_CRD_OPT_TRAN_SOURCE
(
  tran_seq_sn        VARCHAR2(40),
  tran_date          VARCHAR2(20),
  crd_grant_org_num  VARCHAR2(6),
  customer_num       VARCHAR2(10),
  crd_detail_prd     VARCHAR2(10),
  crd_currency_cd    VARCHAR2(10),
  busi_prd_num       VARCHAR2(3),
  busi_deal_desc     VARCHAR2(100),
  busi_deal_org_num  VARCHAR2(6),
  busi_deal_org_name VARCHAR2(100),
  busi_oppt_org_num  VARCHAR2(6),
  busi_oppt_org_name VARCHAR2(100),
  busi_sum_amt       NUMBER(24,6),
  busi_cert_cnt      VARCHAR2(3)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on table CLM.TT_FUND_CRD_OPT_TRAN_SOURCE
  is '�ʽ�ϵͳ���ʹ�ý�����Ϣ';
comment on column CLM.TT_FUND_CRD_OPT_TRAN_SOURCE.tran_seq_sn
  is '������ˮ��';
comment on column CLM.TT_FUND_CRD_OPT_TRAN_SOURCE.tran_date
  is '��������';
comment on column CLM.TT_FUND_CRD_OPT_TRAN_SOURCE.crd_grant_org_num
  is '���Ż���';
comment on column CLM.TT_FUND_CRD_OPT_TRAN_SOURCE.customer_num
  is '���ſͻ���';
comment on column CLM.TT_FUND_CRD_OPT_TRAN_SOURCE.crd_detail_prd
  is '�����ϸ��Ʒ(CD000198)';
comment on column CLM.TT_FUND_CRD_OPT_TRAN_SOURCE.crd_currency_cd
  is '����';
comment on column CLM.TT_FUND_CRD_OPT_TRAN_SOURCE.busi_prd_num
  is 'ҵ���Ʒ���(CD000199)';
comment on column CLM.TT_FUND_CRD_OPT_TRAN_SOURCE.busi_deal_desc
  is '��������';
comment on column CLM.TT_FUND_CRD_OPT_TRAN_SOURCE.busi_deal_org_num
  is '��������';
comment on column CLM.TT_FUND_CRD_OPT_TRAN_SOURCE.busi_deal_org_name
  is '������������';
comment on column CLM.TT_FUND_CRD_OPT_TRAN_SOURCE.busi_oppt_org_num
  is '���ֻ���';
comment on column CLM.TT_FUND_CRD_OPT_TRAN_SOURCE.busi_oppt_org_name
  is '���ֻ�������';
comment on column CLM.TT_FUND_CRD_OPT_TRAN_SOURCE.busi_sum_amt
  is '�����ܽ��';
comment on column CLM.TT_FUND_CRD_OPT_TRAN_SOURCE.busi_cert_cnt
  is 'ƾ֤����';

prompt
prompt Creating table TT_FUND_CRD_SEG_SOURCE
prompt =====================================
prompt
create table CLM.TT_FUND_CRD_SEG_SOURCE
(
  tran_seq_sn    VARCHAR2(20) not null,
  tran_date      VARCHAR2(20),
  crd_detail_prd VARCHAR2(10),
  crd_detail_amt NUMBER(24,6)
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
comment on table CLM.TT_FUND_CRD_SEG_SOURCE
  is '����з���ϸ';
comment on column CLM.TT_FUND_CRD_SEG_SOURCE.tran_seq_sn
  is '������ˮ��';
comment on column CLM.TT_FUND_CRD_SEG_SOURCE.tran_date
  is '��������';
comment on column CLM.TT_FUND_CRD_SEG_SOURCE.crd_detail_prd
  is '��ϸ��Ȳ�Ʒ(CD000198)';
comment on column CLM.TT_FUND_CRD_SEG_SOURCE.crd_detail_amt
  is '��ϸ���';

prompt
prompt Creating table TT_FUND_CRD_SOURCE
prompt =================================
prompt
create table CLM.TT_FUND_CRD_SOURCE
(
  tran_seq_sn       VARCHAR2(40) not null,
  tran_date         VARCHAR2(20),
  busi_deal_num     VARCHAR2(40),
  tran_type_cd      VARCHAR2(2),
  crd_grant_org_num VARCHAR2(10),
  customer_num      VARCHAR2(10),
  crd_main_prd      VARCHAR2(10),
  crd_currency_cd   VARCHAR2(3),
  crd_sum_amt       NUMBER(24,6),
  crd_begin_date    VARCHAR2(20),
  crd_end_date      VARCHAR2(20),
  busi_segm_amt     NUMBER(24,6),
  busi_segm_cnt     VARCHAR2(2),
  tran_system       VARCHAR2(12),
  user_num          VARCHAR2(12)
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
comment on table CLM.TT_FUND_CRD_SOURCE
  is '���������Ϣ';
comment on column CLM.TT_FUND_CRD_SOURCE.tran_seq_sn
  is '������ˮ��';
comment on column CLM.TT_FUND_CRD_SOURCE.tran_date
  is '��������';
comment on column CLM.TT_FUND_CRD_SOURCE.busi_deal_num
  is 'ҵ����';
comment on column CLM.TT_FUND_CRD_SOURCE.tran_type_cd
  is '��������(CD000194)';
comment on column CLM.TT_FUND_CRD_SOURCE.crd_grant_org_num
  is '���Ż�����';
comment on column CLM.TT_FUND_CRD_SOURCE.customer_num
  is 'ECIF�ͻ���';
comment on column CLM.TT_FUND_CRD_SOURCE.crd_main_prd
  is '�����ܶ��Ʒ(CD000205)';
comment on column CLM.TT_FUND_CRD_SOURCE.crd_currency_cd
  is '����(CD000019)';
comment on column CLM.TT_FUND_CRD_SOURCE.crd_sum_amt
  is '�����ܶ��';
comment on column CLM.TT_FUND_CRD_SOURCE.crd_begin_date
  is '�����Ч��';
comment on column CLM.TT_FUND_CRD_SOURCE.crd_end_date
  is '��Ƚ�ֹ��';
comment on column CLM.TT_FUND_CRD_SOURCE.busi_segm_amt
  is '�з��ܶ�';
comment on column CLM.TT_FUND_CRD_SOURCE.busi_segm_cnt
  is '�з���';
comment on column CLM.TT_FUND_CRD_SOURCE.tran_system
  is '�������';
comment on column CLM.TT_FUND_CRD_SOURCE.user_num
  is '������';

prompt
prompt Creating table TT_FUND_CRD_TRANSFER_SOURCE
prompt ==========================================
prompt
create table CLM.TT_FUND_CRD_TRANSFER_SOURCE
(
  tran_seq_sn   VARCHAR2(40),
  tran_date     VARCHAR2(20),
  busi_deal_num VARCHAR2(40),
  busi_sum_amt  NUMBER(24,6),
  tran_type_cd  VARCHAR2(10)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on table CLM.TT_FUND_CRD_TRANSFER_SOURCE
  is '�ʽ�ϵͳ���ת��';
comment on column CLM.TT_FUND_CRD_TRANSFER_SOURCE.tran_seq_sn
  is '������ˮ��';
comment on column CLM.TT_FUND_CRD_TRANSFER_SOURCE.tran_date
  is '��������';
comment on column CLM.TT_FUND_CRD_TRANSFER_SOURCE.busi_deal_num
  is 'ҵ����';
comment on column CLM.TT_FUND_CRD_TRANSFER_SOURCE.busi_sum_amt
  is 'ҵ���׽��';
comment on column CLM.TT_FUND_CRD_TRANSFER_SOURCE.tran_type_cd
  is '��������';

prompt
prompt Creating table TT_FUND_CRD_TRANS_IN_SOURCE
prompt ==========================================
prompt
create table CLM.TT_FUND_CRD_TRANS_IN_SOURCE
(
  tran_seq_sn       VARCHAR2(40),
  tran_date         VARCHAR2(20),
  crd_in_org_num    VARCHAR2(6),
  busi_prd_num      VARCHAR2(3),
  busi_newl_req_num VARCHAR2(40),
  currency_cd       VARCHAR2(3),
  crd_apply_in_amt  NUMBER(24,6)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on table CLM.TT_FUND_CRD_TRANS_IN_SOURCE
  is '�ʽ���ת��-ת��';
comment on column CLM.TT_FUND_CRD_TRANS_IN_SOURCE.tran_seq_sn
  is '������ˮ��';
comment on column CLM.TT_FUND_CRD_TRANS_IN_SOURCE.tran_date
  is '��������';
comment on column CLM.TT_FUND_CRD_TRANS_IN_SOURCE.crd_in_org_num
  is 'ת�����(��Ա��)';
comment on column CLM.TT_FUND_CRD_TRANS_IN_SOURCE.busi_prd_num
  is '��Ʒ����';
comment on column CLM.TT_FUND_CRD_TRANS_IN_SOURCE.busi_newl_req_num
  is 'ҵ����(��Ψһ)';
comment on column CLM.TT_FUND_CRD_TRANS_IN_SOURCE.currency_cd
  is '����(CD000019)';
comment on column CLM.TT_FUND_CRD_TRANS_IN_SOURCE.crd_apply_in_amt
  is 'ת����';

prompt
prompt Creating table TT_FUND_CRD_TRNS_OUT_SOURCE
prompt ==========================================
prompt
create table CLM.TT_FUND_CRD_TRNS_OUT_SOURCE
(
  tran_seq_sn         VARCHAR2(10) not null,
  tran_date           VARCHAR2(20),
  crd_out_org_num     VARCHAR2(6),
  busi_source_req_num VARCHAR2(40),
  currency_cd         VARCHAR2(3),
  crd_apply_out_amt   NUMBER(24,6)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on table CLM.TT_FUND_CRD_TRNS_OUT_SOURCE
  is '�ʽ�ϵͳ���ת��-ת��';
comment on column CLM.TT_FUND_CRD_TRNS_OUT_SOURCE.tran_seq_sn
  is '������ˮ��';
comment on column CLM.TT_FUND_CRD_TRNS_OUT_SOURCE.tran_date
  is '��������';
comment on column CLM.TT_FUND_CRD_TRNS_OUT_SOURCE.crd_out_org_num
  is 'ת������';
comment on column CLM.TT_FUND_CRD_TRNS_OUT_SOURCE.busi_source_req_num
  is 'ҵ����';
comment on column CLM.TT_FUND_CRD_TRNS_OUT_SOURCE.currency_cd
  is '����';
comment on column CLM.TT_FUND_CRD_TRNS_OUT_SOURCE.crd_apply_out_amt
  is 'ת�����';

prompt
prompt Creating table TT_FUND_LOAD_ALLOT_SOURCE
prompt ========================================
prompt
create table CLM.TT_FUND_LOAD_ALLOT_SOURCE
(
  tran_seq_sn        VARCHAR2(40),
  tran_date          VARCHAR2(20),
  crd_allot_org_num  VARCHAR2(6),
  crd_allot_amt      NUMBER(24,6),
  earmark_begin_date VARCHAR2(20),
  earmark_end_date   VARCHAR2(20)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on table CLM.TT_FUND_LOAD_ALLOT_SOURCE
  is 'Ȧ�������Ϣ';
comment on column CLM.TT_FUND_LOAD_ALLOT_SOURCE.tran_seq_sn
  is '������ˮ��';
comment on column CLM.TT_FUND_LOAD_ALLOT_SOURCE.tran_date
  is '��������';
comment on column CLM.TT_FUND_LOAD_ALLOT_SOURCE.crd_allot_org_num
  is '�����Ա��';
comment on column CLM.TT_FUND_LOAD_ALLOT_SOURCE.crd_allot_amt
  is '������';
comment on column CLM.TT_FUND_LOAD_ALLOT_SOURCE.earmark_begin_date
  is 'Ȧ�濪ʼ��';
comment on column CLM.TT_FUND_LOAD_ALLOT_SOURCE.earmark_end_date
  is 'Ȧ�浽����';

prompt
prompt Creating table TT_FUND_LOAD_SOURCE
prompt ==================================
prompt
create table CLM.TT_FUND_LOAD_SOURCE
(
  tran_seq_sn     VARCHAR2(40) not null,
  tran_date       VARCHAR2(20),
  busi_deal_num   VARCHAR2(40),
  tran_type_cd    VARCHAR2(2),
  customer_num    VARCHAR2(10),
  crd_detail_prd  VARCHAR2(3),
  crd_currency_cd VARCHAR2(3),
  crd_eark_amt    NUMBER(24,6)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on table CLM.TT_FUND_LOAD_SOURCE
  is '���Ȧ����Ϣ';
comment on column CLM.TT_FUND_LOAD_SOURCE.tran_seq_sn
  is '������ˮ';
comment on column CLM.TT_FUND_LOAD_SOURCE.tran_date
  is '��������';
comment on column CLM.TT_FUND_LOAD_SOURCE.busi_deal_num
  is 'ҵ����';
comment on column CLM.TT_FUND_LOAD_SOURCE.tran_type_cd
  is '��������';
comment on column CLM.TT_FUND_LOAD_SOURCE.customer_num
  is 'ECIF�ͻ���';
comment on column CLM.TT_FUND_LOAD_SOURCE.crd_detail_prd
  is '������Ȳ�Ʒ';
comment on column CLM.TT_FUND_LOAD_SOURCE.crd_currency_cd
  is '����';
comment on column CLM.TT_FUND_LOAD_SOURCE.crd_eark_amt
  is 'Ȧ����';

prompt
prompt Creating table TT_FUND_OPT_CERT_SOURCE
prompt ======================================
prompt
create table CLM.TT_FUND_OPT_CERT_SOURCE
(
  tran_seq_sn           VARCHAR2(40),
  tran_date             VARCHAR2(20),
  cert_num              VARCHAR2(40),
  cert_type_cd          VARCHAR2(40),
  cert_ppt_cd           VARCHAR2(2),
  cert_interest_period  VARCHAR2(40),
  cert_interest_rate    NUMBER(24,6),
  cert_currency_cd      VARCHAR2(3),
  cert_seq_amt          NUMBER(24,6),
  cert_apply_amt        NUMBER(24,6),
  cert_apply_balance    NUMBER(24,6),
  cert_status           VARCHAR2(1),
  cert_begin_date       VARCHAR2(20),
  cert_end_date         VARCHAR2(20),
  cert_finish_date      VARCHAR2(20),
  cert_drawer_cust_num  VARCHAR2(10),
  cert_drawer_name      VARCHAR2(100),
  cert_drawer_bank_num  VARCHAR2(50),
  cert_drawer_bank_name VARCHAR2(100),
  cert_guaranty_type    VARCHAR2(2),
  cert_guaranty_person  VARCHAR2(10),
  cert_busi_remark      VARCHAR2(100),
  crd_grant_org_num     VARCHAR2(10),
  customer_num          VARCHAR2(10),
  crd_detail_prd        VARCHAR2(10)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on table CLM.TT_FUND_OPT_CERT_SOURCE
  is 'ƾ֤��Ϣ';
comment on column CLM.TT_FUND_OPT_CERT_SOURCE.tran_seq_sn
  is '������ˮ';
comment on column CLM.TT_FUND_OPT_CERT_SOURCE.tran_date
  is '��������';
comment on column CLM.TT_FUND_OPT_CERT_SOURCE.cert_num
  is 'ƾ֤���';
comment on column CLM.TT_FUND_OPT_CERT_SOURCE.cert_type_cd
  is 'ƾ֤����';
comment on column CLM.TT_FUND_OPT_CERT_SOURCE.cert_ppt_cd
  is 'ƾ֤����';
comment on column CLM.TT_FUND_OPT_CERT_SOURCE.cert_interest_period
  is 'ƾ֤��Ϣ����';
comment on column CLM.TT_FUND_OPT_CERT_SOURCE.cert_interest_rate
  is '������/����';
comment on column CLM.TT_FUND_OPT_CERT_SOURCE.cert_currency_cd
  is '����(CD000019)';
comment on column CLM.TT_FUND_OPT_CERT_SOURCE.cert_seq_amt
  is 'ƾ֤ԭʼ���';
comment on column CLM.TT_FUND_OPT_CERT_SOURCE.cert_apply_amt
  is 'ƾ֤���Ž��';
comment on column CLM.TT_FUND_OPT_CERT_SOURCE.cert_apply_balance
  is 'ƾ֤�������';
comment on column CLM.TT_FUND_OPT_CERT_SOURCE.cert_status
  is 'ƾ֤״̬';
comment on column CLM.TT_FUND_OPT_CERT_SOURCE.cert_begin_date
  is 'ƾ֤����';
comment on column CLM.TT_FUND_OPT_CERT_SOURCE.cert_end_date
  is 'ƾֹ֤��';
comment on column CLM.TT_FUND_OPT_CERT_SOURCE.cert_finish_date
  is 'ƾ֤��������';
comment on column CLM.TT_FUND_OPT_CERT_SOURCE.cert_drawer_cust_num
  is '�����˿ͻ���';
comment on column CLM.TT_FUND_OPT_CERT_SOURCE.cert_drawer_name
  is '�����˿ͻ�����';
comment on column CLM.TT_FUND_OPT_CERT_SOURCE.cert_drawer_bank_num
  is '�����˴���/�ж��к�';
comment on column CLM.TT_FUND_OPT_CERT_SOURCE.cert_drawer_bank_name
  is '�����˴���/�ж�������';
comment on column CLM.TT_FUND_OPT_CERT_SOURCE.cert_guaranty_type
  is '������ʽ(CD000100)';
comment on column CLM.TT_FUND_OPT_CERT_SOURCE.cert_guaranty_person
  is '������';
comment on column CLM.TT_FUND_OPT_CERT_SOURCE.cert_busi_remark
  is '��ע';
comment on column CLM.TT_FUND_OPT_CERT_SOURCE.crd_grant_org_num
  is '��Ȩ����';
comment on column CLM.TT_FUND_OPT_CERT_SOURCE.customer_num
  is 'ECIF�ͻ���';
comment on column CLM.TT_FUND_OPT_CERT_SOURCE.crd_detail_prd
  is '��Ȳ�Ʒ���';

prompt
prompt Creating table TT_FUND_STATUS_UPDATE_SOURCE
prompt ===========================================
prompt
create table CLM.TT_FUND_STATUS_UPDATE_SOURCE
(
  tran_seq_sn    VARCHAR2(10) not null,
  tran_date      VARCHAR2(20),
  crd_detail_prd VARCHAR2(10),
  crd_admit_flag VARCHAR2(10)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on table CLM.TT_FUND_STATUS_UPDATE_SOURCE
  is '�ͻ�׼����Ϣ';
comment on column CLM.TT_FUND_STATUS_UPDATE_SOURCE.tran_seq_sn
  is '������ˮ��';
comment on column CLM.TT_FUND_STATUS_UPDATE_SOURCE.tran_date
  is '��������';
comment on column CLM.TT_FUND_STATUS_UPDATE_SOURCE.crd_detail_prd
  is '��ϸ��Ȳ�Ʒ(CD000198)';
comment on column CLM.TT_FUND_STATUS_UPDATE_SOURCE.crd_admit_flag
  is '�ͻ�׼���־';

prompt
prompt Creating sequence ACT_EVT_LOG_SEQ
prompt =================================
prompt
create sequence CLM.ACT_EVT_LOG_SEQ
minvalue 1
maxvalue 9999999999999999999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence ACT_HI_TASK_EVT_LOG_SEQ
prompt =========================================
prompt
create sequence CLM.ACT_HI_TASK_EVT_LOG_SEQ
minvalue 1
maxvalue 9999999999999999999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence BATCHDEPENDON
prompt ===============================
prompt
create sequence CLM.BATCHDEPENDON
minvalue 1
maxvalue 9999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence JOBINSTANCE
prompt =============================
prompt
create sequence CLM.JOBINSTANCE
minvalue 1
maxvalue 9999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence JOBPARAM
prompt ==========================
prompt
create sequence CLM.JOBPARAM
minvalue 1
maxvalue 9999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_SIX_NUM
prompt =============================
prompt
create sequence CLM.SEQ_SIX_NUM
minvalue 1
maxvalue 9999999
start with 61
increment by 1
cache 20;

prompt
prompt Creating function FNC_GET_BAT_DATE
prompt ==================================
prompt
create or replace function clm.FNC_GET_BAT_DATE return varchar2 is
  funResult varchar2(20);
begin
   SELECT t.BATCH_DATE into funResult
           FROM TB_SYS_DATE t;
  return(funResult);
end;
/

prompt
prompt Creating function FNC_GET_BIZ_NUM
prompt =================================
prompt
CREATE OR REPLACE FUNCTION CLM."FNC_GET_BIZ_NUM"(IN_PARAMETER IN VARCHAR)
    RETURN VARCHAR IS    
    --��������
    SEQ_SIX_NUM VARCHAR(6);
    SRETURN VARCHAR(20) DEFAULT '';
    SEQ_NUM number;
    SEQ_NUM_STR VARCHAR(100);
BEGIN

    --���ñ���ֵ    
    execute immediate 'select ' || 'seq_six_num.nextval from dual' into SEQ_NUM ;
    SEQ_NUM_STR :=  '000000' || to_char(SEQ_NUM);
    select SUBSTR(SEQ_NUM_STR, LENGTH(SEQ_NUM_STR)-5) into SEQ_SIX_NUM from dual;
    SELECT replace(t.WORK_DATE,'-','')|| SEQ_SIX_NUM INTO SRETURN from TB_SYS_DATE t;
    --����ֵ
    return IN_PARAMETER || SRETURN;
END;
/

prompt
prompt Creating function FNC_GET_BUSI_DATE
prompt ===================================
prompt
create or replace function clm.FNC_GET_BUSI_DATE return varchar2 is
  funResult varchar2(20);
begin
   SELECT t.WORK_DATE into funResult
           FROM TB_SYS_DATE t;
  return(funResult);
end;
/

prompt
prompt Creating function FNC_GET_BUSI_TIME
prompt ===================================
prompt
CREATE OR REPLACE FUNCTION CLM.FNC_GET_BUSI_TIME  return date is
    workDateTime date;
begin
    SELECT to_date(t.WORK_DATE || to_char(sysdate, 'hh24:mi:ss'),
                              'yyyy-mm-dd hh24:mi:ss') into workDateTime
           FROM TB_SYS_DATE t;
    return (workDateTime);
end FNC_GET_BUSI_TIME;
/

prompt
prompt Creating function FNC_GET_DICT_TRANS
prompt ====================================
prompt
CREATE OR REPLACE FUNCTION CLM.FNC_GET_DICT_TRANS( v_value IN VARCHAR,  v_code IN VARCHAR)
return VARCHAR is
     key_name VARCHAR(100);
BEGIN

    if (v_code = '' or v_code is null) then
        return v_value;
    end if;

    if (v_value = '' or v_value is null) then
       return v_value;
    end if;

    if (v_code = 'user') then
        select t.REAL_NAME
        into key_name
        from CHAIN_USER t
        where t.ACCOUNT = v_value;
    elsif (v_code = 'crd') then
        select t.CRD_PRODUCT_NAME
        into key_name
        from TB_PAR_CRD t
        where t.CRD_PRODUCT_NUM = v_value;
    elsif (v_code = 'product') then
        select t.PRODUCT_NAME
        into key_name
        from TB_PAR_PRODUCT t
        where t.PRODUCT_NUM = v_value;
    else
        select t.DICT_VALUE
        into key_name
        from CHAIN_DICT t
        where t.CODE = v_code
          and t.DICT_KEY =v_value;
    end if;
    return key_name;
END;
/

prompt
prompt Creating function FNC_GET_DIVISION
prompt ==================================
prompt
CREATE OR REPLACE FUNCTION CLM."FNC_GET_DIVISION"(fz in number,
                                                    fm in number)
  return number is
  res  number;
  p_fm number;
  p_fz number;
  p_fm1 number;
BEGIN
  p_fz := nvl(fz, 0);
  p_fm := nvl(fm, 0);  
  select decode(p_fm,0,1,p_fm) into p_fm from dual;  
  res := p_fz / p_fm;
  return res;
END;
/

prompt
prompt Creating function FNC_GET_HS_DATE
prompt =================================
prompt
create or replace function clm.FNC_GET_HS_DATE(hs_type in varchar2, style in varchar2)
  return varchar2 is
  v_hs_date   varchar2(10);
  v_busi_time date; --��ǰϵͳ����
  v_style     varchar2(10); --���ڷ��
begin

  v_busi_time := fnc_get_busi_time();

  if style is not null and length(trim(style))> 0 then
    if upper(style) = 'Y' then
      v_style := 'yyyy';   
      elsif upper(style) = 'M' then v_style := 'MM';
      elsif upper(style) = 'D' then v_style := 'dd';
    else
      v_style := style;
    end if;
  else
    v_style := 'yyyyMM';
  end if;

  if (hs_type = 0) then
    --��ǰ
    v_hs_date := to_char(v_busi_time, v_style);
    elsif(hs_type = 1) then --ͬ�ڣ�ָȥ��ͬ�·ݣ�
    v_hs_date := to_char(add_months(trunc(v_busi_time),-1), v_style);
    elsif(hs_type = 2) then --���������һ�·ݣ�
    v_hs_date := to_char(to_date(extract(year from v_busi_time) ||
                                    '1231',
                                    'yyyyMMdd'),
                            v_style);
    elsif(hs_type = 3) then --���ڣ��ϸ��£�
    v_hs_date := to_char(add_months(trunc(v_busi_time),-1), v_style);
  end if;

  --����ֵ
  return v_hs_date;

  return(v_hs_date);
end;
/

prompt
prompt Creating function FNC_GET_TRAN_SEQ
prompt ==================================
prompt
CREATE OR REPLACE FUNCTION CLM.FNC_GET_TRAN_SEQ RETURN VARCHAR IS
  --��������
  N_TRAN_SEQ_SN VARCHAR(20); ---�������½�����ˮ��
  GRANT_SEQ_SN  NUMBER; --������ˮ�����ֵ
  USE_SEQ_SN    NUMBER; --������ˮ�����ֵ
  TRAN_SEQ_NUM  NUMBER; --�����ˮ��ֵ
  V_TRAN_SYSTEM VARCHAR(20); --����ϵͳ

BEGIN
  /*
    �ú����������ǲ���һ����ˮ�ţ���ˮ�Ų��������ǣ�
    ��ȡ������ˮ��������ˮ�š�������ˮ��������ˮ�ţ�ͨ���Ƚ�������ˮ�ŵ����ֵ��ȡ�����Ǹ�ֵ+1��Ϊ�µ���ˮ��
  */

  --�趨ֵ
   V_TRAN_SYSTEM := '0010'; --�ʽ�ϵͳ��ϵͳ��
    SELECT MAX(TO_NUMBER((SUBSTR(T.TRAN_SEQ_SN, 8, LENGTH(T.TRAN_SEQ_SN) - 7)))) INTO GRANT_SEQ_SN
      FROM TB_CRD_GRANTING_SERIAL T; --WHERE T.TRAN_SYSTEM = V_TRAN_SYSTEM
    SELECT MAX(TO_NUMBER((SUBSTR(T1.TRAN_SEQ_SN, 8, LENGTH(T1.TRAN_SEQ_SN) - 7)))) INTO USE_SEQ_SN
      FROM TB_CRD_APPLY_SERIAL T1; -- WHERE T1.TRAN_SYSTEM = V_TRAN_SYSTEM);
  IF GRANT_SEQ_SN > USE_SEQ_SN THEN
     TRAN_SEQ_NUM :=(GRANT_SEQ_SN + 1);
  ELSE
     TRAN_SEQ_NUM :=(USE_SEQ_SN + 1);
  END IF;
  --����ֵ
  RETURN 'CR00001' || TO_CHAR(TRAN_SEQ_NUM);
END;
/

prompt
prompt Creating function FNC_GET_UUID
prompt ==============================
prompt
CREATE OR REPLACE FUNCTION CLM.FNC_GET_UUID( IN_PARAMETER IN VARCHAR)
    RETURN VARCHAR IS
   --��������
    SEQ_SIX_NUM VARCHAR(10);
    SRETURN VARCHAR(28) DEFAULT '';
    SEQ_NUM number;
    SEQ_NUM_STR VARCHAR(100);

BEGIN
    --���ñ���ֵ
    execute immediate 'select ' || 'seq_six_num.nextval from dual' into SEQ_NUM ;
    SEQ_NUM_STR :=  '0000000000000000' || to_char(SEQ_NUM);
    select SUBSTR(SEQ_NUM_STR, LENGTH(SEQ_NUM_STR)-9) into SEQ_SIX_NUM from dual;
    select to_char(sysdate,'yymmddhh24miss')||SEQ_SIX_NUM into SRETURN from dual;
    --����ֵ
    RETURN IN_PARAMETER || SRETURN;
END;
/

prompt
prompt Creating procedure PRC_CC_STATIS
prompt ================================
prompt
CREATE OR REPLACE PROCEDURE CLM.PRC_CC_STATIS
IS
 V_CRD_DETAIL_NUM VARCHAR(40); --������ȱ��
 V_CRD_MAIN_NUM VARCHAR(40); --������ȱ��
 V_WORK_TIME DATE; --Ӫҵʱ��

BEGIN
    V_WORK_TIME := FNC_GET_BUSI_TIME();
    --�������ÿ�3Ҫ��ƥ��ͻ���
    merge into TB_CRD_CC_INFO t
    using (
        select a.CUSTOMER_NUM, a.CUSTOMER_NAME, b.CERT_TYPE, b.CERT_NUM
        from TB_CSM_PARTY a,
             TB_CSM_CERT_INFO b
        where a.CUSTOMER_NUM = b.CUSTOMER_NUM
    ) s
    on (
            t.CUSTOMER_NAME = s.CUSTOMER_NAME
            and t.CERT_TYPE = s.CERT_TYPE
            and t.CERT_NUM = s.CERT_NUM
        )
    when matched then
        update set t.CUSTOMER_NUM=s.CUSTOMER_NUM;


    --���¶���������
    for crd_detail_list in (
        SELECT T.CRD_DETAIL_PRD,
               T.CUSTOMER_NUM,
               A.CORP_ORG_CODE
        FROM TB_CRD_CC_INFO T,
             CHAIN_DEPT A
        WHERE T.ORG_NUM = A.ID
        GROUP BY T.CUSTOMER_NUM,
                 A.CORP_ORG_CODE,
                 T.CRD_DETAIL_PRD
    )
        loop
            V_CRD_DETAIL_NUM := null;

            select t.CRD_DETAIL_NUM
            into V_CRD_DETAIL_NUM
            from TB_CRD_DETAIL t
            where t.CUSTOMER_NUM = crd_detail_list.CUSTOMER_NUM
              and t.CRD_DETAIL_PRD = crd_detail_list.CRD_DETAIL_PRD
              and t.ORG_NUM = crd_detail_list.CORP_ORG_CODE;

            if (V_CRD_DETAIL_NUM is null or V_CRD_DETAIL_NUM = '') then
                V_CRD_DETAIL_NUM := FNC_GET_BIZ_NUM('ED3');
            end if;

            update TB_CRD_CC_INFO t
            set t.CRD_DETAIL_NUM=V_CRD_DETAIL_NUM,
                t.UPDATE_TIME=V_WORK_TIME
            where t.CUSTOMER_NUM = crd_detail_list.CUSTOMER_NUM
              and t.CRD_DETAIL_PRD = crd_detail_list.CRD_DETAIL_PRD
              and exists(select 1
                         from CHAIN_DEPT a
                         where a.ID = t.ORG_NUM
                           and a.CORP_ORG_CODE = crd_detail_list.CORP_ORG_CODE);
        end loop;

    --���¶�ȶ������
    for crd_main_list in (
        SELECT t.CRD_MAIN_PRD,
               T.CUSTOMER_NUM,
               A.CORP_ORG_CODE
        FROM TB_CRD_CC_INFO T,
             CHAIN_DEPT A
        WHERE T.ORG_NUM = A.ID
        GROUP BY T.CUSTOMER_NUM,
                 A.CORP_ORG_CODE,
                 t.CRD_MAIN_PRD
    )
        loop
            V_CRD_MAIN_NUM := null;

            select t.CRD_MAIN_NUM
            into V_CRD_MAIN_NUM
            from TB_CRD_MAIN t
            where t.CUSTOMER_NUM = crd_main_list.CUSTOMER_NUM
              and t.CRD_MAIN_PRD = crd_main_list.CRD_MAIN_PRD
              and t.ORG_NUM = crd_main_list.CORP_ORG_CODE;

            if (V_CRD_MAIN_NUM is null or V_CRD_MAIN_NUM = '') then
                V_CRD_MAIN_NUM := FNC_GET_BIZ_NUM('ED3');
            end if;

            update TB_CRD_CC_INFO t
            set t.CRD_MAIN_NUM=V_CRD_MAIN_NUM,
                t.UPDATE_TIME=V_WORK_TIME
            where t.CUSTOMER_NUM = crd_main_list.CUSTOMER_NUM
              and t.CRD_MAIN_PRD = crd_main_list.CRD_MAIN_PRD
              and exists(select 1
                         from CHAIN_DEPT a
                         where a.ID = t.ORG_NUM
                           and a.CORP_ORG_CODE = crd_main_list.CORP_ORG_CODE);
        end loop;

    --ɾ��û�й��������������ÿ������Ŷ����Ϣ
    DELETE
    FROM TB_CRD_DETAIL T
    WHERE T.TRAN_SYSTEM = '1106'
      AND EXISTS(
            SELECT 1
            FROM TB_PAR_CRD A
            WHERE A.CRD_PRODUCT_NUM = T.CRD_DETAIL_PRD
              AND SUBSTR(A.CRD_PRODUCT_NUM, 1, 2) IN ('01', '02')--�Ŵ����ˡ���˾�Ķ��
              AND A.CRD_PRODUCT_TYPE = '1'--���Ŷ��
        )
      AND NOT EXISTS(
            SELECT 1
            FROM TB_CRD_CC_INFO A
            WHERE A.CRD_DETAIL_NUM = T.CRD_DETAIL_NUM
        );

    --���¶����ϸ���ȣ�TB_CRD_DETAIL��
    MERGE INTO TB_CRD_DETAIL TA
    USING (SELECT T.CRD_MAIN_NUM,
                  T.CRD_DETAIL_NUM,
                  T.CRD_DETAIL_PRD,
                  T.CUSTOMER_NUM,
                  SUM(T.CREDIT_LIMIT)              LIMIT_CREDIT,
                  SUM(T.CREDIT_LIMIT - t.CURR_BAL) LIMIT_USED,
                  SUM(T.CURR_BAL)                  LIMIT_AVI,
                  SUM(T.CREDIT_LIMIT)              EXP_CREDIT,
                  SUM(T.CREDIT_LIMIT - t.CURR_BAL) EXP_USED,
                  SUM(T.CURR_BAL)                  EXP_AVI,
                  0                                LIMIT_PRE,
                  0                                EXP_PRE,
                  A.CORP_ORG_CODE
           FROM TB_CRD_CC_INFO T,
                CHAIN_DEPT A
           WHERE T.ORG_NUM = A.ID
           GROUP BY T.CUSTOMER_NUM,
                    A.CORP_ORG_CODE,
                    T.CRD_DETAIL_PRD,
                    T.CRD_DETAIL_NUM, T.CRD_MAIN_NUM) S
    ON (
        S.CRD_DETAIL_NUM = ta.CRD_DETAIL_NUM
        )
    WHEN NOT MATCHED
        THEN
        INSERT (CRD_MAIN_NUM,--������ȱ��
                CRD_DETAIL_NUM, --������ȱ��
                CRD_DETAIL_PRD, --�������Ʒ��
                CUSTOMER_NUM, --ECIF�ͻ����
                CURRENCY_CD, --����
                EXCHANGE_RATE, --����
                LIMIT_CREDIT, --���Ŷ��
                LIMIT_USED, --���Ŷ������
                LIMIT_AVI, --���Ŷ�ȿ���
                EXP_CREDIT, --���ų���
                EXP_USED, --��������
                EXP_AVI, --���ڿ���
                LIMIT_PRE, ---Ԥռ�ö��
                EXP_PRE, --Ԥռ�ó���
                CREATE_TIME, --��������
                UPDATE_TIME, --��������
                CRD_GRANT_ORG_NUM,--���Ż���
                ORG_NUM, --�������
                TRAN_SYSTEM,--����ϵͳ
                CRD_PRODUCT_TYPE--�������
        )
        VALUES (S.CRD_MAIN_NUM,
                S.CRD_DETAIL_NUM,
                S.CRD_DETAIL_PRD,
                S.CUSTOMER_NUM,
                'CNY',
                '1',
                S.LIMIT_CREDIT,
                S.LIMIT_USED,
                S.LIMIT_AVI,
                S.EXP_CREDIT,
                S.EXP_AVI,
                S.EXP_USED,
                S.LIMIT_PRE,
                S.EXP_PRE,
                V_WORK_TIME,
                V_WORK_TIME,
                S.CORP_ORG_CODE,
                S.CORP_ORG_CODE,
                '1106', '1'--�������(���Ŷ��)
               )
    WHEN MATCHED
        THEN
        UPDATE
        SET TA.CRD_MAIN_NUM=S.CRD_MAIN_NUM,--������ȱ��
            TA.CRD_DETAIL_PRD=S.CRD_DETAIL_PRD,--�������Ʒ��
            TA.LIMIT_CREDIT = S.LIMIT_CREDIT, --���Ŷ��
            TA.LIMIT_USED = S.LIMIT_USED, --���Ŷ������
            TA.LIMIT_AVI = S.LIMIT_AVI, --���Ŷ�ȿ���
            TA.EXP_CREDIT = S.EXP_CREDIT, --���ų���
            TA.EXP_USED = S.EXP_USED, --��������
            TA.EXP_AVI = S.EXP_AVI, --���ڿ���
            TA.LIMIT_PRE = S.LIMIT_PRE, ---Ԥռ�ö��
            TA.EXP_PRE = S.LIMIT_PRE, --Ԥռ�ó���
            TA.CRD_GRANT_ORG_NUM=S.CORP_ORG_CODE,--�������
            TA.ORG_NUM = S.CORP_ORG_CODE, --�������
            TA.UPDATE_TIME = V_WORK_TIME;
    --��������

    --ɾ����Ч�Ķ������
    DELETE
    FROM TB_CRD_MAIN T
    WHERE T.TRAN_SYSTEM = '1106'
      AND EXISTS(
            SELECT 1
            FROM TB_PAR_CRD A
            WHERE A.CRD_PRODUCT_NUM = T.CRD_MAIN_PRD
              AND SUBSTR(A.CRD_PRODUCT_NUM, 1, 2) IN ('01', '02') --�Ŵ����ˡ���˾�Ķ��
        )
      AND NOT EXISTS(
            SELECT 1 FROM TB_CRD_CC_INFO A WHERE A.CRD_MAIN_NUM = T.CRD_MAIN_NUM --���ÿ�
        );

    --���¶������
    MERGE INTO TB_CRD_MAIN TA
    USING (SELECT T.CRD_MAIN_NUM,
                  T.CRD_MAIN_PRD,
                  T.CUSTOMER_NUM,
                  SUM(T.CREDIT_LIMIT)              LIMIT_CREDIT,
                  SUM(T.CREDIT_LIMIT - t.CURR_BAL) LIMIT_USED,
                  SUM(T.CURR_BAL)                  LIMIT_AVI,
                  SUM(T.CREDIT_LIMIT)              EXP_CREDIT,
                  SUM(T.CREDIT_LIMIT - t.CURR_BAL) EXP_USED,
                  SUM(T.CURR_BAL)                  EXP_AVI,
                  0                                LIMIT_PRE,
                  0                                EXP_PRE,
                  A.CORP_ORG_CODE
           FROM TB_CRD_CC_INFO T,
                CHAIN_DEPT A
           WHERE T.ORG_NUM = A.ID
           GROUP BY T.CUSTOMER_NUM,
                    A.CORP_ORG_CODE,
                    T.CRD_MAIN_NUM,
                    T.CRD_MAIN_PRD) S
    ON (
        S.CRD_MAIN_NUM = TA.CRD_MAIN_NUM
        )
    WHEN NOT MATCHED
        THEN
        INSERT (CRD_MAIN_NUM,--������ȱ��
                CRD_MAIN_PRD, --�������Ʒ��
                CUSTOMER_NUM, --ECIF�ͻ����
                CURRENCY_CD, --����
                EXCHANGE_RATE, --����
                LIMIT_CREDIT, --���Ŷ��
                LIMIT_USED, --���Ŷ������
                LIMIT_AVI, --���Ŷ�ȿ���
                EXP_CREDIT, --���ų���
                EXP_USED, --��������
                EXP_AVI, --���ڿ���
                LIMIT_PRE, ---Ԥռ�ö��
                EXP_PRE, --Ԥռ�ó���
                CREATE_TIME, --��������
                UPDATE_TIME, --��������
                CRD_GRANT_ORG_NUM,--���Ż���
                ORG_NUM,--�������
                TRAN_SYSTEM,--����ϵͳ
                CRD_PRODUCT_TYPE--�������
        )
        VALUES (S.CRD_MAIN_NUM,
                S.CRD_MAIN_PRD,
                S.CUSTOMER_NUM,
                'CNY',
                '1',
                S.LIMIT_CREDIT,
                S.LIMIT_USED,
                S.LIMIT_AVI,
                S.EXP_CREDIT,
                S.EXP_AVI,
                S.EXP_USED,
                S.LIMIT_PRE,
                S.EXP_PRE,
                V_WORK_TIME,
                V_WORK_TIME,
                S.CORP_ORG_CODE,
                S.CORP_ORG_CODE, '1106', '1')
    WHEN MATCHED
        THEN
        UPDATE
        SET TA.CRD_MAIN_PRD=S.CRD_MAIN_PRD,
            TA.LIMIT_CREDIT = S.LIMIT_CREDIT,    --���Ŷ��
            TA.LIMIT_USED = S.LIMIT_USED,        --���Ŷ������
            TA.LIMIT_AVI = S.LIMIT_AVI,          --���Ŷ�ȿ���
            TA.EXP_CREDIT = S.EXP_CREDIT,        --���ų���
            TA.EXP_USED = S.EXP_USED,            --��������
            TA.EXP_AVI = S.EXP_AVI,              --���ڿ���
            TA.LIMIT_PRE = S.LIMIT_PRE,          ---Ԥռ�ö��
            TA.EXP_PRE = S.LIMIT_PRE,            --Ԥռ�ó���
            TA.CRD_GRANT_ORG_NUM=S.CORP_ORG_CODE,--�������
            TA.ORG_NUM = S.CORP_ORG_CODE,        --�������
            TA.UPDATE_TIME = V_WORK_TIME; --��������
END;
/

prompt
prompt Creating procedure PRC_CRD_BATCH_LOG
prompt ====================================
prompt
create or replace procedure clm.PRC_CRD_BATCH_LOG(SCHEMA_TYPE  in varchar2,
                                              STEP_NAME    in varchar2,
                                              STATUS       in varchar2,
                                              EFFECT_COUNT in number,
                                              SQL_CODE     in number,
                                              REMARK       in varchar) is
begin
   INSERT INTO
   TB_PROCEDURE_EXEC_LOG(
     PROC_EXEC_ID,
     SCHEMA_TYPE,
     PROC_NAME,
     STATUS,
     EXEC_DATE,
     EXEC_TIME,
     EFFECT_COUNT,
     SQL_CODE,
     REMARK)
  VALUES
   (
     FNC_GET_UUID('LOG'),
     SCHEMA_TYPE,
     STEP_NAME,
     STATUS,
     sysdate,
     sysdate,
     EFFECT_COUNT,
     SQL_CODE,
     REMARK);
end PRC_CRD_BATCH_LOG;
/

prompt
prompt Creating procedure PRC_CRD_BILL_EXPIRE_DUE
prompt ==========================================
prompt
CREATE OR REPLACE PROCEDURE CLM."PRC_CRD_BILL_EXPIRE_DUE" (
     EXEC_DATE in VARCHAR,
     RES_NUM out NUMBER)
IS
   EFFECT_COUNT NUMBER;---Ӱ������
   SQL_CODE VARCHAR(20);--������
   SCHEMA_TYPE VARCHAR(10);--SCHEMA����
   STATUS VARCHAR(20);--ִ�����
   PROC_NAME VARCHAR(50);--�洢����
   V_CRD_DETAIL_PRD VARCHAR(10);--������Ȳ�Ʒ��
   V_CRD_MAIN_PRD VARCHAR(10);--������Ȳ�Ʒ��
   V_D_CRD_DETAIL_NUM VARCHAR(40);--������ϸ��ȱ��
   V_M_CRD_DETAIL_NUM VARCHAR(40);--ʡ������ϸ��ȱ��
   V_D_CRD_MAIN_NUM VARCHAR(40);--��������ȱ��
   V_M_CRD_MAIN_NUM VARCHAR(40);--ʡ��������ȱ��
   V_B_CRD_GRANT_ORG_NUM VARCHAR(6);--���Ż���
   V_P_CRD_GRANT_ORG_NUM VARCHAR(6);--���Ż���-ʡ����
   V_CUSTOMER_NUM VARCHAR(10);--�ͻ���
   V_BUSI_PRD_NUM VARCHAR(40);--ҵ���Ʒ���
   V_CERT_STATUS VARCHAR(2);--ƾ֤״̬
   V_CERT_DRAWER_CUST_NUM VARCHAR(10);--�����˿ͻ���
   V_CERT_DRAWER_BANK_NUM VARCHAR(10);--�����˴���/�ж��к�
   V_CERT_APPLY_AMT NUMBER(24,2);--ƾ֤���Ž��
   V_B_DUE_NUM NUMBER;--���Ż���Ϊ���������ʧЧ����
   V_FAILURE_STATE VARCHAR(2);--ʧЧ״̬ 01:��Ч��02�����ֶ��ᡢ03��ȫ�����ᡢ04�������
   V_IS_C VARCHAR(2);--ʧЧ״̬ 01:��Ч��02�����ֶ��ᡢ03��ȫ�����ᡢ04�������
   V_CRET_INFO_ID VARCHAR(32);--ƾ֤ID
   V_BANK_CUST_NUM VARCHAR(10);--���пͻ���
   V_B_D_CRD_MAIN_NUM VARCHAR(40);--�ж������ŷ��˻���������ȱ��
   V_B_M_CRD_MAIN_NUM VARCHAR(40);--�ж�������ʡ���������ȱ��
   V_B_M_CRD_DETAIL_NUM VARCHAR(40);--�ж�������ʡ�������ϸ��ȱ��
   V_B_D_CRD_DETAIL_NUM VARCHAR(40);--�ж������ŷ��˻�������ϸ��ȱ��

  BEGIN

  V_P_CRD_GRANT_ORG_NUM := '01000';--ʡ���������
  /*
     ƾ֤����
    1�����Ȳ鿴ƾ֤��Ϣ�����Ƿ����ƾ֤״̬Ϊռ��(ռ��)��Ʊ�ݵ��ڵ�ƾ֤��
    2����ѯ����������1��ƾ֤��������ȱ�š�ҵ���Ʒ��š�ƾ֤���Ž�ƾ֤״̬�������˿ͻ��š������˴���/�ж��кš��ͻ��š����Ż����������ϸ��Ʒ��
    3���ҵ���ƾ֤��������ҵ���Ʒ���=200007-ֱ���� ���� ƾ֤״̬=03 ռ��/10 ���壩����ֱ����ҵ�Ļָ����ţ���Ȳ�ѭ�������Կ��ò��ָ����ָ�֮��״̬Ϊ10 ����
    4���ҵ���ƾ֤��������ƾ֤״̬=03 ռ�ã������гж��У��ҿͻ������лָ����ţ��ָ�֮��״̬Ϊ10 ����
  */
  SELECT COUNT(*) INTO V_B_DUE_NUM FROM TB_CRD_BUSI_CERT_INFO T1 WHERE T1.CERT_END_DATE = EXEC_DATE AND T1.CERT_STATUS = '03';
  IF V_B_DUE_NUM >0
  THEN
    FOR CERT_INFO_DATAS IN (
    SELECT T1.CRET_INFO_ID, --ƾ֤��ϢID
      T1.CRD_DETAIL_NUM,--������ȱ��
      T1.BUSI_PRD_NUM,--ҵ���Ʒ���
      T1.CERT_APPLY_AMT,--ƾ֤���Ž��
      T1.CERT_STATUS,--ƾ֤״̬
      T1.CERT_DRAWER_CUST_NUM,--�����˿ͻ���
      T1.CERT_DRAWER_BANK_NUM,--�����˴���/�ж��к�
      T1.CUSTOMER_NUM,--�ͻ���
      T1.CRD_GRANT_ORG_NUM,--���Ż���
      T1.CRD_DETAIL_PRD--�����ϸ��Ʒ
    FROM
      TB_CRD_BUSI_CERT_INFO T1 WHERE T1.CERT_END_DATE = EXEC_DATE AND T1.CERT_STATUS = '03'
      )
    LOOP
     V_CRET_INFO_ID := CERT_INFO_DATAS.CRET_INFO_ID;--ID�������ڸ���Ʊ��״̬
     V_D_CRD_DETAIL_NUM := CERT_INFO_DATAS.CRD_DETAIL_NUM;--������ϸ��ȱ��
     V_BUSI_PRD_NUM := CERT_INFO_DATAS.BUSI_PRD_NUM;
     V_CERT_APPLY_AMT := CERT_INFO_DATAS.CERT_APPLY_AMT;
     V_CERT_STATUS := CERT_INFO_DATAS.CERT_STATUS;
     V_CERT_DRAWER_CUST_NUM := CERT_INFO_DATAS.CERT_DRAWER_CUST_NUM;
     V_CERT_DRAWER_BANK_NUM := CERT_INFO_DATAS.CERT_DRAWER_BANK_NUM;
     V_CUSTOMER_NUM := CERT_INFO_DATAS.CUSTOMER_NUM;
     V_B_CRD_GRANT_ORG_NUM := CERT_INFO_DATAS.CRD_GRANT_ORG_NUM;
     V_CRD_DETAIL_PRD := CERT_INFO_DATAS.CRD_DETAIL_PRD;
     SELECT SUPER_CRD_NUM INTO V_CRD_MAIN_PRD FROM TB_PAR_CRD WHERE CRD_PRODUCT_NUM = V_CRD_DETAIL_PRD;--��ȡ������Ʒ���
     SELECT T1.CRD_MAIN_NUM INTO V_D_CRD_MAIN_NUM FROM TB_CRD_DETAIL T1 WHERE T1.CRD_DETAIL_NUM = V_D_CRD_DETAIL_NUM;--��ȡ��������ȱ��
     SELECT T1.CRD_DETAIL_NUM INTO V_M_CRD_DETAIL_NUM  FROM TB_CRD_DETAIL T1 WHERE T1.CRD_DETAIL_PRD = V_CRD_DETAIL_PRD AND T1.CRD_GRANT_ORG_NUM = V_P_CRD_GRANT_ORG_NUM AND T1.CUSTOMER_NUM = V_CUSTOMER_NUM;--��ȡʡ������ϸ��ȱ��
     SELECT T1.CRD_MAIN_NUM INTO V_M_CRD_MAIN_NUM FROM TB_CRD_DETAIL T1 WHERE T1.CRD_DETAIL_NUM = V_M_CRD_DETAIL_NUM;--��ȡʡ��������ȱ��
     SELECT  T3.CUSTOMER_NUM INTO V_BANK_CUST_NUM FROM TB_CSM_CORPORATION T3 WHERE T3.BANK_PAY_SYS_NUM = V_CERT_DRAWER_BANK_NUM;--�����к���Ѱ�ͻ���
    --TB_PAR_CRD
    IF  V_BUSI_PRD_NUM = '200007'
    THEN
      UPDATE TB_CRD_DETAIL T1 SET T1.LIMIT_AVI = T1.LIMIT_AVI+V_CERT_APPLY_AMT WHERE T1.CRD_DETAIL_NUM = V_D_CRD_DETAIL_NUM AND IS_CYCLE ='1';--�ָ���ϸ��ȱ��˿��ý��
      UPDATE TB_CRD_DETAIL T2 SET T2.LIMIT_USED =T2.LIMIT_AVI-V_CERT_APPLY_AMT WHERE CRD_DETAIL_NUM = V_D_CRD_DETAIL_NUM ;--�ָ����ý��
      UPDATE TB_CRD_DETAIL T1 SET T1.LIMIT_AVI = T1.LIMIT_AVI+V_CERT_APPLY_AMT WHERE T1.CRD_DETAIL_NUM = V_M_CRD_DETAIL_NUM AND IS_CYCLE ='1';--�ָ���ϸ��ȱ�ʡ������ý��
      UPDATE TB_CRD_DETAIL T2 SET T2.LIMIT_USED =T2.LIMIT_AVI-V_CERT_APPLY_AMT WHERE CRD_DETAIL_NUM = V_M_CRD_DETAIL_NUM ;--�ָ����ý��
      UPDATE TB_CRD_MAIN T2 SET T2.LIMIT_USED =T2.LIMIT_USED-V_CERT_APPLY_AMT  WHERE CRD_MAIN_NUM = V_D_CRD_MAIN_NUM;--�ָ���������˻������ý�� ���ý��δ��
      UPDATE TB_CRD_MAIN T2 SET T2.LIMIT_USED =T2.LIMIT_USED-V_CERT_APPLY_AMT  WHERE CRD_MAIN_NUM = V_M_CRD_MAIN_NUM;--�ָ��������ʡ�������ý�� ���ý��δ��
      UPDATE TB_CRD_BUSI_CERT_INFO SET CERT_STATUS = '10' WHERE CRET_INFO_ID = V_CRET_INFO_ID;--�޸�ƾ֤״̬Ϊ���� 10
    ELSE
      SELECT T2.CRD_DETAIL_NUM,T2.CRD_MAIN_NUM INTO V_B_M_CRD_DETAIL_NUM,V_B_M_CRD_MAIN_NUM  FROM TB_CRD_DETAIL T2 WHERE T2.CRD_DETAIL_PRD = V_CRD_DETAIL_PRD AND T2.CRD_GRANT_ORG_NUM = V_P_CRD_GRANT_ORG_NUM AND T2.CUSTOMER_NUM = V_BANK_CUST_NUM;--��ȡʡ�������ŵ���ϸ��ȱ�ţ�����ȱ��
      SELECT T2.CRD_DETAIL_NUM,T2.CRD_MAIN_NUM INTO V_B_D_CRD_DETAIL_NUM,V_B_D_CRD_MAIN_NUM FROM TB_CRD_DETAIL T2 WHERE T2.CRD_DETAIL_PRD = V_CRD_DETAIL_PRD AND T2.CRD_GRANT_ORG_NUM = V_B_CRD_GRANT_ORG_NUM AND T2.CUSTOMER_NUM = V_BANK_CUST_NUM;--��ȡ���˻�������ϸ��ȱ�ţ�����ȱ��
      UPDATE TB_CRD_DETAIL T1 SET T1.LIMIT_AVI = T1.LIMIT_AVI+V_CERT_APPLY_AMT WHERE T1.CRD_DETAIL_NUM = V_B_D_CRD_DETAIL_NUM AND IS_CYCLE ='1';--�ָ���ϸ��ȱ��˿��ý��
      UPDATE TB_CRD_DETAIL T2 SET T2.LIMIT_USED =T2.LIMIT_AVI-V_CERT_APPLY_AMT WHERE CRD_DETAIL_NUM = V_B_D_CRD_DETAIL_NUM ;--�ָ����ý��
      UPDATE TB_CRD_DETAIL T1 SET T1.LIMIT_AVI = T1.LIMIT_AVI+V_CERT_APPLY_AMT WHERE T1.CRD_DETAIL_NUM = V_B_M_CRD_DETAIL_NUM AND IS_CYCLE ='1';--�ָ���ϸ��ȱ�ʡ������ý��
      UPDATE TB_CRD_DETAIL T2 SET T2.LIMIT_USED =T2.LIMIT_AVI-V_CERT_APPLY_AMT WHERE CRD_DETAIL_NUM = V_B_M_CRD_DETAIL_NUM ;--�ָ����ý��
      UPDATE TB_CRD_MAIN T2 SET T2.LIMIT_USED =T2.LIMIT_USED-V_CERT_APPLY_AMT  WHERE CRD_MAIN_NUM = V_B_D_CRD_MAIN_NUM;--�ָ���������˻������ý�� ���ý��δ��
      UPDATE TB_CRD_MAIN T2 SET T2.LIMIT_USED =T2.LIMIT_USED-V_CERT_APPLY_AMT  WHERE CRD_MAIN_NUM = V_B_M_CRD_MAIN_NUM;--�ָ��������ʡ�������ý�� ���ý��δ��
      UPDATE TB_CRD_BUSI_CERT_INFO SET CERT_STATUS = '10' WHERE CRET_INFO_ID = V_CRET_INFO_ID;--�޸�ƾ֤״̬Ϊ���� 10
    END IF;
    END LOOP;
     RES_NUM := 1;
  ELSE
     RES_NUM := 1;
  END IF;

END;
/

prompt
prompt Creating procedure PRC_CRD_EARK_EXPIRE_DUE
prompt ==========================================
prompt
CREATE OR REPLACE PROCEDURE CLM."PRC_CRD_EARK_EXPIRE_DUE" (
     EXEC_DATE in VARCHAR,
     RES_NUM out NUMBER)
IS

   EFFECT_COUNT NUMBER;---Ӱ������
   SQL_CODE VARCHAR(20);--������
   SCHEMA_TYPE VARCHAR(10);--SCHEMA����
   STATUS VARCHAR(20);--ִ�����
   PROC_NAME VARCHAR(50);--�洢����
   V_CRD_DETAIL_PRD VARCHAR(10);--������Ʒ��
   V_CRD_DETAIL_NUM VARCHAR(40);--����ȱ��
   V_M_CRD_GRANT_ORG_NUM VARCHAR(6);--���Ż���
   V_CUSTOMER_NUM VARCHAR(10);--�ͻ���
   V_D_DUE_NUM NUMBER;--Ȧ����ʧЧ����
   V_FAILURE_STATE VARCHAR(2);--ʧЧ״̬ 01:��Ч��02�����ֶ��ᡢ03��ȫ�����ᡢ04:�����
   V_P_CRD_GRANT_ORG_NUM VARCHAR(6);--���Ż���

  BEGIN
    
        V_P_CRD_GRANT_ORG_NUM := '01122';--ʡ���������
  /*
                  Ȧ���ȵ��ڴ���
    1��Ȧ���ȵ������ڵ��ڵ�ǰ��������EXEC_DATE�������Ż���Ϊʡ����ʱ�����ÿͻ��ò�Ʒ�����е�Ȧ���ȣ�Ȧ�����ö���Ϊ0.0
    2��Ȧ���ȵ����յ��ڵ�ǰ��������EXEC_DATE�������Ż���Ϊ����ķ��˻���ʱ���򽫸û����ò�Ʒ��Ȧ���ȣ�Ȧ�����ö���Ϊ0.0
  */
  SELECT COUNT(*) INTO V_D_DUE_NUM FROM TB_CRD_DETAIL T1 WHERE T1.EARMARK_END_DATE = EXEC_DATE;

 IF V_D_DUE_NUM >0  THEN 
    
  FOR CRD_DETAIL_DATAS IN (SELECT T1.CRD_DETAIL_PRD, T1.CRD_DETAIL_NUM, T1.CUSTOMER_NUM, T1.CRD_GRANT_ORG_NUM FROM TB_CRD_DETAIL T1 WHERE T1.EARMARK_END_DATE = EXEC_DATE)
    LOOP
       V_CRD_DETAIL_PRD := CRD_DETAIL_DATAS.CRD_DETAIL_PRD;
       V_CRD_DETAIL_NUM := CRD_DETAIL_DATAS.CRD_DETAIL_NUM;
       V_M_CRD_GRANT_ORG_NUM := CRD_DETAIL_DATAS.CRD_GRANT_ORG_NUM;
       V_CUSTOMER_NUM := CRD_DETAIL_DATAS.CUSTOMER_NUM;
      /*
        ���Ż���Ϊʡ����ʱ
      */
      IF V_M_CRD_GRANT_ORG_NUM = V_P_CRD_GRANT_ORG_NUM
      THEN
        UPDATE TB_CRD_DETAIL T2 SET T2.LIMIT_EARMARK=0.0,T2.LIMIT_EARMARK_USED=0.0 WHERE T2.CUSTOMER_NUM = V_CUSTOMER_NUM AND T2.CRD_DETAIL_PRD = V_CRD_DETAIL_PRD;
      ELSE
       UPDATE TB_CRD_DETAIL T2 SET T2.LIMIT_EARMARK=0.0,T2.LIMIT_EARMARK_USED=0.0 WHERE T2.CRD_DETAIL_NUM = V_CRD_DETAIL_NUM;    
      END IF;
    END LOOP;
 
 
     RES_NUM := 1;
  ELSE
     RES_NUM := 1;
  END IF;

END;
/

prompt
prompt Creating procedure PRC_CRD_EXPIRE_DUE
prompt =====================================
prompt
CREATE OR REPLACE PROCEDURE CLM."PRC_CRD_EXPIRE_DUE" (
     EXEC_DATE in VARCHAR,
     RES_NUM out NUMBER)
IS

   EFFECT_COUNT INTEGER;---Ӱ������
   SQL_CODE VARCHAR(20);--������
   SCHEMA_TYPE VARCHAR(10);--SCHEMA����
   STATUS VARCHAR(20);--ִ�����
   PROC_NAME VARCHAR(50);--�洢����
   V_CRD_MAIN_PRD VARCHAR(10);--������Ʒ��
   V_CRD_MAIN_NUM VARCHAR(40);--����ȱ��
   V_M_CRD_GRANT_ORG_NUM VARCHAR(6);--���Ż���
   V_CUSTOMER_NUM VARCHAR(10);--�ͻ���
   V_M_DUE_NUM INTEGER;--���Ż���Ϊ���������ʧЧ����
   V_FAILURE_STATE VARCHAR(2);--ʧЧ״̬ 01:��Ч��02�����ֶ��ᡢ03��ȫ�����ᡢ04�������
   V_P_CRD_GRANT_ORG_NUM VARCHAR(6);--���Ż���


  BEGIN
    
   V_P_CRD_GRANT_ORG_NUM := '01122';--ʡ���������
   V_FAILURE_STATE := '04';--���ʧЧ״̬
 /*
                  ��ȵ��ڴ���
    ��ȵĵ��ڽ����մ��ڻ�����������ڽ����״̬��Ϊ��Ч����ΪʧЧ״̬(�����)��
    1���ڶ�������У������Ż���Ϊʡ����ʱ������ݶ�Ӧ�Ŀͻ��Ž��ÿͻ����µ��������������ڸö�����Ʒ�µ�����ȱ�Ķ��״̬��ΪʧЧ
    2���ڶ�������У������Ż���Ϊ���˻���ʱ�����ݶ�Ӧ�Ŀͻ��š����Ż��������������ڸû����µĸö�����Ʒ�µĶ����ʧЧ״̬
    *****���ڿ��ƹ���ֻ���漰��������״̬�����ֻ��Ҫ�޸Ķ������Ķ��״̬����ϸ��ȱ��еĶ��״̬���漰��
  */
  SELECT COUNT(*) INTO V_M_DUE_NUM FROM TB_CRD_MAIN T1 WHERE T1.END_DATE = EXEC_DATE;
  IF V_M_DUE_NUM >0
  THEN
    FOR CRD_MAIN_DATAS IN (SELECT T1.CRD_MAIN_PRD, T1.CRD_MAIN_NUM, T1.CRD_GRANT_ORG_NUM, T1.CUSTOMER_NUM   FROM TB_CRD_MAIN T1 WHERE T1.END_DATE = EXEC_DATE)
    LOOP
      V_CRD_MAIN_PRD := CRD_MAIN_DATAS.CRD_MAIN_PRD;
      V_CRD_MAIN_NUM := CRD_MAIN_DATAS.CRD_MAIN_NUM;
      V_M_CRD_GRANT_ORG_NUM := CRD_MAIN_DATAS.CRD_GRANT_ORG_NUM;
      V_CUSTOMER_NUM := CRD_MAIN_DATAS.CUSTOMER_NUM;
      /*
        ���Ż���Ϊʡ����ʱ
      */
      IF V_M_CRD_GRANT_ORG_NUM = V_P_CRD_GRANT_ORG_NUM
      THEN
        UPDATE TB_CRD_MAIN T2 SET T2.CREDIT_STATUS = V_FAILURE_STATE WHERE T2.CUSTOMER_NUM = V_CRD_MAIN_NUM AND T2.CRD_MAIN_PRD = V_CRD_MAIN_PRD;
      ELSE
        UPDATE TB_CRD_MAIN T2 SET T2.CREDIT_STATUS = V_FAILURE_STATE WHERE T2.CRD_MAIN_NUM = V_CRD_MAIN_NUM;
      END IF;
    END LOOP;
    RES_NUM := 1;
  ELSE
    RES_NUM := 1;
  END IF;

END;
/

prompt
prompt Creating procedure PRC_CRD_GRANT_SERIAL
prompt =======================================
prompt
CREATE OR REPLACE PROCEDURE CLM."PRC_CRD_GRANT_SERIAL"
IS
     EFFECT_COUNT   NUMBER; ---Ӱ������
     SQL_CODE       VARCHAR(20); --������
     SCHEMA_TYPE    VARCHAR(10); --SCHEMA����
     STATUS         VARCHAR(20); --ִ�����
     PROC_NAME      VARCHAR(50); --�洢����
     V_CRD_GRANT_ORG_NUM VARCHAR(10);--���Ż���
     V_CUSTOMER_NUM VARCHAR(10);--ECIF�ͻ���
     V_CRD_MAIN_PRD VARCHAR(10);--������Ȳ�Ʒ
     V_CRD_DETAIL_PRD VARCHAR(10);--������Ȳ�Ʒ
     CRD_HAVE_COUNT       NUMBER; --��ͳһ����ϵͳ�е���������
     FUND_HAVE_COUNT      NUMBER; --���ʽ�ϵͳ�е���������

  BEGIN

   SELECT  COUNT(1) INTO CRD_HAVE_COUNT  FROM  TB_FUND_GRANT_MAIN T1  WHERE  T1.TRAN_EVENT_STATUS = '1' AND T1.TRAN_ACCT_STATUS = '0' AND
            T1.ADJUST_FLAG = '1' AND  T1.ADJUST_DIRECTION = '0' ;
    SELECT  COUNT(1) INTO FUND_HAVE_COUNT FROM  TB_FUND_GRANT_MAIN T1  WHERE  T1.TRAN_EVENT_STATUS = '0' AND T1.TRAN_ACCT_STATUS =  '1' AND
            T1.ADJUST_FLAG = '1' AND T1.ADJUST_DIRECTION = '1';

  IF CRD_HAVE_COUNT>0
    THEN
        FOR CRD_HAVE_CONDTION IN ( SELECT T1.TRAN_SEQ_SN, T1.TRAN_DATE,
                                         T1.BUSI_DEAL_NUM, T1.TRAN_TYPE_CD, T1.CRD_APPLY_AMT, T1.TRAN_EVENT_STATUS, T1.TRAN_ACCT_STATUS, T1.ADJUST_FLAG, T1.ADJUST_DIRECTION FROM TB_FUND_GRANT_MAIN T1 WHERE T1.TRAN_EVENT_STATUS = '1' AND T1.TRAN_ACCT_STATUS = '0' AND T1.ADJUST_FLAG = '1' AND T1.ADJUST_DIRECTION = '0')
            LOOP
                IF CRD_HAVE_CONDTION.TRAN_TYPE_CD = '01'  THEN
                    SELECT T2.CRD_GRANT_ORG_NUM,T2.CUSTOMER_NUM,T2.CRD_MAIN_PRD INTO V_CRD_GRANT_ORG_NUM,V_CUSTOMER_NUM,V_CRD_MAIN_PRD  FROM TB_FUND_GRANT_DETAIL T2 WHERE T2.TRAN_SEQ_SN=CRD_HAVE_CONDTION.TRAN_SEQ_SN AND T2.TRAN_DATE=CRD_HAVE_CONDTION.TRAN_DATE;
                END IF;
            END LOOP;

    END IF;

       /*

        FUND_HAVE_CURSOR CURSOR FOR
          SELECT
           T1.TRAN_SEQ_SN,
           T1.TRAN_DATE,
           T1.BUSI_DEAL_NUM,
           T1.TRAN_TYPE_CD,
           T1.CRD_APPLY_AMT,
           T1.TRAN_EVENT_STATUS,
           T1.TRAN_ACCT_STATUS,
           T1.ADJUST_FLAG,
           T1.ADJUST_DIRECTION
          FROM
           TB_FUND_GRANT_MAIN T1
          WHERE
           T1.TRAN_EVENT_STATUS = '0' AND
           T1.TRAN_ACCT_STATUS = '1' AND
           T1.ADJUST_FLAG = '1' AND
           T1.ADJUST_DIRECTION = '1';
    */
------------------------------------STEP1--BIGIN-----------------------------

END;
/

prompt
prompt Creating procedure PRC_CREDIT_RECOUNT
prompt =====================================
prompt
CREATE OR REPLACE PROCEDURE CLM."PRC_CREDIT_RECOUNT"( V_CUSTOMER_NUM IN VARCHAR)
IS
     V_APPROVE_USED NUMBER(18, 2) DEFAULT 0; --��������
     V_APPROVE_EXP_USED NUMBER(18, 2) DEFAULT 0; --������������


     V_APPROVE_PRE_AMT NUMBER(18, 2) DEFAULT 0; --����Ԥռ�ý��
     V_APPROVE_PRE_EXP NUMBER(18, 2) DEFAULT 0; --����Ԥռ�ó��ڽ��

     V_CON_BAL NUMBER(18, 2) DEFAULT 0; --��ͬ���
     V_CON_AMT NUMBER(18, 2) DEFAULT 0; --��ͬ�½�ݽ��֮��
     V_CON_USED NUMBER(18, 2) DEFAULT 0; --��ͬ����

     V_CRD_DETAIL_NUM VARCHAR(40); --������ȱ��
     V_CRD_MAIN_NUM VARCHAR(40); --������ȱ��

     V_WORK_TIME DATE; --Ӫҵʱ��
BEGIN

    V_WORK_TIME := FNC_GET_BUSI_TIME();

    --��ͬ�������
    FOR CON_LIST IN (SELECT CONTRACT_NUM, IS_CYCLE, CONTRACT_AMT
                     FROM TB_CRD_CONTRACT
                     WHERE CUSTOMER_NUM = V_CUSTOMER_NUM
                       AND CONTRACT_STATUS IN ('0', '1', '2'))
        LOOP
        --1����ͬ���(��ͬ����) = ��ͬ��δ����Ľ�����֮�ͣ����״̬��02,03��
        --2��ѭ����ͬ����=��ͬ���-��ͬ��δ���������֮��
        --3����ѭ����ͬ����=��ͬ���-��ͬ��δ�����ݽ��֮��
            SELECT NVL(SUM(S.SUMMARY_BAL), 0),
                   NVL(SUM(S.SUMMARY_AMT), 0)
            INTO V_CON_BAL, V_CON_AMT
            FROM TB_CRD_SUMMARY S
            WHERE S.CONTRACT_NUM = CON_LIST.CONTRACT_NUM
              AND S.SUMMARY_STATUS IN ('00', '156', '02', '03');
            /*  00 δ����  01����  02����  03��������  07����  08����  09Ʊ���û�  10�ʲ��û�  11��Ȩ�û�*/

            IF CON_LIST.IS_CYCLE = '1'
            THEN
                --ѭ�����
                V_CON_USED := V_CON_BAL;
            ELSE
                V_CON_USED := V_CON_AMT;
            END IF;

            --���º�ͬ����/���ö��
            UPDATE TB_CRD_CONTRACT T
            SET T.CONTRACT_USED=V_CON_USED,
                T.CONTRACT_AVI = T.CONTRACT_AMT - V_CON_USED,
                T.CONTRACT_BAL = V_CON_BAL,
                T.UPDATE_TIME  = V_WORK_TIME
            WHERE T.CONTRACT_NUM = CON_LIST.CONTRACT_NUM;
        END LOOP;

    --���������ü���
    FOR APPROVE_LIST in (SELECT nvl(t.DEPOSIT_RATIO, 0) DEPOSIT_RATIO,
                               T.APPROVE_ID,
                               T.IS_CYCLE,
                               A.LIMIT_USED_TYPE, --��Ʒ���ռ�÷�ʽ��CD000179��1��ͬռ�� 2�ſ�ռ��
                               t.IS_LOW_RISK--�ͷ��ձ�ʶ
                        FROM TB_CRD_APPROVE T,
                             TB_PAR_PRODUCT A,
                             CHAIN_DEPT b
                        WHERE T.PRODUCT_NUM = A.PRODUCT_NUM
                          and b.ID = t.ORG_NUM
                          and t.PRODUCT_TYPE != '1000034'--���ֵĶ�Ȳ���Ҫ�ڴ˼��㣬���ʽ��ҵ���߼����д���
                          AND T.CUSTOMER_NUM = V_CUSTOMER_NUM)
        LOOP
            IF APPROVE_LIST.LIMIT_USED_TYPE = '1' THEN--��ͬռ�ö��
                IF APPROVE_LIST.IS_CYCLE = '1' THEN--���ѭ��
                    SELECT SUM(NVL(CONTRACT_AMT, 0)), CAST(SUM(NVL(CONTRACT_EXP, 0)) AS NUMBER(18, 2))
                    INTO V_APPROVE_USED,V_APPROVE_EXP_USED
                    FROM (
                             SELECT SUM(T.CONTRACT_AMT)                                 CONTRACT_AMT,
                                    SUM(T.CONTRACT_AMT * (100 - T.DEPOSIT_RATIO) / 100) CONTRACT_EXP
                             FROM TB_CRD_CONTRACT T
                             WHERE T.APPROVE_ID = APPROVE_LIST.APPROVE_ID
                               AND T.IS_CYCLE = '1'--��ͬѭ��
                               AND T.CONTRACT_STATUS IN ('0', '1', '2')
                             UNION ALL
                             SELECT SUM(T.CONTRACT_AVI + T.CONTRACT_BAL)                                   CONTRACT_AMT,
                                    SUM((T.CONTRACT_AVI + T.CONTRACT_BAL) * (100 - T.DEPOSIT_RATIO) / 100) CONTRACT_EXP
                             FROM TB_CRD_CONTRACT T
                             WHERE T.APPROVE_ID = APPROVE_LIST.APPROVE_ID
                               AND T.IS_CYCLE = '0'--��ͬ��ѭ��
                               AND T.CONTRACT_STATUS IN ('0', '1', '2')
                         ) S;
                ELSIF APPROVE_LIST.IS_CYCLE = '0' THEN--��Ȳ�ѭ��
                    SELECT SUM(T.CONTRACT_AMT)                                 CONTRACT_AMT,
                           SUM(T.CONTRACT_AMT * (100 - T.DEPOSIT_RATIO) / 100) CONTRACT_EXP
                    INTO V_APPROVE_USED,V_APPROVE_EXP_USED
                    FROM TB_CRD_CONTRACT T
                    WHERE T.APPROVE_ID = APPROVE_LIST.APPROVE_ID
                      --AND T.IS_CYCLE IN('1','0')--��ͬѭ��
                      AND T.CONTRACT_STATUS IN ('0', '1', '2', '4');
                END IF;
            ELSIF APPROVE_LIST.LIMIT_USED_TYPE = '2' THEN--�ſ�ռ��
                IF APPROVE_LIST.IS_CYCLE = '1' THEN--���ѭ��
                    SELECT SUM(SUMMARY_AMT), SUM(SUMMARY_EXP)
                    INTO V_APPROVE_USED,V_APPROVE_EXP_USED
                    FROM (
                             SELECT SUM(A.SUMMARY_AMT)                                 SUMMARY_AMT,
                                    SUM(A.SUMMARY_AMT * (100 - T.DEPOSIT_RATIO) / 100) SUMMARY_EXP
                             FROM TB_CRD_CONTRACT T,
                                  TB_CRD_SUMMARY A
                             WHERE T.CONTRACT_NUM = A.CUSTOMER_NUM
                               AND T.APPROVE_ID = APPROVE_LIST.APPROVE_ID
                               AND T.IS_CYCLE = '1'--��ͬѭ��
                               AND A.SUMMARY_STATUS IN ('02', '03', '04')
                             UNION ALL
                             SELECT SUM(A.SUMMARY_BAL)                                 SUMMARY_AMT,
                                    SUM(A.SUMMARY_BAL * (100 - T.DEPOSIT_RATIO) / 100) SUMMARY_EXP
                             FROM TB_CRD_CONTRACT T,
                                  TB_CRD_SUMMARY A
                             WHERE T.CONTRACT_NUM = A.CUSTOMER_NUM
                               AND T.APPROVE_ID = APPROVE_LIST.APPROVE_ID
                               AND T.IS_CYCLE = '0'--��ͬ��ѭ��
                               AND A.SUMMARY_STATUS IN ('02', '03')
                         ) S;
                ELSIF APPROVE_LIST.IS_CYCLE = '0' THEN--��Ȳ�ѭ��
                    SELECT SUM(A.SUMMARY_AMT)                                 CONTRACT_AMT,
                           SUM(A.SUMMARY_AMT * (100 - T.DEPOSIT_RATIO) / 100) CONTRACT_EXP
                    INTO V_APPROVE_USED,V_APPROVE_EXP_USED
                    FROM TB_CRD_CONTRACT T,
                         TB_CRD_SUMMARY A
                    WHERE T.CONTRACT_NUM = A.CUSTOMER_NUM
                      AND T.APPROVE_ID = APPROVE_LIST.APPROVE_ID
                      AND T.IS_CYCLE IN ('1', '0')--��ͬѭ������ѭ��
                      AND T.CONTRACT_STATUS IN ('0', '1', '2', '4');
                END IF;
            END IF;

            --��ѯԤռ�õĶ��
            SELECT SUM(NVL(T.CONTRACT_AMT, 0)),
                   SUM(NVL(T.CONTRACT_AMT * (100 - T.DEPOSIT_RATIO) / 100, 0))
            INTO V_APPROVE_PRE_AMT,V_APPROVE_PRE_EXP
            FROM TB_CRD_CONTRACT T
            WHERE T.APPROVE_ID = APPROVE_LIST.APPROVE_ID
              AND T.CONTRACT_STATUS IN ('0');--�����еĺ�ͬ

            V_APPROVE_USED := NVL(V_APPROVE_USED, 0);
            V_APPROVE_EXP_USED := NVL(V_APPROVE_EXP_USED, 0);
            V_APPROVE_PRE_AMT := NVL(V_APPROVE_PRE_AMT, 0);
            V_APPROVE_PRE_EXP := NVL(V_APPROVE_PRE_EXP, 0);

            UPDATE TB_CRD_APPROVE T
            SET T.APPROVE_USED     = V_APPROVE_USED,                         --���Ŷ������
                T.APPROVE_AVI      = T.APPROVE_AMT - V_APPROVE_USED,         --���Ŷ�ȿ���
                T.APPROVE_EXP_USED = V_APPROVE_EXP_USED,                     --��������
                T.APPROVE_EXP_AVI  = T.APPROVE_EXP_AMT - V_APPROVE_EXP_USED, --���ڿ���
                T.APPROVE_PRE_AMT  = V_APPROVE_PRE_AMT,                      --Ԥռ�ö��
                T.APPROVE_PRE_EXP  = V_APPROVE_PRE_EXP,                      --Ԥռ�ó���
                t.DEPOSIT_RATIO=APPROVE_LIST.DEPOSIT_RATIO,--��֤�����
                T.UPDATE_TIME      = V_WORK_TIME
            WHERE T.APPROVE_ID = APPROVE_LIST.APPROVE_ID;
        END loop;


    --���¶���������
    for crd_detail_list IN (
        SELECT T.CRD_DETAIL_PRD,
               T.CUSTOMER_NUM,
               A.CORP_ORG_CODE
        FROM TB_CRD_APPROVE T,
             CHAIN_DEPT A
        WHERE T.ORG_NUM = A.ID
          AND T.CUSTOMER_NUM = V_CUSTOMER_NUM
        GROUP BY T.CUSTOMER_NUM,
                 A.CORP_ORG_CODE,
                 T.CRD_DETAIL_PRD
    )
        LOOP
            V_CRD_DETAIL_NUM := null;

            --��ѯ���еĶ�ȱ��
            select distinct t.CRD_DETAIL_NUM
            into V_CRD_DETAIL_NUM
            from TB_CRD_DETAIL t
            where t.CUSTOMER_NUM = crd_detail_list.CUSTOMER_NUM
              and t.CRD_DETAIL_PRD = crd_detail_list.CRD_DETAIL_PRD
              and t.ORG_NUM = crd_detail_list.CORP_ORG_CODE;

            --�����û������3����ȱ�ţ���������
            if (V_CRD_DETAIL_NUM is null or V_CRD_DETAIL_NUM = '') then
                V_CRD_DETAIL_NUM := FNC_GET_BIZ_NUM('ED3');
            end if;

            update TB_CRD_APPROVE t
            set t.CRD_DETAIL_NUM=V_CRD_DETAIL_NUM,
                t.UPDATE_TIME=V_WORK_TIME
            where t.CUSTOMER_NUM = crd_detail_list.CUSTOMER_NUM
              and t.CRD_DETAIL_PRD = crd_detail_list.CRD_DETAIL_PRD
              and exists(select 1
                         from CHAIN_DEPT a
                         where a.ID = t.ORG_NUM
                           and a.CORP_ORG_CODE = crd_detail_list.CORP_ORG_CODE);
        end LOOP;

    --���¶�ȶ������
    for crd_main_list IN (
        SELECT t.CRD_MAIN_PRD,
               T.CUSTOMER_NUM,
               A.CORP_ORG_CODE
        FROM TB_CRD_APPROVE T,
             CHAIN_DEPT A
        WHERE T.ORG_NUM = A.ID
          AND T.CUSTOMER_NUM = V_CUSTOMER_NUM
        GROUP BY T.CUSTOMER_NUM,
                 A.CORP_ORG_CODE,
                 t.CRD_MAIN_PRD
    )
        LOOP
            V_CRD_MAIN_NUM := null;

            select t.CRD_MAIN_NUM
            into V_CRD_MAIN_NUM
            from TB_CRD_MAIN t
            where t.CUSTOMER_NUM = crd_main_list.CUSTOMER_NUM
              and t.CRD_MAIN_PRD = crd_main_list.CRD_MAIN_PRD
              and t.ORG_NUM = crd_main_list.CORP_ORG_CODE;

            if (V_CRD_MAIN_NUM is null or V_CRD_MAIN_NUM = '') then
                V_CRD_MAIN_NUM := CLM.FNC_GET_BIZ_NUM('EDM3');
            end if;

            update TB_CRD_APPROVE t
            set t.CRD_MAIN_NUM=V_CRD_MAIN_NUM,
                t.UPDATE_TIME=V_WORK_TIME
            where t.CUSTOMER_NUM = crd_main_list.CUSTOMER_NUM
              and t.CRD_MAIN_PRD = crd_main_list.CRD_MAIN_PRD
              and exists(select 1
                         from CHAIN_DEPT a
                         where a.ID = t.ORG_NUM
                           and a.CORP_ORG_CODE = crd_main_list.CORP_ORG_CODE);
        end LOOP;

    --ɾ��û�й��������������Ŷ����Ϣ
    DELETE
    FROM TB_CRD_DETAIL T
    WHERE T.TRAN_SYSTEM = '0007'
      AND T.CUSTOMER_NUM = V_CUSTOMER_NUM
      AND t.CRD_PRODUCT_TYPE = '1'--���Ŷ��
      AND NOT EXISTS(
            SELECT 1 FROM TB_CRD_APPROVE A WHERE A.CRD_DETAIL_NUM = T.CRD_DETAIL_NUM AND A.APPROVE_STATUS = '2'--��Ч����
        );

    --���¶����ϸ���ȣ�TB_CRD_DETAIL��
    MERGE INTO TB_CRD_DETAIL TA
    USING (SELECT T.CRD_MAIN_NUM,
                  T.CRD_DETAIL_NUM,
                  T.CRD_DETAIL_PRD,
                  T.CUSTOMER_NUM,
                  SUM(T.APPROVE_AMT)      LIMIT_CREDIT,
                  SUM(T.APPROVE_USED)     LIMIT_USED,
                  SUM(T.APPROVE_AVI)      LIMIT_AVI,
                  SUM(T.APPROVE_EXP_AMT)  EXP_CREDIT,
                  SUM(T.APPROVE_EXP_USED) EXP_USED,
                  SUM(T.APPROVE_EXP_AVI)  EXP_AVI,
                  SUM(T.APPROVE_PRE_AMT)  LIMIT_PRE,
                  SUM(T.APPROVE_PRE_EXP)  EXP_PRE,
                  A.CORP_ORG_CODE
           FROM TB_CRD_APPROVE T,
                CHAIN_DEPT A
           WHERE T.ORG_NUM = A.ID
             AND T.APPROVE_STATUS = '2'--��Ч
             AND T.CUSTOMER_NUM = V_CUSTOMER_NUM
           GROUP BY T.CUSTOMER_NUM,
                    A.CORP_ORG_CODE,
                    T.CRD_DETAIL_PRD,
                    T.CRD_DETAIL_NUM, T.CRD_MAIN_NUM) S
    ON (
        S.CRD_DETAIL_NUM = ta.CRD_DETAIL_NUM
        )
    WHEN NOT MATCHED
        THEN
        INSERT (CRD_MAIN_NUM,--������ȱ��
                CRD_DETAIL_NUM, --������ȱ��
                CRD_DETAIL_PRD, --�������Ʒ��
                CUSTOMER_NUM, --ECIF�ͻ����
                CURRENCY_CD, --����
                EXCHANGE_RATE, --����
                LIMIT_CREDIT, --���Ŷ��
                LIMIT_USED, --���Ŷ������
                LIMIT_AVI, --���Ŷ�ȿ���
                EXP_CREDIT, --���ų���
                EXP_USED, --��������
                EXP_AVI, --���ڿ���
                LIMIT_PRE, ---Ԥռ�ö��
                EXP_PRE, --Ԥռ�ó���
                CREATE_TIME, --��������
                UPDATE_TIME, --��������
                CRD_GRANT_ORG_NUM,--���Ż���
                ORG_NUM, --�������
                TRAN_SYSTEM,--����ϵͳ
                CRD_PRODUCT_TYPE--�������
        )
        VALUES (S.CRD_MAIN_NUM,
                S.CRD_DETAIL_NUM,
                S.CRD_DETAIL_PRD,
                S.CUSTOMER_NUM,
                'CNY',
                '1',
                S.LIMIT_CREDIT,
                S.LIMIT_USED,
                S.LIMIT_AVI,
                S.EXP_CREDIT,
                S.EXP_AVI,
                S.EXP_USED,
                S.LIMIT_PRE,
                S.EXP_PRE,
                V_WORK_TIME,
                V_WORK_TIME,
                S.CORP_ORG_CODE,
                S.CORP_ORG_CODE,
                '0007', '1')
    WHEN MATCHED
        THEN
        UPDATE
        SET TA.CRD_MAIN_NUM=S.CRD_MAIN_NUM,--������ȱ��
            TA.CRD_DETAIL_PRD=S.CRD_DETAIL_PRD,--�������Ʒ��
            TA.LIMIT_CREDIT = S.LIMIT_CREDIT, --���Ŷ��
            TA.LIMIT_USED = S.LIMIT_USED, --���Ŷ������
            TA.LIMIT_AVI = S.LIMIT_AVI, --���Ŷ�ȿ���
            TA.EXP_CREDIT = S.EXP_CREDIT, --���ų���
            TA.EXP_USED = S.EXP_USED, --��������
            TA.EXP_AVI = S.EXP_AVI, --���ڿ���
            TA.LIMIT_PRE = S.LIMIT_PRE, ---Ԥռ�ö��
            TA.EXP_PRE = S.LIMIT_PRE, --Ԥռ�ó���
            TA.CRD_GRANT_ORG_NUM=S.CORP_ORG_CODE,--�������
            TA.ORG_NUM = S.CORP_ORG_CODE, --�������
            TA.UPDATE_TIME = V_WORK_TIME;
    --��������

    --
    DELETE
    FROM TB_CRD_MAIN T
    WHERE T.TRAN_SYSTEM = '0007'
      AND T.CUSTOMER_NUM = V_CUSTOMER_NUM
      AND t.CRD_PRODUCT_TYPE = '1'--���Ŷ��
      AND NOT EXISTS(
            SELECT 1 FROM TB_CRD_APPROVE A WHERE A.CRD_MAIN_NUM = T.CRD_MAIN_NUM AND A.APPROVE_STATUS = '2'--��Ч����
        );

    --���¶������
    MERGE INTO TB_CRD_MAIN TA
    USING (SELECT T.CRD_MAIN_NUM,
                  T.CRD_MAIN_PRD,
                  T.CUSTOMER_NUM,
                  SUM(T.APPROVE_AMT)      LIMIT_CREDIT,
                  SUM(T.APPROVE_USED)     LIMIT_USED,
                  SUM(T.APPROVE_AVI)      LIMIT_AVI,
                  SUM(T.APPROVE_EXP_AMT)  EXP_CREDIT,
                  SUM(T.APPROVE_EXP_USED) EXP_USED,
                  SUM(T.APPROVE_EXP_AVI)  EXP_AVI,
                  SUM(T.APPROVE_PRE_AMT)  LIMIT_PRE,
                  SUM(T.APPROVE_PRE_EXP)  EXP_PRE,
                  A.CORP_ORG_CODE
           FROM TB_CRD_APPROVE T,
                CHAIN_DEPT A
           WHERE T.ORG_NUM = A.ID
             AND T.APPROVE_STATUS = '2'--��Ч
             AND T.CUSTOMER_NUM = V_CUSTOMER_NUM
           GROUP BY T.CUSTOMER_NUM,
                    A.CORP_ORG_CODE,
                    T.CRD_MAIN_NUM,
                    T.CRD_MAIN_PRD) S
    ON (
        S.CRD_MAIN_NUM = TA.CRD_MAIN_NUM
        )
    WHEN NOT MATCHED
        THEN
        INSERT (CRD_MAIN_NUM,--������ȱ��
                CRD_MAIN_PRD, --�������Ʒ��
                CUSTOMER_NUM, --ECIF�ͻ����
                CURRENCY_CD, --����
                EXCHANGE_RATE, --����
                LIMIT_CREDIT, --���Ŷ��
                LIMIT_USED, --���Ŷ������
                LIMIT_AVI, --���Ŷ�ȿ���
                EXP_CREDIT, --���ų���
                EXP_USED, --��������
                EXP_AVI, --���ڿ���
                LIMIT_PRE, ---Ԥռ�ö��
                EXP_PRE, --Ԥռ�ó���
                CREATE_TIME, --��������
                UPDATE_TIME, --��������
                CRD_GRANT_ORG_NUM,--���Ż���
                ORG_NUM,--�������
                TRAN_SYSTEM,--����ϵͳ
                CRD_PRODUCT_TYPE--�������
        )
        VALUES (S.CRD_MAIN_NUM,
                S.CRD_MAIN_PRD,
                S.CUSTOMER_NUM,
                'CNY',
                '1',
                S.LIMIT_CREDIT,
                S.LIMIT_USED,
                S.LIMIT_AVI,
                S.EXP_CREDIT,
                S.EXP_AVI,
                S.EXP_USED,
                S.LIMIT_PRE,
                S.EXP_PRE,
                V_WORK_TIME,
                V_WORK_TIME,
                S.CORP_ORG_CODE,
                S.CORP_ORG_CODE, '0007', '1')
    WHEN MATCHED
        THEN
        UPDATE
        SET TA.CRD_MAIN_PRD=S.CRD_MAIN_PRD,
            TA.LIMIT_CREDIT = S.LIMIT_CREDIT,    --���Ŷ��
            TA.LIMIT_USED = S.LIMIT_USED,        --���Ŷ������
            TA.LIMIT_AVI = S.LIMIT_AVI,          --���Ŷ�ȿ���
            TA.EXP_CREDIT = S.EXP_CREDIT,        --���ų���
            TA.EXP_USED = S.EXP_USED,            --��������
            TA.EXP_AVI = S.EXP_AVI,              --���ڿ���
            TA.LIMIT_PRE = S.LIMIT_PRE,          ---Ԥռ�ö��
            TA.EXP_PRE = S.LIMIT_PRE,            --Ԥռ�ó���
            TA.CRD_GRANT_ORG_NUM=S.CORP_ORG_CODE,--�������
            TA.ORG_NUM = S.CORP_ORG_CODE,        --�������
            TA.UPDATE_TIME = V_WORK_TIME; --��������
END;
/

prompt
prompt Creating procedure PRC_CREDIT_STATIS
prompt ====================================
prompt
CREATE OR REPLACE PROCEDURE CLM.PRC_CREDIT_STATIS IS

  V_WORK_TIME DATE; --Ӫҵʱ��


BEGIN

    /**
      ͳ��ʵʱ�����Ϣ
     */

    V_WORK_TIME := FNC_GET_BUSI_TIME();

    --���ͳ�Ʊ�-���Ʒ�֣���ʷ+ʵʱ��
    delete from TB_CRD_STATIS_CRDPT t where t.DATA_TYPE = '1';--ɾ��ʵʱ���ݣ������²���
    insert into TB_CRD_STATIS_CRDPT(STATIS_ID,
                                    APPROVE_COUNT, APPROVE_EXP_AMOUNT, CREDIT_EXP_BALANCE, LOAN_EXP_BALANCE,
                                    LIMIT_CREDIT, LIMIT_AVI, LIMIT_USED, EXP_USED, EXP_AVI, CRD_DETAIL_PRD,
                                    ORG_NUM, DATA_TYPE, CREATE_TIME, UPDATE_TIME)
    select FNC_GET_UUID('TJ')    STATIS_ID,
           sum(t.APPROVE_COUNT)      APPROVE_COUNT,--��������
           sum(t.APPROVE_EXP_AMOUNT) APPROVE_EXP_AMOUNT,--�������ڽ��
           sum(t.APPROVE_EXP_AMOUNT) CREDIT_EXP_BALANCE,--���ų������
           sum(t.LOAN_EXP_BALANCE)   LOAN_EXP_BALANCE,--��������
           sum(t.LIMIT_CREDIT)       LIMIT_CREDIT,--���Ŷ��
           sum(t.LIMIT_AVI)          LIMIT_AVI,--���Ŷ�ȿ���
           sum(t.LIMIT_USED)         LIMIT_USED,--���Ŷ������
           sum(t.EXP_USED)           EXP_USED,--��������
           sum(t.EXP_AVI)            EXP_AVI,--���ڿ���
           t.CRD_DETAIL_PRD,
           t.ORG_NUM,
           '1',--ʵʱ����
           V_WORK_TIME               CREATE_TIME,
           V_WORK_TIME               UPDATE_TIME
    from TB_CRD_STATIS t
    group by t.ORG_NUM, t.CRD_DETAIL_PRD;


    --���ͳ�Ʊ�-��ҵ��ģ����ʷ+ʵʱ��
    delete from TB_CRD_STATIS_USCALE t where t.DATA_TYPE = '1';--ɾ��ʵʱ���ݣ������²���
    insert into TB_CRD_STATIS_USCALE(STATIS_ID,
                                     APPROVE_COUNT, APPROVE_EXP_AMOUNT, CREDIT_EXP_BALANCE, LOAN_EXP_BALANCE,
                                     LIMIT_CREDIT, LIMIT_AVI, LIMIT_USED, EXP_USED, EXP_AVI, UNIT_SCALE,
                                     ORG_NUM, DATA_TYPE, CREATE_TIME, UPDATE_TIME)
    select FNC_GET_UUID('TJ')    STATIS_ID,
           sum(t.APPROVE_COUNT)      APPROVE_COUNT,--��������
           sum(t.APPROVE_EXP_AMOUNT) APPROVE_EXP_AMOUNT,--�������ڽ��
           sum(t.APPROVE_EXP_AMOUNT) CREDIT_EXP_BALANCE,--���ų������
           sum(t.LOAN_EXP_BALANCE)   LOAN_EXP_BALANCE,--��������
           sum(t.LIMIT_CREDIT)       LIMIT_CREDIT,--���Ŷ��
           sum(t.LIMIT_AVI)          LIMIT_AVI,--���Ŷ�ȿ���
           sum(t.LIMIT_USED)         LIMIT_USED,--���Ŷ������
           sum(t.EXP_USED)           EXP_USED,--��������
           sum(t.EXP_AVI)            EXP_AVI,--���ڿ���
           t.UNIT_SCALE,--��ҵ��ģ
           t.ORG_NUM,
           '1',--ʵʱ����
           V_WORK_TIME               CREATE_TIME,
           V_WORK_TIME               UPDATE_TIME
    from TB_CRD_STATIS t
    where t.UNIT_SCALE is not null
    group by t.ORG_NUM, t.UNIT_SCALE;

    --���ͳ�Ʊ�-�ͻ����ͣ���ʷ+ʵʱ��
    delete from tb_crd_statis_custype t where t.DATA_TYPE = '1';--ɾ��ʵʱ���ݣ������²���
    insert into tb_crd_statis_custype(STATIS_ID,
                                      APPROVE_COUNT, APPROVE_EXP_AMOUNT, CREDIT_EXP_BALANCE, LOAN_EXP_BALANCE,
                                      LIMIT_CREDIT, LIMIT_AVI, LIMIT_USED, EXP_USED, EXP_AVI, CUSTOMER_TYPE,
                                      ORG_NUM, DATA_TYPE, CREATE_TIME, UPDATE_TIME)
    select FNC_GET_UUID('TJ')    STATIS_ID,
           sum(t.APPROVE_COUNT)      APPROVE_COUNT,--��������
           sum(t.APPROVE_EXP_AMOUNT) APPROVE_EXP_AMOUNT,--�������ڽ��
           sum(t.APPROVE_EXP_AMOUNT) CREDIT_EXP_BALANCE,--���ų������
           sum(t.LOAN_EXP_BALANCE)   LOAN_EXP_BALANCE,--��������
           sum(t.LIMIT_CREDIT)       LIMIT_CREDIT,--���Ŷ��
           sum(t.LIMIT_AVI)          LIMIT_AVI,--���Ŷ�ȿ���
           sum(t.LIMIT_USED)         LIMIT_USED,--���Ŷ������
           sum(t.EXP_USED)           EXP_USED,--��������
           sum(t.EXP_AVI)            EXP_AVI,--���ڿ���
           t.CUSTOMER_TYPE,--�ͻ�����
           t.ORG_NUM,
           '1',--ʵʱ����
           V_WORK_TIME               CREATE_TIME,
           V_WORK_TIME               UPDATE_TIME
    from TB_CRD_STATIS t
    group by t.ORG_NUM, t.CUSTOMER_TYPE;

    --���ͳ�Ʊ�-���ſͻ����ͣ���ʷ+ʵʱ��
    insert into tb_crd_statis_custype(STATIS_ID,
                                      APPROVE_COUNT, APPROVE_EXP_AMOUNT, CREDIT_EXP_BALANCE, LOAN_EXP_BALANCE,
                                      LIMIT_CREDIT, LIMIT_AVI, LIMIT_USED, EXP_USED, EXP_AVI, CUSTOMER_TYPE,
                                      ORG_NUM, DATA_TYPE, CREATE_TIME, UPDATE_TIME)
    select FNC_GET_UUID('TJ')    STATIS_ID,
           sum(t.APPROVE_COUNT)      APPROVE_COUNT,--��������
           sum(t.APPROVE_EXP_AMOUNT) APPROVE_EXP_AMOUNT,--�������ڽ��
           sum(t.APPROVE_EXP_AMOUNT) CREDIT_EXP_BALANCE,--���ų������
           sum(t.LOAN_EXP_BALANCE)   LOAN_EXP_BALANCE,--��������
           sum(t.LIMIT_CREDIT)       LIMIT_CREDIT,--���Ŷ��
           sum(t.LIMIT_AVI)          LIMIT_AVI,--���Ŷ�ȿ���
           sum(t.LIMIT_USED)         LIMIT_USED,--���Ŷ������
           sum(t.EXP_USED)           EXP_USED,--��������
           sum(t.EXP_AVI)            EXP_AVI,--���ڿ���
           '4',--�ͻ�����
           t.ORG_NUM,
           '1',--ʵʱ����
           V_WORK_TIME               CREATE_TIME,
           V_WORK_TIME               UPDATE_TIME
    from TB_CRD_STATIS t,
         TB_CSM_GROUP_MEMBER a
    where a.MEMBER_CUSTOMER_NUM = t.CUSTOMER_NUM
    group by t.ORG_NUM, a.CUSTOMER_NUM;

    --���ͳ�Ʊ�-������ʽ����ʷ+ʵʱ��
    delete from TB_CRD_STATIS_GTYPE t where t.DATA_TYPE = '1';--ɾ��ʵʱ���ݣ������²���
    insert into TB_CRD_STATIS_GTYPE(STATIS_ID,
                                    APPROVE_COUNT, APPROVE_EXP_AMOUNT, CREDIT_EXP_BALANCE, LOAN_EXP_BALANCE,
                                    LIMIT_CREDIT, LIMIT_AVI, LIMIT_USED, EXP_USED, EXP_AVI, GUARANTEE_TYPE,
                                    ORG_NUM, DATA_TYPE, CREATE_TIME, UPDATE_TIME)
    select FNC_GET_UUID('TJ')    STATIS_ID,
           sum(t.APPROVE_COUNT)      APPROVE_COUNT,--��������
           sum(t.APPROVE_EXP_AMOUNT) APPROVE_EXP_AMOUNT,--�������ڽ��
           sum(t.APPROVE_EXP_AMOUNT) CREDIT_EXP_BALANCE,--���ų������
           sum(t.LOAN_EXP_BALANCE)   LOAN_EXP_BALANCE,--��������
           sum(t.LIMIT_CREDIT)       LIMIT_CREDIT,--���Ŷ��
           sum(t.LIMIT_AVI)          LIMIT_AVI,--���Ŷ�ȿ���
           sum(t.LIMIT_USED)         LIMIT_USED,--���Ŷ������
           sum(t.EXP_USED)           EXP_USED,--��������
           sum(t.EXP_AVI)            EXP_AVI,--���ڿ���
           t.GUARANTEE_TYPE,--������ʽ
           t.ORG_NUM,
           '1',--ʵʱ����
           V_WORK_TIME               CREATE_TIME,
           V_WORK_TIME               UPDATE_TIME
    from TB_CRD_STATIS t
    group by t.ORG_NUM, t.GUARANTEE_TYPE;


    --���ͳ�Ʊ�-��ҵ����ʷ+ʵʱ��
    delete from TB_CRD_STATIS_INDUSTRY t where t.DATA_TYPE = '1';--ɾ��ʵʱ���ݣ������²���
    insert into TB_CRD_STATIS_INDUSTRY(STATIS_ID,
                                       APPROVE_COUNT, APPROVE_EXP_AMOUNT, CREDIT_EXP_BALANCE, LOAN_EXP_BALANCE,
                                       LIMIT_CREDIT, LIMIT_AVI, LIMIT_USED, EXP_USED, EXP_AVI, INDUSTRY,
                                       ORG_NUM, DATA_TYPE, CREATE_TIME, UPDATE_TIME)
    select FNC_GET_UUID('TJ')    STATIS_ID,
           sum(t.APPROVE_COUNT)      APPROVE_COUNT,--��������
           sum(t.APPROVE_EXP_AMOUNT) APPROVE_EXP_AMOUNT,--�������ڽ��
           sum(t.APPROVE_EXP_AMOUNT) CREDIT_EXP_BALANCE,--���ų������
           sum(t.LOAN_EXP_BALANCE)   LOAN_EXP_BALANCE,--��������
           sum(t.LIMIT_CREDIT)       LIMIT_CREDIT,--���Ŷ��
           sum(t.LIMIT_AVI)          LIMIT_AVI,--���Ŷ�ȿ���
           sum(t.LIMIT_USED)         LIMIT_USED,--���Ŷ������
           sum(t.EXP_USED)           EXP_USED,--��������
           sum(t.EXP_AVI)            EXP_AVI,--���ڿ���
           t.INDUSTRY_MAIN           INDUSTRY,--��ҵ
           t.ORG_NUM,
           '1',--ʵʱ����
           V_WORK_TIME               CREATE_TIME,
           V_WORK_TIME               UPDATE_TIME
    from (
             select a.*, substr(a.INDUSTRY, 1, 1) INDUSTRY_MAIN from TB_CRD_STATIS a
         ) t
    group by t.ORG_NUM, t.INDUSTRY_MAIN;


    --���ͳ�Ʊ�-ҵ��Ʒ�֣���ʷ+ʵʱ��
    delete from TB_CRD_STATIS_PRODUCT t where t.DATA_TYPE = '1';--ɾ��ʵʱ���ݣ������²���
    insert into TB_CRD_STATIS_PRODUCT(STATIS_ID,
                                      APPROVE_COUNT, APPROVE_EXP_AMOUNT, CREDIT_EXP_BALANCE, LOAN_EXP_BALANCE,
                                      LIMIT_CREDIT, LIMIT_AVI, LIMIT_USED, EXP_USED, EXP_AVI, PRODUCT_NUM,
                                      ORG_NUM, DATA_TYPE, CREATE_TIME, UPDATE_TIME)
    select FNC_GET_UUID('TJ')    STATIS_ID,
           sum(t.APPROVE_COUNT)      APPROVE_COUNT,--��������
           sum(t.APPROVE_EXP_AMOUNT) APPROVE_EXP_AMOUNT,--�������ڽ��
           sum(t.APPROVE_EXP_AMOUNT) CREDIT_EXP_BALANCE,--���ų������
           sum(t.LOAN_EXP_BALANCE)   LOAN_EXP_BALANCE,--��������
           sum(t.LIMIT_CREDIT)       LIMIT_CREDIT,--���Ŷ��
           sum(t.LIMIT_AVI)          LIMIT_AVI,--���Ŷ�ȿ���
           sum(t.LIMIT_USED)         LIMIT_USED,--���Ŷ������
           sum(t.EXP_USED)           EXP_USED,--��������
           sum(t.EXP_AVI)            EXP_AVI,--���ڿ���
           t.PRODUCT_NUM,--ҵ��Ʒ��
           t.ORG_NUM,
           '1',--ʵʱ����
           V_WORK_TIME               CREATE_TIME,
           V_WORK_TIME               UPDATE_TIME
    from TB_CRD_STATIS t
    group by t.ORG_NUM, t.PRODUCT_NUM;

    --���ͳ�Ʊ�-��������ʷ+ʵʱ��
    delete from TB_CRD_STATIS_ORG t where t.DATA_TYPE = '1';--ɾ��ʵʱ���ݣ������²���
    insert into TB_CRD_STATIS_ORG(STATIS_ID, APPROVE_EXP_AMOUNT, CREDIT_EXP_BALANCE, LOAN_EXP_BALANCE,
                                  LIMIT_CREDIT, LIMIT_AVI, LIMIT_USED, EXP_USED, EXP_AVI, ORG_NUM,
                                  corporation_count, individual_count, bank_count, DATA_TYPE, CREATE_TIME, UPDATE_TIME)
    select FNC_GET_UUID('TJ')    STATIS_ID,
           sum(t.APPROVE_EXP_AMOUNT) APPROVE_EXP_AMOUNT,--�������ڽ��
           sum(t.APPROVE_EXP_AMOUNT) CREDIT_EXP_BALANCE,--���ų������
           sum(t.LOAN_EXP_BALANCE)   LOAN_EXP_BALANCE,--��������
           sum(t.LIMIT_CREDIT)       LIMIT_CREDIT,--���Ŷ��
           sum(t.LIMIT_AVI)          LIMIT_AVI,--���Ŷ�ȿ���
           sum(t.LIMIT_USED)         LIMIT_USED,--���Ŷ������
           sum(t.EXP_USED)           EXP_USED,--��������
           sum(t.EXP_AVI)            EXP_AVI,--���ڿ���
           t.ORG_NUM,
           0                         corporation_count,
           0                         individual_count,
           0                         bank_count,
           '1',--ʵʱ����
           V_WORK_TIME               CREATE_TIME,
           V_WORK_TIME               UPDATE_TIME
    from TB_CRD_STATIS t
    where t.ORG_NUM is not null
    group by t.ORG_NUM;

    for STATIS_ORG in (select b.ORG_NUM, a.CUSTOMER_TYPE, count(1) customer_count
                       from tb_csm_party a,
                            (
                                select t.ORG_NUM, t.CUSTOMER_NUM from TB_CRD_STATIS t group by t.ORG_NUM, t.CUSTOMER_NUM
                            ) b
                       where a.CUSTOMER_NUM = b.CUSTOMER_NUM
                       group by a.CUSTOMER_TYPE, b.ORG_NUM)
        loop
            if (STATIS_ORG.CUSTOMER_TYPE = '1') then--���˿ͻ�
                update TB_CRD_STATIS_ORG t
                set t.INDIVIDUAL_COUNT=STATIS_ORG.customer_count
                where t.ORG_NUM = STATIS_ORG.ORG_NUM;
            elsif
                (STATIS_ORG.CUSTOMER_TYPE = '2') then--��˾�ͻ�
                update TB_CRD_STATIS_ORG t
                set t.CORPORATION_COUNT=STATIS_ORG.customer_count
                where t.ORG_NUM = STATIS_ORG.ORG_NUM;
            elsif
                (STATIS_ORG.CUSTOMER_TYPE = '3') then--ͬҵ�ͻ�
                update TB_CRD_STATIS_ORG t
                set t.BANK_COUNT=STATIS_ORG.customer_count
                where t.ORG_NUM = STATIS_ORG.ORG_NUM;
            end if;
        end loop;


END;
/

prompt
prompt Creating procedure PRC_CREDIT_STATIS_CSM
prompt ========================================
prompt
CREATE OR REPLACE PROCEDURE CLM."PRC_CREDIT_STATIS_CSM"(V_CUSTOMER_NUM IN VARCHAR) IS

     v_approve_count NUMBER(18, 2) DEFAULT 0; --��������
     v_approve_exp_amount NUMBER(18, 2) DEFAULT 0; --�������ڽ��
     v_credit_exp_balance NUMBER(18, 2) DEFAULT 0;--���ų������
     v_loan_exp_balance NUMBER(18, 2) DEFAULT 0;--��������
     limit_credit NUMBER(18, 2) DEFAULT 0;--���Ŷ��
     limit_avi NUMBER(18, 2) DEFAULT 0;--���ö��
     limit_used NUMBER(18, 2) DEFAULT 0;--���ö��
     exp_used NUMBER(18, 2) DEFAULT 0;--���ó���
     exp_avi NUMBER(18, 2) DEFAULT 0;--���ó���

     V_WORK_TIME DATE; --Ӫҵʱ��

BEGIN
    /**
        ͳ��ʵʱ�����Ϣ
    */

    V_WORK_TIME := FNC_GET_BUSI_TIME();

    --ͳ�ƶ�Ȼ��ܱ�
    delete from TB_CRD_SUM t where t.CUSTOMER_NUM = V_CUSTOMER_NUM;
    merge into TB_CRD_SUM ta
    using (
        select t.CUSTOMER_NUM,
               t.ORG_NUM,
               a.CRD_PRODUCT_TYPE,--�������
               sum(t.limit_credit) limit_credit,--���Ŷ��
               sum(t.limit_used)   limit_used,--���ö��
               sum(t.limit_avi)    limit_avi,--���ö��
               sum(t.exp_credit)   exp_credit,--���ų���
               sum(t.exp_used)     exp_used,--���ó���
               sum(t.exp_avi)      exp_avi,--���ó���
               sum(t.limit_pre)    limit_pre,--Ԥռ�ö��
               sum(t.exp_pre)      exp_pre,--Ԥռ�ó���
               sum(t.limit_frozen) limit_frozen,--������
               sum(t.EXP_FROZEN)   exp_frozen--���᳨��
        from TB_CRD_DETAIL t,
             TB_PAR_CRD a
        where t.CRD_DETAIL_PRD = a.CRD_PRODUCT_NUM
          and t.CUSTOMER_NUM = V_CUSTOMER_NUM
        group by t.CUSTOMER_NUM, t.ORG_NUM, a.CRD_PRODUCT_TYPE
    ) s
    on (s.ORG_NUM = ta.ORG_NUM
        and s.CUSTOMER_NUM = ta.CUSTOMER_NUM
        and s.CRD_PRODUCT_TYPE = ta.CRD_PRODUCT_TYPE)
    when not matched then
        insert
        (STATIS_ID, CUSTOMER_NUM, CRD_PRODUCT_TYPE, CURRENCY_CD,
         LIMIT_CREDIT, LIMIT_USED, LIMIT_AVI,
         EXP_CREDIT, EXP_USED, EXP_AVI,
         LIMIT_PRE, EXP_PRE, LIMIT_FROZEN, exp_frozen,
         ORG_NUM, CREATE_TIME, UPDATE_TIME)
        values (FNC_GET_UUID('TJ'), s.CUSTOMER_NUM, s.CRD_PRODUCT_TYPE, '156',
                s.LIMIT_CREDIT, s.LIMIT_USED, s.LIMIT_AVI,
                s.EXP_CREDIT, s.EXP_USED, s.EXP_AVI,
                s.LIMIT_PRE, s.EXP_PRE, s.LIMIT_FROZEN, s.exp_frozen,
                s.ORG_NUM, V_WORK_TIME, V_WORK_TIME)
    when matched then
        update
        set ta.CURRENCY_CD='156',
            ta.LIMIT_CREDIT=s.limit_credit,
            ta.LIMIT_USED=s.LIMIT_USED,
            ta.LIMIT_AVI=s.LIMIT_AVI,
            ta.EXP_CREDIT=s.exp_credit,
            ta.EXP_USED=s.EXP_USED,
            ta.EXP_AVI=s.exp_avi,
            ta.LIMIT_PRE=s.limit_pre,
            ta.EXP_PRE=s.exp_pre,
            ta.LIMIT_FROZEN=s.limit_frozen,
            ta.exp_frozen=s.exp_frozen,
            ta.ORG_NUM=s.ORG_NUM,
            ta.UPDATE_TIME=V_WORK_TIME;


    --ͳ�ƶ�����ݵ����ͳ�Ʊ����ݶ��Ʒ�֡�ҵ��Ʒ�֡���������ҵ���ͻ����͡�������ʽ����ҵ��ģ����
    --��ɾ�����е�ͳ����Ϣ
    delete from tb_crd_statis t where t.CUSTOMER_NUM = V_CUSTOMER_NUM;

    --�����ͻ�ͳ������
    insert into TB_CRD_STATIS(STATIS_ID, CUSTOMER_NUM, CURRENCY_CD,
                              APPROVE_COUNT, APPROVE_EXP_AMOUNT, CREDIT_EXP_BALANCE, LOAN_EXP_BALANCE, LIMIT_CREDIT,
                              LIMIT_AVI, LIMIT_USED, EXP_USED, EXP_AVI,
                              CRD_DETAIL_PRD, PRODUCT_NUM, ORG_NUM, INDUSTRY, CUSTOMER_TYPE, GUARANTEE_TYPE,
                              UNIT_SCALE,
                              CREATE_TIME, UPDATE_TIME)
    select FNC_GET_UUID('TJ')  STATIS_ID,
           t.CUSTOMER_NUM,
           '156'                    CURRENCY_CD,
           count(1)                APPROVE_COUNT,--��������
           sum(t.APPROVE_EXP_AMT)  APPROVE_EXP_AMOUNT,--�������ڽ��
           0                       CREDIT_EXP_BALANCE,--���ų������
           0                       LOAN_EXP_BALANCE,--��������
           sum(t.APPROVE_AMT)      LIMIT_CREDIT,--���Ŷ��
           sum(t.APPROVE_AVI)      LIMIT_AVI,--���ö��
           sum(t.APPROVE_USED)     LIMIT_USED,--���ö��
           sum(t.APPROVE_EXP_USED) EXP_USED,--���ó���
           sum(t.APPROVE_EXP_AVI)  EXP_AVI,--���ó���
           t.CRD_DETAIL_PRD,--���Ʒ��
           t.PRODUCT_NUM,--ҵ��Ʒ��
           a.CORP_ORG_CODE         ORG_NUM,--������
           t.INDUSTRY,--��ҵ
           b.CUSTOMER_TYPE,--�ͻ�����
           t.MAIN_GUARANTEE_TYPE   GUARANTEE_TYPE,--������ʽ
           c.UNIT_SCALE,--��ҵ��ģ
           V_WORK_TIME             CREATE_TIME,
           V_WORK_TIME             UPDATE_TIME
    from TB_CRD_APPROVE t,
         CHAIN_DEPT a,
         TB_CSM_PARTY b
             left join TB_CSM_CORPORATION c on b.CUSTOMER_Num = c.CUSTOMER_NUM
    where t.ORG_NUM = a.ID
      and t.CUSTOMER_NUM = b.CUSTOMER_NUM
      and t.CUSTOMER_NUM = V_CUSTOMER_NUM
    group by t.CUSTOMER_NUM, t.CRD_DETAIL_PRD, t.PRODUCT_NUM, a.CORP_ORG_CODE, t.INDUSTRY, b.CUSTOMER_TYPE,
             t.MAIN_GUARANTEE_TYPE, c.UNIT_SCALE;


    --ͳ�����ų������
    merge into TB_CRD_STATIS ta
    using (select FNC_GET_UUID('TJ')                             STATIS_ID,
                  t.CUSTOMER_NUM,
                  '156'                                               CURRENCY_CD,
                  0                                                  APPROVE_COUNT,--��������
                  0                                                  APPROVE_EXP_AMOUNT,--�������ڽ��
                  sum(t.SUMMARY_BAL * (100 - t.DEPOSIT_RATIO) / 100) CREDIT_EXP_BALANCE,--���ų������,
                  0                                                  LOAN_EXP_BALANCE,--��������
                  0                                                  LIMIT_CREDIT,--���Ŷ��
                  0                                                  LIMIT_AVI,--���ö��
                  0                                                  LIMIT_USED,--���ö��
                  0                                                  EXP_USED,--���ó���
                  0                                                  EXP_AVI,--���ó���
                  tb.CRD_DETAIL_PRD,
                  t.PRODUCT_NUM,
                  a.CORP_ORG_CODE                                    ORG_NUM,
                  t.INDUSTRY,
                  b.CUSTOMER_TYPE,
                  t.MAIN_GUARANTEE_TYPE                              GUARANTEE_TYPE,
                  c.UNIT_SCALE,
                  V_WORK_TIME                                        CREATE_TIME,
                  V_WORK_TIME                                        UPDATE_TIME
           from TB_CRD_SUMMARY t,
                TB_CRD_APPROVE tb,
                TB_PAR_PRODUCT tc,
                CHAIN_DEPT a,
                TB_CSM_PARTY b
                    left join TB_CSM_CORPORATION c on b.CUSTOMER_Num = c.CUSTOMER_NUM
           where t.APPROVE_ID = tb.APPROVE_ID
             and t.PRODUCT_NUM = tc.PRODUCT_NUM
             and t.ORG_NUM = a.ID
             and tc.INOUT_TABLE = '2' --����
             and t.CUSTOMER_NUM = b.CUSTOMER_NUM
             and t.CUSTOMER_NUM = V_CUSTOMER_NUM
           group by t.CUSTOMER_NUM, tb.CRD_DETAIL_PRD, t.PRODUCT_NUM, a.CORP_ORG_CODE, t.INDUSTRY, b.CUSTOMER_TYPE,
                    t.MAIN_GUARANTEE_TYPE, c.UNIT_SCALE) s
    ON (S.CUSTOMER_NUM = TA.CUSTOMER_NUM
        and s.CRD_DETAIL_PRD = ta.CRD_DETAIL_PRD
        and s.PRODUCT_NUM = ta.PRODUCT_NUM
        and s.ORG_NUM = ta.ORG_NUM
        and s.INDUSTRY = ta.INDUSTRY
        and s.CUSTOMER_TYPE = ta.CUSTOMER_TYPE
        and s.GUARANTEE_TYPE = ta.GUARANTEE_TYPE
        and s.UNIT_SCALE = ta.UNIT_SCALE)
    when not matched then
        insert
        (STATIS_ID, CUSTOMER_NUM, CURRENCY_CD, APPROVE_COUNT,
         APPROVE_EXP_AMOUNT, CREDIT_EXP_BALANCE, LOAN_EXP_BALANCE, LIMIT_CREDIT,
         LIMIT_AVI, LIMIT_USED, EXP_USED, EXP_AVI,
         CRD_DETAIL_PRD, PRODUCT_NUM, ORG_NUM, INDUSTRY, CUSTOMER_TYPE, GUARANTEE_TYPE, UNIT_SCALE,
         CREATE_TIME, UPDATE_TIME)
        values (s.STATIS_ID, s.CUSTOMER_NUM, s.CURRENCY_CD, s.APPROVE_COUNT,
                s.APPROVE_EXP_AMOUNT, s.CREDIT_EXP_BALANCE, s.LOAN_EXP_BALANCE, s.LIMIT_CREDIT,
                s.LIMIT_AVI, s.LIMIT_USED, s.EXP_USED, s.EXP_AVI,
                s.CRD_DETAIL_PRD, s.PRODUCT_NUM, s.ORG_NUM, s.INDUSTRY, s.CUSTOMER_TYPE, s.GUARANTEE_TYPE,
                s.UNIT_SCALE,
                s.CREATE_TIME, s.UPDATE_TIME)
    when matched then
        update set ta.CREDIT_EXP_BALANCE=s.CREDIT_EXP_BALANCE, ta.UPDATE_TIME=V_WORK_TIME;


    --ͳ�ƴ�������
    merge into TB_CRD_STATIS ta
    using (select FNC_GET_UUID('TJ') STATIS_ID,
                  t.CUSTOMER_NUM,
                  '156'                   CURRENCY_CD,
                  0                      APPROVE_COUNT,--��������
                  0                      APPROVE_EXP_AMOUNT,--�������ڽ��
                  0                      CREDIT_EXP_BALANCE,--���ų������,
                  sum(t.SUMMARY_BAL)     LOAN_EXP_BALANCE,--��������
                  0                      LIMIT_CREDIT,--���Ŷ��
                  0                      LIMIT_AVI,--���ö��
                  0                      LIMIT_USED,--���ö��
                  0                      EXP_USED,--���ó���
                  0                      EXP_AVI,--���ó���
                  tb.CRD_DETAIL_PRD,
                  t.PRODUCT_NUM,
                  a.CORP_ORG_CODE        ORG_NUM,
                  t.INDUSTRY,
                  b.CUSTOMER_TYPE,
                  t.MAIN_GUARANTEE_TYPE  GUARANTEE_TYPE,
                  c.UNIT_SCALE,
                  V_WORK_TIME            CREATE_TIME,
                  V_WORK_TIME            UPDATE_TIME
           from TB_CRD_SUMMARY t,
                TB_CRD_APPROVE tb,
                TB_PAR_PRODUCT tc,
                CHAIN_DEPT a,
                TB_CSM_PARTY b
                    left join TB_CSM_CORPORATION c on b.CUSTOMER_Num = c.CUSTOMER_NUM
           where t.APPROVE_ID = tb.APPROVE_ID
             and t.PRODUCT_NUM = tc.PRODUCT_NUM
             and t.ORG_NUM = a.ID
             and tc.INOUT_TABLE = '1' --����
             and t.CUSTOMER_NUM = b.CUSTOMER_NUM
             and t.CUSTOMER_NUM = V_CUSTOMER_NUM
           group by t.CUSTOMER_NUM, tb.CRD_DETAIL_PRD, t.PRODUCT_NUM, a.CORP_ORG_CODE, t.INDUSTRY, b.CUSTOMER_TYPE,
                    t.MAIN_GUARANTEE_TYPE, c.UNIT_SCALE) s
    on (s.CUSTOMER_NUM = ta.CUSTOMER_NUM
        and s.CRD_DETAIL_PRD = ta.CRD_DETAIL_PRD
        and s.PRODUCT_NUM = ta.PRODUCT_NUM
        and s.ORG_NUM = ta.ORG_NUM
        and s.INDUSTRY = ta.INDUSTRY and s.CUSTOMER_TYPE = ta.CUSTOMER_TYPE
        and s.GUARANTEE_TYPE = ta.GUARANTEE_TYPE
        and s.UNIT_SCALE = ta.UNIT_SCALE)
    when not matched then
        insert
        (STATIS_ID, CUSTOMER_NUM, CURRENCY_CD, APPROVE_COUNT,
         APPROVE_EXP_AMOUNT, CREDIT_EXP_BALANCE, LOAN_EXP_BALANCE, LIMIT_CREDIT,
         LIMIT_AVI, LIMIT_USED, EXP_USED, EXP_AVI,
         CRD_DETAIL_PRD, PRODUCT_NUM, ORG_NUM, INDUSTRY, CUSTOMER_TYPE, GUARANTEE_TYPE, UNIT_SCALE,
         CREATE_TIME, UPDATE_TIME)
        values (s.STATIS_ID, s.CUSTOMER_NUM, s.CURRENCY_CD, s.APPROVE_COUNT,
                s.APPROVE_EXP_AMOUNT, s.CREDIT_EXP_BALANCE, s.LOAN_EXP_BALANCE, s.LIMIT_CREDIT,
                s.LIMIT_AVI, s.LIMIT_USED, s.EXP_USED, s.EXP_AVI,
                s.CRD_DETAIL_PRD, s.PRODUCT_NUM, s.ORG_NUM, s.INDUSTRY, s.CUSTOMER_TYPE, s.GUARANTEE_TYPE,
                s.UNIT_SCALE,
                s.CREATE_TIME, s.UPDATE_TIME)
    when matched then
        update set ta.LOAN_EXP_BALANCE=s.LOAN_EXP_BALANCE, ta.UPDATE_TIME=V_WORK_TIME;


    --ͳ��ͬҵ�ͻ����
    insert into TB_CRD_STATIS(STATIS_ID, CUSTOMER_NUM, CURRENCY_CD,
                              APPROVE_COUNT, APPROVE_EXP_AMOUNT, CREDIT_EXP_BALANCE, LOAN_EXP_BALANCE, LIMIT_CREDIT,
                              LIMIT_AVI, LIMIT_USED, EXP_USED, EXP_AVI,
                              CRD_DETAIL_PRD, PRODUCT_NUM, ORG_NUM, INDUSTRY, CUSTOMER_TYPE, GUARANTEE_TYPE,
                              UNIT_SCALE,
                              CREATE_TIME, UPDATE_TIME)
    select FNC_GET_UUID('TJ') STATIS_ID,
           t.CUSTOMER_NUM,
           '156'                   CURRENCY_CD,
           count(1)               APPROVE_COUNT,--��������
           sum(t.EXP_CREDIT)      APPROVE_EXP_AMOUNT,--�������ڽ��
           sum(t.EXP_USED)        CREDIT_EXP_BALANCE,--���ų������
           sum(t.EXP_AVI)         LOAN_EXP_BALANCE,--��������
           sum(t.LIMIT_CREDIT)    LIMIT_CREDIT,--���Ŷ��
           sum(t.LIMIT_AVI)       LIMIT_AVI,--���ö��
           sum(t.LIMIT_USED)      LIMIT_USED,--���ö��
           sum(t.EXP_USED)        EXP_USED,--���ó���
           sum(t.EXP_AVI)         EXP_AVI,--���ó���
           t.CRD_DETAIL_PRD,--���Ʒ��
           ''                     product_num,--ҵ��Ʒ��
           t.ORG_NUM,--������
           ''                     INDUSTRY,--��ҵ
           b.CUSTOMER_TYPE,--�ͻ�����
           ''                     GUARANTEE_TYPE,--������ʽ
           c.UNIT_SCALE,--��ҵ��ģ
           V_WORK_TIME            CREATE_TIME,
           V_WORK_TIME            UPDATE_TIME
    from TB_CRD_DETAIL t,
         TB_CSM_PARTY b
             left join TB_CSM_CORPORATION c on b.CUSTOMER_Num = c.CUSTOMER_NUM
    where t.CUSTOMER_NUM = b.CUSTOMER_NUM
      and t.TRAN_SYSTEM = '0010'--�ʽ�ҵ��ϵͳ
      and t.CUSTOMER_NUM = V_CUSTOMER_NUM
    group by t.CUSTOMER_NUM, t.CRD_DETAIL_PRD, t.ORG_NUM, b.CUSTOMER_TYPE, c.UNIT_SCALE;


    --���ͳ�Ʊ�-�ͻ���ʵʱ��
    delete from TB_CRD_STATIS_CSM t where t.CUSTOMER_NUM = V_CUSTOMER_NUM;

    insert into TB_CRD_STATIS_CSM(STATIS_ID, CUSTOMER_NUM,
                                  APPROVE_COUNT, APPROVE_EXP_AMOUNT, CREDIT_EXP_BALANCE, LOAN_EXP_BALANCE,
                                  LIMIT_CREDIT, LIMIT_AVI, LIMIT_USED, EXP_USED, EXP_AVI,
                                  ORG_NUM, CREATE_TIME, UPDATE_TIME)
    select FNC_GET_UUID('TJ')    STATIS_ID,
           t.CUSTOMER_NUM,
           sum(t.APPROVE_COUNT)      APPROVE_COUNT,--��������
           sum(t.APPROVE_EXP_AMOUNT) APPROVE_EXP_AMOUNT,--�������ڽ��
           sum(t.APPROVE_EXP_AMOUNT) CREDIT_EXP_BALANCE,--���ų������
           sum(t.LOAN_EXP_BALANCE)   LOAN_EXP_BALANCE,--��������
           sum(t.LIMIT_CREDIT)       LIMIT_CREDIT,--���Ŷ��
           sum(t.LIMIT_AVI)          LIMIT_AVI,--���Ŷ�ȿ���
           sum(t.LIMIT_USED)         LIMIT_USED,--���Ŷ������
           sum(t.EXP_USED)           EXP_USED,--��������
           sum(t.EXP_AVI)            EXP_AVI,--���ڿ���
           t.ORG_NUM,
           V_WORK_TIME               CREATE_TIME,
           V_WORK_TIME               UPDATE_TIME
    from TB_CRD_STATIS t
    where t.CUSTOMER_NUM = V_CUSTOMER_NUM
    group by t.CUSTOMER_NUM, t.ORG_NUM;


END;
/

prompt
prompt Creating procedure PRC_CREDIT_STATIS_HS
prompt =======================================
prompt
CREATE OR REPLACE PROCEDURE CLM."PRC_CREDIT_STATIS_HS" IS


    /**
      ͳ����ʷ�����Ϣ����ĩʱ������ǰͳ�����ݣ���¼һ���ڱ���
      CHENCHUAN 2019-12-03
     */
     V_LAST_DATE VARCHAR(10);--��ĩ���һ��
     V_WORK_DATE VARCHAR(10);--��ǰϵͳ����
     V_WORK_TIME TIMESTAMP;--��ǰϵͳ����
     V_BAT_DATE VARCHAR(10);--��ǰ��������

     V_YEAR VARCHAR(6); --��
     V_MONTH VARCHAR(2); --��
     V_DATE VARCHAR(2);

BEGIN



     V_WORK_TIME := CLM.FNC_GET_BUSI_TIME(); --��ǰӪҵʱ��
     V_WORK_DATE := CLM.FNC_GET_BUSI_DATE();
     V_BAT_DATE := CLM.FNC_GET_BAT_DATE();--��ǰ��������
     V_YEAR := SUBSTR(V_BAT_DATE, 1, 4);
     V_MONTH := SUBSTR(V_BAT_DATE, 6, 2);
     V_DATE := SUBSTR(V_BAT_DATE, 9, 2);
    --��ȡ�������һ�������
    V_LAST_DATE := TO_CHAR(LAST_DAY(V_WORK_TIME), 'YYYY-MM-DD');


    --�����ǰӪҵ���ڲ�����ĩ����������
    IF V_LAST_DATE != V_BAT_DATE THEN
        RETURN;
    END IF;


    --�����ϸ��ʷ��
    DELETE FROM TB_CRD_DETAIL_HS T WHERE T.YEAR = V_YEAR AND T.MONTH = V_MONTH;

    INSERT INTO TB_CRD_DETAIL_HS(STATIS_ID, CRD_DETAIL_NUM, CRD_MAIN_NUM, CRD_DETAIL_PRD,CRD_PRODUCT_TYPE,
                                 CRD_GRANT_ORG_NUM, CUSTOMER_NUM, CRD_ADMIT_FLAG, CURRENCY_CD,
                                 EXCHANGE_RATE, BEGIN_DATE, END_DATE, LIMIT_CREDIT, LIMIT_AVI,
                                 LIMIT_USED, EXP_CREDIT, EXP_USED, EXP_AVI, LIMIT_PRE, EXP_PRE,
                                 LIMIT_EARMARK, earmark_begin_date, earmark_end_date,
                                 LIMIT_FROZEN, EXP_FROZEN, IS_CYCLE, IS_MIX, MIXREMARK,
                                 CLOSE_DATE, CLOSE_REASON, IS_CONTINUE,
                                 TRAN_SYSTEM, USER_NUM, ORG_NUM, YEAR, MONTH, "DATE", CREATE_TIME, UPDATE_TIME)
    SELECT CLM.FNC_GET_UUID('TJ') STATIS_ID,
           T.CRD_DETAIL_NUM,
           T.CRD_MAIN_NUM,
           T.CRD_DETAIL_PRD,
           t.CRD_PRODUCT_TYPE,
           T.CRD_GRANT_ORG_NUM,
           T.CUSTOMER_NUM,
           T.CRD_ADMIT_FLAG,
           T.CURRENCY_CD,
           T.EXCHANGE_RATE,
           T.BEGIN_DATE,
           T.END_DATE,
           T.LIMIT_CREDIT,
           T.LIMIT_AVI,
           T.LIMIT_USED,
           T.EXP_CREDIT,
           T.EXP_USED,
           T.EXP_AVI,
           T.LIMIT_PRE,
           T.EXP_PRE,
           T.LIMIT_EARMARK,
           T.earmark_begin_date,
           T.earmark_end_date,
           T.LIMIT_FROZEN,
           T.EXP_FROZEN,
           T.IS_CYCLE,
           T.IS_MIX,
           T.MIXREMARK,
           T.CLOSE_DATE,
           T.CLOSE_REASON,
           T.IS_CONTINUE,
           T.TRAN_SYSTEM,
           T.USER_NUM,
           T.ORG_NUM,
           V_YEAR,
           V_MONTH,
           V_DATE,
           V_WORK_TIME        CREATE_TIME,
           V_WORK_TIME        UPDATE_TIME
    FROM TB_CRD_DETAIL T;

    --���������ʷ
    DELETE FROM TB_CRD_MAIN_HS T WHERE T.YEAR = V_YEAR AND T.MONTH = V_MONTH;
    INSERT INTO TB_CRD_MAIN_HS(STATIS_ID, CRD_MAIN_NUM, CRD_MAIN_PRD, CRD_PRODUCT_TYPE,CRD_GRANT_ORG_NUM,
                               CUSTOMER_NUM, CURRENCY_CD, EXCHANGE_RATE, CREDIT_STATUS, LIMIT_CREDIT,
                               LIMIT_USED, LIMIT_AVI, EXP_CREDIT, EXP_USED, EXP_AVI, LIMIT_PRE, EXP_PRE,
                               LIMIT_FROZEN, EXP_FROZEN, BEGIN_DATE, END_DATE, FROZEN_DATE, OVER_DATE,
                               TRAN_SYSTEM, ORG_NUM, USER_NUM, YEAR, MONTH, "DATE", CREATE_TIME, UPDATE_TIME)
    SELECT CLM.FNC_GET_UUID('TJ') STATIS_ID,
           t.CRD_MAIN_NUM,
           t.CRD_MAIN_PRD,
           t.CRD_GRANT_ORG_NUM,
           t.CRD_PRODUCT_TYPE,
           t.CUSTOMER_NUM,
           t.CURRENCY_CD,
           t.EXCHANGE_RATE,
           t.CREDIT_STATUS,
           t.LIMIT_CREDIT,
           t.LIMIT_USED,
           t.LIMIT_AVI,
           t.EXP_CREDIT,
           t.EXP_USED,
           t.EXP_AVI,
           t.LIMIT_PRE,
           t.EXP_PRE,
           t.LIMIT_FROZEN,
           t.EXP_FROZEN,
           t.BEGIN_DATE,
           t.END_DATE,
           t.FROZEN_DATE,
           t.OVER_DATE,
           t.TRAN_SYSTEM,
           t.ORG_NUM,
           t.USER_NUM,
           V_YEAR,
           V_MONTH,
           V_DATE,
           V_WORK_TIME,
           V_WORK_TIME
    FROM TB_CRD_MAIN T;


    --�ͻ������ʷ
    --���ͳ�Ʊ�-���Ʒ�֣���ʷ+ʵʱ��
    DELETE FROM TB_CRD_STATIS_CSM_HS T WHERE  T.YEAR = V_YEAR AND T.MONTH = V_MONTH;--ɾ����ʷ���ݣ������²���
    INSERT INTO TB_CRD_STATIS_CSM_HS(STATIS_ID,
                                    APPROVE_COUNT, APPROVE_EXP_AMOUNT, CREDIT_EXP_BALANCE, LOAN_EXP_BALANCE,
                                    LIMIT_CREDIT, LIMIT_AVI, LIMIT_USED, EXP_USED, EXP_AVI,customer_num,
                                    ORG_NUM, YEAR, MONTH, "DATE", CREATE_TIME, UPDATE_TIME)
    SELECT CLM.FNC_GET_UUID('TJ') STATIS_ID,
           APPROVE_COUNT,
           APPROVE_EXP_AMOUNT,
           CREDIT_EXP_BALANCE,
           LOAN_EXP_BALANCE,
           LIMIT_CREDIT,
           LIMIT_AVI,
           LIMIT_USED,
           EXP_USED,
           EXP_AVI,
           CUSTOMER_NUM,
           ORG_NUM,
           V_YEAR,
           V_MONTH,
           V_DATE,
           V_WORK_TIME,
           V_WORK_TIME
    FROM TB_CRD_STATIS_CSM T; --ʵʱ����


    --���ͳ�Ʊ�-���Ʒ�֣���ʷ+ʵʱ��
    DELETE FROM TB_CRD_STATIS_CRDPT T WHERE T.DATA_TYPE = '2' AND T.YEAR = V_YEAR AND T.MONTH = V_MONTH;--ɾ����ʷ���ݣ������²���

    INSERT INTO TB_CRD_STATIS_CRDPT(STATIS_ID,
                                    APPROVE_COUNT, APPROVE_EXP_AMOUNT, CREDIT_EXP_BALANCE, LOAN_EXP_BALANCE,
                                    LIMIT_CREDIT, LIMIT_AVI, LIMIT_USED, EXP_USED, EXP_AVI, CRD_DETAIL_PRD,
                                    ORG_NUM, DATA_TYPE, YEAR, MONTH, "DATE", CREATE_TIME, UPDATE_TIME)
    SELECT CLM.FNC_GET_UUID('TJ') STATIS_ID,
           APPROVE_COUNT,
           APPROVE_EXP_AMOUNT,
           CREDIT_EXP_BALANCE,
           LOAN_EXP_BALANCE,
           LIMIT_CREDIT,
           LIMIT_AVI,
           LIMIT_USED,
           EXP_USED,
           EXP_AVI,
           CRD_DETAIL_PRD,
           ORG_NUM,
           '2'                DATA_TYPE,
           V_YEAR  ,
           V_MONTH ,
           V_DATE  ,
           V_WORK_TIME        CREATE_TIME,
           V_WORK_TIME        UPDATE_TIME
    FROM TB_CRD_STATIS_CRDPT T --ʵʱ����
    WHERE T.DATA_TYPE = '1';


    --���ͳ�Ʊ�-��ҵ��ģ����ʷ+ʵʱ��
    DELETE FROM TB_CRD_STATIS_USCALE T WHERE T.DATA_TYPE = '2' AND T.YEAR = V_YEAR AND T.MONTH = V_MONTH;--ɾ����ʷ���ݣ������²���

    INSERT INTO TB_CRD_STATIS_USCALE(STATIS_ID,
                                     APPROVE_COUNT, APPROVE_EXP_AMOUNT, CREDIT_EXP_BALANCE, LOAN_EXP_BALANCE,
                                     LIMIT_CREDIT, LIMIT_AVI, LIMIT_USED, EXP_USED, EXP_AVI, UNIT_SCALE,
                                     ORG_NUM, DATA_TYPE, YEAR, MONTH, "DATE", CREATE_TIME, UPDATE_TIME)
    SELECT CLM.FNC_GET_UUID('TJ') STATIS_ID,
           APPROVE_COUNT,
           APPROVE_EXP_AMOUNT,
           CREDIT_EXP_BALANCE,
           LOAN_EXP_BALANCE,
           LIMIT_CREDIT,
           LIMIT_AVI,
           LIMIT_USED,
           EXP_USED,
           EXP_AVI,
           UNIT_SCALE,
           ORG_NUM,
           '2'                DATA_TYPE,
           V_YEAR  ,
           V_MONTH ,
           V_DATE  ,
           V_WORK_TIME        CREATE_TIME,
           V_WORK_TIME        UPDATE_TIME
    FROM TB_CRD_STATIS_USCALE T --ʵʱ����
    WHERE T.DATA_TYPE = '1';


    --���ͳ�Ʊ�-�ͻ����ͣ���ʷ+ʵʱ��
    DELETE FROM TB_CRD_STATIS_CUSTYPE T WHERE T.DATA_TYPE = '2' AND T.YEAR = V_YEAR AND T.MONTH = V_MONTH;--ɾ����ʷ���ݣ������²���

    INSERT INTO TB_CRD_STATIS_CUSTYPE(STATIS_ID,
                                      APPROVE_COUNT, APPROVE_EXP_AMOUNT, CREDIT_EXP_BALANCE, LOAN_EXP_BALANCE,
                                      LIMIT_CREDIT, LIMIT_AVI, LIMIT_USED, EXP_USED, EXP_AVI, CUSTOMER_TYPE,
                                      ORG_NUM, DATA_TYPE, YEAR, MONTH, "DATE", CREATE_TIME, UPDATE_TIME)
    SELECT CLM.FNC_GET_UUID('TJ') STATIS_ID,
           APPROVE_COUNT,
           APPROVE_EXP_AMOUNT,
           CREDIT_EXP_BALANCE,
           LOAN_EXP_BALANCE,
           LIMIT_CREDIT,
           LIMIT_AVI,
           LIMIT_USED,
           EXP_USED,
           EXP_AVI,
           CUSTOMER_TYPE,
           ORG_NUM,
           '2'                DATA_TYPE,
           V_YEAR  ,
           V_MONTH ,
           V_DATE  ,
           V_WORK_TIME        CREATE_TIME,
           V_WORK_TIME        UPDATE_TIME
    FROM TB_CRD_STATIS_CUSTYPE T --ʵʱ����
    WHERE T.DATA_TYPE = '1';

    --���ͳ�Ʊ�-������ʽ����ʷ+ʵʱ��
    DELETE FROM TB_CRD_STATIS_GTYPE T WHERE T.DATA_TYPE = '2' AND T.YEAR = V_YEAR AND T.MONTH = V_MONTH;--ɾ����ʷ���ݣ������²���

    INSERT INTO TB_CRD_STATIS_GTYPE(STATIS_ID,
                                    APPROVE_COUNT, APPROVE_EXP_AMOUNT, CREDIT_EXP_BALANCE, LOAN_EXP_BALANCE,
                                    LIMIT_CREDIT, LIMIT_AVI, LIMIT_USED, EXP_USED, EXP_AVI, GUARANTEE_TYPE,
                                    ORG_NUM, DATA_TYPE, YEAR, MONTH, "DATE", CREATE_TIME, UPDATE_TIME)
    SELECT CLM.FNC_GET_UUID('TJ') STATIS_ID,
           APPROVE_COUNT,
           APPROVE_EXP_AMOUNT,
           CREDIT_EXP_BALANCE,
           LOAN_EXP_BALANCE,
           LIMIT_CREDIT,
           LIMIT_AVI,
           LIMIT_USED,
           EXP_USED,
           EXP_AVI,
           GUARANTEE_TYPE,
           ORG_NUM,
           '2'                DATA_TYPE,
           V_YEAR  ,
           V_MONTH ,
           V_DATE  ,
           V_WORK_TIME        CREATE_TIME,
           V_WORK_TIME        UPDATE_TIME
    FROM TB_CRD_STATIS_GTYPE T --ʵʱ����
    WHERE T.DATA_TYPE = '1';


    --���ͳ�Ʊ�-��ҵ����ʷ+ʵʱ��
    DELETE FROM TB_CRD_STATIS_INDUSTRY T WHERE T.DATA_TYPE = '2' AND T.YEAR = V_YEAR AND T.MONTH = V_MONTH;--ɾ����ʷ���ݣ������²���

    INSERT INTO TB_CRD_STATIS_INDUSTRY(STATIS_ID,
                                       APPROVE_COUNT, APPROVE_EXP_AMOUNT, CREDIT_EXP_BALANCE, LOAN_EXP_BALANCE,
                                       LIMIT_CREDIT, LIMIT_AVI, LIMIT_USED, EXP_USED, EXP_AVI, INDUSTRY,
                                       ORG_NUM, DATA_TYPE, YEAR, MONTH, "DATE", CREATE_TIME, UPDATE_TIME)
    SELECT CLM.FNC_GET_UUID('TJ') STATIS_ID,
           APPROVE_COUNT,
           APPROVE_EXP_AMOUNT,
           CREDIT_EXP_BALANCE,
           LOAN_EXP_BALANCE,
           LIMIT_CREDIT,
           LIMIT_AVI,
           LIMIT_USED,
           EXP_USED,
           EXP_AVI,
           INDUSTRY,
           ORG_NUM,
           '2'                DATA_TYPE,
           V_YEAR  ,
           V_MONTH ,
           V_DATE  ,
           V_WORK_TIME        CREATE_TIME,
           V_WORK_TIME        UPDATE_TIME
    FROM TB_CRD_STATIS_INDUSTRY T --ʵʱ����
    WHERE T.DATA_TYPE = '1';


    --���ͳ�Ʊ�-ҵ��Ʒ�֣���ʷ+ʵʱ��
    DELETE FROM TB_CRD_STATIS_PRODUCT T WHERE T.DATA_TYPE = '2' AND T.YEAR = V_YEAR AND T.MONTH = V_MONTH;--ɾ����ʷ���ݣ������²���

    INSERT INTO TB_CRD_STATIS_PRODUCT(STATIS_ID,
                                      APPROVE_COUNT, APPROVE_EXP_AMOUNT, CREDIT_EXP_BALANCE, LOAN_EXP_BALANCE,
                                      LIMIT_CREDIT, LIMIT_AVI, LIMIT_USED, EXP_USED, EXP_AVI, PRODUCT_NUM,
                                      ORG_NUM, DATA_TYPE, YEAR, MONTH, "DATE", CREATE_TIME, UPDATE_TIME)
    SELECT CLM.FNC_GET_UUID('TJ') STATIS_ID,
           APPROVE_COUNT,
           APPROVE_EXP_AMOUNT,
           CREDIT_EXP_BALANCE,
           LOAN_EXP_BALANCE,
           LIMIT_CREDIT,
           LIMIT_AVI,
           LIMIT_USED,
           EXP_USED,
           EXP_AVI,
           PRODUCT_NUM,
           ORG_NUM,
           '2'                DATA_TYPE,
           V_YEAR,
           V_MONTH,
           V_DATE,
           V_WORK_TIME        CREATE_TIME,
           V_WORK_TIME        UPDATE_TIME
    FROM TB_CRD_STATIS_PRODUCT T --ʵʱ����
    WHERE T.DATA_TYPE = '1';

    --���ͳ�Ʊ�-��������ʷ+ʵʱ��
    DELETE FROM TB_CRD_STATIS_ORG T WHERE T.DATA_TYPE = '2' AND T.YEAR = V_YEAR AND T.MONTH = V_MONTH;--ɾ����ʷ���ݣ������²���

    INSERT INTO TB_CRD_STATIS_ORG(STATIS_ID,
                                  APPROVE_EXP_AMOUNT, CREDIT_EXP_BALANCE, LOAN_EXP_BALANCE,
                                  LIMIT_CREDIT, LIMIT_AVI, LIMIT_USED, EXP_USED, EXP_AVI, INDIVIDUAL_COUNT,
                                  CORPORATION_COUNT, BANK_COUNT, ORG_NUM, DATA_TYPE, YEAR, MONTH, "DATE", CREATE_TIME,
                                  UPDATE_TIME)
    SELECT CLM.FNC_GET_UUID('TJ') STATIS_ID,
           t.APPROVE_EXP_AMOUNT,
           t.CREDIT_EXP_BALANCE,
           t.LOAN_EXP_BALANCE,
           t.LIMIT_CREDIT,
           t.LIMIT_AVI,
           t.LIMIT_USED,
           t.EXP_USED,
           t.EXP_AVI,
           t.INDIVIDUAL_COUNT,
           t.CORPORATION_COUNT,
           t.BANK_COUNT,
           ORG_NUM,
           '2'                DATA_TYPE,
           V_YEAR  ,
           V_MONTH ,
           V_DATE  ,
           V_WORK_TIME        CREATE_TIME,
           V_WORK_TIME        UPDATE_TIME
    FROM TB_CRD_STATIS_ORG T --ʵʱ����
    WHERE T.DATA_TYPE = '1';


END;
/

prompt
prompt Creating procedure PRC_ECIF_ADDR_INFO_DEAL
prompt ==========================================
prompt
CREATE OR REPLACE PROCEDURE CLM."PRC_ECIF_ADDR_INFO_DEAL" (
     EXEC_DATE IN VARCHAR,
     RES_NUM OUT NUMBER ) IS

    EFFECT_COUNT                 NUMBER;                            ---Ӱ������
    SQL_CODE                     VARCHAR (20);                    --������
    SCHEMA_TYPE                  VARCHAR (10);               --SCHEMA����
    STATUS                       VARCHAR (20);                   --ִ�����
    PROC_NAME                    VARCHAR (50);                   --�洢����
    REMARK                       VARCHAR (200);                  --ִ�б�ע
    TRUNCATE_ECIF_ADDR_INFO_MIDDLE     VARCHAR (200);                 --��ձ�����


BEGIN  
   /*
    ����м������
   */
   EXECUTE IMMEDIATE 'TRUNCATE TABLE TB_ECIF_ADDR_INFO_MIDDLE';
   /*
    ���Թ��ͻ���ַ��Ϣ�����м��
   */
   INSERT INTO TB_ECIF_ADDR_INFO_MIDDLE (CUSTOMER_NUM,
                                      CONN_TYPE,
                                      COUN_REGI,
                                      PROVINCE,
                                      CITY,
                                      COUNTY,
                                      STREET,
                                      DETAIL_ADDR,
                                      ENG_ADDR,
                                      POST_CODE)
   SELECT T1.CUST_NO,
          T1.CONN_TYPE,
          T1.COUN_REGI,
          T1.PROVINCE,
          T1.CITY,
          T1.COUNTY,
          T1.STREET,
          T1.DETAIL_ADDR,
          T1.ENG_ADDR,
          T1.POST_CODE
   FROM TT_ECIF_CORPORATION_ADDR_INFO T1;

   EFFECT_COUNT := sql%rowcount;

   SCHEMA_TYPE := 'CLM';
   PROC_NAME := 'PRC_ECIF_ADDR_INFO__DEAL.INSERT_TB_ECIF_ADDR_INFO_MIDDLE_CORP';
   STATUS := '1';
   SQL_CODE := '';
   REMARK := '��ECIF��ַ��Ϣ�м�����Թ���ַ��Ϣ';
   /*
    ����˽�ͻ���ַ��Ϣ�����м��
   */
   INSERT INTO TB_ECIF_ADDR_INFO_MIDDLE (CUSTOMER_NUM,
                                      CONN_TYPE,
                                      COUN_REGI,
                                      PROVINCE,
                                      CITY,
                                      COUNTY,
                                      STREET,
                                      DETAIL_ADDR,
                                      ENG_ADDR,
                                      POST_CODE)
   SELECT T2.CUST_NO,
          T2.CONN_TYPE,
          T2.COUN_REGI,
          T2.PROVINCE,
          T2.CITY,
          T2.COUNTY,
          T2.STREET,
          T2.DETAIL_ADDR,
          T2.ENG_ADDR,
          T2.POST_CODE
   FROM TT_ECIF_INDIVIDUAL_ADDR_INFO T2;

   EFFECT_COUNT := sql%rowcount;

   SCHEMA_TYPE := 'CLM';
   PROC_NAME := 'PRC_ECIF_ADDR_INFO__DEAL.INSERT_TB_ECIF_ADDR_INFO_MIDDLE_PER';
    STATUS := '1';
    SQL_CODE := 0;
    REMARK := '��ECIF��ַ��Ϣ�м������˽��ַ��Ϣ';
   --��¼������־��Ϣ
   PRC_CRD_BATCH_LOG (SCHEMA_TYPE,PROC_NAME,STATUS,EFFECT_COUNT,SQL_CODE,REMARK);
   RES_NUM := 1;
END;
/

prompt
prompt Creating procedure PRC_ECIF_CERT_INFO_DEAL
prompt ==========================================
prompt
CREATE OR REPLACE PROCEDURE CLM."PRC_ECIF_CERT_INFO_DEAL" (
     EXEC_DATE IN	VARCHAR,
     RES_NUM OUT	INTEGER ) is

   
      EFFECT_COUNT                     number;                        ---Ӱ������
    SQL_CODE                         VARCHAR (20);                --������
    SCHEMA_TYPE                      VARCHAR (10);           --SCHEMA����
    STATUS                           VARCHAR (20);               --ִ�����
    PROC_NAME                        VARCHAR (50);               --�洢����
    REMARK                           VARCHAR (200);              --ִ�б�ע
    TRUNCATE_ECIF_CERT_INFO_MIDDLE   VARCHAR (200);             --��ձ�����

   BEGIN


   /*
    ����м������
   */   
   EXECUTE IMMEDIATE 'TRUNCATE TABLE TB_ECIF_CERT_INFO_MIDDLE';

   /*
    ��֤����Ϣ�м��������֤����Ϣ
   */
   INSERT INTO TB_ECIF_CERT_INFO_MIDDLE (CUSTOMER_NUM,
                                         CERT_FLAG,
                                         CERT_TYPE,
                                         CERT_NUM,
                                         ISSUED_INST,
                                         CERT_START_DATE,
                                         CERT_END_DATE)
      SELECT T.CUST_NO,
             T.CERT_FLAG,
             T.CERT_TYPE,
             T.CERT_NUM,
             T.ISSUED_INST,
             T.CERT_START_DATE,
             T.CERT_END_DATE
      FROM TT_ECIF_INDIVIDUAL_CERT_INFO T;

    EFFECT_COUNT := sql%rowcount;
    SCHEMA_TYPE := 'CLM';
    PROC_NAME :=
          'PRC_ECIF_CERT_INFO_DEAL.INSERT_TB_ECIF_CERT_INFO_MIDDLE_PER';
    STATUS := '1';
    SQL_CODE := 0;
    REMARK := '��֤����Ϣ�м������˽�ͻ�֤����Ϣ';


   --��¼������־��Ϣ
   PRC_CRD_BATCH_LOG (SCHEMA_TYPE,
                               PROC_NAME,
                               STATUS,
                               EFFECT_COUNT,
                               SQL_CODE,
                               REMARK);

   /*
     ��֤����Ϣ�м�����Թ�֤����Ϣ
   */
   INSERT INTO TB_ECIF_CERT_INFO_MIDDLE (CUSTOMER_NUM,
                                         CERT_FLAG,
                                         CERT_TYPE,
                                         CERT_NUM,
                                         ISSUED_INST,
                                         CERT_START_DATE,
                                         CERT_END_DATE)
      SELECT T1.CUST_NO,
             T1.CERT_FLAG,
             T1.CERT_TYPE,
             T1.CERT_NUM,
             T1.ISSUED_INST,
             T1.CERT_START_DATE,
             T1.CERT_END_DATE
      FROM TT_ECIF_CORPORATION_CERT_INFO T1;

    EFFECT_COUNT := sql%rowcount;

    SCHEMA_TYPE := 'CLM';
    PROC_NAME :=
          'PRC_ECIF_CERT_INFO_DEAL.INSERT_TB_ECIF_CERT_INFO_MIDDLE_CORP';
    STATUS := '1';
    SQL_CODE := 0;
    REMARK := '��֤����Ϣ�м�����Թ��ͻ�֤����Ϣ';
      --��¼������־��Ϣ
   PRC_CRD_BATCH_LOG (SCHEMA_TYPE,
                               PROC_NAME,
                               STATUS,
                               EFFECT_COUNT,
                               SQL_CODE,
                               REMARK);
   RES_NUM := 1;
END;
/

prompt
prompt Creating procedure PRC_ECIF_CONNECT_INFO_DEAL
prompt =============================================
prompt
CREATE OR REPLACE PROCEDURE CLM."PRC_ECIF_CONNECT_INFO_DEAL" (
     EXEC_DATE IN	VARCHAR,
     RES_NUM OUT	NUMBER ) IS




    EFFECT_COUNT                 NUMBER;                            ---Ӱ������
    SQL_CODE                     VARCHAR (20);                    --������
    SCHEMA_TYPE                  VARCHAR (10);               --SCHEMA����
    STATUS                       VARCHAR (20);                   --ִ�����
    PROC_NAME                    VARCHAR (50);                   --�洢����
    REMARK                       VARCHAR (200);                  --ִ�б�ע
    TR_ECIF_CON_INFO_MIDDLE     VARCHAR (200);                 --��ձ�����

   BEGIN

   /*
    ����м������
   */
   
  EXECUTE IMMEDIATE 'TRUNCATE TABLE TB_ECIF_CONNECT_INFO_MIDDLE';
        INSERT INTO  TB_ECIF_CONNECT_INFO_MIDDLE (
                            CUSTOMER_NUM
                           ,CONN_TYPE
                           ,INTER_CODE
                           ,INLAND_CODE
                           ,TEL_NUMBER
                           ,EXTEN_NUM
                           ,IS_CHECK_FLAG
                                         )
                        SELECT
                            CUST_NO
                            ,CONN_TYPE
                            ,INTER_CODE
                            ,INLAND_CODE
                            ,TEL_NUMBER
                            ,EXTEN_NUM
                            ,IS_CHECK_FLAG
        FROM  TT_ECIF_INDIVIDUAL_PHONE_INFO T1;
         EFFECT_COUNT := sql%rowcount; 
         SCHEMA_TYPE := 'CLM';
         PROC_NAME := 'PRC_ECIF_CONNECT_INFO_DEAL.INSERT_TB_ECIF_CONNECT_INFO_MIDDLE_PER';
         STATUS := '1';
         SQL_CODE := 0;
         REMARK := '��ECIF��ϵ��Ϣ�м����������ϵ��Ϣ';
        --��¼������־��Ϣ
        PRC_CRD_BATCH_LOG (SCHEMA_TYPE,PROC_NAME,STATUS,EFFECT_COUNT,SQL_CODE,REMARK);
        INSERT INTO  TB_ECIF_CONNECT_INFO_MIDDLE (
                            CUSTOMER_NUM
                           ,CONN_TYPE
                           ,INTER_CODE
                           ,INLAND_CODE
                           ,TEL_NUMBER
                           ,EXTEN_NUM
                           ,IS_CHECK_FLAG
                                         )
                        SELECT
                            CUST_NO
                            ,CONN_TYPE
                            ,INTER_CODE
                            ,INLAND_CODE
                            ,TEL_NUMBER
                            ,EXTEN_NUM
                            ,IS_CHECK_FLAG
        FROM  TT_ECIF_CORPORATION_PHONE_INFO T1;
         EFFECT_COUNT :=  sql%rowcount; 
         SCHEMA_TYPE := 'CLM';
         PROC_NAME := 'PRC_ECIF_CONNECT_INFO_DEAL.INSERT_TB_ECIF_CONNECT_INFO_MIDDLE_CORP';
         STATUS := '1';
         SQL_CODE := 0;
         REMARK := '��ECIF��ϵ��Ϣ�м�����Թ���ϵ��Ϣ';
        --��¼������־��Ϣ
        PRC_CRD_BATCH_LOG (SCHEMA_TYPE,PROC_NAME,STATUS,EFFECT_COUNT,SQL_CODE,REMARK);
         RES_NUM := 1;
END;
/

prompt
prompt Creating procedure PRC_ECIF_RELATION_INFO_DEAL
prompt ==============================================
prompt
CREATE OR REPLACE PROCEDURE CLM."PRC_ECIF_RELATION_INFO_DEAL" (
     EXEC_DATE IN	VARCHAR,
     RES_NUM OUT	INTEGER ) IS


    EFFECT_COUNT                 number;                            ---Ӱ������
    SQL_CODE                     VARCHAR (20);                    --������
    SCHEMA_TYPE                  VARCHAR (10);               --SCHEMA����
    STATUS                       VARCHAR (20);                   --ִ�����
    PROC_NAME                    VARCHAR (50);                   --�洢����
    REMARK                       VARCHAR (200);                  --ִ�б�ע
    TR_ECIF_RE_INFO_MIDDLE     VARCHAR (200);                 --��ձ�����

    BEGIN


   /*
    ����м������
   */
   EXECUTE IMMEDIATE 'TRUNCATE TABLE TB_ECIF_RELATION_INFO_MIDDLE';
   
   INSERT INTO TB_ECIF_RELATION_INFO_MIDDLE (CUSTOMER_NUM,
                                          REL_CUSTOMER_NUM,
                                          REL_TYPE,
                                          CUST_NAME,
                                          CERT_TYPE,
                                          CERT_NUM,
                                          GENDER)
   SELECT T1.CUST_NO,
          T1.REL_CUST_NO,
          T1.REL_TYPE,
          T1.CUST_NAME,
          T1.CERT_TYPE,
          T1.CERT_NUM,
          GENDER
   FROM TT_ECIF_INDIVIDUAL_PEOPLE_INFO T1;

    EFFECT_COUNT := rowcount;
    SCHEMA_TYPE := 'CLM';
    PROC_NAME := 'PRC_ECIF_RELATION_INFO_DEAL.INSERT_TB_ECIF_RELATION_INFO_MIDDLE_PER_1';
    STATUS := '1';
    SQL_CODE := 0;
    REMARK := '��ECIF������ϵ�м�������˶�˽������Ϣ';
   --��¼������־��Ϣ
   PRC_CRD_BATCH_LOG (SCHEMA_TYPE,PROC_NAME,STATUS,EFFECT_COUNT,SQL_CODE,REMARK);
   
   INSERT INTO TB_ECIF_RELATION_INFO_MIDDLE (CUSTOMER_NUM,
                                          REL_CUSTOMER_NUM,
                                          REL_TYPE,
                                          CUST_NAME,
                                          CERT_TYPE,
                                          CERT_NUM,
                                          GENDER)
   SELECT T1.CUST_NO,
          T1.REL_CUST_NO,
          T1.REL_TYPE,
          T1.CUST_NAME,
          T1.CERT_TYPE,
          T1.CERT_NUM,
          GENDER
   FROM TT_ECIF_CORPORATION_PEOPLE_INFO T1;

    EFFECT_COUNT := rowcount;
    SCHEMA_TYPE := 'CLM';
    PROC_NAME := 'PRC_ECIF_RELATION_INFO_DEAL.INSERT_TB_ECIF_RELATION_INFO_MIDDLE_C_PER_2';
    STATUS := '1';
    SQL_CODE := 0;
    REMARK := '��ECIF������ϵ�м�����Թ����˹�����Ϣ';
   --��¼������־��Ϣ
   PRC_CRD_BATCH_LOG (SCHEMA_TYPE,PROC_NAME,STATUS,EFFECT_COUNT,SQL_CODE,REMARK);
   INSERT INTO TB_ECIF_RELATION_INFO_MIDDLE (
        CUSTOMER_NUM
        ,REL_CUSTOMER_NUM
        ,REL_TYPE
        ,CUST_NAME
        ,CERT_TYPE
        ,CERT_NUM
        ,UNIT_SCALE
                    )
        SELECT T1.CUST_NO,
              T1.REL_CUST_NO,
              T1.REL_TYPE,
              T1.CUST_NAME,
              T1.CERT_TYPE,
              T1.CERT_NUM,
              T1.UNIT_SCALE
        FROM TT_ECIF_CORPORATION_COMPANY_INFO T1;
    EFFECT_COUNT := rowcount;
    SCHEMA_TYPE := 'CLM';
    PROC_NAME := 'PRC_ECIF_RELATION_INFO_DEAL.INSERT_TB_ECIF_RELATION_INFO_MIDDLE_CORP';
    STATUS := '1';
    SQL_CODE := 0;
    REMARK := '��ECIF������ϵ�м�����Թ�˾�ͻ��Թ�������Ϣ';
   --��¼������־��Ϣ
   PRC_CRD_BATCH_LOG (SCHEMA_TYPE,PROC_NAME,STATUS,EFFECT_COUNT,SQL_CODE,REMARK);
    RES_NUM = 1;
END;
/

prompt
prompt Creating procedure PRC_FUND_CRD_ADJUST
prompt ======================================
prompt
CREATE OR REPLACE PROCEDURE CLM."PRC_FUND_CRD_ADJUST"(
     EXEC_DATE IN VARCHAR) IS



        EFFECT_COUNT   NUMBER; ---Ӱ������
     SQL_CODE       VARCHAR(20); --������
     SCHEMA_TYPE    VARCHAR(10); --SCHEMA����
     STATUS         VARCHAR(20); --ִ�����
     PROC_NAME      VARCHAR(50); --�洢����
     V_CRD_GRANT_ORG_NUM VARCHAR(10);--���Ż���
     V_CUSTOMER_NUM VARCHAR(10);--ECIF�ͻ���
     V_CRD_MAIN_PRD VARCHAR(10);--������Ȳ�Ʒ
     V_CRD_DETAIL_PRD VARCHAR(10);--������Ȳ�Ʒ
     CRD_HAVE_COUNT       NUMBER; --��ͳһ����ϵͳ�е���������
     FUND_HAVE_COUNT      NUMBER; --���ʽ�ϵͳ�е���������

     BEGIN


     SELECT  COUNT(1) INTO CRD_HAVE_COUNT  FROM  TB_FUND_GRANT_MAIN T1  WHERE  T1.TRAN_EVENT_STATUS = '1' AND T1.TRAN_ACCT_STATUS = '0' AND
            T1.ADJUST_FLAG = '1' AND  T1.ADJUST_DIRECTION = '0' ;
     SELECT  COUNT(1) into FUND_HAVE_COUNT FROM  TB_FUND_GRANT_MAIN T1  WHERE  T1.TRAN_EVENT_STATUS = '0' AND T1.TRAN_ACCT_STATUS =  '1' AND
            T1.ADJUST_FLAG = '1' AND T1.ADJUST_DIRECTION = '1';

    IF CRD_HAVE_COUNT>0
    THEN
        FOR CRD_HAVE_CONDTION IN ( SELECT T1.TRAN_SEQ_SN, T1.TRAN_DATE,
                                         T1.BUSI_DEAL_NUM, T1.TRAN_TYPE_CD, T1.CRD_APPLY_AMT, T1.TRAN_EVENT_STATUS, T1.TRAN_ACCT_STATUS, T1.ADJUST_FLAG, T1.ADJUST_DIRECTION FROM TB_FUND_GRANT_MAIN T1 WHERE T1.TRAN_EVENT_STATUS = '1' AND T1.TRAN_ACCT_STATUS = '0' AND T1.ADJUST_FLAG = '1' AND T1.ADJUST_DIRECTION = '0')
            LOOP
                IF CRD_HAVE_CONDTION.TRAN_TYPE_CD = '01'
                THEN
                    SELECT T2.CRD_GRANT_ORG_NUM,T2.CUSTOMER_NUM,T2.CRD_MAIN_PRD INTO V_CRD_GRANT_ORG_NUM,V_CUSTOMER_NUM,V_CRD_MAIN_PRD  FROM TB_FUND_GRANT_DETAIL T2 WHERE T2.TRAN_SEQ_SN=CRD_HAVE_CONDTION.TRAN_SEQ_SN AND T2.TRAN_DATE=CRD_HAVE_CONDTION.TRAN_DATE;



                END IF;
            END LOOP;

    END IF;
    /*

        FUND_HAVE_CURSOR CURSOR FOR
          SELECT
           T1.TRAN_SEQ_SN,
           T1.TRAN_DATE,
           T1.BUSI_DEAL_NUM,
           T1.TRAN_TYPE_CD,
           T1.CRD_APPLY_AMT,
           T1.TRAN_EVENT_STATUS,
           T1.TRAN_ACCT_STATUS,
           T1.ADJUST_FLAG,
           T1.ADJUST_DIRECTION
          FROM
           TB_FUND_GRANT_MAIN T1
          WHERE
           T1.TRAN_EVENT_STATUS = '0' AND
           T1.TRAN_ACCT_STATUS = '1' AND
           T1.ADJUST_FLAG = '1' AND
           T1.ADJUST_DIRECTION = '1';
    */
------------------------------------STEP1--BIGIN-----------------------------


END;
/

prompt
prompt Creating procedure PRC_GUARANTEE_RECOUNT
prompt ========================================
prompt
CREATE OR REPLACE PROCEDURE CLM."PRC_GUARANTEE_RECOUNT"( V_CUSTOMER_NUM IN VARCHAR) IS

    /*
    �����������
    */
    V_GRT_USED NUMBER(24, 6) DEFAULT 0; --�����������

    V_CRD_DETAIL_NUM VARCHAR(40); --������ȱ��
    V_CRD_MAIN_NUM VARCHAR(40); --������ȱ��

    V_WORK_TIME DATE; --Ӫҵʱ��

    BEGIN

    V_WORK_TIME := FNC_GET_BUSI_TIME();


    /*�������--�������*/
    FOR GRT_LIST IN (SELECT T.SURETY_NUM, NVL(SUM(S.SURETY_AMT), 0) SURETY_AMT
                     FROM TB_CRD_SURETY T
                              LEFT JOIN (SELECT A.SURETY_NUM, NVL(A.SURETY_AMT, 0) SURETY_AMT
                                         FROM TB_CRD_SUBCONTRACT_SURETY A,
                                              TB_CRD_SUBCONTRACT B,
                                              TB_CRD_SUBCONTRACT_CON C,
                                              TB_CRD_CONTRACT D
                                         WHERE A.SUBCONTRACT_NUM = B.SUBCONTRACT_NUM
                                           AND B.SUBCONTRACT_NUM = C.SUBCONTRACT_NUM
                                           AND C.CONTRACT_NUM = D.CONTRACT_NUM
                                           AND D.CONTRACT_STATUS in ('0', '1', '2')
                     ) S ON S.SURETY_NUM = T.SURETY_NUM
                     WHERE T.CUSTOMER_NUM = V_CUSTOMER_NUM
                     GROUP BY T.SURETY_NUM)
        LOOP
            --���µ�����ȿ��ã�����
            UPDATE TB_CRD_SURETY T
            SET T.AMT_USED=GRT_LIST.SURETY_AMT,
                T.AMT_AVI=T.AMT_ACTUAL - GRT_LIST.SURETY_AMT,
                T.UPDATE_TIME=V_WORK_TIME
            WHERE T.SURETY_NUM = GRT_LIST.SURETY_NUM
              and t.GUARANTEE_TYPE in ('2', '3');

            UPDATE TB_CRD_SURETY T
            SET t.AMT_ACTUAL=GRT_LIST.SURETY_AMT,
                t.AMT_ASSES=GRT_LIST.SURETY_AMT,
                T.AMT_USED=GRT_LIST.SURETY_AMT,
                T.AMT_AVI=0,
                T.UPDATE_TIME=V_WORK_TIME
            WHERE T.SURETY_NUM = GRT_LIST.SURETY_NUM
              and t.GUARANTEE_TYPE in ('1', '4');
        END LOOP;


    --���¶���������
    for crd_detail_list IN (
        SELECT T.CRD_DETAIL_PRD,
               T.CUSTOMER_NUM,
               A.CORP_ORG_CODE
        FROM TB_CRD_SURETY T,
             CHAIN_DEPT A
        WHERE T.ORG_NUM = A.ID
          AND T.CUSTOMER_NUM = V_CUSTOMER_NUM
        GROUP BY T.CUSTOMER_NUM,
                 A.CORP_ORG_CODE,
                 T.CRD_DETAIL_PRD
    )
        LOOP
            V_CRD_DETAIL_NUM := null;
            select t.CRD_DETAIL_NUM
            into V_CRD_DETAIL_NUM
            from TB_CRD_DETAIL t
            where t.CUSTOMER_NUM = crd_detail_list.CUSTOMER_NUM
              and t.CRD_DETAIL_PRD = crd_detail_list.CRD_DETAIL_PRD
              and t.ORG_NUM = crd_detail_list.CORP_ORG_CODE;

            if (V_CRD_DETAIL_NUM is null or V_CRD_DETAIL_NUM = '') then
                 V_CRD_DETAIL_NUM := FNC_GET_BIZ_NUM('ED3');
            end if;

            update TB_CRD_SURETY t
            set t.CRD_DETAIL_NUM=V_CRD_DETAIL_NUM,
                t.UPDATE_TIME=V_WORK_TIME
            where t.CUSTOMER_NUM = crd_detail_list.CUSTOMER_NUM
              and t.CRD_DETAIL_PRD = crd_detail_list.CRD_DETAIL_PRD
              and exists(select 1
                         from CHAIN_DEPT a
                         where a.ID = t.ORG_NUM
                           and a.CORP_ORG_CODE = crd_detail_list.CORP_ORG_CODE);
        end LOOP;
    --���¶���������
    for crd_main_list IN (
        SELECT t.CRD_MAIN_PRD,
               T.CUSTOMER_NUM,
               A.CORP_ORG_CODE
        FROM TB_CRD_SURETY T,
             CHAIN_DEPT A
        WHERE T.ORG_NUM = A.ID
          AND T.CUSTOMER_NUM = V_CUSTOMER_NUM
        GROUP BY T.CUSTOMER_NUM,
                 A.CORP_ORG_CODE,
                 t.CRD_MAIN_PRD
    )
        LOOP
            V_CRD_MAIN_NUM := null;

            select t.CRD_MAIN_NUM
            into V_CRD_MAIN_NUM
            from TB_CRD_MAIN t
            where t.CUSTOMER_NUM = crd_main_list.CUSTOMER_NUM
              and t.CRD_MAIN_PRD = crd_main_list.CRD_MAIN_PRD
              and t.ORG_NUM = crd_main_list.CORP_ORG_CODE;

            if (V_CRD_MAIN_NUM is null or V_CRD_MAIN_NUM = '') then
                V_CRD_MAIN_NUM := FNC_GET_BIZ_NUM('ED2');
            end if;

            update TB_CRD_SURETY t
            set t.CRD_MAIN_NUM=V_CRD_MAIN_NUM,
                t.UPDATE_TIME=V_WORK_TIME
            where t.CUSTOMER_NUM = crd_main_list.CUSTOMER_NUM
              and t.CRD_MAIN_PRD = crd_main_list.CRD_MAIN_PRD
              and exists(select 1
                         from CHAIN_DEPT a
                         where a.ID = t.ORG_NUM
                           and a.CORP_ORG_CODE = crd_main_list.CORP_ORG_CODE);
        end LOOP;

    --ɾ��û�й�����������ĵĵ�����ȶ����Ϣ
    DELETE
    FROM TB_CRD_DETAIL T
    WHERE T.TRAN_SYSTEM = '0007'
      AND T.CUSTOMER_NUM = V_CUSTOMER_NUM
      and t.CRD_PRODUCT_TYPE = '2'--�������
      AND NOT EXISTS(
            SELECT 1 FROM TB_CRD_SURETY A WHERE A.CRD_DETAIL_NUM = T.CRD_DETAIL_NUM
        );

    /* ���¶����ϸ���ȣ�TB_CRD_DETAIL��*/
    MERGE INTO TB_CRD_DETAIL TA
    USING (SELECT T.CRD_MAIN_NUM,
                  T.CRD_DETAIL_NUM,
                  T.CRD_DETAIL_PRD,
                  T.CUSTOMER_NUM,
                  A.CORP_ORG_CODE,
                  SUM(T.AMT_ACTUAL) LIMIT_CREDIT,
                  SUM(T.AMT_USED)   LIMIT_USED,
                  SUM(T.AMT_AVI)    LIMIT_AVI
           FROM TB_CRD_SURETY T,
                CHAIN_DEPT A
           WHERE T.ORG_NUM = A.ID
             AND T.CUSTOMER_NUM = V_CUSTOMER_NUM
           GROUP BY T.CUSTOMER_NUM,
                    A.CORP_ORG_CODE,
                    T.CRD_DETAIL_PRD,
                    T.CRD_DETAIL_NUM,
                    T.CRD_MAIN_NUM) S
    ON (
        S.CRD_DETAIL_NUM = TA.CRD_DETAIL_NUM
        )
    WHEN NOT MATCHED
        THEN
        INSERT (CRD_MAIN_NUM,--������ȱ��
                CRD_DETAIL_NUM, --������ȱ��
                CRD_DETAIL_PRD, --�������Ʒ��
                CUSTOMER_NUM, --�ͻ����
                CURRENCY_CD, --����
                EXCHANGE_RATE, --����
                LIMIT_CREDIT, --���Ŷ��
                LIMIT_USED, --���Ŷ������
                LIMIT_AVI, --���Ŷ�ȿ���
                CREATE_TIME, --��������
                UPDATE_TIME, --��������
                ORG_NUM, --�������
                CRD_GRANT_ORG_NUM,--���Ż���
                TRAN_SYSTEM,--����ϵͳ
                CRD_PRODUCT_TYPE--�������
        )
        VALUES (S.CRD_MAIN_NUM,
                S.CRD_DETAIL_NUM,
                S.CRD_DETAIL_PRD,
                S.CUSTOMER_NUM,
                'CNY',
                '1',
                S.LIMIT_CREDIT,
                S.LIMIT_USED,
                S.LIMIT_AVI,
                V_WORK_TIME,
                V_WORK_TIME,
                S.CORP_ORG_CODE, s.CORP_ORG_CODE, '0007','2')
    WHEN MATCHED
        THEN
        UPDATE
        SET ta.CRD_MAIN_NUM=s.CRD_MAIN_NUM,--��ȶ������
            ta.LIMIT_CREDIT = S.LIMIT_CREDIT, --���Ŷ��
            ta.LIMIT_USED = S.LIMIT_USED, --���Ŷ������
            ta.LIMIT_AVI = S.LIMIT_AVI, --���Ŷ�ȿ���
            ta.CRD_GRANT_ORG_NUM=S.CORP_ORG_CODE, --�������
            ta.ORG_NUM = S.CORP_ORG_CODE, --�������
            ta.TRAN_SYSTEM='0007',
            ta.UPDATE_TIME = V_WORK_TIME;

    --ɾ��û�й�����������ĵĵ�����ȶ����Ϣ
    DELETE
    FROM TB_CRD_MAIN T
    WHERE T.TRAN_SYSTEM = '0007'
      AND T.CUSTOMER_NUM = V_CUSTOMER_NUM
      and t.CRD_PRODUCT_TYPE = '2'--�������
      AND NOT EXISTS(
            SELECT 1 FROM TB_CRD_SURETY A WHERE A.CRD_MAIN_NUM = T.CRD_MAIN_NUM
        );

    --���¶������
    MERGE INTO TB_CRD_MAIN TA
    USING (SELECT T.CRD_MAIN_NUM,
                  T.CRD_MAIN_PRD,
                  T.CUSTOMER_NUM,
                  A.CORP_ORG_CODE,
                  SUM(t.AMT_ACTUAL) LIMIT_CREDIT,
                  SUM(T.AMT_USED)   LIMIT_USED,
                  SUM(T.AMT_AVI)    LIMIT_AVI
           FROM TB_CRD_SURETY T,
                CHAIN_DEPT A
           WHERE T.ORG_NUM = A.ID
             AND T.CUSTOMER_NUM = V_CUSTOMER_NUM
           GROUP BY T.CUSTOMER_NUM,
                    A.CORP_ORG_CODE,
                    T.CRD_MAIN_NUM,
                    T.CRD_MAIN_PRD) S
    ON (
        S.CRD_MAIN_NUM = TA.CRD_MAIN_NUM
        )
    WHEN NOT MATCHED
        THEN
        INSERT (CRD_MAIN_NUM,--������ȱ��
                CRD_MAIN_PRD, --�������Ʒ��
                CUSTOMER_NUM, --ECIF�ͻ����
                CURRENCY_CD, --����
                EXCHANGE_RATE, --����
                LIMIT_CREDIT, --���Ŷ��
                LIMIT_USED, --���Ŷ������
                LIMIT_AVI, --���Ŷ�ȿ���
                CREATE_TIME, --��������
                UPDATE_TIME, --��������
                CRD_GRANT_ORG_NUM,--���Ż���
                ORG_NUM, --�������
                TRAN_SYSTEM,
                CRD_PRODUCT_TYPE)
        VALUES (S.CRD_MAIN_NUM,
                S.CRD_MAIN_PRD,
                S.CUSTOMER_NUM,
                'CNY',
                '1',
                S.LIMIT_CREDIT,
                S.LIMIT_USED,
                S.LIMIT_AVI,
                V_WORK_TIME,
                V_WORK_TIME,
                S.CORP_ORG_CODE,
                S.CORP_ORG_CODE, '0007', '2')
    WHEN MATCHED
        THEN
        UPDATE
        SET TA.LIMIT_CREDIT     = S.LIMIT_CREDIT,  --���Ŷ��
            TA.LIMIT_USED       = S.LIMIT_USED,    --���Ŷ������
            TA.LIMIT_AVI        = S.LIMIT_AVI,     --���Ŷ�ȿ���
            TA.CRD_GRANT_ORG_NUM=S.CORP_ORG_CODE,--�������
            TA.ORG_NUM          = S.CORP_ORG_CODE, --�������
            TA.UPDATE_TIME      = V_WORK_TIME; --��������


END;
/

prompt
prompt Creating procedure PRC_THIRD_RECOUNT
prompt ====================================
prompt
CREATE OR REPLACE PROCEDURE CLM."PRC_THIRD_RECOUNT"( V_CUSTOMER_NUM IN VARCHAR) IS

    /*
    �������������
    */
     v_prj_used NUMBER(24, 6) DEFAULT 0; --�������������

     v_summary_bal NUMBER(24, 6) DEFAULT 0; --������
     v_summary_amt NUMBER(24, 6) DEFAULT 0; --��ݽ��

     V_CRD_DETAIL_NUM VARCHAR(40); --������ȱ��
     V_CRD_MAIN_NUM VARCHAR(40); --������ȱ��

     v_work_time TIMESTAMP; --Ӫҵʱ��

    BEGIN

    v_work_time := FNC_GET_busi_time();

    --���������--�������
    FOR prj_list IN (SELECT t.PROJECT_NUM, t.LIMIT_CONTROL_TYPE, t.TOTAL_AMT
                     FROM TB_CRD_PROJECT t
                     WHERE t.customer_num = V_CUSTOMER_NUM
                       AND t.PROJECT_STATUS = '1')
        LOOP

            SELECT nvl(sum(b.APPROVE_AMT), 0)
            INTO v_prj_used
            FROM tb_crd_approve b
            where b.APPROVE_STATUS = '2' -- ����Ч
              and b.PROJECT_NUM = prj_list.PROJECT_NUM;

            /*
                SELECT COALESCE(sum(s.summary_bal), 0),
                       COALESCE(sum(s.summary_amt), 0)
                INTO v_summary_bal, v_summary_amt
                FROM tb_crd_summary s,
                     tb_crd_approve b
                WHERE s.APPROVE_ID = b.APPROVE_ID
                  AND b.PROJECT_NUM = prj_list.PROJECT_num;
                IF prj_list.LIMIT_CONTROL_TYPE = '0' --�������ۼƷ��������
                THEN
                    --ѭ�����
                    SET v_prj_used = v_summary_amt;
                ELSEIF prj_list.LIMIT_CONTROL_TYPE = '1'
                THEN --������������
                    SET v_prj_used = v_summary_bal;
                ELSE --������
                    SET v_prj_used = 0;
                END IF;
            */
            --������Ŀ��ȿ���
            UPDATE TB_CRD_PROJECT t
            SET t.USED_AMT    = v_prj_used,
                t.AVI_AMT     = t.TOTAL_AMT - v_prj_used,
                t.update_time = v_work_time
            WHERE t.PROJECT_NUM = prj_list.PROJECT_NUM;
        END LOOP;


    --���¶���������
    for crd_detail_list IN (
        SELECT T.CRD_DETAIL_PRD,
               T.CUSTOMER_NUM,
               A.CORP_ORG_CODE
        FROM TB_CRD_PROJECT T,
             CHAIN_DEPT A
        WHERE T.ORG_NUM = A.ID
          AND T.CUSTOMER_NUM = V_CUSTOMER_NUM
        GROUP BY T.CUSTOMER_NUM,
                 A.CORP_ORG_CODE,
                 T.CRD_DETAIL_PRD
    )
        LOOP
            V_CRD_DETAIL_NUM := null;
            select t.CRD_DETAIL_NUM
            into V_CRD_DETAIL_NUM
            from TB_CRD_DETAIL t
            where t.CUSTOMER_NUM = crd_detail_list.CUSTOMER_NUM
              and t.CRD_DETAIL_PRD = crd_detail_list.CRD_DETAIL_PRD
              and t.ORG_NUM = crd_detail_list.CORP_ORG_CODE;

            if (V_CRD_DETAIL_NUM is null or V_CRD_DETAIL_NUM = '') then
                V_CRD_DETAIL_NUM := CLM.FNC_GET_BIZ_NUM('ED3');
            end if;

            update TB_CRD_PROJECT t
            set t.CRD_DETAIL_NUM=V_CRD_DETAIL_NUM,
                t.UPDATE_TIME=V_WORK_TIME
            where t.CUSTOMER_NUM = crd_detail_list.CUSTOMER_NUM
              and t.CRD_DETAIL_PRD = crd_detail_list.CRD_DETAIL_PRD
              and exists(select 1
                         from CHAIN_DEPT a
                         where a.ID = t.ORG_NUM
                           and a.CORP_ORG_CODE = crd_detail_list.CORP_ORG_CODE);
        end LOOP;

    --���¶�ȶ������
    for crd_main_list IN (
        SELECT t.CRD_MAIN_PRD,
               T.CUSTOMER_NUM,
               A.CORP_ORG_CODE
        FROM TB_CRD_PROJECT T,
             CHAIN_DEPT A
        WHERE T.ORG_NUM = A.ID
          AND T.CUSTOMER_NUM = V_CUSTOMER_NUM
        GROUP BY T.CUSTOMER_NUM,
                 A.CORP_ORG_CODE,
                 t.CRD_MAIN_PRD
    )
        LOOP
            V_CRD_MAIN_NUM := null;

            select t.CRD_MAIN_NUM
            into V_CRD_MAIN_NUM
            from TB_CRD_MAIN t
            where t.CUSTOMER_NUM = crd_main_list.CUSTOMER_NUM
              and t.CRD_MAIN_PRD = crd_main_list.CRD_MAIN_PRD
              and t.ORG_NUM = crd_main_list.CORP_ORG_CODE;

            if (V_CRD_MAIN_NUM is null or V_CRD_MAIN_NUM = '') then
                V_CRD_MAIN_NUM := CLM.FNC_GET_BIZ_NUM('ED3');
            end if;

            update TB_CRD_PROJECT t
            set t.CRD_MAIN_NUM=V_CRD_MAIN_NUM,
                t.UPDATE_TIME=V_WORK_TIME
            where t.CUSTOMER_NUM = crd_main_list.CUSTOMER_NUM
              and t.CRD_MAIN_PRD = crd_main_list.CRD_MAIN_PRD
              and exists(select 1
                         from CHAIN_DEPT a
                         where a.ID = t.ORG_NUM
                           and a.CORP_ORG_CODE = crd_main_list.CORP_ORG_CODE);
        end LOOP;

    --ɾ��û�й�����������Ŀ�����Ŷ����Ϣ
    delete
    from tb_crd_detail t
    where t.CUSTOMER_NUM = V_CUSTOMER_NUM
      and t.TRAN_SYSTEM = '0007'
      and t.CRD_PRODUCT_TYPE = '3'
      and not exists(
            select 1 from TB_CRD_PROJECT a where a.CRD_DETAIL_NUM = t.CRD_DETAIL_NUM and a.PROJECT_STATUS in ('1', '2')--��Ч����
        );

    --���¶����ϸ���ȣ�tb_crd_detail��
    MERGE INTO tb_crd_detail ta
    USING (SELECT t.CRD_MAIN_NUM,
                  t.crd_detail_num,
                  t.crd_detail_prd,
                  t.CUSTOMER_NUM,
                  b.CORP_ORG_CODE,
                  sum(t.total_amt) limit_credit,
                  sum(t.used_amt)  limit_used,
                  sum(t.avi_amt)   limit_avi
           FROM tb_crd_project t,
                CHAIN_DEPT b
           WHERE t.ORG_NUM = b.ID
             and t.PROJECT_STATUS = '1'
             AND t.customer_num = V_CUSTOMER_NUM
           GROUP BY t.CUSTOMER_NUM,
                    b.CORP_ORG_CODE,
                    t.CRD_MAIN_NUM,
                    t.crd_detail_prd,
                    t.crd_detail_num) s
    ON (s.CRD_DETAIL_NUM = ta.CRD_DETAIL_NUM)
    WHEN NOT MATCHED
        THEN
        INSERT (crd_main_num,--��ȱ��
                crd_detail_num, --�����ϸ���
                crd_detail_prd, --��Ȳ�Ʒ���
                CUSTOMER_NUM, --�ͻ����
                currency_cd, --����
                exchange_rate, --����
                limit_credit, --���Ŷ��
                limit_used, --���Ŷ������
                limit_avi, --���Ŷ�ȿ���
                create_time, --��������
                update_time, --��������
                org_num,--�������
                CRD_GRANT_ORG_NUM,--���Ż���
                TRAN_SYSTEM,--����ϵͳ
                CRD_PRODUCT_TYPE--�������
        )
        VALUES (s.crd_main_num,
                s.crd_detail_num,
                s.crd_detail_prd,
                s.customer_num,
                'CNY',
                '1',
                s.limit_credit,
                s.limit_used,
                s.limit_avi,
                v_work_time,
                v_work_time,
                s.CORP_ORG_CODE, s.CORP_ORG_CODE, '0007', '3')
    WHEN MATCHED
        THEN
        UPDATE
        SET ta.CRD_MAIN_NUM=s.CRD_MAIN_NUM,--������ȱ��
            ta.CRD_DETAIL_PRD=s.CRD_DETAIL_PRD,--�������Ʒ��
            ta.limit_credit = s.limit_credit, --���Ŷ��
            ta.limit_used = s.limit_used, --���Ŷ������
            ta.limit_avi = s.limit_avi, --���Ŷ�ȿ���
            ta.org_num = s.CORP_ORG_CODE, --�������
            ta.update_time = v_work_time;
    --��������

    --ɾ��û�й�����������Ŀ�����Ŷ����Ϣ
    delete
    from TB_CRD_MAIN t
    where t.CUSTOMER_NUM = V_CUSTOMER_NUM
      and t.TRAN_SYSTEM = '0007'
      and t.CRD_PRODUCT_TYPE = '3'
      and not exists(
            select 1 from TB_CRD_PROJECT a where a.CRD_MAIN_NUM = t.CRD_MAIN_NUM and a.PROJECT_STATUS in ('1', '2')--��Ч����
        );

    --���¶������
    MERGE INTO TB_CRD_MAIN TA
    USING (SELECT T.CRD_MAIN_NUM,
                  T.CRD_MAIN_PRD,
                  T.CUSTOMER_NUM,
                  A.CORP_ORG_CODE,
                  SUM(t.TOTAL_AMT) LIMIT_CREDIT,
                  SUM(T.USED_AMT)  LIMIT_USED,
                  SUM(T.AVI_AMT)   LIMIT_AVI
           FROM TB_CRD_PROJECT T,
                CHAIN_DEPT A
           WHERE T.ORG_NUM = A.ID
             AND T.CUSTOMER_NUM = V_CUSTOMER_NUM
           GROUP BY T.CUSTOMER_NUM,
                    A.CORP_ORG_CODE,
                    T.CRD_MAIN_NUM,
                    T.CRD_MAIN_PRD) S
    ON (
        S.CRD_MAIN_NUM = TA.CRD_MAIN_NUM
        )
    WHEN NOT MATCHED
        THEN
        INSERT (CRD_MAIN_NUM,--������ȱ��
                CRD_MAIN_PRD, --�������Ʒ��
                CUSTOMER_NUM, --ECIF�ͻ����
                CURRENCY_CD, --����
                EXCHANGE_RATE, --����
                LIMIT_CREDIT, --���Ŷ��
                LIMIT_USED, --���Ŷ������
                LIMIT_AVI, --���Ŷ�ȿ���
                CREATE_TIME, --��������
                UPDATE_TIME, --��������
                CRD_GRANT_ORG_NUM,--���Ż���
                ORG_NUM,--�������
                TRAN_SYSTEM,--����ϵͳ
                CRD_PRODUCT_TYPE--�������
        )
        VALUES (S.CRD_MAIN_NUM,
                S.CRD_MAIN_PRD,
                S.CUSTOMER_NUM,
                'CNY',
                '1',
                S.LIMIT_CREDIT,
                S.LIMIT_USED,
                S.LIMIT_AVI,
                V_WORK_TIME,
                V_WORK_TIME,
                S.CORP_ORG_CODE,
                S.CORP_ORG_CODE, '0007', '3')
    WHEN MATCHED
        THEN
        UPDATE
        SET TA.LIMIT_CREDIT     = S.LIMIT_CREDIT,  --���Ŷ��
            TA.LIMIT_USED       = S.LIMIT_USED,    --���Ŷ������
            TA.LIMIT_AVI        = S.LIMIT_AVI,     --���Ŷ�ȿ���
            TA.CRD_GRANT_ORG_NUM=S.CORP_ORG_CODE,--�������
            TA.ORG_NUM          = S.CORP_ORG_CODE, --�������
            TA.UPDATE_TIME      = V_WORK_TIME; --��������

END;
/


spool off
