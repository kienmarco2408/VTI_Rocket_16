drop database if exists `Testing_System_Assignment_2`;
create database if not exists  `Testing_System_Assignment_2`;
use `Testing_System_Assignment_1`;

insert into `department`(DepartmentName)
values					
						('Marketing'	),
                        ('Sale'			),
                        (N'Bảo vệ'		),
                        (N'Nhân sự'		),
                        (N'Kỹ thuật'		),
                        (N'Tài chính'	),
                        (N'Phó giám đốc'	),
                        (N'Giám đốc'		),
                        (N'Thư ký'		),
                        (N'Bán hàng'		);
 

insert into `position`(PositionName)
values
					  ('Dev'		),
					  ('Test'		),
					  ('Scrum Master'),
					  ('PM'			);



insert into `account`(Email					  	   , Username         , Fullname	   , DepartmentID , PositionID, CreateDate		)
values		
					 ('kienmarco999@gmail.com'     ,'kientran2408'    , 'Tran Van Kien', 	  5	  ,	    1  ,	'2017-08-24'),
                     ('johnmartin23@gmail.com'     ,'johnmartin23'    , 'John Martin'  , 	  2	  ,	    2   ,	'2020-02-23'),
                     ('kevinphillip42@gmail.com'   ,'kevinphi4299'    , 'Kevin Phillip', 	  6	  ,	    3   ,	'2018-04-02'),
                     ('harryparker33@gmail.com'    ,'harryparker33'   , 'Harry Parker' , 	  9	  ,	    4   ,	'2019-03-03'),
                     ('peterkrush18@gmail.com'     ,'peterkrush18'    , 'Peter Krush'  , 	  7	  ,	    1   ,	'2017-07-18'),
                     ('henrypham65@gmail.com'      ,'henrypham65'     , 'Henry Pham'   , 	  8	  ,	    4   ,	'2016-06-05'),
                     ('robertroger97@gmail.com'    ,'robertroger97'   , 'Robert Roger' , 	  5	  ,	    2   ,	'2019-07-24'),
                     ('samwillson123@gmail.com'    ,'samwillson123'   , 'Sam Willson'  , 	  2   ,	    2   ,	'2020-01-23');


insert into `group` (GroupName, CreatorID, CreateDate  )
values
					('London' ,    1   ,'2020-03-24' ),
                    ('Paris'  ,    2   ,'2020-04-21' ),
                    ('Moscow' ,    3   ,'2020-05-27' ),
                    ('Berlin' ,    4   ,'2020-06-12' ),
                    ('Tokyo'  ,    5   ,'2020-07-16' );


insert into `groupaccount` (GroupID, AccountID, JoinDate)
values
						   (   1 ,    1   , '2020-03-25'),
                           (   3 ,    2   , '2020-05-28'),
                           (   5 ,    3   , '2020-07-17'),
                           (   1 ,    4   , '2020-03-26'),
                           (   2 ,    5   , '2020-04-22'),
                           (   4 ,    6   , '2020-06-13'),
                           (   4 ,    7   , '2020-06-13'),
                           (   1 ,    8   , '2020-03-30');


insert into `typequestion`(TypeName)
values
						('Essay'),
						('Mutiple-Choice');


insert into `categoryquestion`  (CategoryName)
values
								('Java'	 	 ),
                                ('.NET'	 	 ),
                                ('SQL '	 	 ),
                                ('Postman'	 ),
                                ('Ruby'		 );


insert into `question` (Content, CategoryID, TypeID, CreatorID, CreateDate  )
values
					   ('SQL là gì?', 3, 1, 1, '2020-09-12'),
                       ('Có bao nhiêu loại kiểu dữ liệu number ?', 3, 2, 2, '2020-09-13'),
                       ('Lập trình Java là gì ?', 1, 1, 1, '2020-09-12'),
                       ('Java sử dụng để làm gì ?', 1, 2, 1, '2020-09-12'),
                       ('.NET là gì và sử dụng chủ yếu để làm gì ?', 2, 1, 2, '2020-09-13');
 

insert into `answer`(Content, QuestionID, isCorrect )
values
					(N'SQL là ngôn ngữ truy vấn dữ liệu', 1, 'yes'),
                    (N'Có tổng cộng 5 loại kiểu dữ liệu number', 2, 'yes'),
                    (N'Java là ngôn ngữ lập trình hướng đối tượng, bậc thấp', 3, 'no'),
                    (N'Java dùng để thiết kế app, website, robot,... ', 4, 'yes'),
                    (N'.NET là một phần mềm chạy chủ yếu trên Microsoft và chủ yếu dùng làm web ', 1, 'yes');


insert into `exam`  (`Code`  , Title , CategoryID , Duration  , CreatorID , CreateDate )
values
					('VTI1', 'SQL' ,'3','30 phút',1	,'2020-10-12'),
					('VTI2', 'Java','1','30 phút',1	,'2020-10-12'),
                    ('VTI3', 'SQL' ,'3','30 phút',1	,'2020-10-12'),
                    ('VTI4', '.NET','2','30 phút',2	,'2020-10-12'),
                    ('VTI5', 'SQL' ,'3','30 phút',2	,'2020-10-12');


insert into `examquestion`	(ExamID, QuestionID)
values
							(1, 1),
                            (2, 2),
                            (3, 3),
                            (4, 4),
                            (5, 5);
