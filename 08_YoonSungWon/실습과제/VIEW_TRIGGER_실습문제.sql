/***********************************************************************************************************************
Q1. View 생성하기
***********************************************************************************************************************/
-- students 테이블 생성
CREATE OR REPLACE TABLE students(
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    class VARCHAR(50)
);

-- grades 테이블 생성
CREATE OR REPLACE TABLE grades(
    grade_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    subject VARCHAR(2),
    grade CHAR(1),
    FOREIGN KEY (student_id)
            REFERENCES students(student_id)
);

-- students 테이블 데이터 생성
INSERT INTO students(name,class) VALUES ('유관순','A');
INSERT INTO students(name,class) VALUES ('신사임당','B');
INSERT INTO students(name,class) VALUES ('홍길동','A');

-- grades 테이블 데이터 생성
INSERT INTO grades(student_id,subject,grade) VALUES (1,'과학','A');
INSERT INTO grades(student_id,subject,grade) VALUES (1,'수학','B');
INSERT INTO grades(student_id,subject,grade) VALUES (2,'수학','C');
INSERT INTO grades(student_id,subject,grade) VALUES (2,'과학','A');
INSERT INTO grades(student_id,subject,grade) VALUES (3,'과학','B');
INSERT INTO grades(student_id,subject,grade) VALUES (3,'수학','C');

-- 테이블 조회
SELECT * FROM students;
SELECT * FROM grades;

-- students 와 grades 를 조인하여 과목별로 정렬하여 학생들의 이름, 반, 성적을 보여주는 뷰를 생성
CREATE VIEW IF NOT EXISTS students_grades AS
    SELECT
        g.subject 과목별,
        s.name 이름,
        s.class 반,
        g.grade 성적
    FROM
        students s
    JOIN
        grades g ON (s.student_id = g.student_id)
    ORDER BY
        g.subject;

-- 생성된 뷰 조회
SELECT * FROM students_grades;


/***********************************************************************************************************************
Q2. Index 생성/삭제
***********************************************************************************************************************/
-- employeedb의 employee 테이블을 대상으로 dept_code 컬럼에 인덱스를 생성
CREATE INDEX idx_dept ON employee(dept_code);

-- 생성된 인덱스 조회
SHOW INDEX FROM employee;

-- 인덱스 삭제
DROP INDEX idx_dept ON employee;
ALTER TABLE employee DROP INDEX idx_dept;


/***********************************************************************************************************************
Q3. Stored Procedure 생성
***********************************************************************************************************************/
-- 두 개의 숫자를 입력 받아 더한 결과를 출력하는 addNumbers stored procedure를 작성
DELIMITER //

CREATE OR REPLACE PROCEDURE addNumbers(
    IN num1 INT,
    IN num2 INT,
    OUT sum INT
)

BEGIN

    SET sum = num1 + num2;

END //

DELIMITER ;

-- 호출
SET @sum = 0;
CALL addNumbers(10,20,@sum);
SELECT @sum;


/***********************************************************************************************************************
Q4. Stored function 생성
***********************************************************************************************************************/
DELIMITER //

CREATE OR REPLACE FUNCTION increasePrice(
    current_price DECIMAL(10,2),
    increase_rate DECIMAL(10,2)
)
RETURNS DECIMAL(10,2)
DETERMINISTIC

BEGIN
    RETURN current_price * (1 + increase_rate);
END //

DELIMITER ;

SELECT
    menu_name 메뉴명,
    menu_price 기존가,
    TRUNCATE(increasePrice(menu_price, 0.1), -2) 예정가
FROM
    tbl_menu;


/***********************************************************************************************************************
Q5. Trigger 생성
***********************************************************************************************************************/
-- salary_history 테이블 생성
CREATE TABLE salary_history (
    history_id INT AUTO_INCREMENT PRIMARY KEY ,
    emp_id VARCHAR(3),
    old_salary DECIMAL(10, 2),
    new_salary DECIMAL(10, 2),
    change_date DATETIME,
    FOREIGN KEY (emp_id) REFERENCES employee(emp_id)
);

DESC salary_history;

DELIMITER //

-- Trigger 생성
CREATE OR REPLACE TRIGGER trg_salary_update
    BEFORE UPDATE ON employee
    FOR EACH ROW
BEGIN
    INSERT INTO salary_history(emp_id, old_salary, new_salary, change_date)
    VALUES (OLD.emp_id, OLD.salary,NEW.salary, NOW());
END //

DELIMITER ;

UPDATE employee
SET SALARY = 9000000
WHERE emp_id = 200;

SELECT emp_id, emp_name, salary
FROM employee
WHERE emp_id = 200;

SELECT * FROM salary_history;