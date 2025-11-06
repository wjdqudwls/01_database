/*  03_where
    - 테이블에서 특정 조건에 맞는 레코드(행, row)만 선택하는 구문
    - 조건을 나타내기 위한 각종 연산자를 사용
 */
/*---------------------------------------------------------------------*/

 -- 1) 비교 연산자 ([=], [!=] = [<>] , [<], [>], [<=], [>=])
-- [ = ] : 값이 일치하는지 확인
SELECT
    menu_code,
    menu_name,
    orderable_status
FROM
    tbl_menu
WHERE
    orderable_status='Y' and
    menu_price>10000
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
    menu_price = 13000
ORDER BY
    menu_price DESC;

-- [!=, <>] 같지 않음
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
#     orderable_status != 'Y'
    orderable_status<> 'Y'
ORDER BY
    menu_name ASC;

-- [<, >, <=, >=] 크기 비교
        /*
        초과 <-> 이하
        미만 <-> 이상
        */
-- 메뉴 가격이 20000원 미만인 메뉴의
-- 메뉴명, 가격을
-- 메뉴코드 내림차순으로 조회
SELECT
    menu_name n, menu_price p
FROM
    tbl_menu t
WHERE
    t.menu_price<20000
ORDER BY
    menu_code DESC;
    -- menu_code가 SELECT에 없어도 정렬이 가능한 이유는?
    --  => FROM이 첫번째로 시작된다. 그러므로 눈에 보이지 않더라도
    -- 데이터 값은 캐싱 되어있다
    -- FROM -> WHERE -> SELECT -> ORDER BY

/*---------------------------------------------------------------------*/
/*
 2) 논리 연산자
 - 논리란? 참(TRUE), 거짓(FALSE)을 나타내는 값
 */

-- 2-1) A AND B : A와 B 모두 참(TRUE)인 경우 결과가 TRUE
--           나머진 모두 거짓(FALSE)

-- 주문가능한 상태이며, 카테고리 코드가 10에 해당하는 메뉴만 조회
SELECT
    *
FROM
    tbl_menu
WHERE
    orderable_status = 'Y'
    AND category_code = 10;

-- 메뉴 가격이 5000원 초과이면서 카테고리 번호가 10인 메뉴의
-- 메뉴코드, 메뉴명, 카테고리 코드를
-- 메뉴코드 오름차순으로 조회
SELECT menu_code mc, menu_name mn, category_code cc
FROM tbl_menu tm
WHERE menu_price>5000 AND category_code=10
ORDER BY menu_code ASC;

-- 메뉴 가격이 5000원 이상, 20000원 미만인
-- 메뉴의 메뉴명, 메뉴가격을
-- 메뉴 가격 오름차순으로 조회
SELECT menu_name mn, menu_price mp
FROM tbl_menu tm
WHERE menu_price>=5000 and menu_price<20000
ORDER BY menu_price ASC;

-- 메뉴 가격이 5000원 이상, 20000원 미만
-- 카테고리 코드가 10인
-- 메뉴의 메뉴명, 메뉴가격, 카테고리코드를
-- 메뉴 가격 오름차순으로 조회
SELECT menu_name mn, menu_price mp, category_code cc
FROM tbl_menu tm
WHERE menu_price>=5000 and menu_price<20000 and category_code=10
ORDER BY menu_price ASC;

-- 2-2) A OR B : 둘 중 하나라도 TRUE => TRUE
--               둘 다 FALSE => FALSE

-- 주문가능한 상태 이거나
-- 카테고리코드가 10인 메뉴를 모두 조회
SELECT *
FROM tbl_menu tm
WHERE orderable_status='Y' OR category_code=10;

-- 메뉴가격 5000미만, 20000이상, 메뉴가격 오름차순
SELECT menu_name mn, menu_price mp
FROM tbl_menu tm
WHERE menu_price<5000 OR menu_price>=20000
order by menu_price ASC;

/*
 AND, OR 연산 중 우선순위는
 AND가 높다
 EX) FALSE OR TRUE AND FALSE => FALSE
 */

SELECT *
FROM tbl_menu
WHERE category_code = 4 OR menu_price = 9000;

-- 흑마늘아메리카노, 까나리 코코넛쥬스
SELECT *
FROM tbl_menu
WHERE menu_price = 9000 AND menu_code>10;

SELECT *
FROM tbl_menu
WHERE category_code = 4 OR menu_price = 9000 AND menu_code>10;



--

/*---------------------------------------------------------------------*/
 /*
 3) LIKE 연산자
 -- 문자열% : 해당 문자열로 끝남
 -- %문자열 : 해당 문자열로 시작함
 -- %문자열% : 문자열이 포함됨
 -- ___ : 3글자인 데이터 조회
 */
    SELECT tbl_menu.menu_name
    FROM tbl_menu
    WHERE menu_name LIKE '코%';

    SELECT tbl_menu.menu_name
    FROM tbl_menu
    WHERE menu_name LIKE '%빵';

    SELECT tbl_menu.menu_name
    FROM tbl_menu
    WHERE menu_name LIKE '%마늘%';

    SELECT tbl_menu.menu_name
    FROM tbl_menu
    WHERE menu_name LIKE '%마늘_____';   -- 5글자 메뉴명만 조회

-- NOT LIKE : 문자열 패턴이 일치하지 않는 데이터만 조회

    SELECT tbl_menu.menu_name
    FROM tbl_menu
    WHERE menu_name NOT LIKE '%마늘_____';   -- 5글자 메뉴명만 조회

/*
 만약 4번째 글자가 ‘_’인 자료를 찾고 싶다면?
⇒ Like ‘____%’ 를 쓰면 4글자 이상인 자료를 찾게 됨
⇒ % 와일드 카드를 사용하면 됨
 */

SELECT *
FROM tbl_temp
WHERE temp_email LIKE '___!_%' ESCAPE '!';

/*---------------------------------------------------------------------*/
/*
4) IN/ NOT IN
- 찾는 값이 ( ) 안에 있으면 결과에 포함

    == OR 연산을 연달아 작성하는 효과
 */
SELECT *
FROM tbl_menu t
WHERE category_code = 4
OR category_code = 5
OR category_code = 6
OR category_code = 7
ORDER BY  category_code ASC;

-- =>

SELECT *
FROM tbl_menu t
WHERE category_code IN (4,5,6,10)
ORDER BY  category_code ASC;

SELECT *
FROM tbl_menu t
WHERE category_code NOT IN (4)
ORDER BY  category_code ASC;
/*---------------------------------------------------------------------*/
/*
 5) NULL 관련 연산

 - NULL == 빈칸 (값 X)
 --> 비교연산이 불가능하다!!!
 */
SELECT *
FROM tbl_category
WHERE ref_category_code = NULL; -- 비교 연산 불가

-- IS NULL
SELECT *
FROM tbl_category
WHERE ref_category_code IS NULL;

-- IS NOT NULL
SELECT *
FROM tbl_category
WHERE ref_category_code IS NOT NULL;

/*---------------------------------------------------------------------*/