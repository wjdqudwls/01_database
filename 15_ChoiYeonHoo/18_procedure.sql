/*
    18_PROCEDURE (프로시져)
*/

/*
    1. 매개 변수 (Parameter) 없는 Procedure
*/

DELIMITER //

CREATE PROCEDURE getAllEmployee()

    BEGIN
        SELECT
            EMP_ID,
            EMP_NAME,
            SALARY
        FROM
            employee;
    END //

DELIMITER ;

-- 프로시져 호출
CALL getAllEmployee();

-- 여러 SQL을 묶어서 실행하는 PROCEDURE 생성
DELIMITER @@

CREATE PROCEDURE getAllEmployeeDept()
    BEGIN
        SELECT
            EMP_ID,
            EMP_NAME,
            SALARY
        FROM
            employee;

        SELECT
            DEPT_ID,
            DEPT_TITLE
        FROM
            department;
    END @@

DELIMITER ;

CALL getAllEmployeeDept();

/*
    2. IN 매개 변수
    - PROCEDURE 호출 시 전달된 값을 저장하는 변수
    - (외부에있는 값이 PROCEDURE 내부로 들어옴(IN)
    - C# 에서 in 변수와 같다고 생각하면 된다.
*/

DELIMITER //
CREATE OR REPLACE PROCEDURE getEmployeesByDepartment( IN Dept CHAR(2) )

    BEGIN
        SELECT
            EMP_ID,
            EMP_NAME,
            DEPT_CODE,
            SALARY
        FROM
            employee
        WHERE
            DEPT_CODE = Dept;
    END //

DELIMITER ;

-- PROCEDURE CALL

CALL getEmployeesByDepartment('D9');
CALL getEmployeesByDepartment('D5');

-- Parameter 두개 짜리 PROCEDURE

DELIMITER //
CREATE OR REPLACE PROCEDURE getEmpByDeptSalary(IN dept VARCHAR(2), sal int)
    BEGIN
        SELECT
            DEPT_CODE,
            SALARY
        FROM employee
        WHERE DEPT_CODE = dept AND SALARY >= sal;
    END //

DELIMITER ;

CALL getEmpByDeptSalary('D5',2500000);

/*
    3.OUT Parameter
    - 결과 값을 호출한 곳으로 반환
    - C# 에서 out 변수와 같다고 생각하면 된다.

*/

/*
    @ 기호
    User Variable : 동적 변수
    - 동적 할당:
    - 세션 범위 :
    - 기본값 없음 :
    - 접두사 @ 사용 :
*/

DELIMITER //
CREATE OR REPLACE PROCEDURE getEmployeeSalary(IN id VARCHAR(3), OUT sal DECIMAL(10,2))
    BEGIN
        SELECT
            SALARY INTO sal
        FROM
            employee
        WHERE
            EMP_ID = id;
    END //

DELIMITER ;

SET @sal = 0;
CALL getEmployeeSalary('200', @sal);

SELECT @sal;

/*
    4. INOUT Parameter
    -- C# 에서 ref. 변수와 같다고 생각하면 된다.
*/

DELIMITER //

CREATE OR REPLACE PROCEDURE updateAndReturnSalary(IN id VARCHAR(3), INOUT sal DECIMAL(10,2))
    BEGIN
        -- 입력된 sal로 해당 id 인원의 SALARY를 업데이트 하고
        UPDATE employee
        SET SALARY = sal
        WHERE EMP_ID = id;

        -- 해당 인원의 보너스를 포함한 급여를 출력
        SELECT
            SALARY * (1 + IFNULL(BONUS,0)) INTO sal
        FROM employee
        WHERE EMP_ID = id;

    END //

DELIMITER ;

-- 바꾸기 전 보너스 포함 급여
SELECT SALARY * (1 + IFNULL(BONUS,0))
FROM employee
WHERE EMP_ID = 200;

-- 새로운 급여 1000만
SET @NEW_SAL = 10000000;
SELECT @NEW_SAL;
CALL updateAndReturnSalary('200',@NEW_SAL);

-- PROCEDURE 실행 후, 1300만 변경 확인
SELECT @NEW_SAL;

/*
    5. IF-ELSE (조건문)
*/

DELIMITER  //

CREATE OR REPLACE PROCEDURE checkEmployeeSalary(
	IN id VARCHAR(3),
	IN threshold DECIMAL(10,2),
	OUT result VARCHAR(50)
    )
    BEGIN
        -- PROCEDURE 내부에서만 사용하는 지역 변수 선언
        DECLARE sal DECIMAL(10,2);

        -- id가 일치하는 사원의 급여를 sal 지역 변수에 저장
        SELECT
            SALARY INTO sal
        FROM employee
        WHERE EMP_ID = id;

        IF sal > threshold THEN
            SET result = '기준치를 넘는 급여입니다.';
        ELSE
            SET result = '기준치와 같거나 이하의 급여입니다.';

        END IF;
    END //

DELIMITER ;

SET @result = '';

CALL checkEmployeeSalary('200', 10000000, @result);
SELECT @result;

CALL checkEmployeeSalary('200', 2000000, @result);
SELECT @result;

/*
    6. CASE
    - C# switch 구문
*/
DELIMITER //

CREATE OR REPLACE PROCEDURE getDepartmentMessage(
	IN id VARCHAR(3),
	OUT message VARCHAR(50)
)

    BEGIN
        -- 지역 변수 선언
        DECLARE dept VARCHAR(50);

        -- emp_id가 id인 사람의 의 dept_code를 조회해서 dept에 저장
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

-- 사용자 변수 선언
SET @message ='';
CALL getDepartmentMessage('220',@message);
SELECT @message;

/*
    7. While
    - 조건이 참 일 동안 반복해서 실행
*/

DELIMITER //

CREATE OR REPLACE PROCEDURE calculateSumUpTo(
    -- IN start_num INT,
    IN max_num INT,
    OUT sum_result INT
    )
    BEGIN
        DECLARE current_num INT DEFAULT 1;
        DECLARE total_sum INT DEFAULT 0; -- 합계 저장 할 변수
        -- current_num = start_num;

#         WHILE current_num <= max_num
#             DO
#                 SET total_sum = total_sum + current_num;
#                 SET current_num = current_num + 1;
#         END WHILE;
        -- While current_num < max_num -- 전달 받은 max_num 미만 까지 반복
        While current_num <= max_num -- 전달 받은 max_num 이하 까지 반복
        Do
            SET total_sum = total_sum + current_num; -- 이전 합계에 현재 숫자 누적
            SET current_num = current_num + 1; -- 반복이 끝날때 마다 1씩 증가
        END WHILE;

        SET sum_result = total_sum;
    END //

DELIMITER ;

SET @result = 0;
CALL calculateSumUpTo(5,@result);
SELECT @result;

/*
    8. 예외 처리 활용
    - ERROR : 코드로 해결 X
    - EXCEPTION - 코드로 해결 O
        1. 코드 수정
        2. 예외 처리
*/

DELIMITER //

CREATE PROCEDURE divideNumbers(
	IN numerator DOUBLE,
	IN denominator DOUBLE,
	OUT result DOUBLE
    )
    BEGIN
        DECLARE division_by_zero CONDITION FOR SQLSTATE '45000'; -- Error 코드를 45000으로 설정
            -- 예외 처리 선언
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

--    --------------------------------------------------------------------------------
/*
                                PROCEDURE           VS          FUNCTION
    목적:     특정 작업 수행, 여러작업 일괄 처리          | 계산 수행 후 값 반환
    반환값:    한개, 여러개 또는 없음                    | 항상 한개만 반환
    호출 방법 : CALL문 호출                            | SQL 문장에서 함수 이름 호출, SELECT 문 내에서 COUNT(), MAX()등과 같음.
    Parameter: in / out / inout                     | in만 사용 (in 만 사용하므로, 생략 가능)
    사용 범위 : 데이터 조작, 로직 구현                   | 데이터 기반 연산
*/

/*
    DETERMINISTIC : 동일한 입력값에 대해 항상 동일한 결과를 반환하는 함수
    NOT DETERMINISTIC : 동일한 입력값에 대해 동일한 결과를 내보내지 않을 수 있는 함수
        ex ) 시간 관련 함수들 : 특정 시간 입력하면, 하루 전, 이틀전 등 변할 수 있음
*/

/*
    FUNCTION
    - 매개 변수는 IN (생략 가능)
    - 반환값 무조건 1개
    - 호출 방법 : SELECT 문에서 함수() 호출
*/

DELIMITER //

CREATE OR REPLACE FUNCTION getAnnualSalary(id VARCHAR(3))

    -- RETURNS DECIMAL(15,2)  -- 반환 값의 자료형을 명시함. return 아니고 returns,
    RETURNS DECIMAL -- 자리수 오류 발생 안하게 하려면, 그냥 길이 지정 안하고 자료형만 지정하는 경우가 많음
    DETERMINISTIC -- 매개변수값이 동일하면 항상 같은 결과를 반환

    BEGIN
        DECLARE monthly_salary DECIMAL(10,2); -- 월급
        DECLARE annual_salary DECIMAL(15,2);  -- 연봉

        SELECT SALARY INTO monthly_salary -- 조회된 salary 값을 monthly_salary에 저장
        FROM employee
        WHERE EMP_ID = id;

        -- 연봉 계산
        SET annual_salary = monthly_salary * 12;

        RETURN annual_salary; -- 함수를 호출한 곳으로 annual_salary 값을 반환

    END //
DELIMITER ;

SELECT
    EMP_ID,
    EMP_NAME,
    SALARY,
    getAnnualSalary(EMP_ID) AS '연봉'
FROM employee;