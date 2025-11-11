/*
    15. BUILT IN FUNCTION 내장 함수
*/

-- ASCII('문자') : 문자의 ASCII code를 반환
-- CHAR(ASCII CODE) : 입력한 아스키 코드에 맞는 문자를 반환
SELECT ASCII('A'), CHAR(65);

/*
BIT_LENGTH: 할당된 비트 크기 반환
CHAR_LENGTH: 문자열의 길이 반환
LENGTH: 할당된 BYTE 크기 반환
*/

SELECT BIT_LENGTH('pie'), CHAR_LENGTH('pie'), LENGTH('pie');
SELECT
    menu_name,
    BIT_LENGTH(menu_name),
    CHAR_LENGTH(menu_name),
    LENGTH(menu_name)
from tbl_menu
WHERE CHAR_LENGTH(menu_name) <= 6  ;

/*
CONCAT: 문자열을 이어붙임
CONCAT_WS: 구분자와 함께 문자열을 이어붙임 (CONCAT WHITE SPACE)
*/
SELECT CONCAT('호랑이', '기린', '토끼');
SELECT CONCAT_WS(',', '호랑이', '기린', '토끼');
SELECT CONCAT_WS('-', '2023', '05', '31');

/*
ELT: 해당 위치의 문자열 반환
FIELD: 찾을 문자열 위치 반환
FIND_IN_SET: 찾을 문자열의 위치 반환 -> 0부터
INSTR: 기준 문자열에서 부분 문자열의 시작 위치 반환 -> 1부터
LOCATE: INSTR과 동일하고 순서는 반대 -> 1부터
*/

SELECT
       ELT(2, '사과', '딸기', '바나나')
     , FIELD('딸기', '사과', '딸기', '바나나')
     , FIND_IN_SET('바나나', '사과,딸기,바나나')
     , INSTR('사과딸기바나나', '딸기')
     , LOCATE('딸기', '사과딸기바나나');

/*
FORMAT: 1000단위마다 콤마(,) 표시를 해 주며 소수점 아래 자릿수(반올림)까지 표현한다.
*/
SELECT FORMAT(123142512521.5635326, 3);

/*
BIN: 2진수 표현
OCT: 8진수 표현
HEX: 16진수 표현
*/
SELECT BIN(65), OCT(65), HEX(65);

/*
INSERT: 기준 문자열의 위치부터 길이만큼을 지우고 삽입할 문자열을 끼워 넣는다. 1부터 셈
*/
SELECT INSERT('내 이름은 아무개입니다.', 7, 3, '홍길동');

/*
LEFT: 왼쪽에서 문자열의 길이만큼을 반환
RIGHT: 오른쪽에서 문자열의 길이만큼을 반환
*/
SELECT LEFT('Hello World!', 3), RIGHT('Hello World!', 3);

/*
UPPER: 소문자를 대문자로 변경
LOWER: 대문자를 소문자로 변경
*/
SELECT LOWER('Hello World!'), UPPER('Hello World!');

/*
LPAD: 문자열을 길이만큼 왼쪽으로 늘린 후에 빈 곳을 문자열로 채운다.
RPAD: 문자열을 길이만큼 오른쪽으로 늘린 후에 빈 곳을 문자열로 채운다.
*/
SELECT LPAD('왼쪽', 6, '@'), RPAD('오른쪽', 6 ,'@');

/*
LTRIM: 왼쪽 공백 제거
RTRIM: 오른쪽 공백 제거
*/
SELECT LTRIM('    왼쪽'), RTRIM('오른쪽    ');

/*
TRIM: TRIM은 기본적으로 앞뒤 공백을 제거하지만 방향(LEADING(앞), BOTH(양쪽), TRAILING(뒤))이 있으면 해당 방향에 지정한 문자열을 제거할 수 있다.
*/
SELECT TRIM('    MySQL    '), TRIM(BOTH '@' FROM '@@@@MySQL@@@@'),
       TRIM(LEADING '@' FROM '@@@@MySQL@@@@'), TRIM(TRAILING '@' FROM '@@@@MySQL@@@@');

/*
REPEAT: 문자열을 횟수만큼 반복
*/
SELECT REPEAT('재밌어', 3);

/*
REPLACE: 문자열에서 문자열을 찾아 치환
*/
SELECT REPLACE('마이SQL', '마이', 'My');

/*
REVERSE: 문자열의 순서를 거꾸로 뒤집음
*/
SELECT REVERSE('stressed');

/*
SPACE: 길이 만큼의 공백을 반환
*/
SELECT CONCAT('제 이름은', SPACE(5), '이고 나이는', SPACE(3), '세입니다.');

/*
SUBSTRING: 시작 위치부터 길이만큼의 문자를 반환(길이를 생략하면 시작 위치부터 끝까지 반환)
*/
SELECT SUBSTRING('안녕하세요 반갑습니다.', 7, 2), SUBSTRING('안녕하세요 반갑습니다.', 7);

/*
UBSTRING_INDEX: 구분자가 왼쪽부터 횟수 번째 나오면 그 이후의 오른쪽은 버린다.
횟수가 음수일 경우 오른쪽부터 세고 왼쪽을 버린다.
*/
SELECT SUBSTRING_INDEX('hong.test@gmail.com', '.', 2), SUBSTRING_INDEX('hong.test@gmail.com', '.', -2);

/*
ABS: 절대값 반환
*/
SELECT ABS(-123);

/*
CEILING: 올림값 반환
FLOOR: 버림값 반환
ROUND: 반올림값 반환
*/
SELECT CEILING(1234.56), FLOOR(1234.56), ROUND(1234.56);
SELECT FLOOR(-123.4), ROUND(-123.4);


/*
CONV: 원래 진수에서 변환하고자 하는 진수로 변환
*/
SELECT CONV('A', 16, 10), CONV('A', 16, 2), CONV(1010, 2, 8);

/*
MOD: 숫자 1을 숫자 2로 나눈 나머지 추출
*/
SELECT MOD(75, 10), 75 % 10, 75 MOD 10;

/*
POW: 거듭제곱값 추출
SQRT: 제곱근을 추출
*/
SELECT POW(2, 4), SQRT(16);

/*
RAND: 0이상 1 미만의 실수를 구한다.
'm <= 임의의 정수 < n'을 구하고 싶다면
FLOOR((RAND() * (n - m) + m)을 사용한다.
1부터 10까지 난수 발생: FLOOR(RAND() * (11 - 1) + 1)
*/
SELECT RAND(), FLOOR(RAND() * (11 - 1) + 1);

/*
SIGN: 양수면 1, 0이면 0, 음수면 -1을 반환
*/
SELECT SIGN(10.1), SIGN(0), SIGN(-10.1);

/*
TRUNCATE: 소수점을 기준으로 정수 위치까지 구하고 나머지는 버림
*/
SELECT TRUNCATE(12345.12345, 2), TRUNCATE(12345.12345, -2);

-- (3) 날짜/시간 관련 함수

-- adddate, subdate
/*
ADDDATE: 날짜를 기준으로 차이를 더함
SUBDATE: 날짜를 기준으로 날짜를 뺌
*/
SELECT
       ADDDATE('2023-05-31', INTERVAL 30 DAY)
     , ADDDATE('2023-05-31', INTERVAL 6 MONTH)
     , ADDDATE('2023-05-31', INTERVAL 1 YEAR)
     , SUBDATE('2023-05-31', INTERVAL 30 DAY)
     , SUBDATE('2023-05-31', INTERVAL 6 MONTH)
     , SUBDATE('2023-05-31', INTERVAL 1 YEAR);

-- addtime, subtime
/*
ADDTIME: 날짜 또는 시간을 기준으로 시간을 더함
SUBTIME: 날짜 또는 시간을 기준으로 시간을 뺌
*/
SELECT
       ADDTIME('2023-05-31 09:00:00', '1:0:1')
     , SUBTIME('2023-05-31 09:00:00', '1:0:1');

-- 현재 시스템 날짜/시간 반환
/*
CURDATE: 현재 연-월-일 추출
CURTIME: 현재 시:분:초 추출
NOW() 또는 SYSDATE(): 현재 연-월-일 시:분:초 추출
*/
SELECT CURDATE(), CURRENT_DATE(), CURRENT_DATE;
SELECT CURTIME(), CURRENT_TIME(), CURRENT_TIME;
SELECT NOW(), LOCALTIME, LOCALTIME(), LOCALTIMESTAMP, LOCALTIMESTAMP();

-- year, month, dayofmonth
/*
HOUR(시간), MINUTE(시간), SECOND(시간), MICROSECOND(시간)
날짜 또는 시간에서 연, 월, 일, 시, 분, 초, 밀리초를 추출
*/

SELECT YEAR(CURDATE()), MONTH(CURDATE()), DAYOFMONTH(CURDATE());
-- hour, minute, second, microsecond
SELECT HOUR(CURTIME()), MINUTE(CURTIME()), SECOND(CURTIME()),
MICROSECOND(CURTIME(6));

-- date, time
/*
DATE: 연-월-일만 추출
TIME: 시:분:초만 추출
*/
SELECT DATE(NOW()), TIME(NOW());

-- datediff, timediff
/*
DATEDIFF: 날짜1 - 날짜2의 일수를 반환
TIMEDIFF: 시간1 - 시간2의 결과를 구함
*/
SELECT DATEDIFF('2023-05-31', '2023-02-27')
     , TIMEDIFF('17:07:11', '13:06:10');

-- dayofweek, monthname, dayofyear
/*
DAYOFWEEK: 요일 반환(1이 일요일)
MONTHNAME: 해당 달의 이름 반환
DAYOFYEAR: 해당 년도에서 몇 일이 흘렀는지 반환
*/
SELECT DAYOFWEEK(CURDATE()), MONTHNAME(CURDATE()), DAYOFYEAR(CURDATE());

-- last_day
/*
LAST_DAY: 해당 날짜의 달에서 마지막 날의 날짜를 구한다.
*/
SELECT LAST_DAY('2023-02-01');

-- makedate, maketime
/*
MAKEDATE: 해당 연도의 정수만큼 지난 날짜를 구한다.
MAKETIME: 시, 분, 초를 이용해서 '시:분:초'의 TIME 형식을 만든다.
*/
SELECT MAKEDATE(2023, 32), MAKETIME(17, 03, 02);

-- quarter
/*
QUARTER: 해당 날짜의 분기를 구함
*/
SELECT QUARTER('2023-05-01');

-- time_to_sec
/*
TIME_TO_SEC: 시간을 초 단위로 구함
*/
SELECT TIME_TO_SEC('1:1:1');


SELECT
