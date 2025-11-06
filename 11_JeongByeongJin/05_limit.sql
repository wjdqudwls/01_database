/* SELECT 해석 순서

1:   SELECT
2:   FROM
3:   WHERE
4:   GROUP BY
5:   HAVING
6:   LIMIT

*/

/* 05_LIMIT
   - SELECT 조회 결과 집합(RESULT SET)에서
     원하는 행의 갯수를 제한하여 반환
*/

SELECT
    *
FROM
    tbl_menu
ORDER BY
    menu_price;
-- 가장 저렴한 메뉴 TOP4 조회(TOP-N 분석)
SELECT
    *
FROM
    tbl_menu
ORDER BY
    menu_price
LIMIT 1, 4;
-- LIMIT [OFFSET,] ROW_COUNT;
-- OFFSET : 시작할 행의 번호
-- ROW_COUNT : 행의 개수

-- 중간에 원하는 행만 조회
SELECT
    menu_code,
    menu_name,
    menu_price
FROM
    tbl_menu
ORDER BY
    menu_price DESC, menu_name ASC
LIMIT 5, 8;