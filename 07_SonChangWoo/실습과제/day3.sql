SELECT * FROM employee;
SELECT * FROM department;
SELECT * FROM location;
SELECT * FROM sal_grade;
SELECT * FROM national;

-- 부서별 직원 급여의 총합 중 가장 큰 액수를 출력하세요
SELECT MAX(A.TOTAL_SALARY) AS `부셔별 직원 급여의 총합`
FROM (SELECT DEPT_CODE, SUM(SALARY) AS TOTAL_SALARY
FROM employee
WHERE DEPT_CODE IS NOT NULL
GROUP BY DEPT_CODE) A;

-- 서브쿼리를 이용하여 영업부인 직원들의 사원 번호, 직원명, 부서코드, 급여를 출력하세요.
-- 참고. 영업부인 직원은 부서명에 ‘영업’이 포함된 직원임
SELECT B.EMP_ID, B.EMP_NAME, B.DEPT_CODE, B.SALARY
FROM (SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
      FROM employee E
          JOIN department D ON E.DEPT_CODE = D.DEPT_ID
      WHERE D.DEPT_TITLE LIKE '%영업%'
      )AS B;

-- 서브쿼리와 JOIN을 이용하여 영업부인 직원들의 사원번호, 직원명, 부서명, 급여를 출력하세요.
SELECT B.EMP_ID, B.EMP_NAME, B.DEPT_TITLE, B.SALARY
FROM (SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY
      FROM employee E
          JOIN department D ON E.DEPT_CODE = D.DEPT_ID
      WHERE D.DEPT_TITLE LIKE '%영업%'
      )AS B;

/*
1. JOIN을 이용하여 부서의 부서코드, 부서명, 해당 부서가 위치한 지역명, 국가명을 추출하는 쿼리를 작성하세요.
2. 위 1에서 작성한 쿼리를 서브쿼리로 활용하여 모든 직원의
사원번호, 직원명, 급여, 부서명, (부서의) 국가명을 출력하세요.
단, 국가명 내림차순으로 출력되도록 하세요.
*/
SELECT B.DEPT_ID, B.DEPT_TITLE, B.LOCAL_NAME, B.NATIONAL_NAME
FROM (SELECT DEPT_ID, DEPT_TITLE, LOCAL_NAME, NATIONAL_NAME
      FROM location L
          JOIN department D ON L.LOCAL_CODE = D.LOCATION_ID
          JOIN national N ON L.NATIONAL_CODE = N.NATIONAL_CODE
      )AS B;



SELECT EMP_ID, EMP_NAME, SALARY, DEPT_TITLE, LOCAL_NAME, NATIONAL_CODE
FROM employee E
    JOIN (SELECT DEPT_ID, DEPT_TITLE, LOCAL_NAME, NATIONAL_CODE
                      FROM location L
                          JOIN department D ON L.LOCAL_CODE = D.LOCATION_ID)AS B
    ON (E.DEPT_CODE = B.DEPT_ID)
ORDER BY NATIONAL_CODE DESC;

/*
러시아에서 발발한 전쟁으로 인해 정신적 피해를 입은 직원들에게 위로금을 전달하려고 합니다.
위로금은 각자의 급여에 해당 직원의 급여 등급에 해당하는 최소 금액을 더한 금액으로
정했습니다.Q4에서 작성한 쿼리를 활용하여 해당 부서의 국가가 ‘러시아’인 직원들을 대상으로,
직원의 사원번호, 직원명, 급여, 부서명, 국가명, 위로금을 출력하세요.
단, 위로금 내림차순으로 출력되도록 하세요.
*/

SELECT EMP_ID, EMP_NAME, SALARY, DEPT_TITLE, NATIONAL_NAME, '위로금'
FROM employee E
    JOIN sal_grade S_G ON E.SAL_LEVEL = S_G.SAL_LEVEL
    JOIN (SELECT DEPT_ID, DEPT_TITLE, LOCAL_NAME, NATIONAL_CODE
                      FROM location L
                          JOIN department D
                              ON L.LOCAL_CODE = D.LOCATION_ID
                      WHERE L.NATIONAL_CODE = 'RU')AS B
    ON (E.DEPT_CODE = B.DEPT_ID)
    JOIN national N ON (B.NATIONAL_CODE = N.NATIONAL_CODE)
ORDER BY '위로금' DESC;
