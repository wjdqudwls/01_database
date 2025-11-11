/*
INDEX : 데이터 검색 (SELECT 속도 향상에 사용되는 객체)
*/

CREATE TABLE phone
(
    phone_code  INT PRIMARY KEY,
    phone_name  VARCHAR(100),
    phone_price DECIMAL(10, 2)
);

INSERT
INTO phone (phone_code, phone_name, phone_price)
VALUES (1, 'galaxyS23', 1200000),
       (2, 'iPhone14pro', 1433000),
       (3, 'galaxyZfold3', 1730000);

/*
EXPLAIN
    - 쿼리 실행 계획 분석용 명령어.
*/
EXPLAIN SELECT * FROM phone;

-- 인덱스 생성 (phone_name 컬럼)
CREATE INDEX idx_name
ON phone(phone_name); -- phone_name에 대한 인덱스 생성

-- 인덱스를 사용해서 조회
EXPLAIN SELECT * FROM phone
WHERE phone_name = 'galaxyS23';

DROP INDEX idx_name ON phone;

EXPLAIN SELECT *
FROM tbl_menu a
JOIN tbl_category b ON a.category_code = b.category_code
WHERE category_name = (SELECT category_name
                       FROM tbl_category
                       WHERE category_code = 4);

-- 데이터베이스에 존재하는 인덱스 모두 조회
SELECT * FROM information_schema.STATISTICS
WHERE TABLE_SCHEMA = 'menudb';

-- 특정 테이블의 인덱스 조회하는 방법
SHOW INDEX FROM tbl_menu;

-- 인덱스 생성
CREATE INDEX idx_name ON phone(phone_name);

-- 인덱스 최적화를 위한 재구성
ALTER TABLE phone DROP INDEX idx_name;
ALTER TABLE phone ADD INDEX idx_name(phone_name);

-- INDEX속도 체엄
# 인덱스를 이용한 속도 향상 확인

-- 1. 테이블 생성
DROP TABLE if exists students;
CREATE TABLE students
(
    id    INT PRIMARY KEY,
    name  VARCHAR(50),
    age   INT,
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

    WHILE i <= 100000
        DO
            -- 나이: 18~25 랜덤
            SET random_age = 18 + FLOOR(RAND() * 8);

            -- 학점: A, B, C, D, F 중 랜덤
            SET random_grade = ELT(FLOOR(1 + RAND() * 5), 'A', 'B', 'C', 'D', 'F');

            INSERT INTO students (id, name, age, grade)
            VALUES (i,
                    CONCAT('학생', LPAD(i, 5, '0')), -- 학생00001, 학생00002, ...
                    random_age,
                    random_grade);

            SET i = i + 1;
        END WHILE;
END$$

DELIMITER ;

-- 3. 프로시저 실행
CALL insert_sample_students();

-- 4. 확인
SELECT COUNT(*)
FROM students;

SELECT *
FROM students
LIMIT 10;

-- INDEX 사용 X
select *
from students
where name = '학생71293';

-- INDEX 사용 X
select *
from students
where id = 71293;

-- 5. 프로시저 삭제 (정리)
DROP PROCEDURE insert_sample_students;
DROP TABLE students;