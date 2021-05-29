﻿--
-- Script was generated by Devart dbForge Studio 2019 for MySQL, Version 8.2.23.0
-- Product home page: http://www.devart.com/dbforge/mysql/studio
-- Script date 4/28/2021 10:46:07 AM
-- Server version: 5.5.5-10.3.23-MariaDB
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
AUTO_INCREMENT = 237,
AVG_ROW_LENGTH = 585,
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
  HasTask bit(1) DEFAULT NULL,
  AssigneeType int(11) DEFAULT NULL,
  HasField bit(1) DEFAULT NULL,
  ProcessID int(11) DEFAULT NULL,
  HasDeadline bit(1) DEFAULT NULL,
  DeadLine int(11) DEFAULT NULL,
  CreatedBy varchar(255) binary DEFAULT NULL,
  CreatedDate datetime DEFAULT NULL,
  ModifiedBy varchar(255) binary DEFAULT NULL,
  ModifiedDate datetime DEFAULT NULL,
  StepSortOrder int(11) DEFAULT NULL COMMENT ' = 1 là step đầu, = 2 là step cuối , còn lại step giữa',
  PRIMARY KEY (ProcessStepID)
)
ENGINE = INNODB,
AUTO_INCREMENT = 21,
AVG_ROW_LENGTH = 5461,
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
AUTO_INCREMENT = 27,
AVG_ROW_LENGTH = 5461,
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
  IsRequired bit(1) DEFAULT NULL,
  Type int(11) DEFAULT NULL,
  DataSetting longtext binary CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  ProcessStepID int(11) DEFAULT NULL,
  PRIMARY KEY (StepFieldID)
)
ENGINE = INNODB,
AUTO_INCREMENT = 21,
AVG_ROW_LENGTH = 1820,
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
AUTO_INCREMENT = 36,
AVG_ROW_LENGTH = 910,
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
  Password varchar(255) binary DEFAULT NULL,
  IsFirstTimeLogin bit(1) DEFAULT NULL,
  PRIMARY KEY (UserID)
)
ENGINE = INNODB,
AVG_ROW_LENGTH = 8192,
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
  PRIMARY KEY (ProcessExecutionID)
)
ENGINE = INNODB,
AUTO_INCREMENT = 13,
AVG_ROW_LENGTH = 1820,
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
  IsReject bit(1) DEFAULT NULL,
  RejectReason text binary CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  NextAssigneeID int(11) DEFAULT NULL,
  PrevAssigneeID int(11) DEFAULT NULL,
  CurrentAssigneeID int(11) DEFAULT NULL,
  CreatedDate datetime DEFAULT NULL,
  ProcessStepId int(11) DEFAULT NULL,
  PRIMARY KEY (StepExecutionID)
)
ENGINE = INNODB,
AUTO_INCREMENT = 25,
AVG_ROW_LENGTH = 1365,
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
AUTO_INCREMENT = 7,
AVG_ROW_LENGTH = 2730,
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
-- Dumping data for table process_group
--
INSERT INTO process_group VALUES
(1, 'Khác', NULL, NULL, NULL, NULL),
(2, 'Tài sản', NULL, NULL, NULL, NULL),
(3, 'Nhân sự', NULL, NULL, NULL, NULL);

-- 
-- Dumping data for table role
--
INSERT INTO role VALUES
(1, 'sys_admin'),
(2, 'manager'),
(3, 'employee');

-- 
-- Dumping data for table process
--
INSERT INTO process VALUES
(1, 'Quy trình test 123', NULL, 2, 'Trải nghiệm Đà Lạt "nguy hiểm" bạn chưa từng biết: Đu dây leo cây như Spider-Man, 4 giờ sáng chèo thuyền kinh hoàng!', 2, NULL, '2021-04-07 19:39:00', NULL, '2021-04-07 19:39:00'),
(2, 'Quy trình test 2345', NULL, 2, 'Sed tempus elit in sem tempus, at laoreet massa vestibulum. Donec mattis pretium felis quis sodales. Nam accumsan, sapien id accumsan molestie, mauris ex maximus ligula, at facilisis tortor lorem id felis. Ut suscipit leo ullamcorper, ullamcorper ligula a, accumsan lectus. Phasellus in malesuada risus, eget interdum libero. In consectetur vitae est interdum lacinia. Cras dictum sodales turpis pellentesque bibendum. Nulla facilisi. Interdum et malesuada fames ac ante ipsum primis in faucibus. Donec eu tellus vitae dui dictum laoreet in a dolor. Praesent sagittis pharetra sapien in bibendum. Donec quis ante nec orci placerat tincidunt non eu sem. Etiam nulla arcu, convallis quis diam quis, aliquam elementum nisi. Praesent ipsum risus, dictum et dui non, pellentesque fringilla est.', 1, NULL, '2021-04-07 19:30:33', NULL, '2021-04-07 19:30:33'),
(3, 'Quy trình cấp tài sản', NULL, 3, 'Fusce vitae orci a tortor dignissim gravida. Donec suscipit massa dolor, sed pharetra elit maximus a. Suspendisse eu porttitor ante. Phasellus sed molestie lectus, eu hendrerit turpis. Donec laoreet elementum sem eu venenatis. Vivamus vitae elementum eros. Suspendisse eget arcu sed erat tincidunt finibus. Praesent bibendum eu tortor ut sollicitudin.', 2, 'Nguyễn Viêt Nam', '2021-03-30 00:00:00', NULL, NULL),
(4, 'Quy trình nghỉ việc', NULL, 4, 'Sed lorem quam, suscipit in orci at, commodo egestas risus. Donec pulvinar felis ac dolor sagittis tempor. Vestibulum sed aliquet purus. Sed diam tellus, suscipit non velit vel, bibendum porttitor ipsum. Curabitur ultricies orci diam, ac lobortis nulla cursus ac. Fusce sapien urna, molestie eget luctus eu, molestie vel justo. Aliquam mi enim, iaculis a pellentesque eu, euismod in lacus. Pellentesque ac vestibulum nulla, ac tristique diam. Sed non ex vitae ante interdum aliquet sit amet vitae tortor. Nunc ultrices pretium nunc eu interdum. Donec lectus lacus, eleifend quis orci nec, ultricies finibus nulla. Integer vitae tellus sem.', 2, 'Nguyễn Viêt Nam', '2021-03-28 00:00:00', NULL, NULL),
(5, 'Quy trình xin cấp bảng điểm', NULL, 2, 'Proin dignissim tincidunt felis, eget volutpat metus pretium maximus. Praesent efficitur a nunc iaculis imperdiet. Maecenas ultricies, nibh a malesuada imperdiet, diam nisi cursus elit, nec vulputate orci nibh eleifend nibh. Ut eu vestibulum diam. Fusce orci odio, molestie sed nibh a, sodales consectetur arcu. Curabitur at diam sit amet magna volutpat congue. Nunc a elementum purus, sit amet commodo ipsum.', 2, 'Nguyễn Huy Nam', '2021-04-04 00:00:00', NULL, NULL),
(6, 'Test', NULL, 2, '        this.currentGroupSelected = this.listProcessGroup[0];\n', 2, NULL, NULL, NULL, NULL),
(7, 'Test', NULL, 2, '        this.currentGroupSelected = this.listProcessGroup[0];\n', 2, NULL, NULL, NULL, NULL),
(8, 'Test', NULL, 3, '        this.currentGroupSelected = this.listProcessGroup[0];\n', 2, NULL, '2021-04-06 18:55:28', NULL, '2021-04-06 18:55:28'),
(10, 'Quy trình ăn chơi nhảy múa 2', '', 2, 'Quy trình ăn chơi nhảy múa', 1, '', '2021-04-08 20:54:33', '', '2021-04-08 20:54:33'),
(11, 'Quy trình ăn chơi nhảy múa 3', '', 2, 'Quy trình ăn chơi nhảy múa', 1, '', '2021-04-08 20:54:33', '', '2021-04-08 20:54:33'),
(12, 'Quy trình ăn chơi nhảy múa ', '', 2, 'Quy trình ăn chơi nhảy múa', 1, '', '2021-04-08 20:54:33', '', '2021-04-08 20:54:33'),
(13, 'Quy trình ăn chơi nhảy múa ', '', 1, 'Quy trình ăn chơi nhảy múa', 1, '', '2021-04-08 20:54:33', '', '2021-04-08 20:54:33'),
(14, 'Quy trình ăn chơi nhảy múa ', '', 3, 'Quy trình ăn chơi nhảy múa', 1, '', '2021-04-08 20:54:33', '', '2021-04-08 20:54:33'),
(15, 'Quy trình ăn chơi nhảy múa 111', '', 1, 'Quy trình ăn chơi nhảy múa', 1, '', '2021-04-08 20:54:34', '', '2021-04-08 20:54:34'),
(16, 'Quy trình ăn chơi nhảy múa ', '', 2, 'Quy trình ăn chơi nhảy múa', 1, '', '2021-04-08 20:54:34', '', '2021-04-08 20:54:34'),
(17, 'Quy trình ăn chơi nhảy múa 11', '', 1, 'Quy trình ăn chơi nhảy múa', 1, '', '2021-04-08 20:54:34', '', '2021-04-08 20:54:34'),
(18, 'Quy trình ăn chơi nhảy múa ', '', 1, 'Quy trình ăn chơi nhảy múa', 1, '', '2021-04-08 20:54:34', '', '2021-04-08 20:54:34'),
(19, 'Quy trình ăn chơi nhảy múa 6', '', 2, 'Quy trình ăn chơi nhảy múa', 1, '', '2021-04-08 20:54:34', '', '2021-04-08 20:54:34'),
(20, 'Quy trình ăn chơi nhảy múa ', '', 3, 'Quy trình ăn chơi nhảy múa', 1, '', '2021-04-08 20:54:34', '', '2021-04-08 20:54:34'),
(21, 'Quy trình ăn chơi nhảy múa ', '', 2, 'Quy trình ăn chơi nhảy múa', 1, '', '2021-04-08 20:54:35', '', '2021-04-08 20:54:35'),
(22, 'Quy trình ăn chơi nhảy múa ', '', 1, 'Quy trình ăn chơi nhảy múa', 1, '', '2021-04-08 20:54:35', '', '2021-04-08 20:54:35'),
(23, 'Quy trình ăn chơi nhảy múa 4', '', 4, 'Quy trình ăn chơi nhảy múa', 1, '', '2021-04-08 20:54:35', '', '2021-04-08 20:54:35'),
(24, 'Quy trình ăn chơi nhảy múa ', '', 2, 'Quy trình ăn chơi nhảy múa', 1, '', '2021-04-08 20:54:35', '', '2021-04-08 20:54:35'),
(25, 'Quy trình ăn chơi nhảy múa ', '', 3, 'Quy trình ăn chơi nhảy múa', 1, '', '2021-04-08 20:54:36', '', '2021-04-08 20:54:36'),
(26, 'Quy trình xin nghỉ ốm1', NULL, 1, 'Quy trình cho nhân viên nghỉ ốm', 3, NULL, '2021-04-18 18:24:28', NULL, '2021-04-18 18:24:28'),
(236, 'Quy trình ăn chơi nhảy múa 1', '', 1, 'Quy trình ăn chơi nhảy múa', 1, '', '2021-04-08 20:54:25', '', '2021-04-08 20:54:25');

-- 
-- Dumping data for table user_infor
--
INSERT INTO user_infor VALUES
(1, 'Nguyễn Huy Việt', 'nhviet@abc.com', '2021-04-20', '012345678', 'Ha Noi', 3, NULL, NULL, NULL, NULL),
(2, 'Quản lý ', 'qly@abc.com', '1999-07-06', '0987654321', 'Ha Noi', 2, NULL, NULL, NULL, NULL),
(3, 'Quản trị hệ thống', 'admin@abc.com', NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL),
(20, 'Nguyễn Văn An', 'nvan@gmail.com', '2021-04-16', '', '', 3, '', '2021-04-16 13:04:52', '', '2021-04-16 13:04:52'),
(21, 'Nguyễn Văn Toàn', 'nvan@gmail.com', '2021-04-16', '', '', 3, '', '2021-04-16 13:04:59', '', '2021-04-16 13:04:59'),
(22, 'Nguyễn Huy Hoàng', 'nvan@gmail.com', '2021-04-16', '', '', 3, '', '2021-04-16 13:05:06', '', '2021-04-16 13:05:06'),
(23, 'Hoàng Hà Phương', 'nvan@gmail.com', '2021-04-16', '', '', 3, '', '2021-04-16 13:05:16', '', '2021-04-16 13:05:16'),
(24, 'Bùi Văn Tuấn', 'nvan@gmail.com', '2021-04-16', '', '', 3, '', '2021-04-16 13:05:23', '', '2021-04-16 13:05:23'),
(25, 'Bùi Văn Tuấn', 'bvtuan@gmail.com', '2021-04-16', '', '', 3, '', '2021-04-16 13:05:31', '', '2021-04-16 13:05:31'),
(26, 'Bùi Văn Tuấn', 'tuan@gmail.com', '2021-04-16', '', '', 3, '', '2021-04-16 13:05:39', '', '2021-04-16 13:05:39'),
(27, 'Nguyễn Phương Thảo', 'npthao@gmail.com', '2021-04-16', '', '', 3, '', '2021-04-16 13:05:51', '', '2021-04-16 13:05:51'),
(28, 'Cao Việt Dũng', 'cvdung@gmail.com', '2021-04-16', '', '', 3, '', '2021-04-16 13:06:01', '', '2021-04-16 13:06:01'),
(29, 'Cao Văn Cường', 'cvcuong@gmail.com', '2021-04-16', '', '', 3, '', '2021-04-16 13:06:10', '', '2021-04-16 13:06:10'),
(30, 'Hồ Quang Hiếu', 'hqhieu@gmail.com', '2021-04-16', '', '', 3, '', '2021-04-16 13:06:34', '', '2021-04-16 13:06:34'),
(31, 'Châu Việt Cường', 'cvcuong1@gmail.com', '2021-04-16', '', '', 3, '', '2021-04-16 13:06:51', '', '2021-04-16 13:06:51'),
(32, 'Thùy Chi', 'chipau@gmail.com', '2021-04-16', '', '', 3, '', '2021-04-16 13:07:06', '', '2021-04-16 13:07:06'),
(33, 'Khac Việt', 'kv@gmail.com', '2021-04-16', '', '', 3, '', '2021-04-16 13:07:16', '', '2021-04-16 13:07:16'),
(34, 'Nguyễn Thành Nam', 'ntn@gmail.com', '2021-04-16', '', '', 3, '', '2021-04-16 13:07:27', '', '2021-04-16 13:07:27'),
(35, 'Nguyễn Đức Việt', 'ndviet@gmail.com', '2021-04-16', '', '', 3, '', '2021-04-16 13:07:38', '', '2021-04-16 13:07:38');

-- 
-- Dumping data for table process_step
--
INSERT INTO process_step VALUES
(1, 'Lập đơn xin nghỉ', 1, 'Người dùng vào tạo đơn xin nghỉ', True, NULL, True, 26, NULL, NULL, NULL, '2021-04-27 11:16:04', NULL, '2021-04-27 11:16:04', 1),
(2, 'Quản lý phê duyệt', 3, 'Quản lý vào phê duyệt đơn', True, NULL, True, 26, True, 1440, NULL, '2021-04-27 13:24:43', NULL, '2021-04-27 13:24:43', 2),
(3, 'Quản lý nhân sự phê duyệt', 2, 'Quản lý vào phê duyệt đơn', NULL, NULL, NULL, 26, NULL, NULL, NULL, '2021-04-18 18:12:55', NULL, '2021-04-18 18:12:55', 3);

-- 
-- Dumping data for table process_execution
--
INSERT INTO process_execution VALUES
(3, 'Quy trình xin nghỉ ốm1', 26, NULL, 1, 3, NULL, '2021-04-21 18:17:03'),
(4, 'Quy trình xin nghỉ ốm1', 26, 2, 1, 1, NULL, '2021-04-21 18:17:07'),
(5, 'Quy trình xin nghỉ ốm1', 26, NULL, 1, 3, NULL, '2021-04-21 18:17:16'),
(7, 'Quy trình xin nghỉ ốm1', 26, 2, 1, 3, NULL, '2021-04-26 14:43:41'),
(8, 'Quy trình xin nghỉ ốm1', 26, 2, 1, NULL, NULL, '2021-04-27 11:11:47'),
(9, 'Quy trình xin nghỉ ốm1', 26, 2, 1, NULL, NULL, '2021-04-27 11:18:18'),
(10, 'Quy trình xin nghỉ ốm1', 26, 2, 1, NULL, NULL, '2021-04-27 11:19:51'),
(11, 'Quy trình xin nghỉ ốm1', 26, 2, 1, NULL, NULL, '2021-04-27 11:28:54'),
(12, 'Quy trình xin nghỉ ốm1', 26, 2, 1, NULL, NULL, '2021-04-27 11:33:48');

-- 
-- Dumping data for table user_group
--
INSERT INTO user_group VALUES
(1, 'Quản lý phòng nhân sự', NULL, NULL, NULL, NULL, NULL),
(2, 'Nhân viên hành chính', NULL, NULL, NULL, NULL, NULL),
(3, 'Giảng viên', NULL, NULL, NULL, NULL, NULL);

-- 
-- Dumping data for table user_login
--
INSERT INTO user_login VALUES
(1, 'nhviet', '12345', NULL),
(2, 'quanly', '12345', NULL),
(3, 'admin', '12345', NULL);

-- 
-- Dumping data for table user_group_detail
--
INSERT INTO user_group_detail VALUES
(1, 1, 24, NULL, NULL, NULL, NULL),
(2, 1, 27, NULL, NULL, NULL, NULL),
(3, 1, 26, NULL, NULL, NULL, NULL),
(4, 1, 30, NULL, NULL, NULL, NULL),
(5, 1, 34, NULL, NULL, NULL, NULL),
(6, 2, 29, NULL, NULL, NULL, NULL),
(7, 2, 24, NULL, NULL, NULL, NULL),
(8, 3, 23, NULL, NULL, NULL, NULL);

-- 
-- Dumping data for table step_task
--
INSERT INTO step_task VALUES
(2, 'phát triển bối cảnh trong game, bao gồm khung cảnh, môi trường, nhà cây cối trong Thần Trùng', 2, 2),
(17, '1', 2, 2),
(26, '1234', 1, 1);

-- 
-- Dumping data for table step_field
--
INSERT INTO step_field VALUES
(12, 'text', 0, '', True, 1, '{"Placeholder":"","LinkName":"","LinkTo":"","ListOption":[]}', 2),
(13, 'longtext', 0, '', False, 1, '{"Placeholder":"","LinkName":"","LinkTo":"","ListOption":[]}', 2),
(14, 'hour', 0, '', True, 3, '{"Placeholder":"","LinkName":"","LinkTo":"","ListOption":[]}', 2),
(15, 'date', 0, '', True, 4, '{"Placeholder":"","LinkName":"","LinkTo":"","ListOption":[]}', 2),
(16, 'datetime', 0, '', False, 5, '{"Placeholder":"","LinkName":"","LinkTo":"","ListOption":[]}', 2),
(17, 'dropdown', 0, '', True, 7, '{"Placeholder":"","LinkName":"","LinkTo":"","ListOption":[{"OptionId":"e6f8cea7-79a0-4048-870c-c135c446f409","OptionName":"1"},{"OptionId":"5a62456d-1929-49ed-9ca0-5738175661bc","OptionName":"2"}]}', 2),
(18, 'check', 0, '', False, 8, '{"Placeholder":"","LinkName":"","LinkTo":"","ListOption":[{"OptionId":"beaa3ead-eda9-45aa-a47f-38c8d049ce97","OptionName":"1"},{"OptionId":"5e499e8a-e2d7-43b2-8336-5c394b7b8ea5","OptionName":"2"}]}', 2),
(19, 'check', 0, '', False, 8, '{"Placeholder":"","LinkName":"","LinkTo":"","ListOption":[{"OptionId":"a05e0bf6-27e1-4fdb-9b38-f71a95c3e96b","OptionName":"hello"},{"OptionId":"e9d1ed91-bb81-46c8-8655-1a184067c6ed","OptionName":"hi"}]}', 1),
(20, 'Dropdown', 0, '', False, 7, '{"Placeholder":"","LinkName":"","LinkTo":"","ListOption":[{"OptionId":"8c547345-e870-41eb-b0de-179b7b2cdf29","OptionName":"dropdown1"},{"OptionId":"6729c7a6-33de-4850-b517-781bbb2e064a","OptionName":"dropdown2"}]}', 1);

-- 
-- Dumping data for table step_execution
--
INSERT INTO step_execution VALUES
(12, '[{"StepFieldId":7,"Value":"Em xin 1 điều ước"},{"StepFieldId":8,"Value":"2021-04-11T17:02:00.000Z"},{"StepFieldId":9,"Value":"2021-04-26T14:43:26.931Z"},{"StepFieldId":10,"Value":"Cho anh bỉnh yên"},{"StepFieldId":11,"Value":"2021-04-26T14:43:24.834Z"}]', 7, NULL, NULL, 29, NULL, 1, '2021-04-26 14:43:41', 1),
(13, '[{"StepFieldId":1,"Value":"xin chào cả nhà"}]', 7, NULL, NULL, NULL, 1, 29, '2021-04-26 14:43:41', 2),
(15, '[{"StepFieldId":7,"Value":null},{"StepFieldId":8,"Value":null},{"StepFieldId":9,"Value":null},{"StepFieldId":10,"Value":null},{"StepFieldId":11,"Value":null},{"StepFieldId":19,"ListOptionValue":[{"OptionId":"6e446e82-3e16-4a92-bf07-f9f227c47cdc","Value":null},{"OptionId":"9ed6698d-5206-4998-a87f-b06e2030db95","Value":null}]}]', 8, NULL, NULL, 29, NULL, 1, '2021-04-27 11:11:47', 1),
(16, NULL, 8, NULL, NULL, NULL, NULL, 29, '2021-04-27 11:11:47', 2),
(17, '[{"StepFieldId":19,"ListOptionValue":[{"OptionId":"a05e0bf6-27e1-4fdb-9b38-f71a95c3e96b","Value":null},{"OptionId":"e9d1ed91-bb81-46c8-8655-1a184067c6ed","Value":null}]},{"StepFieldId":20,"Value":"8c547345-e870-41eb-b0de-179b7b2cdf29"}]', 9, NULL, NULL, 29, NULL, 1, '2021-04-27 11:18:18', 1),
(18, NULL, 9, NULL, NULL, NULL, NULL, 29, '2021-04-27 11:18:18', 2),
(19, '[{"StepFieldId":19,"ListOptionValue":[{"OptionId":"a05e0bf6-27e1-4fdb-9b38-f71a95c3e96b","Value":null},{"OptionId":"e9d1ed91-bb81-46c8-8655-1a184067c6ed","Value":null}]},{"StepFieldId":20,"Value":"6729c7a6-33de-4850-b517-781bbb2e064a"}]', 10, NULL, NULL, 29, NULL, 1, '2021-04-27 11:19:51', 1),
(20, NULL, 10, NULL, NULL, NULL, NULL, 29, '2021-04-27 11:19:51', 2),
(21, '[{"StepFieldId":19,"ListOptionValue":[{"OptionId":"a05e0bf6-27e1-4fdb-9b38-f71a95c3e96b","Value":null},{"OptionId":"e9d1ed91-bb81-46c8-8655-1a184067c6ed","Value":null}]},{"StepFieldId":20,"Value":"6729c7a6-33de-4850-b517-781bbb2e064a"}]', 11, NULL, NULL, 29, NULL, 1, '2021-04-27 11:28:54', 1),
(22, NULL, 11, NULL, NULL, NULL, NULL, 29, '2021-04-27 11:28:54', 2),
(23, '[{"StepFieldId":19,"ListOptionValue":[{"OptionId":"a05e0bf6-27e1-4fdb-9b38-f71a95c3e96b","Value":true,"Checked":true},{"OptionId":"e9d1ed91-bb81-46c8-8655-1a184067c6ed","Value":false,"Checked":false}]},{"StepFieldId":20,"Value":"6729c7a6-33de-4850-b517-781bbb2e064a"}]', 12, NULL, NULL, 29, NULL, 1, '2021-04-27 11:33:48', 1),
(24, NULL, 12, NULL, NULL, NULL, NULL, 29, '2021-04-27 11:33:48', 2);

-- 
-- Dumping data for table step_assignee
--
INSERT INTO step_assignee VALUES
(1, 2, 30, NULL),
(2, 2, 35, NULL),
(3, 2, NULL, 1),
(4, 2, 25, NULL),
(5, 3, 24, NULL),
(6, 3, NULL, 2);

-- 
-- Dumping data for table assignee_user
--
-- Table process_management.assignee_user does not contain any data (it is empty)

-- 
-- Restore previous SQL mode
-- 
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;

-- 
-- Enable foreign keys
-- 
/*!40014 SET FOREIGN_KEY_CHECKS = @OLD_FOREIGN_KEY_CHECKS */;