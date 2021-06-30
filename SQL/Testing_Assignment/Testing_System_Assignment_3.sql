drop database if exists `Testing_System_Assignment_3`;
create database if not exists `Testing_System_Assignment_3`;
use `Testing_System_Assignment_1`;
use `Testing_System_Assignment_2`;

-- Question 2: lấy ra tất cả các phòng ban
select * from `department`;

-- Question 3: lấy ra id của phòng ban "Sale"
select DepartmentID from `department` where Sale;

-- Question 4: lấy ra thông tin account có full name dài nhất
select * from `account` where character_length(Fullname) = (select max(character_length(Fullname))from `account`);
select max(character_length(Fullname)) from `account`;

-- Question 5: lấy ra thông tin account có full name dài nhất và thuộc phòng ban có id = 3
select * from `account` where character_length(Fullname) = (select max(character_length(Fullname)) from `account` where AccountID in(3));

-- Question 6: Lấy ra tên group đã tham gia trước ngày 20/12/2019
select * from `group` where CreateDate < '2019-12-20';

-- Question 7: Lấy ra ID của question có >= 4 câu trả lời
select QuestionID from `answer` group by QuestionID having AnswerID >= 4;

-- Question 8: Lấy ra các mã đề thi có thời gian thi >= 60 phút và được tạo trước ngày 20/12/2019
select `Code` from `exam` group by Duration >= '60' and CreateDate < '2019-12-20';

-- Question 9: Lấy ra 5 group được tạo gần đây nhất
select * from `group` order by CreateDate asc limit 5;

-- Question 10: Đếm số nhân viên thuộc department có id = 2
select count(*) from `department` where DepartmentID in(2); 

-- Question 11: Lấy ra nhân viên có tên bắt đầu bằng chữ "D" và kết thúc bằng chữ "o"
select * from `account` where Fullname like 'D%o';

-- Question 12: Xóa tất cả các exam được tạo trước ngày 20/12/2019
delete from `exam` where CreateDate < '2019-12-20';

-- Question 13: Xóa tất cả các question có nội dung bắt đầu bằng từ "câu hỏi"
delete from `question` where Content like 'câu hỏi%';

-- Question 14: Update thông tin của account có id = 5 thành tên "Nguyễn Bá Lộc" và email thành loc.nguyenba@vti.com.vn
update `account` set Fullname = 'Nguyễn Bá Lộc', Email = 'loc.nguyenba@vti.com.vn' where AccountID in(5);

-- Question 15: update account có id = 5 sẽ thuộc group có id = 4
update `groupaccount` set GroupID = 4 where AccountID in(5);



