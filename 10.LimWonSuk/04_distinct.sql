/* 04_DISTINCT
   -중복 컬럼 값을 제거 후 조회
   - 테이블 내에 명단, 중복되지않은 데이터의 개수 등에 사용
 */

 -- 메뉴 테이블에 존재하는 모든 카테고리 코드의 종류를 조회
/* SELECT
    tbl_menu.category_code
FROM
    tbl_menu;
 */
SELECT
    DISTINCT category_code
FROM
    tbl_menu;

-- 컬럼 값 중 NULL이 존재하는 컬럼에 사용
SELECT
    DISTINCT tbl_category.ref_category_code
FROM
    tbl_category;

-- ref_category_code의 종류를 모두 조회
-- 단, NULL 제외
-- NULL이 없는것들중에 조회하겠다
SELECT
    DISTINCT tbl_category.ref_category_code
FROM
    tbl_category
WHERE
    ref_category_code IS NOT NULL ;

-- 여러 컬럼(다중 열) 에서 DISTINCT 적용
SELECT
    tbl_menu.category_code,
    tbl_menu.orderable_status
FROM
    tbl_menu;

-- > 모든 컬럼 값이 같은 경우 중복 제거
SELECT
    DISTINCT tbl_menu.category_code,
    tbl_menu.orderable_status
FROM
    tbl_menu;
-- DISTINCT  는 무조건 SELECT 절 맨앞만 사용가능
SELECT
    tbl_menu.category_code,
   DISTINCT tbl_menu.orderable_status
FROM
    tbl_menu;



