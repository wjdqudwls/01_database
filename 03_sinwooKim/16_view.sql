/*
VIEW
    - SELECT 쿼리문을 저장한 객체 (가상 테이블)
    - 실질적인 데이터를 물리적으로 저장한 테이블 X -> 논리적으로 저장 후 보여주기만 함
    - 보안성, 복잡한 쿼리를 저장해서 간단히 호출 가능
*/

-- VIEW
-- CREATE : 데이터베이스 객체를 생성
CREATE VIEW IF NOT EXISTS hansik AS
SELECT menu_code
     , menu_name
     , menu_price
     , category_code
     , orderable_status
FROM tbl_menu
WHERE category_code = 4;

SELECT * FROM hansik;

-- 원본 테이블 값 추가 -> VIEW 값 영향.

INSERT
INTO tbl_menu
VALUES (null, '식혜맛국밥', 5500, 4, 'Y');

SELECT *
FROM hansik;

-- VIEW를 이용한 원본 테이블(tbl_menu)에 데이터 삽입
-- VIEW는 가짜 테이블이지만 실제 테이블과 연결되어 있음
INSERT
INTO hansik
VALUES (99, '수정과맛국밥', 5500, 4, 'Y');

SELECT *
FROM hansik;

SELECT *
FROM tbl_menu; -- 베이스 테이블에 삽입됨을 확인.

-- VIEW를 이용한 UPDATE

UPDATE hansik
SET menu_name  = '버터맛국밥',
    menu_price = 5700
WHERE menu_code = 99;

SELECT *
FROM hansik;

SELECT *
FROM tbl_menu;

-- VIEW를 이용한 DELETE
DELETE FROM hansik WHERE menu_code = 99;
SELECT * FROM hansik;
SELECT * FROM tbl_menu;

/*
VIEW를 사용하는 이유
*/
CREATE VIEW IF NOT EXISTS v_emp AS
SELECT E.EMP_ID, E.EMP_NAME, E.SALARY, D.DEPT_TITLE, J.JOB_NAME,L.LOCAL_NAME,N.NATIONAL_NAME
FROM EMPLOYEE E
JOIN DEPARTMENT D ON E.DEPT_CODE = D.DEPT_ID
JOIN JOB J ON E.JOB_CODE = J.JOB_CODE
JOIN LOCATION L ON D.LOCATION_ID = L.LOCAL_CODE
JOIN NATIONAL N ON L.NATIONAL_CODE = N.NATIONAL_CODE
ORDER BY E.EMP_ID;

-- 모든 사원의 사번, 이름, 부서명, 직급명
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME
FROM v_emp;

-- 영업팀에 속하는 사원의 사번, 이름, 부서명, 직급명, 지역명 조회
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME, LOCAL_NAME
FROM v_emp
WHERE DEPT_TITLE LIKE '%영업%';

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
INSERT INTO view_menu_no_price
VALUES (1, '메뉴', 4, 'Y');
-- 에러: menu_price는 NOT NULL인데 값이 없음!

-- VIEW 삭제
DROP VIEW hansik;

-- VIEW OPTION
-- OR REPLACE 옵션
CREATE OR REPLACE VIEW hansik AS
SELECT menu_code AS '메뉴코드'
     , menu_name '메뉴명'
     , category_name '카테고리명'
FROM tbl_menu a
         JOIN tbl_category b ON a.category_code = b.category_code
WHERE b.category_name = '한식';

SELECT * FROM hansik;