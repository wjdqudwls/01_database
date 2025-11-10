/* 13_DDL(Data Definition Language)
   - 데이터 정의 언어
   - 데이터베이스 스키마를 정의하거나 수정
 */

-- 1. CREATE TABLE
/*
 CREATE TABLE [IF NOT EXISTS] 테이블명 (
  컬럼명1 데이터타입 [제약조건],
  컬럼명2 데이터타입 [제약조건],
  ...
);
 */
-- IF NOT EXISTS 옵션 : 테이블이 존재하지 않으면 수행
--                      (테이블이 이미 존재하면 만들지 않는다)
CREATE TABLE IF NOT EXISTS tb1
(
    pk   INTEGER PRIMARY KEY, -- 행을 식별할 수 있는 컬럼
    fk   INTEGER,
    col1 VARCHAR(255),
    CHECK (col1 IN ('Y', 'N'))
) ENGINE = INNODB;

-- tb1 생성 확인 방법 (테이블 구조 확인)
-- int(11)의 의미 => (+,-)10자리의 수 = 1자리 부호 + 10자리 숫자
DESCRIBE tb1;
DESC tb1;
-- DESC = DESCRIBE 약어

-- INSERT 테스트
SELECT *
FROM tb1;
INSERT
INTO tb1
VALUES (1, 1, 'Y');
/* 테이블 생성 시 AUTO_INCREMENT 적용
   - AUTO_INCREMENT란?
        PRIMARY키에 해당하는 컬럼에 자동으로 번호를 발생(중복되지 않게)시켜 저장

   - 사용법 : INSERT/UPDATE 수행 시
        AUTO_INCREMENT가 적용된 컬럼의 값으로 NULL 대입
 */
CREATE TABLE IF NOT EXISTS tb2
(
    pk   INTEGER AUTO_INCREMENT PRIMARY KEY,
    fk   INTEGER,
    col1 VARCHAR(255),
    CHECK (col1 IN ('Y', 'N'))
) ENGINE = INNODB;

-- INSERT 테스트
SELECT *
FROM tb2;
INSERT INTO tb2
VALUES (NULL, 10, 'Y'),
       (NULL, 20, 'N'),
       (NULL, 30, 'Y'),
       (NULL, 40, 'N');

/* 2. ALTER : 테이블에 추가/변경/수정/삭제하는 구문 */
-- 2.1. 열(칼럼) 추가
DESC tb2;

ALTER TABLE tb2
    ADD col2 INT NOT NULL;

DESC tb2;
SELECT *
FROM tb2;
-- => 기존의 NULL값이 NOT NULL 제약조건 때문에, 0으로 바뀌었다.

-- 2.2. 열 삭제 (COLUMN 생략 가능)
ALTER TABLE tb2
    DROP COLUMN col2;

ALTER TABLE tb2
    DROP col2;
DESC tb2;

-- 2.3. 열 수정
ALTER TABLE tb2
    CHANGE COLUMN CHANGE_FK CHANGE_FK DECIMAL(10, 2) NOT NULL;

DESC tb2;

-- 2.4. 제약조건 추가/삭제
ALTER TABLE tb2
    DROP PRIMARY KEY;

-- AUTO_INCREMENT는
-- PRIMARY KEY가 설정된 컬럼에서만 동작이 가능함
-- -> PRIMARY KEY 삭제 시 AUTO_INCREMENT가 정상동작X
--    삭제 못하게 에러 발생 :
--      Incorrect table definition; there can be only one auto column and it must be defined as a key

-- AUTO_INCREMENT부터 삭제
ALTER TABLE tb2
    MODIFY COLUMN pk INT; -- MODIFY(수정)

ALTER TABLE tb2
    DROP PRIMARY KEY;

DESC tb2;

-- PK 제약조건 다시 추가
ALTER TABLE tb2
    ADD PRIMARY KEY (pk);

DESC tb2;

-- 2.5. 다중 커럼 추가
ALTER TABLE tb2
    ADD COL3 DATE     NOT NULL,
    ADD COL4 TINYINT  NULL,
    ADD COL5 CHAR(11) NOT NULL;

DESC tb2;

SELECT * FROM tb2;

/*
 3. DROP TABLE
 */
 -- 초기 테이블 생성
 CREATE TABLE IF NOT EXISTS TB3(
     COL1 INT AUTO_INCREMENT PRIMARY KEY ,
     COL2 INT NOT NULL,
     COL3 CHAR NOT NULL,
     CHECK(COL3 IN ('A','B'))
 ) ENGINE =INNODB;

DESC TB3;
INSERT INTO TB3
VALUES(NULL, 1, 'A');
SELECT * FROM TB3;

 CREATE TABLE IF NOT EXISTS TB4(
     COL1 INT AUTO_INCREMENT PRIMARY KEY ,
     COL2 INT NOT NULL,
     COL3 CHAR NOT NULL,
     CHECK(COL3 IN ('A','B'))
 ) ENGINE =INNODB;
DESC TB3;
INSERT INTO TB3
VALUES(NULL, 1, 'A');
SELECT * FROM TB3;
-- TB3 테이블 삭제
-- IF EXISTS : 테이블이 존재하면 삭제
DROP TABLE TB3;
DROP TABLE IF EXISTS TB3;

-- TB3, TB4 테이블 다중 삭제
DROP TABLE IF EXISTS TB3, TB4;

/*
 4. TRUNCATE(잘라내기, 절삭)
    - 기존 테이블 내 모든 데이터 삭제
    - 원리 : 테이블 삭제 후 재생성
 */

SET AUTOCOMMIT = OFF;
-- ROLLBACK TEST
START TRANSACTION ;

DELETE FROM TB2;
SELECT * FROM TB2;

ROLLBACK;
SELECT * FROM TB2;

-- TRUNCATE TEST (ROLLBACK이 되지 않는 것을 확인해보자)
START TRANSACTION ;

TRUNCATE TB2;
SELECT * FROM TB2;

ROLLBACK;
SELECT *FROM TB2;

/* (참고)
   - DML(INSERT,UPDATE,DELETE,REPLACE) 수행 후
     DDL(CREATE, ALTER, DROP, TRUNCATE)을 수행하면
     자동으로 COMMIT이 진행된다!
 */
