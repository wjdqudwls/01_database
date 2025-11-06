/*---------------------------------------------------------------------*/
/*
 04_DISTINCT
    - 컬럼 값을 제거 후 조회
    - 테이블 내에 명단, 중복되지 않는 데이터의 개수
 */

-- 메뉴 테이블에 존재하는 모든 카테고리 코드의 종류를 조회
SELECT DISTINCT category_code
FROM tbl_menu;

-- 컬럼 값 중 NULL이 존재하는 컬럼에 사용
SELECT DISTINCT ref_category_code
FROM tbl_category;

-- 컬럼 값 중 NULL을 제외한 원자값
SELECT DISTINCT ref_category_code
FROM tbl_category
WHERE ref_category_code IS NOT NULL;

-- 여러 컬럼(다중 열)에서 DISTINCT 적용
SELECT DISTINCT category_code,orderable_status
FROM tbl_menu;

SELECT category_code,orderable_status
FROM tbl_menu;

-- DISTINCT는 SELECT절 제일 앞에만 작성 가능
SELECT category_code,
        DISTINCT orderable_status
FROM tbl_menu;