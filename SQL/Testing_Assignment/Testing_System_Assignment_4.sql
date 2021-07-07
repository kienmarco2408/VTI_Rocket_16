drop database if exists `Testing_System_Assignment_4`;
create table if not exists `Testing_System_Assignment_4`;
use `Testing_System_Assignment_1`;
use `Testing_System_Assignment_2`;

-- Exercise 1: Join
-- Question 1: Viết lệnh để lấy ra danh sách nhân viên và thông tin phòng ban của họ
select a.FullName, b.DepartmentName
from `account` a join `department` b 
on a.DepartmentID = b.DepartmentID;

-- Question 2: Viết lệnh để lấy ra thông tin các account được tạo sau ngày 20/12/2010
select * from `account` 
where CreateDate > 2010-12-20;

-- Question 3: Viết lệnh để lấy ra tất cả các developer
select a.FullName, b.PositionName
from `account` a join `position` b
on a.PositionID = b.PositionID
where a.PositionID = (select PositionID from `position` where PositionName like 'Developer');

select a.FullName, b.PositionName
from `account` a join `position` b
on a.PositionID = b.PositionID
where PositionName = 'Developer';

-- Question 4: Viết lệnh để lấy ra danh sách các phòng ban có >3 nhân viên
select a.DepartmentName, count(b.DepartmentId) as 'So luong'
from `department` a join `account` b
on a.DepartmentId = b.DepartmentId
group by a.DepartmentName having count(b.DepartmentId) > 3;

-- Question 5: Viết lệnh để lấy ra danh sách câu hỏi được sử dụng trong đề thi nhiều nhất
select a.Content, count(b.QuestionID) as 'so luong'
from `question` a join `examquestion` b
on a.QuestionID = b.QuestionID
group by Content
order by count(b.QuestionID) desc limit 1;

-- Question 6: Thông kê mỗi category Question được sử dụng trong bao nhiêu Question
select a.CategoryName, count(b.QuestionID) as 'so luong'
from `categoryquestion` a join `question` b
on a.CategoryID = b.CategoryID
group by CategoryName
order by count(b.QuestionID) asc ;

-- Question 7: Thông kê mỗi Question được sử dụng trong bao nhiêu Exam
select a.Content, count(b.ExamID) as 'so luong'
from `question` a join `examquestion` b
on a.QuestionID = b.QuestionID
group by Content
order by count(b.ExamID) asc;

-- Question 8: Lấy ra Question có nhiều câu trả lời nhất
select a.Content, count(b.AnswerID) as 'so luong'
from `question` a join `answer` b
on a.QuestionID = b.QuestionID
group by Content
order by count(b.AnswerID) desc limit 1;

-- Question 9: Thống kê số lượng account trong mỗi group
select a.GroupName, count(b.AccountID) as 'so luong'
from `group` a join `groupaccount` b
on a.GroupID = b.GroupID
group by GroupName
order by count(b.AccountID) asc;

-- Question 10: Tìm chức vụ có ít người nhất
select a.PositionName, count(b.AccountID) as'so luong'
from `position` a join `account` b
on a.PositionID = b.PositionID
group by PositionName
order by count(b.AccountID) asc limit 1;

-- Question 11: Thống kê mỗi phòng ban có bao nhiêu dev, test, scrum master, PM
select d.DepartmentName, p.PositionName, count(*) as 'soluong'
from `account` a 
	join `department` d on a.DepartmentID = d.DepartmentID
    join `position` p on a.PositionID = p.PositionID
group by d.DepartmentID, p.PositionID;
-- Question 12: Lấy thông tin chi tiết của câu hỏi bao gồm: thông tin cơ bản của question, loại câu hỏi, ai là người tạo ra câu hỏi, câu trả lời là gì, ...
select a.*, b.TypeName, c.Content
from `question` a
	join `typequestion` b on a.TypeID = b.TypeID
    join `answer` c on a.QuestionID = c.QuestionID
group by b.TypeID, c.QuestionID;
-- Question 13: Lấy ra số lượng câu hỏi của mỗi loại tự luận hay trắc nghiệm
select a.TypeName, count(b.QuestionID) as 'soluong'
from `typequestion` a
join `question` b on a.TypeID = b.TypeID
group by a.TypeName
order by count(b.QuestionID);

-- Question 14:Lấy ra group không có account nào
select distinct a.GroupID, GroupName
from `group` a
         left join `groupaccount` b on a.GroupID = b.GroupID
where AccountID is null;

-- Question 15: Lấy ra group không có account nào
select distinct a.GroupID, GroupName
from `group` a
         left join `groupaccount` b on a.GroupID = b.GroupID
where AccountID is null;

-- Question 16: Lấy ra question không có answer nào
select *
from `question`
where QuestionID not in (select QuestionID from `answer`);

-- Exercise 2: Union
-- Question 17:
-- a) Lấy các account thuộc nhóm thứ 1
select a.AccountID, FullName
from `account` a
	join `groupaccount` b on a.AccountID = b.AccountID
where GroupID = 1;
-- b) Lấy các account thuộc nhóm thứ 2
select a.AccountID, FullName
from `account` a
	join `groupaccount` b on a.AccountID = b.AccountID
where GroupID = 2;
-- c) Ghép 2 kết quả từ câu a) và câu b) sao cho không có record nào trùng nhau
select a.AccountID, FullName
from `account` a
	join `groupaccount` b on a.AccountID = b.AccountID
where GroupID = 1
union
select a.AccountID, FullName
from `account` a
	join `groupaccount` b on a.AccountID = b.AccountID
where GroupID = 2;
-- Question 18:
-- a) Lấy các group có lớn hơn 5 thành viên
select a.GroupID, GroupName, count(AccountID) as 'soluong'
from `group` a
	join `groupaccount` b on a.GroupID = b.GroupID
group by a.GroupID
having count(AccountID) > 5;
-- b) Lấy các group có nhỏ hơn 7 thành viên
select a.GroupID, GroupName, count(AccountID) as 'soluong'
from `group` a
	join `groupaccount` b on a.GroupID = b.GroupID
group by a.GroupID
having count(AccountID) < 7;
-- c) Ghép 2 kết quả từ câu a) và câu b)
select a.GroupID, GroupName, count(AccountID) as 'soluong'
from `group` a
	join `groupaccount` b on a.GroupID = b.GroupID
group by a.GroupID
having count(AccountID) > 5
union
select a.GroupID, GroupName, count(AccountID) as 'soluong'
from `group` a
	join `groupaccount` b on a.GroupID = b.GroupID
group by a.GroupID
having count(AccountID) < 7;
