/* 16. VIEW
   - SELECT 쿼리문을 저장한 객체
   - 실질적인 데이터를 물리적으로 저장한 테이블 X
     논리적으로 저장 후 보여주기만 함
   -- 보안성, 복잡한 쿼리를 저장해서 간단히 호출 가능
*/

-- VIEW 생성 후 조회
SELECT * FROM tbl_menu;

-- VIEW 생성
-- CREATE : 데이터베이스 객체를 생성하는 구문
CREATE VIEW IF NOT EXISTS hansik AS
    SELECT
        menu_code,
        menu_name,
        menu_price,
        category_code,
        orderable_status
    FROM tbl_menu
WHERE category_code = 4;

-- 생성된 VIEW 조회
SELECT * from hansik;

-- VIEW를 이용한 원본 테이블(tbl_menu)에 데이터 삽입
-- 원본 테이블에 값 추가 -> VIEW에도 추가됨
INSERT
  INTO tbl_menu
VALUES (null,
        '식혜맛국밥',
        5500,
        4,
        'Y');

SELECT * FROM hansik;


-- 1-2-1. VIEW를 통한 INSERT
-- - VIEW는 가짜 테이블이지만
--   실제 테이블과 연결되어 있음
-- INSERT INTO hansik VALUES (null, '식혜맛국밥', 5500, 4, 'Y');    -- 에러 발생
INSERT
INTO hansik
VALUES (99,
        '수정과맛국밥',
        5500,
        4,
        'Y');

SELECT * FROM hansik;

SELECT * FROM tbl_menu;

-- 1-2-2. VIEW를 통한 UPDATE
UPDATE hansik
   SET menu_name = '버터맛국밥', menu_price = 5700
 WHERE menu_code = 99;

SELECT * FROM hansik;

SELECT * FROM tbl_menu;

-- 1-2-3. VIEW를 통한 DELETE
DELETE FROM hansik WHERE menu_code = 99;

SELECT * FROM hansik;

SELECT * FROM tbl_menu;

/* 왜 쓰는지 모르겠다?? 따라 해보세요 */
CREATE VIEW IF NOT EXISTS v_emp AS
SELECT
    E.EMP_ID, E.EMP_NAME, E.SALARY,
    D.DEPT_TITLE, J.JOB_CODE, L.LOCAL_NAME, N.NATIONAL_NAME
FROM
    employee E
JOIN
    department D ON (E.DEPT_CODE = D.DEPT_ID)
JOIN
    job J ON (E.JOB_CODE = J.JOB_CODE)
JOIN
    location L ON (D.LOCATION_ID = L.LOCAL_CODE)
JOIN
    national N ON (L.NATIONAL_CODE = N.NATIONAL_CODE)
ORDER BY
    E.EMP_ID ASC;

-- 모든 사원의 사번, 이름, 부서명, 직급명
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_CODE
FROM v_emp;
-- 영업팀에 속하는 사원의 사번, 이름, 부서명, 직급명, 지역명 조회
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_CODE
FROM v_emp
WHERE DEPT_TITLE LIKE '영업%';
-- 급여가 300만원 이상 500만원 이하인 사원의
-- 이름, 직급명, 급여, 국가명 조회

/* ### 1-2-4. VIE를 DML 명령어로 조작이 불가능한 경우

- 사용된 SUBQUERY에 따라 DML 명령어로 조작이 불가능할 수 있다.
    1. 뷰 정의에 포함되지 않은 컬럼을 조작하는 경우
    2. 뷰에 포함되지 않은 컬럼 중에 베이스가 되는 테이블 컬럼이 NOT NULL 제약조건이 지정된 경우
    3. 산술 표현식이 정의된 경우
    4. JOIN을 이용해 여러 테이블을 연결한 경우
    5. DISTINCT를 포함한 경우
    6. 그룹함수나 GROUP BY 절을 포함한 경우
*/

-- (2) 뷰에 포함되지 않은 컬럼 중 베이스 테이블에 not null 조건이 있는 경우

-- tbl_menu_notnull 구조
CREATE TABLE tbl_menu_notnull (
  menu_code INT PRIMARY KEY,
  menu_name VARCHAR(30) NOT NULL,
  menu_price INT NOT NULL,           -- NOT NULL
  category_code INT NOT NULL,        -- NOT NULL
  orderable_status CHAR(1) NOT NULL
);


-- VIEW에서 menu_price 제외
CREATE VIEW view_menu_no_price AS
SELECT menu_code, menu_name, category_code, orderable_status
FROM tbl_menu_notnull;


-- INSERT 실패
INSERT INTO view_menu_no_price VALUES (1,
                                       '메뉴',
                                       4,
                                       'Y');
-- 에러: menu_price는 NOT NULL인데 값이 없음!

-- VIEW 삭제
DROP VIEW IF EXISTS hansik;

-- OR REPLACE 옵션
CREATE OR REPLACE VIEW hansik AS
SELECT
        menu_name '메뉴명', category_name '카테고리명'
  FROM tbl_menu a
  JOIN tbl_category b ON a.category_code = b.category_code
 WHERE b.category_name = '한식';

SELECT * FROM hansik;
