/* 06_JOIN
    - 두 개 이상의 테이블을 관련 있는 컬럼을 통해 결합
*/


/*  1. INNER JOIN
    - 두 테이블의 교집합을 반환
    - ON 키워드 : JOIN에 사용할 두 테이블의 컬럼을 명시
*/

# 두 테이블 따로 조회
SELECT * FROM tbl_menu;
SELECT * FROM tbl_category;



#  INNER JOIN (ANSI)

SELECT
    a.menu_name,
    a.menu_price,
    b.category_name
FROM
    tbl_menu a
INNER JOIN
    tbl_category b
        ON a.category_code = b.category_code;

/* JOIN은 두 테이블에서 지정된 컬럼 값이 같은 행들의 결합으로 만들어진 큰 테이블 */

/* Oracle 방식 JOIN (권자X) */
SELECT
    a.menu_name,
    a.menu_price,
    b.category_name
FROM
    tbl_menu a, tbl_category b
WHERE
    a.category_code = b.category_code;



/* practice 계정 */
SELECT * FROM employee;
SELECT  * FROM department;

SELECT
    em.EMP_ID,
    em.EMP_NAME,
    dp.DEPT_TITLE
FROM
    employee em
JOIN # JOIN == INNER JOIN
        department dp ON em.DEPT_CODE = dp.DEPT_ID
WHERE
    em.EMP_ID < 210;


/* 2. LEFT [OUTER] JOIN
    - JOIN 구문 기준으로 왼쪽에 테이블의
        모든 레코드 (행)이 결과에 포함되도록 하는 JOIN
    - JOIN의 기준이 된 컬럼 값이 일치하지 않아도 결과에 포함
*/

/* practice 계정 */
SELECT
    EMP_NAME,
    DEPT_CODE
FROM
    employee; -- 23행

SELECT
    DEPT_ID,
    DEPT_TITLE
FROM
    department; -- 9행


# INNER JOIN 시 : 하동운, 이오리 결과 포함X
# LEFT OUTER JOIN시 : 하동운, 이오리 결과 포함
SELECT
    *
FROM
    employee e
LEFT JOIN
    department d ON e.DEPT_CODE = d.DEPT_ID;


/* 3. RIGHT [OUTER] JOIN
    - JOIN 구문 기준으로 오른쪽에 테이블의
        모든 레코드 (행)이 결과에 포함되도록 하는 JOIN
    - JOIN의 기준이 된 컬럼 값이 일치하지 않아도 결과에 포함
*/
SELECT
    *
FROM
    employee e
RIGHT JOIN
    department d ON e.DEPT_CODE = d.DEPT_ID;




/* 4. CROSS JOIN
   - 두 테이블의 가능한 모든 조합을 반환하는 조인
*/

#  swcamp 계정
SELECT
    a.menu_name,
    b.category_name
FROM
    tbl_menu a
CROSS JOIN
    tbl_category b;


/* 5. SELF JOIN
   - 같은 테이블 JOIN
   - 같은 테이블의 행과 행 사이의 관계를 찾을 때 주로 사용.
   - tip. 같은 모양의 서로 다른 테이블이 2개 있고, 이들의 JOIN을 생각하자!
*/

SELECT
    *
FROM
    tbl_category a
LEFT JOIN
    tbl_category b ON a.ref_category_code = b.category_code;


# practice 계정
SELECT
    a.EMP_ID AS '사번',
    a.EMP_NAME AS '이름',
    NVL(b.EMP_NAME, '없음') AS '사수명'
FROM
    employee a
LEFT JOIN
    employee b ON a.MANAGER_ID = b.EMP_ID;


# SWCAMP 계정
/* USING
    - JOIN에 사용되는 컬럼 이름이 같은 경우 사용 가능한 구문
    - JOIN에 사용되는 컬럼을 실제로 하나로 합침

    - 장점 : JOIN 결과 컬럼 개수 감소
    - 단점 : 다른 JOIN, SUBQUERY, 연산 수행 시
            어떤 테이블의 컬럼을 지시하려는 것인지 알 수 없음.(애매모호함)
*/
SELECT
    *
FROM
    tbl_menu a
JOIN
    tbl_category b
USING(category_code);
# ON a.category_code = b.category_code;