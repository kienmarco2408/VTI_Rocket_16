drop database if exists `Testing_System_Assignment_6`;
create database if not exists `Testing_System_Assignment_6`;
use `Testing_System_Assignment_1`;
use `Testing_System_Assignment_2`;

-- Question 1: Tạo store để người dùng nhập vào tên phòng ban và in ra tất cả các account thuộc phòng ban đó
delimiter $$
create procedure printAc(IN in_dName varchar(50))
begin
	declare idD int;
    select DepartmentID into idD from `department` where DepartmentName like in_dName;
    select * from Account where DepartmentID = idD;
end $$
delimiter ;

call printAc('Phòng Dev 2');


-- Question 2: Tạo store để in ra số lượng account trong mỗi group
delimiter $$
drop procedure if exists printAg;
create procedure printAg()
begin
	select count(AccountID) as 'so luong', G.GroupID, G.GroupName
    from `Group` G
             join GroupAccount GA on G.GroupID = GA.GroupID
    group by G.GroupID;
end$$
delimiter ;

call printAg ();

-- Question 3: Tạo store để thống kê mỗi type question có bao nhiêu question được tạo trong tháng hiện tại
delimiter $$
drop procedure if exists printQT;
create procedure printQT()
begin
    select count(QuestionID) as 'so luong', T.TypeID, TypeName
    from `typequestion` T
             join `question` Q on Q.TypeID = T.TypeID
    where month(CreateDate) = month(now())
      and year(CreateDate) = year(now())
    group by T.TypeID;
end$$
delimiter ;

call printQT();


-- Question 4: Tạo store để trả ra id của type question có nhiều câu hỏi nhất
delimiter $$
drop procedure if exists printTq;
create procedure printTq(out type_id int unsigned)
begin
    select T.TypeID
    into type_id
    from `typequestion` T
             join `question` Q on T.TypeID = Q.TypeID
    group by Q.TypeID
    order by count(QuestionID)
    limit 1;
end$$
delimiter ;

-- Question 5: Sử dụng store ở question 4 để tìm ra tên của type question
set @a = 0;
call printTq(@a);
select @a;

select TypeName from `typequestion` where TypeID = @a; 

set @a = null;

-- Question 6: Viết 1 store cho phép người dùng nhập vào 1 chuỗi và trả về group có tên chứa chuỗi của người dùng nhập vào hoặc trả về user có username chứa chuỗi của người dùng nhập vào
delimiter $$
drop procedure if exists printN;
create procedure printN(in in_keyword char(50))
begin
    select GroupID as 'ID', GroupName as Name
    from `group`
    where GroupName like concat('%', in_keyword, '%')
    union
    select AccountID as 'ID', FullName as Name
    from `account`
	where FullName like concat('%',in_keyword, '%');
end$$
delimiter ;

call printN('a');

-- Question 7: Viết 1 store cho phép người dùng nhập vào thông tin fullName, email và trong store sẽ tự động gán:

-- username sẽ giống email nhưng bỏ phần @..mail đi
-- positionID: sẽ có default là developer
-- departmentID: sẽ được cho vào 1 phòng chờ
-- Sau đó in ra kết quả tạo thành công


delimiter $$
drop procedure if exists printAcc;
create procedure printAcc(IN in_FullName VARCHAR(50), in_Email VARCHAR(50))
begin
	declare user_name char(50);
	declare position_id int;
	set user_name = substring_index(in_Email,'@',1);
	select PositionID into position_id 
    from `position` 
    where PositionName like '%dev%' limit 1;
	insert into `account` (Email, UserName, FullName, PositionID, CreateDate)
    values (in_Email, user_name, in_FullName, position_id , now());
    select 'thanh cong';
end$$
delimiter ;

begin work;
select * from `account`;
call printAcc('Tran Van Kien', 'kientran@gmail.com');
rollback;

-- Question 8: Viết 1 store cho phép người dùng nhập vào Essay hoặc Multiple-Choice để thống kê câu hỏi essay hoặc multiple-choice nào có content dài nhất

delimiter $$
	drop procedure if exists printLength_content ; 
	create procedure printLength_content(in in_Type char(50)) 
    begin
		select Content
        from `question`
        where in_Type = (select TypeID from `typequestion` where TypeName like in_Type)
        order by character_length(Content) desc
        limit 1;
    end $$
delimiter ;

call printLength_content('Multiple-Choice');


-- Question 9: Viết 1 store cho phép người dùng xóa exam dựa vào ID

delimiter $$
drop procedure if exists printDeleteID;
create procedure printDeleteID(in in_ExamID tinyint unsigned)
    begin
		if exists(select * from `exam` where ExamID = in_ExamID)
        then 
			begin
				delete from `exam` where  ExamID = in_ExamID;
            end;
		end if;
    end$$
delimiter ;

begin work;
select *
from Exam;
call printDeleteID(9);
rollback;

-- Question 10: Tìm ra các exam được tạo từ 3 năm trước và xóa các exam đó đi (sử dụng store ở câu 9 để xóa)


delimiter $$
drop procedure if exists printExam; 
create procedure printExam()
    begin
		select e.*, eq.QuestionID from `exam` e
        join `examquestion` eq on eq.ExamID = e.ExamID
        where year(e.CreateDate) = (year(now())-1);
        
		if exists (select * from `exam` where year(CreateDate) = (year(now())-1)) 
        then 
         begin
			delete from `exam` where year(CreateDate) = (year(now())-1);
         end;
		end if; 
    end$$
delimiter ; 

begin work ; 
select * from `exam` ;
call printExam();
rollback;

-- Sau đó in số lượng record đã remove từ các table liên quan trong khi removing

-- Question 11: Viết store cho phép người dùng xóa phòng ban bằng cách người dùng nhập vào tên phòng ban và các account thuộc phòng ban đó sẽ được chuyển về phòng ban default là phòng ban chờ việc


delimiter $$
drop procedure if exists printDepartmnet; 
create procedure printDepartmnet(in in_Type varchar(50) )
		begin
			declare department_id int unsigned;
			select DepartmentID into department_id from `department` where DepartmentName like in_Type limit 1;
            if(department_id is not null)
            then
				begin
					update `account` set DepartmentID = null where DepartmentID = department_id ;
                    delete from `department` where DepartmentID = department_id ;   
                end;
            end if;
        end$$
delimiter ;

begin work ;
select * from `department`;
select * from `account` ;
call printDepartmnet('Phòng Sale');
rollback;

-- Question 12: Viết store để in ra mỗi tháng có bao nhiêu câu hỏi được tạo trong năm nay


delimiter $$
drop procedure if exists printQues;
create procedure printQues()
    begin
		select monthname(CreateDate) as 'Thang', count(QuestionID) as 'So luong' 
        from `question` 
        where year(CreateDate) = (year(now())-1)
        group by month(CreateDate) ;
    end$$
delimiter ;

call  printQues();


-- Question 13: Viết store để in ra mỗi tháng có bao nhiêu câu hỏi được tạo trong 6 tháng gần đây nhất (Nếu tháng nào không có thì sẽ in ra là "không có câu hỏi nào trong tháng")


delimiter $$
drop procedure if exists printCreateQues;
create procedure printCreateQues()
    begin
		select monthname(CreateDate) as 'Thang', count(QuestionID) as 'So luong' 
        from `question` 
        where year(CreateDate) = (year(now())) 
        and month(CreateDate) >= (month(now())-6) 
        group by month(CreateDate) ;
    end$$
delimiter ; 

call  printCreateQues(); 



DROP TRIGGER IF EXISTS trigger_department;

DELIMITER $$
CREATE TRIGGER trigger_department
    BEFORE DELETE ON department
    FOR EACH ROW
        BEGIN
            UPDATE account SET DepartmentID = 0
            WHERE DepartmentID = OLD.DepartmentID;
        END$$
        DELETE FROM department WHERE DepartmentName = 'Phòng Dev 1';
DELIMITER ;