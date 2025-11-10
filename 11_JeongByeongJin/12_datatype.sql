/* 12_DATA TYPE

   1. 명시적 형변환

   - CAST(expression AS 데이터형식)
   = CONVERT()

*/
-- 메뉴 평균금액 확인
SELECT AVG(menu_price)
FROM tbl_menu;

-- CAST()를 이용한 형변환 (ANSI 표준)
-- (참고) 실수 -> 정수로 변환시 소수점 반올림 자동 수행
 -- 소수점 없애기위해 데이터 형식을
SELECT CAST(AVG(menu_price)AS SIGNED INTEGER)
       AS '메뉴 평균 가격'
FROM tbl_menu;

-- CONVERT()를 이용한 형변환 ( MySQL, MriaDB )
-- CONVERT()의 괄호 사이에 AS 대신 ,(콤마)로 변경
SELECT CONVERT(AVG(menu_price), SIGNED INTEGER)
           AS '메뉴 평균 가격'
FROM tbl_menu;

SELECT
    SUM(menu_price),                -- 숫자형식은 오른쪽 정렬
    CAST(sum(menu_price) AS CHAR)   -- CAST 형식은 왼쪽 정렬
FROM tbl_menu;

-- SIGNED INTEGER, UNSIGNED INTEGER 차이
-- SIGNED : 부호(+-)를 포함한 범위의 INTEGER (-21.47억 ~ 21.47억)
-- UNSIGNED : 부호(+-)를 포함하지 범위의 INTEGER (0 ~ 42.9억)
-- -> 음수(-숫자)를 UNSIGNED로 변환시 무조건 0이 된다.

SELECT CAST(-123.456 AS SIGNED INTEGER),
       CAST(-123.456 AS UNSIGNED INTEGER);

-- 날짜 형태 문자열 형변환
-- -> 문자열이 (어느정도) 날짜 형식으로 인식이 되면 자동으로 변환 가능
SELECT CAST('2023$5$30' AS DATE);
SELECT CAST('2023/5/30' AS DATE);
SELECT CAST('2023%5%30' AS DATE);
SELECT CAST('2023@5@30' AS DATE);
-- 현재시간 실습
SELECT CAST('2025-11-06 10:20:40' AS DATE);

--
SELECT CAST('2025-11-05 10:20:40' AS DATETIME)
            >
       CAST('2025-11-06 10:20:40' AS DATETIME);

-- 메뉴 가겨 문자열로 바꿔서 조회
-- (참고) 문자열로 변환 시 지정된 숫자의 크기가 문자열의 크기보다 크면
--       문자열 크기에 맞춰서 숫자가 잘림
SELECT
    CONCAT (menu_price, '원'),
    CONCAT (CAST(menu_price AS CHAR(5)), '원')
    AS '문자열 가격'
FROM tbl_menu;

/* 2. 암시적(묵시적) 형변환
    - 연산 수행 시 자동으로 데이터 타입을 맞춰줌
*/

SELECT '1' + '2';    -- 각 문자가 정수로 변환됨
SELECT CONCAT(menu_price, '원') FROM tbl_menu;    -- menu_price가 문자로 변환됨
SELECT 3 > 'MAY';    -- 문자는 0으로 변환된다.

SELECT 5 > '6MAY';   -- 문자에서 첫번째로 나온 숫자는 정수로 전환된다.
SELECT 5 > 'M6AY';   -- 숫자가 뒤에 나오면 문자로 인식되어 0으로 변환된다.
SELECT NOW() > '2023-5-30';  -- 날짜형으로 바뀔 수 있는 문자는 DATE형으로 변환된다.


