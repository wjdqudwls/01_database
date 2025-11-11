SHOW TABLES;

SELECT *
FROM DEPARTMENT;
SELECT *
FROM EMPLOYEE;
SELECT *
FROM JOB;
SELECT *
FROM LOCATION;
SELECT *
FROM NATIONAL;
SELECT *
FROM SAL_GRADE;

/* Q1. 부서별 직원 급여의 총합 중 가장 큰 액수를 출력하세요. */

SELECT MAX(e.SALARY)
FROM EMPLOYEE E
         JOIN DEPARTMENT D ON (d.DEPT_ID = e.DEPT_CODE)
GROUP BY d.DEPT_TITLE
ORDER BY MAX(e.SALARY) DESC
LIMIT 1;

/* Q2. 서브쿼리를 이용하여 영업부인 직원들의 사원번호, 직원명, 부서코드, 급여를 출력하세요.
   참고. 영업부인 직원은 부서명에 '영업'이 포함된 직원임 */

SELECT E.EMP_ID    AS 사원번호
     , E.EMP_NAME  AS 직원명
     , E.DEPT_CODE AS 부서코드
     , E.SALARY    AS 급여
FROM EMPLOYEE E
WHERE E.DEPT_CODE IN (SELECT D.DEPT_ID
                      FROM DEPARTMENT D
                      WHERE DEPT_TITLE LIKE '%영업%');

/* Q3. 서브쿼리와 JOIN을 이용하여 영업부인 직원들의 사원번호, 직원명, 부서명, 급여를 출력하세요. */
SELECT E.EMP_ID      AS '사원번호'
     , E.EMP_NAME    AS '직원명'
     , ED.DEPT_TITLE AS '부서명'
     , E.SALARY      AS '급여'
FROM EMPLOYEE E
         JOIN (SELECT d.DEPT_TITLE
                    , D.DEPT_ID
               FROM DEPARTMENT D
               WHERE d.DEPT_TITLE LIKE '%영업%') AS ED
              ON ED.DEPT_ID = E.DEPT_CODE;

/* Q4. 1. JOIN을 이용하여 부서의 부서코드, 부서명, 해당 부서가 위치한 지역명, 국가명을 추출하는 쿼리를 작성하세요.
       2. 위 1에서 작성한 쿼리를 서브쿼리로 활용하여 모든 직원의 사원번호, 직원명, 급여, 부서명, (부서의) 국가명을 출력하세요.
   단, 국가명 내림차순으로 출력되도록 하세요. */


SELECT E.EMP_ID   AS '사원번호'
     , E.EMP_NAME AS '직원명'
     , E.SALARY   AS '급여'
     , DLN.부서명
     , DLN.국가명
FROM EMPLOYEE E
         JOIN (SELECT D.DEPT_ID     AS '부서코드'
                    , D.DEPT_TITLE  AS '부서명'
                    , LOCAL_NAME    AS '지역명'
                    , NATIONAL_NAME AS '국가명'
               FROM DEPARTMENT D
                        JOIN LOCATION L ON D.LOCATION_ID = L.LOCAL_CODE
                        JOIN NATIONAL N ON N.NATIONAL_CODE = L.NATIONAL_CODE)
    AS DLN
              ON DLN.부서코드 = E.DEPT_code
ORDER BY DLN.국가명 DESC;


/* Q5. 러시아에서 발발한 전쟁으로 인해 정신적 피해를 입은 직원들에게 위로금을 전달하려고 합니다. 위로금은 각자의 급여에
   해당 직원의 급여 등급에 해당하는 최소 금액을 더한 금액으로 정해졌습니다.

   Q4에서 작성한 쿼리를 활용하여 해당 부서의 국가가 '러시아'인 직원들을 대상으로, 직원의 사원번호, 직원명, 급여, 부서명, 국가명, 위로금을 출력하ㅔㅅ요.
   단, 위로금 내림차순으로 출력되도록 하세요.

*/

SELECT E.EMP_ID             AS '사원번호'
     , E.EMP_NAME           AS '직원명'
     , E.SALARY             AS '급여'
     , DLN.부서명
     , DLN.국가명
     , E.SALARY + G.MIN_SAL AS '위로금'
FROM EMPLOYEE E
         JOIN (SELECT D.DEPT_ID     AS '부서코드'
                    , D.DEPT_TITLE  AS '부서명'
                    , LOCAL_NAME    AS '지역명'
                    , NATIONAL_NAME AS '국가명'
               FROM DEPARTMENT D
                        JOIN LOCATION L ON D.LOCATION_ID = L.LOCAL_CODE
                        JOIN NATIONAL N ON N.NATIONAL_CODE = L.NATIONAL_CODE)
    AS DLN
              ON DLN.부서코드 = E.DEPT_code
         JOIN SAL_GRADE G ON G.SAL_LEVEL = E.SAL_LEVEL
WHERE DLN.국가명 LIKE '%러시아%'
ORDER BY `위로금` DESC;
