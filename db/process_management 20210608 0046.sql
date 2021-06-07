﻿--
-- Script was generated by Devart dbForge Studio 2019 for MySQL, Version 8.2.23.0
-- Product home page: http://www.devart.com/dbforge/mysql/studio
-- Script date 6/8/2021 12:46:26 AM
-- Server version: 5.5.5-10.4.13-MariaDB
-- Client version: 4.1
--

-- 
-- Disable foreign keys
-- 
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;

-- 
-- Set SQL mode
-- 
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- 
-- Set character set the client will use to send SQL statements to the server
--
SET NAMES 'utf8';

--
-- Set default database
--
USE process_management;

--
-- Drop table `assignee_user`
--
DROP TABLE IF EXISTS assignee_user;

--
-- Drop table `step_assignee`
--
DROP TABLE IF EXISTS step_assignee;

--
-- Drop table `user_group_detail`
--
DROP TABLE IF EXISTS user_group_detail;

--
-- Drop table `user_group`
--
DROP TABLE IF EXISTS user_group;

--
-- Drop table `step_execution`
--
DROP TABLE IF EXISTS step_execution;

--
-- Drop table `process_execution`
--
DROP TABLE IF EXISTS process_execution;

--
-- Drop table `user_login`
--
DROP TABLE IF EXISTS user_login;

--
-- Drop table `user_infor`
--
DROP TABLE IF EXISTS user_infor;

--
-- Drop table `role`
--
DROP TABLE IF EXISTS role;

--
-- Drop table `step_field`
--
DROP TABLE IF EXISTS step_field;

--
-- Drop table `step_task`
--
DROP TABLE IF EXISTS step_task;

--
-- Drop table `process_step`
--
DROP TABLE IF EXISTS process_step;

--
-- Drop table `process`
--
DROP TABLE IF EXISTS process;

--
-- Drop table `process_group`
--
DROP TABLE IF EXISTS process_group;

--
-- Set default database
--
USE process_management;

--
-- Create table `process_group`
--
CREATE TABLE process_group (
  ProcessGroupID int(11) NOT NULL AUTO_INCREMENT,
  ProcessGroupName varchar(255) binary DEFAULT NULL,
  CreatedBy varchar(255) binary DEFAULT NULL,
  CreatedDate datetime DEFAULT NULL,
  ModifiedBy varchar(255) binary DEFAULT NULL,
  ModifiedDate datetime DEFAULT NULL,
  PRIMARY KEY (ProcessGroupID)
)
ENGINE = INNODB,
AUTO_INCREMENT = 4,
AVG_ROW_LENGTH = 8192,
CHARACTER SET utf8,
COLLATE utf8_bin;

--
-- Create table `process`
--
CREATE TABLE process (
  ProcessID int(11) NOT NULL AUTO_INCREMENT,
  ProcessName varchar(255) binary DEFAULT NULL,
  ProcessImage varchar(255) binary DEFAULT NULL,
  ProcessStatus int(11) DEFAULT NULL,
  Description text binary DEFAULT NULL,
  ProcessGroupID int(11) DEFAULT NULL,
  CreatedBy varchar(255) binary DEFAULT NULL,
  CreatedDate datetime DEFAULT NULL,
  ModifiedBy varchar(255) binary DEFAULT NULL,
  ModifiedDate datetime DEFAULT NULL,
  PRIMARY KEY (ProcessID)
)
ENGINE = INNODB,
AUTO_INCREMENT = 248,
AVG_ROW_LENGTH = 4096,
CHARACTER SET utf8,
COLLATE utf8_bin;

--
-- Create foreign key
--
ALTER TABLE process
ADD CONSTRAINT FK_process_process_group_ProcessGroupID FOREIGN KEY (ProcessGroupID)
REFERENCES process_group (ProcessGroupID) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Create table `process_step`
--
CREATE TABLE process_step (
  ProcessStepID int(11) NOT NULL AUTO_INCREMENT,
  ProcessStepName varchar(255) binary DEFAULT NULL,
  SortOrder int(11) DEFAULT NULL,
  Description text binary DEFAULT NULL,
  HasTask tinyint(1) DEFAULT NULL,
  AssigneeType int(11) DEFAULT NULL,
  HasField tinyint(1) DEFAULT NULL,
  ProcessID int(11) DEFAULT NULL,
  HasDeadline tinyint(1) DEFAULT NULL,
  DeadLine int(11) DEFAULT NULL,
  CreatedBy varchar(255) binary DEFAULT NULL,
  CreatedDate datetime DEFAULT NULL,
  ModifiedBy varchar(255) binary DEFAULT NULL,
  ModifiedDate datetime DEFAULT NULL,
  StepSortOrder int(11) DEFAULT NULL COMMENT ' = 1 là step đầu, = 2 là step cuối , còn lại step giữa',
  PRIMARY KEY (ProcessStepID)
)
ENGINE = INNODB,
AUTO_INCREMENT = 47,
AVG_ROW_LENGTH = 1365,
CHARACTER SET utf8,
COLLATE utf8_bin;

--
-- Create foreign key
--
ALTER TABLE process_step
ADD CONSTRAINT FK_process_step_process_ProcessID FOREIGN KEY (ProcessID)
REFERENCES process (ProcessID) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Create table `step_task`
--
CREATE TABLE step_task (
  TaskID int(11) NOT NULL AUTO_INCREMENT,
  TaskName varchar(255) binary DEFAULT NULL,
  SortOrder int(11) DEFAULT NULL,
  ProcessStepID int(11) DEFAULT NULL,
  PRIMARY KEY (TaskID)
)
ENGINE = INNODB,
AUTO_INCREMENT = 43,
AVG_ROW_LENGTH = 2048,
CHARACTER SET utf8,
COLLATE utf8_bin;

--
-- Create foreign key
--
ALTER TABLE step_task
ADD CONSTRAINT FK_step_task_process_step_ProcessStepID FOREIGN KEY (ProcessStepID)
REFERENCES process_step (ProcessStepID) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Create table `step_field`
--
CREATE TABLE step_field (
  StepFieldID int(11) NOT NULL AUTO_INCREMENT,
  FieldName varchar(255) binary DEFAULT NULL,
  SortOrder int(11) DEFAULT NULL,
  Description text binary DEFAULT NULL,
  IsRequired tinyint(1) DEFAULT NULL,
  Type int(11) DEFAULT NULL,
  DataSetting longtext binary CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  ProcessStepID int(11) DEFAULT NULL,
  PRIMARY KEY (StepFieldID)
)
ENGINE = INNODB,
AUTO_INCREMENT = 40,
AVG_ROW_LENGTH = 2340,
CHARACTER SET utf8,
COLLATE utf8_bin;

--
-- Create foreign key
--
ALTER TABLE step_field
ADD CONSTRAINT FK_step_field_process_step_ProcessStepID FOREIGN KEY (ProcessStepID)
REFERENCES process_step (ProcessStepID) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Create table `role`
--
CREATE TABLE role (
  RoleID int(11) NOT NULL AUTO_INCREMENT,
  RoleName varchar(255) binary DEFAULT NULL,
  PRIMARY KEY (RoleID)
)
ENGINE = INNODB,
AUTO_INCREMENT = 4,
AVG_ROW_LENGTH = 8192,
CHARACTER SET utf8,
COLLATE utf8_bin;

--
-- Create table `user_infor`
--
CREATE TABLE user_infor (
  UserID int(11) NOT NULL AUTO_INCREMENT,
  FullName varchar(100) binary DEFAULT NULL,
  Email varchar(50) binary DEFAULT NULL,
  DateOfBirth date DEFAULT NULL,
  Phone varchar(50) binary DEFAULT NULL,
  Address varchar(255) binary DEFAULT NULL,
  RoleID int(11) DEFAULT NULL,
  CreatedBy varchar(255) binary DEFAULT NULL,
  CreatedDate datetime DEFAULT NULL,
  ModifiedBy varchar(255) binary DEFAULT NULL,
  ModifiedDate datetime DEFAULT NULL,
  PRIMARY KEY (UserID)
)
ENGINE = INNODB,
AUTO_INCREMENT = 49,
AVG_ROW_LENGTH = 546,
CHARACTER SET utf8,
COLLATE utf8_bin;

--
-- Create foreign key
--
ALTER TABLE user_infor
ADD CONSTRAINT FK_user_infor FOREIGN KEY (RoleID)
REFERENCES role (RoleID) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Create table `user_login`
--
CREATE TABLE user_login (
  UserID int(11) NOT NULL,
  Username varchar(50) binary DEFAULT NULL,
  PasswordHash binary(64) DEFAULT NULL,
  IsFirstTimeLogin bit(1) DEFAULT NULL,
  PasswordSalt binary(128) DEFAULT NULL,
  PRIMARY KEY (UserID)
)
ENGINE = INNODB,
AVG_ROW_LENGTH = 1024,
CHARACTER SET utf8,
COLLATE utf8_bin;

--
-- Create foreign key
--
ALTER TABLE user_login
ADD CONSTRAINT FK_user_login_user_infor_UserID FOREIGN KEY (UserID)
REFERENCES user_infor (UserID) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Create table `process_execution`
--
CREATE TABLE process_execution (
  ProcessExecutionID int(11) NOT NULL AUTO_INCREMENT,
  ProcessExecutionName varchar(255) binary DEFAULT NULL,
  ProcessSettingID int(11) DEFAULT NULL,
  CurrentStepID int(11) DEFAULT NULL,
  OwnerID int(11) DEFAULT NULL,
  Status int(11) DEFAULT NULL,
  Priority int(11) DEFAULT NULL,
  CreatedDate datetime DEFAULT NULL,
  CompletedDate datetime DEFAULT NULL,
  PRIMARY KEY (ProcessExecutionID)
)
ENGINE = INNODB,
AUTO_INCREMENT = 48,
AVG_ROW_LENGTH = 8192,
CHARACTER SET utf8,
COLLATE utf8_bin;

--
-- Create foreign key
--
ALTER TABLE process_execution
ADD CONSTRAINT FK_process_execution_process_ProcessID FOREIGN KEY (ProcessSettingID)
REFERENCES process (ProcessID) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Create foreign key
--
ALTER TABLE process_execution
ADD CONSTRAINT FK_process_execution_process_step_ProcessStepID FOREIGN KEY (CurrentStepID)
REFERENCES process_step (ProcessStepID) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Create foreign key
--
ALTER TABLE process_execution
ADD CONSTRAINT FK_process_execution_user_infor_UserID FOREIGN KEY (OwnerID)
REFERENCES user_infor (UserID) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Create table `step_execution`
--
CREATE TABLE step_execution (
  StepExecutionID int(11) NOT NULL AUTO_INCREMENT,
  StepExecutionData longtext binary CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  ProcessExecutionID int(11) DEFAULT NULL,
  IsReject tinyint(1) DEFAULT NULL,
  RejectReason text binary CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  NextAssigneeID int(11) DEFAULT NULL,
  PrevAssigneeID int(11) DEFAULT NULL,
  CurrentAssigneeID int(11) DEFAULT NULL,
  CreatedDate datetime DEFAULT NULL,
  ProcessStepId int(11) DEFAULT NULL,
  IsExpire tinyint(1) DEFAULT NULL,
  CompletedDate datetime DEFAULT NULL,
  PRIMARY KEY (StepExecutionID)
)
ENGINE = INNODB,
AUTO_INCREMENT = 111,
AVG_ROW_LENGTH = 3276,
CHARACTER SET utf8,
COLLATE utf8_bin;

--
-- Create foreign key
--
ALTER TABLE step_execution
ADD CONSTRAINT FK_next_step_execution_user_infor_UserID FOREIGN KEY (NextAssigneeID)
REFERENCES user_infor (UserID) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Create foreign key
--
ALTER TABLE step_execution
ADD CONSTRAINT FK_prev_step_execution_user_infor_UserID FOREIGN KEY (PrevAssigneeID)
REFERENCES user_infor (UserID) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Create foreign key
--
ALTER TABLE step_execution
ADD CONSTRAINT FK_step_execution_process_execution_ProcessExecutionID FOREIGN KEY (ProcessExecutionID)
REFERENCES process_execution (ProcessExecutionID) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Create foreign key
--
ALTER TABLE step_execution
ADD CONSTRAINT FK_step_execution_process_step_ProcessStepID FOREIGN KEY (ProcessStepId)
REFERENCES process_step (ProcessStepID) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Create foreign key
--
ALTER TABLE step_execution
ADD CONSTRAINT FK_step_execution_user_infor_UserID FOREIGN KEY (CurrentAssigneeID)
REFERENCES user_infor (UserID) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Create table `user_group`
--
CREATE TABLE user_group (
  UserGroupID int(11) NOT NULL AUTO_INCREMENT,
  UserGroupName varchar(255) binary DEFAULT NULL,
  Description varchar(255) binary DEFAULT NULL,
  CreatedBy varchar(255) binary DEFAULT NULL,
  CreatedDate datetime DEFAULT NULL,
  ModifiedBy varchar(255) binary DEFAULT NULL,
  ModifiedDate datetime DEFAULT NULL,
  PRIMARY KEY (UserGroupID)
)
ENGINE = INNODB,
AUTO_INCREMENT = 4,
AVG_ROW_LENGTH = 8192,
CHARACTER SET utf8,
COLLATE utf8_bin;

--
-- Create table `user_group_detail`
--
CREATE TABLE user_group_detail (
  ID int(11) NOT NULL AUTO_INCREMENT,
  UserGroupID int(11) DEFAULT NULL,
  UserID int(11) DEFAULT NULL,
  CreatedBy varchar(255) binary DEFAULT NULL,
  CreatedDate datetime DEFAULT NULL,
  ModifiedBy varchar(255) binary DEFAULT NULL,
  ModifiedDate datetime DEFAULT NULL,
  PRIMARY KEY (ID)
)
ENGINE = INNODB,
AUTO_INCREMENT = 9,
AVG_ROW_LENGTH = 2048,
CHARACTER SET utf8,
COLLATE utf8_bin;

--
-- Create foreign key
--
ALTER TABLE user_group_detail
ADD CONSTRAINT FK_user_group_detail_user_group_UserGroupID FOREIGN KEY (UserGroupID)
REFERENCES user_group (UserGroupID) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Create foreign key
--
ALTER TABLE user_group_detail
ADD CONSTRAINT FK_user_group_detail_user_infor_UserID FOREIGN KEY (UserID)
REFERENCES user_infor (UserID) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Create table `step_assignee`
--
CREATE TABLE step_assignee (
  StepAssingeeID int(11) NOT NULL AUTO_INCREMENT,
  ProcessStepID int(11) DEFAULT NULL,
  UserID int(11) DEFAULT NULL,
  UserGroupID int(11) DEFAULT NULL,
  PRIMARY KEY (StepAssingeeID)
)
ENGINE = INNODB,
AUTO_INCREMENT = 32,
AVG_ROW_LENGTH = 1170,
CHARACTER SET utf8,
COLLATE utf8_bin;

--
-- Create foreign key
--
ALTER TABLE step_assignee
ADD CONSTRAINT FK_step_assignee_process_step_ProcessStepID FOREIGN KEY (ProcessStepID)
REFERENCES process_step (ProcessStepID) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Create foreign key
--
ALTER TABLE step_assignee
ADD CONSTRAINT FK_step_assignee_user_group_UserGroupID FOREIGN KEY (UserGroupID)
REFERENCES user_group (UserGroupID) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Create foreign key
--
ALTER TABLE step_assignee
ADD CONSTRAINT FK_step_assignee_user_infor_UserID FOREIGN KEY (UserID)
REFERENCES user_infor (UserID) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Create table `assignee_user`
--
CREATE TABLE assignee_user (
  AssingeeUserID int(11) NOT NULL AUTO_INCREMENT,
  ProcessStepID int(11) DEFAULT NULL,
  UserID varchar(255) binary DEFAULT NULL,
  CreatedBy varchar(255) binary DEFAULT NULL,
  CreatedDate datetime DEFAULT NULL,
  ModifiedBy varchar(255) binary DEFAULT NULL,
  ModifiedDate datetime DEFAULT NULL,
  PRIMARY KEY (AssingeeUserID)
)
ENGINE = INNODB,
CHARACTER SET utf8,
COLLATE utf8_bin;

-- 
-- Restore previous SQL mode
-- 
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;

-- 
-- Enable foreign keys
-- 
/*!40014 SET FOREIGN_KEY_CHECKS = @OLD_FOREIGN_KEY_CHECKS */;