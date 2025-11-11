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
    CHECK(col1 IN ('Y', 'N'))
)  ENGINE=INNODB;

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
    CHECK ( col1 IN ('Y','N') )
) ENGINE = INNODB;

-- pk 컬럼 값을 NULL로 지정해서 INSERT (AUTO_INCREMENT 확인)
INSERT INTO tb2 VALUES(NULL, 10, 'Y');
INSERT INTO tb2 VALUES(NULL, 20, 'Y');
INSERT INTO tb2 VALUES(NULL, 30, 'Y');
INSERT INTO tb2 VALUES(NULL, 40, 'Y');

SELECT * FROM tb2;


/* 2. ALTER : 테이블에 추가/변경/수정/삭제하는 구문 */

--  2-1. 열(컬럼) 추가
DESC tb2;

ALTER TABLE tb2
ADD col2 INT NOT NULL;

DESC tb2;

-- 2-2. 열 삭제  (COLUMN 생략 가능)
ALTER TABLE tb2
DROP COLUMN col2;

DESC tb2;


-- 2-3. 열 수정
ALTER TABLE tb2
CHANGE COLUMN fk change_fk DECIMAL NOT NULL;

DESC tb2;


-- 2-4. 제약 조건 추가/삭제

ALTER TABLE tb2
DROP PRIMARY KEY;    -- 에러 발생

-- AUTO_INCREMENT는
-- PRIMARY KEY가 설정된 컬럼에서만 동작이 가능함
-- -> PRIMARY KEY 삭제 시 AUTO_INCREMENT가 정상 동작 x
--    삭제 못하게 에러 발생
--    Incorrect table definition; there can be only one auto column and it must be defined as a key

-- AUTO_INCREMENT 부터 삭제 (컬럼 수정 이용)
ALTER TABLE tb2
MODIFY pk INT AUTO_INCREMENT; -- MODIFY (수정)

DESC tb2;

-- 다시 PK 제약조건 삭제 시도
ALTER TABLE tb2
DROP PRIMARY KEY;

DESC tb2;


-- PK 제약조건 다시 추가
ALTER TABLE tb2
ADD PRIMARY KEY(pk);

DESC tb2;
