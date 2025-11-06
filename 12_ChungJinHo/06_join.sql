/*
 6_JOIN
 - 두 개 이상의 테이블을 관련 있는 컬럼을 통해 결합
 */

/* Oracle 방식 JOIN (권장 X) */
SELECT *
FROM tbl_menu a,
     tbl_category b
WHERE A.category_code = B.category_code;

/* ANSI 방식 JOIN (권장 O) */
SELECT *
FROM tbl_menu TM
         INNER JOIN tbl_category TC
                    ON TM.category_code = TC.category_code;
/*
 6-1. INNER JOIN
 - 두 테이블의 교집합을 반환
 - ON 키워드 : JOIN에 사용할 두 테이블의 컬럼을 명시
 */

-- 기존 테이블 조회
SELECT *
FROM tbl_menu;
SELECT *
FROM tbl_category;

SELECT *
FROM tbl_menu tm
         INNER JOIN tbl_category tc
                    ON tm.category_code = tc.category_code;

/* JOIN은 두 테이블에서 지정된 컬럼 값이 같은 행들의 결합으로 만들어진 큰 테이블 */

/* practice 계정으로 변경 후 실습 */
SELECT *
FROM employee;
SELECT *
FROM department;

SELECT *
FROM employee E
         INNER JOIN department D
                    ON E.DEPT_CODE = D.DEPT_ID;

/*  ==  */
SELECT *
FROM employee E
         JOIN department D -- JOIN의 기본값은 INNER JOIN
WHERE E.DEPT_CODE = D.DEPT_ID;

-- INNER JOIN (ANSI)
SELECT E.EMP_ID, E.EMP_NAME, D.DEPT_TITLE
FROM employee E
         JOIN department D
              ON E.DEPT_CODE = D.DEPT_ID;


/*
 6-2. LEFT [OUTER] JOIN
  - JOIN 구문 기준으로 왼쪽에 테이블의
    모든 레코드(행)이 결과에 포함되도록 하는 JOIN
  - JOIN의 기준이 된 컬럼 값이 일치하지 않아도 결과에 포함
 */
-- practice 계정
SELECT EMP_NAME, DEPT_CODE
FROM employee;

SELECT DEPT_ID, DEPT_TITLE
FROM DEPARTMENT;

SELECT *
FROM employee E
         JOIN department D
              ON E.DEPT_CODE = D.DEPT_ID;
-- => DEPT_CODE가 NULL인 EMPLOYEE의 레코드가 없다

SELECT *
FROM employee E
         LEFT JOIN department D
                   ON E.DEPT_CODE = D.DEPT_ID;
-- => DEPT_CODE가 NULL인 EMPLOYEE의 레코드가 !있다!

/*
 6-2. RIGHT [OUTER] JOIN
  - JOIN 구문 기준으로 오른쪽에 테이블의
    모든 레코드(행)이 결과에 포함되도록 하는 JOIN
  - JOIN의 기준이 된 컬럼 값이 일치하지 않아도 결과에 포함
 */

SELECT *
FROM employee E
         RIGHT JOIN department D
                    ON E.DEPT_CODE = D.DEPT_ID;
-- => EMP_ID가 NULL인 EMPLOYEE의 레코드가 !있다!

/*
 6-3. CROSS JOIN
  - 두 테이블의 가능한 모든 조합을 반환하는 조인
 */

SELECT *
FROM employee E -- 23 RECORDS
         CROSS JOIN department D;
-- 9 RECORDS
-- => 207 RECORDS = 23 * 9 RECORDS

/*
 6-4. SELF JOIN
  - 같은 테이블의 JOIN
  - 같은 테이블의 행과 행 사이의 관계를 찾을 때 주로 사용.
  - TIP) 같은 테이블이 2개
 */

-- 대분류 확인
SELECT *
FROM tbl_category A
JOIN tbl_category B
ON A.ref_category_code = B.category_code;

-- practice 계정
SELECT NOW.EMP_ID '사번',
       NOW.EMP_NAME '이름',
       UP.EMP_ID '사수사번',
       UP.EMP_NAME '사수명'
FROM employee NOW
LEFT JOIN employee UP
ON NOW.MANAGER_ID = UP.EMP_ID;

/*
 6-5. ON과 USING의 차이
 - `JOIN`에 사용되는 **컬럼 이름**이 **같은 경우** 사용 가능한 구문
- `JOIN`에 사용되는 **컬럼**을 실제로 **하나로 합침**

 - 장점 : JOIN 결과 컬럼 개수 감소
 - 단점 : 다른 JOIN, SUBQUERY, 연산 수행 시 어떤 테이블의 컬럼을 지시하려는 것인지 알 수 없음(애매모호해짐)
 */

-- swcamp 계정

-- ON을 사용할 때
SELECT *
FROM tbl_menu TM
JOIN tbl_category TC
ON TM.category_code = TC.category_code;

-- USING을 사용할 때
SELECT *
FROM tbl_menu TM
JOIN tbl_category TC
USING(category_code);