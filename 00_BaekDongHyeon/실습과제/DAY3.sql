-- Q1. 부서별 직원 급여의 총합 중 가장 큰 액수를 출력하세요.


-- Q2. 서브쿼리를 이용하여 영업부인 직원들의 사원번호, 직원명, 부서코드, 급여를 출력하세요.
--     참고. 영업부인 직원은 부서명에 '영업'이 포함된 직업임


-- Q3. 서브쿼리와 JOIN을 이용하여 영업부인 직원들의 사원번호, 직원명, 부서명, 급여를 출력하세요.


-- Q4.
-- 1. JOIN을 이용하여 부서의 부서코드, 부서명, 해당 부서가 위치한 지역명, 국가명을 추출하는 쿼리를 작성하세요.
-- 2. 위 1에서 작성한 쿼리를 서브쿼리로 활용하여 모든 직원의 사원번호, 직원명, 급여, 부서명, (부서의)국가명을 출력하세요.
--    단, 국가명 내림차순으로 출력되도록 하세요.
SELECT E.EMP_ID, E.EMP_NAME, E.SALARY, DLN.DEPT_TITLE, DLN.NATIONAL_NAME
FROM EMPLOYEE E
         JOIN (SELECT D.DEPT_ID, D.DEPT_TITLE, N.NATIONAL_NAME
               FROM DEPARTMENT D
                        JOIN LOCATION L ON (D.LOCATION_ID = L.LOCAL_CODE)
                        JOIN NATIONAL N ON (L.NATIONAL_CODE = N.NATIONAL_CODE)) DLN ON E.DEPT_CODE = DLN.DEPT_ID
ORDER BY DLN.NATIONAL_NAME DESC;



-- Q5.
-- 러시아에서 발발한 전쟁으로 인해 정신적 피해를 입은 직원들에게 위로금을 전달하려고 합니다.
-- 위로금은 각자의 급여에 해당 직원의 급여 등급에 해당하는 최소 금액을 더한 금액으로 정했습니다.
-- Q4에서 작성한 쿼리를 활용하여 해당 부서의 국가가 ‘러시아’인 직원들을 대상으로,
--  직원의 사원번호, 직원명, 급여, 부서명, 국가명, 위로금을 출력하세요.
-- 단, 위로금 내림차순으로 출력되도록 하세요.

SELECT
    E.EMP_ID AS '사원번호',
    E.EMP_NAME AS '직원명',
    E.SALARY AS '급여',
    DLN.DEPT_TITLE AS '부서명',
    DLN.NATIONAL_NAME AS '국가명',
    E.SALARY + S.MIN_SAL AS '위로금'
FROM
    EMPLOYEE E
JOIN (
    SELECT D.DEPT_ID, D.DEPT_TITLE, N.NATIONAL_NAME
    FROM DEPARTMENT D
    JOIN LOCATION L ON (D.LOCATION_ID = L.LOCAL_CODE)
    JOIN NATIONAL N ON (L.NATIONAL_CODE = N.NATIONAL_CODE)
) DLN ON E.DEPT_CODE = DLN.DEPT_ID
JOIN
    sal_grade S ON (E.SAL_LEVEL = S.SAL_LEVEL)
WHERE
    DLN.NATIONAL_NAME = '러시아'
ORDER BY `위로금` DESC;


select * from sal_grade;