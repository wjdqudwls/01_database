/* 13_DDL (DATA DEFINITION LANGUAGE)
   - 데이터 정의 언어
   - 데이터베이스 스키마를 생성하는 작접
*/

-- 1. CREATE(생성)
/*
CREATE TABLE [IF NOT EXISTS] 테이블명 (
  컬럼명1 데이터타입 [제약조건],
  컬럼명2 데이터타입 [제약조건],
  ...
);
*/

drop table tb1;
CREATE TABLE IF NOT EXISTS tb1 (
    pk INT PRIMARY KEY, -- 컬럼 레벨에서  제약조건 추가
    fk INT,
    col1 VARCHAR(255),
    CHECK(col1 IN ('Y', 'N')) -- 테이블 레벨에서 제약조건 추가
) ENGINE=INNODB;

DESCRIBE tb1;

-- 줄여서 쓸 수도 있다.
DESC tb1;

/* 테이블 생성 시 AUTO_INCREMENT 적용
   - AUTO_INCREMENT란?
   - PRIMARY키에 해당하는 컬럼에 자동으로 번호를 발생(중복되지 않게)시켜 저장

   - 사용법 : INSERT/UPDATE 시 AUTO_INCREMENT가 적용된 컬럼의 값으로 NULL 대입

*/
CREATE TABLE IF NOT EXISTS tb2 (
    pk INT AUTO_INCREMENT PRIMARY KEY,
    fk INT,
    col1 VARCHAR(255),
    CHECK(col1 IN ('Y', 'N'))
) ENGINE=INNODB;

-- pk 컬럼 값을 null로 지정해서 insert(auto_increment 확인)
insert into tb2 values(null,10,'Y');
insert into tb2 values(null,20,'Y');
insert into tb2 values(null,30,'Y');
insert into tb2 values(null,40,'Y');

insert into tb2(fk,col1) values(50,'Y');

select * from tb2;

/* ALTER
   - 테이블에 추가/변경/수정/삭제하는 모든 것은 ALTER 명령어를 사용해 적용한다.
   - 종류가 너무 많고 복잡하므로 대표적인 것만 살펴보도록 하자.

   ALTER TABLE 테이블명 ADD 컬럼명 컬럼정의
*/

-- col2 컬럼 추가(INT형, NOT NULL 제약조건 존재)
ALTER TABLE tb2
ADD col2 INT NOT NULL;

DESCRIBE tb2;

-- 컬럼 삭제
ALTER TABLE tb2
DROP COLUMN col2;

DESCRIBE tb2;

-- 열 이름 및 데이터 형식 변경
-- `ALTER TABLE 테이블명 CHANGE COLUMN 기존컬럼명 바꿀 컬럼명 컬럼정의`
ALTER TABLE tb2
CHANGE COLUMN fk change_fk INT NOT NULL;

DESCRIBE tb2;

-- 열 제약 조건 추가 및 삭제(이후 챕터에서 다룰 내용)
ALTER TABLE tb2
DROP PRIMARY KEY;    -- 에러 발생

/* AUTO_INCREMENT가 걸려 있는 컬럼은
   PRIMARY KEY 제거가 안되므로 AUTO_INCREMENT를 MODIFY 명령어로 제거한다.(MODIFY는 컬럼의 정의를 바꾸는 것이다.)
*/
ALTER TABLE tb2
MODIFY pk INT;

DESCRIBE tb2;

-- 다시 제약조건 삭제
ALTER TABLE tb2
DROP PRIMARY KEY;

-- 다중 컬럼 추가
ALTER TABLE tb2
ADD col3 DATE NOT NULL,
ADD col4 TINYINT NOT NULL;

DESC tb2;
DESCRIBE tb2;

-- drop
-- tb3 테이블 생성
CREATE TABLE IF NOT EXISTS tb3 (
  pk INT AUTO_INCREMENT PRIMARY KEY,
  fk INT,
  col1 VARCHAR(255),
  CHECK(col1 IN ('Y', 'N'))
) ENGINE=INNODB;

desc tb3;


-- tb3 테이블 삭제
DROP TABLE IF EXISTS tb3;

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

desc tb4;
desc tb5;

-- 한번에 2개의 테이블 삭제
DROP TABLE IF EXISTS tb4, tb5;

/* 4. TRUNCATE
      - 테이블 내 모든 데이터 삭제
      - 원리 : 테이블을 삭제하고 똑같은 테이블을 새로 만듦
      - 데이터 삭제 성능이 매우 좋음
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

-- 테이블 초기화 하기
-- TRUNCATE TABLE tb6;
TRUNCATE tb6;    -- TABLE 키워드 생략 가능