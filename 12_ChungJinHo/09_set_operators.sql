/* 09_set_operators
   - 2개 이상의 select 결과 set을 결합
   - union(합집합)
   - intersect(교집합)
   - union all(합집합, 중복포함) = union + all
   - minus(차집합)
   (중요) 집합 연산의 대상이 되는 두 result set은 컬럼 갯수가 같고 자료형도 같아야 함
*/

-- 1. union (합집합, 중복제거)
-- 두 집합의 합집합의 결과를 결합

SELECT menu_code
     , menu_name
     , menu_price
     , category_code
     , orderable_status
  FROM tbl_menu
 WHERE category_code = 10 -- 6행

 UNION

SELECT menu_code
     , menu_name
     , menu_price
     , category_code
     , orderable_status
  FROM tbl_menu
 WHERE menu_price < 9000; -- 9행
 -- 6행 + 9행 - 5행 = 10행

-- 2. union all (합집합, 중복포함)
-- 두 집합의 결과를 중복울 포함하여 결합

                          SELECT menu_code
     , menu_name
     , menu_price
     , category_code
     , orderable_status
  FROM tbl_menu
 WHERE category_code = 10 -- 6행

 UNION all

SELECT menu_code
     , menu_name
     , menu_price
     , category_code
     , orderable_status
  FROM tbl_menu
 WHERE menu_price < 9000; -- 9행
-- 6행 + 9행 = 15행

-- 3. intersect (교집합)
-- 두 집합의 교집합을 반환 mysql, mariadb에서는 제공 x, inner join이나 in 활용

-- inner join 방식
SELECT a.menu_code
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

-- in 연산 방식
SELECT a.menu_code
     , a.menu_name
     , a.menu_price
     , a.category_code
     , a.orderable_status
  FROM tbl_menu a
 WHERE a.category_code = 10
   and a.menu_code in (SELECT menu_code
                         FROM tbl_menu
                        WHERE menu_price < 9000);

-- 1. minus (차집합, 중복제거)
-- 두 집합의 차집합의 결과를 결합
-- left join을 이용하여 구현

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