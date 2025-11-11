/*
    13_DDL(Data Definition Language)
    - 데이터 정의 언어
    - 데이터베이스 스키마를 정의하거나 수정
*/

-- 1. create (생성)
/*
CREATE TABLE [IF NOT EXISTS] 테이블명 (
                                      컬럼명1 데이터타입 [제약조건],
                                      컬럼명2 데이터타입 [제약조건],
                                      ...
);
*/

-- if not exists : t이 존재하지 않으면 수행, 존재하면 수행 x
create table if not exists tb1(
    pk int primary key ,  -- pk : 행 식별자
    fk int,
    col1 varchar(255),
    check(col1 in('Y', 'N'))
) engine=innoDB;    -- 수정,삭제 용이, 트랜잭션 지원 좋음

select * from tb1;

describe tb1  ;  --  t구조 확인 설명

-- insert test
insert into tb1 values(1, 10, 'Y');


/*
 테이블 생성시 auto_increment 적용
 : pk키에 해당하는 컬럼에 자동으로 번호를 발생(중복되지 않게)시켜 저장

 사용법: insert update 수행 시
 auto_increment가 적용된 컬럼의 값으로 null 대입
 */
    create table if not exists tb2(
        pk int auto_increment primary key ,
        fk int,
        col1 varchar(255),
        check ( col1 in('Y', 'N') )
    ) engine=innoDB;

-- pk 컬럼 값은 null로 지정해서 insert(auto_increment check)
insert into tb2 values(null, 1, 'Y');
insert into tb2 values(null, 2, 'N');
insert into tb2 values(null, 3, 'N');
insert into tb2 values(null, 4, 'Y');
insert into tb2 values(null, 4, 'Y');


select * from tb2;


/*
    2_ALTER
    : 테이블에 추가/변경/수정/삭제하는 구문
    - 열(컬럼)추가
*/

alter table tb2
add pk  int auto_increment not null;  -- 뒤늦게 추가한 not null column의 경우 조회해보면  int형이라서 0이 기본값으로 입력되나봄

describe tb2;

select * from tb2;

-- 열삭제
alter table tb2
drop column col2;   -- column 입력 안해도 지워지긴함

select * from tb2;

describe tb2;

-- 2-3 열 수정
alter table tb2
change column fk change_fk decimal not null;    -- 열과 데이터타입 같이 수정해야함

describe tb2;

alter table tb2
drop pk;

-- auto_increment는 pk가 설정된 컬럼에서만 동작이 가능함
-- pk삭제시 auto_increment가 정상동작 안함
-- 삭제 못하게 에러 발생

-- auto_increment부터 제거(컬럼 수정)
alter table tb2
modify pk int;  -- modify 수정

desc tb2;   -- describe

-- 다시 pk제약조건 삭제 실행
alter table tb2
drop primary key;

-- pk제약조건 다시 추가
alter table tb2
add primary key (pk);

desc tb2;

drop table tb2;

-- 2-5. 다중 컬럼 추가
alter table tb2
add col3 date not null,
add col4 tinyint null,
add col5 char(11) not null;

desc tb2;

select * from tb2;


-- 3. drop : T 삭제
-- tb3 table create after drop
-- delete and drop

CREATE TABLE IF NOT EXISTS tb3 (
                                   pk INT AUTO_INCREMENT PRIMARY KEY,
                                   fk INT,
                                   col1 VARCHAR(255),
                                   CHECK(col1 IN ('Y', 'N'))
) ENGINE=INNODB;

drop table if exists tb3;

CREATE TABLE IF NOT EXISTS tb4 (
                                   pk INT AUTO_INCREMENT PRIMARY KEY,
                                   fk INT,
                                   col1 VARCHAR(255),
                                   CHECK(col1 IN ('Y', 'N'))
) ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS tb5 (
                                   pk INT AUTO_INCREMENT PRIMARY KEY,
                                   fk INT,
                                   col1 VARCHAR(255),
                                   CHECK(col1 IN ('Y', 'N'))
) ENGINE=INNODB;

select * from tb5;

drop table if exists tb4, tb5;

/*
    4. truncate
    : 잘라내기, 절삭
    - 기존 테이블을 잘라내고 새 테이블을 만듬
    - 테이블 내 모든 데이터 삭제
    - 원리 : 테이블을 삭제하고 똑같은 테이블을 새로 만듬
    - 데이터 삭제 성능이 매우 우수하지만 단점은 복구가 안됨
    -- truncate로 데이터 삭제 시 rollback이 안됨
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

set autocommit = off;

start transaction ; -- 트랜잭션 실행

delete from tb6;    -- 모든 행 delete로 삭제

select * from tb6;  -- 삭제 확인

rollback;           -- delete cancel

select * from tb6;  -- 복구 확인

-- 제대로 INSERT 되었는지 확인
SELECT * FROM tb6;

-- 테이블 초기화 하기
-- TRUNCATE TABLE tb6;
-- truncate table tb6
TRUNCATE tb6;    -- TABLE 키워드 생략 가능


start transaction ; -- 트랜잭션 시작

-- 테이블 초기화
truncate tb6;           -- truncate는 dbms에서 작업하는게 아니라 트랜잭션을 밀고 들어가서 db에서 작업하기 때문에 바로 반영되는 것(DDL 특징)
select * from tb6;

rollback ;
select * from tb6;
-- DDL을 수행하면 commit이 자동으로 수행됨(우선순위가 높음)

/*
    cf)
    - dml 수행 후 ddl을 수행하면 자동으로 commit이 진행된다.
    - commit이 되면 transaction 내용이 db에 들어갔으므로 당연히 rollback이 안된다.
*/

-- update set T where
-- insert into T values
-- delete from where
-- drop
-- truncate


select
    a.category_code
     , b.category_name
     , avg(a.menu_price)
from tbl_menu a
         join tbl_category b on(a.category_code = b.category_code)
group by a.category_code, b.category_name;


select
    max(count)
from (select count(*) as 'count'
      from tbl_menu
      group by category_code) as countmenu;

WITH menucate AS (
    SELECT menu_name,
           category_name
    FROM tbl_menu a
             JOIN tbl_category b
                  ON a.category_code = b.category_code
)
SELECT *
FROM menucate
ORDER BY menu_name;
