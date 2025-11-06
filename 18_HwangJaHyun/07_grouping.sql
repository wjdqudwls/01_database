/*
select 5어떤 컬럼
from 1테이블 선택 (+ join)
where 2행 필터링
group by 3그룹화
having 4그룹화 필터링
order by 6정렬순서
LIMIT 7 조회 행수 제한
*/

/*
    07_grouping

    1. GROUP BY
    결과 집합을 특정 컬럼 값에 따라 그룹화

    그룹함수
    전체 테이블 또는 GROUP이 지어진 결과 집합에 사용 가능한 함수
    COUNT(), SUM(), MIN(), MAX(), AVG()
*/

SELECT
    category_code, COUNT(*)
FROM
    tbl_menu
GROUP BY
    category_code;
-- DISTINCT는 중복제거
-- GROUP BY는 같은 거 묶기

-- GROUP BY 없이 그룹함수 사용
-- ==테이블 전체 == 한 그룹
SELECT
    COUNT(*)
FROM
    tbl_menu;
-- 전체 메뉴 개수 조회

-- COUNT 함수 특징
SELECT
    COUNT(*), -- * : 모든 행(NULL 포함)
    COUNT(category_code), -- 컬럼명 기재 : 지정된 컬럼의 값 개수(NULL 제외)
    COUNT(ref_category_code)
FROM
    tbl_category;

-- SUM, AVG, MAX, MIN확인
SELECT
    tbl_menu.category_code,
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
-- 문자 (소)A ~ Z(대)
--     (소)ㄱ ~ 힣(대)
-- 날짜: (소)과거 ~ 미래(대)
--     19980817  20251104

SELECT
    MIN(emp_name),
    MAX(emp_name),
    MIN(HIRE_DATE) as '가장 빠른 입사일',
    MAX(HIRE_DATE) as '가장 최근 입사일'
FROM
    employee;

-- swcamp계정
/*
    그룹 내 그룹 만들기(2개 이상의 그룹 생성)
    큰 그룹 내 소규모 그룹 구성
*/
SELECT
    category_code,
    menu_price,
    -- menu_name,
    COUNT(*) -- GROUP BY 가장 끝에 작성된 그룹을 기준으로 함수 수행
FROM
    tbl_menu
GROUP BY
    category_code, menu_price;
-- 오른쪽에 작성될 수록 왼쪽 그룹에 포함된 소규모 그룹
/*
    Tip.
    GROUP BY절에 언급되지 않은 컬럼명은
    SELECT 절에 일반 작성하면 정확한 값이 출력되지 않는다.
*/

/*
    2. HAVING
    GROUP BY로 만들어진 그룹에 대한 조건을 작성하는 절
    HAVING 절에는 그룹함수가 반드시 포함된다.
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
/*
 tbl_menu에서
 menu_price가 10000 초과인것만
 category_code가 같은 것 끼리 그룹화
 그룹화 한것의 합계가 50000원 초과일 경우만
 오름차순으로 정렬
*/


/*
    ROLLUP: 그룹별 중간 합계, 총 합계 조회
*/
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
-- ORDER BY menu_price, category_code
-- 소규모 그룹의 합이 중간중간에
-- 전체합은 가장 밑에


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
    tbl_menu, tbl_category join -> 큰 테이블
    tbl_menu.category_code로 group화
    tbl_category.category_name으로 그룹화

 */
