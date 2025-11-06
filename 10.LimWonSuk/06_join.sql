/* 06_JOIN
   -두 개 이상의 테이블을 관련 있는 컬럼을 통해 결합
 */

 /* 1. INNER JOIN
    -두 테이블의 교집합을 반환
    - ON 키워드 : JOIN에 사용할 두 테이블의 컬럼을 명시
  */
SELECT * FROM  tbl_menu;
SELECT * FROM  tbl_category;

-- 두 테이블 따로 조회
SELECT * FROM  tbl_menu;
SELECT * FROM tbl_category;

-- INNER JOIN (ANSI)

SELECT
    *
FROM
tbl_menu
INNER JOIN
    tbl_category
        1.<->1:ON a.category_code = tbl_menu.category_cod;

/* JOIN은 두 테이블에서 지정된 컬럼 값이 같은 행들의 결합으로 만들어진 큰 테이블 */

    /* Oracle 방식 JOIN (권장 x ) */
    SELECT
        *
    FROM
     menu a,


/* parctice 계정으로 변경 후 실습*/
SELECT * FROM employes
SELECT * FROM department

-- INNER JOIN (ANSI)
SELECT
    *
        FROM
            employee
JOIN -- JOIN == INNER JOIN(기본 값)
    department d
    ON e.dept_code = d.DEPT_ID
WHERE
    e.emp_id < 210;

/* 2.LEFT [OUTER] JOIN
   - JOIN 구문 기준으로 왼쪽에 테이블의
   모든 레코드(행)이 결과에 포함되도록 하는 JOIN
   - JOIN의 기준이된 컬럼 값이 일치하지 않아도 결과에 포함
 */

 -- practice 계정 --
SELECT
    employee.EMP_NAME,
    employee.DEPT_CODE
FROM
    employee; -- 23행

SELECT
    department.DEPT_ID,
    department.DEPT_TITLE
    FROM
        department; -- 9행


-- INNER JOIN 시 : 하동운, 이오리 결과 포함 X
-- LEFT OUTER JOIN  시 : 하동운, 이오리 결과포함 O
        SELECT
            *
        FROM
            employee e
        JOIN
                department d
                    ON e.DEPT_CODE = d.DEPT_ID;

 SELECT
            *
        FROM
            employee e
        LEFT JOIN
                department d
                    ON e.DEPT_CODE = d.DEPT_ID;

/* 2.RIGHT [OUTER] JOIN
   - JOIN 구문 기준으로 왼쪽에 테이블의
   모든 레코드(행)이 결과에 포함되도록 하는 JOIN
   - JOIN의 기준이된 컬럼 값이 일치하지 않아도 결과에 포함

 */
 SELECT
            *
        FROM
            employee e
       RIGHT JOIN
                department d
                    ON e.DEPT_CODE = d.DEPT_ID;
