/*
    07_GROUPING

    1. GROUP BY
     - 결과 집합을 특정 컬럼 값에 따라 그룹화
*/

/*
    그룹 함수
    - 전체 테이블 또는 GROUP이 지어진 결과 집합에
    사용 가능한 함수
    - COUNT(), SUM(), MIN(), MAX(), AVG()
*/
SELECT
    category_code, COUNT(*) -- 그룹화된 행 전체 몇개냐 // * : 전체
FROM
    tbl_menu
GROUP BY
    category_code;


-- GROUP BY 없이 그룹 함수 사용
-- == 테이블 전체 == 한 그룹

SELECT
    COUNT(*)
FROM
    tbl_menu; -- 전체 메뉴 개수 조회 (21개)

-- COUNT 함수 특징
SELECT * FROM tbl_category;

SELECT
    COUNT(*),                   -- * : 모든 행 (NULL 포함)
    COUNT(category_code),      -- 컬럼 명 기재 : 지정된 컬럼에 값의 개수(NULL 제외)
    COUNT(ref_category_code)    -- NULL 카운트 X
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

-- practice 계정
-- 대소 비교는 숫자, 문자, 날짜 가능
-- 문자 : A(소) ~ Z (대)
--      ㄱ(소) ~ 힣(대)
-- 날짜 : 과거(소) ~ 미래(대)

SELECT
    MIN(emp_name), -- 출석부 맨 뒤 이름 아래 이름
    MAX(emp_name),
    MIN(hire_date) AS '가장빠른입사일',
    MAX(hire_date) AS '가장최근입사일'
FROM
    employee;

-- swcmap 계정

/*
    그룹 내 그룹 만들기 (2개 이상의 그룹 생성)
    - 큰 그룹 내 소규모 그룹 구성
*/

-- 같은 가격 몇개있는지 그룹화
SELECT
    menu_price,
    count(*)
FROM
    tbl_menu
GROUP BY
    menu_price;


SELECT
    category_code,
    menu_price,
   -- menu_name,
    count(*) -- GROUP BY 가장 끝에 작성된 그룹을 기준으로 함수 수행
FROM
    tbl_menu
GROUP BY
    category_code, menu_price; -- 오른쪽에 작성될 수록 왼쪽 그룹에 포함된 소규모 그룹


/*

 tip ) GROUP BY 절에 언급되지 않은 컬럼명을
 SELETE 절에 일반 작성하면 정확한 값이 출력되지 않는다!!!!

*/

/*

    2. HAVING
    - GROUP BY로 만들어진 그룹에 대한 조건 작성하는 젛
    - HAVING  절에는 그룹함수가 반드시 포함된다
*/

SELECT
   category_code,
   SUM(menu_price)
FROM
    tbl_menu
GROUP BY
    category_code
HAVING
    SUM(menu_price) < 50000 ; -- 50000원 안되는 것만 보고싶다

-- WHERE HAVING 헷갈림

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
-- 50000원 넘는 그룹 보고싶을 떄
HAVING
    SUM(menu_price) > 50000 -- 그룹 메뉴 가격 합이 5만원 초과인 그룹만 조회
ORDER BY
    category_code ASC ;

SELECT
    category_code,
    SUM(menu_price)
FROM
    tbl_menu
WHERE
     SUM(menu_price)menu_price > 10000 --> -- WHERE절에 그룹함수 사용 불가
ORDER BY
    category_code ASC ;


-- ROLLUP : 그룹 별 중간 합계, 총 합계 조회
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
-- ORDER BY menu_price, category_code ASC;

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

/*

 1. FROM 절 JOIN 시키면 큰 테이블 만들어짐
 큰 표 안에서 GROUP BY code, name 그룹화

*/

