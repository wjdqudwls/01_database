/*---------------------------------------------------------------------*/
/* SELECT 해석 순서

   1. SELECT
   2. FROM
   3. WHERE
   4. GROUP BY
   5. HAVING
   6. ORDER BY
   7. LIMIT

 */

/* 05_LIMIT
   - SELECT 조회
 */

-- 기존 테이블
SELECT menu_code, menu_name, menu_price
FROM tbl_menu
ORDER BY menu_price DESC;

-- 2번 행부터 5번 행까지 조회
SELECT menu_code, menu_name, menu_price
FROM tbl_menu
ORDER BY menu_price DESC
LIMIT 1, 4;

-- 상위 5줄의 행만 조회 (TOP-N 분석)
SELECT menu_code, menu_name, menu_price
FROM tbl_menu
ORDER BY menu_price DESC
LIMIT 5;

-- 상위 5줄의 행만 조회
SELECT menu_code, menu_name, menu_price
FROM tbl_menu
ORDER BY menu_price DESC
LIMIT 0,5;

-- 상위 5줄의 행만 조회 (TOP-N 분석)
SELECT menu_code, menu_name, menu_price
FROM tbl_menu
ORDER BY menu_price DESC, menu_name ASC;

-- 중간 원하는 행만 조회
SELECT menu_code, menu_name, menu_price
FROM tbl_menu
ORDER BY menu_price DESC, menu_name ASC
LIMIT 5, 8;