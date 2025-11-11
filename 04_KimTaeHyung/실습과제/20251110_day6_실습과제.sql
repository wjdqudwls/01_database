/* Q1. VIEW 생성하기 */
-- students 테이블 생성

CREATE TABLE IF NOT EXISTS students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,  -- 컬럼 레벨 제약 조건
    name VARCHAR(100) NOT NULL,
    class VARCHAR(50)

) ENGINE=INNODB;

DROP TABLE IF EXISTS students;


select * from students;


-- grades 테이블 생성
CREATE TABLE IF NOT EXISTS grades (
    grade_id INT AUTO_INCREMENT PRIMARY KEY,  -- 컬럼 레벨 제약 조건
    student_id INT,
    subject VARCHAR(255) NOT NULL,
    grade CHAR(1),
    FOREIGN KEY (student_id)
        REFERENCES students(student_id)

) ENGINE=INNODB;

SELECT * FROM grades;


-- students 데이터 삽입
INSERT INTO students(student_id, name, class)
VALUES
    (1, '유관순', 'A'),
    (2, '신사임당', 'B'),
    (3, '홍길동', 'A');

select * from students;


-- grades 데이터 삽입
INSERT INTO grades (grade_id, student_id, subject, grade)
VALUES
    (101, 1, '과학', 'A'),
    (102, 2, '과학', 'B'),
    (103, 3, '과학', 'B'),
    (104, 1, '수학', 'B'),
    (105, 2, '수학', 'C'),
    (106, 3, '수학', 'A');

SELECT * FROM grades;


-- VIEW 생성
CREATE OR REPLACE VIEW student_grades AS
SELECT
    G.subject,
    S.name,
    S.class,
    G.grade
FROM
    students S
JOIN
    grades G ON (S.student_id = G.student_id)
ORDER BY
    G.subject ;

SELECT * FROM student_grades;


/* Q2. INDEX 생성/삭제 */

CREATE INDEX idx_dept_code
ON employee (dept_code);


SHOW INDEX FROM employee;

DROP INDEX idx_dept_code ON employee;
    ALTER TABLE employee DROP INDEX idx_dept_code;


/* Q3. Stored Procedure 생성 */
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

SET @sum = 0;
CALL addNumbers(10, 20, @sum);
SELECT @sum;


/* Q4. Stored function 생성 */
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


/* Q5. TRIGGER 생성
- employee 테이블의 salary가 수정되기 전에 트리거가 동작해야 한다!
 -> 그래야지 수정 전 값을 기록할 수 있기 때문
*/
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