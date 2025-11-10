/*
 Q1. View 생성하기
students 테이블 생성
    student_id INT, PRIMARY KEY
    name VARCHAR
    class VARCHAR
 grades 테이블 생성
    grade_id INT, PRIMARY KEY
    student_id INT, FOREGIN KEY
    subject VARCHAR
    grade CHAR
 students와 grades를 조인하여 과목별로 정렬하여 학생들의 이름, 반, 성적을 보여주는 뷰를 생성하세요.
 1단계
 :create table
 2단계
 :데이터 insert
 3단계
 : create view
 4단계
 : select * from view
 */
DROP TABLE IF EXISTS grades;
DROP TABLE IF EXISTS students;

-- students 테이블
CREATE TABLE IF NOT EXISTS students(
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    class VARCHAR(50)
);
-- grades
CREATE TABLE IF NOT EXISTS grades(
    grade_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT REFERENCES students(student_id) ,
    subject VARCHAR(50),
    grade CHAR(1)
);



-- 데이터 삽입
INSERT INTO students (name, class) VALUES
('홍길동', 'A'),
('신사임당', 'B'),
('유관순', 'A');

SELECT * FROM students;

INSERT INTO grades (student_id, subject, grade) VALUES
(1, '수학', 'B'),
(1, '과학', 'A'),
(2, '수학', 'C'),
(2, '과학', 'B'),
(3, '수학', 'A'),
(3, '과학', 'B');

CREATE OR REPLACE VIEW student_grades AS
SELECT
       g.subject
      , s.name
      , s.class
      , g.grade
  FROM students s
  JOIN grades g ON s.student_id = g.student_id
 ORDER BY g.subject;

-- 1번 정답
SELECT * FROM student_grades;


 /*
 Q2. Index 생성/삭제
 employeedb의 employee 테이블을 대상으로 dept_code 컬럼에 인덱스를 생성하여
부서코드로 직원들을 검색할 때의 성능을 향상시키세요.

- employee 테이블의 인덱스를 조회해보세요.
- 생성한 인덱스를 다시 삭제하세요.
 */

-- 인덱스 생성
CREATE INDEX idx_debt ON employee(DEPT_CODE);
-- 인덱스 조회
SHOW INDEX FROM employee;
-- 인덱스 삭제
DROP INDEX idx_debt ON employee;
ALTER TABLE employee DROP INDEX idx_debt;

/*
 Q3. Stored Procedure 생성
 - 두개의 숫자를 입력 받아 더한 결과를 출력하는 'addNumbers' stored procedure 작성하세요.
호출 실행 테스트는 아래와 같습니다.
 CALL addNumbers(10, 20, @sum);
 SELECT @sum; -- 30 조회
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
 Q4. Stored function생성
 현재 가격과 인상 비율을 입력 받아 인상 예정가를 반환하는 increasePrice stored
function을 만들고 메뉴 가격을 대상으로 select절에서 사용하여 아래와 같이 조회하
세요. 예정가는 십의자리까지 버림처리합니다.
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
Q5. trigger생성
salary_history테이블생성
history_id INT, PRIMARY KEY
 emp_id VARCHAR, FOREGIN KEY
 old_salary DECIMAL
 new_salary DECIMAL
 change_date DATETIME

 employeedb의 salary 컬럼이 update될 경우 해당 이력을 salary_history 테이블에
insert하는 트리거를 생성합니다.

1단계 : salary_history 테이블 생성
2단계 : trg_salary_update 트리거 생성
3단계 : employee의 특정 행의 salary 컬럼 수정 시 트리거 동작하는지 확인
- 테스트 결과는 아래와 같습니다.

UPDATE
        employee
    SET salary = 5000000
WHERE emp_id = '202';

SELECT * FROM salary_history;
 */


DROP TABLE IF EXISTS salary_history;
CREATE TABLE IF NOT EXISTS salary_history(
    history_id INT AUTO_INCREMENT,
    emp_id VARCHAR(3),
    old_salary DECIMAL(10,2),
    new_salary DECIMAL(10,2),
    change_date DATETIME,
    PRIMARY KEY (history_id),
    FOREIGN KEY (emp_id) REFERENCES employee ( EMP_ID )
);
DESC salary_history;

-- TRIGGER 생성
-- employee 테이블의 salary가 수정되기 전에 트리거가 동작해야 한다!
-- -> 그래야 수정 전 값을 기록할 수 있기 때문!
DELIMITER //

CREATE OR REPLACE TRIGGER trg_salary_update
    BEFORE UPDATE ON employee
    FOR EACH ROW

BEGIN

    INSERT INTO salary_history(emp_id, old_salary, new_salary, change_date)
    VALUES (OLD.EMP_ID,
            OLD.SALARY,
            NEW.SALARY,
            NOW());

END //

DELIMITER ;

UPDATE employee
SET SALARY = 8000000
WHERE EMP_ID = '200';

SELECT * FROM salary_history;

