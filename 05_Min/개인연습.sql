SELECT
    *
FROM
    employee;

-- 💥문제 1️⃣

-- 각 사원의 급여가 자신과 같은 직급(JOB_CODE)을 가진 사원들의 평균 급여보다 높은 사원만 조회하시오.
-- 조회 컬럼: EMP_NAME, JOB_CODE, SALARY

SELECT
    EMP_NAME,DEPT_CODE,SALARY
FROM
    employee e
WHERE
    e.salary > (
    SELECT
        AVG(e2.salary)
    FROM
        employee e2
    WHERE e.JOB_CODE = e2.JOB_CODE
    );


-- 💥문제 2️⃣

-- 자신의 부서 평균 보너스보다 보너스를 더 많이 받는 사원의 이름, 부서코드, 보너스를 조회하시오.
-- (단, 보너스가 NULL이 아닌 사원만 비교)
SELECT
    EMP_NAME,DEPT_CODE,BONUS
FROM
    employee e
WHERE
    e.BONUS > (
        SELECT
            AVG(e2.bonus)
        FROM
            employee e2
        WHERE
            e.DEPT_CODE = e2.DEPT_CODE
    );
-- 💥문제 3️⃣

-- 자신과 같은 지역(LOCATION_ID)에 속한 부서들의 평균 급여보다 높은 급여를 받는 사원의 이름, 급여, 근무 지역명을 조회하시오.
-- (힌트: employee → department → location 순으로 JOIN 후,
-- 서브쿼리 안에서도 location_id 기준으로 비교)
SELECT
    EMP_NAME,SALARY
FROM
    employee e JOIN
        department d ON e.DEPT_CODE = d.DEPT_ID

-- 각 부서에서 가장 먼저 입사한(입사일이 가장 빠른) 사원의 이름, 입사일, 부서명을 조회하시오.
-- (힌트: WHERE e.HIRE_DATE = (SELECT MIN(e2.HIRE_DATE) FROM employee e2 WHERE e2.DEPT_CODE = e.DEPT_CODE))

-- 💥문제 5️⃣

-- 자신의 급여가 전체 평균 급여보다 높고, 동시에 자기 부서의 평균 급여보다도 높은 사원을 조회하시오.
-- 조회 컬럼: EMP_NAME, DEPT_CODE, SALARY
-- (힌트: 서브쿼리 2개를 써야 함 — 하나는 전체 평균, 하나는 부서별 평균)
