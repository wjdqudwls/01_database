# DAY5: Question
# Q1.
# 전화번호가 010으로 시작하는 직원의 직원명과 전화번호를 다음과 같이 출력하세요.
# 출력한 결과집합 헤더의 명칭은 각각 ‘EMP_NAME’, ‘PHONE’이어야 함
# 전화번호는 ‘010-0000-0000’ 형식으로 출력해야 함
# HINT 1
# CONCAT
# HINT 2
# SUBSTRING
# 답안
SELECT
    EMP_NAME AS EMP_NAME,
    CONCAT(
        SUBSTRING(PHONE, 1, 3), '-',
        SUBSTRING(PHONE, 4, 4), '-',
        SUBSTRING(PHONE, 8)
    ) AS PHONE
FROM EMPLOYEE
WHERE PHONE LIKE '010%';


# Q2.
# 근속 일수가 20년 이상인 직원의 직원명, 입사일, 급여를 다음과 같이 출력하세요.
# 단, 입사한 순서대로 출력하고 입사일이 같으면 급여가 높은 순서로 출력되도록 하세요.
# 출력한 결과집합 헤더의 명칭은 각각 ‘직원명’, ‘입사일’, ‘급여’여야 함
# 입사일은 ‘0000년 00월 00일’ 형식으로 출력해야 함
# 급여는 천 단위로 , 를 찍어 출력해야 함
# HINT 1
# CONCAT
# HINT 2
# FORMAT
# HINT 3
# DATE 관련 함수
# HING 4
# YEAR, MONTH, DAY
# 답안
SELECT
    EMP_NAME AS '직원명',
    CONCAT(
        YEAR(HIRE_DATE), '년 ',
        LPAD(MONTH(HIRE_DATE), 2, '0'), '월 ',
        LPAD(DAY(HIRE_DATE), 2, '0'), '일'
    ) AS '입사일',
    FORMAT(SALARY, 0) AS '급여'
FROM EMPLOYEE
WHERE TIMESTAMPDIFF(YEAR, HIRE_DATE, CURDATE()) >= 20
ORDER BY HIRE_DATE ASC, SALARY DESC;


# Q3.
# 모든 직원의 직원명, 급여, 보너스, 급여에 보너스를 더한 금액을 다음과 같이 출력하세요.
# 단, 급여에 보너스를 더한 금액이 높은 순으로 출력되도록 하세요.
# 출력한 결과집합 헤더의 명칭은 각각 ‘EMP_NAME’, ‘SALARY’, ‘BONUS’,
# ‘TOTAL_SALARY’여야 함
# 보너스를 더한 급여는 소수점이 발생할 경우 반올림 처리함
# 급여와 보너스를 더한 급여는 천 단위로 , 를 찍어 출력해야 함
# 보너스는 백분율로 출력해야 함
# HINT 1
# 급여에 보너스를 더한 금액을 구하고자 할 때, 보너스가 0이라면 원하는 값이 나오지 않
# 을 겁니다. 수업 시간에 다루지 않았지만 NULL 값을 다른 값으로 대체하는 내장함수가
# 있습니다. 해당 함수를 찾아서 사용해 보세요🙂
# HINT 2
# FORMAT
# HINT 3
# CONCAT
# HINT 4
# TRUNCATE
# DAY5: Question 4
# HINT 5
# ROUND
# 답안
SELECT
    EMP_NAME AS EMP_NAME,
    FORMAT(SALARY, 0) AS SALARY,
    CONCAT(IFNULL(BONUS, 0) * 100, '%') AS BONUS,
    FORMAT(ROUND(SALARY * (1 + IFNULL(BONUS, 0))), 0) AS TOTAL_SALARY
FROM EMPLOYEE
ORDER BY SALARY * (1 + IFNULL(BONUS, 0)) DESC;


# Q4.
# 직원의 직원명과 이메일을 다음과 같이 출력하세요.
# 출력한 결과집합 헤더의 명칭은 각각 ‘EMP_NAME’, ‘EMAIL’이어야 함
# 이메일의 도메인 주소인 greedy.com 은 모두 동일하므로, 해당 문자열이 맞춰질 수 있
# 도록 이메일의 앞에 공백을 두고 출력해야 함
# HINT 1
# LPAD
# HINT 2
# MAX
# DAY5: Question 5
# HINT 3
# 서브쿼리
# 답안
SELECT
    EMP_NAME AS EMP_NAME,
    CONCAT(
        LPAD(SUBSTRING_INDEX(EMAIL, '@', 1),
             (SELECT MAX(CHAR_LENGTH(SUBSTRING_INDEX(EMAIL, '@', 1))) FROM EMPLOYEE),
             ' '),
        '@',
        SUBSTRING_INDEX(EMAIL, '@', -1)
    ) AS EMAIL
FROM EMPLOYEE;


# +@ (심화)
# 이메일의 도메인 주소가 모두 다르다고 가정할 때, @의 위치를 한 줄로 맞추고 싶은 경
# 우에는 어떻게 수정할 수 있을까?
# 답안
SELECT
    EMP_NAME AS EMP_NAME,
    CONCAT(
        LPAD(SUBSTRING_INDEX(EMAIL, '@', 1),
             (SELECT MAX(CHAR_LENGTH(SUBSTRING_INDEX(EMAIL, '@', 1))) FROM EMPLOYEE),
             ' '),
        '@',
        SUBSTRING_INDEX(EMAIL, '@', -1)
    ) AS EMAIL
FROM EMPLOYEE;



# Q5.
# 사내 행사 준비를 위해 직원 목록을 출력하려고 합니다. 직원 목록을 다음과 같이 출력하세
# 요.
# 단, 관리자의 이름순으로 정렬하여 출력되도록 하세요.
# 직원명, 직급명, 주민등록번호, 부서가 있는 국가, 부서명, 해당 직원의 관리자 직원명을
# 출력해야 함
# 출력한 결과집합 헤더의 명칭은 각각 ‘NAME_TAG’, ‘EMP_NO’, ‘BELONG’,
# ‘MANAGER_NAME’이어야 하며 출력 형식은 각각 아래와 같아야 함
# NAME_TAG : (직원명) (직급명)님
# EMP_NO : (생년월일6자리)-(뒷자리 한 자리를 제외하고는 *로 표시)
# BELONG : (부서의 국가)지사 (부서명) 소속
# HINT 1
# JOIN
# HINT 2
# CONCAT
# HINT 3
# RPAD
# HINT 4
# SUBSTRING
# 답안
SELECT
    CONCAT(e.EMP_NAME, ' ', j.JOB_NAME, '님') AS NAME_TAG,
    CONCAT(
        SUBSTRING(e.EMP_NO, 1, 6), '-',
        RPAD(SUBSTRING(e.EMP_NO, 8, 1), 7, '*')
    ) AS EMP_NO,
    CONCAT(n.NATIONAL_NAME, '지사 ', d.DEPT_TITLE, ' 소속') AS BELONG,
    m.EMP_NAME AS MANAGER_NAME
FROM EMPLOYEE e
LEFT JOIN JOB j
    ON e.JOB_CODE = j.JOB_CODE
LEFT JOIN DEPARTMENT d
    ON e.DEPT_CODE = d.DEPT_ID
LEFT JOIN LOCATION l
    ON d.LOCATION_ID = l.LOCAL_CODE
LEFT JOIN NATIONAL n
    ON l.NATIONAL_CODE = n.NATIONAL_CODE
LEFT JOIN EMPLOYEE m
    ON e.MANAGER_ID = m.EMP_ID
ORDER BY m.EMP_NAME;


