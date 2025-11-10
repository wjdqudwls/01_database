/* DATA_TYPES

   1. 명시적 형변환
   - `CAST (expression AS 데이터형식 [(길이)])`
   - `CONVERT (expression, 데이터형식 [(길이)])`
*/

SELECT AVG(menu_price) FROM tbl_menu;

-- CAST()를 이용한 형변환

SELECT CAST(AVG(menu_price) AS SIGNED INTEGER) AS '평균 메뉴 가격' FROM tbl_menu;

-- CONVERT()를 이용한 형변환
SELECT CONVERT(AVG(menu_price), SIGNED INTEGER) AS '평균 메뉴 가격' FROM tbl_menu;

SELECT CAST(SUM(menu_price) AS CHAR ) FROM tbl_menu;

-- SIGNED INTEGER, UNSIGNED INTEGER 차이
-- SIGNED : 부호(+-)를 포함한 범위의 INTEGER (-21.47억 ~ 21.47억)
-- UNSIGNED : 부호(+-)를 포함하지 않은 범위의 INTEGER (0 ~ 42.9억)
-- -> 음수를 UNSIGNED로 변환 시 무조건 0이 된다.
SELECT CAST(-123.456 AS SIGNED INTEGER ), CAST(-123.456 AS UNSIGNED INTEGER )

-- 날짜 형태 문자열 형변환
-- 문자열이 대략 날짜 형식으로 인식이 되면 자동으로 형변환 가능
SELECT CAST('2023$5$30' AS DATE);
SELECT CAST('2023/5/30' AS DATE);
SELECT CAST('2023%5%30' AS DATE);
SELECT CAST('2023@5@30' AS DATE);

SELECT CAST('2025-11-06 10:20:40' AS DATETIME ) < CAST('2025-11-05 10:20:40' AS DATETIME );

-- 메뉴 가격 문자열로 바꿔서 조회
-- 문자열로 변환 시 숫자의 크기가 문자열의 크기보다 크면 문자열의 크기에 맞춰서 숫자가 잘림
SELECT CAST(menu_price AS CHAR(5)) `문자열 가격` FROM tbl_menu;

SELECT CONCAT(CAST(menu_price AS CHAR(5)), '원') FROM tbl_menu;
SELECT CONCAT(CAST(menu_price AS CHAR(4)), '원') FROM tbl_menu;
SELECT CONCAT(CAST(menu_price AS CHAR(1)), '원') FROM tbl_menu;

/* 암시적 형변환
   - 연산 수행 시 자동으로 데이터타입을 맞춰줌
*/
SELECT '1' + '2';    -- 각 문자가 정수로 변환됨
SELECT CONCAT(menu_price, '원') FROM tbl_menu;    -- menu_price가 문자로 변환됨
SELECT 3 > 'MAY';    -- 문자는 0으로 변환된다.

SELECT 5 > '6MAY';   -- 문자에서 첫번째로 나온 숫자는 정수로 전환된다.
SELECT 5 > 'M6AY';   -- 숫자가 뒤에 나오면 문자로 인식되어 0으로 변환된다.
SELECT now() > '2023-5-30';  -- 날짜형으로 바뀔 수 있는 문자는 DATE형으로 변환된다.
select 'j6' > 'g5'