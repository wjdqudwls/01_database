    SELECT * FROM employee;
    SELECT * FROM department;
    SELECT * FROM job;
    SELECT * FROM location;
    SELECT * FROM sal_grade;
    SELECT * FROM national;

/*    CREATE VIEW IF NOT EXISTS students AS
     SELECT
        student_id,
        name,
        class
  FROM tbl_menu
 WHERE category_code = 3;

SELECT * FROM students;*/

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
4단계 : select * from view;


/*CREATE TABLE
    students
(
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    name       VARCHAR(30),
    class      VARCHAR(30)
);

SELECT * FROM students;

CREATE TABLE
    grades
(
    grade_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT, -- FOREIGN KEY,
    subject    VARCHAR(30),
    grade           CHAR(10),
    FOREIGN KEY (student_id) REFERENCES students(student_id)
);
*/

/*SELECT * FROM grades;

CREATE OR REPLACE VIEW student_grades_view AS
SELECT
    S.name AS 학생이름,
    S.class AS 반,
    G.subject AS 과목,
    G.grade AS 성적
FROM
    students S
JOIN
    grades G ON S.student_id = G.student_id
ORDER BY
    G.subject;*/



/*SELECT
    *
FROM
    students S
JOIN
        grades G ON (S.student_id = G.student_id)
   INSERT INTO
       students (name, class),

    VALUES
        ('김가영', '1반'),
        ('박나래', '2반'),
        ('이도현', '3반'),
        ('정은지', '1반'),
        ('최민호', '2반'),
        ('한서준', '3반')*/

/*DROP TABLE students;
DROP TABLE grades;*/ -- 이름이 난잡해서 지움

/*SELECT
    *
FROM (students S
    JOIN
    grades G ON (S.student_id = G.student_id)
    (
        SELECT
    *
    FROM
        students
   INSERT INTO students (name, class),
        AND
        grades (subject, grade)
    VALUES
    ('일이삼','1반')
    ('일이사','2반')
    ('일이오','3반')
    ('일이육','4반')
    ('일이칠','3반')

UNION  -- INSERT절에는 UNION 절대 못씀

    SELECT
    *
    FROM
        grades
   INSERT INTO
    grades (student_id, subject, grade)
    VALUES
    (1, '국어', 'A');
    (2, '국어', 'B');
    (3, '국어', 'A');
    (4, '수학', 'C');
    (5, '국어', 'A');



         );*/

SELECT * FROM students;

CREATE TABLE IF NOT EXISTS students
(
student_id INT PRIMARY KEY,
name VARCHAR(100),
class VARCHAR(50)
)

CREATE TABLE IF NOT EXISTS students
(
grade_id INT PRIMARY KEY,
student_id INT FOREGIN KEY,
subject VARCHAR(100),
grade CHAR(50)
)

INSERT INTO students ();

CREATE OR REPLACE VIEW student_grades AS
    SELECT;


Q2. Index 생성 / 삭제
employeedb의 employee 테이블을 대상으로 dept_code 컬럼에 인덱스를 생성하여
부서코드로 직원들을 검색할 때의 성능을 향상시키세요.
Question 2
employee 테이블의 인덱스를 조회해보세요.
생성한 인덱스를 다시 삭제하세요.;

-- 인덱스 생성








 /*


          정답


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


-- 2번

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