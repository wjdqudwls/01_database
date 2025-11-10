/*
Q1. View 생성하기
students 테이블 생성
student_id (INT, PRIMARY KEY)
name (VARCHAR)
class (VARCHAR)
grades 테이블 생성
grade_id (INT, PRIMARY KEY)
student_id (INT, FOREGIN KEY)
subject (VARCHAR)
grade (CHAR)
students 와 grades 를 조인하여 과목별로 정렬하여 학생들의 이름, 반, 성적을 보여주는
뷰를 생성하세요.
1단계 : create table
2단계 : 데이터 insert
3단계 : create view
4단계 : select * from view
*/
DROP  TABLE IF EXISTS students;

CREATE TABLE students (
    student_id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    name VARCHAR(255) NOT NULL,
    class VARCHAR(255) NOT NULL
    );
CREATE TABLE grades (
    grades_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    subject VARCHAR (255),
    grade CHAR (10),
    FOREIGN KEY (student_id)
            REFERENCES students (student_id)
) ENGINE = INNODB;

INSERT
INTO students
(name, class)
VALUES
    ('유관순', 'A'),
    ('신사임당', 'B'),
    ('홍길동', 'A');

SELECT * FROM students;

INSERT
INTO grades(student_id, subject , grade)
VALUES
    (1 ,'수학', 'B'),
    (1 ,'과학', 'A'),
    (2 ,'수학', 'C'),
    (2 ,'과학', 'B'),
    (3 ,'수학', 'A'),
    (3 ,'과학', 'B');

CREATE OR REPLACE VIEW student_grades AS
SELECT g.subject, s.name, s.class, g.grade
FROM students s
JOIN grades g ON (s.student_id = g.student_id)
ORDER BY ;

SELECT * FROM student_grades;
/*
Q2. Index 생성 / 삭제
employeedb의 employee 테이블을 대상으로 dept_code 컬럼에 인덱스를 생성하여
부서코드로 직원들을 검색할 때의 성능을 향상시키세요.
Question 2
employee 테이블의 인덱스를 조회해보세요.
생성한 인덱스를 다시 삭제하세요.
*/
-- DLSEPRTM

-- 인덱스 생성
CREATE INDEX idx_dept ON employee(dept_code);
-- 인덱스 조회
SHOW INDEX FROM employee;
-- 인덱스 삭제
DROP INDEX idx_dept ON employee;
ALTER TABLE employee DROP INDEX idx_dept;




/*
Q3. Stored Procedure 생성
두 개의 숫자를 입력 받아 더한 결과를 출력하는 addNumbers stored procedure를 작
성하세요.
호출 실행 테스트는 아래와 같습니다.
*/
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


/*
Q4. Stored function 생성
현재 가격과 인상 비율을 입력 받아 인상 예정가를 반환하는 increasePrice stored
function을 만들고 메뉴 가격을 대상으로 select 절에서 사용하여 아래와 같이 조회하
세요. 예정가는 십의 자리까지 버림처리합니다.
조회 결과는 아래와 같습니다.
*/
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

/*
Q5. trigger 생성
salary_history 테이블 생성
history_id (INT, PRIMARY KEY)
emp_id (VARCHAR, FOREGIN KEY)
old_salary (DECIMAL)
new_salary (DECIMAL)
change_date (DATETIME)
employeedb의 salary 컬럼이 update 될 경우 해당 이력을 salary_history 테이블에
insert 하는 트리거를 생성합니다.
1단계 : salary_history 테이블 생성
2단계 : trg_salary_update 트리거 생성
3단계 : employee의 특정 행의 salary 컬럼 수정 시 트리거 동작하는지 확인
테스트 결과는 아래와 같습니다.
*/

/*
 - EMPLOYEE 테이블의 salary가 수정되기 전에 트리거가 동작해야 한다 !
 -> 그래야지 수정 전 값을 기록할 수 있기 때문 !
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

-- ------------------------------------------------

-- TRIGGER 생성


DELIMITER  //

CREATE OR REPLACE TRIGGER trg_salary_update
    BEFORE UPDATE ON EMPLOYEE
    FOR EACH ROW
    BEGIN

        INSERT INTO salary_history(EMP_ID, old_salary, new_salary, change_date)
        VALUES (OLD.EMP_ID, OLD.SALARY,NEW.SALARY, CURRENT_DATE);

    end //

DELIMITER ;

UPDATE EMPLOYEE
SET SALARY = 8000000
WHERE EMP_ID = 200;

SELECT EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE
WHERE EMP_ID = 200;

SELECT * FROM salary_history;