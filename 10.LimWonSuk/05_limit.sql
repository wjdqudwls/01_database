/* SELECT 해석 순서

 5: SELECT
 1: FROM
 2: WHERE
 3: GROUP BY
 4: HAVING
 6: ORDER BY
 7:  LIMIT

 */

 /* 05_LIMIT
    - SELECT 조회 결과 집합(RESULT SET)에서
    원하는 행ㅇ의 갯수를 제한하여 반환
  */
SELECT
    *
FROM
    tbl_menu
ORDER BY
   menu_price;

-- 가장 저렴한 메뉴 TOP4 조회 (TOP-N 분석)
SELECT
    *
FROM
    tbl_menu
ORDER BY
   menu_price
LIMIT 0, 4; -- 0개 건너뛰고 4개

-- LIMIT [OFFSET,] ROWCOUNT;
-- OFFSET : 시작할 행의 번호
-- ROWCOUNT :  행의 개수

-- 가장 비싼 메뉴 TOP4 조회 (TOP-N 분석)
SELECT
    *
FROM
    tbl_menu
ORDER BY
   menu_price DESC
LIMIT 0, 5; -- 0개 건너뛰고 5개
-- OFFSET 생략 : 1행

SELECT
    menu_code,
    menu_name,
    menu_price
FROM
    tbl_menu
ORDER BY
   menu_price DESC , menu_name ASC
LIMIT 5, 8; -- 5개 건너뛰고 8개