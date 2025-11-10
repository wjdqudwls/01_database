-- Q1
-- 부서별 직원 급여의 총합 중 가장 큰 액수를 출력하세요.
SELECT SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY SUM(SALARY) DESC
LIMIT 1;

-- Q2
-- 서브쿼리를 이용하여 영업부인 직원들의 사원번호, 직원명, 부서코드, 급여를 출력하세요.
-- (참고) 영업부인 직원은 부서명에 ‘영업’이 포함된 직원임
SELECT E.EMP_ID 사원번호, E.EMP_NAME 이름, E.DEPT_CODE 부서코드, E.SALARY 급여
FROM EMPLOYEE E
WHERE E.DEPT_CODE IN (SELECT DEPT_ID
                    FROM DEPARTMENT
                    WHERE DEPT_TITLE LIKE '%영업%');

-- Q3
-- 서브쿼리와 JOIN을 이용하여 영업부인 직원들의 사원번호, 직원명, 부서명, 급여를 출력하세요.
SELECT E.EMP_ID 사원번호, E.EMP_NAME 이름, E.DEPT_CODE 부서코드, E.SALARY 급여
FROM EMPLOYEE E
JOIN DEPARTMENT D ON E.DEPT_CODE = D.DEPT_ID
WHERE D.DEPT_ID IN (SELECT DEPT_ID
                    FROM DEPARTMENT
                    WHERE DEPT_TITLE LIKE '%영업%');

-- Q4
-- 1. JOIN을 이용하여 부서의 부서코드, 부서명, 해당 부서가 위치한 지역명, 국가명을 추출하는 쿼리를 작성하세요.
-- 2. 위 1에서 작성한 쿼리를 서브쿼리로 활용하여 모든 직원의 사원번호, 직원명, 급여, 부서명, (부서의) 국가명을 출력하세요.
-- 단, 국가명 내림차순으로 출력되도록 하세요.
SELECT E.EMP_ID 사원번호, E.EMP_NAME 직원명, 부서코드, 부서명, 지역명, 국가명
FROM EMPLOYEE E
JOIN (SELECT D.DEPT_ID 부서코드, D.DEPT_TITLE 부서명, L.LOCAL_NAME 지역명, N.NATIONAL_NAME 국가명
      FROM DEPARTMENT D
      JOIN LOCATION L ON D.LOCATION_ID = L.LOCAL_CODE
      JOIN NATIONAL N ON L.NATIONAL_CODE = N.NATIONAL_CODE) T ON E.DEPT_CODE = T.부서코드
ORDER BY 국가명 DESC;

SELECT D.DEPT_ID 부서코드, D.DEPT_TITLE 부서명, L.LOCAL_NAME 지역명, N.NATIONAL_NAME 국가명
FROM DEPARTMENT D
JOIN LOCATION L ON D.LOCATION_ID = L.LOCAL_CODE
JOIN NATIONAL N ON L.NATIONAL_CODE = N.NATIONAL_CODE;


-- Q5
/*
러시아에서 발발한 전쟁으로 인해 정신적 피해를 입은 직원들에게 위로금을 전달하려고 합니다.
위로금은 "각자의 급여에 해당 직원의 급여 등급에 해당하는 최소 금액"을 더한 금액으로정했습니다.
Q4 에서 작성한 쿼리를 활용하여 해당 부서의 국가가 ‘러시아’인 직원들을 대상으로,
직원의 사원번호, 직원명, 급여, 부서명, 국가명, 위로금을 출력하세요.
단, 위로금 내림차순으로 출력되도록 하세요.
*/

SELECT E.EMP_ID 사원번호, E.EMP_NAME 직원명, E.SALARY 급여, T.부서명, T.국가명, (E.SALARY + S.MIN_SAL) 위로금
FROM EMPLOYEE E
JOIN SAL_GRADE S ON E.SAL_LEVEL = S.SAL_LEVEL
JOIN (SELECT D.DEPT_ID 부서코드, D.DEPT_TITLE 부서명, L.LOCAL_NAME 지역명, N.NATIONAL_NAME 국가명
      FROM DEPARTMENT D
      JOIN LOCATION L ON D.LOCATION_ID = L.LOCAL_CODE
      JOIN NATIONAL N ON L.NATIONAL_CODE = N.NATIONAL_CODE) T ON E.DEPT_CODE = T.부서코드
WHERE T.국가명 LIKE '러시아'
ORDER BY 위로금 DESC;

SELECT (E.SALARY + S.MIN_SAL) 위로금
FROM EMPLOYEE E
JOIN SAL_GRADE S ON E.SAL_LEVEL = S.SAL_LEVEL;