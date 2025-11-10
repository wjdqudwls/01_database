-- Q1. 부서별 직원 급여의 총합 중 가장 큰 액수를 출력하세요.
SELECT * FROM department;
SELECT * FROM employee;
SELECT * FROM job;
SELECT * FROM location;
SELECT * FROM national;
SELECT * FROM sal_grade;

SELECT
    SUM(E.SALARY)
FROM
    employee E
JOIN department D ON(E.DEPT_CODE = D.DEPT_ID)
GROUP BY
    D.DEPT_ID
ORDER BY
    SUM(E.SALARY) DESC
LIMIT 1;



-- Q2. 서브쿼리를 이용하여 영업부인 직원들의 사원번호, 직원명, 부서코드, 급여를 출력하세요.
-- 참고. 영업부인 직원은 부서명에 ‘영업’이 포함된 직원임
SELECT
    E.EMP_ID,
    E.EMP_NAME,
    E.DEPT_CODE,
    E.SALARY
FROM
    employee E
WHERE E.DEPT_CODE IN(SELECT DEPT_ID
                      FROM department
                      WHERE DEPT_TITLE LIKE '%영업%');


-- Q3. 서브쿼리와 JOIN을 이용하여 영업부인 직원들의 사원번호, 직원명, 부서명, 급여를 출력하세요
SELECT
    E1.EMP_ID,
    E1.EMP_NAME,
    D1.DEPT_TITLE,
    E1.SALARY
FROM
    employee E1
JOIN department D1 ON (E1.DEPT_CODE = D1.DEPT_ID)
WHERE E1.DEPT_CODE IN (SELECT E2.DEPT_CODE
                      FROM employee E2
                                JOIN department D2 ON (E2.DEPT_CODE = D2.DEPT_ID)
                      WHERE D2.DEPT_TITLE LIKE '%영업%'
                      );


-- Q4. Q4.
-- 1. JOIN을 이용하여 부서의 부서코드, 부서명, 해당 부서가 위치한 지역명, 국가명을 추출
-- 하는 쿼리를 작성하세요.
-- 2. 위 1에서 작성한 쿼리를 서브쿼리로 활용하여 모든 직원의 사원번호, 직원명, 급여, 부서
-- 명, (부서의) 국가명을 출력하세요.
-- 단, 국가명 내림차순으로 출력되도록 하세요


SELECT
    EMP_ID,
    EMP_NAME,
    SALARY,
    DEPT_TITLE,
    NATIONAL_NAME
FROM employee MAIN
JOIN (SELECT
            E.DEPT_CODE,
            D.DEPT_TITLE,
            L.LOCAL_NAME,
            N.NATIONAL_NAME
    FROM
        employee E
    JOIN department D ON (E.DEPT_CODE = D.DEPT_ID)
    JOIN location L ON (D.LOCATION_ID = L.LOCAL_CODE)
    JOIN national N ON (L.NATIONAL_CODE = N.NATIONAL_CODE)
    ) AS SUB
ON MAIN.DEPT_CODE = SUB.DEPT_CODE
ORDER BY NATIONAL_NAME DESC;


-- Q5.러시아에서 발발한 전쟁으로 인해 정신적 피해를 입은 직원들에게 위로금을 전달하려고 합니다.
-- 위로금은 각자의 급여에 해당 직원의 급여 등급에 해당하는 최소 금액을 더한 금액으로 정했습니다.
-- Q4에서 작성한 쿼리를 활용하여 해당 부서의 국가가 ‘러시아’인 직원들을 대상으로, 직원의
-- 사원번호, 직원명, 급여, 부서명, 국가명, 위로금을 출력하세요.
-- 단, 위로금 내림차순으로 출력되도록 하세요.

SELECT
    EMP_ID AS 사원번호,
    EMP_NAME AS 직원명,
    SALARY AS 급여,
    DEPT_TITLE AS 부서명,
    NATIONAL_NAME AS 국가명,
    SALARY + MIN_SAL AS 위로금
FROM employee MAIN
JOIN (SELECT
            E.DEPT_CODE,
            D.DEPT_TITLE,
            L.LOCAL_NAME,
            N.NATIONAL_NAME
    FROM
        employee E
    JOIN department D ON (E.DEPT_CODE = D.DEPT_ID)
    JOIN location L ON (D.LOCATION_ID = L.LOCAL_CODE)
    JOIN national N ON (L.NATIONAL_CODE = N.NATIONAL_CODE)
    ) AS SUB
ON MAIN.DEPT_CODE = SUB.DEPT_CODE
JOIN sal_grade S ON (MAIN.SAL_LEVEL = S.SAL_LEVEL)
WHERE
    NATIONAL_NAME = '러시아'
ORDER BY
    위로금 DESC;