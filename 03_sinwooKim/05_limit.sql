/*
SQL 해석 순서
5: SELECT
1: FROM
2: WHERE
3: GROUP BY
4: HAVING
6: ORDER BY
7: LIMIT
 */

 /*
 LIMIT
    - SELECT 조회 결과 집합(RESULT SET)에서 원하는 행의 개수를 제한하여 반환
 */

SELECT *
FROM tbl_menu
ORDER BY menu_price;

-- 가장 저렴한 메뉴 4개 조회
SELECT *
FROM tbl_menu
ORDER BY menu_price
LIMIT 1,4;
-- LIMIT [OFFSET], ROWCOUNT;
-- OFFSET : 시작할 행의 번호(INDEX)
-- ROW COUNT : 행의 개수

-- 가장 비싼 메뉴 5개 조회
SELECT *
FROM tbl_menu
ORDER BY menu_price DESC
LIMIT 5; -- LIMIT 0,5 (0은 생략가능)

-- 중간에 원하는 행만 조회
SELECT *
FROM tbl_menu
ORDER BY menu_price DESC, menu_name ASC
LIMIT 5,8;