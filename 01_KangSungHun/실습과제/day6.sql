DROP TABLE IF EXISTS students;
DROP TABLE IF EXISTS grades;


CREATE TABLE IF NOT EXISTS students (
    student_id INT AUTO_INCREMENT PRIMARY KEY ,
    name VARCHAR(100),
    class VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS grades (
    grade_id INT AUTO_INCREMENT PRIMARY KEY ,
    student_id INT ,
    subject VARCHAR(6),
    grade CHAR(1),
    FOREIGN KEY (student_id) REFERENCES students(student_id)
);

SELECT *
    FROM students s
JOIN grades g ON (g.student_id = s.student_id);

INSERT INTO students VALUES (1, '유관순','A');
INSERT INTO students VALUES (2,'신사임당','B');
INSERT INTO students VALUES (3,'홍길동','C');
SELECT * FROM students;

INSERT INTO grades (student_id, subject, grade) VALUES
                                                    (1,'수학','B'),
                                                    (1,'과학','A'),
                                                    (2,'수학','C'),
                                                    (2,'과학','B'),
                                                    (3,'수학','A'),
                                                    (3,'과학','B');

select * from grades;


CREATE VIEW IF NOT EXISTS student_grades AS
SELECT g.subject,
       s.name,
       s.class,
       g.grade
FROM students s
JOIN grades g ON g.student_id = s.student_id
ORDER BY g.subject;

SELECT * FROM student_grades;

-- 인덱스 생성
CREATE INDEX idx_dept ON employee(dept_code);
-- 인덱스 조회
SHOW INDEX FROM employee;
-- 인덱스 삭제
DROP INDEX idx_dept ON employee;
ALTER TABLE employee DROP INDEX idx_dept;

-- 3번

DELIMITER //
CREATE OR REPLACE PROCEDURE addNumbers(
    IN num1 INT,
    IN num2 INT,
    OUT sum INT
)
BEGIN
    SET sum = num1 + num2;
end //
DELIMITER ;

SET @result = 0;
CALL addNumbers(10, 20, @result);
SELECT @result;


-- 4번
DELIMITER //

CREATE OR REPLACE FUNCTION increasePrice(
    current_price DECIMAL(10,2),
    increase_rate DECIMAL(10,2)
)
    RETURNS DECIMAL(10,2)
    DETERMINISTIC
BEGIN
    RETURN current_price * (1 + increase_rate);
END//

DELIMITER ;

SELECT
    menu_name 메뉴명,
    menu_price 기존가,
    TRUNCATE(increasePrice(menu_price, 0.1), -2) 예정가
FROM
    tbl_menu;

-- 5
CREATE TABLE salary_history (
                                history_id INT AUTO_INCREMENT PRIMARY KEY ,
                                emp_id VARCHAR(3),
                                old_salary DECIMAL(10, 2),
                                new_salary DECIMAL(10, 2),
                                change_date DATETIME,
                                FOREIGN KEY (emp_id) REFERENCES employee(emp_id)
);

DESC salary_history;


-- TRIGGER 생성
/*

employee 테이블의 salary가 수정되기 전에 트리거가 동작해야 한다!-> 그래야지 수정 전 값을 기록할 수 있기 때문!*/

DELIMITER //

CREATE OR REPLACE TRIGGER trg_salary_update
    BEFORE UPDATE ON employee
    FOR EACH ROW
BEGIN

    INSERT INTO salary_history(
        emp_id, old_salary, new_salary, change_date)
    VALUES (OLD.emp_id, OLD.salary,
            NEW.salary, NOW());
end //

DELIMITER ;

UPDATE employee
SET SALARY = 9000000
WHERE emp_id = 200;

SELECT emp_id, emp_name, salary
FROM employee
WHERE emp_id = 200;

SELECT * FROM salary_history;


