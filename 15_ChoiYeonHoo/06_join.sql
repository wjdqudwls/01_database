/*
    06_JOIN
    : 두 개 이상의 테이블을 관련 있는 컬럼을 통해 결합
*/

/*
    1. INNER JOIN
    - 두 테이블 열의 교집합을 반환 ( Column 이 아니고, Row의 교집합 )
    - ON 키워드
    : JOIN의 사용 할 두 테이블의 컬럼을 명시
*/
-- 나중엔 FK(Foreign Key) 사용해서 강제로 연관이 있다고 만들 예정

-- 두 테이블을 따로 조회
SELECT * FROM tbl_menu;
SELECT * FROM tbl_category;

-- INNER JOIN (ANSI 방식)
SELECT
    a.menu_name,
    a.menu_price,
    b.category_code
FROM
    tbl_menu a -- tbl_menu를 a라 부름
INNER JOIN
        tbl_category b -- tbl_category를 b라 부름
            ON a.category_code = b.category_code;

/*
    JOIN은 두 테이블에서 지정된 컬럼 값이 같은 행들의 결합으로 만들어진 큰 테이블
*/

-- INNER JOIN (Oracle 방식, 권장 X)
SELECT
    *
FROM
    tbl_menu a, tbl_category b -- JOIN 할 테이블을 한줄에
WHERE
    a.category_code = b.category_code; -- On 부분을 WHERE절에 표현


/* practice 계정으로 변경 후 테스트*/
 -- 컬럼 이름이 달라도 값이 같으면 됨.
 -- 데이터가 중요함

SELECT * FROM employee;
SELECT * FROM department;

-- INNER JOIN (ANSI)
SELECT
    e.EMP_ID,
    e.EMP_NAME,
    d.DEPT_TITLE
FROM employee e
JOIN -- JOIN == INNER JOIN (기본값)
    department d
        ON e.DEPT_CODE = d.DEPT_ID
WHERE
    -- EMP_ID가 210보다 작은
    e.EMP_ID < 210;

/*
    2. LEFT [OUTER] JOIN
    - JOIN 구문 기준으로 왼쪽 테이블의
       모든 레코드(행)이 결과에 포함 되도록 하는  JOIN
    - JOIN에 기준이 된 컬럼 값이 일치하지 않아도 결과에 포함
*/

-- practice 계정으로 테스트

SELECT
    EMP_NAME,
    DEPT_CODE
FROM
    employee; -- 23행,

SELECT
    DEPT_ID,
    DEPT_TITLE

FROM department; -- 9행

SELECT
    *
FROM employee e
JOIN department d
    ON e.DEPT_CODE = d.DEPT_ID;
 -- 결과 : DEPT_CODE NULL 이였던 두명은 제거 됨

SELECT
    *
FROM employee e
LEFT JOIN department d
-- LEFT OUTER JOIN department d  -- LEFT 적혀있어 OUTER 없어도 됨
    ON e.DEPT_CODE = d.DEPT_ID;
   -- 결과 : DEPT_CODE NULL 이였던 두명도 포함 됨

/*
    3. RIGHT [OUTER] JOIN
    - JOIN 구문 기준으로 오른쪽 테이블의
       모든 레코드(행)이 결과에 포함 되도록 하는  JOIN
    - JOIN에 기준이 된 컬럼 값이 일치하지 않아도 결과에 포함
*/
SELECT
    *
FROM employee e
RIGHT JOIN department d
-- RIGHT OUTER JOIN department d
    ON e.DEPT_CODE = d.DEPT_ID;

-- FULL OUTER JOIN 이라는게 있는데 ORACLE 에서만 가능

/*
    4. CROSS JOIN
    - 두 테이블의 가능한 모든 조합을 반환 하는 JOIN 구문
*/

-- swcamp 계정으로 변환
SELECT
    a.menu_name,
    b.category_name
FROM
    tbl_menu a      -- 21개
CROSS JOIN
    tbl_category b; -- 12개
-- 총 252개

/*
    5. SELF JOIN
    - 같은 테이블을 JOIN
    - 같은 테이블의 행과 행 사이의 관계를 찾을 때 많이 사용
    - tip. 같은 모양의 서로 다른 테이블이 2개 있다고 생각하고, 이들의 JOIN을 생각
*/

SELECT
    *
FROM
    tbl_category a
-- JOIN    -- 그냥 조인 하면 a에 있는 null값은 사라짐
LEFT JOIN  -- null도 표현하기 위해 LEFT JOIN 사용
    tbl_category b
        ON a.ref_category_code = b.category_code;

-- practice 계정
-- 자신의 사수 번호를 출력
SELECT
    a.EMP_ID AS 사번,
    a.EMP_NAME AS 이름,
    NVL(b.EMP_NAME, '없음') AS 사수명 -- b.EMP_NAME이 NULL이면 '없음'을 넣어라
FROM employee a
LEFT JOIN employee b
    ON a.MANAGER_ID = b.EMP_ID;

-- swcamp 계정
-- 예전엔 많이 썼지만 지금은 안쓰는 구문
/*
    USING
    - JOIN에 사용되는 컬럼 이름이 같은 경우 사용 가능한 구문
    - JOIN에 사용 되는 컬럼을 실제로 하나로 합침

    - 장점 : JOIN 결과 컬럼 개수 감소
    - 단점 : 다른 JOIN, Subquery, 연산 수행 시
            어떤 테이블의 컬럼을 지시하려는 것인지 알 수 없음(애매모호함)
*/

SELECT *
FROM
    tbl_menu a
JOIN tbl_category b
USING(category_code) -- 데이터 조회시 컬럼이 a.ca, b.ca 로 나뉘는게 아니라 하나로 합쳐짐
# ON a.category_code = b.category_code;