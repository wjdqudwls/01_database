/*
    연봉 계산법 : 월급 * (1 + 보너스) * 12 로 수행하시면 됩니다.
    참고로 보너스 컬럼 값이 null인 경우 연산 결과도 null이 나옵니다.

    null 처리 함수 → 내장 함수 챕터에서 학습할 예정이지만 적용해보려면
    IFNULL(보너스, 0) 또는 NVL(보너스, 0) 과 같이 적용하면 null 인 경우 0 으로 취급되어 보너스 없이 계산이 수행 됩니다.
*/
SELECT * FROM employee;
SELECT * FROM department;
SELECT * FROM job;
SELECT * FROM location;
SELECT * FROM sal_grade;


-- 1. 이름에 '형'자가 들어가는 직원들의 사번, 사원명, 부서명을 조회하시오.(1행)
SELECT
    e.EMP_ID, e.EMP_NAME, d.DEPT_TITLE
FROM
             employee e
LEFT JOIN
             department d ON(e.DEPT_CODE = d.DEPT_ID)
WHERE
                e.EMP_NAME LIKE '%형%';


-- 2. 해외영업팀에 근무하는 사원명, 직급명, 부서코드, 부서명을 조회하시오.(9행)
SELECT
    E.EMP_NAME AS 사원명,
    J.JOB_NAME AS '직급명',
    D.DEPT_ID "부서코드",
    D.DEPT_TITLE `부서명`
FROM
    employee E
JOIN
    job J ON (E.JOB_CODE = J.JOB_CODE)
JOIN
    department D ON (E.DEPT_CODE = D.DEPT_ID)
WHERE
    D.DEPT_TITLE LIKE '해외영업%';


-- 3. 보너스포인트를 받는 직원들의 사원명, 보너스포인트, 부서명, 근무지역명을 조회하시오.(8행)
-- (INNER JOIN 결과, JOIN 순서 중요!!)
SELECT
    E.EMP_NAME, E.BONUS, D.DEPT_TITLE, L.LOCAL_NAME
FROM
    employee E
JOIN
    department D ON (E.DEPT_CODE = D.DEPT_ID)
JOIN
    location L ON (D.LOCATION_ID = L.LOCAL_CODE)
WHERE
    E.BONUS IS NOT NULL;


-- 4. 부서코드가 D2인 직원들의 사원명, 직급명, 부서명, 근무지역명을 조회하시오.(3행)
SELECT
       a.emp_name "사원명"
     , c.job_name "직급명"
     , b.dept_title "부서명"
     , d.local_name "근무지역명"
  FROM employee a
  JOIN department b ON (a.dept_code = b.dept_id)
  JOIN job c ON (a.job_code = c.job_code)
  JOIN location d ON (b.location_id = d.local_code)
 WHERE b.dept_id = 'D2';



-- 5. 급여 테이블의 등급별 최소급여(MIN_SAL)보다 많이 받는 직원들의
-- 사원명, 직급명, 급여, 연봉을 조회하시오.
-- 연봉에 보너스포인트를 적용하시오.(20행)
SELECT
    E.EMP_NAME, J.JOB_NAME, E.SALARY,
    (E.SALARY * ( 1 + NVL(BONUS, 0) ) * 12) AS 연봉
FROM
    employee E
JOIN
    job J ON (E.JOB_CODE = J.JOB_CODE)
JOIN
    sal_grade S ON (E.SAL_LEVEL = S.SAL_LEVEL)
WHERE
    E.SALARY > S.MIN_SAL;



-- 6. 한국(KO)과 일본(JP)에 근무하는 직원들의
-- 사원명, 부서명, 지역명, 국가명을 조회하시오.(15행)
SELECT
       a.emp_name "사원명"
     , b.dept_title "부서명"
     , c.local_name "지역명"
     , d.national_name "국가명"
  FROM employee a
  JOIN department b ON (a.dept_code = b.dept_id)
  JOIN location c ON (b.location_id = c.local_code)
  JOIN national d ON (c.national_code = d.national_code)
 WHERE c.national_code IN ('KO', 'JP');

-- 7. 보너스포인트가 없는 직원들 중에서 직급코드가 J4와 J7인 직원들의 사원명, 직급명, 급여를 조회하시오.
-- 단, join과 IN 사용할 것(8행)
SELECT
       a.emp_name
     , b.job_name
     , a.salary
  FROM employee a
  JOIN job b ON (a.job_code = b.job_code)
 WHERE a.job_code IN ('J4', 'J7')
   AND bonus IS NULL;

-- 8. 직급이 대리이면서 아시아 지역(ASIA1, ASIA2, ASIA3 모두 해당)에 근무하는 직원 조회(2행)
-- 사번(EMPLOYEE.EMP_ID), 이름(EMPLOYEE.EMP_NAME), 직급명(JOB.JOB_NAME), 부서명(DEPARTMENT.DEPT_TITLE),
-- 근무지역명(LOCATION.LOCAL_NAME), 급여(EMPLOYEE.SALARY)를 조회하시오.
-- (해당 컬럼을 찾고, 해당 컬럼을 지닌 테이블들을 찾고, 테이블들을 어떤 순서로 조인해야 하는지 고민하고 SQL문을 작성할 것)
SELECT
       a.emp_id
     , a.emp_name
     , b.job_name
     , c.dept_title
     , d.local_name
     , a.salary
  FROM employee a
  JOIN job b ON (a.job_code = b.job_code)
  JOIN department c ON (a.dept_code = c.dept_id)
  JOIN location d ON (c.location_id = d.local_code)
 WHERE b.job_name = '대리'
--   AND d.local_name IN ('asia1', 'asia2', 'asia3');
   AND d.local_name LIKE '%asia%';

-- 9. 각 부서별 평균 급여와 직원 수를 조회하시오. (NULL 급여는 제외)
-- 평균 급여가 높은 순으로 정렬하시오. (6행)
SELECT
    D.DEPT_TITLE "부서명",
    AVG(E.SALARY) "평균 급여",
    COUNT(*) "직원 수"
FROM
    employee E
JOIN
    department D ON (E.DEPT_CODE = D.DEPT_ID)
WHERE
    E.SALARY IS NOT NULL
GROUP BY
    D.DEPT_TITLE
ORDER BY
    AVG(E.SALARY) DESC;


-- 10. 직원 중 보너스를 받는 직원들의 연봉 총합(급여 *(1+ BONUS) * 12)이 1억 원을
-- 초과하는 부서의 부서명과 연봉 총합을 조회하시오. (1행)
SELECT
    DEPT_TITLE,
    SUM(E.SALARY * (1 + E.BONUS) * 12) "연봉 총합"
FROM
    employee E
JOIN
    department D ON(E.DEPT_CODE = D.DEPT_ID)
WHERE
    E.BONUS IS NOT NULL
GROUP BY
    DEPT_TITLE
HAVING
    SUM(E.SALARY * (1 + E.BONUS) * 12) > 100000000;


-- 11. 국내 근무하는 직원들 중 평균 급여 이상을 받는
-- 직원들의 사원명, 급여, 부서명을 조회하시오. (서브쿼리 사용) (4행)

-- 2개 테이블 조인, 서브쿼리 2개
SELECT
    E.EMP_NAME,
    E.SALARY,
    D.DEPT_TITLE
FROM employee E
         JOIN department D ON (E.DEPT_CODE = D.DEPT_ID)
WHERE
    D.DEPT_ID IN (
        SELECT DEPT_ID
        FROM department D2
        JOIN location L2 ON (D2.LOCATION_ID = L2.LOCAL_CODE)
        WHERE L2.NATIONAL_CODE = 'KO'
    )
AND
    E.SALARY >= (
        SELECT AVG(SALARY)
        FROM employee
    );


-- 3개 테이블 조인
SELECT
    E.EMP_NAME,
    E.SALARY,
    D.DEPT_TITLE
FROM
    employee E
JOIN
    department D ON (E.DEPT_CODE = D.DEPT_ID)
JOIN
    location L ON (D.LOCATION_ID = L.LOCAL_CODE)
WHERE
    L.NATIONAL_CODE = 'KO'
AND
    E.SALARY >= (
            SELECT AVG(SALARY)
            FROM employee
        );



-- 12. 모든 부서의 부서명과 해당 부서에 소속된 직원 수를 조회하시오.
-- 직원이 없는 부서도 함께 표시하시오. (9행)
SELECT
    D.DEPT_TITLE, COUNT(E.EMP_ID)
FROM
    department D
LEFT JOIN
    employee E ON (D.DEPT_ID = E.DEPT_CODE)
GROUP BY
    D.DEPT_TITLE



-- 13. 차장(J4) 이상 직급을 가진 직원과 사원(J7) 직급을 가진
-- 직원들의 급여 합계를 비교하여 결과를 출력하시오. (SET OPERATOR 사용) (2행)
SELECT
    '차장 이상' AS "구분",SUM(E.SALARY) AS "급여합계"
FROM
    employee E
WHERE
    E.JOB_CODE IN ('J1','J2','J3','J4')
UNION

SELECT '사원' AS "구분", SUM(E.SALARY) AS "급여합계"
FROM
    employee E
WHERE
    E.JOB_CODE = 'J7';

