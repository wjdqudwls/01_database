/*  Q1.부서별 직원 급여의 총합 중 가장 큰 액수를 출력하세요.  */
SELECT
    DEPT_TITLE,
    SUM(SALARY)
FROM employee e
JOIN department d ON (DEPT_CODE = DEPT_ID)
GROUP BY d.DEPT_TITLE
ORDER BY SUM(e.SALARY) DESC
LIMIT 1;

-- HAVING SUM(SALARY) 는 그냥 조건없이 구문만 적어놓


    d.DEPT_TITLE,
    SUM(e.SALARY)
FROM employee e
JOIN department d ON (e.DEPT_CODE = d.DEPT_ID)
GROUP BY d.DEPT_TITLE
HAVING SUM(e.SALARY)
ORDER BY SUM(e.SALARY) DESC
LIMIT 1;

/*
SELECT
     d.DEPT_TITLE `부서명`,
   --  MAX( e1.DEPT_CODE ),
     MAX( e1.ms ) `최대 급여`
FROM (SELECT
        e.DEPT_CODE,
        SUM(e.SALARY) ms
    FROM employee e
    GROUP BY e.DEPT_CODE ) e1
JOIN department d
      ON e1.DEPT_CODE = d.DEPT_ID
 GROUP BY d.DEPT_TITLE
ORDER BY MAX( e1.ms ) desc
 limit 1
;
*/



/*  Q2.
    서브쿼리를 이용하여 영업부인 직원들의 사원번호, 직원명, 부서코드, 급여를 출력하세요.
    참고. 영업부인 직원은 부서명에 ‘영업’이 포함된 직원임*/

SELECT
    `사원번호`,`직원명`,`부서코드`,`급여`
FROM    (
        SELECT
            e.EMP_ID `사원번호`,
            e.EMP_NAME `직원명`,
            e.DEPT_CODE `부서코드`,
            e.SALARY `급여`
        FROM employee e
        WHERE e.DEPT_CODE = 'D5'
            or e.DEPT_CODE = 'D6'
            or e.DEPT_CODE = 'D7'
        ) AS `영업부`;


/*  Q3.
    서브쿼리와 JOIN을 이용하여 영업부인 직원들의 사원번호, 직원명, 부서명, 급여를 출력하세요.
*/
SELECT
    `사원번호`,`직원명`,`부서명`,`급여`
FROM(
        SELECT
        d.DEPT_TITLE `부서명`,
        e.EMP_ID `사원번호`,
        e.EMP_NAME `직원명`,
        e.SALARY `급여`
        FROM employee e
        JOIN department d ON(e.DEPT_CODE = d.DEPT_ID)
        WHERE d.DEPT_TITLE LIKE '%영업%'
        ) AS `영업부`;



/*  Q4.
    1. JOIN을 이용하여 부서의 부서코드, 부서명, 해당 부서가 위치한 지역명, 국가명을 추출
    하는 쿼리를 작성하세요.
 */
SELECT
    e.DEPT_CODE,
    d.DEPT_TITLE,
    l.LOCAL_NAME,
    l.NATIONAL_CODE
FROM employee e
JOIN department d ON (e.DEPT_CODE = d.DEPT_ID)
JOIN location l ON (d.LOCATION_ID = l.LOCAL_CODE);


 /*
    2. 위 1에서 작성한 쿼리를 서브쿼리로 활용하여 모든 직원의 사원번호, 직원명, 급여, 부서
    명, (부서의) 국가명을 출력하세요.
    단, 국가명 내림차순으로 출력되도록 하세요.
  */

SELECT
    `사원번호`, `직원명`, `급여`, `부서명` , n.NATIONAL_NAME `국가명`
FROM (SELECT e.EMP_ID     `사원번호`,
             e.EMP_NAME   `직원명`,
             e.SALARY     `급여`,
             d.DEPT_TITLE `부서명`,
             d.LOCATION_ID `지역코드`
      FROM employee e
               JOIN department d ON (e.DEPT_CODE = d.DEPT_ID)
      )AS `직원정보`
JOIN location l ON (직원정보.지역코드 = l.LOCAL_CODE)
JOIN national n ON (l.NATIONAL_CODE = n.NATIONAL_CODE)
ORDER BY `국가명` DESC;



/*
  DAY3: Question 2
    Q5.
    러시아에서 발발한 전쟁으로 인해 정신적 피해를 입은 직원들에게 위로금을 전달하려고 합
    니다. 위로금은 각자의 급여에 해당 직원의 급여 등급에 해당하는 최소 금액을 더한 금액으로
    정했습니다.
    Q4에서 작성한 쿼리를 활용하여 해당 부서의 국가가 ‘러시아’인 직원들을 대상으로, 직원의
    사원번호, 직원명, 급여, 부서명, 국가명, 위로금을 출력하세요.
    단, 위로금 내림차순으로 출력되도록 하세요.
 */
 -- 위로금 : 급여 + 급여 등급에 해당하는 최소금액
SELECT
    e.EMP_ID '사원번호',
    e.EMP_NAME '사원명',
    e.SALARY '급여',
    d.DEPT_TITLE '부서명',
    n.NATIONAL_NAME '국가명',
    e.SALARY + s.MIN_SAL '위로금'
FROM employee e
JOIN department d ON(e.DEPT_CODE = d.DEPT_ID)
JOIN location l ON(d.LOCATION_ID = l.LOCAL_CODE)
JOIN national n ON(l.NATIONAL_CODE = n.NATIONAL_CODE)
JOIN sal_grade s ON(e.SAL_LEVEL = s.SAL_LEVEL)
WHERE n.NATIONAL_NAME = '러시아'
ORDER BY 위로금 DESC;






