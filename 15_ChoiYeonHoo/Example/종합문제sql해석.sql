SELECT
    a.category_code AS '코드',
    b.category_name '카테고리명',
    AVG(a.menu_price) AS '평균금액'
        -- 4) a의 카테고리 코드
        --    b의 카테고리 네임
        --    카테고리 평균 가격
        -- 3개의 Column만 표현
FROM
    tbl_menu a
        -- 1-1) 테이블 메뉴 a 와
JOIN
    tbl_category b
        -- 1-2) 카테고리 테이블 b 를
ON
    a.category_code = b.category_code
        -- 1-3) category_code로 엮는 새로운 테이블에서
GROUP BY
    a.category_code, b.category_name
        -- 2) 카테고리 코드로 그룹 -> 카테고리 이름 순서로 그룹
 -- 어짜피 1대1 매칭이라 b.category_name을 grouping 할 이유는 없는데
 -- 안하면 SELECT에서 category_name을 보여줄 때 테이블 데이터가 이상 할 수 있어서 추가함
HAVING
    AVG(a.menu_price) >= 8000
        -- 3) 그 중 카테고리 이름 그룹의 평균이 8000 이상인것만 남기고
ORDER BY
    평균금액 ASC
        -- 5) 평균 금액 오름차순으로 정렬 후
LIMIT 0,3
        -- 6) TOP 3값만 표현
;


/*
1. a: tbl_menu 테이블과, b: tbl_category 테이블을
2. a의 category_code와, b의 category_code를 같은값으로 연갈한 테이블을 만들고
3. 상위 a.category_group, 하위 b.category.name으로 그루핑
4. 그룹별 메뉴 평균이 8000 이상인 그룹만 남음
5. 평균금액 오름차순으로 정렬하고
6. 상위 3개 행만 확인

-> 카테고리 코드 및 카테 명으로 그룹을 묶고 메뉴 평균 금액이 8000원이 넘는 그룹 중 싼 그룹 3종류
*/