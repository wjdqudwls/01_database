    SELECT * FROM employee;
    SELECT * FROM department;
    SELECT * FROM job;
    SELECT * FROM location;
    SELECT * FROM sal_grade;
    SELECT * FROM national;



1_부서별 직원 급여의 총합 중 가장 큰 액수를 출력하세요


    SELECT
        SALARY AS "급여",
        DEPT_TITLE AS "부서"
    FROM
        employee E
    JOIN
            department D ON E.DEPT_CODE = D.DEPT_ID
    GROUP BY
        D.DEPT_TITLE
    ORDER BY
        AVG(SALARY)DESC
    LIMIT 1;


2_ 서브쿼리를 이용하여 영업부인 직원들의 사원번호, 작원명, 부서코드, 급여를 출력하세요




   SELECT
       EMP_NO AS '사원번호',
       EMP_NAME AS '직원명',
       DEPT_CODE AS '부서코드',
       SALARY AS '급여'
   FROM
       employee E
--   JOIN
--           department D ON (DEPT_CODE = EMP_ID)
    WHERE
        DEPT_CODE IN (
                SELECT
                    DEPT_ID
                FROM
                    department D
                WHERE
                    DEPT_TITLE LIKE '%영업%'
                );

SELECT
    E.EMP_NO AS '사원번호',
    E.EMP_NAME AS '직원명',
    D.DEPT_TITLE AS '부서명',
    E.SALARY AS '급여'
FROM
    employee E
JOIN
    department D ON E.DEPT_CODE = D.DEPT_ID -- (E.DEPT_CODE = D.DEPT_ID)
WHERE
    D.DEPT_TITLE LIKE '%영업%'; -- 부분 검색, %를 포함한 검색


3_ 서브쿼리와 JOIN을 이용하여 영업부인 직원들의 사원번호, 직원명 ,부서명 ,급여를
   출력하시오

     SELECT
       EMP_NO AS '사원번호',
       EMP_NAME AS '직원명',
       DEPT_CODE AS '부서코드',
       SALARY AS '급여'
   FROM
       employee E
   JOIN
        department D ON E.DEPT_CODE = D.DEPT_ID
    WHERE
        DEPT_CODE IN ( -- = 은 한가지 값만 비교 가능
                SELECT
                    DEPT_ID
                FROM
                    department
                WHERE
                    DEPT_TITLE LIKE '%영업%'
                                  );
#
# 4_
#     1. JOIN을 이용하여 부서의 부서코드, 부서명, 해당 부서가 위치한 지역명,
#     국가명을 추출하는 쿼리를 작성하세요

#     2. 위 1에서 작성한 쿼리를 서브쿼리로 활용하여 모든 직원의 사원번호, 직원명,
#     급여, 부서명, (부서의)국가명을 출력하세요
#     단, 국가명 내림차순으로 출력하세요

    SELECT * FROM employee;
    SELECT * FROM department;
    SELECT * FROM job;
    SELECT * FROM location;
    SELECT * FROM sal_grade;
    SELECT * FROM national;

-- 1
SELECT
    D.DEPT_ID AS '부서코드',
    D.DEPT_TITLE AS '부서명',
    L.LOCAL_NAME AS '지역명',
    N.NATIONAL_NAME AS '국가명'
FROM
    department D
JOIN -- 부서코드, 부서명 은 DEPARTMENT D에 있으니 지역명, 국가명을 찾아야한다
    location L
        ON D.LOCATION_ID = L.LOCAL_CODE
JOIN
    national N
        ON L.NATIONAL_CODE = N.NATIONAL_CODE;

-- 2
    SELECT
        DEPT_ID,
        DEPT_TITLE,
        LOCAL_NAME,
        NATIONAL_NAME
    FROM
        employee E
        JOIN
      --          employee IN
       (
            SELECT
             D.DEPT_ID,
             D.DEPT_TITLE,
              L.LOCAL_NAME,
              N.NATIONAL_NAME
FROM
    department D
JOIN -- 부서코드, 부서명 은 DEPARTMENT D에 있으니 지역명, 국가명을 찾아야한다
    location L
        ON D.LOCATION_ID = L.LOCAL_CODE
JOIN
    national N
        ON L.NATIONAL_CODE = N.NATIONAL_CODE
            ) SUB
    ORDER BY
        SUB.NATIONAL_NAME DESC;


















/*-- 1
SELECT
    DEPT_ID,
    DEPT_TITLE,
    LOCAL_NAME,
    NATIONAL_NAME
FROM
    department D
JOIN
    location L
        ON D.LOCATION_ID = L.LOCAL_CODE
JOIN
    national N
        ON L.NATIONAL_CODE = N.NATIONAL_CODE;


-- 2
SELECT E.EMP_ID,
  E.EMP_NAME,
  E.SALARY,
  SUB.DEPT_TITLE,
  SUB.NATIONAL_NAME
FROM
    employee E
JOIN
    (
    SELECT
        DEPT_ID,
        DEPT_TITLE,
        LOCAL_NAME,
        NATIONAL_NAME
    FROM
        department D
    JOIN
        location L
            ON D.LOCATION_ID = L.LOCAL_CODE
    JOIN
        national N
            ON L.NATIONAL_CODE = N.NATIONAL_CODE
    ) SUB
ON E.DEPT_CODE = SUB.DEPT_ID
ORDER BY
    SUB.NATIONAL_NAME DESC;
*/

/*   -- 서브쿼리를 테이블표처럼 쓰려고
     JOIN에 넣어서 테이블로 만든다
 WHERE
        DEPT_CODE IN (
            SELECT
                E.DEPT_CODE,
                DEPT_TITLE,
                LOCAL_NAME,
                NATIONAL_NAME
            FROM
                employee E
            WHERE
                DEPT_TITLE
            )
    ORDER BY
        NATIONAL_CODE DESC;
*/


# 05.
/*러시아에서 발발한 전쟁으로 인해 정신적 피해를 입은 직원들에게 위로금을 전달하려고 합니다
      위로금은 각자의 급영에 해당 직원의 급여 등급에 해당하는 최소 금액을 더한 금액으로 정했습니다

  Q4에서 작성한 쿼리를 활용하여 해당 부서의 국가가 '러시아'인 직원들을 대상으로, 직원의
      사원번호, 직원명, 급여, 부서명, 국가명, 위로금을 출력하세요

      단, 위로금 내림차순으로 출력되도록 하세요*/
    SELECT * FROM employee;
    SELECT * FROM department;
    SELECT * FROM job;
    SELECT * FROM location;
    SELECT * FROM sal_grade;
    SELECT * FROM national;


SELECT
    E.EMP_ID AS '사원번호',
    E.EMP_NAME AS '직원명',
    D.DEPT_TITLE AS '급여',
--   E.BONUS AS '위로금',
    N.NATIONAL_NAME AS '국가명',
    S.MIN_SAL + E.SALARY AS '위로금' -- 풀이에 추가
FROM
    employee E
    JOIN
    department D ON E.DEPT_CODE = D.DEPT_ID
    JOIN
        location L ON D.LOCATION_ID = L.LOCAL_CODE
    JOIN
        national N ON L.NATIONAL_CODE = N.NATIONAL_CODE
    JOIN
        sal_grade S ON E.SAL_LEVEL = S.SAL_LEVEL
WHERE
    N.NATIONAL_NAME = '러시아'
ORDER BY
   (S.MIN_SAL + E.SALARY) DESC;







