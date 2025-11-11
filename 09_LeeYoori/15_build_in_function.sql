/*
    15_build in function : 내장함수
*/

/* 1. 문자열 함수 */
-- ascii('문자') : 문자의 아스키 코드 번호 반환
-- char(아스키코드) : 입력한 아스키코드의 맞는 문자를 반환
select ascii('A'), char(65);

/* 2. bit_length, byte_length, char_length */
SELECT BIT_LENGTH('pie'), CHAR_LENGTH('pie'), LENGTH('pie');
SELECT menu_name, BIT_LENGTH(menu_name), CHAR_LENGTH(menu_name), LENGTH(menu_name) from tbl_menu
where char_length(menu_name) <= 6;

/* 3. concat, concat_ws */
select concat('호랑이', '토끼', '기린');
select concat_ws(',','호랑이', '토끼', '기린');
select concat_ws('-','호랑이', '토끼', '기린');


/* 4. ELT, FILED, FIND_IN_SET, INSTR, LOCATE */
SELECT
    ELT(2, '사과', '딸기', '바나나')
     , FIELD('딸기', '사과', '딸기', '바나나')
     , FIND_IN_SET('바나나', '사과,딸기,바나나')
     , INSTR('사과딸기바나나', '딸기')
     , LOCATE('딸기', '사과딸기바나나');

/* format */
SELECT FORMAT(123142512521.5635326, 3); -- 1000단위마다 콤마로 끊어주고 소수점 3자리까지 끊기

/* bin, oct, hex */
SELECT BIN(65), OCT(65), HEX(65);

/* insert */
-- 기존의 문자열의 위치부터 길이만큼을 지우고 삽입할 문자열을 끼워놓는다
SELECT INSERT('내 이름은 아무개입니다.', 7, 3, '홍길동');    -- 아무개를 홍길동으로 변경

/* left, right */
SELECT LEFT('Hello World!', 3), RIGHT('Hello World!', 3);

/* upper, lower */
SELECT LOWER('Hello World!'), UPPER('Hello World!');

/* lpad, rpad */
SELECT LPAD('왼쪽', 6, '@'), RPAD('오른쪽', 6 ,'@');

/* ltrim, rtrim */
SELECT LTRIM('    왼쪽'), RTRIM('오른쪽    ');

/* trim */
SELECT TRIM('    MySQL    '), TRIM(BOTH '@' FROM '@@@@MySQL@@@@');

/* repeat */
SELECT REPEAT('재밌어', 3);

/* replace */
SELECT REPLACE('마이SQL', '마이', 'My');

/* reverse */
SELECT REVERSE('stressed');

/* space */
SELECT CONCAT('제 이름은', SPACE(5), '이고 나이는', SPACE(3), '세입니다.');

/* substring */
SELECT SUBSTRING('안녕하세요 반갑습니다.', 7, 2), SUBSTRING('안녕하세요 반갑습니다.', 7);

/* substring_index */
-- 밑에 예시에서는 두번째 점을 찾아서 그 뒤에를 버림, 음수일 경우 뒤에서부터 세서 앞을 버림
SELECT SUBSTRING_INDEX('hong.test@gmail.com', '.', 2), SUBSTRING_INDEX('hong.test@gmail.com', '.', -2);

/* abs */
SELECT ABS(-123);

/* ceiling, floor, round */
SELECT CEILING(1234.56), FLOOR(1234.56), ROUND(1234.56);
SELECT FLOOR(-123.4), ROUND(-123.4);


/* conv(convert) */
SELECT CONV('A', 16, 10), CONV('A', 16, 2), CONV(1010, 2, 8);

/* mod */
SELECT MOD(75, 10), 75 % 10, 75 MOD 10;

/* pow, sqrt */
SELECT POW(2, 4), SQRT(16);

/* rand */
SELECT RAND(), FLOOR(RAND() * (11 - 1) + 1);

/* sign */
SELECT SIGN(10.1), SIGN(0), SIGN(-10.1);

/* truncate */
SELECT TRUNCATE(12345.12345, 2), TRUNCATE(12345.12345, -2);

/* adddate, subdate */
SELECT ADDDATE('2023-05-31', INTERVAL 30 DAY), ADDDATE('2023-05-31', INTERVAL 6 MONTH);
SELECT SUBDATE('2023-05-31', INTERVAL 30 DAY), SUBDATE('2023-05-31', INTERVAL 6 MONTH);

/* addtime, subtime */
SELECT ADDTIME('2023-05-31 09:00:00', '1:0:1'), SUBTIME('2023-05-31 09:00:00', '1:0:1');

/* curdate(), curtime(), now(), sysdate() */
SELECT CURDATE(), CURTIME(), NOW(), SYSDATE();
-- CURDATE(), CURRENT_DATE(), CURRENT_DATE는 동일
SELECT CURDATE(), CURRENT_DATE(), CURRENT_DATE;
-- CURTIME(), CURRENT_TIME(), CURRENT_TIME은 동일
SELECT CURTIME(), CURRENT_TIME(), CURRENT_TIME;
-- NOW(), LOCALTIME, LOCALTIME(), LOCALTIMESTAMP, LOCALTIMESTAMP()는 동일
SELECT NOW(), LOCALTIME, LOCALTIME(), LOCALTIMESTAMP, LOCALTIMESTAMP();

/* year, month, dayofmonth */
SELECT YEAR(CURDATE()), MONTH(CURDATE()), DAYOFMONTH(CURDATE());
SELECT HOUR(CURTIME()), MINUTE(CURTIME()), SECOND(CURRENT_TIME), MICROSECOND(CURRENT_TIME);

/* date, time */
SELECT DATE(NOW()), TIME(NOW());

/* datediff, timediff */
SELECT DATEDIFF('2023-05-31', '2023-02-27'), TIMEDIFF('17:07:11', '13:06:10');

/* dayofweek, monthname, dayofyear */
SELECT DAYOFWEEK(CURDATE()), MONTHNAME(CURDATE()), DAYOFYEAR(CURDATE());

/* last_day */
SELECT LAST_DAY('20230201');

/* makedate */
SELECT MAKEDATE(2023, 32);

/* maketime */
SELECT MAKETIME(17, 03, 02);

/* quarter */
SELECT QUARTER('2023-05-31');

/* time_to_sec */
SELECT TIME_TO_SEC('1:1:1');