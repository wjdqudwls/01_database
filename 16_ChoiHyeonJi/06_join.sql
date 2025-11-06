/*
    - 06_JOIN
    - 두 개 이상의 테이블을 관련 있는 컬럼을 통해 결합
*/

/*

    1. INNER JOIN
    - 두 테이블의 교집합을 반환
    - ON 키워드 : JOIN에 사용할 두 테이블의 컬럼을 명시
*/


-- 두 테이블 따로 조회
SELECT * FROM tbl_menu;
SELECT * FROM tbl_category;

-- INNER JOIN (ANSI)
SELECT
    a.menu_name,
    a.menu_price,
    b.category_name
FROM
    tbl_menu a
INNER JOIN
    tbl_category b
        ON a.category_code = b.category_code;

-- JOIN은 두 테이블에서 지정된 컬럼 값이 같은 행들의 결합으로 만들어진 큰 테이블
/*

practice 게쩡으로 변경 후 실습

*/

SELECT * FROM employee;
SELECT * FROM department;

-- INNER JOIN (ANSI)
SELECT
    e.emp_id,
    e.emp_name,
    e.dept_title
FROM
    employee e
JOIN -- JOIN == INNER JOIN(기본 값)
    department d
        on e.dept_code = d.dept_id
WHERE
    e.emp_id < 210;

/*
Oracle 방식 JOIN(권장X)
*/
SELECT
    *
FROM
    tbl_menu a, tbl_category b
WHERE  a.category_code = b.category_code-- 조회 하고 시은 컬럼들


-- 오라클 방식 몰라도 됨
SELECT
    a.menu_name,
    a.menu_price,
    b.category_name
FROM
    tbl_menu a, tbl_category b
WHERE  a.category_code = b.category_code



/*
2. LEFT [OUTER] JION
    - JOIN 구문 기준으로 왼쪽 테이블의 모든 레코드(행)이 결과에 포함되도록 하는 JOIN
    - JOIN의 기준이 된 컬럼 값이 일치하지 않아도 결과에 포함
*/

-- practice 계쩡
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
    *
FROM
    employee e
JOIN
    department d
    ON e.dept_code = d.dept_id;

/*
    - 06_JOIN
    - 두 개 이상의 테이블을 관련 있는 컬럼을 통해 결합
*/

/*

    1. INNER JOIN
    - 두 테이블의 교집합을 반환
    - ON 키워드 : JOIN에 사용할 두 테이블의 컬럼을 명시
*/


-- 두 테이블 따로 조회
SELECT * FROM tbl_menu;
SELECT * FROM tbl_category;

-- INNER JOIN (ANSI)
SELECT
    a.menu_name,
    a.menu_price,
    b.category_name
FROM
    tbl_menu a
INNER JOIN
    tbl_category b
        ON a.category_code = b.category_code;

-- JOIN은 두 테이블에서 지정된 컬럼 값이 같은 행들의 결합으로 만들어진 큰 테이블
/*

practice 게쩡으로 변경 후 실습

*/

SELECT * FROM employee;
SELECT * FROM department;

-- INNER JOIN (ANSI)
SELECT
    e.emp_id,
    e.emp_name,
    e.dept_title
FROM
    employee e
JOIN -- JOIN == INNER JOIN(기본 값)
    department d
        on e.dept_code = d.dept_id
WHERE
    e.emp_id < 210;

/*
Oracle 방식 JOIN(권장X)
*/
SELECT
    *
FROM
    tbl_menu a, tbl_category b
WHERE  a.category_code = b.category_code-- 조회 하고 시은 컬럼들


-- 오라클 방식 몰라도 됨
SELECT
    a.menu_name,
    a.menu_price,
    b.category_name
FROM
    tbl_menu a, tbl_category b
WHERE  a.category_code = b.category_code



/*
2. LEFT [OUTER] JION
    - JOIN 구문 기준으로 왼쪽 테이블의 모든 레코드(행)이 결과에 포함되도록 하는 JOIN
    - JOIN의 기준이 된 컬럼 값이 일치하지 않아도 결과에 포함
*/

-- practice 계쩡
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

-- INNER JOIN 시 : 하동운, 이오리 결과 포함 X
-- LEFT OUTER JOIN 시 : 하동운, 이오리 결과 포함 O
SELECT
    *
FROM
    employee e
LEFT OUTER JOIN
    department d
    ON e.dept_code = d.dept_id; -- 하동운 이오리 포함

/*
2. RIGHT [OUTER] JION
    - JOIN 구문 기준으로 오른쪽 테이블의 모든 레코드(행)이 결과에 포함되도록 하는 JOIN
    - JOIN의 기준이 된 컬럼 값이 일치하지 않아도 결과에 포함
*/

SELECT
    *
FROM
    employee e
RIGHT JOIN
    department d
    ON e.dept_code = d.dept_id; -- 하동운 이오리 포함




/*
    4. CROSS JOIN
    - 두 테이블의 가능한 모든 조합을 반환하는 조인
*/

-- swcamp 계정
SELECT
    a.menu_name,
    b.category_name
FROM
    tbl_menu a
CROSS JOIN
    tbl_category b;

/*

5. SELF JOIN
    - 같은 테이블의 JOIN
    - 같은 테이블의 행과 행 사이의 관계를 찾을 때 주로 사용.
    -
    - tip. 같은 모양의 서로 다른 테이블이 2개 있고, 이들의 JOIN을 생각하쟈!

*/

SELECT
    *
FROM
    tbl_category a -- a 테이블
LEFT JOIN -- LEFT 추가하면 왼쪽에 다시 나타남
    tbl_category b
        ON a.ref_category_code = b.category_code;



-- practice 계정 --
-- 테이블이 2개라고 생각하기
SELECT
    a.emp_id AS '사번', -- 별칭으로 AS 사번
    a.emp_name AS '이름',
    b.emp_name AS '사수명'
FROM
    employee a
JOIN -- 선동일 포함하려면 LEFT JOIN
    employee b
        ON a.manager_id = b.emp_id;


SELECT
    a.emp_id AS '사번',
    a.emp_name AS '이름',
    NVL(b.emp_name, '없음') AS '사수명'
FROM
    employee a
LEFT JOIN -- 선동일 포함하려면 LEFT JOIN
    employee b
        ON a.manager_id = b.emp_id;

-- swcamp 계정 --

/*
    - USING
    JOIN에 사용되는 컬럼이름이 같은 경우 사용 가능한 구문
    JOIN에 사용되는 컬럼을 하나에 합침

    장점 : JOIN 결과 컬럼 개수 감소
    단점 : 다른 JOIN, SUBQUERY, 연산 수행 시
    어떤 테이블의 컬럼을 지시하려는 것인지 알 수 없음(애매모호함)
*/

SELECT
    *
FROM
    tbl_menu a
JOIN
    tbl_category b
USING(category_code)
        -- ON A.category_code = b.category_code;