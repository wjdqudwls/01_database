/* 13.DDL(Data Definition Laguage)
   - 데이터 정의 언어
   - 데이터베이스 스키마를 정의하거나 수정

 */


 -- 1.CREATE (생성)
/*
CREATE TABLE [IF NOT EXISTS] 테이블명 (
  컬럼명1 데이터타입 [제약조건],
  컬럼명2 데이터타입 [제약조건],
  ...
);
*/
-- IF NOT EXISTS 옵션 : 테이블이 존재하지 않으면 수행
--                     테이블이 이미 존재하면 만들지 말아라
CREATE TABLE IF NOT EXISTS tb1(pk INT PRIMARY KEY, -- 행을 식별 할수 있는 컬럼
                 fk INT,
                 col1 VARCHAR(255),
                 CHECK ( col1 IN('Y', 'N') )
) ENGINE = INNODB;

select * from tb1;

-- 테이블 구조 확인, 설명 (DESC tb1)이랑 동일
DESCRIBE tb1;


-- INSERT TEST

insert into tb1
VALUES (1, 10, 'Y');

/* 테이블 생성 시 AUTO_INCREMENT 사용
   AUTO_INCREMENT란?
   PRIMARY키에 해당하는 칼럼에 자동으로 번호를 발생(중복되지 않게)시켜 저장

   -사용법 :  INSERT/UPDATE 수행 시
        AUTO_INCREMENT 가 적용된 컬럼의 값으로 NULL 대입
 */


CREATE TABLE IF NOT EXISTS tb2(
    pk INT PRIMARY KEY AUTO_INCREMENT,
    fk INT,
    col1 VARCHAR(255)
    CHECK (col1 IN('Y','N'))
)ENGINE  = INNODB;

SELECT * FROM tb2;

INSERT INTO tb2
VALUES(NULL,20,'Y'),
VALUES (Null,30,'N');

delete from tb2
where pk=2;

desc tb2;

/* 2.ALTER
    테이블에 추가/ 변경/ 수정 삭제하는 모든것을 알터 명령어를 사용해 적용한다.
*/

 -- 테이블 확인
    DESC tb2; -- DESC "테이블 이름";

 -- 컬럼 추가

ALTER table tb2
ADD col2 INT NOT NULL;


-- 열 삭제 ( COLUMN 생략 가능 )
ALTER TABLE tb2
DROP COLUMN col2;

-- 열 수정
ALTER TABLE tb2
CHANGE COLUMN fk change_fk DECIMAL NOT NULL

-- 제약조건 추가 삭제

ALTER TABLE tb2
DROP PRIMARY KEY;

-- AUTO_INCREMENT 는 PRIMARY KEY가 설정된 컬럼에서만 동작이 가능함
-- -> PRIMARY KEY 삭제시 AUTO_INCREMENT가 정상 동작 불가능
-- 삭제 못하게 오류 발생
-- 에러 내용   Incorrect table definition; there can be only one auto column and it must be defined as a key

-- AUTO INCREMENT 부터 삭제 ( 컬럼 수정 이용 )
ALTER TABLE tb2
MODIFY pk INT; -- modify = 수정

-- PK 제약조건 삭제 시도
ALTER TABLE tb2
DROP PRIMARY KEY ;

DESC tb2;

-- PK 제약조건 추가
ALTER TABLE tb2
ADD PRIMARY KEY(pk);

-- 다중 컬럼 추가
ALTER TABLE tb2
ADD col5 CHAR(11) NOT NULL

-- 3, DROP : 테이블 삭제

-- tb3 테이블 생성(CREATE) 후 삭제(DROP)

CREATE TABLE IF NOT EXISTS tb3 (
  pk INT AUTO_INCREMENT PRIMARY KEY,
  fk INT,
  col1 VARCHAR(255),
  CHECK(col1 IN ('Y', 'N'))
) ENGINE=INNODB;

DROP table IF EXISTS tb3; -- 테이블이 존재하면 지워라 없으면 안지움


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

DROP TABLE IF EXISTS tb4, tb5;

desc tb5;

/*-- Truncate ( 잘라내기, 절삭 )
-- 테이블 내 모든 데이터 삭제
--    원리 : 테이블을 삭제하고 똑같은 테이블을 새로 만든다.
    데이터 삭제 성능이 우수

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
SET AUTOCOMMIT  = 0;
START TRANSACTION; -- 트랜잭션 시작

DELETE FROM tb6;     -- 모든행 DELETE로 삭제
SELECT * FROM tb6;   -- 삭제 확인
ROLLBACK;            -- 롤백(삭제 취소)
SELECT * FROM tb6;   -- 삭제 확인

TRUNCATE tb6;        -- 복구 X

/* ( 참고 )
   DML(INSERT, UPDATE, DELETE, REPLACE) 수행 후
   DDL(CREATE, ALTER, DROP, TRUCATE)을 수행하면
   자동으로 COMMIT이 진행된다!
      -> 이후 ROLLBACK 불가능
*/