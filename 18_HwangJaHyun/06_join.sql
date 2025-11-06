/*
    ANSI 방식
    명시적으로 쓰자
*/
/*
    06_JOIN
    두 개이상의 테이블을 관련있는 컬럼을 통해 결합
*/

/*
    1. INNER JOIN
    두 테이블의 교집합을 반환
    ON 키워드 : JOIN에 사용할 두 테이블의 컬럼을 명시

    JOIN
    두 테이블에 지정된 컬럼값이 같은 행의 결합으로 만들어진 큰 테이블
*/

-- 두 테이블 조회
SELECT * FROM tbl_menu;
SELECT * FROM tbl_category;

-- INNER JOIN (ANSI)
-- 등가조인
SELECT
    *
FROM
    tbl_menu a
INNER JOIN
    tbl_category b ON a.category_code = b.category_code;

SELECT
    a.menu_code,
    a.menu_name,
    b.category_code
FROM
    tbl_menu a
INNER JOIN
    tbl_category b ON a.category_code = b.category_code;

/* Oracle 방식 JOIN (권장X) */
SELECT
    a.menu_code,
    a.menu_name,
    b.category_code
FROM
    tbl_menu a, tbl_category b
WHERE
    a.category_code = b.category_code;

/*
    practice 계정으로 변경 후 실습
*/
SELECT * FROM employee;
SELECT * FROM department;

SELECT
    e.emp_id,
    e.emp_name,
    d.dept_title
FROM
    employee e
JOIN
    department d ON e.DEPT_CODE = d.DEPT_ID
WHERE
    e.EMP_ID <= 210;

/*
    2. LEFT [OUTER] JOIN
    JOIN 구문 기준으로 왼쪽 테이블의
    모든 레코드(행)이 결과에 포함되도록 하는 JOIN

    JOIN의 기준이 된 컬럼 값이 일치하지 않아도 결과에 포함
*/

/*
    practice 계정으로 변경 후 실습
*/
SELECT
    emp_name,
    dept_code
FROM
    employee; -- 23행

SELECT
    dept_id,
    dept_title
FROM
    department; -- 9행

SELECT
    e.emp_name,
    d.dept_id,
    d.dept_title
FROM
    employee e
JOIN
    department d ON e.DEPT_CODE = d.DEPT_ID; -- 21행, 하동훈 이오리 X

SELECT
    e.emp_name,
    d.dept_id,
    d.dept_title
FROM
    employee e
LEFT OUTER JOIN
    department d ON e.DEPT_CODE = d.DEPT_ID; -- 23행, 하동훈 이오리 O


/*
    3. RIGHT [OUTER] JOIN
    JOIN 구문 기준으로 오른쪽 테이블의
    모든 레코드(행)이 결과에 포함되도록 하는 JOIN

    JOIN의 기준이 된 컬럼 값이 일치하지 않아도 결과에 포함
*/
SELECT
    e.emp_name,
    d.dept_id,
    d.dept_title
FROM
    employee e
RIGHT OUTER JOIN
    department d ON e.DEPT_CODE = d.DEPT_ID;


/*
    4. CROSS JOIN
    두 테이블의 가능한 모든 조합을 반환하는 조인

    swcamp 계정
*/
SELECT
    a.menu_name,
    b.category_name
FROM
    tbl_menu a
CROSS JOIN
    tbl_category b;

/*
    5. SELF JOIN
    같은 테이블의 JOIN
    같은 테이블의 행과 행 사이의 관계를 찾을 때 주로 사용
    tip. 같은 모양의 서로 다른 테이블이 2개, 이들의 JOIN을 생각하자!
*/
SELECT
    *
FROM
    tbl_category a
LEFT JOIN
    tbl_category b ON a.ref_category_code = b.category_code;

/*
    practice 계정
*/
SELECT
    *
FROM
    employee;

SELECT
    a.emp_id AS '사번',
    a.emp_name AS '이름',
    NVL(b.emp_name, '없음') AS '사수명'
FROM
    employee a
LEFT JOIN
    employee b on a.MANAGER_ID = b.emp_id;
-- a테이블의 사수 번호를 가지고 b 테이블의 id조회

-- swcamp 계정
/*
    USING
    JOIN에 사용되는 컬럼 이름이 같은 경우 사용 가능한 구문
    JOIN에 사용되는 컬럼을 실제로 하나로 합침

    장점: JOIN 결과 컬럼 개수 감소
    단점: 다른 JOIN, SUBQUERY, 연산 수행 시
    어떤 테이블의 컬럼을 지시하려는 것인지 알 수 없음
    (애매모호함)잘안쓴다..
*/
SELECT
    *
FROM
    tbl_menu a
JOIN
    tbl_category b
    -- ON a.category_code = b.category_code;
    USING(category_code);