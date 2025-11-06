/*
    08. subquery
    - main query 내에서 실행되는 보조 query(select)
    - 종류 : 단일 행, 다중 행, 다중 열, 단일 행 다중 열, 스칼라 서브쿼리, 상관 서브쿼리, 인라인 뷰
    - 서브쿼리를 위한 연산자 : exists
*/

-- 서브쿼리 예시
-- '민트미역국'과 같은 카테고리의 메뉴를 모두 조회하시오

select *
from tbl_menu
where menu_name = '민트미역국';

select menu_name, category_code
from tbl_menu
where category_code = (
        select  category_code
        from    tbl_menu
        where   menu_name = '민트미역국'
    );


-- 전체 메뉴의 평균 가격보다 비싼 메뉴 찾기
select
    menu_name,
    menu_price
from tbl_menu
where menu_price > (select avg(menu_price) from tbl_menu);

-- 가장 비싼 메뉴가 속한 카테고리의 모든 메뉴 조회
select
    menu_name,
    menu_price,
    category_code
from tbl_menu
where category_code = (select category_code
                       from tbl_menu
                       order by menu_price desc
                       limit 1);

-- 2) 다중행 서브쿼리
-- 서브쿼리가 여러 행, 1개의 컬럼 반환
-- 사용 연산자 : in, any, all, exists

-- '식사' 카테고리의 하위 카테고리에 속하는 모든 메뉴 조회
select
    menu_name,
    menu_price,
    category_code
from tbl_menu
where category_code in( select category_code
                        from tbl_category
                        where ref_category_code = 1);

-- '식사'의 하위 카테고리

-- 3) 다중열 서브쿼리
-- 서브쿼리가 1개의 행, 여러 컬럼 반환
-- 여러 컬럼을 한 번에 비교

-- 10번째로 비싼 메뉴와 동일한 카테고리 + 가격을 가진 메뉴
select *
from tbl_menu
where (category_code, menu_price)= (select
            category_code, menu_price
            from tbl_menu
            order by menu_price desc
            limit 9,1); -- 서브쿼리에 컬럼 두개니까 메인쿼리 where절에도 받는 컬럼 두개

-- 4) 다중행 다중열 서브쿼리
-- 서브쿼리가 여러 행, 여러 컬럼 반환
-- in 연산자와 함께 사용

-- 각 카테고리별로 가장 저렴한 메뉴
select tbl_menu.menu_name,
       tbl_menu.category_code,
       tbl_menu.menu_price
from tbl_menu
where (category_code, menu_price) in (select category_code, min(menu_price)
                                      from tbl_menu
                                      group by category_code)
order by category_code;

-- 5) 스칼라 서브쿼리
-- select 절에서 사용되는 서브쿼리(1행 1열만 반환)

-- 메뉴 정보와 함께 카테고리명도 조회(join대신 서브쿼리 사용)
select menu_code,
       menu_name,
       menu_price,
       (select category_name
        from tbl_category
        where category_code = m.category_code) as category_name -- select절에 사용되는 서브쿼리를 스칼라 서브쿼리라고 칭함
from tbl_menu m
order by menu_code
limit 5;


-- 각 메뉴의 가격과 전체 평균의 차이
SELECT menu_name
     , menu_price
     , (SELECT AVG(menu_price) FROM tbl_menu)              AS avg_price
     , menu_price - (SELECT AVG(menu_price) FROM tbl_menu) AS price_diff
FROM tbl_menu
ORDER BY price_diff DESC;


-- 메뉴 정보와 함께 다양한 통계 표시
SELECT menu_name
     , menu_price
     , (SELECT MIN(menu_price) FROM tbl_menu) AS min_price
     , (SELECT MAX(menu_price) FROM tbl_menu) AS max_price
     , (SELECT AVG(menu_price) FROM tbl_menu) AS avg_price
     , (SELECT COUNT(*) FROM tbl_menu)        AS total_menu_count
FROM tbl_menu
WHERE menu_code = 1;


/* 상관서브쿼리(상호연관서브쿼리)
   1) 메인 쿼리를 1행씩 접근(커서)
   2) 서브 쿼리에서 사용할 메인 쿼리의 컬럼값을 전달(메인쿼리에서 서브쿼리로 넘어감)
   3) 서브쿼리가 전달 받은 값을 이용해서 select 수행
   4) 서브쿼리 수행 결과를 다시 메인쿼리에 전달(서브쿼리 > 메인쿼리)
   5) 메인쿼리가 전달 받은 값을 이용해 연산 수행 >
        - where : 연산 수행 결과에 따라 메인 쿼리 1행을 result set에 포함 할지 말지 결정
        - select : 단순 출력 or 추가 연산
   */
select avg(tbl_menu.menu_price)
from tbl_menu
where category_code = 4;    -- group by 역할과 같이 4번그룹을 지어서 평균 보여줌


-- 카테고리별 평균 가격보다 높은 가격의 메뉴 조회
select
    menu_code,
    menu_name,
    menu_price,
    category_code,
    orderable_status
from tbl_menu a
where
    menu_price > (select avg(b.menu_price)
                  from tbl_menu b
                  where b.category_code = a.category_code   -- 서브쿼리 실행하면서 main쿼리 실행할 때 한행씩 실행
                  )
order by menu_code;

/* exists
   - 서브쿼리의 조회 결과가 있을 경우에만 해당 메인 쿼리 1행을 result set에 포함시키는 연산자 */

-- 실제로 메뉴 테이블에 사용된 카테고리만 조회
select category_name
from tbl_category a
where exists(select 1   -- 값 존재 여부이므로 select 옆에 아무거나 써도 상관 x
             from tbl_menu b
             where b.category_code = a.category_code)
order by 1; -- 첫번째 컬럼을 정렬의 기준
-- 서브쿼리에 값이 존재하면 메인쿼리에 값을 태우고 그렇지 않으면 값을 넣지 않음


/* CTE(Common Table Expression)
  -- 인라인 뷰로 사용되는 서브쿼리를 미리 정의해서 사용하는 방법
  -- 인라인뷰 : from절에 사용되는 서브쿼리로 서브쿼리의 결과를 테이블처럼 사용
  */

-- 인라인뷰
select
    me, nu
from (

         select
             a.menu_name as me,
             b.category_name as nu
         from tbl_menu a
                  join tbl_category b
                       on a.category_code = b.category_code
     ) as menu_category
where me like '%마늘%'
;

-- CTE 적용(속도 조금 빨리짐) > 메인쿼리 계산하다가 서브쿼리 계산하는 것보다는 따로 계산하므로 속도 빨라짐
with menu_category as (

    select
        a.menu_name as me,
        b.category_name as nu
    from tbl_menu a
             join tbl_category b
                  on a.category_code = b.category_code
)   -- 서브쿼리
select
    me, nu
from menu_category
where me like '%마늘%';   -- 메인쿼리
-- 서브쿼리와 메인쿼리 분리

-- command + / > 한줄 주석
-- command + shift + / > 여러줄 주석

-- result set : select 결과 집합
