drop database if exists	`Testing_System_Assignment_1`;
create database if not exists  `Testing_System_Assignment_1`;
use `Testing_System_Assignment_1`;

create table `Department` (
	DepartmentID	TINYINT unsigned primary key auto_increment,
    DepartmentName	Nvarchar(50) not null
);

create table `Position` (
	PositionID		TINYINT unsigned primary key auto_increment,
    PositionName	enum('Dev', 'Test', 'Scrum Master', 'PM') unique key not null
);

create table `Account` (
	AccountID		TINYINT unsigned primary key auto_increment,
    Email			varchar(50) not null,
    Username		varchar(50) not null,
    Fullname		nvarchar(50) not null,
    DepartmentID	TINYINT unsigned not null,
    PositionID		TINYINT unsigned not null,
    CreateDate		datetime default now(),
    constraint fk_account foreign key (DepartmentID) references `Department` (DepartmentID),
    constraint fk_account1 foreign key (PositionID) references `Position` (PositionID)
);
 create table `Group` (
	GroupID			TINYINT unsigned primary key auto_increment,
    GroupName		varchar(50) not null,
    CreatorID		TINYINT unsigned not null,
    CreateDate		datetime default now(),
    
    constraint fk_group foreign key (CreatorID) references `Account` (AccountID)
 );
 
 create table `GroupAccount` (
	GroupID			TINYINT unsigned not null,
    AccountID		TINYINT unsigned not null,
    JoinDate		datetime default now(),
	constraint fk_groupaccount foreign key (GroupID) references `Group` (GroupID),
    constraint fk_groupaccount1 foreign key (AccountID) references `Account` (AccountID)
 );

create table `TypeQuestion` (
	TypeID			TINYINT  unsigned  primary key auto_increment,
    TypeName		enum('Essay', 'Mutiple-Choice') unique key not null
);
 create table `CategoryQuestion` (
	CategoryID		TINYINT unsigned primary key auto_increment,
    CategoryName	enum('Java', '.NET','SQL', 'Postman','Ruby','...') unique key not null
 );
 
 create table `Question` (
	QuestionID		TINYINT unsigned primary key auto_increment,
    Content			nvarchar(50) not null,
    CategoryID		TINYINT unsigned not null,
    TypeID			TINYINT unsigned not null,
    CreatorID		TINYINT	unsigned not null,
    CreateDate		datetime default now(),
    
    constraint fk_question foreign key (CategoryID) references `CategoryQuestion` (CategoryID),
    constraint fk_question1 foreign key (CreatorID) references `Account` (AccountID)
 );
 
 create table `Answer` (
	AnswerID		TINYINT unsigned primary key auto_increment,
    Content			nvarchar(225) not null,
    QuestionID		TINYINT unsigned not null,
    isCorrect		varchar(50) not null,
    
    constraint fk_answer foreign key (QuestionID) references `Question` (QuestionID)
 );
 
 create table `Exam` (
	ExamID			TINYINT unsigned primary key auto_increment,
    `Code`			varchar(50) not null,
    Title			varchar(50),
    CategoryID		TINYINT unsigned not null,
    Duration		int unsigned not null,
    CreatorID		TINYINT unsigned not null,
    CreateDate		datetime default now(),
    
    constraint fk_exam foreign key (CategoryID) references `CategoryQuestion` (CategoryID),
    constraint fk_exam1 foreign key (CreatorID) references `Account` (AccountID)
 );
 
 create table `ExamQuestion` (
	ExamID			TINYINT unsigned ,
    QuestionID		TINYINT unsigned ,
    
    constraint pk_examquestion primary key (ExamID, QuestionID),
    constraint fk_examquestion foreign key (ExamID) references `Exam` (ExamID),
    constraint fk_examquestion2 foreign key (QuestionID) references `Question` (QuestionID)
 );

 

