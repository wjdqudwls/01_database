/* 06_JOIN
   - 두 개 이상의 테이블을 관련 있는 컬럼을 통해 결합

*/

/* 1. INNER JOIN
    - 두 테이블의 교집합을 반환
    - ON 키워드 : JOIN에 사용할 두 테이블의 컬럼을 명시
*/
-- 두 테이블 따로 조회
SELECT * FROM tbl_menu;
SELECT  * FROM tbl_category;

-- INNER JOIN (ANSI) (***중요)
SELECT
    a.menu_name,
    a.menu_price,
    b.category_name
FROM
    tbl_menu a
INNER JOIN
    tbl_category b ON a.category_code = b.category_code;

/* JOIN은 두 테이블에서 지정된 컬럼 값이 같은 행들의 결합으로 만들어진 큰 테이블*/
/* Oracle 방식 JOIN(권장 x) */
    SELECT
        a.menu_name,
        a.menu_price,
        b.category_name
    FROM
        tbl_menu a, tbl_category b
    WHERE
        a.category_code = b. category_code;

/* Practice 계정으로 변경 후 실습 */

SELECT * FROM EMPLOYEE;
SELECT * FROM DEPARTMENT;

/* INNER JOIN (ANSI)*/
SELECT
    e.EMP_ID,
    e.EMP_NAME,
    d.DEPT_TITLE
FROM EMPLOYEE e
JOIN  -- JOIN == INNER JOIN(기본 값)
    DEPARTMENT d ON e.DEPT_CODE = d.DEPT_ID
WHERE
    e.EMP_ID < 210;

/* LEFT [OUTER] JOIN
    - JOIN 구문 기준으로 왼쪽에 테이블의 모든 레코드(행)이 결과에 포함되도록 하는 JOIN
    - JOIN의 기준이 된 컬럼 값이 일치하지 않아도 결고 포함
*/

-- practice 계정 --
SELECT
    emp_name,
    dept_code
FROM
    employee; -- 23행

SELECT
    DEPT_ID,
    DEPT_TITLE
FROM
    DEPARTMENT; -- 9행
-- INNER JOIN 시 : 하동운, 이오리 결과 포함 X
-- LEFT OUTER JOIN 시 : 하동운, 이오리 결과 포함 O
SELECT
    *
FROM
    EMPLOYEE e
LEFT OUTER JOIN
    DEPARTMENT d
        ON e.DEPT_CODE = d.DEPT_ID;

/* RIGHT [OUTER] JOIN
    - JOIN 구문 기준으로 오른쪽에 테이블의 모든 레코드(행)이 결과에 포함되도록 하는 JOIN
    - JOIN의 기준이 된 컬럼 값이 일치하지 않아도 결고 포함
*/

SELECT
    *
FROM
    EMPLOYEE e
RIGHT JOIN
    DEPARTMENT d
    ON e.DEPT_CODE = d.DEPT_ID;


/* 4. CROSS JOIN
   - 두 테이블의 가능한 모든 조합을 반환하는 조인
*/
-- swcamp 계정 --

SELECT
    a.menu_name,
    b.category_name
FROM
    tbl_menu a
CROSS JOIN
    tbl_category b;

/* 5. SELF JOIN
    - 같은 테이블 내에서 JOIN
    - 같은 테이블의 행과 행 사이의 관계를 찾을 때 주로 사용.
    - tip. 같은 모양의 서로 다른 테이블이 2개 있고, 이들의 JOIN을 생각하자 !
*/

SELECT
    *
FROM
    tbl_category a
LEFT JOIN
    tbl_category b
        ON a.ref_category_code = b.category_code;

-- practice 계정 --
SELECT
    a.EMP_ID AS '사번',
    a.EMP_NAME AS '이름',
    NVL(b.EMP_NAME, '없음') AS '사수명'
FROM
    EMPLOYEE a
JOIN
    EMPLOYEE b
        ON a.MANAGER_ID = b.EMP_ID;

-- swcamp 계정 --
/* USING
    - JOIN에 사용되는 컬럼 이름이 같은 경우 사용 가능한 구문
    - JOIN에 사용되는 컬럼을 실제로 하나로 합침

   - 장점 : JOIN 결과 칼럼 개수 감소
   - 단점 : 다른 JOIN, SUBQUERY, 연산 수행 시
           어떤 테이블의 컬럼을 지시하려는 것인지 알 수 없음(애매모호함)
*/

SELECT
    *
FROM
    tbl_menu a
JOIN
    tbl_category b
USING(category_code);
-- ON a.category_code = b.category_code;
