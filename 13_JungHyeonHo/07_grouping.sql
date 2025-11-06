/*
 07_GROUPING
*/
/*
 7-1. GROUP BY
  - 결과 집합을 특정 컬럼 값에 따라 그룹화
 */

SELECT category_code
FROM tbl_menu
GROUP BY category_code;

SELECT category_code, COUNT(*)
FROM tbl_menu
GROUP BY category_code;

-- GROUP BY 없이 그룹 함수 사용
-- == 테이블 전체 == 한 그룹
SELECT *
FROM tbl_category;

-- COUNT 함수 특징
SELECT COUNT(*),                -- * : 모든 행
       COUNT(ref_category_code) -- 컬럼명 기재 : 지정된 컬럼에 값의 개수(NULL 제외)
FROM tbl_category;

-- SUM, AVG, MAX, MIN 확인
SELECT category_code   카테고리코드,
       COUNT(*)        개수,
       SUM(menu_price) 합,
       AVG(menu_price) 평균,
       MAX(menu_price) 최대,
       MIN(menu_price) 최소
FROM tbl_menu
GROUP BY category_code;

-- practice 계정
-- 대소 비교는 숫자, 문자, 날짜
-- 문자 : (소)A ~ Z(대)
--       (소)ㄱ ~ 힣(대)
-- 날짜 : (소)과거 ~ 미래(대)

SELECT MIN(EMP_NAME),
       MAX(EMP_NAME),
       MIN(HIRE_DATE) AS '가장빠른입사일',
       MAX(HIRE_DATE) AS '가장최근입사일'
FROM employee

-- swcamp 계정

/* 그룹 내 그룹 만들기 (2개 이상의 그룹 생성)
    - 큰 그룹 내 소규모 그룹 구성
   */
SELECT category_code,
       menu_price,
       menu_name, -- GROUP BY 절에서 사용하지 않은 컬럼을 SELECT에서 사용하게 되면, 원하는 결과값을 얻을 수 없음
       COUNT(*)   -- GROUP BY 가장 끝에 작성된 그룹을 기준으로 함수 수행
FROM tbl_menu
GROUP BY category_code, menu_price;
-- 오른쪽에 작성될수록 소규모 그룹

/* TIP) GROUPT BY 절에 언급되지 않은 컬럼명을
   SELECT 절에 일반 작성하면 정확한 값이 출력되지 않는다!!
   => 원하는 컬럼명을 GROUP BY에 적자*/


/*
 7-2. HAVING
 */
SELECT category_code, SUM(menu_price)
FROM tbl_menu\
GROUP BY category_code
HAVING SUM(menu_price) < 50000;

/*
WHERE와 함께 써보자
WHERE : 행 필터링
HAVING : 그룹 필터링
 */

SELECT category_code, SUM(menu_price)
FROM tbl_menu
WHERE menu_price > 10000
GROUP BY category_code
HAVING SUM(menu_price) > 50000
ORDER BY category_code ASC;

/*
 7-3. ROLL UP
 -- ROLLUP : 그룹별 중간 합계, 총 합계 조회
 */
 SELECT
       category_code
     , SUM(menu_price)
 FROM tbl_menu
 GROUP BY category_code;

SELECT
       category_code
     , SUM(menu_price)
 FROM tbl_menu
 GROUP BY category_code
 WITH ROLLUP;

SELECT
       menu_price,
       category_code
     , SUM(menu_price)
 FROM tbl_menu
 GROUP BY menu_price, category_code
 WITH ROLLUP;
# ORDER BY menu_price, category_code;

# 종합문제 - SQL 해석하기
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
 menu랑 category를 category_code 기준으로 JOIN
 CATEGORY_CODE를 기준으로 GROUP화
 GROUP화된 행들의 요소들의 menu_price 평균이 8000이 넘는 그룹에서
 컬럼을 코드, 카테고리명, 평균금액만 추출해서
 평균금액을 기준으로 오름차순 정렬하고
 3개 상위 값들로 구성된 result set을 추출한다
 */