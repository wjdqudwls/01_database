/*SELECT 해석 순서
  5:SELECT
  1:FROM
  2:WHERE
  3:GRPOUBY
  4:HAVING
  6:ORDERBY
  7:LIMIT
 */

 /* 05_LIMIT
    -SELECT 조회 결과 집합(RESULT SET)에서
    원하는 행의 개수를 제한하여 반환

  */
SELECT *
FROM tbl_menu
ORDER BY  menu_price  ;

-- 가장 저렴한 메뉴 TOP 4
SELECT *
FROM tbl_menu
ORDER BY  menu_price
LIMIT 1, 4;

-- LIMIT [OFFSET], ROWCOUNT;
-- OFFSET: 시작할 행의 번호
-- ROW_COUNT : 행의 개수


-- 가장 저렴한 메뉴 TOP 4
SELECT menu_code, menu_name, menu_price
FROM tbl_menu
ORDER BY menu_price desc
LIMIT 0, 5;

SELECT menu_code, menu_name, menu_price
FROM tbl_menu
ORDER BY menu_price DESC ,menu_name ASC
LIMIT 5, 13;







