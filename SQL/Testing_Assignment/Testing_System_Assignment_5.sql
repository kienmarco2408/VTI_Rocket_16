drop database if exists `Testing_System_Assignment_5`;
create database if not exists `Testing_System_Assignment_5`;
use `Testing_System_Assignment_1`;
use `Testing_System_Assignment_2`;

-- Exercise 1: Tiếp tục với Database Testing System (Sử dụng subquery hoặc CTE)

-- Question 1: Tạo view có chứa danh sách nhân viên thuộc phòng ban sale
create view Nvsale as (
select a.FullName, b.DepartmentName
from `account` a join `department` b 
on a.DepartmentID = b.DepartmentID
where DepartmentName like '%Sale');

select * from NVsale;
-- Question 2: Tạo view có chứa thông tin các account tham gia vào nhiều group nhất


create or replace view Accs as 
	select a.*, count(b.AccountID) as 'so luong'
	from `account` a join `GroupAccount` b
	using (AccountID)
	group by b.AccountID
	having count(b.AccountID) = (select max(maax) from (select count(b.AccountID) as maax
																	from `account` a
																	join `GroupAccount` b
																	using (AccountID)
																	group by b.AccountID) as maxgroup);

select * from Accs;

-- Question 3: Tạo view có chứa câu hỏi có những content quá dài (content quá 300 từ được coi là quá dài) và xóa nó đi
create or replace view Cont as
	select Content, character_length(Content) as 'so luong'
    from `Question` where character_length(Content) > 10;

delete from Cont;

-- Question 4: Tạo view có chứa danh sách các phòng ban có nhiều nhân viên nhất
create or replace view slots as
	select d.DepartmentName, count(a.AccountID) as 'so nhan vien'
    from `Department` d join `Account` a
    on d.DepartmentID = a.DepartmentID
    group by d.DepartmentName
    order by count(a.AccountID) desc;

-- Question 5: Tạo view có chứa tất các các câu hỏi do user họ Nguyễn tạo
create or replace view Ques as
	select q.Content, a.FullName 
    from `question` q
    join `Account` a
    on q.CreatorID = a.AccountID
    group by q.Content
    having a.FullName like 'Nguyễn%';