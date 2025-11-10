
# 1.
drop table if exists grades;
drop table if exists students;

create table if not exists students(
    student_id int primary key,
    name varchar(255),
    class varchar(255)
) engine = innodb;

create table if not exists grades(
    grade_id int primary key,
    student_id int,
    subject varchar(255),
    grade char(4),
    foreign key (student_id)
    references students(student_id)
) engine = innodb;

insert into students (student_id, name, class)
values
    (2018310314, '유관순', 'A'),
    (2016309847, '신사임당', 'B'),
    (2020384192, '홍길동', 'A');

insert into grades (grade_id, student_id, subject, grade)
values
    (101, 2018310314, '과학', 'A'),
    (102, 2016309847, '과학', 'B'),
    (103, 2020384192, '과학', 'B'),
    (201, 2018310314, '수학', 'B'),
    (202, 2016309847, '수학', 'C'),
    (203, 2020384192, '수학', 'A'),
    (301, 2018310314, '영어', 'B'),
    (302, 2016309847, '영어', 'A'),
    (303, 2020384192, '영어', 'B');

drop view if exists student_grades;
create view if not exists student_grades as
    select g.subject subject, s.name name, s.class class, g.grade grade
    from students s
        join grades g on s.student_id = g.student_id
    where g.subject in ('수학', '과학')
    order by g.grade_id;

select * from student_grades;


# 2.
create index idx_dept on employee(dept_code);

show index from employee;

drop index idx_dept on employee;
alter table employee drop index idx_dept;


# 3.
delimiter //
create or replace procedure addNumbers(
    in num1 int,
    in num2 int,
    out sum int
)
begin
    set sum = num1 + num2;
    -- select num1+num2 into sum; 도 가능
end //

delimiter ;

set @result = 0;
call addNumbers(10, 20, @result);
select @result;


# 4.
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


# 5.
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