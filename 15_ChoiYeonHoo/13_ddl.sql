/*
    13_DDL (Data Definition Language)
    - 데이터 정의 언어
    - 데이터베이스 스키마를 정의하거나, 수정
*/


    -- 1. CREATE (생성)

/*
CREATE TABLE [IF NOT EXISTS] 테이블명 (
  컬럼명1 데이터타입 [제약조건],
  컬럼명2 데이터타입 [제약조건],
  ...
);
*/

CREATE TABLE tb1 (
        pk INT PRIMARY KEY, -- 행을 식별 할 수 있는 컬럼 컬럼 레벨에서  제약조건 추가
        fk INT,

        col1 VARCHAR(255),
        CHECK(col1 IN ('Y', 'N')) -- 테이블 레벨에서 Constraints(제약 조건) 추가
    );

SELECT *
FROM tb1;

-- 테이블 구조 확인(설명)
DESCRIBE tb1;
DESC tb1; -- 짧게

-- IF NOT EXISTS : 테이블이 존재하지 않으면 수행
--                  (테이블이 이미 존재하면 만들지 말아라)
CREATE TABLE IF NOT EXISTS tb1 (
        pk INT PRIMARY KEY, -- 행을 식별 할 수 있는 컬럼 컬럼 레벨에서  제약조건 추가
        fk INT,

        col1 VARCHAR(255),
        CHECK(col1 IN ('Y', 'N')) -- 테이블 레벨에서 제약조건 추가
    ) ENGINE INNODB; -- 기본이 INNODB

-- INSERT TEST
INSERT INTO tb1
    values (1,10,'Y');


/*
    테이블 생성 시 AUTO-INCREMENT 적용
    -AUTO-INCREMENT
    PRIMARY 키에 해당하는 컬럼에 자동으로 번호를 발행(중복되지 않게)시켜 저장
    사용법 : INSERT/UPDATE 수행 시
   AUTO INCREMENT가 적용된 컬럼의 값으로 NULL 대입
 */

 CREATE TABLE IF NOT EXISTS tb2(
    pk INT AUTO_INCREMENT primary key ,
    fk INT,
    col1 VARCHAR(255)
    CHECK ( col1 IN ('Y','N'))
 ) ENGINE INNODB;

DESC tb2;

-- pk 컬럼 값을 NULL 로 지정해서 INSERT (Auto increment 확인)
INSERT INTO tb2 VALUES (NULL,10,'Y');
INSERT INTO tb2 VALUES (NULL,20,'Y');
INSERT INTO tb2 VALUES (NULL,30,'Y');
INSERT INTO tb2 VALUES (NULL,40,'Y');

SELECT * FROM tb2;

INSERT INTO tb2 VALUES (5,40,'Y');
INSERT INTO tb2 VALUES (6,40,'Y');
INSERT INTO tb2 VALUES (7,40,'Y');
INSERT INTO tb2 VALUES (NULL,40,'Y');

/*
    2. ALTER : 테이블에 추가/변경/수정/삭제 하는 구문

*/

-- 2-1. 컬럼(열) 추가
DESC tb2;

ALTER TABLE tb2
    -- ADD COLUMN col2 INT NOT NULL;
    ADD col2 INT NOT NULL; -- COLUMN 생략 가능

-- 2-2. 열 삭제
ALTER TABLE tb2
    -- DROP COLUMN col2;
    DROP col2; -- COLUMN 생략 가능
DESC tb2;

-- 2-3. 열 수정
ALTER TABLE tb2
#     CHANGE COLUMN fk change_fk; 바꾸려는거 하나만 쓰지 말고 모든 열에 대해 적어줘야함.
    CHANGE COLUMN fk change_fk DECIMAL NOT NULL;

-- 2-4. 열 제약 조건 추가 및 삭제

ALTER TABLE tb2
DROP PRIMARY KEY;    -- 에러 발생
 -- Auto increment는 PRIMARY KEY가 설정된 컬럼에서만 동작하는데
 -- > PK 삭제 시 Auto increment가 남아있으면 정상동작 X
 -- > 삭제 못하게 에러 발생
 --  Incorrect table definition; there can be only one auto column and it must be defined as a key

-- Primary Key를 지우고 싶으면 우선 Auto increment부터 삭제
-- 컬럼 수정 이용
ALTER TABLE tb2
    MODIFY pk INT;
DESCRIBE tb2; -- extra 항목에 있던 auto increment 사라짐

-- 다시 PK 삭제 시도
ALTER TABLE tb2
DROP PRIMARY KEY; -- 정상 삭제
DESCRIBE tb2; -- key 항목에 PRI 삭제

-- PK 제약 조건 다시 추가
ALTER TABLE tb2
    ADD PRIMARY KEY(pk);
DESCRIBE tb2; -- 추가 확인

-- 2-5. 다중 컬럼 추가

ALTER TABLE tb2
ADD col3 DATE NOT NULL,
ADD col4 TINYINT NULL,
ADD col5 CHAR(11) NOT NULL ;
DESCRIBE tb2;

-- 3. DROP
-- : 테이블(스키마) 삭제

-- tb3 테이블 생성(CREATE) 후 삭제(DROP)

-- tb3 테이블 생성
CREATE TABLE IF NOT EXISTS tb3 (
  pk INT AUTO_INCREMENT PRIMARY KEY,
  fk INT,
  col1 VARCHAR(255),
  CHECK(col1 IN ('Y', 'N'))
) ENGINE=INNODB;

SELECT * FROM tb3;

-- tb3 테이블 제거
DROP TABLE tb3; -- 이미 지웠으면 오류 발생
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

/*
    4. TRUNCATE (자르기)
    - 테이블 내 모든 데이터를 삭제
    - 원리 : 테이블을 삭제하고 똑같은 테이블을 새로 만듦
    - 데이터 삭제 성능이 매우 우수함.
    - DELETE와 다르게 ROLLBACK이 되지 않음
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

-- TRANSACTION 관련

SET AUTOCOMMIT = 0;

START TRANSACTION;

DELETE FROM tb6; -- 모든 행 DELETE로 삭제
SELECT * FROM tb6; -- 삭제 확인

ROLLBACK; -- ROLLBACK
SELECT * FROM tb6; -- 복구 확인

START TRANSACTION;
-- 테이블 초기화 하기
-- TRUNCATE TABLE tb6;
TRUNCATE tb6;    -- TABLE 키워드 생략 가능
SELECT * FROM tb6; -- 삭제 확인

ROLLBACK;
SELECT * FROM tb6; -- 롤백 안됨

/*
    (참고)
    - DML(INSERT, UPDATE, DELETE, REPLACE 등) 수행 후
    - DDL(CREATE, ALTER, DROP, TRUNCATE)을 수행 하면
     자동으로 COMMIT이 진행 된다.
      -> 이 후 ROLLBACK 불가!!!
*/