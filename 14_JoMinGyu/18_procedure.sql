
delimiter //

create procedure getAllEmployee()
BEGIN
select EMP_ID, EMP_NAME, SALARY
from employee;
END //

delimiter ;

call getAllEmployee();

delimiter @@

create procedure getAllEmpDept()
BEGIN
select EMP_ID, EMP_NAME, SALARY
from employee;
select DEPT_ID, DEPT_TITLE
from department;
END @@

delimiter ;

call getAllEmpDept();

delimiter //
create procedure getEmployeesByDepartment(
    in dept CHAR(2)
)
begin
    select EMP_ID, EMP_NAME, DEPT_CODE, SALARY
    from employee
    where DEPT_CODE = dept;
end //

delimiter ;

call getEmployeesByDepartment('D5')

delimiter //
create or replace procedure getEmpByDeptSalary(
    in dept char(2),
    in sal int
)
begin
    select EMP_NAME, DEPT_CODE, SALARY
    from employee
    where DEPT_CODE = dept and SALARY >= sal;
end //
delimiter ;

call getEmpByDeptSalary('D5', 2500000);


delimiter //
create or replace procedure getEmployeeSalary(
    in id varchar(3),
    out sal decimal(10,2)
)
begin
    select SALARY
    into sal
    from employee
    where EMP_ID = id;
end //
delimiter ;

set @result = 0;
call getEmployeeSalary('201', @result);
select @result;


delimiter //
create or replace procedure updateAndReturnSalary(
    in id varchar(3),
    inout sal decimal(10,2)
)
begin
    update employee
    set SALARY = sal
    where EMP_ID = id;

    select salary * (1+NVL(bonus, 0))
    into sal
    from employee
    where EMP_ID = id;
end //
delimiter ;

select salary * (1+nvl(bonus, 0))
from employee
where emp_id = 200;

set @NEW_SAL = 10000000;
select @NEW_SAL;
call updateAndReturnSalary('200', @NEW_SAL);
select @NEW_SAL;


DELIMITER //

CREATE PROCEDURE checkEmployeeSalary(
	IN id VARCHAR(3),
	IN threshold DECIMAL(10,2),
	OUT result VARCHAR(50)
)
BEGIN
    DECLARE sal DECIMAL(10,2);

    SELECT salary INTO sal
    FROM employee
    WHERE emp_id = id;

    IF sal > threshold THEN
        SET result = '기준치를 넘는 급여입니다.';
    ELSE
        SET result = '기준치와 같거나 기준치 이하의 급여입니다.';
    END IF;
END //

DELIMITER ;

set @result = '';
call checkEmployeeSalary('200', 10000000, @result);
select @result;

call checkEmployeeSalary('200', 2000000, @result);
select @result;


DELIMITER //

CREATE PROCEDURE getDepartmentMessage(
	IN id VARCHAR(3),
	OUT message VARCHAR(100)
)
BEGIN
    DECLARE dept VARCHAR(50);

    SELECT dept_code INTO dept
    FROM employee
    WHERE emp_id = id;

    CASE
        WHEN dept = 'D1' THEN
            SET message = '인사관리부 직원이시군요!';
        WHEN dept = 'D2' THEN
            SET message = '회계관리부 직원이시군요!';
        WHEN dept = 'D3' THEN
            SET message = '마케팅부 직원이시군요!';
        ELSE
            SET message = '어떤 부서 직원이신지 모르겠어요!';
    END CASE;
END //

DELIMITER ;

SET @message = '';
CALL getDepartmentMessage('221', @message);
SELECT @message;


DELIMITER //

CREATE PROCEDURE calculateSumUpTo(
    IN max_num INT,
    OUT sum_result INT
)
BEGIN
    DECLARE current_num INT DEFAULT 1;
    DECLARE total_sum INT DEFAULT 0;

    WHILE current_num <= max_num DO
        SET total_sum = total_sum + current_num;
        SET current_num = current_num + 1;
    END WHILE;

    SET sum_result = total_sum;
END //

DELIMITER ;

CALL calculateSumUpTo(10, @result);
SELECT @result;


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

CALL divideNumbers(10, 2, @result);
SELECT @result;
CALL divideNumbers(10, 0, @result); -- error 발생


DELIMITER //

CREATE or replace FUNCTION getAnnualSalary(
	id VARCHAR(3)
)
RETURNS DECIMAL(15, 2)
DETERMINISTIC
BEGIN
    DECLARE monthly_salary DECIMAL(10, 2);
    DECLARE annual_salary DECIMAL(15, 2);

    SELECT salary INTO monthly_salary
    FROM employee
    WHERE emp_id = id;

    SET annual_salary = monthly_salary * 12;

    RETURN annual_salary;
END //

DELIMITER ;

SELECT emp_id, emp_name, salary,
       getAnnualSalary(emp_id) AS annual_salary
 FROM employee;