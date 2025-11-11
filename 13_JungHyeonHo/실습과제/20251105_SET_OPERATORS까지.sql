/*
    연봉 계산법 : 월급 * (1 + 보너스) * 12 로 수행하시면 됩니다.
    참고로 보너스 컬럼 값이 null인 경우 연산 결과도 null이 나옵니다.
    null 처리 함수 → 내장 함수 챕터에서 학습할 예정이지만 적용해보려면
    IFNULL(보너스, 0) 또는 NVL(보너스, 0) 과 같이 적용하면 null 인 경우 0 으로 취급되어 보너스 없이 계산이 수행 됩니다.
*/

-- 1. 이름에 '형'자가 들어가는 직원들의 사번, 사원명, 부서명을 조회하시오.(1행)
SELECT E.EMP_NO, E.EMP_NAME, D.DEPT_TITLE
FROM employee E
         LEFT JOIN department D -- LEFT JOIN을 사용하는 이유 : DEPT_CODE가 NULL인 행도 포함해줘야함
                   ON E.DEPT_CODE = D.DEPT_ID
WHERE E.EMP_NAME LIKE "%형%";

SELECT *
FROM department;
-- 2. 해외영업팀에 근무하는 사원명, 직급명, 부서코드, 부서명을 조회하시오.(9행)
SELECT E.EMP_NAME    `사원명`
     , J.JOB_NAME AS '직급명'
     , E.DEPT_CODE   "부서코드"
     , D.DEPT_TITLE  `부서명`
FROM employee E
         JOIN JOB J
              ON (E.JOB_CODE = J.JOB_CODE)
         JOIN department D
              ON (E.DEPT_CODE = D.DEPT_ID)
WHERE D.DEPT_TITLE LIKE '해외영업%';

-- 3. 보너스포인트를 받는 직원들의 사원명, 보너스포인트, 부서명, 근무지역명을 조회하시오.(8행)
-- (INNER JOIN 결과)
SELECT E.EMP_NO, E.BONUS, D.DEPT_TITLE, L.LOCAL_NAME
FROM employee E
         INNER JOIN department D ON E.DEPT_CODE = D.DEPT_ID
         INNER JOIN location L ON D.LOCATION_ID = L.LOCAL_CODE;

-- 4. 부서코드가 D2인 직원들의 사원명, 직급명, 부서명, 근무지역명을 조회하시오.(3행)
-- (INNER JOIN 결과, JOIN 순서 중요!!)
SELECT E.EMP_NAME, J.JOB_NAME, D.DEPT_TITLE, L.LOCAL_NAME
FROM employee E
         JOIN job J ON E.JOB_CODE = J.JOB_CODE
         JOIN department D ON E.DEPT_CODE = D.DEPT_ID
         JOIN location L ON D.LOCATION_ID = L.LOCAL_CODE;

-- 5. 급여 테이블의 등급별 최소급여(MIN_SAL)보다 많이 받는 직원들의
-- 사원명, 직급명, 급여, 연봉을 조회하시오.
-- 연봉에 보너스포인트를 적용하시오.(20행)
/*
    연봉 계산법 : 월급 * (1 + 보너스) * 12 로 수행하시면 됩니다.
    참고로 보너스 컬럼 값이 null인 경우 연산 결과도 null이 나옵니다.
    null 처리 함수 → 내장 함수 챕터에서 학습할 예정이지만 적용해보려면
    IFNULL(보너스, 0) 또는 NVL(보너스, 0) 과 같이 적용하면 null 인 경우 0 으로 취급되어 보너스 없이 계산이 수행 됩니다.
*/
SELECT E.EMP_NAME,
       J.JOB_NAME,
       E.SALARY,
       E.SALARY * (1 + IFNULL(E.BONUS, 0)) * 12 연봉
FROM employee E
         JOIN job J ON (E.JOB_CODE = J.JOB_CODE)
         JOIN sal_grade S ON (E.SAL_LEVEL = S.SAL_LEVEL)
WHERE E.SALARY > S.MIN_SAL;



-- 6. 한국(KO)과 일본(JP)에 근무하는 직원들의
-- 사원명, 부서명, 지역명, 국가명을 조회하시오.(15행)
SELECT E.EMP_NAME, D.DEPT_TITLE, L.LOCAL_NAME, N.NATIONAL_NAME
FROM employee E
         JOIN department D ON E.DEPT_CODE = D.DEPT_ID
         JOIN location L ON D.LOCATION_ID = L.LOCAL_CODE
         JOIN national N ON L.NATIONAL_CODE = N.NATIONAL_CODE;


-- 7. 보너스포인트가 없는 직원들 중에서 직급코드가 J4와 J7인 직원들의 사원명, 직급명, 급여를 조회하시오.
-- 단, join과 IN 사용할 것(8행)

SELECT E.EMP_NAME, J.JOB_NAME, SALARY
FROM employee E
         JOIN (SELECT EMP_NO
               FROM employee E
               WHERE BONUS IS NULL) TMP ON E.EMP_NO = TMP.EMP_NO
         JOIN job J ON E.JOB_CODE = J.JOB_CODE
WHERE E.JOB_CODE IN ('J4', 'J7');

-- 8. 직급이 대리이면서 아시아 지역(ASIA1, ASIA2, ASIA3 모두 해당)에 근무하는 직원 조회(2행)
-- 사번(EMPLOYEE.EMP_ID), 이름(EMPLOYEE.EMP_NAME), 직급명(JOB.JOB_NAME), 부서명(DEPARTMENT.DEPT_TITLE),
-- 근무지역명(LOCATION.LOCAL_NAME), 급여(EMPLOYEE.SALARY)를 조회하시오.
-- (해당 컬럼을 찾고, 해당 컬럼을 지닌 테이블들을 찾고, 테이블들을 어떤 순서로 조인해야 하는지 고민하고 SQL문을 작성할 것)
SELECT E.EMP_ID, E.EMP_NAME, J.JOB_NAME, D.DEPT_TITLE, L.LOCAL_NAME, E.SALARY
FROM employee E
         JOIN job J ON E.JOB_CODE = J.JOB_CODE
         JOIN department D ON E.DEPT_CODE = D.DEPT_ID
         JOIN location L ON D.LOCATION_ID = L.LOCAL_CODE
         JOIN national N ON L.NATIONAL_CODE = N.NATIONAL_CODE
WHERE L.LOCAL_NAME LIKE '%ASIA%'
  AND JOB_NAME = '대리';

-- 9. 각 부서별 평균 급여와 직원 수를 조회하시오. (NULL 급여는 제외)
-- 평균 급여가 높은 순으로 정렬하시오. (6행)
SELECT AVG(E.SALARY), COUNT(*)
FROM employee E
         JOIN (SELECT *
               FROM employee
               WHERE DEPT_CODE IS NOT NULL) TEMP ON E.EMP_ID = TEMP.EMP_ID
GROUP BY E.DEPT_CODE
ORDER BY AVG(E.SALARY);

-- 10. 직원 중 보너스를 받는 직원들의 연봉 총합이 1억 원을
-- 초과하는 부서의 부서명과 연봉 총합을 조회하시오. (1행)
SELECT D.DEPT_TITLE, SUM(E.SALARY * (1 + BONUS) * 12) 연봉총합
FROM employee E
         JOIN department D ON E.DEPT_CODE = D.DEPT_ID
WHERE BONUS IS NOT NULL
  AND E.SALARY * (1 + BONUS) * 12 > 100000000;


-- 11. 국내 근무하는 직원들 중 평균 급여 이상을 받는
-- 직원들의 사원명, 급여, 부서명을 조회하시오. (서브쿼리 사용) (4행)
WITH TEMP AS (SELECT E.EMP_ID, E.SALARY, D.DEPT_TITLE
              FROM employee E
                       JOIN department D ON E.DEPT_CODE = D.DEPT_ID
                       JOIN location L ON D.LOCATION_ID = L.LOCAL_CODE
                       JOIN national N ON L.NATIONAL_CODE = N.NATIONAL_CODE
              WHERE N.NATIONAL_NAME = '한국')
SELECT E.EMP_NAME, E.SALARY, TEMP.DEPT_TITLE
FROM employee E
         JOIN TEMP ON E.EMP_ID = TEMP.EMP_ID
WHERE E.SALARY > (SELECT AVG(TEMP.SALARY)
                  FROM TEMP);


-- 12. 모든 부서의 부서명과 해당 부서에 소속된 직원 수를 조회하시오.
-- 직원이 없는 부서도 함께 표시하시오. (9행)

-- 복습
SELECT D.DEPT_TITLE, COUNT(E.EMP_NO)
FROM employee E
RIGHT JOIN department D ON E.DEPT_CODE = D.DEPT_ID
GROUP BY D.DEPT_TITLE;




SELECT D.DEPT_TITLE 부서명, COUNT(*)
FROM employee E
         JOIN department D ON E.DEPT_CODE = D.DEPT_ID
GROUP BY E.DEPT_CODE
UNION
SELECT D.DEPT_TITLE 부서명, 0
FROM department D
         LEFT JOIN employee E ON D.DEPT_ID = E.DEPT_CODE
WHERE E.EMP_ID IS NULL
GROUP BY D.DEPT_TITLE;

SELECT D.DEPT_TITLE, COUNT(EMP_ID)
FROM department D
         LEFT JOIN
     employee E ON (D.DEPT_ID = E.DEPT_CODE)
GROUP BY D.DEPT_TITLE;



-- 13. 차장(J4) 이상 직급을 가진 직원과 사원(J7) 직급을 가진
-- 직원들의 급여 합계를 비교하여 결과를 출력하시오. (SET OPERATOR 사용) (2행)
SELECT '차장이상' AS 직급, SUM(E.SALARY) 급여합계
FROM employee E
WHERE E.JOB_CODE <= 'J4'
UNION
SELECT '사원' AS 직급, SUM(E.SALARY) 급여합계
FROM employee E
WHERE E.JOB_CODE = 'J7'
