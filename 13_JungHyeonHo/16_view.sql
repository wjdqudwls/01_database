/* 16. VIEW
    - SELECT 쿼리문을 저장한 객체 (가상 테이블)
    - 실질적인 데이터를 물리적으로 저장한 테이블 X
      논리적으로 저장 후 보여주기만 함
    - 보안성, 복잡한 쿼리를 저장해서 간단히 호출 가능
 */

CREATE VIEW IF NOT EXISTS HANSIK AS
SELECT MENU_CODE,
       MENU_NAME,
       MENU_PRICE,
       CATEGORY_CODE,
       ORDERABLE_STATUS
FROM tbl_menu
WHERE category_code = 4;

SELECT *
FROM HANSIK;

-- 원본 테이블에 값 추가 => VIEW에도 추가됨
INSERT
INTO tbl_menu
VALUES (NULL,
        '식혜맛국밥',
        5500,
        4,
        'Y');

SELECT * FROM HANSIK;

-- 뷰를 통한 테이블에 값 추가 => 원본에도 추가됨
INSERT
INTO HANSIK
VALUES (NULL,'식혜맛국밥',5500,4,'Y');
SELECT * FROM tbl_menu; -- 베이스 테이블에도 데이터가 INSERT됨을 확인

-- INSERT INTO hansik VALUES (null, '식혜맛국밥', 5500, 4, 'Y');    -- 에러 발생
INSERT
  INTO hansik
VALUES (99, '수정과맛국밥', 5500, 4, 'Y');
SELECT * FROM hansik;
SELECT * FROM tbl_menu;

UPDATE hansik
   SET menu_name = '버터맛국밥', menu_price = 5700
 WHERE menu_code = 99;
SELECT * FROM hansik;
SELECT * FROM tbl_menu;

DELETE FROM hansik WHERE menu_code = 99;
SELECT * FROM hansik;
SELECT * FROM tbl_menu;

/* 왜 쓰는지 모르겠다?? 따라 해보세요 */
CREATE VIEW IF NOT EXISTS V_EMP AS
SELECT E.EMP_ID,E.EMP_NAME,E.SALARY,
       D.DEPT_TITLE,J.JOB_NAME,L.LOCAL_NAME,N.NATIONAL_NAME
FROM employee E
JOIN department D ON E.DEPT_CODE = D. DEPT_ID
JOIN job J        ON E.JOB_CODE = J.JOB_CODE
JOIN location L   ON D.LOCATION_ID = L.LOCAL_CODE
JOIN national N   ON L.NATIONAL_CODE = N.NATIONAL_CODE
ORDER BY E.EMP_ID ASC;

-- 모든 사원의 사번, 이름, 부서명, 직급명
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME
FROM V_EMP;
-- 영업팀에 속하는 사원의 사번, 이름, 부서명, 직급명, 지역명
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME, LOCAL_NAME
FROM V_EMP;


-- 급여가 300만원 이상 500만원 이하인 사원의
-- 이름, 직급명, 급여, 근무 국가명 조회
SELECT EMP_NAME, JOB_NAME, SALARY, NATIONAL_NAME
FROM V_EMP
WHERE SALARY BETWEEN 3000000 AND 5000000;

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
-- 에러: menu_price는 NOT NULL인데 값이 없음!

-- OR REPLACE 옵션
CREATE OR REPLACE VIEW hansik AS
SELECT
       menu_code AS '메뉴코드'
     , menu_name '메뉴명'
     , category_name '카테고리명'
  FROM tbl_menu a
  JOIN tbl_category b ON a.category_code = b.category_code
 WHERE b.category_name = '한식';

SELECT * FROM hansik;