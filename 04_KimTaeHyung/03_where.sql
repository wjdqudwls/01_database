/*
    03_where
    - 테이블에서 특정 조건에 맞는 레코드(행, row)만 선택하는 구문
    - 조건을 나타내기 위한 각종 연산자를 사용
*/

-- 1) 비교 연산자 (=, !=, <>, <, >, <=, >=)

-- [ = ] : 값이 일치하는지 확인
SELECT
    menu_code,
    menu_name,
    orderable_status
FROM
    tbl_menu
WHERE
    orderable_status = 'Y'
ORDER BY
    menu_name ASC;

-- 이름이 '붕어빵초밥'인 메뉴 조회
SELECT
    *
FROM
    tbl_menu
WHERE
    menu_name = '붕어빵초밥';

-- 메뉴 가격이 13000인 메뉴의
-- 메뉴명, 가격을
-- 메뉴명 내림 차순으로 조회

SELECT
    menu_name,
    menu_price
FROM
    tbl_menu
WHERE
    menu_price = '13000'
ORDER BY
    menu_name DESC;


-- [ !=, <> ]같지 않음
-- 주문가능상태가 'Y'가 아닌 메뉴의
-- 메뉴코드, 메뉴명, 주문가능상태를
-- 메뉴명 오름차순으로 조회

SELECT
    menu_code,
    menu_name,
    orderable_status
FROM
    tbl_menu
WHERE
--    orderable_status != 'Y'
    orderable_status <> 'Y'
ORDER BY
    menu_name ASC;


-- 대소 비교(초과, 미만, 이상, 이하)
-- 메뉴 가격이 20000원 초과인 메뉴의
-- 메뉴명, 가격을
-- 메뉴코드 내림차순으로 조회
-- caching
SELECT
    menu_name,
    menu_price
FROM
    tbl_menu
WHERE
    menu_price >= 20000
ORDER BY
    menu_code DESC;

/*
    2) 논리 연산자
    - 논리란? 참(TRUE), 거짓(FALSE)을 나타내는 값
*/

-- A AND B : A와 B 모두 참(TRUE)인 경우 결과가 TRUE
--           나머진 모두 거짓(FALSE)

-- 주문가능한 상태이며, 카테고리 코드가 10에 해당하는 메뉴만 조회
SELECT
    *
FROM
    tbl_menu
WHERE
    orderable_status = 'Y'
AND
    category_code = 10;

-- 메뉴 가격이 5000원 초과이면서 카테고리 번호가 10인 메뉴의
-- 메뉴코드, 메뉴명, 카테고리 코드를
-- 메뉴코드 오름차순으로 조회

SELECT
    menu_code,
    menu_name,
    category_code
FROM
    tbl_menu
WHERE
    menu_price > 5000
AND
    category_code = 10
ORDER BY
    menu_code ASC;



-- 메뉴 가격이 5000원 이상, 20000원 미만인
-- 메뉴의 메뉴명, 메뉴가격을
-- 메뉴 가격 오름 차순으로 조회

SELECT
    menu_name,
    menu_price
FROM
    tbl_menu
WHERE
    menu_price >= 5000
AND
    menu_price < 20000
ORDER BY
    menu_price ASC;

-- 메뉴 가격이 5000원 이상, 20000원 미만
-- 카테고리 코드가 10
-- 메뉴의 메뉴명, 메뉴가격, 카테고리코드를
-- 메뉴 가격 오름 차순으로 조회

SELECT
    menu_name,
    menu_price,
    category_code
FROM
    tbl_menu
WHERE
    menu_price >= 5000
AND
    menu_price < 20000
AND
    category_code = 10
ORDER BY
    menu_price ASC;

/* A OR B
   - 둘 다 FALSE인 경우에만 결과가 FALSE
   - 하나라도 TRUE이면 TRUE
*/

-- 주문가능한 상태 이거나
-- 카테고리코드가 10인 메뉴를 모두 조회
SELECT
    *
FROM
    tbl_menu
WHERE
    orderable_status = 'Y'
OR
    category_code = 10;


-- 메뉴 가격이 5000원 미만, 20000원 이상인
-- 메뉴의 메뉴명, 메뉴가격을
-- 메뉴 가격 오름 차순으로 조회
SELECT
    menu_name,
    menu_price
FROM
    tbl_menu
WHERE
    menu_price < 5000
OR
    menu_price >= 20000
ORDER BY
    menu_price ASC;


/*
    AND, OR 연산 중 우선순위는
    AND가 높다!!

    * 우선순위 문제 해결 시 () 이용!!
*/

SELECT
    *
FROM
    tbl_menu
WHERE
    (category_code = 4
OR
    menu_price = 9000)
AND
    menu_code > 6;


