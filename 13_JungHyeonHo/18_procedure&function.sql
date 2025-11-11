/* 18_PROCEDURE (프로시저) */

-- 1. 매개 변수(PARAMETER) 없는 프로시저

DELIMITER //
CREATE PROCEDURE GETALLEMPLOYEE()
SELECT EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE;
END //
DELIMITER ;

-- 프로시저 호출
CALL GETALLEMPLOYEE();

-- 여러 SQL을 묶어서 실행하는 프로시저 생성
DELIMITER @@
CREATE PROCEDURE GETALLEMPDEPARTMENT()
BEGIN
    SELECT EMP_ID, EMP_NAME, SALARY
    FROM employee;
    SELECT DEPT_ID, DEPT_TITLE
    FROM department;
END @@
DELIMITER ;

-- 프로시저 호출
CALL GETALLEMPDEPARTMENT();

/*
 2. IN 매개변수
 - 프로시저 호출 시 전달된 값을 저장하는 변수
 - (외부에 있는 값이 프로시저 내부로 들어옴(IN))
 */

-- IN을 활용한 프로시저
DELIMITER //
CREATE PROCEDURE GETEMPLOYEESBYDEPARTMENT(
    IN dept CHAR(2)
)
BEGIN
    SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
    FROM employee
    WHERE DEPT_CODE = dept;
END //
DELIMITER ;

-- 프로시저 호출
CALL GETEMPLOYEESBYDEPARTMENT('D9');

-- IN을 활용한 매개변수 2개짜리 프로시저
DELIMITER //
CREATE OR REPLACE PROCEDURE GETEMPBYDEPTJOB(
    IN DEPT CHAR(2),
    SAL INT
)
BEGIN
    SELECT EMP_NAME, DEPT_CODE, SALARY
    FROM employee
    WHERE DEPT_CODE = DEPT
      AND SALARY > SAL;
end //
DELIMITER ;
-- 프로시저 호출
CALL GETEMPBYDEPTJOB('D5', 2500000);

/*
 3. OUT 매개 변수
 - 결과 값을 호출한 곳으로 반환
 */
DELIMITER //
CREATE OR REPLACE PROCEDURE GETEMPLOYEESALARY(
    IN ID VARCHAR(3),
    OUT SAL DECIMAL(10, 2) -- 전체 10자리에 소수부분은 2자리 지정
)
BEGIN
    SELECT SALARY
    INTO SAL
    FROM employee
    WHERE EMP_ID = ID;
end //
DELIMITER ;

-- 프로시저 호출
-- '@' : 사용자 변수 선언
SET @RESULT = 0;
CALL GETEMPLOYEESALARY('202', @RESULT);
SELECT @RESULT;

/*
 4. INOUT 매개 변수
 */
DELIMITER //
CREATE OR REPLACE PROCEDURE UPDATEANDRETURNSALARY(
    IN ID VARCHAR(3),
    INOUT SAL DECIMAL(10, 2)
)
BEGIN
    UPDATE employee
    SET SALARY = SAL
    WHERE EMP_ID = ID;

    SELECT SALARY * (1 + IFNULL(BONUS, 0))
    INTO SAL
    FROM employee
    WHERE EMP_ID = ID;
end //
DELIMITER ;

SELECT SALARY * (1 + IFNULL(BONUS, 0))
FROM employee
WHERE EMP_ID = 200;

SET @NEW_SAL = 10000000;
SELECT @NEW_SAL;
CALL UPDATEANDRETURNSALARY('200', @NEW_SAL);

SELECT @NEW_SAL;
-- 프로시저 실행 후 -> 1300만

/*
 5. IF - ELSE (조건문)
 */
DELIMITER //
CREATE PROCEDURE checkEmployeeSalary(
    IN id VARCHAR(3),
    IN threshold DECIMAL(10, 2),
    OUT result VARCHAR(50)
)
BEGIN

    DECLARE SAL DECIMAL(10, 2); -- 프로시저 내부에서만 사용하는 지역 변수 선언
    SELECT SALARY
    INTO SAL -- ID가 일치하는 사원의 급여를 SQL 지역 변수에 저장
    FROM employee
    WHERE EMP_ID = ID;

    IF SAL > threshold
    THEN
        SET RESULT = '기준치를 넘는 급여입니다.';
    ELSE
        SET RESULT = '기준치의 이하 급여입니다.';
    end if;
end //
DELIMITER ;

SET @RESULT = '';
CALL checkEmployeeSalary('200', 10000000, @RESULT);
SELECT @RESULT;

/*
 6. CASE
 - 여러 경우에 대한 조건문
 */
DELIMITER //
CREATE OR REPLACE PROCEDURE GETDEPARTMENTMESSAGE(
    IN ID VARCHAR(3),
    OUT MESSAGE VARCHAR(50)
)
BEGIN
    DECLARE DEPT VARCHAR(50); -- 지역 변수 선언
    SELECT DEPT_CODE
    INTO DEPT
    FROM employee
    WHERE EMP_ID = ID;
    CASE
        WHEN dept = 'D1' THEN SET message = '인사관리부 직원이시군요!';
        WHEN dept = 'D2' THEN SET message = '회계관리부 직원이시군요!';
        WHEN dept = 'D3' THEN SET message = '마케팅부 직원이시군요!';
        ELSE SET message = '어떤 부서 직원이신지 모르겠어요!';
        END CASE;
end //
DELIMITER ;

SET @MESSAGE = '';
CALL GETDEPARTMENTMESSAGE('221', @MESSAGE);
SELECT @MESSAGE;

/*
 7. WHILE (반복문)
 */
DELIMITER //

CREATE PROCEDURE calculateSumUpTo(
    IN max_num INT,
    OUT sum_result INT
)
BEGIN
    DECLARE current_num INT DEFAULT 1;
    DECLARE total_sum INT DEFAULT 0;

    WHILE current_num <= max_num
        DO
            SET total_sum = total_sum + current_num;
            SET current_num = current_num + 1;
        END WHILE;

    SET sum_result = total_sum;
END //

DELIMITER ;

CALL calculateSumUpTo(10, @result);
SELECT @result;


/*
 8. 예외 처리
 */

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

DELIMITER //
CALL divideNumbers(10, 0, @RESULT);
SELECT @RESULT;
-- ------------------------------------------------------------------------------
/* STORED FUNCTION
- 매개 변수는 IN(생략)
- 반환 값 무조건 1개
- 호출 방법 : SELECT문에서 함수() 호출
 */
DELIMITER //
CREATE OR REPLACE FUNCTION getAnnualSalary(
    id VARCHAR(3)
)
    RETURNS DECIMAL(15, 2) -- 반환 값의 자료형을 명시 + 무조건 반환값이 1개 있어야 한다
    DETERMINISTIC -- 매개 변수 값이 동일하면 결과도 항상 동일하다
BEGIN
    DECLARE monthly_salary DECIMAL(10, 2);
    DECLARE annual_salary DECIMAL(15, 2);

    SELECT salary
    INTO monthly_salary
    FROM employee -- 조회된 salary를 montlye_salary에 대입
    WHERE emp_id = id;

    SET annual_salary = monthly_salary * 12;

    RETURN annual_salary;
end //
DELIMITER ;

SELECT EMP_ID, EMP_NAME, SALARY, getAnnualSalary(EMP_ID) 연봉
FROM employee;