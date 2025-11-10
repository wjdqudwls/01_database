/* 12.DataType

   1.명시적 형변환
      - `CAST (expression AS 데이터형식 [(길이)])`
      - `CONVERT (expression, 데이터형식 [(길이)])`
*/

SELECT AVG(menu_price)
FROM tbl_menu;


    -- CAST를 이용한 형변환(ANSI 표준)
    -- (참고) 실수 -> 정수 변환시 소수점 반올림 자동 수행
SELECT CAST(AVG(menu_price)AS SIGNED INTEGER) "메뉴 평균 가격"
FROM tbl_menu;

    -- CONVERT를 이용한 형변환 (MySQL, MariaDB)
SELECT CONVERT(AVG(menu_price), SIGNED INTEGER) "메뉴 평균 가격"
FROM tbl_menu;

SELECT SUM(menu_price), CAST(SUM(menu_price) AS CHAR  ) "문자열로"
FROM tbl_menu;


-- SIGNED INTEGER, UNSIGEND INTEGER 차이
-- SIGNED : 부호(+, -)를 포함한 범위의 INTEGER (-21.47억 ~  +21.47억)
-- UNSIGEND : 부호(+, -)를 포함하지 않는 범위의 INTEGER ( 0 ~ 42.9억)
-- 음수를  UNSIGNED로 변환시 무조건 0 이 된다.

SELECT CAST(-123.456 AS SIGNED INTEGER ),
       CAST(-123.456 AS UNSIGNED INTEGER );

-- 날짜 형태 문자열 형변환
--     -> 문자열이 어느정도 날짜 형식으로 인식 되면 자동으로 변환 가능
    SELECT CAST('2023$5$30' AS DATE);
    SELECT CAST('2023/5/30' AS DATE);
    SELECT CAST('2023%5%30' AS DATE);
    SELECT CAST('2023@5@30' AS DATE);
    SELECT CAST('2025-11-06 10:20:40' AS DATETIME);

    SELECT CAST('2025-11-06 10:20:40' AS DATETIME) < CAST('2025-11-05 10:20:40' AS DATETIME);



-- 메뉴 가격 문자열로 바꿔서 조회
-- 참고] 문자열로 변환시 숫자의 크기가 문자열의 크기보다 크면 문자열 크기에 맞춰서 숫자가 잘림
SELECT CAST(menu_price AS CHAR(1)) "문자열"
FROM tbl_menu


SELECT CAST(menu_price AS CHAR(5)) FROM tbl_menu;
SELECT CONCAT(CAST(menu_price AS CHAR(5)), '원') FROM tbl_menu;


/* 2. 암시적(묵시적) 형변환
    - 연산 수행 시 자동으로 데이터 타입을 맞춰줌
 */

 SELECT '1' + '2';    -- 각 문자가 정수로 변환됨
SELECT CONCAT(menu_price, '원') FROM tbl_menu;    -- menu_price가 문자로 변환됨
SELECT 3 > 'MAY';    -- 문자는 0으로 변환된다.

SELECT 5 > '6MAY';   -- 문자에서 첫번째로 나온 숫자는 정수로 전환된다.
SELECT 5 > 'M6AY';   -- 숫자가 뒤에 나오면 문자로 인식되어 0으로 변환된다.
SELECT NOW()  > '2023-5-30';  -- 날짜형으로 바뀔 수 있는 문자는 DATE형으로 변환된다.