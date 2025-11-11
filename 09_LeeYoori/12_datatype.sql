/*
    12_datatype

    1. 명시적 형변환
    - `CAST (expression AS 데이터형식 [(길이)])`
    - `CONVERT (expression, 데이터형식 [(길이)])`
*/

    select  avg(menu_price) as '평균'
    from    tbl_menu;

-- cast()를 이용한 형변환(ANSI)
-- 실수 > 정수 변환시 반올림 자동 수행
    select cast(avg(menu_price) as signed integer) as '메뉴 평균 가격'
    from tbl_menu;


    select cast(sum(menu_price)  as char) as '가격 합계'
    from tbl_menu;

-- convert()를 이용한 형변환(mysql, mariadb)
    select convert(avg(menu_price), signed integer) as '메뉴 평균 가격'
    from tbl_menu;

-- signed integer, unsigned integer 차이
-- signed : 부호(+ -)를 포함한 범위의 integer (-21.47억 ~ +21.47억)
-- unsigned : 부호(+ -)를 포함하지 않은 범위의 integer (0 ~ 42.9억)
-- 음수(-숫자)를 unsigned로 변환 시 무조건 0이 된다.

    select cast(-123.456 as signed integer) as 'signed',
           cast(-123.456 as unsigned integer) as 'unsigned';


-- 날짜형태 문자열 형변환
-- 문자열이 어느정도 날짜 형식으로 인식이 되면 자동으로 변환 가능
    SELECT CAST('2023$5$30' AS DATE);
    SELECT CAST('2023/5/30' AS DATE);
    SELECT CAST('2023%5%30' AS DATE);
    SELECT CAST('2023@5@30' AS DATE);

    select cast('2025-11-06 10:20:40' as datetime);

    select cast('2025-11-06 10:20:40' as datetime)
                >
           cast('2025-11-05 10:20:40' as datetime); -- 1이 나오면 true 0이 나오면 false

-- 메뉴 가격 문자열로 바꿔서 조회
-- 참고/ 문자열로 변환 시 숫자의 크기가 문자열의 크기보다 크면 문자열 크기에 맞춰서 숫자가 잘림
    select cast(menu_price as char(5)) as '문자열 가격'
    From tbl_menu;

    select cast(menu_price as char(4)) as '문자열 가격'
    From tbl_menu;


/*
    묵시적 형변환(암시적 형변환)
    - 연산 수행 시 자동으로 데이터 타입을 맞춰줌
*/
    select concat(cast(tbl_menu.menu_price as char(5)), '원') from tbl_menu;

    SELECT '1' + '2';    -- 각 문자가 정수로 변환됨
    SELECT CONCAT(menu_price, '원') FROM tbl_menu;    -- menu_price가 문자로 변환됨
    SELECT 3 > 'MAY';    -- 문자는 0으로 변환된다.

    SELECT 5 > '6MAY';   -- 문자에서 첫번째로 나온 숫자는 정수로 전환된다.(may를 없애고 숫자 6만 남김)
    SELECT 5 > 'M6AY';   -- 숫자가 뒤에 나오면 문자로 인식되어 0으로 변환된다.(숫자가 뒤에나오면 문자로 인식되서 0으로 인식되어버림)
    SELECT now() > '2023-5-30' as '시간 비교';  -- 날짜형으로 바뀔 수 있는 문자는 DATE형으로 변환된다.