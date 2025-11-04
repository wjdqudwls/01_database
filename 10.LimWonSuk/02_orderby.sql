/* 02. ORDER BY
   - RESULT SET을 정렬하는 구문
    -> RESULT SET이란?
        SELECT문의 결과 집합 (SELECT 실행해서 조회되는 데이터의 집합)

   - 보통 SELECT문 제일 마지막에 작성

   - 정렬 방식
        1) ASC : 오름차순(ascening)
        2) DESC : 내림차순(descening)
 */

 SELECT
     menu_code,
     menu_name,
     menu_price
 FROM
     tbl_menu
 ORDER BY
     menu_price ASC; -- 오름차순

SELECT
     menu_code,
     menu_name,
     menu_price
 FROM
     tbl_menu
 ORDER BY
     menu_price DESC; -- 내림차순

-- 문자열 컬럼기준 오름/내림차순
SELECT menu_name
FROM    tbl_menu
ORDER BY menu_name ASC;

SELECT menu_name
FROM    tbl_menu
ORDER BY menu_name DESC;
-- ORDER BY menu_name ASC;

-- 컬럼 별로 정렬기준 설정하기

SELECT
    menu_name,
    menu_code,
    menu_price
FROM
    tbl_menu
ORDER BY
    menu_price DESC,
    menu_code ASC;
-- 정렬방식

SELECT
    menu_name,
    menu_code,
    menu_price
FROM
    tbl_menu
ORDER BY
    menu_price ASC,
    menu_code ASC;
-- 가격 오름차순에서 , 가격이같으면 이름순으로 나열

SELECT
    menu_name,
    menu_code,
    menu_price
FROM
    tbl_menu
ORDER BY
    menu_price ASC,
    menu_code ASC,
    menu_price DESC;
-- 가격 오름차순에서 , 가격이같으면 이름순으로 나열 , 가격은 내림차순

/*
 ORDER BY절에는 컬럼명 외에
 연산결과, 별칭, 컬럼 순서 등을 이용할 수 있다.
 */

-- 컬럼 순서 사용
    -- 추천하지 않는 이유 : SELECT절의 컬럼 순서는 언제든지 바뀔수있기 때문에 숫자는추천않함
        -- 한컬럼만 사용할경우 숫자사용함 (바뀔일이없기때문)
SELECT
    menu_name,
    menu_code,
    menu_price
FROM
    tbl_menu
ORDER BY
    2 DESC;
-- RESULT SET 중 2번째 컬럼(menu_name)을 내림차순으로 변경

-- 연산 결과를 이용한 정렬
SELECT
    menu_code,
    menu_price,
    menu_code * menu_price
FROM
    tbl_menu
ORDER BY
    menu_code * menu_price DESC;

-- 별칭을 이용하여 정렬
/*    (중요) ORDER BY절은 SELECT 해석 이후에 적용된다!
      1_FROM, 2_SELECT, 3_ORDDER BY */

SELECT
    menu_code AS '메뉴 코드',
    menu_price AS '메뉴 가격',
    menu_code * menu_price AS '연산 결과'
FROM
    tbl_menu
ORDER BY
    `연산 결과` DESC;

-- ` = 문자열 모양을 그대로 표시하기 때문에 `(백틱) 이용


/*
    DB에서 NULL == "빈칸"을 의미 !!!
 */
-- NULL 값의 정렬 방식
SELECT * FROM tbl_category;

SELECT
    category_code,
    category_name,
    ref_category_code
FROM
    tbl_category
ORDER BY
 ref_category_code ASC; -- NULL 윗쪽존재
 --   ref_category_code DESC; -- NULL 윗쪽존재


/*
 ASC 정렬 시 NULL은 무조건 윗쪽
 DESC 정렬 시 NULL은 무조건 아랫쪽

 ORDER BY 대상 컬럼명 앞에 - 추가 시


SELECT
    category_code,
    category_name,
    ref_category_code
FROM
    tbl_category
ORDER BY
--    ref_category_code ASC; -- NULL 윗쪽존재, 오름차순
--    ref_category_code ASC; -- NULL 윗쪽존재, 내림차순
--    ref_category_code DESC; -- NULL 아래쪽존재, 내림차순
      ref_category_code DESC; -- NULL 아래쪽존재, 오림차순




 /* field(찾을 값, 목록1, 목록2, ...)함수
    -찾을 값이 목록에 존재하면 해당 위치(숫자)를
 */

SELECT FIELD('A','A','B','C');  -- 1
SELECT FIELD('B','A','B','C');  -- 2
SELECT FIELD('C','A','B','C');  -- 3
SELECT FIELD('D','A','B','C');  -- 0

-- field() 함수를 이용해 정렬하기
SELECT
    menu_name,
    tbl_menu.orderable_status,
    FIELD(orderable_status, 'Y', 'N')
FROM
    tbl_menu
ORDER BY
    FIELD(orderable_status, 'Y', 'N') ASC;

