select
    *
from
    tbl_menu
where
    category_code = (select
    category_code as c
from
    tbl_menu
where
    menu_name = '민트미역국');

-- 전체 메뉴의 평균 가격보다 비싼 메뉴 찾기
select
    *
from
    tbl_menu
where menu_price > (select avg(menu_price)
                    from tbl_menu);

-- 가장 비싼 메뉴가 속한 카테고리의 모든 메뉴 조회
select
    *
from
    tbl_menu
where
    category_code = (select category_code
                    from tbl_menu
                    order by menu_price desc
                    limit 1);

-- 식사 카테고리의 하위 카테고리에 속하는 모든 메뉴 조회
select
    *
from
    tbl_menu
where
    category_code in (select category_code
                      from tbl_category
                      where ref_category_code = 1);

-- 가장 비싼 메뉴와 동일한 카테고리+가격을 가진 메뉴
select *
from tbl_menu
where (category_code, menu_price) = (select category_code, menu_price
                                     from tbl_menu
                                     order by menu_price desc
                                     limit 1);

-- 각 카테고리별로 가장 저렴한 메뉴들만 조회
select *
from tbl_menu
where (category_code, menu_price) in (select category_code, min(menu_price)
                                      from tbl_menu
                                      group by category_code);

-- 메뉴 정보와 함께 카테고리명도 조회
select menu_code, menu_name, menu_price, (select category_name
                                          from tbl_category
                                          where category_code = m.category_code) as category_name
from tbl_menu m;

-- 각 메뉴의 가격과 전체 평균의 차이
select menu_name,
       menu_price - (select avg(menu_price)
                     from tbl_menu) as price_diff
from tbl_menu;

-- 메뉴 정보와 함께 다양한 통계 표시
select menu_name,
       menu_price,
       (select min(menu_price) from tbl_menu) as min_price
from tbl_menu;

-- 이러면 min 함수 한번만 실행되며 한 행만 반환
select menu_name,
       menu_price,
       min(menu_price) as min_price
from tbl_menu;

-- 가격이 평균보다 큰 메뉴 모두 출력
select *
from tbl_menu
where menu_price > (select avg(menu_price)
                    from tbl_menu)