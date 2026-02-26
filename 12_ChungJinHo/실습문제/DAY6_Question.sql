/*
   Q1. View 생성하기
   - students 와 grades 를 조인하여 과목별로 정렬하여 학생들의 이름, 반, 성적을 보여주는
     뷰를 생성하세요.
 */

CREATE TABLE students (
    student_id INT PRIMARY KEY,
    name VARCHAR,
    class VARCHAR
);

CREATE TABLE grades (
    grade_id INT PRIMARY KEY,
    student_id INT,
    subject VARCHAR,
    grade CHAR(1),
    FOREIGN KEY (student_id) REFERENCES students(student_id)
);


INSERT INTO students (student_id, name, class) VALUES
(1, '유관순', 'A'),
(2, '신사임당', 'B'),
(3, '홍길동', 'A');

INSERT INTO grades (grade_id, student_id, subject, grade) VALUES
(101, 1, '과학', 'A'),
(102, 2, '과학', 'B'),
(103, 3, '과학', 'B'),
(104, 1, '수학', 'B'),
(105, 2, '수학', 'C'),
(106, 3, '수학', 'A');


CREATE VIEW student_grades AS
SELECT
    s.name AS name,
    s.class AS class,
    g.subject AS subject,
    g.grade AS grade
FROM
    students s
JOIN
    grades g ON s.student_id = g.student_id
ORDER BY
    g.subject, s.name;


SELECT * FROM student_grades;

/*
   Q2. Index 생성 / 삭제
   - employeedb의 employee 테이블을 대상으로 dept_code 컬럼에 인덱스를 생성하여
     부서코드로 직원들을 검색할 때의 성능을 향상시키세요.
 */

CREATE INDEX idx_dept_code ON employee (dept_code);
-- ALTER TABLE employee ADD INDEX idx_dept_code (dept_code);


SHOW INDEX FROM employee;


DROP INDEX idx_dept_code ON employee;
DROP INDEX IF EXISTS idx_dept_code ON employee;


SHOW INDEX FROM employee;

/*
   Q3. Stored Procedure 생성
   - 두 개의 숫자를 입력 받아 더한 결과를 출력하는 addNumbers stored procedure를 작
     성하세요.
 */

DELIMITER //
CREATE PROCEDURE addNumbers(IN num1 INT, IN num2 INT, OUT sum_result INT)
BEGIN
    SET sum_result = num1 + num2;
END //
DELIMITER ;


CALL addNumbers(10, 20, @sum);
SELECT @sum AS sum_of_numbers;

/*
   Q4. Stored function 생성
   - 현재 가격과 인상 비율을 입력 받아 인상 예정가를 반환하는 increasePrice stored
     function을 만들고 메뉴 가격을 대상으로 select 절에서 사용하여 아래와 같이 조회하
     세요. 예정가는 십의 자리까지 버림처리합니다.


 */

DELIMITER //
CREATE FUNCTION increasePrice(currentPrice DECIMAL(10, 2), increaseRate DECIMAL(5, 2))
RETURNS DECIMAL(10, 2)
DETERMINISTIC
BEGIN
    DECLARE increased_price DECIMAL(10, 2);

    SET increased_price = currentPrice * (1 + increaseRate);
    SET increased_price = TRUNCATE(increased_price / 100, 0) * 100;

    RETURN increased_price;
END //
DELIMITER ;


SELECT
    menu_name AS 메뉴명,
    menu_price AS 기존가,
    increasePrice(menu_price, 0.1) AS 예정가
FROM
    tbl_menu;


/*
 * Q5. Trigger 생성
    - insert 하는 트리거를 생성합니다.
    1단계 : salary_history 테이블 생성
    2단계 : trg_salary_update 트리거 생성
    3단계 : employee의 특정 행의 salary 컬럼 수정 시 트리거 동작하는지 확인
    테스트 결과는 아래와 같습니다.
 */

CREATE TABLE IF NOT EXISTS salary_history (
    history_id INT PRIMARY KEY AUTO_INCREMENT,
    emp_id VARCHAR(10),
    old_salary DECIMAL(10, 2),
    new_salary DECIMAL(10, 2),
    change_date DATETIME,
    FOREIGN KEY (emp_id) REFERENCES employee(emp_id) -- employee 테이블의 emp_id 참조
);


DELIMITER //
CREATE TRIGGER trg_salary_update
AFTER UPDATE ON employee
FOR EACH ROW
BEGIN
    IF OLD.salary <> NEW.salary THEN
        INSERT INTO salary_history (emp_id, old_salary, new_salary, change_date)
        VALUES (OLD.emp_id, OLD.salary, NEW.salary, NOW());
    END IF;
END //
DELIMITER ;


UPDATE employee
SET salary = 5000000
WHERE emp_id = '202';

SELECT * FROM employee where emp_id = '202';
SELECT * FROM salary_history;


UPDATE employee
SET EMP_NAME = '노옹철 (수정됨)'
WHERE emp_id = '202';


SELECT * FROM salary_history;