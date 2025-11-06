/* 04_DISTINCT
   - 중복 컬럼 값을 제거 후 조회
   - 테이블 내의 명단, 중복되지 않은 데이터의 개수 등에 사용

*/

-- 메뉴 테이블에 존재하는 모든 카테고리 코드의 종류를 조회
SELECT
    DISTINCT category_code
FROM
    tbl_menu;

-- NULL도 1개만 조회 == NULL도 중복 제거
SELECT
    DISTINCT ref_category_code
FROM
    tbl_category;

-- NULL 제외
SELECT
    DISTINCT ref_category_code
FROM
    tbl_category
WHERE
    ref_category_code IS NOT NULL;

-- 다중 컬럼(다중 열)에서 DISTINCT 적용
-- > 모든 컬럼 값이 같은 경우 중복 제거
SELECT
    DISTINCT category_code,
    orderable_status
FROM
    tbl_menu;

-- DISTINCT는 SELECT절 제일 앞에만 작성 가능
SELECT
    category_code,
    DISTINCT orderable_status
FROM
    tbl_menu;

