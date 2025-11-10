/* 15 build in function (내장 함수)
 */

 /* 문자열 함수
    - ASCII('문자') : 문자의 아스키 코드 반환
    - CHAR(ASCII) : 입력한 아스키 코드에 맞는 값 반환*/
select bit_length('pie'), char_length('[pie'), length('pie');

SELECT BIT_LENGTH('pie'), CHAR_LENGTH('pie'), LENGTH('pie');
SELECT menu_name, BIT_LENGTH(menu_name), CHAR_LENGTH(menu_name), LENGTH(menu_name) from tbl_menu;

SELECT LPAD('왼쪽', 6, '@'), RPAD('오른쪽', 6 ,'@');

SELECT LTRIM('    왼쪽'), RTRIM('오른쪽    ');

SELECT TRIM('    MySQL    '), TRIM(BOTH '@' FROM '@@@@MySQL@@@@');

SELECT CONCAT(REPEAT('멋있어', 2),' 이찬오빠 멋있어') 'ㅎㅎ';

SELECT REPLACE('마이SQL', '마이', 'My');

SELECT REVERSE('stressed');

SELECT SUBSTRING('안녕하세요 반갑습니다.', 7, 2), SUBSTRING('안녕하세요 반갑습니다.', 7);

SELECT SUBSTRING_INDEX('hong.test@gmail.com', '.', 2), SUBSTRING_INDEX('hong.test@gmail.com', '.', -2);

SELECT ABS(-123);

SELECT CEILING(1234.56), FLOOR(1234.56), ROUND(1234.56);

SELECT FLOOR(-123.4), ROUND(-123.445,2);

SELECT RAND(), FLOOR(RAND() * (11 - 1) + 1);

SELECT SIGN(10.1), SIGN(0), SIGN(-10.1);

SELECT TRUNCATE(12345.12345, 2), TRUNCATE(12345.12345, -2);

-- (3) 날짜/시간 관련 함수

-- adddate, subdate
SELECT
       ADDDATE('2023-05-31', INTERVAL 30 DAY)
     , ADDDATE('2023-05-31', INTERVAL 6 MONTH)
     , ADDDATE('2023-05-31', INTERVAL 1 YEAR)
     , SUBDATE('2023-05-31', INTERVAL 30 DAY)
     , SUBDATE('2023-05-31', INTERVAL 6 MONTH)
     , SUBDATE('2023-05-31', INTERVAL 1 YEAR);

-- addtime, subtime
SELECT
       ADDTIME('2023-05-31 09:00:00', '1:0:1')
     , SUBTIME('2023-05-31 09:00:00', '1:0:1');

-- 현재 시스템 날짜/시간 반환
SELECT CURDATE(), CURRENT_DATE(), CURRENT_DATE;
SELECT CURTIME(), CURRENT_TIME(), CURRENT_TIME;
SELECT NOW(), LOCALTIME, LOCALTIME(), LOCALTIMESTAMP, LOCALTIMESTAMP();

-- year, month, dayofmonth
SELECT YEAR(CURDATE()), MONTH(CURDATE()), DAYOFMONTH(CURDATE());
-- hour, minute, second, microsecond
SELECT HOUR(CURTIME()), MINUTE(CURTIME()), SECOND(CURTIME()),
MICROSECOND(CURTIME(6));
-- date, time
SELECT DATE(NOW()), TIME(NOW());

-- datediff, timediff
SELECT DATEDIFF('2023-05-31', '2023-02-27')
     , TIMEDIFF('17:07:11', '13:06:10');

-- dayofweek, monthname, dayofyear
SELECT DAYOFWEEK(CURDATE()), MONTHNAME(CURDATE()), DAYOFYEAR(CURDATE());

-- last_day
SELECT LAST_DAY('2023-02-01');

-- makedate, maketime
SELECT MAKEDATE(2023, 32), MAKETIME(17, 03, 02);

-- quarter
SELECT QUARTER('2023-05-01');

-- time_to_sec
SELECT TIME_TO_SEC('1:1:1');
