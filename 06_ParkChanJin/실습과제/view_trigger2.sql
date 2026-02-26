/*
Q1. View 생성하기
grades 테이블 생성

students 와 grades 를 조인하여 과목별로 정렬하여 학생들의 이름, 반, 성적을 보여주는
뷰를 생성하세요.
1단계 : create table
2단계 : 데이터 insert
3단계 : create view
4단계 : select * from view
*/
DROP TABLE IF EXISTS grades;
DROP TABLE IF EXISTS students;

CREATE TABLE IF NOT EXISTS students(
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    class VARCHAR(1) NOT NULL
);

CREATE TABLE IF NOT EXISTS grades(
    grade_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT REFERENCES students(student_id),
    subject VARCHAR(10),
    grade CHAR(1)
);

INSERT INTO students(name, class) VALUES
('유관순', 'A'),
('신사임당', 'B'),
('홍길동', 'A');

INSERT INTO grades (student_id,subject, grade) VALUES
(1,'과학', 'A'),
(2,'과학', 'B'),
(3,'과학', 'B'),
(1,'수학', 'B'),
(2,'수학', 'C'),
(3,'수학', 'A');



SELECT * FROM students;
SELECT * FROM grades;

CREATE VIEW IF NOT EXISTS v_students AS
    SELECT
        g.subject,
        s.name,
        s.class,
        g.grade
    FROM students s
    JOIN grades g ON(s.student_id = g.student_id);

SELECT * FROM v_students;


DESCRIBE grades;
DESCRIBE students;

select * from students;
select * from grades;




/*
Q2. Index 생성 / 삭제
employeedb의 employee 테이블을 대상으로 dept_code 컬럼에 인덱스를 생성하여
부서코드로 직원들을 검색할 때의 성능을 향상시키세요.
Question 2
employee 테이블의 인덱스를 조회해보세요.
생성한 인덱스를 다시 삭제하세요.
*/

CREATE OR REPLACE INDEX idx_employeedb
ON employee(dept_code);

EXPLAIN SELECT * FROM employee
WHERE dept_code = 'D6';

DROP INDEX idx_employeedb ON employee;

EXPLAIN SELECT * FROM employee
WHERE dept_code = 'D6';

select * FROM employee;


/*
Q3. Stored Procedure 생성
두 개의 숫자를 입력 받아 더한 결과를 출력하는 addNumbers stored procedure를 작
성하세요.
호출 실행 테스트는 아래와 같습니다.
CALL addNumbers(10, 20, @sum);
SELECT @sum; -- 30 조회
*/

DELIMITER //
CREATE OR REPLACE PROCEDURE addNumbers(
    IN num1 INT,
    IN num2 INT,
    OUT SUM INT
)
BEGIN
    SET SUM = num1 + num2;
END //
DELIMITER ;

SET @result = 0;
CALL addNumbers(10,20,@result);
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
end //

DELIMITER ;

SELECT
    menu_name 메뉴명,
    menu_price 기존가,
    TRUNCATE(increasePrice(menu_price,0.1), -2) 예정가
FROM
    tbl_menu;













CREATE TABLE IF NOT EXISTS salary_history(
    history_id INT AUTO_INCREMENT PRIMARY KEY,
    emp_id VARCHAR(3),
    old_salary DECIMAL(10,2),
    new_salary DECIMAL(10,2),
    change_date DATETIME,
    FOREIGN KEY(emp_id) REFERENCES employee(EMP_ID)
);
DESC salary_history;

select * FROM salary_history;

