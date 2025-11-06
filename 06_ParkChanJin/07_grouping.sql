/*  07_GROUPING

    1. GROUP BY
    - 결과 집합을 특정 컬럼 값에 따라 그룹화
*/

/*  그룹 함수
    - 전체 테이블 또는 GROUP이 지어진 결과 집합에 사용 가능한 함수
    - COUNT(), SUM(), MIN(), MAX(), AVG()
*/
SELECT
    category_code, COUNT(*)
FROM
    tbl_menu
GROUP BY
    category_code;



-- GROUP BY 없이 그룹 함수 사용
-- == 테이블 전체 == 한 그룹
SELECT
    COUNT(*)
FROM tbl_menu; -- 전체 메뉴 개수 조회



-- COUNT 함수 특징
SELECT * FROM tbl_category
SELECT
    COUNT(*),     -- * : 모든 행(NULL 포함)
    COUNT(category_code), -- 컬럼명 기재 : 지정된 컬럼에 값의 개수(NULL 제외)
    COUNT(ref_category_code)   -- NULL 카운트 X
FROM
    tbl_category;



-- SUM, AVG, MAX, MIN 확인
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


-- practice 계정 --
-- 대소 비교는 숫자, 문자, 날짜 가능
-- 문자 : (소)A ~ Z(대)
--       (소) ㄱ ~ 힣(대)
-- 날짜 : (소)과거 ~ 미래(대)

SELECT
    MIN(EMP_NAME),
    MAX(EMP_NAME),
    MIN(HIRE_DATE) AS '가장 빠른 입사일',
    MAX(HIRE_DATE) AS '가장 최근 입사일'
FROM
    employee;



-- swcamp 계정 --

/*  그룹 내 그룹 만들기 (2개 이상의 그룹 생성)
    - 큰 그룹 내 소규모 그룹 구성
*/

SELECT
    category_code,
    menu_price, -- GROUP BY 가장 끝에 작성된 그룹을 기준을 함수 수행
    -- menu_name,
    COUNT(*)
FROM
    tbl_menu
GROUP BY
    category_code, menu_price;
-- 오른쪽에 작성 될 수록 왼쪽 그룹에 포함된 소규모 그룹

/* tip.
   GROUP BY 절에 언급되지 않은 컬럼명을
   SELECT 절에 일반 작성하면 정확한 값이 출력되지 않는다!
   정확한 값을 보고싶으면 SELECT, GROUP BY절 모두 작성하면됨!
*/

/*
    2. HAVING
    - GROUP BY로 만들어진 그룹에 대한 조건을 작성하는 절
    - HAVING절에는 그룹 함수가 반드시 포함된다
*/

SELECT
    category_code,
    SUM(menu_price)
FROM
    tbl_menu
GROUP BY
    category_code
HAVING
    SUM(menu_price) < 50000;


/*
    WHERE : 행 필터링
    HAVING : 그룹 필터링
*/

SELECT
    category_code,
    SUM(menu_price)
FROM
    tbl_menu
WHERE
    menu_price > 10000 -- 10000원 미만 메뉴 제외
GROUP BY
    category_code
HAVING
    SUM(menu_price) > 50000
ORDER BY
    category_code ASC;

-- ROLLUP : 그룹별 중간 합계, 총 합계 조회
SELECT
       category_code
     , SUM(menu_price)
 FROM tbl_menu
 GROUP BY category_code
 WITH ROLLUP;



SELECT
       menu_price
     , category_code
     , SUM(menu_price)
FROM tbl_menu
GROUP BY menu_price, category_code
WITH ROLLUP;
-- ORDER BY menu_price, category_code ASC



-- 종합 문제 - SQL 해석하기
SELECT
    a.category_code AS '코드',
    b.category_name '카테고리명',
    AVG(a.menu_price) AS '평균금액'
FROM
    tbl_menu a
JOIN
    tbl_category b
ON
    a.category_code = b.category_code
GROUP BY
    a.category_code, b.category_name
HAVING
    AVG(a.menu_price) >= 8000
ORDER BY
    평균금액 ASC
LIMIT 0,3;