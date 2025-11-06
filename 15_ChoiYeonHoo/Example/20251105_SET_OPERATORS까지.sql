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
SELECT * FROM national;
SELECT * FROM sal_grade;

-- 1. 이름에 '형'자가 들어가는 직원들의 사번, 사원명, 부서명을 조회하시오.(1행)
SELECT
    e.EMP_ID AS 사번,
    e.EMP_NAME AS 사원명,
    d.DEPT_TITLE AS 부서명

FROM employee e
LEFT JOIN department d ON e.DEPT_CODE = d.DEPT_ID
WHERE e.EMP_NAME LIKE '%형%';



-- 2. 해외영업팀에 근무하는 사원명, 직급명, 부서코드, 부서명을 조회하시오.(9행)
SELECT
    e.EMP_NAME AS 사원명,
    j.JOB_NAME AS 직급명,
    e.DEPT_CODE AS 부서코드,
    d.DEPT_TITLE AS 부서명

FROM employee e
JOIN job j ON (e.JOB_CODE = j.JOB_CODE)
JOIN department d ON (e.DEPT_CODE = d.DEPT_ID)
WHERE DEPT_TITLE LIKE '해외영업%';

-- 3. 보너스포인트를 받는 직원들의 사원명, 보너스포인트, 부서명, 근무지역명을 조회하시오.(8행)
-- (INNER JOIN 결과, JOIN 순서 중요!!)
SELECT
    e.EMP_NAME,
    e.BONUS,
    d.DEPT_TITLE,
    l.LOCAL_NAME
FROM employee e
         JOIN department d on (e.DEPT_CODE = d.DEPT_ID)
         JOIN location l on (d.LOCATION_ID = l.LOCAL_CODE)
WHERE BONUS IS NOT NULL;


-- 4. 부서코드가 D2인 직원들의 사원명, 직급명, 부서명, 근무지역명을 조회하시오.(3행)
SELECT
    e.EMP_NAME,
    j.JOB_NAME,
    d.DEPT_TITLE,
    l.LOCAL_NAME
FROM employee e
    JOIN job j on (e.JOB_CODE = j.JOB_CODE)
    JOIN department d ON (e.DEPT_CODE = d.DEPT_ID)
    JOIN location l ON (d.LOCATION_ID = l.LOCAL_CODE)
WHERE d.DEPT_ID = 'D2';

-- 5. 급여 테이블의 등급별 최소급여(MIN_SAL)보다 많이 받는 직원들의
-- 사원명, 직급명, 급여, 연봉을 조회하시오.
-- 연봉에 보너스포인트를 적용하시오.(20행)
SELECT
    e.EMP_NAME,
    j.JOB_NAME,
    e.SALARY,
    (e.SALARY * (1 + NVL(e.BONUS, 0)) * 12) AS 연봉
FROM employee e
    JOIN job j on(e.JOB_CODE = j.JOB_CODE)
    JOIN department d on (e.DEPT_CODE = d.DEPT_ID)
    JOIN sal_grade s on (e.SAL_LEVEL = s.SAL_LEVEL)
WHERE e.SALARY > s.MIN_SAL;


-- 6. 한국(KO)과 일본(JP)에 근무하는 직원들의
-- 사원명, 부서명, 지역명, 국가명을 조회하시오.(15행)
SELECT
    e.EMP_NAME,
    d.DEPT_TITLE,
    l.LOCAL_NAME,
    n.NATIONAL_NAME
FROM employee e
    JOIN job j on (e.JOB_CODE = j.JOB_CODE)
    JOIN department d ON (e.DEPT_CODE = d.DEPT_ID)
    JOIN location l ON (d.LOCATION_ID = l.LOCAL_CODE)
    JOIN national n ON (n.NATIONAL_CODE = l.NATIONAL_CODE)
WHERE n.NATIONAL_NAME IN ('한국', '일본');

-- 7. 보너스포인트가 없는 직원들 중에서 직급코드가 J4와 J7인 직원들의 사원명, 직급명, 급여를 조회하시오.
-- 단, join과 IN 사용할 것(8행)
SELECT
    e.EMP_NAME,
    j.JOB_NAME,
    e.SALARY
FROM
    employee e
    JOIN job j on (e.JOB_CODE = j.JOB_CODE)
WHERE e.BONUS IS NULL AND e.JOB_CODE IN ('J4', 'J7');


-- 8. 직급이 대리이면서 아시아 지역(ASIA1, ASIA2, ASIA3 모두 해당)에 근무하는 직원 조회(2행)
-- 사번(EMPLOYEE.EMP_ID), 이름(EMPLOYEE.EMP_NAME), 직급명(JOB.JOB_NAME), 부서명(DEPARTMENT.DEPT_TITLE),
-- 근무지역명(LOCATION.LOCAL_NAME), 급여(EMPLOYEE.SALARY)를 조회하시오.
-- (해당 컬럼을 찾고, 해당 컬럼을 지닌 테이블들을 찾고, 테이블들을 어떤 순서로 조인해야 하는지 고민하고 SQL문을 작성할 것)

SELECT
    e.EMP_ID,
    e.EMP_NAME,
    j.JOB_NAME,
    d.DEPT_TITLE,
    l.LOCAL_NAME,
    e.SALARY
FROM employee e
    JOIN department d ON (e.DEPT_CODE = d.DEPT_ID)
    JOIN job j ON (e.JOB_CODE = j.JOB_CODE)
    JOIN location l ON (d.LOCATION_ID = l.LOCAL_CODE)
WHERE j.JOB_NAME ='대리' AND l.LOCAL_NAME LIKE 'ASIA%';

-- 9. 각 부서별 평균 급여와 직원 수를 조회하시오. (NULL 급여는 제외)
-- 평균 급여가 높은 순으로 정렬하시오. (6행)
SELECT
    e.DEPT_CODE,
    AVG(E.SALARY) AS 평균급여,
    COUNT(*) AS 직원수
FROM employee e
    JOIN department d ON (e.DEPT_CODE = d.DEPT_ID)
WHERE
    e.SALARY IS NOT NULL
GROUP BY e.DEPT_CODE
ORDER BY 평균급여 DESC;


-- 10. 직원 중 보너스를 받는 직원들의 연봉 총합이 1억 원을
-- 초과하는 부서의 부서명과 연봉 총합을 조회하시오. (1행)

-- 보너스를 받는 직원만
SELECT
    d.DEPT_TITLE,
    SUM(e.SALARY * (1 + NVL(e.BONUS,0) ) * 12 ) AS 연봉합
    -- where에서 is not null 했으므로 NVL을 안해도 됨
FROM employee e
    JOIN department d ON (e.DEPT_CODE = d.DEPT_ID)
WHERE
    e.BONUS IS NOT NULL
GROUP BY d.DEPT_TITLE
HAVING SUM(e.SALARY * (1+NVL(e.BONUS,0) ) * 12 ) > 100000000;

-- 11. 국내 근무하는 직원들 중 평균 급여 이상을 받는
-- 직원들의 사원명, 급여, 부서명을 조회하시오. (서브쿼리 사용) (4행)

SELECT
    e.EMP_NAME,
    e.SALARY,
    d.DEPT_TITLE

FROM employee e
    JOIN department d ON (e.DEPT_CODE = d.DEPT_ID)
    JOIN location l ON (d.LOCATION_ID = l.LOCAL_CODE)
WHERE
    e.SALARY >=
    -- 직원 평균 급여 구하기
        (
        SELECT
            AVG(SALARY)
        FROM
            employee
        )
        AND l.NATIONAL_CODE = 'KO';


-- 12. 모든 부서의 부서명과 해당 부서에 소속된 직원 수를 조회하시오.
-- 직원이 없는 부서도 함께 표시하시오. (9행)
SELECT
    d.DEPT_ID,
    d.DEPT_TITLE,
    COUNT(e.EMP_ID) AS 직원수
     -- COUNT(*) 하면 직원 없는 부서가 NULL도 1로 침
FROM department d
    LEFT JOIN employee e ON (e.DEPT_CODE = d.DEPT_ID)
GROUP BY d.DEPT_ID,d.DEPT_TITLE
ORDER BY DEPT_TITLE;


-- 13. 차장(J4) 이상 직급을 가진 직원과 사원(J7) 직급을 가진
-- 직원들의 급여 합계를 비교하여 결과를 출력하시오. (SET OPERATOR 사용) (2행)

-- 차장이상 테이블
SELECT
    '차장 이상' AS 구분,
    SUM(SALARY) AS 급여합계
FROM employee e
JOIN job j ON (e.JOB_CODE = j.JOB_CODE)
WHERE j.JOB_CODE IN ('J1','J2','J3','J4')

UNION
-- 사원 테이블
SELECT
    '사원' AS 구분,
    SUM(SALARY) AS 급여합계
FROM employee e
JOIN job j ON (e.JOB_CODE = j.JOB_CODE)
WHERE j.JOB_CODE IN ('J7')