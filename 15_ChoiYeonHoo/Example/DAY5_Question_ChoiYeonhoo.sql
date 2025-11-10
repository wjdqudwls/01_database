/*
Q1.전화번호가 010으로 시작하는 직원의 직원명과 전화번호를 다음과 같이 출력하세요
*/

SELECT
    EMP_NAME,
#     CONCAT(SUBSTRING(PHONE,1,3),'-',SUBSTRING(PHONE,4,4),'-',SUBSTRING(PHONE,8,4)) AS PHONE,
    CONCAT_WS('-',SUBSTRING(PHONE,1,3),SUBSTRING(PHONE,4,4),SUBSTRING(PHONE,8,4)) AS PHONE

FROM employee
WHERE
    SUBSTRING(PHONE,1,3) = '010';

/*
Q2. 근속 일수가 20년 이상인 직원의 직원명, 입사일, 급여를 다음과 같이 출력하세요.
단, 입사한 순서대로 출력하고 입사일이 같으면 급여가 높은 순서로 출력되도록 하세요.
*/

SELECT
    EMP_NAME AS 직원명,
    CONCAT(YEAR(HIRE_DATE),'년 ',MONTH(HIRE_DATE),'월 ',DAY(HIRE_DATE),'일') AS 입사일,
    FORMAT(SALARY,0) AS 급여
FROM employee
WHERE
    CURDATE() >= ADDDATE(HIRE_DATE, INTERVAL 20 YEAR)

ORDER BY
    HIRE_DATE, SALARY DESC;


/*
Q3. 모든 직원의 직원명, 급여, 보너스, 급여에 보너스를 더한 금액을 다음과 같이 출력하세요.
    단, 급여에 보너스를 더한 금액이 높은 순으로 출력되도록 하세요.
*/

SELECT
    EMP_NAME,
    FORMAT(SALARY,0) AS SALARY,
    CONCAT((BONUS*100),'%') AS BONUS,
    FORMAT( ROUND(SALARY * ( 1 + IFNULL(BONUS,0))), 0 ) AS TOTAL_SALARY
    -- FORMAT으로 바꾸면 문자열로 변환 되므로, 만약 해당으로 정렬할 땐 숫자로 다시 변환
FROM employee
ORDER BY
    CAST(TOTAL_SALARY AS SIGNED INT) DESC;

/*
Q4. 직원의 직원명과 이메일을 다음과 같이 출력하세요.
*/

-- 수정
SELECT
    EMP_NAME,
    LPAD(EMAIL,
         (SELECT MAX(CHAR_LENGTH(EMAIL))
          FROM employee),' ') AS EMAIL
FROM employee;

/*
심화 문제
이메일의 도메인 주소가 모두 다르다고 가정할 때, @의 위치를 한 줄로 맞추고 싶은 경우에는 어떻게 수정할 수 있을까?
*/
-- EMAIL에서 @ 위치를 반환 하는 내장 함수 사용 INSTR(EMAIL,'@')
-- @ 위치를 찾았으면, @ 앞까지만 뽑아서 (SUBSTRING 사용) 아이디 MAX.Length, 뒤에 뽑아서 도메인 Max.Length 뽑고
-- LPAD, RPAD로 앞 뒤로 빈칸 삽입

-- 그럴 필요 없음
-- SUBSTRING_INDEX(EMAIL,'@',1),SUBSTRING_INDEX(EMAIL,'@',-1) 사용해서 @ 앞 뒤 글자 추출
-- CHAR_LENGTH(SUBSTRING_INDEX()) 앞뒤 글자 길이 추출
-- SUBSTRING_INDEX LPAD, RPAD 두개 따로 하고
-- CONCAT 으로 붙임


SELECT
    EMP_NAME,
    CONCAT_WS('@',
                LPAD
                (
                    SUBSTRING_INDEX(EMAIL,'@',1),
                    (SELECT MAX(CHAR_LENGTH(SUBSTRING_INDEX(EMAIL,'@',1)))
                    FROM employee),
                ' '
                ),
                RPAD
                (
                    SUBSTRING_INDEX(EMAIL,'@',-1),
                    (SELECT MAX(CHAR_LENGTH(SUBSTRING_INDEX(EMAIL,'@',-1)))
                    FROM employee),
                    ' ')
            )
FROM employee;

/*
Q5. 사내 행사 준비를 위해 직원 목록을 출력하려고 합니다. 직원 목록을 다음과 같이 출력하세요.
    단, 관리자의 이름순으로 정렬하여 출력되도록 하세요
    1. name_tag : cancat으로 함
    2. EMP_NO
        : SUBSTRING 으로 주민번호 101010-1 까지 반환 하고 RPAD로 뒤에 공백 추가해서 해당 자리 *로
    3. BELONG
        : concat (national_name,'지사'
    4. MANAGER_ID가 있으면 이름으로 표현 해야하는데 ?? 상관 쿼리를 써서 한줄씩 ID 읽고 ID에 해당하는 이름 출력
*/

SELECT
    CONCAT(e.EMP_NAME,' ',j.JOB_NAME,'님' )                        AS NAME_TAG,
    RPAD(substring(e.EMP_NO,1,8),14,'*')                          AS EMP_NO,
    CONCAT(n.NATIONAL_NAME,'지사 ',d.DEPT_TITLE,' 소속')            AS BELONG,
    (
        SELECT
            e2.EMP_NAME
        FROM employee e2
        WHERE e2.EMP_ID = e.MANAGER_ID
     ) AS MANAGER_NAME
FROM employee e
    JOIN department d ON (e.DEPT_CODE = d.DEPT_ID)
    JOIN job j ON (e.JOB_CODE = j.JOB_CODE)
    JOIN location l ON (d.LOCATION_ID = l.LOCAL_CODE)
    JOIN national n ON (l.NATIONAL_CODE = n.NATIONAL_CODE)

ORDER BY
    MANAGER_NAME;
