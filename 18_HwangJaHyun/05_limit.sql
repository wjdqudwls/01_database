/*
    <SELECT 해석 순서>
        SELECT(5)
        FROM(1)
        WHERE(2)
        GROUP BY(3)
        HAVING(4)
        ORDER BY(6)
        LIMIT(7)
*/

/*
    05_LIMIT
    (oracle엔 존재하지 않음)
    select문의 조회 결과 집합(RESULT SET)에서
    반환할 행의 수를 제한하는데 사용

    LIMIT [OFFSET, ] RAW_COUNT;
    [] 생략가능
    OFFSET: 시작할 행의 index번호, 생략시 0
    RAW_COUNT: 행의 개수
*/

SELECT
    *
FROM
    tbl_menu
ORDER BY
    menu_price;

-- 가장 저렴한 메뉴 top4 조회 (TOP-N 분석)
SELECT
    *
FROM
    tbl_menu
ORDER BY
    menu_price
LIMIT 0,4;

-- 가장 비싼 메뉴 TOP5 조회 (TOP-N 분석)
SELECT
    *
FROM
    tbl_menu
ORDER BY
    menu_price DESC
LIMIT 5;


SELECT
    menu_code,
    menu_name,
    menu_price
FROM
    tbl_menu
ORDER BY
    menu_price DESC, menu_name ASC
LIMIT 5, 8;
