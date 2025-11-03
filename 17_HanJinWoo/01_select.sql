-- 01_select : 특정 테이블의 원하는 데이터(행)을 조회하는 구문

-- tbl_menu 테이블의 모든 메뉴 이름(menu_name) 조회
/*범위 주석 (단축키 ctrl + shift + /) */
/*2*/
select
    menu_name
/*1*/
from
    tbl_menu;

-- 모든 메뉴의 menu_code, menu_name, menu_price 조회
select
        menu_code,
        menu_name,
        menu_price

from
    tbl_menu;

-- tbl_menu 테이블 모든 열 조회
select
    menu_code,
    menu_name,
    menu_price,
    category_code,
    orderable_status


FROM
    tbl_menu;

select
    *
from
    tbl_menu;

-- from 없이 단독 select 사용
-- == 선택할 테이블이 없다!
-- == 어떠한 테이블도 조회하려는 데이터를 가지고 있지 않다!

/*2*/
select 7 + 3;
select 7 - 3;
select 7 * 3;
select 7 / 3;
select 7 % 3; -- 나머지(modulo,mod)

select 7 + 3,7-3; -- 여러 컬럼(column,열,세로줄) 조회도 가능

-- 내장 함수 이용
select now(); -- 현재 시간
select concat('홍','길동'); -- () 내 문자열을 합쳐서 결과 출력

-- 컬럼 별칭 사용
select now() as 현재시간;
select concat('홍','길동') as 이름;
select concat('홍','길동') as 'full name'; -- 띄어쓰기도 문자열
select concat('홍','길동') as 'full name'; -- 띄어쓰기도 문자열

-- menudb 데이터베이스 내 모든 테이블 조회해보기

select
    *
from
    tbl_category;

select
    category_code,category_name
from
    tbl_category;

select * from tbl_order;
select * from tbl_order_menu;
select * from tbl_payment;
select * from tbl_payment_order;

