/* 13_DDL(Data Definition Language)
   - 데이터 정의 언어
   - 데이터베이스 스키마를 정의하거나 수정
*/

-- 1. CREATE (생성)
/*
CREATE TABLE [IF NOT EXISTS] 테이블명 (
  컬럼명1 데이터타입 [제약조건],
  컬럼명2 데이터타입 [제약조건],
  ...
);
*/
-- IF NOT EXISTS 옵션 : 테이블이 존재하지 않으면 수행
--                     (테이블이 이미 존재하면 만들지 말아라!)
CREATE TABLE IF NOT EXISTS tb1(
    pk INT PRIMARY KEY, -- 행을 식별할 수 있는 컬럼
    fk INT,
    col1 VARCHAR(255),
    CHECK(col1 IN ('Y', 'N')) -- 테이블 레벨에서 제약조건 추가
) ENGINE=INNODB;

SELECT * FROM tb1;

-- 테이블 구조 확인(설명)
DESCRIBE tb1;
DESC tb1;

-- INSERT TEST
INSERT INTO tb1
VALUES(1, 10, 'Y');

SELECT * FROM tb1;


/* 테이블 생성 시 AUTO_INCREMENT 적용
   - AUTO_INCREMENT란?
     PRIMARY키에 해당하는 컬럼에 자동으로 번호를 발생(중복되지 않게)시켜 저장

   - 사용법 : INSERT/UPDATE 수행 시
        AUTO_INCREMENT가 적용된 컬럼의 값으로 NULL 대입
*/

CREATE TABLE IF NOT EXISTS tb2(
    pk INT AUTO_INCREMENT PRIMARY KEY,
    fk INT,
    col1 VARCHAR(255),
    CHECK ( col1 IN ('Y', 'N'))
) ENGINE = INNODB;

-- pk 컬럼 값을 NULL로 지정해서 INSERT (AUTO_INCREMENT 확인)
INSERT INTO tb2 VALUES(NULL, 10,'y');
INSERT INTO tb2 VALUES(NULL, 20,'y');
INSERT INTO tb2 VALUES(NULL, 30,'y');
INSERT INTO tb2 VALUES(NULL, 40,'y');

SELECT * FROM tb2;


/* 2. ALTER : 테이블에 추가/변경/수정/삭제하는 구문 */

-- 2-1. 열(컬럼) 추가
DESC tb2;

ALTER TABLE tb2
ADD col2 INT NOT NULL;

-- 2-2. 열 삭제 (COLUMN 생략 가능)
ALTER TABLE tb2
DROP COLUMN col2;

DESC tb2;

-- 2-3. 열 수정
ALTER TABLE tb2
CHANGE COLUMN fk change_fk DECIMAL NOT NULL;

-- 2-4. 제약 조건 추가/삭제

ALTER TABLE tb2
DROP PRIMARY KEY;    -- 에러 발생

-- AUTO_INCREMENT는
-- PRIMARY KEY가 설정된 컬럼에서만 동작이 가능함
-- -> PRIMARY KEY 삭제 시 AUTO_INCREMENT가 정상동작 x
--    삭제 못하게 에러 발생
--    Incorrect table definition; there can be only one auto column and it must be defined as a key

-- AUTO_INCREMENT 부터 삭제 (컬럼 수정 이용)
ALTER TABLE tb2
MODIFY pk INT;  -- MODIFY (수정)

DESC tb2;

-- 다시 PK 제약조건 삭제 시도
ALTER TABLE tb2
DROP PRIMARY KEY;


-- PK 제약조건 다시 추가
ALTER TABLE tb2
ADD PRIMARY KEY(pk);


-- 2-5. 다중 컬럼 추가
ALTER TABLE tb2
ADD col3 DATE NOT   NULL,
ADD col4 TINYINT    NULL,
ADD col5 CHAR(11)   NOT NULL;

DESC tb2;

SELECT * FROM tb2;




-- 3. DROP : 테이블 삭제

-- tb3 테이블 생성(DELETE) 후 삭제(DROP)

-- tb3 테이블 생성
CREATE TABLE IF NOT EXISTS tb3 (
  pk INT AUTO_INCREMENT PRIMARY KEY,
  fk INT,
  col1 VARCHAR(255),
  CHECK(col1 IN ('Y', 'N'))
) ENGINE=INNODB;

DESC tb3;

-- tb3 테이블 삭제
-- IF EXISTS : 테이블이 존재하면 삭제
DROP TABLE IF EXISTS tb3;


-- 테이블 여러 개 삭제하기

-- tb4 테이블 생성
CREATE TABLE IF NOT EXISTS tb4 (
  pk INT AUTO_INCREMENT PRIMARY KEY,
  fk INT,
  col1 VARCHAR(255),
  CHECK(col1 IN ('Y', 'N'))
) ENGINE=INNODB;

-- tb5 테이블 생성
CREATE TABLE IF NOT EXISTS tb5 (
  pk INT AUTO_INCREMENT PRIMARY KEY,
  fk INT,
  col1 VARCHAR(255),
  CHECK(col1 IN ('Y', 'N'))
) ENGINE=INNODB;

-- 한번에 2개의 테이블 삭제
DROP TABLE IF EXISTS tb4, tb5;

DESC tb4;



/* 4. TRUNCATE(잘라내기, 절삭)
    - 테이블 내 모든 데이터 삭제
    - 원리 : 테이블을 삭제하고 똑같은 테이블을 새로 만듦
    - 데이터 삭제 성능이 매우 우수함
*/

-- tb6 테이블 생성
CREATE TABLE IF NOT EXISTS tb6 (
  pk INT AUTO_INCREMENT PRIMARY KEY,
  fk INT,
  col1 VARCHAR(255),
  CHECK(col1 IN ('Y', 'N'))
) ENGINE=INNODB;

-- 4개 행 데이터 INSERT
INSERT INTO tb6 VALUES (null, 10, 'Y');
INSERT INTO tb6 VALUES (null, 20, 'Y');
INSERT INTO tb6 VALUES (null, 30, 'Y');
INSERT INTO tb6 VALUES (null, 40, 'Y');

-- 제대로 INSERT 되었는지 확인
SELECT * FROM tb6;

-- 자동 커밋 끄기
SET AUTOCOMMIT = OFF;

START TRANSACTION; -- 트랜잭션 시작

DELETE FROM tb6; -- 모든 행 DELETE로 삭제

ROLLBACK; -- 롤백 (DELETE 취소)
SELECT * FROM tb6; -- 복구 확인



-- 테이블 초기화 하기
-- TRUNCATE TABLE tb6;
TRUNCATE tb6;    -- TABLE 키워드 생략 가능
SELECT * FROM tb6; -- 삭제 확인

ROLLBACK;
SELECT * FROM tb6;


/* (참고)
    - DML(INSERT, UPDATE, DELETE, REPLACE) 수행 후
      DDL(CREATE, ALTER, DROP, TRUNCATE)를 수행하면
      자동으로 COMMIT이 진행된다!
            -> 이후 ROLLBACK 불가!!
*/