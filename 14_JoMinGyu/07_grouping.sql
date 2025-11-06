select
    category_code, count(*)
from
    tbl_menu
group by
    category_code;

select
    count(*),
    count(ref_category_code)
from
    tbl_category;

select
    category_code,
    count(*),
    SUM(menu_price),
    AVG(menu_price)
from
    tbl_menu
GROUP BY
    category_code;

select
    min(EMP_NAME),
    max(EMP_NAME),
    min(HIRE_DATE) as '가장빠른입사일'
from
    employee;

select
    category_code,
    menu_price,
    menu_name,
    count(*)
from
    tbl_menu
group by
    category_code, menu_price;

select
    category_code,
    sum(menu_price)
from
    tbl_menu
group by
    category_code
HAVING
    sum(menu_price) < 50000;

select
    category_code,
    sum(menu_price)
from
    tbl_menu
where
    menu_price > 10000
group by
    category_code
having
    sum(menu_price) > 50000
order by
    category_code;

select
    menu_price,
    category_code,
    SUM(menu_price)
from
    tbl_menu
group by menu_price, category_code
with rollup;
#order by menu_price, category_code;

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
# 1. 메뉴 테이블과 카테고리 테이블을 카테고리 기준 병합하고,
# 2. 상위항목 카테고리 코드, 하위항목 카테고리 이름별로 그룹화한다.
# 3. 평균 메뉴 가격이 8000 이상인 그룹만 남긴다.
# 4. 카테고리 코드, 카테고리 이름, 평균금액 열만 남긴다.
# 5. 평균금액 오름차순으로 정렬하고,
# 6. 상위 3개 항목만 남긴다.

