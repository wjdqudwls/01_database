/*
PROCEDURE
    - 1. 매개 변수(parameter) 없는 프로시저
*/

DELIMITER //

CREATE PROCEDURE getAllEmployee()
BEGIN
SELECT EMP_ID, EMP_NAME, EMP_NO
FROM EMPLOYEE;
END //

DELIMITER ;

-- procedure 호출
CALL getAllEmployee();

-- 여러 SQL을 묶어서 실행하는 PROCEDURE 생성
DELIMITER @@

CREATE PROCEDURE getAllEmpDept()
BEGIN
    SELECT EMP_ID, EMP_NAME, SALARY
    FROM EMPLOYEE;

    SELECT DEPT_ID, DEPT_TITLE
    FROM DEPARTMENT;
END @@

DELIMITER ;

CALL getAllEmpDept();

-- IN 매개 변수
-- PROCEDURE 호출 시 전달된 값을 저장하는 변수
-- (외부에 있는 값이 PROCEDURE 내부로 들어옴(IN))

DELIMITER //

CREATE PROCEDURE getEmployeesByDepartment(
    IN dept CHAR(2)
)
BEGIN
    SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
    FROM EMPLOYEE
    WHERE DEPT_CODE = dept;
end //

DELIMITER ;

CALL getEmployeesByDepartment('D9');

-- 매개 변수 2개짜리 PROCEDURE
DELIMITER //

CREATE OR REPLACE PROCEDURE getEmpByDeptSalary(
    IN dept CHAR(2),
    IN sal INT
)
BEGIN
    SELECT EMP_NAME, DEPT_CODE, SALARY
    FROM EMPLOYEE
    WHERE DEPT_CODE = dept AND SALARY >= sal;
end //

DELIMITER ;

CALL getEmpByDeptSalary('D5',3000000);

-- OUT 매개 변수
-- 결과 값을 호출한 곳으로 반환
DELIMITER //

CREATE OR REPLACE PROCEDURE getEmployeeSalary(
    IN id VARCHAR(3),
    OUT sal INT
)
BEGIN
    SELECT SALARY INTO sal
    FROM EMPLOYEE
    WHERE EMP_ID = id;
end //

DELIMITER ;

-- PROCEDURE 호출
-- '@' : 사용자 변수 선언
SET @result = 0;
CALL getEmployeeSalary('200',@result);
SELECT @result;

-- INOUT 매개 변수
DELIMITER //

CREATE OR REPLACE PROCEDURE updateAndReturnSalary(
    IN id VARCHAR(3),
    INOUT sal DECIMAL(10,1)
)
BEGIN
    UPDATE EMPLOYEE
    SET SALARY = sal
    WHERE EMP_ID = id;

    SELECT SALARY * (1+IFNULL(BONUS,0)) INTO sal
    FROM EMPLOYEE
    WHERE EMP_ID = id;
end //

DELIMITER ;

SELECT SALARY * (1 + IFNULL(BONUS,0))
FROM EMPLOYEE
WHERE EMP_ID = 200;

SET @NEW_SAL = 10000000;
CALL updateAndReturnSalary('200',@NEW_SAL);
SELECT @NEW_SAL;


-- IF ~ ELSE (조건문)
DELIMITER //

CREATE PROCEDURE checkEmployeeSalary(
	IN id VARCHAR(3),
	IN threshold DECIMAL(10,2),
	OUT result VARCHAR(50)
)
BEGIN
    -- PROCEDURE 내부에서만 사용하는 지역 변수 선언 'DECLARE'
    DECLARE sal DECIMAL(10,2);

    -- id가 일치하는 employee의 salary를 지역변수에 저장.
    SELECT SALARY INTO sal
    FROM EMPLOYEE
    WHERE EMP_ID = id;

    IF sal > threshold
    THEN
        SET result = '기준치를 넘는 급여입니다.';
    ELSE
        SET result = '기준치와 같거나 기준치 이하 급여입니다.';
    END IF;
end //

DELIMITER ;

SET @result = '';
CALL checkEmployeeSalary('200',55,@result);
SELECT @result;


-- CASE
-- 여러 경우에 대한 조건문
DELIMITER //

CREATE OR REPLACE PROCEDURE getDepartmentMessage(
    IN id VARCHAR(3),
    OUT message VARCHAR(50)
)
BEGIN
    DECLARE dept VARCHAR(50); -- 지역 변수 선언
    SELECT DEPT_CODE INTO dept
    FROM EMPLOYEE
    WHERE EMP_ID = id;

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
end //

DELIMITER ;

SET @MESSAGE = '';
CALL getDepartmentMessage('202',@MESSAGE);
SELECT @MESSAGE;


-- WHILE
DELIMITER //

CREATE OR REPLACE PROCEDURE calculateSumUpTo(
    IN max_num INT,
    OUT sum_result INT
)
BEGIN
    DECLARE current_num INT DEFAULT 1;
    DECLARE total_sum INT DEFAULT 0; -- 합계를 저장할 변수

    WHILE current_num <= max_num
    DO
        SET total_sum = total_sum + current_num;
        SET current_num = current_num + 1;
    end while;

    SET sum_result = total_sum;
END //

DELIMITER ;

SET @RESULT = 0;
CALL calculateSumUpTo(100,@RESULT);
SELECT @RESULT;

-- 예외 처리
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


/* ------------------------------------------------------------------------ */

/*
FUNCTION
    - 매개 변수는 IN(생략가능)
    - 반환 값 무조건 1개
    - 호출 방법 : SELECT문에서 함수() 호출
*/

DELIMITER //

CREATE OR REPLACE FUNCTION getAnnualSalary(
    id VARCHAR(3)
)
RETURNS DECIMAL(15,2) -- 함수가 반환하는 값의 자료형을 명시
DETERMINISTIC -- 매개 변수 값이 동일하면 결과값도 항상 동일하다
BEGIN
    DECLARE monthly_salary DECIMAL(10,2);   -- 월급
    DECLARE annual_salary  DECIMAL(15,2);   -- 연봉

    SELECT SALARY INTO monthly_salary -- 조회된 SALARY를 monthly_salary에 대입
    FROM EMPLOYEE
    WHERE EMP_ID = id;

    -- 연봉 계산
    SET annual_salary = monthly_salary * 12;
    RETURN annual_salary; -- 함수를 호출한 곳으로 annual_salary 값을 반환
end //

DELIMITER ;

-- 함수 호출
SELECT EMP_ID, EMP_NAME, SALARY, getAnnualSalary(EMP_ID) AS 연봉
FROM EMPLOYEE;