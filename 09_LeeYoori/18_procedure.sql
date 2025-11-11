/*
    18_procedure
-- 1. 매개변수(procedure) 없는 프로시저
*/

delimiter //

create procedure getAllEmployee()
begin
select emp_id, emp_name, salary
from employee;
end //

delimiter ;

-- 프로시저 호출
call getAllEmployee();

-- 여러 sql을 묶어서 실행하는 프로시저 생성

delimiter @@

create procedure getAllEmpDept()
begin
    select emp_id, EMPLOYEE.EMP_NAME, EMPLOYEE.SALARY
    from EMPLOYEE;

    select DEPT_ID, DEPT_TITLE
    from DEPARTMENT;
end @@

delimiter ;

call getAllEmpDept();




-- 2. in 매개변수 사용하여 값 넣기
-- - procedure 호출 시 전달된 값을 저장하는 변수
-- (외부에 있는 값이 procedure 내부로(in) 들어옴)

delimiter //

create procedure getEmployeesByDepartment(
    in dept char(2)
)

begin
    select EMP_ID, EMP_NAME, DEPT_CODE, SALARY
    from EMPLOYEE
    where DEPT_CODE = dept;
end //


delimiter ;

-- 프로시저 호출
call getEmployeesByDepartment('D9');
call getEmployeesByDepartment('D5');


-- 매개변수 2개짜리 procedure
delimiter //

create or replace procedure getEmpByDeptSalary(

    in dept char(2),
    in sal integer

)
    begin

        select EMP_NAME, DEPT_CODE, SALARY
        from EMPLOYEE
        where DEPT_CODE = dept
        and SALARY >= sal;
    end //


delimiter ;

-- call getEmployeesByDepartment('D5');
call getEmpByDeptSalary('D5', 2500000);


-- 3. out 매개 변수
-- 결과값을 호출한 곳으로 반환

delimiter //

create or  replace procedure getEmployeeSalary(

    in id varchar(3),
    out sal decimal -- decimal : 10진수를 실수형으로 ex(10,2)
)

begin

    select SALARY
    into sal -- 반환값을 집어넣는 과정
    from EMPLOYEE
    where EMP_ID = id;

end //

delimiter ;


-- 프로시저 호출
-- '@' : 사용자 변수 선언
set @result = 0; -- 0으로 기본값
call getEmployeeSalary('200', @result); -- result에 값이 담겨있는 과정
select @result;
-- 모르면 실행해볼것


-- 4. inout 매개변수

delimiter //

create or replace procedure updateAndReturnSalary(

    in id varchar(3),
    inout sal decimal(10,2)

)

begin

    update EMPLOYEE
    set salary = sal
    where EMP_ID = id;

    select salary * (1 + nvl(bonus, 0))
    into sal
    from employee
    where EMP_ID = id;
end //

delimiter ;

select SALARY * (1+nvl(bonus, 0))
from EMPLOYEE
where EMP_ID = 200;

set @NEW_SAL = 10000000;

select @NEW_SAL;    -- 10000000
call updateAndReturnSalary('200', @NEW_SAL);

select @NEW_SAL;


-- if else
delimiter //
    CREATE PROCEDURE checkEmployeeSalary(
        IN id VARCHAR(3),
        IN threshold DECIMAL(10,2), -- threshold : 임계점
        OUT result VARCHAR(50)
    )

    begin
        -- procedure 내부에서만 사용하는 지역변수 선언 (declare)
        declare sal decimal(10,2);

        -- id가 일치하는 사원의 급여를 sal 지역변수에 저장
        select SALARY
        into sal    -- 받은 값을 지역변수 sal에 집어넣겠다!
        from EMPLOYEE
        where emp_id = id;

        if sal > threshold
        then
            set result = '기준치를 넘는 급여입니다.';
        else
            set result = '기준치와 같거나 기준치 이하 급여입니다.';
        end if;

    end //

delimiter ;

set @result = '';
call checkEmployeeSalary('200', 10000000, @result);

select @result;


-- 6. case
-- 여러 경우의 대한 조건문
delimiter //

create or replace procedure getDepartmentMessage(

    in id varchar(3),
    out message varchar(50)
)

begin

    declare dept varchar(50);   -- 지역변수 선언

    select dept_code       -- 3
    into dept           -- 4
    from EMPLOYEE       -- 1
    where emp_id = id;  -- 2

    case
        when dept = 'D1' then
            set message = '인사부 직원';
        when dept = 'D2' then
            set message = '회계관리부 직원';
        when dept = 'D3' then
            set message = '마케팅부 직원';
        else
            set message = '어떤 부서 직원인지 모르겠어요';
        end case;

end //

delimiter ;

-- 사용자 변수 선언
set @message = '';
call getDepartmentMessage('202', @message); --  input
select @message;    -- message check


-- 7. while 반복문
-- 조건식이 true일 동안 반복수행

DELIMITER //

CREATE or replace PROCEDURE calculateSumUpTo(
    IN max_num INT,
    OUT sum_result INT
)
BEGIN
    DECLARE current_num INT DEFAULT 1;
    DECLARE total_sum INT DEFAULT 0;    -- 합계 저장할 변수

    while current_num <= max_num -- 전달받은 max_num 이하까지 반복하겠다
        do
            set total_sum = total_sum + current_num;    -- 이전 합계의 현재 숫자를 누적
            set current_num = current_num + 1;  -- 반복이 끝날때마다 1씩 증가
        end while ;

    SET sum_result = total_sum;
END //

DELIMITER ;

-- 반복문 확인
set @result = 0;
call calculateSumUpTo(100, @result);

select @result;





-- 8. exception 예외처리
DELIMITER //

CREATE PROCEDURE divideNumbers(
    IN numerator DOUBLE,
    IN denominator DOUBLE,
    OUT result DOUBLE
)
BEGIN
    DECLARE division_by_zero CONDITION FOR SQLSTATE '45000';
    DECLARE EXIT HANDLER FOR division_by_zero
        BEGIN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '0으로 나눌 수 없습니다.';
        END;

    IF denominator = 0 THEN
        SIGNAL division_by_zero;
    ELSE
        SET result = numerator / denominator;
    END IF;
END//

DELIMITER ;

set @result = 0;
call divideNumbers(10, 2, @result);
select @result;
call divideNumbers(10,0,@result);   -- error발생


-- --------------------------------------------------------------------------------------------------
-- stored procedure
-- procedure는 값을 반환할 수도 반환하지 않을 수도 있다.

-- stored function
-- 하나의 값을 항상 반환해야함(하지 않으면 안됨)
-- 호출 방법은 call이 아님 함수를 호출해서 사용(out 매개변수 고정)

/*
    function
    - 매개변수는 in
    - 반환 값 무조건 1개
    - 호출방법은 : select문에서 함수() 호출
*/
delimiter //
create or replace function getAnnualSalary(
    id varchar(3) -- 들어오는건 in밖에 없으므로 생략가능

)

    returns decimal (15,2)  -- 반환값의 자료형을 명시
    deterministic -- 매개변수값이 동일하면 결과도 항상 같다.

begin

    declare monthly_salary decimal(10,2);   -- 월급
    declare annual_salary decimal(15,2);    -- 연봉

    select SALARy
    into monthly_salary -- 조회된 salary를 monthly_salary에 대입
    from EMPLOYEE
    where EMP_ID = id;


    -- 연봉계산
    set annual_salary = monthly_salary * 12;
    return annual_salary;   -- 함수를 호출한 곳으로 annual_salary 값을 반환




end //
delimiter ;

-- 함수 호출
select EMP_ID, EMP_NAME, SALARY, getAnnualSalary(emp_id) as '연봉'
from EMPLOYEE;