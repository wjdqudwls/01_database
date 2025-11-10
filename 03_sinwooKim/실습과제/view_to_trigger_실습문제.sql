-- Q1. VIEW 생성하기
DROP TABLE students;
DROP TABLE grades;

CREATE TABLE students(
    student_id  INT PRIMARY KEY AUTO_INCREMENT,
    name        VARCHAR(255),
    class       VARCHAR(255)
);

CREATE TABLE grades (
    grade_id    INT PRIMARY KEY AUTO_INCREMENT,
    student_id  INT,
    subject     VARCHAR(255),
    grade       VARCHAR(255),
    FOREIGN KEY (student_id) REFERENCES students(student_id)
);

INSERT INTO students (student_id, name, class)
VALUES  (1,'유관순','A'),
        (2,'신사임당','B'),
        (3,'홍길동','A');

INSERT INTO grades (grade_id, student_id, subject, grade)
VALUES (1,1,'과학','A'),
(2,2,'과학','B'),
(3,'3','과학','B'),
(4,'1','수학','B'),
(5,'2','수학','C'),
(6,'3','수학','A');

CREATE VIEW IF NOT EXISTS student_grades AS
SELECT g.subject, s.name, s.class, g.grade
FROM students s
JOIN grades g ON s.student_id = g.student_id;

SELECT * FROM student_grades
ORDER BY subject;


-- Q2 INDEX 생성 / 삭제
CREATE INDEX dept_code_idx ON EMPLOYEE(DEPT_CODE);
SHOW INDEX FROM EMPLOYEE;
DROP INDEX dept_code_idx ON EMPLOYEE;


-- Q3. STORED PROCEDURE 생성
DELIMITER //

CREATE OR REPLACE PROCEDURE addNumbers(
    IN n1 INT,
    IN n2 INT,
    OUT result INT
)
BEGIN
    SET result = n1 + n2;
end //

DELIMITER ;

SET @sum = 0;
CALL addNumbers(10,20,@sum);
SELECT @sum;


-- Q4. STORED FUNCTION
DELIMITER //

CREATE OR REPLACE FUNCTION increasePrise(
    price INT,
    ratio INT
)
RETURNS DECIMAL(10)
DETERMINISTIC
BEGIN
    DECLARE result_price DECIMAL;
    SET result_price = price + (price * ratio/100);
    RETURN result_price;
end //

DELIMITER ;

SELECT menu_name 메뉴명, menu_price 기존가, TRUNCATE(increasePrise(menu_price,10),-2) 예정가
FROM tbl_menu;


-- Q5. Trigger 생성
CREATE TABLE salary_history (
    history_id  INT PRIMARY KEY AUTO_INCREMENT,
    emp_id      VARCHAR(255),
    old_salary  DECIMAL(10),
    new_salary  DECIMAL(10),
    change_date DATETIME,
    FOREIGN KEY (emp_id) REFERENCES EMPLOYEE(EMP_ID)
);

DELIMITER //

CREATE OR REPLACE TRIGGER trg_salary_update
    BEFORE UPDATE
    ON EMPLOYEE
    FOR EACH ROW
BEGIN
    INSERT INTO salary_history (emp_id, old_salary, new_salary, change_date)
    VALUES (OLD.EMP_ID, OLD.SALARY, NEW.SALARY,NOW());
end //

DELIMITER ;

UPDATE EMPLOYEE
SET SALARY = 1231231
WHERE EMP_ID = '202';

SELECT * FROM salary_history;