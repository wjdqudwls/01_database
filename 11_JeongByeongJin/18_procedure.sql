/* 18_PROCEDURE (프로시저) */

-- 1. 매개 변수(parameter) 없는 프로시저

DELIMITER //

CREATE PROCEDURE getAllEMPLOYEE()
BEGIN
SELECT EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE;
END //

DELIMITER ;

-- 프로시저 호출
CALL getAllEMPLOYEE();

-- 여러 SQL을 묶어서 실행하는 프로시저 생성
DELIMITER @@

CREATE PROCEDURE getAllEmpDept()

BEGIN
    SELECT EMP_ID, EMP_NAME, SALARY
    FROM EMPLOYEE;

    SELECT DEPT_ID, DEPT_TITLE
    FROM DEPARTMENT;

end @@


DELIMITER  ;

CALL getAllEmpDept();

-- 2. IN 매개 변수
-- - 프로시저 호출 시 전달된 값을 저장하는 변수
-- (외부에 있는 값이 프로시전 내부로 들어옴(IN))

DELIMITER //

CREATE OR REPLACE PROCEDURE GetEmployeeByDepartment(
    IN dept CHAR(2)
)
BEGIN
    SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
    FROM EMPLOYEE
    WHERE DEPT_CODE = dept;
END //

DELIMITER ;

-- 프로시저 호출
CALL GetEmployeeByDepartment('D9');
CALL GetEmployeeByDepartment('D8');

-- 매개 변수 2개짜리 전달 받기

DELIMITER //

CREATE OR REPLACE PROCEDURE getEmpByDeptSalary(
    IN dept CHAR(2),
    IN sal INTEGER
)
BEGIN
    SELECT EMP_NAME, DEPT_CODE, SALARY
    FROM EMPLOYEE
    WHERE DEPT_CODE = dept
    AND SALARY >= sal;
end //

DELIMITER ;

# CALL GetEmployeeByDepartment('D5');
CALL getEmpByDeptSalary('D5', 2500000);


-- 3. OUT 매개 변수
-- - 결과값을 호출한 곳으로 반환
DELIMITER //

CREATE OR REPLACE PROCEDURE getEmployeeSalary(
    IN id VARCHAR(3),
    OUT sal DECIMAL (10,2) -- DECIMAL == 10진수
)
BEGIN
    SELECT SALARY
    INTO sal
    FROM EMPLOYEE
    WHERE EMP_ID = id;
end//

DELIMITER ;

-- 프로시저 호출
-- '@' : 사용자 변수 선언
SET @result = 0;
CALL getEmployeeSalary('200', @result);
SELECT @result;

-- 4. INOUT 매개 변수

DELIMITER //

CREATE OR REPLACE PROCEDURE updateANdReturnSalary(
    in id VARCHAR(3),
    INOUT sal DECIMAL(10, 2)
)
BEGIN
    update EMPLOYEE
    SET SALARY = sal
    WHERE EMP_ID = id;

    SELECT SALARY * (1 + IFNULL(BONUS, 0))
    INTO sal
    FROM EMPLOYEE
    WHERE EMP_ID = id;
end //


DELIMITER ;

SELECT SALARY * (1 + IFNULL(BONUS, 0))
FROM EMPLOYEE
WHERE EMP_ID = 200;

SET @NEW_SAL = 10000000;
SELECT @NEW_SAL; -- 1000만
CALL updateANdReturnSalary('200', @NEW_SAL);
SELECT @NEW_SAL; -- 프로시저 실행 후 -> 1300만

-- 5. IF - ELSE (조건문)
DELIMITER //

DELIMITER //

CREATE OR REPLACE PROCEDURE checkEmployeeSalary(
    IN id VARCHAR(3),
    IN threshold DECIMAL(10,2),
    OUT result VARCHAR(50)
)
BEGIN
    -- 프로시저 내부에서만 사용하는 지역 변수 선언
    DECLARE sal DECIMAL(10,2);
    -- id가 일치하는 사원의 급여를 sal 급여를 sal 지역 변수에 저장
    SELECT SALARY
    INTO sal
    FROM EMPLOYEE
    WHERE   EMP_ID = id;

    IF
        sal > threshold
    THEN
        SET result = '기준치를 넘는 급여입니다.';
    ELSE
        SET result = '기준치와 같거니 기준치 이하 급여입니다.';

    end if ;

end //

DELIMITER ;

SET @result = '';
CALL checkEmployeeSalary('200', 10000000, @result);
SELECT @result;

CALL checkEmployeeSalary('200', 2000000, @result);
SELECT @result;

-- 6. CASE
-- 여러 경우에 대한 조건문
DELIMITER //

CREATE OR REPLACE PROCEDURE getDepartmentMessage(
    IN id VARCHAR(3),
    OUT message VARCHAR(50)
)
BEGIN
    DECLARE dept VARCHAR(50);   -- 지역 변수 선언

    SELECT DEPT_CODE       -- 3
    INTO dept              -- 4
    FROM EMPLOYEE          -- 1
    WHERE   EMP_ID = id;   -- 2

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

-- 사용자 변수 선언
SET @MESSAGE = '';
CALL getDepartmentMessage('214', @MESSAGE);
SELECT @MESSAGE;


-- 7. WHILE 반복문
-- 조건식이 TRUE일 동안 반복 수행

DELIMITER //

CREATE OR REPLACE PROCEDURE calculateSumUpTo(
    IN max_num INT,
    OUT sum_result INT
)
BEGIN
    DECLARE current_num INT DEFAULT 1;
    DECLARE total_sum INT DEFAULT 0; -- 합계를 저장할 변수

    WHILE current_num <= max_num -- 전달 받은 max_num 미만까지 반복하겠다.
        DO
            SET total_sum = total_sum + current_num; -- 이전 합계에 현재 숫자

            SET current_num = current_num + 1; -- 반복이 끝날 때 마다 1씩 증가

        END WHILE ;



    SET sum_result = total_sum;
END //

DELIMITER ;

-- 반복문 확인
SET @result = 0;
CALL calculateSumUpTo(100, @result);
SELECT @result;


-- 8. 예외처리 활용
    -- EROR - 코드 해결 X
    -- EXCEPTION - 코드 해결 O
        -- 1) 코드 수정
        -- 2) 예외 처리

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
SET @result = 0;
CALL divideNumbers(10, 2, @result);
SELECT @result;

CALL divideNumbers(10, 0, @result); -- error 발생

-- ----------------------------------------------------------------------

/*  FUNCTION
    - 매개 변수는 IN (생략)
    - 반환 값 무조건 1개
    - 호출 방법 : SELECT 문에서 함수() 호출
*/
DELIMITER //

CREATE OR REPLACE FUNCTION getAnnualSalary(
    id VARCHAR(3)
)
    RETURNS DECIMAL(15,2) -- 반환 값의 자료형을 명시
    DETERMINISTIC        -- 매개 변수 값이 동일하면 결과도 항상 동일하다
BEGIN
    DECLARE monthly_salary DECIMAL(10,2); -- 월급
    DECLARE annual_salary DECIMAL(15,2); -- 연봉

    SELECT SALARY
    INTO monthly_salary -- 조회된 salary를 monthly_salary 에 대입
    FROM EMPLOYEE
    WHERE EMP_ID = id;

    -- 연봉계산
    SET annual_salary = monthly_salary * 2;
    RETURN annual_salary;

end //

DELIMITER ;

-- 함수 호출
SELECT
    EMP_ID,
    EMP_NAME,
    SALARY,
    getAnnualSalary(EMP_ID) AS '연봉'
FROM EMPLOYEE;

