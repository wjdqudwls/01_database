/* 17. INDEX : 데이터 검색(SELECT) 속도 향상에 사용되는 객체 */
CREATE TABLE phone (
    phone_code INT PRIMARY KEY,
    phone_name VARCHAR(100),
    phone_price DECIMAL(10, 2)
);

INSERT
  INTO phone (phone_code , phone_name , phone_price )
VALUES
(1, 'galaxyS23', 1200000),
(2, 'iPhone14pro', 1433000),
(3, 'galaxyZfold3', 1730000);

SELECT * FROM phone;

/* EXPLAIN
   - 쿼리 실행 계획 분석용 명령어
    select_type 서브쿼리, 인덱스
    table 접근방식
    NULL index를 사용하지 않았다
            index를 사용하면 채워진다
    rows 행의 개수

 */
EXPLAIN SELECT * FROM phone WHERE phone_name = 'galaxyS23';

CREATE INDEX IDX_NAME ON PHONE(phone_name);
EXPLAIN SELECT * FROM phone WHERE phone_name = 'galaxyS23';
DROP INDEX IDX_NAME ON phone;

EXPLAIN
SELECT *
FROM tbl_menu A
JOIN tbl_category B
ON A.category_code=B.category_code
WHERE category_name IN (SELECT B.category_name
                     FROM tbl_category
                     WHERE A.category_code=4);

SELECT *FROM information_schema.STATISTICS
WHERE TABLE_SCHEMA = 'menudb';

-- 특정 테이블의 인덱스 조회
SHOW INDEX FROM employee;

-- 인덱스 생성
CREATE INDEX IDX_NAME ON PHONE(phone_name);

-- 인덱스 최적화를 위한 재구성
ALTER TABLE PHONE DROP INDEX IDX_NAME;
ALTER TABLE PHONE ADD INDEX IDX_NAME(PHONE_NAME);

-- 인덱스 속도 체험
# 인덱스를 이용한 속도 향상 확인

-- 1. 테이블 생성
DROP TABLE if exists students;
CREATE TABLE students (
                          id INT PRIMARY KEY,
                          name VARCHAR(50),
                          age INT,
                          grade VARCHAR(10)
);

SHOW INDEX FROM students;

-- 2. 학생 10만명 데이터 생성 프로시저
DELIMITER $$

CREATE PROCEDURE insert_sample_students()
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE random_age INT;
    DECLARE random_grade VARCHAR(10);

    WHILE i <= 100000 DO
            -- 나이: 18~25 랜덤
            SET random_age = 18 + FLOOR(RAND() * 8);

            -- 학점: A, B, C, D, F 중 랜덤
            SET random_grade = ELT(FLOOR(1 + RAND() * 5), 'A', 'B', 'C', 'D', 'F');

            INSERT INTO students (id, name, age, grade)
            VALUES (
                       i,
                       CONCAT('학생', LPAD(i, 5, '0')),  -- 학생00001, 학생00002, ...
                       random_age,
                       random_grade
                   );

            SET i = i + 1;
        END WHILE;
END$$

DELIMITER ;

-- 3. 프로시저 실행
CALL insert_sample_students();


-- 4. 확인
SELECT COUNT(*) FROM students;
SELECT * FROM students LIMIT 10;

-- 인덱스 사용 X : 31ms
select * from students where name = '학생49723';
-- 인덱스 사용 ㅇ : 4ms
select * from students where id = 49723;

-- 5. 프로시저 삭제 (정리)
DROP PROCEDURE insert_sample_students;

DROP INDEX idx_name ON phone;
SHOW INDEX FROM phone;