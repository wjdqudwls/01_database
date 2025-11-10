/*
    16_VIEW
        - SELECT QUERY 문을 저장한 객체 (가상 테이블)
        - 실질적인 데이터를 물리적으로 저장한 테이블은 아님
            논리적으로 저장 후 보여주기만 함
        - 보안성, 복잡한 쿼리를 저장해서 간단하게 호출 가능
*/

-- VIEW 생성
-- CREATE : 데이터베이서 객체를 생성하는 구문

CREATE VIEW IF NOT EXISTS hansik AS -- AS 뒤에는 () 안쓰고 서브쿼리 써도 된다. 묵시적으로 AS 뒤에는 무조건 서브쿼리가 오기때문에
    (
        SELECT
            menu_code,
            menu_name,
            menu_price,
            category_code,
            orderable_status
        FROM tbl_menu
        WHERE category_code = 4
    );

-- VIEW 조회
SELECT * FROM hansik;

-- 원본 데이터에 넣는거는 VIEW에 보임
INSERT
  INTO tbl_menu
VALUES (null, '식혜맛국밥', 5500, 4, 'Y');
SELECT * FROM hansik;

-- VIEW를 이용한 원본 테이블(tbl_menu)에 데이터 삽입
-- VIEW는 가짜 테이블 이지만
-- 실제 테이블과 연결되어 있음
-- (주의) VIEW를 통해 데이터를 바꾸는것은 권장되지 않는다.

INSERT
  INTO hansik
VALUES (99, '수정과맛국밥', 5500, 4, 'Y');
SELECT * FROM hansik;
SELECT * FROM tbl_menu; -- 베이스 테이블(원본)에 삽입됨을 확인

-- VIEW를 이용한 UPDATE
UPDATE hansik
    SET
        menu_name = '버터맛국밥',
        menu_price = 5700
WHERE
    menu_code = 99;

SELECT * FROM hansik;
SELECT * FROM tbl_menu; -- 베이스 테이블(원본)에 UPDATE 확인

-- VIEW를 이용한 DELETE

DELETE FROM hansik WHERE menu_code = 99;
SELECT * FROM hansik;
SELECT * FROM tbl_menu;

/*
    왜 쓰는지 모르겠으면 따라해보기
*/

CREATE VIEW IF NOT EXISTS V_EMP AS
SELECT
    e.EMP_ID,
    e.EMP_NAME,
    e.SALARY,
    d.DEPT_TITLE,
    j.JOB_NAME,
    l.LOCAL_NAME,
    n.NATIONAL_NAME
FROM employee e
    JOIN department d ON (e.DEPT_CODE = d.DEPT_ID)
    JOIN job j ON (e.JOB_CODE = j.JOB_CODE)
    JOIN location l ON (d.LOCATION_ID = l.LOCAL_CODE)
    JOIN national n ON (l.NATIONAL_CODE = n.NATIONAL_CODE)
ORDER BY
    e.EMP_ID ASC;

-- 모든 사원의 사번, 이름, 부서명
SELECT
    EMP_ID,
    EMP_NAME,
    DEPT_TITLE
FROM V_EMP;
-- 영업팁에 속하는 사원의 사번, 이름, 부서명, 직급명 지역명 조회
SELECT
    EMP_ID,
    EMP_NAME,
    DEPT_TITLE,
    LOCAL_NAME
FROM V_EMP
WHERE DEPT_TITLE LIKE '%영업%'

-- 급여가 300만원 이상 500만원 이하인 사원의 이름, 직급명, 급여, 국가명 조회


/*
    1-2-4 VIEW를 DML 명령어로 조작 불가능한 경우
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
INSERT INTO view_menu_no_price VALUES (NULL, '메뉴', 4, 'Y');
-- VIEW에 작성이 되는게 아니라 베이스 테이블에 데이터가 들어가는데
-- menu_price가 없으므로, 원본 테이블에 NULL값이 들어감
-- 그런데 원본 테이블 menu_price는 IS NOT NULL 이므로 에러가 발생함
-- 에러: menu_price는 NOT NULL인데 값이 없음!

-- DROP : 데이터 베이스 객체 제거
DROP VIEW IF EXISTS hansik;

-- OR REPLACE 옵션
CREATE OR REPLACE VIEW hansik AS
SELECT
     menu_name '메뉴명'
     , category_name '카테고리명'
  FROM tbl_menu a
  JOIN tbl_category b ON a.category_code = b.category_code
 WHERE b.category_name = '한식';

SELECT * FROM hansik;