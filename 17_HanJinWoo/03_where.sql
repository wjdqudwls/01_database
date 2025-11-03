/*
 03_where
 - 테이블에서 특정 조건에 맞는 레코드(행,row)만 선택하는 구문
 - 조건을 나타내기 위한 각종 연산자를 사용
 */

 -- 1) 비교 연산자 (=, !=,<>,<,>,<=,>=)
select
    menu_code,
    menu_name,
    orderable_status
from
    tbl_menu;


-- [=]:값이 일치하는지 확인
select -- 3
    menu_code,
    menu_name,
    orderable_status
from -- 1
    tbl_menu
where -- 2
    orderable_status = 'Y'
order by -- 4
    menu_name asc;


-- 이름이 '붕어빵초밥'인 메뉴
select
    *
from
    tbl_menu
where
    menu_name = '붕어빵초밥';

-- 메뉴 가격이 13000인 메뉴의
--  메뉴명, 가격을
-- 메뉴명 내림 차순으로 조회

select
    menu_name,
    menu_price
from
    tbl_menu
where
    menu_price = 13000
order by
    menu_name desc;

-- [!=,<>] 같지 않음
-- 주문가능상태가 'Y'가 아닌 메뉴의
-- 메뉴코드, 메뉴명, 주문가능상태를
-- 메뉴명 오름차순으로 조회

select
    menu_code,
    menu_name,
    orderable_status
from
    tbl_menu
where
 #   orderable_status != 'Y'
    orderable_status <> 'Y'
order by
    menu_name asc;

-- 대소 비교(초과, 미만, 이상, 이하)
-- 메뉴 가격이 20000원 초과인 메뉴의
-- 메뉴명, 가격을
-- 메뉴코드 오름차순으로 조회

select
    menu_name,
    menu_price
from
    tbl_menu
where
    menu_price > 20000
order by
    menu_code desc;


-- 대소 비교(초과, 미만, 이상, 이하)
-- 메뉴 가격이 20000원 이상인 메뉴의
-- 메뉴명, 가격을
-- 메뉴코드 오름차순으로 조회

select
    menu_name,
    menu_price
from
    tbl_menu
where
    menu_price >= 20000
order by
    menu_code desc;

-- 대소 비교(초과, 미만, 이상, 이하)
-- 메뉴 가격이 20000원 미만인 메뉴의
-- 메뉴명, 가격을
-- 메뉴코드 오름차순으로 조회

select
    menu_name,
    menu_price
from
    tbl_menu
where
    menu_price < 20000
order by
    menu_code desc;

/*
 반대되는 범위
 초과<->이하
 미만<->이상
 */

 /*
  2) 논리 연산자
  -논리란? 참, 거짓을 나타내는 값
  -and
  */

-- A and B: a와b 모두 참인 경우 결과가 true
-- 나머진 모두 거짓

-- 주문가능한 상태이며, 카테고리 코드가 10에 해당하는 메뉴만 조회
-- 카테고리 코드가
select
    *
from
    tbl_menu
where
    orderable_status = 'Y'
and
    category_code = 10;

-- 메뉴 가격이 5000원 초과이면서
-- 카테고리 번호가 10인 메뉴의
-- 메뉴코드, 메뉴명, 카테고리 코드를
-- 메뉴코드 오름차순으로 조회

select
    menu_code,
    menu_name,
    category_code
from
    tbl_menu
where
    menu_price > 5000
and
    category_code = 10
order by
    menu_code asc;

-- 메뉴 가격이 5000원 이상, 20000원 미만인
-- 메뉴의 메뉴명, 메뉴가격을
-- 메뉴 가격 오름차순으로 조회

select
    menu_name,
    menu_price
from
    tbl_menu
where
    menu_price >= 5000
and
    menu_price < 20000
order by
    menu_price asc;

-- 메뉴 가격이 5000원 이상, 20000원 미만
-- 카테고리 코드가 10인
-- 메뉴의 메뉴명, 메뉴가격, 카테고리 코드를
-- 메뉴 가격 오름차순으로 조회

select
    menu_name,
    menu_price
from
    tbl_menu
where
    (menu_price >= 5000 and menu_price < 20000)
and
    category_code = 10
order by
    menu_price asc;

/*
 a or b:
 - 둘 다ㅏ false인 경우에만 결과가 false
 -하나라도 true이면 true
 */

-- 주문가능한 상태이거나
-- 카테고리 코드가 10인 메뉴를 모두 조회
select
    *
from
   tbl_menu
where
    orderable_status = 'Y'
or
    category_code = 10;

-- 메뉴 가격이 5000원 미만, 20000원 이상
-- 메뉴의 메뉴명, 메뉴가격을
-- 메뉴 가격 오름차순으로 조회

select
    menu_name,
    menu_price
from
    tbl_menu
where
    menu_price < 5000
or
    menu_price >= 20000
order by
    menu_price asc;

/*
 and,or 연산 중 우선순위는
 and가 높다!!!!
 */

 select
     *
 from
     tbl_menu
 where
     category_code=4
 or
     menu_price=9000
 and
   menu_code > 10;

-- 흑마늘아메리카노, 까나리코코넛쥬스

 select
     *
 from
     tbl_menu
 where
     category_code=4
 or
     menu_price=9000
 and
   menu_code > 10;

/*
 and,or 연산 중 우선순위는
 and가 높다

 * 우선순위 문제 해결 시 () 이용!!
 */

 select
     *
 from
     tbl_menu
 where
     (category_code=4
 or
     menu_price=9000)
 and
   menu_code > 6;



