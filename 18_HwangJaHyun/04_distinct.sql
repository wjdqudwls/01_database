/*
    04_DISTINCT
    중복 컬럼 값을 제거 후 조회
    테이블 내에 중복되지 않는 데이터의 개수(ex명단,,) 등에 사용
*/

-- 메뉴 테이블에 존재하는 모든 카테고리코드 종류 조회
SELECT
    DISTINCT category_code
FROM
    tbl_menu;


-- 컬럼값 중 NULL이 존재하는 컬럼에 사용
-- NULL도 1개만 조회 == NULL 중복도 제거
SELECT
    DISTINCT ref_category_code
FROM
    tbl_category;

-- ref_category_code의 종류를 모두 조회
-- 단 NULL 제외
SELECT
    DISTINCT ref_category_code
FROM
    tbl_category
WHERE
    ref_category_code IS NOT NULL;

-- 여러 컬럼(다중 열)에서 DISTINCT 적용
-- -> 선택한 모든 컬럼 값이 같은 경우만 중복 제거 됨
SELECT
    DISTINCT category_code,
    orderable_status
FROM
    tbl_menu;
/*
DISTINCT절은 SELECT문 제일 처음에만 됨

SELECT
    category_code,
    DISTINCT orderable_status
FROM
    tbl_menu;
*/