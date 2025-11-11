# Q1. VIEW 생성하기
# STUDENTS 테이블 생성
# STUDENT_ID (INT, PRIMARY KEY)
# NAME (VARCHAR)
# CLASS (VARCHAR)
CREATE TABLE STUDENTS
(
    STUDENT_ID INT PRIMARY KEY,
    NAME       VARCHAR(5),
    CLASS      VARCHAR(5)
);
# GRADES 테이블 생성
# GRADE_ID (INT, PRIMARY KEY)
# STUDENT_ID (INT, FOREGIN KEY)
# SUBJECT (VARCHAR)
# GRADE (CHAR)
CREATE TABLE GRADES
(
    GRADE_ID   INT PRIMARY KEY,
    STUDENT_ID INT,
    SUBJECT    VARCHAR(5),
    GRADE      CHAR(2),
    FOREIGN KEY (STUDENT_ID) REFERENCES STUDENTS (STUDENT_ID)
);
# STUDENTS 와 GRADES 를 조인하여 과목별로 정렬하여 학생들의 이름, 반, 성적을 보여주는
# 뷰를 생성하세요.
# 1단계 : CREATE TABLE
# 2단계 : 데이터 INSERT
# 3단계 : CREATE VIEW
# 4단계 : SELECT * FROM VIEW
INSERT INTO STUDENTS
VALUES (1, '유관순', 'A'),
       (2, '신사임당', 'B'),
       (3, '홍길동', 'A');
INSERT INTO GRADES
VALUES (1, 1, '과학', 'A'),
       (2, 1, '수학', 'B'),
       (3, 3, '과학', 'B'),
       (4, 3, '수학', 'A'),
       (5, 2, '과학', 'B'),
       (6, 2, '수학', 'C');
CREATE VIEW IF NOT EXISTS GRADEOFSTUDENT AS
SELECT G.SUBJECT, S.NAME, S.CLASS, G.GRADE
FROM STUDENTS S
         JOIN GRADES G ON S.STUDENT_ID = G.STUDENT_ID
ORDER BY G.SUBJECT ASC;
SELECT *
FROM GRADEOFSTUDENT;

# Q2. INDEX 생성 / 삭제
# EMPLOYEEDB의 EMPLOYEE 테이블을 대상으로 DEPT_CODE 컬럼에 인덱스를 생성하여
# 부서코드로 직원들을 검색할 때의 성능을 향상시키세요.
# EMPLOYEE 테이블의 인덱스를 조회해보세요.
# 생성한 인덱스를 다시 삭제하세요.
CREATE INDEX DEPTINDEX ON EMPLOYEE (DEPT_CODE);
SHOW INDEX FROM EMPLOYEE;
ALTER TABLE EMPLOYEE
    DROP INDEX DEPTINDEX;

# Q3. STORED PROCEDURE 생성
# 두 개의 숫자를 입력 받아 더한 결과를 출력하는 ADDNUMBERS STORED PROCEDURE를 작
# 성하세요.
# 호출 실행 테스트는 아래와 같습니다.
# CALL ADDNUMBERS(10, 20, @SUM);
# SELECT @SUM; -- 30 조회
DELIMITER //
CREATE PROCEDURE ADDNUMBERS(
    IN A INT,
    IN B INT,
    OUT RESULT INT
)
BEGIN
    SET RESULT = A + B;
END //
DELIMITER ;

SET @SUM = 0;
CALL ADDNUMBERS(10, 20, @SUM)
SELECT @SUM;

# Q4. STORED FUNCTION 생성
# 현재 가격과 인상 비율을 입력 받아 인상 예정가를 반환하는 INCREASEPRICE STORED
# FUNCTION을 만들고 메뉴 가격을 대상으로 SELECT 절에서 사용하여 아래와 같이 조회하
# 세요. 예정가는 십의 자리까지 버림처리합니다.
# 조회 결과는 아래와 같습니다.
DROP FUNCTION INCREASEPRICE;
DELIMITER //
CREATE OR REPLACE FUNCTION INCREASEPRICE(
    IN PRICE INT,
    IN INCREASERATE FLOAT
)
    RETURNS INT
    NOT DETERMINISTIC
BEGIN
    RETURN FLOOR(PRICE * (1 + INCREASERATE) / 100) * 100;
END //
DELIMITER ;

SELECT MENU_NAME 메뉴명, MENU_PRICE 기존가, INCREASEPRICE(MENU_PRICE, 0.1) 예정가
FROM TBL_MENU;

# Q5. TRIGGER 생성
# SALARY_HISTORY 테이블 생성
# HISTORY_ID (INT, PRIMARY KEY)
# EMP_ID (VARCHAR, FOREGIN KEY)
# OLD_SALARY (DECIMAL)
# NEW_SALARY (DECIMAL)
# CHANGE_DATE (DATETIME)
# EMPLOYEEDB의 SALARY 컬럼이 UPDATE 될 경우 해당 이력을 SALARY_HISTORY 테이블에
# INSERT 하는 트리거를 생성합니다.
# 1단계 : SALARY_HISTORY 테이블 생성
drop table SALARY_HISTORY;
drop trigger TRG_SALARY_UPDATE;
CREATE TABLE IF NOT EXISTS SALARY_HISTORY
(
    HISTORY_ID  INT AUTO_INCREMENT,
    EMP_ID      VARCHAR(50),
    OLD_SALARY  DECIMAL(20, 2),
    NEW_SALARY  DECIMAL(20, 2),
    CHANGE_DATE DATETIME,
    PRIMARY KEY (HISTORY_ID),
    FOREIGN KEY (EMP_ID) REFERENCES EMPLOYEE (EMP_ID)
);
desc SALARY_HISTORY;
# 2단계 : TRG_SALARY_UPDATE 트리거 생성
DELIMITER //
CREATE or replace TRIGGER TRG_SALARY_UPDATE
    AFTER UPDATE
    ON employee
    FOR EACH ROW
BEGIN
    INSERT INTO SALARY_HISTORY(HISTORY_ID, EMP_ID, OLD_SALARY, NEW_SALARY, CHANGE_DATE)
    values(null, EMP_ID, old.salary,
           NEW.SALARY,now());
#     !!컬럼 조회시에 new, old를 명시해줘야함
#     !!만일, AFTER UPDATE 트리거 내에서
#       서브쿼리를 사용한다면, 해당 서브쿼리의 데이터가 NEW(갱신)라고 생각하면 된다.
#     values ( null
#            , new.EMP_ID
#            , (SELECT SALARY
#               from employee
#               where emp_id = new.emp_id)
#            , new.SALARY
#            , now());
end //
DELIMITER ;

# 3단계 : EMPLOYEE의 특정 행의 SALARY 컬럼 수정 시 트리거 동작하는지 확인
UPDATE employee
SET salary = 7000000
WHERE emp_id = '202';
SELECT *
FROM salary_history;

# 테스트 결과는 아래와 같습니다.
# UPDATE
#  EMPLOYEE
#  SET SALARY = 5000000
# WHERE EMP_ID = '202';
# SELECT * FROM SALARY_HISTORY;


