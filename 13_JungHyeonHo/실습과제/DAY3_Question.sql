# DAY3: QUESTION
# Q1.
# 부서별 직원 급여의 총합 중 가장 큰 액수를 출력하세요.
# 답안
SELECT D.DEPT_TITLE, SUM(E.SALARY)
FROM EMPLOYEE E
         JOIN DEPARTMENT D
              ON E.DEPT_CODE = D.DEPT_ID
GROUP BY E.DEPT_CODE
HAVING SUM(E.SALARY) =
       (SELECT /*D.DEPT_TITLE 부서명,*/TRUNCATE(SUM(E.SALARY), 0) 급여합
        FROM EMPLOYEE E
                 JOIN DEPARTMENT D ON E.DEPT_CODE = D.DEPT_ID
        GROUP BY E.DEPT_CODE
        ORDER BY SUM(E.SALARY) DESC
        LIMIT 1);

SELECT MAX((SELECT SUM(SALARY)
      FROM employee
      GROUP BY DEPT_CODE));

SELECT MAX(급여합)
FROM (SELECT /*D.DEPT_TITLE 부서명,*/TRUNCATE(SUM(E.SALARY), 0) 급여합
      FROM EMPLOYEE E
               JOIN DEPARTMENT D ON E.DEPT_CODE = D.DEPT_ID
      GROUP BY E.DEPT_CODE
      ORDER BY SUM(E.SALARY) DESC) AS SUM_SAL;

# Q2.
# 서브쿼리를 이용하여 영업부인 직원들의 사원번호, 직원명, 부서코드, 급여를 출력하세요.
# 참고. 영업부인 직원은 부서명에 ‘영업’이 포함된 직원임
# 답안
SELECT E.EMP_NO, E.EMP_NAME, E.DEPT_CODE, E.SALARY
FROM EMPLOYEE E
WHERE E.EMP_NO IN (SELECT EMP_NO
                   FROM EMPLOYEE E
                            JOIN DEPARTMENT D ON E.DEPT_CODE = D.DEPT_ID
                   WHERE D.DEPT_TITLE LIKE '%영업%');
# Q3.
# 서브쿼리와 JOIN을 이용하여 영업부인 직원들의 사원번호, 직원명, 부서명, 급여를 출력하
# 세요.
# 답안
SELECT E.EMP_NO, E.EMP_NAME, 영업부.DEPT_TITLE, E.SALARY
FROM EMPLOYEE E
         JOIN
     (SELECT E.EMP_NO, D.DEPT_TITLE
      FROM EMPLOYEE E
               JOIN DEPARTMENT D ON E.DEPT_CODE = D.DEPT_ID
      WHERE D.DEPT_TITLE LIKE '%영업%') 영업부
     ON E.EMP_NO = 영업부.EMP_NO;
# Q4.
# 1. JOIN을 이용하여 부서의 부서코드, 부서명, 해당 부서가 위치한 지역명, 국가명을 추출
# 하는 쿼리를 작성하세요.
SELECT D.DEPT_ID 부서코드, D.DEPT_TITLE 부서명, L.LOCAL_NAME 지역명, N.NATIONAL_NAME 국가명
FROM DEPARTMENT D
         JOIN LOCATION L ON D.LOCATION_ID = L.LOCAL_CODE
         JOIN NATIONAL N ON L.NATIONAL_CODE = N.NATIONAL_CODE;
# 2. 위 1에서 작성한 쿼리를 서브쿼리로 활용하여 모든 직원의 사원번호, 직원명, 급여, 부서명,
# (부서의) 국가명을 출력하세요.
# 단, 국가명 내림차순으로 출력되도록 하세요.
# 답
SELECT E.EMP_NO 사원번호, E.EMP_NAME 직원명, E.SALARY 급여, DLN.부서명, DLN.국가명
FROM EMPLOYEE E
         LEFT JOIN
     (SELECT D.DEPT_ID 부서코드, D.DEPT_TITLE 부서명, L.LOCAL_NAME 지역명, N.NATIONAL_NAME 국가명
      FROM DEPARTMENT D
               JOIN LOCATION L ON D.LOCATION_ID = L.LOCAL_CODE
               JOIN NATIONAL N ON L.NATIONAL_CODE = N.NATIONAL_CODE) AS DLN
     ON E.DEPT_CODE = DLN.부서코드
ORDER BY DLN.국가명 DESC;

# Q5.
# 러시아에서 발발한 전쟁으로 인해 정신적 피해를 입은 직원들에게 위로금을 전달하려고 합니다.
# 위로금은 각자의 급여에
# 해당 직원의 급여 등급에 해당하는
# 최소 금액을 더한 금액으로 정했습니다.
# Q4에서 작성한 쿼리를 활용하여 해당 부서의 국가가 ‘러시아’인 직원들을 대상으로, 직원의
# 사원번호, 직원명, 급여, 부서명, 국가명, 위로금을 출력하세요.
# 단, 위로금 내림차순으로 출력되도록 하세요.
# 답안
SELECT E.EMP_NO 사원번호, E.EMP_NAME 직원명, E.SALARY 급여, DLN.부서명, DLN.국가명,
       E.SALARY + S.MIN_SAL 위로금
FROM EMPLOYEE E
         JOIN
     (SELECT D.DEPT_ID 부서코드, D.DEPT_TITLE 부서명, L.LOCAL_NAME 지역명, N.NATIONAL_NAME 국가명
      FROM DEPARTMENT D
               JOIN LOCATION L ON D.LOCATION_ID = L.LOCAL_CODE
               JOIN NATIONAL N ON L.NATIONAL_CODE = N.NATIONAL_CODE) AS DLN
     ON E.DEPT_CODE = DLN.부서코드
         JOIN sal_grade S
              ON E.SAL_LEVEL = S.SAL_LEVEL
WHERE DLN.국가명 = '러시아'
ORDER BY 위로금 DESC;