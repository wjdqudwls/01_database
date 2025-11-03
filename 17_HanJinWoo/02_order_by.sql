/* 02. order by
   -result set을 정렬하는 구문
   ->result set이란?
     select문의 결과 집합 (select 실행해서 조회되는 데이터의 집합)

   - 보통 select문 제일 마지막에 작성

   -정렬 방식
   1) asc: 오름차순(ascending)
   2) desc: 내림차순(descending)
 */

 select
     menu_code,
     menu_name,
     menu_price
 from
     tbl_menu
order by
   --   menu_price asc;
   menu_price desc;

-- 문자열 컬럼 기준 오름/내림차순
select menu_name
from tbl_menu
-- order by menu_name asc;
order by menu_name desc;

-- 컬럼 별로 정렬 기준 설정하기
select
    menu_code,
    menu_name,
    menu_price
from
    tbl_menu
order by
    menu_price desc,
    menu_code asc

-- 가격 오름차순, 같으면 이름 오름차순
select
    menu_code,
    menu_name,
    menu_price
from
    tbl_menu
order by
    menu_price asc,
    menu_code asc;

/* order by절에는 컬럼명 외에
   연산 결과,별칭,컬럼 순서 등을 이용할 수 있다
*/

-- 컬럼 순서 사용(추천X)
-- 추천하지 않는 이유:select절의 컬럼 순서는 언제든지 바뀔 수 있기 때문!
select
    7+3 as 더하기,
    menu_code,
    menu_name,
    menu_price
from
    tbl_menu
order by
    2 desc;
-- result set 중 2번째 컬럼(menu_name) 내림차순 정렬

-- 연산 결과를 이용한 정렬
select
    menu_code,
    menu_price,
    menu_code * menu_price
from
    tbl_menu
order by
    menu_code*menu_price desc;

-- 별칭을 이용하여 정렬
/* (중요) order by절은 select 해석 이후에 적용된다! */

select
    menu_code as '메뉴코드',
    menu_price as '메뉴가격',
    menu_code * menu_price as '연산결과'
from
    tbl_menu
order by
    `연산결과` desc;
-- `` (백틱) 문자열 모양을 그대로 인식
/*
 db에서 null == "빈칸"을 의미!!!
 */
-- null 값의 정렬 방식
select * from tbl_category;

/*
asc 정렬 시 null은 무조건 윗쪽
desc 정렬 시 null은 무조건 아랫쪽

order by 대상 컬럼명 앞에 - 추가 시
정렬 방향이 반대로 바뀜
*/

select
    category_code,
    category_name,
    ref_category_code
from
    tbl_category
order by
 --   ref_category_code asc; -- null 윗쪽, 오름차순
 -- ref_category_code desc; -- null 아랫쪽, 내림차순
  --  -ref_category_code asc; -- null 윗쪽, 내림차순
    -ref_category_code desc; -- null 아랫쪽, 오름차순

/*
 field(찾을값,목록1,목록2,...)함수
 -찾을값이 목록에 존재하면 해당 위치(숫자)를 반환
 -목록에 일치하는 값이 없다면 0 반환
 */
SELECT FIELD('A', 'A', 'B', 'C'); -- 1
SELECT FIELD('B', 'A', 'B', 'C'); -- 2
SELECT FIELD('C', 'A', 'B', 'C'); -- 3
SELECT FIELD('D', 'A', 'B', 'C'); -- 0

-- field() 함수를 이용해 정렬하기
-- --> 정렬 우선 순위 적용
select
    menu_name,
    orderable_status,
    field(orderable_status, 'Y', 'N')

   tbl_menu
order by
    field(orderable_status, 'Y', 'N') asc;
