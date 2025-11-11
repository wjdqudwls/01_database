-- 전화번호가 010으로 시작하는 직원의 직원명과 전화번호를 다음과 같이 출력하세요
SELECT
    EMP_NAME,
    CONCAT_WS('-',SUBSTRING(PHONE,1,3),SUBSTRING(PHONE,4,4),SUBSTRING(PHONE,8,4)) AS PHONE
FROM
    employee
WHERE
    SUBSTRING(PHONE,1,3)='010';

/*
근속 일수가 20년 이상인 직원의 직원명, 입사일, 급여를 다음과 같이 출력하세요.
단, 입사한 순서대로 출력하고 입사일이 같으면 급여가 높은 순서로 출력되도록 하세요.
*/
SELECT
    EMP_NAME AS '직원명',
    CONCAT( YEAR(HIRE_DATE), '년', MONTH(HIRE_DATE), '월', DAY(HIRE_DATE), '일') AS '입사일'
FROM
    employee
WHERE
    HIRE_DATE <= SUBDATE(CURDATE(), INTERVAL 20 YEAR )
ORDER BY
    HIRE_DATE ASC, SALARY DESC ;

/*
모든 직원의 직원명, 급여, 보너스, 급여에 보너스를 더한 금액을 다음과 같이 출력하세요.
단, 급여에 보너스를 더한 금액이 높은 순으로 출력되도록 하세요.
- 출력한 결과 집합 헤더의 명칭은 각각 'EMP_NAME', 'SALARY', 'BONUS', 'TOTAL_SALARY'여야 함
- 보너스를 더한 급여는 소수점이 발생한 경우 반올림 처리함
- 급여와 보너스를 더한 급여는 천 단위로 , 를 찍어 출력해야 함
- 보너스는 백분율로 출력해야 함

HINT 1
급여에 보너스를 더한 금액을 구하고자 할 때, 보너스가 0이라면 원하는 값이 나오지 않을 겁니다.
수업시간에 다루지 않았지만 NULL 값을 다른 값으로 대체하는 내장함수가 있습니다.
해당 함수를 찾아서 사용해 보세요.
FORMAT, CONCAT, TRUNCATE, ROUND 사용
*/
SELECT
    EMP_NAME,   -- 직원명
    FORMAT(SALARY, 0) AS 'SALARY',     -- 급여
    TRUNCATE(100 * IFNULL(BONUS,0), 2) AS BONUS,       -- 보너스
    FORMAT(ROUND(SALARY * (1+IFNULL(BONUS,0)), 0), 0) AS TOTAL_SALARY      -- 급여에 보너스를 더한 금액

FROM
    employee
ORDER BY TOTAL_SALARY DESC ;

/*
IFNULL(BONUS, 0)
NULL이 아니면 BONUS 반환, NULL이면 0 반환
*/

/*
직원의 직원명과 이메일을 다음과 같이 출력하세요.
- 출력한 결과집합 헤더의 명칭은 각각 'EMP_NAME', 'EMAIL'이어야 함
- 이메일의 도메인 주소인 greedy.com 은 모두 동일하므로, 해당 문자열이 맞춰질 수 있도록
이메일의 앞에 공백을 두고 출력해야함.
HINT 1 : MAX
HINT 2 : LPAD
HINT 3 : 서브쿼리
+@ 심화 : 이메일의 도메인 주소가 모두 다르다고 가정할 때, @의 위치를 한 줄로 맞추고
싶은 경우에는 어떻게 수정할 수 있을까
*/
SELECT
    EMP_NAME AS 'EMP_NAME',
    LPAD(EMAIL, (SELECT MAX(LENGTH(EMAIL)) FROM employee), ' ') AS 'EMAIL'
FROM employee;

/*
사내 행사 준비를 위해 직원 목록을 출력하려고 한다. 직원 목록을 다음과 같이 출력하세요.
단, 관리자 이름순으로 정렬하세요.

- 직원명, 직급명, 주민등록번호, 부서가 있는 국가, 부서명, 해당 직원의 관리자 직원명을
출력해야함.
- 출력한 결과집합 헤더의 명칭은 'NAME_TAG', 'EMP_NO', 'BELONG', 'MANAGER_NAME'
이어야 하며 출력 형식은 다음과 같아야 한다.
NAME_TAG : (직원명)(직급명)님
EMP_NO : (생년월일6자리)-(뒷자리 한자리를 제외하고는 *표시)
BELONG : (부서의 국가명)지사(부서명)소속
- HINT 1 : JOIN
- HINT 2 : CONCAT
- HINT 3 : RPAD
- HINT 4 : SUBSTRING
*/
SELECT
    CONCAT(E.EMP_NAME, JOB_NAME, '님') AS 'NAME_TAG',
    RPAD(SUBSTRING(E.EMP_NO, 1, 8), 14, '*') AS 'EMP_NO',
    CONCAT(N.NATIONAL_NAME, '지사', D.DEPT_TITLE, '소속') AS 'BELONG',
    M.EMP_NAME AS 'MANAGER_NAME'
FROM
    employee E
JOIN department D ON E.DEPT_CODE = D.DEPT_ID
JOIN job J ON E.JOB_CODE = J.JOB_CODE
JOIN location L ON D.LOCATION_ID = L.LOCAL_CODE
JOIN national N ON L.NATIONAL_CODE = N.NATIONAL_CODE
LEFT JOIN employee M ON E.Manager_ID = M.EMP_ID
ORDER BY MANAGER_NAME;

