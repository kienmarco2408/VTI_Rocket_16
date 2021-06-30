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
    Fullname		varchar(50) not null,
    DepartmentID	TINYINT unsigned not null,
    PositionID		TINYINT unsigned not null,
    CreateDate		datetime default now(),
    foreign key (DepartmentID) references `Department` (DepartmentID),
    foreign key (PositionID) references `Position` (PositionID)
);
 create table `Group` (
	GroupID			TINYINT unsigned primary key auto_increment,
    GroupName		varchar(50) not null,
    CreatorID		TINYINT unsigned not null,
    CreateDate		datetime default now()
 );
 
 create table `GroupAccount` (
	GroupID			TINYINT unsigned not null,
    AccountID		TINYINT unsigned not null,
    JoinDate		datetime default now(),
	foreign key (GroupID) references `Group` (GroupID),
    foreign key (AccountID) references `Account` (AccountID)
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
    
    foreign key (CategoryID) references `CategoryQuestion` (CategoryID)
 );
 
 create table `Answer` (
	AnswerID		TINYINT unsigned primary key auto_increment,
    Content			nvarchar(225) not null,
    QuestionID		TINYINT unsigned not null,
    isCorrect		varchar(50) not null,
    
    foreign key (QuestionID) references `Question` (QuestionID)
 );
 
 create table `Exam` (
	ExamID			TINYINT unsigned primary key auto_increment,
    `Code`			varchar(50) not null,
    Title			varchar(50),
    CategoryID		TINYINT unsigned not null,
    Duration		varchar(50),
    CreatorID		TINYINT unsigned not null,
    CreateDate		datetime default now(),
    
    foreign key (CategoryID) references `CategoryQuestion` (CategoryID)
 );
 
 create table `ExamQuestion` (
	ExamID			TINYINT unsigned primary key,
    QuestionID		TINYINT unsigned not null,
    
    foreign key (ExamID) references `Exam` (ExamID),
    foreign key (QuestionID) references `Question` (QuestionID)
 );

 

