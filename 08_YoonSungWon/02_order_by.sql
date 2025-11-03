/* 02. ORDER BY
 - RESULT SET을 정렬하는 구문
   -> RESULT SET이란?
      SELECT문의 결과 집합(SELECT 실행해서 조회되는 데이터의 집합)


 - 보톤 SELECT문 제일 마지막에 작성


 - 정렬 방식
   1) ASC  : 오른차순(ascending)
   2) DESC : 내림차순(descending)
 */

#  SELECT menu_code,menu_name,menu_price FROM tbl_menu ORDER BY  menu_price ASC;
 SELECT
     menu_code,menu_name,menu_price
 FROM
     tbl_menu
 ORDER BY
     menu_price DESC;


-- 문자열 컬럼 기준 오름/내림차순
SELECT
    menu_name
FROM tbl_menu
# ORDER BY menu_name ASC;
ORDER BY menu_name DESC;


-- 컬럼별로 정렬기준 설정하기
SELECT
    menu_code,menu_name,menu_price
FROM
    tbl_menu
ORDER BY
    menu_price DESC,
    menu_code ASC;


-- 가격 오름차순, 같으면 이름 오름차순
SELECT
    menu_code,menu_name,menu_price
FROM
    tbl_menu
ORDER BY
    menu_price ASC,
    menu_name ASC,
    menu_code DESC;


/*
    ORDER BY 절에는 컬럼명 외에
    연산 결과, 별칭, 컬럼 순서 등을 이용할 수 있다
*/



-- 컬럼 순서 사용
    -- 추천하지 않는 이유: SELECT 절의 컬럼 순서는 언제든지 바뀔 수 있다.
SELECT
    menu_code,menu_name,menu_price
FROM
    tbl_menu
ORDER BY
    2 DESC; -- RESULT SET 중 2번째 컬럼(menu_name) 내림차순 정렬


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
    (중요)ORDER BY절은 SELECT 해석 이후에 적용된다.
*/

SELECT
    menu_code AS '메뉴 코드',
    menu_price AS '메뉴 가격',
    menu_code * menu_price AS '연산 결과'
FROM
    tbl_menu
ORDER BY
    `연산 결과` DESC;
-- ``(백틱) 문자열 모양을 그대로 인식


/*
    DB에서 NULL == "빈칸"을 의미!!!
*/
-- NULL 값의 정렬 방식
SELECT  * FROM tbl_category;

/*
    ASC 정렬 시 NULL은 무조건 윗쪽
    DESC 정렬 시 NULL은 무조건 아래쪽

    ORDER BY 대상 컬럼명 앞에 - 추가 시
    정렬 방향이 반대로 바뀜
*/

SELECT
    *
FROM
    tbl_category
ORDER BY
#     ref_category_code ASC;  -- NULL 위쪽, 오름차순
#     -ref_category_code ASC;  -- NULL 위쪽, 내림차순
#     ref_category_code DESC;  -- NULL 아래쪽, 내림차순
    -ref_category_code DESC;  -- NULL 아래쪽, 오름차순



/*
    field(찾을 값, 목록1,목록2, ....) 함수
    - 찾을 값이 목록에 존재하면 해당 위치(숫자)를 반환
    - 목록에 일치하는 값이 없다면 0 반환
*/

SELECT FIELD('A', 'A', 'B', 'C');
SELECT FIELD('B', 'A', 'B', 'C');
SELECT FIELD('C', 'A', 'B', 'C');
SELECT FIELD('D', 'A', 'B', 'C');


-- field() 함수를 이용해 정렬하기
-- 정렬 우선 순위 적용
SELECT
    menu_name,
    orderable_status,
    FIELD(orderable_status, 'Y','N')
FROM
    tbl_menu
ORDER BY
    FIELD(orderable_status, 'Y','N') ASC;
