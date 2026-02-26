/* 18_PROCEDURE (프로시저) */
-- 1. 매개 변수(parameter)가 없는 프로시저

SELECT emp_id, emp_name, salary
  from employee;

DELIMITER @@

CREATE PROCEDURE getAllEmpDept()
BEGIN
    SELECT EMP_ID AS ID
         , EMP_NAME AS NAME
         , SALARY AS VALUE
      FROM employee;
    SELECT DEPT_ID AS ID
         , DEPT_TITLE AS NAME
         , NULL AS VALUE
      FROM department;
END @@

DELIMITER ;

-- 2. IN 매개변수

DELIMITER //
CREATE OR REPLACE PROCEDURE getEmployeesByDeptId(
    IN dept CHAR(2)
)
BEGIN
    SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
      FROM employee
     WHERE DEPT_CODE = dept;
end //

DELIMITER ;

call getEmployeesByDeptId('D9');

DELIMITER //

CREATE OR REPLACE PROCEDURE getEmpByDeptSalary(
    IN dept CHAR(2),
    IN sal INTEGER
)
BEGIN
    SELECT EMP_NAME, DEPT_CODE, SALARY
      FROM employee
     WHERE dept_code = dept
       AND SALARY >= sal;
end //

DELIMITER ;

-- CALL getEmpByDeptSalary('D5');
CALL getEmpByDeptSalary('D5',3000000);

DELIMITER //

-- 3. OUT 매개변수
-- - 결과 값을 호출한 곳으로 반환
DELIMITER //

CREATE OR REPLACE PROCEDURE getEmployeeSalary(
    IN id VARCHAR(3),
    OUT sal DECIMAL(10,2)
)
BEGIN
    SELECT SALARY
      INTO sal
      FROM employee
     WHERE EMP_ID = id;
end //

DELIMITER ;

SET @sal = 0;
CALL getEmployeeSalary(201,@sal);
SELECT @sal;


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

-- 4. INOUT 매개변수

DELIMITER //

CREATE OR REPLACE PROCEDURE updateAndReturnSalary (
	IN id VARCHAR(3),
	INOUT sal DECIMAL(10,2)
)
BEGIN
    UPDATE employee
    SET salary = sal
    WHERE emp_id = id;

    SELECT salary * (1 + IFNULL(bonus, 0)) INTO sal
    FROM employee
    WHERE emp_id = id;
END //

DELIMITER ;

SELECT SALARY * (1+ IFNULL(BONUS,0) ) FROM employee WHERE EMP_ID = '200';

SET @salary = 10000000;
SELECT @salary;
CALL updateAndReturnSalary('200',@salary);

-- IF-ELSE

DELIMITER //

CREATE PROCEDURE checkEmployeeSalary(
	IN id VARCHAR(3),
	IN threshold DECIMAL(10,2),
	OUT result VARCHAR(50)
)
BEGIN
    -- 지역 변수
    DECLARE sal DECIMAL(10,2);

    -- id가 일치하는 사원의 급여룰  sal 지역 변수에 저장
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

-- 6 CASE (여러 경우에 대한 조건문)
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

set @message = '';
CALL getDepartmentMessage('216',@message);
select @message;

-- while문

DELIMITER //

CREATE OR REPLACE PROCEDURE calculateSumUpTo(
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


CALL calculateSumUpTo(100, @result);
SELECT @result;

--
DELIMITER //

CREATE OR REPLACE PROCEDURE convertDecimalToBinary(
    IN decimal_num INT,
    OUT binary_result VARCHAR(64)
)
BEGIN
    DECLARE quotient INT DEFAULT decimal_num;
    DECLARE remainder INT;
    DECLARE binary_str VARCHAR(64) DEFAULT '';

    IF decimal_num = 0 THEN
        SET binary_result = '0';
    ELSE
        WHILE quotient > 0 DO
            SET remainder = MOD(quotient, 2);
            SET quotient = FLOOR(quotient / 2);
            SET binary_str = CONCAT(remainder, binary_str);
        END WHILE;
        SET binary_result = binary_str;
    END IF;
END //

DELIMITER ;

CALL convertDecimalToBinary(10, @bin);
SELECT @bin AS '2진수';


-- 예외처리
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

/* 프로시저 : 매개변수(IN,OUT,INOUT)
   CALL 반환값이 O or X
   펑션 : 매개변수가 무조건 IN, 반환도 무조건 하나
 */
DELIMITER //

CREATE FUNCTION getAnnualSalary(
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

SELECT
		   emp_name
	   , getAnnualSalary(emp_id) AS annual_salary
 FROM employee;

