/*
    Q1. View 생성하기
*/

DROP TABLE IF EXISTS grades;
DROP TABLE IF EXISTS students;

CREATE TABLE IF NOT EXISTS students(
    student_id INT AUTO_INCREMENT,
    name VARCHAR(10),
    class VARCHAR(5),

    PRIMARY KEY (student_id)
)ENGINE = INNODB;

CREATE TABLE IF NOT EXISTS grades(
    grade_id INT AUTO_INCREMENT,
    student_id INT,
    subject VARCHAR(10),
    grade CHAR,

    PRIMARY KEY (grade_id),
    FOREIGN KEY (student_id) REFERENCES students(student_id)
)ENGINE = INNODB;

INSERT INTO students (name, class)
VALUES ('유관순','A'),
       ('신사임당','B'),
       ('홍길동','A');

INSERT INTO grades (student_id, subject, grade)
VALUES ('1','과학','A'),
       ('1','수학','B'),
       ('2','과학','B'),
       ('2','수학','C'),
       ('3','과학','B'),
       ('3','수학','A');

SELECT * FROM students;
SELECT * FROM grades;

CREATE VIEW IF NOT EXISTS nameScore AS
    (
        SELECT
            g.subject,
            s.name,
            s.class,
            g.grade
        FROM students s
            JOIN grades g ON (s.student_id = g.student_id)
        ORDER BY
            g.subject, s.name
    );

SELECT * FROM nameScore;

/*
    Q2. Index 생성 / 삭제
*/
-- 1. employeedb의 employee 테이블을 대상으로
-- dept_code 컬럼에 인덱스를 생성하여 부서코드로 직원들을 검색할 때의 성능을 향상시키세요.

CREATE INDEX IF NOT EXISTS idx_deptcode
    ON employee(DEPT_CODE);

-- 2. employee 테이블의 인덱스를 조회해보세요.
SHOW INDEX FROM employee;

-- 3. 생성한 인덱스를 다시 삭제하세요.
DROP INDEX IF EXISTS idx_deptcode ON employee;
ALTER TABLE employee DROP INDEX idx_deptcode;
-- [HY000][1553] (conn=190) Cannot drop index 'idx_deptcode': needed in a foreign key constraint
-- FK 제약조건을 ALTER 로 삭제하면 가능
DESC employee;

/*
    Q3.Stored Procedure 생성
    두 개의 숫자를 입력 받아 더한 결과를 출력하는 addNumbers stored procedure를 작성하세요.
*/

DELIMITER //
CREATE PROCEDURE IF NOT EXISTS addNumbers(IN num1 int, IN num2 int, OUT sum INT)
    BEGIN
        SET sum = num1 + num2;
    END //
DELIMITER ;

SET @sum = 0;
CALL addNumbers(10,20,@sum);
SELECT @sum;

/*
    Q4. Stored function 생성
    현재 가격과 인상 비율을 입력 받아 인상 예정가를 반환하는 increasePrice stored
    function을 만들고 메뉴 가격을 대상으로 select 절에서 사용하여 아래와 같이 조회하
    세요. 예정가는 십의 자리까지 버림처리합니다.
*/

DELIMITER //
CREATE OR REPLACE FUNCTION increasePrice(currentPrice DECIMAL(10,2), increaseRatio DECIMAL(10,2))
    -- DECIMAL (10,2) 뒤에 자리수 표기 안했더니 increaseRatio에서 소수점이 삭제되어 계산 오류
    RETURNS DECIMAL
    DETERMINISTIC

    BEGIN

    RETURN TRUNCATE(currentPrice * (1 + increaseRatio), -2) ;
    end //

DELIMITER ;

SELECT
    menu_name AS 메뉴명,
    menu_price AS 기존가,
    increasePrice(menu_price, 0.1) AS 예정가
FROM tbl_menu;

/*
    Q5. trigger 생성
*/

-- 1. salary_history table 생성

DROP TABLE IF EXISTS salary_history;

CREATE TABLE IF NOT EXISTS salary_history(
    history_id INT AUTO_INCREMENT,
    emp_id VARCHAR(10),
    old_salary DECIMAL(10,2),
    new_salary DECIMAL(10,2),
    change_date DATETIME,

    PRIMARY KEY (history_id),
    FOREIGN KEY (emp_id) REFERENCES employee(EMP_ID)
)ENGINE = INNODB;

DESC salary_history;

-- 2. trg_salary_update 트리거 생성
DELIMITER //

CREATE OR REPLACE TRIGGER trg_salary_update
    -- employee 테이블의 salary 가 수정 되기 전에 트리거가 동작
    -- > 그래야 old_salary를 기록 할 수 있음
    BEFORE UPDATE ON employee
    FOR EACH ROW

        BEGIN
            INSERT INTO salary_history
                (emp_id, old_salary,new_salary,change_date)
                VALUES (OLD.emp_id,OLD.SALARY,NEW.SALARY,NOW());

        END //

DELIMITER ;

UPDATE employee
SET SALARY = 8000000
WHERE EMP_ID = '200';

SELECT * FROM salary_history;
