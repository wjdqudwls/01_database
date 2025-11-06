/*
    해석 순서
    5 :SELECT : 컬럼 필터링
    1 :FROM (+ JOIN) : 테이블 선택
    2 :WHERE : 행 필터링
    3 :GROUP BY : 그룹화
    4 :HAVING : 그룹화 필터링
    6: ORDER BY : 정렬 순서
    7: LIMIT : 조회 행수 제한
*/

/*
    07_GROUPING
        1. GROUP BY
        - 결과 집합을 특정 컬럼 값에 따라 그룹화
*/

/*
    그룹 함수
    - 전체 테이블 또는 GROUP이 지어진 결과 집합에 사용 가능한 함수
    - COUNT(), SUM(), MIN(), MAX(), AVG()
*/
SELECT
    category_code, COUNT(*) -- category_code 그룹화 숫자
FROM
    tbl_menu
GROUP BY -- DISTINCT 처럼 한개만 남겨줌 (DISTINCT는 지우고 이건 그룹화)
    category_code;


-- GROUP BY 없이 그룹 함수 사용
-- == 테이블 전체 == 한 그룹
SELECT
     COUNT(*)
FROM
    tbl_menu; -- 전체 매뉴 갯수 조회 : 21개

-- COUNT 함수 특징
SELECT
    COUNT(*), -- * : 모든 행 (NULL 포함)
    COUNT(category_code), -- 컬럼 명 기재 : 지정된 컬럼에 값의 갯수(NULL 제외)
    COUNT(ref_category_code) -- NULL 카운트 X
FROM
    tbl_category;

-- SUM, AVG, MIN, MAX
SELECT
    category_code,
    COUNT(*),
    SUM(menu_price),
    AVG(menu_price),
    MAX(menu_price),
    MIN(menu_price)
FROM
    tbl_menu
GROUP BY
    category_code;

-- practice 계정 변환

-- 대소 비교는 숫자, 문자, 날짜 가능
-- 문자 : A < Z
--       ㄱ < 힣
-- 날짜 : 과거 < 미래

SELECT
    MIN(EMP_NAME),
    MAX(EMP_NAME),
    MIN(HIRE_DATE) AS 가장빠른입사일,
    MAX(HIRE_DATE) AS 가장최근입사일
FROM
    employee;

-- swcamp 계정

/*
 GROUP 내 GROUP 만들기 (2개 이상의 GROUP 생성)
  - 큰 그룹 내 소규모 그룹 생성
*/

SELECT
    category_code,
    COUNT(*)
FROM tbl_menu
GROUP BY
    category_code;

SELECT
    category_code,
    menu_price,
    menu_name, -- Group by 절에 없는 항목을 넣으면 테이블이 부정확 할 수 있음
    COUNT(*) -- Group by 가장 끝에 작성된 소규모 그룹에 있는 것을 카운트
FROM tbl_menu
GROUP BY -- 뒤에 작성 될 수록 앞에 포함된 소규모 그룹
    category_code, menu_price;

/*
    tip.
    Group by 절에 언급되지 않은 컬럼명을
    Select 절에 일반 작성하면 정확한 값이 출력되지 않는다!!
*/


/*
    2. HAVING
    - GROUP BY로 만들어진 그룹에 대한 조건을 작성하는 절
    - HAVING 절에는 그룹 함수가 반드시 포함된다. COUNT(), SUM(), MIN(), MAX(), AVG()
*/

SELECT
    category_code,
    SUM(menu_price)
FROM tbl_menu
GROUP BY
    category_code
HAVING SUM(menu_price) < 50000 -- menu_price의 합이 50000을 넘는 값은 보지 않는다.
;


/*
    WHERE : 행 필터링
    HAVING: 그룹 필터링
*/

SELECT
    category_code,
    SUM(menu_price)
FROM tbl_menu
WHERE
    menu_price > 10000
GROUP BY
    category_code
HAVING
    SUM(menu_price) > 50000
ORDER BY
    category_code ASC;

-- tbl_menu에서 price가 10000원 초과인 품목만 고르고
-- 이거를 카테고리 코드별로 묶고
-- 카테고리별 메뉴 가격 합이 50000이 넘는 값만
-- 카테고리 코드 오름차순으로 출력

/*
 ROLLUP
 : 그룹 별 중간 합계, 총 합계 조회
  잘 안씀
*/

SELECT
  category_code
  ,SUM(menu_price)
FROM tbl_menu
GROUP BY category_code
WITH ROLLUP; -- 카테고리 별 총 합

SELECT
    menu_price
    ,category_code
    ,SUM(menu_price)
FROM tbl_menu
GROUP BY menu_price, category_code
WITH ROLLUP
-- ORDER BY menu_price, category_code;