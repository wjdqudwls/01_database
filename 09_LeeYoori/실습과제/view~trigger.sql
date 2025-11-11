-- Q1. view 생성하기

-- 1. students table create
create table if not exists students (
      student_id int auto_increment primary key
    , name varchar(255)
    , class varchar(255)
) engine=innoDB;

-- 2. grades table create
create table if not exists grades (
      grade_id int auto_increment primary key
    , subject varchar(255)
    , grade char(2)
    , student_id int
    , FOREIGN KEY (student_id)
          REFERENCES students (student_id)
) engine=innoDB;

drop table students;

drop table grades;

insert into students (name,class) values
('홍길동', 'A'),
('신사임당', 'B'),
('유관순', 'A');

insert into grades (subject, grade) values
('수학', 'B'),
('과학', 'A'),
('수학', 'C'),
('과학', 'B'),
('수학', 'A'),
('과학', 'B');
delete from grades;

select * from students;
select * from grades;

-- 3. view create
CREATE VIEW IF NOT EXISTS students_grades AS
    SELECT b.subject, a.name, a.class, b.grade
    from students a
    join grades b on a.student_id = b.student_id
    order by subject asc;

select * from students_grades;




-- Q2. index 생성/삭제

-- Index 생성
CREATE INDEX idx_employee_deptcode
    ON employee (DEPT_CODE);

-- index 확인
SHOW INDEX FROM employee;

-- index 삭제
DROP INDEX idx_employee_deptcode ON employee;


-- Q3. Stored Procedure 생성

delimiter //

create or replace procedure addNumbers(
    in num1 int,
    in num2 int,
    out sum int
)
begin
    set sum = num1+num2;
end //

delimiter ;

set @result = 0;
call addNumbers(10, 20, @result);

select @result;

-- Q4. Stored function 생성

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


-- Q5. trigger
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
