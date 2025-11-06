-- SUM, AVG, MAX, MIN 확인

-- practice 계정 --
-- 대소 비교는 숫자, 문자, 날짜 가능
-- 문자 : (소)A ~ z(대)
--         (소)ㄱ ~ ㅎ(대)
-- 날짜 : (소)과거 ~ 미래(대)

SELECT
    MIN(employee.EMP_NAME),
    MAX(employee.EMP_NAME),
    MIN(employee.HIRE_DATE) AS '가장빠른입사일',
    MAX(employee.HIRE_DATE) AS '가장최근입사일'
FROM
    employee;

-- swcamp계정 --

/* 그룹 내 그룹 마듥기 (2개 이상의 그룹 생성)
   - 큰 그룹 내 소규모 그룹 구성
 */

SELECT
    menu_price,
    COUNT(*)
FROM
    tbl_menu
GROUP BY
    menu_price;

SELECT
    category_code,
    menu_price,
--  menu_name,
    COUNT(*) -- GROUP BY 가장 끝에 작성된 그룹을 기준으로 함수 수행
FROM
    tbl_menu
GROUP BY
    category_code, menu_price:
-- 오른쪽에 작성될 수록 왼쪽 그룹에 포함된 소규모 그룹
/* tip.
   GROUP BY 절에 언급되지 않은 컬럼명을
   SELECT 절에 일반 작성하면 정확한 값이 출력되지 않는다!!
 */

/*
  2. HAVING
  - GROUP BY로 만들어진 그룹에 대한 조건을 작성하는 절
  - HAVING 절에는 그룹 함수가 반드시 포함된다
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
    SUM(menu_price) > 50000 -- 그룹 메뉴 가격 합이 5만원 초과인 그룹만 조회
ORDER BY
    category_code ASC;

-- HAVING 절을 WHERE 절로 이동하면 될까?
SELECT
  category_code,
  SUM(menu_price)
FROM
    tbl_menu
WHERE
    sum(menu_price) > 50000  -- 10000원 미만 메뉴 제외
GROUP BY
    category_code
ORDER BY
    category_code ASC;

-- ROLLUP  그룹별 중간 합계, 총 합계 조회

    SELECT
       category_code
     , SUM(menu_price)
 FROM tbl_menu
 GROUP BY category_code
 WITH ROLLUP;
/*SELECT
    category_code,
    SUM(menu_price)
    FROM
        tbl_menu
GROUP BY
    category_code
WITH ROLLUP:

 */

SELECT
       menu_price
     , category_code
     , SUM(menu_price)
  FROM tbl_menu
 GROUP BY menu_price, category_code
  WITH ROLLUP;

SELECT
       menu_price
     , category_code
     , SUM(menu_price)
  FROM tbl_menu
 GROUP BY menu_price, category_code
 WITH ROLLUP
ORDER BY  menu_price, category_code;
--      WITH ROLLUP; -- ORDER BY 말고 GROUP BY에 붙여야함

-- 해석 순서 예제
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
/* 프롬절을 먼저보고 조인을 보고

 */
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
    a.category_code, b.category_name       -- 여기까지 실행하면 그룹별 메뉴 평균
HAVING
    AVG(a.menu_price) >= 8000
ORDER BY
    a.category_code, b.category_name
