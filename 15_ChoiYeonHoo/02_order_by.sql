/* 02. ORDER BY
   - RESULT SET 을 정렬하는 구문
    -> RESULT SET이란?
        SELECT문 의 결과 집합 (SELECT 실행해서 조회되는 데이터의 집합)

   - 보통 SELECT 문 가장 마지막에 작성
   - 정렬 방식
    1) ASC : 오름차순(ascending)
    2) DESC : 내림차순(descending)
*/

SELECT
    menu_code,
    menu_name,
    menu_price

FROM tbl_menu

ORDER BY
    -- menu_price ASC; -- 오름차순
    menu_price DESC; -- 내림차순

-- 문자열 컬럼 기준 오름/내림차순

SELECT
    menu_name,
    menu_price
FROM tbl_menu
ORDER BY
    -- menu_name ASC; -- 오름차순
    menu_name DESC; -- 내림차순

-- 컬럼 별로 정렬 기준 설정하기
SELECT
    menu_code,
    menu_name,
    menu_price
FROM
    tbl_menu
ORDER BY
-- menu_price를 우선 내림 차순으로 정렬하고
-- menu_price가 같다면 menu_code를 오름 차순으로 나열한다.
    menu_price DESC,
    menu_code ASC;

SELECT
    menu_code,
    menu_name,
    menu_price
FROM
    tbl_menu
ORDER BY
-- menu_price를 우선 오름 차순으로 정렬하고
-- menu_price가 같다면 menu_name을 오름 차순으로 나열한다.
    menu_price ASC,
    menu_name ASC;


/*
    ORDER BY절 뒤에 컬럼명 외
    연산 결과, 별칭, 컬럼 순서 등을 이용 할 수 있다.
*/

-- 컬럼 순서 사용 ( 추천 X )
 -- -> SELECT 절의 컬럼 순서는 언제든지 바뀔수가 있어 참조하는게 바뀔 수 있음
SELECT
    menu_code,
    menu_name,
    menu_price
FROM
    tbl_menu
ORDER BY
    2 DESC; -- RESULT SET 중 두번째 컬럼(menu_name)을 내림차순 정렬

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
/*
    (중요) ORDER BY 절은 SELECT 절 해석 이후에 적용 된다
    나중에 subquerry 라는걸 사용할 때 주로 사용
*/
SELECT
    menu_code AS '메뉴 코드',
    menu_price AS '메뉴 가격',
    menu_code * menu_price AS '연산 결과'
FROM
    tbl_menu
ORDER BY
    `연산 결과`  DESC; -- 여기를 ``(백틱, esc키 아래)으로 사용, 문자열 모양을 그대로 인식

/*
    DB에서 NULL == "빈칸"을 의미
*/
-- NULL 값의 정렬 방식
/*
    ASC 정렬 시 NULL은 무조건 위쪽
    DESC 정렬 시 NULL은 무조건 아래쪽

    ORDER BY 대상 컬럼 앞에 - 추가 시,
    정렬 방향이 반대로 바뀜
*/
SELECT * FROM tbl_category;

SELECT
    *
FROM
    tbl_category
ORDER BY
    -- ref_category_code ASC; -- NULL이 위쪽, 오름차순
    -- -ref_category_code ASC; -- NULL이 위쪽, 내림차순
    -- ref_category_code DESC; -- NULL이 아래쪽, 내림차순
    -ref_category_code DESC; -- NULL이 아래쪽, 오름차순


/* field(찾을 값, 목록1,목록2,목록3,...) 함수
    - 찾을 값이 목록에 존재 하면 해당 위치(숫자)를 반환
    - 목록에 일치하는 값이 없다면 0을 반환
*/
SELECT FIELD('A','A','B','C'); -- 1
SELECT FIELD('B','A','B','C'); -- 2
SELECT FIELD('C','A','B','C'); -- 3
SELECT FIELD('D','A','B','C'); -- 0

-- field() 함수를 이용하여 정렬하기

SELECT
    menu_name,
    orderable_status,
    FIELD(orderable_status,'Y','N') -- orderable_status의 Y는 1, N은 2로 저장 하는 컬럼 만듦
FROM
    tbl_menu
ORDER BY
    FIELD(orderable_status,'Y','N') ASC -- 만든 컬럼을 오름차순으로 정리;

