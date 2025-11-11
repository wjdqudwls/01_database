# Q1.
# 전화번호가 010으로 시작하는 직원의 직원명과 전화번호를 다음과 같이 출력하세요.
# 출력한 결과집합 헤더의 명칭은 각각 ‘EMP_NAME’, ‘PHONE’이어야 함
# 전화번호는 ‘010-0000-0000’ 형식으로 출력해야 함
# 답안
SELECT E.EMP_NAME,
       CONCAT(SUBSTR(E.PHONE, 1, 3), '-'
           , SUBSTR(E.PHONE, 4, 4), '-'
           , SUBSTR(E.PHONE, 8))
FROM employee E
WHERE SUBSTR(E.PHONE, 1, 3) = 010;

# Q2.
# 근속 일수가 20년 이상인 직원의 직원명, 입사일, 급여를 다음과 같이 출력하세요.
# 단, 입사한 순서대로 출력하고 입사일이 같으면 급여가 높은 순서로 출력되도록 하세요.
# 출력한 결과집합 헤더의 명칭은 각각 ‘직원명’, ‘입사일’, ‘급여’여야 함
# 입사일은 ‘0000년 00월 00일’ 형식으로 출력해야 함
# 급여는 천 단위로 , 를 찍어 출력해야 함
# 답안
-- SUBDATE를 활용한 이후
SELECT E.EMP_NAME 직원명,
       CONCAT(YEAR(E.HIRE_DATE),'년 ',MONTH(E.HIRE_DATE),'월 ',DAY(E.HIRE_DATE),'일') 입사일,
       FORMAT(E.SALARY,0) 급여
    FROM employee E
WHERE HIRE_DATE<=SUBDATE(CURDATE(),INTERVAL 20 YEAR)
ORDER BY HIRE_DATE ASC,
         SALARY DESC;

-- SUBDATE를 활용하기 전
SELECT E.EMP_NAME 직원명,
       CONCAT(YEAR(E.HIRE_DATE),'년 ',MONTH(E.HIRE_DATE),'월 ',DAY(E.HIRE_DATE),'일') 입사일,
       FORMAT(E.SALARY,0) 급여
FROM employee E
WHERE ((YEAR(CURDATE()) - YEAR(E.HIRE_DATE) > 20
           OR (YEAR(CURDATE()) - YEAR(E.HIRE_DATE) = 20 AND
               DAYOFYEAR(CURDATE())>DAYOFYEAR(E.HIRE_DATE))))
    OR
        (E.ENT_DATE IS NOT NULL
         AND (YEAR(E.ENT_DATE) - YEAR(E.HIRE_DATE) > 20
            OR (YEAR(E.ENT_DATE) - YEAR(E.HIRE_DATE) = 20 AND
               DAYOFYEAR(E.ENT_DATE)>DAYOFYEAR(E.HIRE_DATE))))
ORDER BY HIRE_DATE ASC,
         SALARY DESC;
# Q3.
# 모든 직원의 직원명, 급여, 보너스, 급여에 보너스를 더한 금액을 다음과 같이 출력하세요.
# 단, 급여에 보너스를 더한 금액이 높은 순으로 출력되도록 하세요.
# 출력한 결과집합 헤더의 명칭은 각각 ‘EMP_NAME’, ‘SALARY’, ‘BONUS’,
# ‘TOTAL_SALARY’여야 함
# 보너스를 더한 급여는 소수점이 발생할 경우 반올림 처리함
# 급여와 보너스를 더한 급여는 천 단위로 , 를 찍어 출력해야 함
# 보너스는 백분율로 출력해야 함
# 답안
SELECT EMP_NAME,
       FORMAT(ROUND(SALARY),0),
       CONCAT(ROUND(BONUS*100,0),'%') BONUS,
       FORMAT(ROUND(SALARY*(1+IFNULL(BONUS,1))) ,0) TOTAL_SALARY
FROM employee
ORDER BY LENGTH(TOTAL_SALARY) DESC,
         TOTAL_SALARY DESC;

# Q4.
# 직원의 직원명과 이메일을 다음과 같이 출력하세요.
# 출력한 결과집합 헤더의 명칭은 각각 ‘EMP_NAME’, ‘EMAIL’이어야 함
# 이메일의 도메인 주소인 greedy.com 은 모두 동일하므로, 해당 문자열이 맞춰질 수 있
# 도록 이메일의 앞에 공백을 두고 출력해야 함
# 답안
SELECT E.EMP_NAME,
       CONCAT(LPAD(SUBSTRING_INDEX(E.EMAIL,'@',1),(
            SELECT MAX(LENGTH(SUBSTRING_INDEX(EMAIL,'@',1)))
            FROM employee
            ),' '),
        '@',
       SUBSTRING_INDEX(E.EMAIL,'@',-1)) EMAIL
    FROM employee E;
# +@ (심화)
# 이메일의 도메인 주소가 모두 다르다고 가정할 때, @의 위치를 한 줄로 맞추고 싶은 경
# 우에는 어떻게 수정할 수 있을까?
# 답안
SELECT E.EMP_NAME,
       CONCAT(LPAD(SUBSTRING_INDEX(E.EMAIL,'@',1)
            ,(SELECT MAX(LENGTH(SUBSTRING_INDEX(EMAIL,'@',1)))
            FROM employee)
            ,' '),
        '@',
       SUBSTRING_INDEX(E.EMAIL,'@',-1)) EMAIL
    FROM employee E;
# Q5.
# 사내 행사 준비를 위해 직원 목록을 출력하려고 합니다. 직원 목록을 다음과 같이 출력하세요.
# 단, 관리자의 이름순으로 정렬하여 출력되도록 하세요.
# 직원명, 직급명, 주민등록번호, 부서가 있는 국가, 부서명, 해당 직원의 관리자 직원명을
# 출력해야 함
# 출력한 결과집합 헤더의 명칭은 각각 ‘NAME_TAG’, ‘EMP_NO’, ‘BELONG’,
# ‘MANAGER_NAME’이어야 하며 출력 형식은 각각 아래와 같아야 함
# NAME_TAG : (직원명) (직급명)님
# EMP_NO : (생년월일6자리)-(뒷자리 한 자리를 제외하고는 *로 표시)
# BELONG : (부서의 국가)지사 (부서명) 소속
# 답안
SELECT CONCAT(E.EMP_NAME,' ',J.JOB_NAME,'님') NAME_TAG,
       RPAD(SUBSTR(E.EMP_NO,1,8),14,'*') EMP_NO,
        CONCAT(N.NATIONAL_NAME,'지사 ',D.DEPT_TITLE,' 소속') BELONG,
       BOSS.EMP_NAME MANAGER_NAME
FROM employee E
    JOIN department D ON E.DEPT_CODE = D.DEPT_ID
    JOIN location L ON D.LOCATION_ID = L.LOCAL_CODE
    JOIN national N ON L.NATIONAL_CODE = N.NATIONAL_CODE
    JOIN job J ON E.JOB_CODE = J.JOB_CODE
    LEFT JOIN employee BOSS ON E.MANAGER_ID = BOSS.EMP_ID
ORDER BY MANAGER_NAME;