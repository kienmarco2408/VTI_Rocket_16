DROP DATABASE IF EXISTS `Final_SQL`;
CREATE DATABASE IF NOT EXISTS `Final_SQL`;
USE `Final_SQL`;

# QUESTION 1:
CREATE TABLE `Student`(
    `SID` INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    `StudentName` VARCHAR(50) NOT NULL ,
    `Age` TINYINT UNSIGNED ,
    `Gender` VARCHAR(50) NOT NULL

);

CREATE TABLE `Subject`(
    `ID` INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    `SubjectName` VARCHAR(50) NOT NULL

);

CREATE TABLE `StudentSubject`(
    `StudentID` INT UNSIGNED,
    `SubjectID` INT UNSIGNED,
    `Mark` INT UNSIGNED,
    `Date` DATE,
CONSTRAINT studentsubject_pk PRIMARY KEY (`StudentID`,`SubjectID`)
);

INSERT INTO `Student`(StudentName, Age, Gender)
VALUES ('TRAN VAN A', 22, 'MALE'),
       ('NGUYEN VAN B', 20, 'MALE'),
       ('DO THI C', 19, 'FEMALE'),
       ('DINH XUAN D', 21, 'FEMALE'),
       ('PHAM DINH G', 20, 'UNKNOW');

INSERT INTO `Subject`(SubjectName)
VALUES ('SQL'),
       ('JAVA'),
       ('PHP'),
       ('C#'),
       ('.NET');

INSERT INTO `StudentSubject`(StudentID, SubjectID, Mark, Date)
VALUES  (1, 2, 10,'2021-07-11'),
        (2, 5, 9, '2021-07-12'),
        (3, 4, 1,'2021-07-12'),
        (4, 2, 3 ,'2021-07-14'),
        (5, 1, NULL,'2021-07-13');

# QUESTION 2:
# A)

SELECT S.*, SS.Mark FROM `Subject` S
JOIN StudentSubject SS on S.ID = SS.SubjectID
WHERE `Mark` IS NULL;

# B)

SELECT S.*, COUNT(SS.Mark) AS 'SOLUONG' FROM `Subject` S
JOIN StudentSubject SS on S.ID = SS.SubjectID
GROUP BY SubjectName
HAVING COUNT(SS.Mark) <= 2;

# QUESTION 3:

CREATE OR REPLACE VIEW `StudentInfo` AS
    SELECT S.SID, SB.ID, S.StudentName, S.Age, S.Gender,
SB.SubjectName, SS.Mark, SS.Date FROM `StudentSubject` SS
JOIN Student S on SS.StudentID = S.SID
JOIN Subject SB on SS.SubjectID = SB.ID;

# QUESTION 4:
# A)

DROP TRIGGER IF EXISTS `SubjectUpdateID`;

DELIMITER $$
CREATE TRIGGER `SubjectUpdateID`
    BEFORE UPDATE ON `Subject`
    FOR EACH ROW
    BEGIN
        UPDATE  `StudentSubject` SET `SubjectID`= NEW.`ID` WHERE `SubjectID` = OLD.`ID`;
    END$$
DELIMITER ;

UPDATE `Subject` SET `ID` = 2 WHERE `ID` = 5;


# B)

DROP TRIGGER IF EXISTS `StudentDeleteID`;

DELIMITER $$
CREATE TRIGGER `StudentDeleteID`
    BEFORE DELETE ON `Student`
    FOR EACH ROW
    BEGIN
        DELETE FROM `StudentSubject` WHERE `StudentID` = OLD.`SID`;
    end$$
DELIMITER ;

BEGIN WORK ;
DELETE FROM `Student` WHERE `SID` = 2;
ROLLBACK ;

# QUESTION 5:
DELIMITER $$
DROP PROCEDURE IF EXISTS set_delete_student;
CREATE PROCEDURE set_delete_student(IN d_studentname VARCHAR(50))
BEGIN
    DELETE FROM `Student` WHERE d_studentname = StudentName;
    IF (d_studentname = '*')
        THEN
        BEGIN
            DELETE FROM `Student`;
        END;
    end if;
END$$
DELIMITER ;

BEGIN WORK ;
SELECT *
FROM Student;
CALL set_delete_student('TRAN VAN A');
ROLLBACK ;