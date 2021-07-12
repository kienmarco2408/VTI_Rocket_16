drop database if exists `Testing_System_Assignment_7`;
create database if not exists `Testing_System_Assignment_7`;
use `Testing_System_Assignment_1`;


-- Question 1: Tạo trigger không cho phép người dùng nhập vào Group có ngày tạo
-- trước 1 năm trước

DROP TRIGGER IF EXISTS trigger_group;

DELIMITER $$
CREATE TRIGGER trigger_group
    BEFORE INSERT ON `group`
    FOR EACH ROW
    BEGIN
        DECLARE d_CreateDate DATETIME;
        SET d_CreateDate = DATE_SUB(NOW(), INTERVAL 1 YEAR );
        IF (NEW.CreateDate <= d_CreateDate) THEN
            SIGNAL SQLSTATE '12345'
            SET MESSAGE_TEXT = 'CANNOT INSERT DATA';
        end if;
    END$$
DELIMITER ;

-- Question 2: Tạo trigger Không cho phép người dùng thêm bất kỳ user nào vào
-- department "Sale" nữa, khi thêm thì hiện ra thông báo "Department
-- "Sale" cannot add more user"

DROP TRIGGER IF EXISTS trigger_account;

DELIMITER $$
CREATE TRIGGER trigger_account
    BEFORE INSERT ON `account`
    FOR EACH ROW
    BEGIN
        DECLARE d_depID TINYINT;
        SELECT DepartmentID INTO d_depID FROM department WHERE DepartmentName = 'Phòng Sale';
        IF (NEW.DepartmentId = d_depID) THEN
            SIGNAL SQLSTATE '12356'
            SET MESSAGE_TEXT = 'Department "Sale" cannot add more user';
        end if ;
    END$$
DELIMITER ;

INSERT INTO account(Email, UserName, FullName, DepartmentId, PositionID, CreateDate)
VALUES
('kientran@gmail.com', 'kientran', 'Tran Van Kien','2','1', '2021-07-11 00:00:00');
-- Question 3: Cấu hình 1 group có nhiều nhất là 5 user
DROP TRIGGER IF EXISTS trigger_group_user;

DELIMITER $$
CREATE TRIGGER trigger_group_user
    BEFORE INSERT ON `groupaccount`
    FOR EACH ROW
    BEGIN
        DECLARE d_GroupID TINYINT;
        SELECT COUNT(GA.GroupID) INTO d_GroupID FROM groupaccount GA
        WHERE GA.GroupID = NEW.GroupID;
        IF (d_GroupID > 5) THEN
            SIGNAL SQLSTATE '12345'
            SET MESSAGE_TEXT = 'CANNOT INSERT MORE USER';
        END IF ;
    END$$
DELIMITER ;


-- Question 4: Cấu hình 1 bài thi có nhiều nhất là 10 Question

DROP TRIGGER IF EXISTS trigger_question;

DELIMITER $$
CREATE TRIGGER trigger_question
    BEFORE INSERT ON `examquestion`
    FOR EACH ROW
    BEGIN
        DECLARE d_questionID TINYINT;
        SELECT COUNT(EQ.QuestionID) INTO d_questionID FROM examquestion EQ
        WHERE EQ.QuestionID = NEW.QuestionID;
        IF(NEW.QuestionID > 10) THEN
            SIGNAL SQLSTATE '12345'
            SET MESSAGE_TEXT = 'CANT INSERT MORE QUESTION';
        end if ;
    end $$
DELIMITER ;

-- Question 5: Tạo trigger không cho phép người dùng xóa tài khoản có email là
-- admin@gmail.com (đây là tài khoản admin, không cho phép user xóa),
-- còn lại các tài khoản khác thì sẽ cho phép xóa và sẽ xóa tất cả các thông
-- tin liên quan tới user đó

DROP TRIGGER IF EXISTS trigger_email;

DELIMITER $$
CREATE TRIGGER trigger_email
    BEFORE DELETE ON `account`
    FOR EACH ROW
    BEGIN
        DECLARE d_email VARCHAR(50);
        SET d_email = 'admin@gmail.com';
        IF (OLD.Email = d_email) THEN
            SIGNAL SQLSTATE '12345'
            SET MESSAGE_TEXT = 'CANNOT DELETE THIS EMAIL';
        end if ;
    end $$
DELIMITER ;



-- Question 6: Không sử dụng cấu hình default cho field DepartmentID của table
-- Account, hãy tạo trigger cho phép người dùng khi tạo account không điền
-- vào departmentID thì sẽ được phân vào phòng ban "waiting Department"

DROP TRIGGER IF EXISTS trigger_accD;

DELIMITER $$
CREATE TRIGGER trigger_accD
    BEFORE INSERT ON `account`
    FOR EACH ROW
    BEGIN
        DECLARE d_DepartmentID TINYINT;
        SET d_DepartmentID = NULL;
        IF (d_DepartmentID = NULL) THEN
            INSERT INTO `department`(DepartmentName)
            VALUES ('Waiting Department');
        end if ;
    end $$
DELIMITER ;

-- Question 7: Cấu hình 1 bài thi chỉ cho phép user tạo tối đa 4 answers cho mỗi
-- question, trong đó có tối đa 2 đáp án đúng.
-- Question 8: Viết trigger sửa lại dữ liệu cho đúng:
-- Nếu người dùng nhập vào gender của account là nam, nữ, chưa xác định
-- Thì sẽ đổi lại thành M, F, U cho giống với cấu hình ở database
-- Question 9: Viết trigger không cho phép người dùng xóa bài thi mới tạo được 2 ngày
-- Question 10: Viết trigger chỉ cho phép người dùng chỉ được update, delete các
-- question khi question đó chưa nằm trong exam nào
-- Question 12: Lấy ra thông tin exam trong đó:
--
-- Duration <= 30 thì sẽ đổi thành giá trị "Short time"
-- 30 < Duration <= 60 thì sẽ đổi thành giá trị "Medium time"
-- Duration > 60 thì sẽ đổi thành giá trị "Long time"
--
-- Question 13: Thống kê số account trong mỗi group và in ra thêm 1 column nữa có tên
-- là the_number_user_amount và mang giá trị được quy định như sau:
--
-- 2
--
-- Nếu số lượng user trong group =< 5 thì sẽ có giá trị là few
-- Nếu số lượng user trong group <= 20 và > 5 thì sẽ có giá trị là normal
-- Nếu số lượng user trong group > 20 thì sẽ có giá trị là higher
-- Question 14: Thống kê số mỗi phòng ban có bao nhiêu user, nếu phòng ban nào
-- không có user thì sẽ thay đổi giá trị 0 thành "Không có User"