/* 09_SET_OPERATORS
   - 두 개 이상의 SELECT 결과(RESULT SET)를 결합
   - UNION(합집함)
   - INTERSECT(교집합)
   - UNION ALL = UNION + INTERSECT / 공통 부분까지 추가
   - MINUS(차집합) /공통 부분을 뺌

   (중요) 집합 연산의 대상이 되는 두 RESULT SET은
   컬럼 개수가 같아야 함
   컬럼 자료형도 동일하게 (문자는 문자끼리 , 날짜는 날짜끼리)
*/

-- 1. UNION (합집합)
-- 두 집합의 결과를 결합
-- 단, 중복은 제거(중복 한번만 나옴)

SELECT
      menu_code
    , menu_name
    , menu_price
    , category_code
    , orderable_status
FROM
    tbl_menu
WHERE
    category_code = '10' -- 6행 조회
UNION
    SELECT
       menu_code
     , menu_name
     , menu_price
     , category_code
     , orderable_status
  FROM tbl_menu
    WHERE
        menu_price < 9000; -- 9행 조회

-- 6행 + 9행 - 5행(중복) == 10행



-- 2. UNION ALL
-- 두 집합의 결과를 포함
-- 중복도 포함

SELECT
      menu_code
    , menu_name
    , menu_price
    , category_code
    , orderable_status
FROM
    tbl_menu
WHERE
    category_code = '10' -- 6행 조회
UNION ALL
    SELECT
       menu_code
     , menu_name
     , menu_price
     , category_code
     , orderable_status
  FROM tbl_menu
    WHERE
        menu_price < 9000; -- 9행 조회

/* INTERSECT
 두 SELECT 문의 결과 중 공통되는 레코드만을 반환하는 SQL 연산자이다.
*/

-- INNER JOIN 방법
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


-- IN 연산자 이용
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

/* 4.MINUS
   - 첫 번째 SELECT 문의 결과에서
   두 번째 SELECT 문의 결과가 포함하는 레코드를 제외한 레코드를 반환하는 SQL 연산자이다.
*/

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