/* set operators
   - 여러 개의 result set(select 결과) 결합
   - union
   - union all
   - intersect
   - minus
*/

-- 1. union
select
    menu_code,
    menu_name,
    menu_price,
    category_code,
    orderable_status
from tbl_menu
where category_code = 10
union
select
    menu_code,
    menu_name,
    menu_price,
    category_code,
    orderable_status
from tbl_menu
where menu_price < 9000;

-- 2. union all (중복제거x)
select
    menu_code,
    menu_name,
    menu_price,
    category_code,
    orderable_status
from tbl_menu
where category_code = 10
union all
select
    menu_code,
    menu_name,
    menu_price,
    category_code,
    orderable_status
from tbl_menu
where menu_price < 9000;

-- 3. intersect

-- 1) inner join 방식
SELECT
       a.menu_code
     , a.menu_name
     , a.menu_price
     , a.category_code
     , a.orderable_status
  FROM tbl_menu a
 INNER JOIN (SELECT menu_code
                  , menu_name
                  , menu_price
                  , category_code
                  , orderable_status
               FROM tbl_menu
              WHERE menu_price < 9000) b ON (a.menu_code = b.menu_code)
 WHERE a.category_code = 10;

-- 2) in 연산자 이용
SELECT
       a.menu_code
     , a.menu_name
     , a.menu_price
     , a.category_code
     , a.orderable_status
  FROM tbl_menu a
 WHERE category_code = 10
   AND menu_code IN (SELECT menu_code
                       FROM tbl_menu
                      WHERE menu_price < 9000);

-- 4. minus
SELECT
       a.menu_code
     , a.menu_name
     , a.menu_price
     , a.category_code
     , a.orderable_status
  FROM tbl_menu a
  LEFT JOIN (SELECT menu_code
                  , menu_name
                  , menu_price
                  , category_code
                  , orderable_status
               FROM tbl_menu b
              WHERE menu_price < 9000) b ON (a.menu_code = b.menu_code)
 WHERE a.category_code = 10
   AND b.menu_code IS NULL;

