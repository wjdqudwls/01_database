-- 서브쿼리 예시

-- '민트미역국'과 같은 카테고리의 메뉴를 모두 조회하시오

-- 1) '민트미역국'의 카테고리 코드 찾기
SELECT
    category_code
FROM
    tbl_menu
WHERE
    menu_name = '민트미역국'; -- 4


-- 2) 카테고리가 코드가 4인 메뉴 모두 조회
SELECT
    menu_name,
    category_code
FROM
    tbl_menu
WHERE
    category_code = 4;


-- 3) 서브쿼리를 이용해서 한 번의 SQL 실행으로 결과 찾기
SELECT
    menu_name,
    category_code
FROM
    tbl_menu
WHERE
    category_code = (
        SELECT
            category_code
        FROM
            tbl_menu
        WHERE
            menu_name = '민트미역국'
    );


/*
    08_SUBQUERY
    - 메인 쿼리(SQL) 내에서 실행되는 보조 쿼리(SELECT)
    - 종류 : 단일행, 다중행, 다중열, 다중행 다중열, 스칼라, 상관, 인라인뷰
    - 서브쿼리를 위한 연산자 : EXISTS
*/

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
-- 사용 연산자: IN, ANY, ALL, EXISTS

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

-- 가장 비싼 메뉴와 동일한 카테고리 + 가격을 가진 메뉴

SELECT
    *
FROM
    tbl_menu
WHERE
    (category_code, menu_price) = (
    SELECT
        category_code, menu_price
    FROM
        tbl_menu
    ORDER BY
        menu_price DESC
    LIMIT 9,1);

SELECT
    category_code, menu_price
FROM
    tbl_menu
ORDER BY
    menu_price DESC
LIMIT 9,1;


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
-- SELECT 절에서 사용되는 서브쿼리 (1행 1열만 반환)

-- 메뉴 정보와 함께 카테고리명도 조회 (JOIN 대신 서브쿼리 사용)
SELECT menu_code
     , menu_name
     , menu_price
     , (SELECT category_name
        FROM tbl_category
        WHERE category_code = m.category_code) AS category_name
FROM tbl_menu m
ORDER BY menu_code
LIMIT 5;


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



/* 상관(상호연관 서브쿼리)
-- 메인 쿼리가 서브쿼리의 결과에 영향을 주는 경우

   1) 메인 쿼리 1행씩 접근(커서)
   2) 서브쿼리에서 사용할 메인쿼리의 컬럼값을 전달 (메인쿼리 -> 서브쿼리)
   3) 서브쿼리가 전달 받은 값을 이용해서 SELECT 수행
   4) 서브쿼리 수행 결과를 다시 메인쿼리에 전달(서브쿼리 -> 메인쿼리)
   5) 메인쿼리가 전달 받은 값을 이용해 연산 수행
    - WHERE 절 : 연산 수행 결과에 따라 메인쿼리 1행을 RESULT SET에 포함 할지 말지 결정
    - SELECT 절 : 단순 출력 OR 추가 연산
*/

SELECT AVG(menu_price)
FROM tbl_menu
WHERE category_code = 4;


-- 카테고리별 평균 가격보다 높은 가격의 메뉴 조회
SELECT
       menu_code
     , menu_name
     , menu_price
     , category_code
     , orderable_status
FROM tbl_menu MAIN
WHERE
    menu_price > (
            SELECT AVG(SUB.menu_price)
            FROM tbl_menu SUB
            WHERE SUB.category_code = MAIN.category_code
        );


/* EXISTS
   - 서브쿼리의 조회 결과가 있을 경우에만
     해당 메인쿼리 1행을 RESULT SET에 포함 시키는 연산자
*/

-- 실제로 메뉴 테이블에 사용된(등록된) 카테고리만 조회
SELECT
       category_name
FROM tbl_category a
WHERE EXISTS(SELECT 1
             FROM tbl_menu b
             WHERE b.category_code = a.category_code)
ORDER BY 1;


/* CTE(Common Table Expression)
-- 인라인뷰로 사용되는 서브쿼리를 미리 정의해서 사용하는 방법

-- 인라인뷰 : FROM절에 사용되는 서브쿼리
            서브쿼리의 결과를 테이블 처럼 사용
*/
SELECT
    `메뉴명`, `카테고리명`
FROM (
    SELECT
        menu_name AS '메뉴명',
        category_name AS '카테고리명'
    FROM tbl_menu a
    JOIN tbl_category b
        ON a.category_code = b.category_code
) AS menu_category
WHERE `메뉴명` LIKE '%마늘%';


-- CTE 적용
WITH menu_category AS (
    SELECT
        menu_name AS '메뉴명',
        category_name AS '카테고리명'
    FROM tbl_menu a
    JOIN tbl_category b
        ON a.category_code = b.category_code
)

SELECT
    `메뉴명`, `카테고리명`
FROM menu_category
WHERE `메뉴명` LIKE '%마늘%';




