/* 04_DISTINCT
   - 중복 컬럼 값을 제거 후 조회
   - 테이블 내에 명단, 중복되지 않는 데이터의 개수 등
*/

-- 메뉴 테이블에 존재하는 모든 카테고리 코드의 종류를 조회

SELECT
    distinct category_code
FROM
    tbl_menu;

-- 컬럼 값 중 NULL이 존재하는 컬럼에 사용
-- 결과 : NULL도 1개만 조회 == NULL 중복도 제거 O
SELECT
    distinct ref_category_code
FROM
    tbl_category;

-- ref_category_code의 종류를 모두 조회
-- 단, NULL 제외

SELECT
    distinct ref_category_code
FROM
    tbl_category
WHERE
    ref_category_code IS NOT NULL;

-- 여러 컬럼(다중 열)에서 DISTINCT 적용
-- 모든 컬럼 값이 같은 경우 중복 제거

SELECT
    distinct category_code,
    orderable_status
FROM
    tbl_menu