/* 09_SET OPERATORS
    - 두 개 이상의 SELECT 결과(RESULT SET)를 결합
    - UNION(합집합)
    - UNION ALL = UNION + INTERSECT
    - INTERSECT (교집합)
    - MINUS (차집합)

    (🔆중요) 집합 연산의 대상이 되는 두 RESULT SET은
    - 컬럼 개수가 동일해야한다
    - 컬럼 자료형이  동일해야한다
*/



#  1. UNION (합집합)
#  두 집합의 결과를 결합
#  단 중복 제거

 # 9행
SELECT
       menu_code
     , menu_name
     , menu_price
     , category_code
     , orderable_status
FROM
    tbl_menu
WHERE
    category_code = 10 # 6행

UNION

SELECT
       menu_code
     , menu_name
     , menu_price
     , category_code
     , orderable_status
FROM
    tbl_menu
WHERE
    menu_price < 9000;

# 6행 + 9행 - 5행(중복)



# 2. UNION ALL
# 두 집합의 결과를 결합
# 중복도 포함
SELECT
       menu_code
     , menu_name
     , menu_price
     , category_code
     , orderable_status
FROM
    tbl_menu
WHERE
    category_code = 10 # 6행

UNION ALL

SELECT
       menu_code
     , menu_name
     , menu_price
     , category_code
     , orderable_status
FROM
    tbl_menu
WHERE
    menu_price < 9000;


# 3. INTERSECT
# - 두 SELECT 문의 결과 중 공통되는 레코드만을 반환하는 SQL 연산자이다.
# - MySQL은 본래 기본적으로 INTERSECT를 제공하지 않는다.
# 하지만 INNER JOIN 또는 IN 연산자 활용해서 구현하는 것은 가능하다.

# INNER JOIN 방법
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


# IN 연산자 이용
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


# 4. minus
# - 첫 번째 SELECT 문의 결과에서
#   두 번째 SELECT 문의 결과가 포함하는 레코드를 제외한 레코드를 반환하는 SQL 연산자이다.
#   (첫 번째 RESULT SET에서 교집합 부분 제외)
# - MySQL은 MINUS를 제공하지 않는다. 하지만 LEFT JOIN을 활용해서 구현하는 것은 가능하다.

SELECT
       a.menu_code, b.menu_code
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
 WHERE b.menu_code IS NULL;