/*
    08_SUBQUERY
    - 메인 쿼리(SQL) 내에서 실행 되는 보조 쿼리(SELECT)
    - 종류 : 단일행, 다중행, 다중열, 다중행 다중열, 스칼라, 상관, 인라인뷰
    - SUBQUERY를 위한 연산자 : EXISTS
*/

-- SUBQUERY 예시

-- 민트미역국과 같은 카테고리의 메뉴를 모두 조회 하시오
-- 1) '민트미역국'의 카테고리 코드 찾기
SELECT
    category_code
FROM tbl_menu
WHERE menu_name = '민트미역국'; -- 4

-- 2) 카테고리 코드가 4인 모든 메뉴 조회
SELECT
    menu_name,
    category_code
FROM tbl_menu
WHERE
    category_code = 4;

-- 3) SUBQUERY를 이용해서 한 번의 SQL 실행으로 결과 찾기
SELECT
    menu_name,
    category_code
FROM tbl_menu
WHERE
    category_code = (
                    SELECT category_code
                    FROM tbl_menu
                    WHERE menu_name = '민트미역국'
                    );

-- 1) 단일행 서브쿼리
-- 서브쿼리가 1개의 행, 1개의 컬럼만 반환
-- 비교 연산자 사용 가능: =, >, <, >=, <=, !=

-- 전체 메뉴의 평균 가격보다 비싼 메뉴 찾기
SELECT menu_name
     , menu_price
FROM tbl_menu
WHERE menu_price > (SELECT AVG(menu_price) FROM tbl_menu);

-- 가장 비싼 메뉴가 속한 카테고리의 모든 메뉴 조회
SELECT menu_name
     , menu_price
     , category_code
FROM tbl_menu
WHERE category_code = (SELECT category_code
                       FROM tbl_menu
                       ORDER BY menu_price DESC
                       LIMIT 1);

-- 2) 다중행 서브쿼리
-- 서브쿼리가 여러 행, 1개의 컬럼 반환
-- 사용 연산자: IN, NOT IN, ANY, ALL, EXISTS

-- '식사' 카테고리의 하위 카테고리에 속하는 모든 메뉴 조회
SELECT menu_name
     , menu_price
     , category_code
FROM tbl_menu
WHERE category_code IN (SELECT category_code
                        FROM tbl_category
                        WHERE ref_category_code = 1);
-- '식사'의 하위 카테고리

-- 3) 다중열 서브쿼리
-- 서브쿼리가 1개의 행, 여러 컬럼 반환
-- 여러 컬럼을 한 번에 비교

-- 10번째로 비싼 메뉴와 동일한 카테고리 + 가격을 가진 메뉴


SELECT
    category_code,
    menu_price
FROM tbl_menu
ORDER BY
    menu_price DESC
LIMIT 9,1;
-- 10번째로 비싼 메뉴의 카테고리, 가격

SELECT
    category_code,
    menu_price,
    menu_name
FROM tbl_menu
WHERE (category_code, menu_price)
          = (SELECT
                category_code,
                menu_price
            FROM tbl_menu
            ORDER BY menu_price DESC
            LIMIT 9,1
                   );
-- 반환되는 열이 2개라 WHERE에도 2개를 주어야 함

-- 4) 다중행 다중열 서브쿼리
-- 서브쿼리가 여러 행, 여러 컬럼 반환
-- IN 연산자와 함께 사용

-- 각 카테고리별로 가장 저렴한 메뉴들만 조회
SELECT menu_name
     , category_code
     , menu_price
FROM tbl_menu
WHERE (category_code, menu_price) IN (SELECT category_code, MIN(menu_price)
                                      FROM tbl_menu
                                      GROUP BY category_code)
ORDER BY category_code;

-- 5) 스칼라 서브쿼리 (Scalar Subquery)
-- SELECT 절에서 사용되는 단일행 서브쿼리 (1행 1열만 반환)

-- 메뉴 정보와 함께 카테고리명도 조회 (JOIN 대신 서브쿼리 사용)
SELECT menu_code
     , menu_name
     , menu_price
     , (SELECT category_name
        FROM tbl_category
        WHERE category_code = m.category_code) AS category_name
#             /*
#             tlb_cateogory 테이블에서 category_code와
#             tbl_menu의 카테고리 코드가 같은것의 카테고리 이름을 출력
               --
#             */
FROM tbl_menu m
ORDER BY menu_code
LIMIT 5;

-- 분석 용 스칼라 쿼리가 없을때 출력 셋
/*  menu_code   menu_name     menu_price   (category code가 출력안되고 내부적으로 있음)
    1           열무          4500            8
    2           우럭          5000            10
    3           생갈치         6000            10
    4           갈릭          7000            10
    5           앙버터         13000           4
*/

/*
스칼라셋 내부에서 위 tbl_menu 한줄마다 비교하여 실행 됨
tbl_category
category_code   category_name
1,식사
2,음료
3,디저트
4,한식
5,중식
6,일식
7,퓨전
8,커피
9,쥬스
10,기타
11,동양
12,서양

*/

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

-- 서브쿼리 안쓰고 한 데이터랑 비교 -- Mariadb에는 가능한 ORACLE에선 안됨
SELECT menu_name
     , menu_price
     , MIN(menu_price) AS min_price
     , MAX(menu_price)  AS max_price
     , AVG(menu_price) AS avg_price
     , COUNT(*)      AS total_menu_count
FROM tbl_menu
WHERE menu_code = 1;

/*
 상관 서브 쿼리
  -- 메인 쿼리가 서브쿼리의 결과에 영향을 주는 경우
  -- 서브쿼리를 활용해 카테고리 별 평균 가격의 메뉴 조회
*/

-- 카테고리 4번의 평균
SELECT
   AVG(menu_price)
FROM tbl_menu
WHERE category_code = 4;

SELECT
   menu_code
 , menu_name
 , menu_price
 , category_code
 , orderable_status
FROM tbl_menu a

WHERE menu_price > (SELECT AVG(menu_price)
                    FROM tbl_menu
                    WHERE category_code = 4);
-- category 4번인 행의 평균 가격보다 큰 가격의 메뉴 조회

-- category 별로 조회하고 싶음
/*  1. 메인쿼리 1행씩 접근(Curser :커서)
    2. 서브 쿼리에 사용할 메인쿼리 값을 전달 (메인 쿼리 -> 서브 쿼리)
    3. 서브 쿼리가 전달 값을 이용해서 SELECT 수행
    4. 서브 쿼리 수행 결과를 메인 쿼리에 전달 (서브 쿼리 -> 메인 쿼리)
    5. 메인 쿼리가 전달 받은 값을 이용해 연산 수행
     - WHERE절 : 연산 수행 결과에 따라 메인 쿼리 1행을 RESULT SET 포함 할지 말지 결정
     - SELECT절 : 단순 출력 or 추가 연산
 */

SELECT
   menu_code
 , menu_name
 , menu_price
 , category_code
 , orderable_status
FROM tbl_menu MAIN

WHERE menu_price > (SELECT AVG(SUB.menu_price)
                    FROM tbl_menu SUB
                    WHERE SUB.category_code = MAIN.category_code);

/*
    EXISTS
    - 상관 서브쿼리임
    - 서브 쿼리의 조회 결과가 있을 경우에만
      해당 메인 쿼리 1행을 RESULT SET 에 포함 시키는 연산자
*/

SELECT
   category_name
FROM tbl_category a
WHERE EXISTS(SELECT 1
                FROM tbl_menu b
                WHERE b.category_code = a.category_code)
-- 실제로 매뉴 테이블에 사용된 카테고리들만 보겠다.
ORDER BY 1; -- SELECT 컬럼 순서 1번 category_name 대신에 쓴거


/*
    CTE(Common Table Expression)
    - 인라인뷰로 사용되는 서브쿼리를 미리 정의해서 사용하는 방법
    - 인라인뷰
      : FROM절에 사용되는 서브쿼리
        서브 쿼리의 결과를 테이블 처럼 사용
    - 서브쿼리가 복합해지는 경우, 메인쿼리를 침범하지 않도록 하는 문법
*/

-- 인라인 뷰 사용
SELECT
    메뉴명,
    카테고리명
FROM
(
    SELECT
    menu_name AS 메뉴명,
    category_name AS 카테고리명
    FROM tbl_menu a
    JOIN tbl_category b
    ON a.category_code = b.category_code
) AS MENU_CATEGORY
WHERE 메뉴명 LIKE '%마늘%';

-- > CTE 적용
 -- 서브 쿼리랑 메인 쿼리랑 분리
 -- 장점 : 보기 편함, 속도가 빠름(약 5%)

WITH MENU_CATEGORY AS
    (
    SELECT
    menu_name AS 메뉴명,
    category_name AS 카테고리명
    FROM tbl_menu a
    JOIN tbl_category b
    ON a.category_code = b.category_code
    )

SELECT
    메뉴명,
    카테고리명
FROM
    MENU_CATEGORY
WHERE 메뉴명 LIKE '%마늘%';