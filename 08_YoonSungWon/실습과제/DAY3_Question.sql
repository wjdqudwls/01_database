-- Q1. 부서별 직원 급여의 총합 중 가장 큰 액수를 출력하세요.
    SELECT
        D.DEPT_TITLE AS '부서',
        SUM(E.SALARY) AS '급여 총합'
    FROM
        employee e
    JOIN
        department d ON (E.DEPT_CODE = D.DEPT_ID)
    GROUP BY
        E.DEPT_CODE
    ORDER BY
        SUM(E.SALARY) DESC
    LIMIT 1;


-- Q2. 서브쿼리를 이용하여 영업부인 직원들의 사원번호, 직원명, 부서코드, 급여를 출력하세요.
--      (참고. 영업부인 직원은 부서명에 '영업' 이 포함된 직원임
    SELECT
        EMP_ID,
        EMP_NAME,
        DEPT_CODE,
        SALARY
    FROM
        employee
    WHERE
        DEPT_CODE IN (SELECT DEPT_ID FROM department WHERE DEPT_TITLE LIKE '%영업%');


-- Q3. 서브쿼리와 JOIN 을 이용하여 영업부인 직원들의 사원번호, 직원명, 부서명, 급여를 출력하세요.
    SELECT
        e.EMP_ID,
        e.EMP_NAME,
        d.DEPT_TITLE,
        e.DEPT_CODE,
        e.SALARY
    FROM
        employee e
    JOIN (SELECT * FROM department WHERE DEPT_TITLE LIKE '%영업%') d ON (e.DEPT_CODE = d.DEPT_ID);


-- Q4. 1. JOIN을 이용하여 부서의 부서코드, 부서명, 해당 부서가 위치한 지역명, 국가명을 추출하는 쿼리를 작성하세요
    WITH deptInfo AS (
    SELECT
        d.DEPT_ID,
        d.DEPT_TITLE,
        l.LOCAL_NAME,
        n.NATIONAL_NAME
    FROM
        department d
    JOIN
        location l ON (d.LOCATION_ID = l.LOCAL_CODE)
    JOIN
        national n ON (l.NATIONAL_CODE = n.NATIONAL_CODE)
    )


--      2. 위 1에서 작성한 쿼리를 서브쿼리로 활용하여 모든 직원의 사원번호, 직원명, 급여, 부서명,(부서워) 국가명을 출력하세요.
--      단. 국가명 내림차순으로 출력하세요
    SELECT
        e.EMP_ID,
        e.EMP_NAME,
        e.SALARY,
        i.DEPT_TITLE,
        i.NATIONAL_NAME
    FROM
        employee e
    JOIN
        deptInfo i ON (e.DEPT_CODE = i.DEPT_ID)
    ORDER BY
        i.NATIONAL_NAME DESC;


-- Q5. 러시아에서 발발한 전쟁으로 인해 정신적 피해를 입은 직원들에게 위로금을 전달하려고 합니다.
--      위로금은 각자의 급여에 해당 직원의 급여 등급에 해당하는 최소 금액을 더한 금액으로 정했습니다.
--      Q4에서 작성한 쿼리를 활용하여 해당 부서의 국가가 '러시아'인 직원들을 대상으로, 직원의 사원번호,
--      직원명, 급여, 부서명, 국가명, 위로금을 출력하세요.
--      단 위로금 내림차순으로 출력되도록 하세요.

    WITH deptInfo AS (
    SELECT
        d.DEPT_ID,
        d.DEPT_TITLE,
        l.LOCAL_NAME,
        n.NATIONAL_NAME
    FROM
        department d
    JOIN
        location l ON (d.LOCATION_ID = l.LOCAL_CODE)
    JOIN
        national n ON (l.NATIONAL_CODE = n.NATIONAL_CODE)
    WHERE
        n.NATIONAL_NAME LIKE '%러시아%'
    )

#     위로금
    SELECT
        e.EMP_ID,
        e.EMP_NAME,
        e.SALARY,
        i.DEPT_TITLE,
        i.NATIONAL_NAME,
        (e.SALARY + s.MIN_SAL) AS '위로금'
    FROM
        employee e
    JOIN
        sal_grade s ON (e.SAL_LEVEL = s.SAL_LEVEL)
    JOIN
        deptInfo i ON (e.DEPT_CODE = i.DEPT_ID)
    ORDER BY
        `위로금` DESC;


