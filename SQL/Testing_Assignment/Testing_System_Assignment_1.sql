drop database if exists	`Testing_System_Assignment_1`;
create database if not exists  `Testing_System_Assignment_1`;
use `Testing_System_Assignment_1`;

# CREATE TABLE Phòng Ban
DROP TABLE IF EXISTS `Department`;
CREATE TABLE IF NOT EXISTS `Department`
(
    `DepartmentID`   TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    `DepartmentName` VARCHAR(50) NOT NULL
);

# CREATE TABLE Chức vụ
DROP TABLE IF EXISTS `Position`;
CREATE TABLE IF NOT EXISTS `Position`
(
    `PositionID`   TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    `PositionName` ENUM ('Dev 1', 'Dev 2', 'Tester', 'PM', 'Mentor', 'Scrum Master', 'Giám đốc', 'Thư ký', 'Developer')
);

# CREATE TABLE Tài khoản
DROP TABLE IF EXISTS `Account`;
CREATE TABLE IF NOT EXISTS `Account`
(
    `AccountId`    TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    `Email`        VARCHAR(50) UNIQUE KEY,
    `UserName`     VARCHAR(50) NOT NULL UNIQUE KEY,
    `FullName`     VARCHAR(50),
    `DepartmentId` TINYINT,
    `PositionID`   TINYINT,
    `CreateDate`   DATETIME DEFAULT NOW()
#     CONSTRAINT pk PRIMARY KEY (AccountId)
);

# CREATE TABLE Nhóm
DROP TABLE IF EXISTS `Group`;
CREATE TABLE IF NOT EXISTS `Group`
(
    `GroupID`    TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    `GroupName`  VARCHAR(50),
    `CreatorID`  TINYINT UNSIGNED,
    `CreateDate` DATETIME DEFAULT NOW()
);

# CREATE TABLE Nhóm Tài Khoản
DROP TABLE IF EXISTS `GroupAccount`;
CREATE TABLE IF NOT EXISTS `GroupAccount`
(
    `GroupID`   TINYINT UNSIGNED,
    `AccountID` TINYINT UNSIGNED,
    `JoinDate`  DATETIME DEFAULT NOW()
);

# CREATE TABLE Loại câu hỏi
DROP TABLE IF EXISTS `TypeQuestion`;
CREATE TABLE IF NOT EXISTS `TypeQuestion`
(
    `TypeID`   TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    `TypeName` VARCHAR(50)
);

# CREATE TABLE loại câu hỏi
DROP TABLE IF EXISTS `CategoryQuestion`;
CREATE TABLE IF NOT EXISTS `CategoryQuestion`
(
    `CategoryID`   TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    `CategoryName` VARCHAR(50) NOT NULL UNIQUE KEY
);

# CREATE TABLE Câu hỏi
DROP TABLE IF EXISTS `Question`;
CREATE TABLE IF NOT EXISTS `Question`
(
    `QuestionID` TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    `Content`    VARCHAR(100),
    `CategoryID` TINYINT UNSIGNED,
    `TypeID`     TINYINT UNSIGNED,
    `CreatorID`  TINYINT UNSIGNED NOT NULL,
    `CreateDate` DATETIME DEFAULT NOW()
);

# CREATE TABLE Câu trả lời
DROP TABLE IF EXISTS `Answer`;
CREATE TABLE IF NOT EXISTS `Answer`
(
    `AnswerID`   TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    `Content`    VARCHAR(100),
    `QuestionID` TINYINT UNSIGNED NOT NULL,
    `isCorrect`  BIT,
    CONSTRAINT fk_question FOREIGN KEY (QuestionID) REFERENCES Question (QuestionID)
);

# CREATE TABLE Đề thi
DROP TABLE IF EXISTS `Exam`;
CREATE TABLE IF NOT EXISTS `Exam`
(
    `ExamID`     TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    `Code`       VARCHAR(50) UNIQUE,
    `Title`      VARCHAR(50),
    `CategoryID` TINYINT UNSIGNED,
    `Duration`   TINYINT,
    `CreatorID`  TINYINT UNSIGNED,
    `CreateDate` DATETIME DEFAULT NOW()
#     ,CONSTRAINT fk_create_id FOREIGN KEY (CategoryID) REFERENCES Account (AccountId),
#     CONSTRAINT fk_category_id FOREIGN KEY (CategoryID) REFERENCES CategoryQuestion (CategoryID)
);

# CREATE TABLE Bộ câu hỏi
DROP TABLE IF EXISTS `ExamQuestion`;
CREATE TABLE IF NOT EXISTS `ExamQuestion`
(
    `ExamID`     TINYINT,
    `QuestionID` TINYINT
);


 

