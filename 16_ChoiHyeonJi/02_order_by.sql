/* 02. ORDER BY
   - RESULT SET을 정렬하는 구문
   -> RESULT SET 이란?
    SELECT문의 결과 집합 (SELECT 실행해서 조회되는 데이터의 집합)

   - 보통 SELECT문 제일 마지막에 작성
   - 정렬 방식
    1) ASC : 오름차순(ascending)
    2) DESC : 내림차순(descending)
*/

SELECT
    menu_code,
    menu_name,
    menu_price
FROM
    tbl_menu
ORDER BY
    -- menu_price ASC; -- 오름차순
    menu_price DESC; -- 내림차순

-- 문자열 컬럼 기준 오름/내림차순
SELECT menu_name
FROM tbl_menu
-- ORDER BY menu_name ASC;
ORDER BY menu_name DESC;

-- 컬럼별로 정렬 기준 설정하기
SELECT menu_code,
       menu_name,
       menu_price
FROM tbl_menu
ORDER BY menu_price DESC,
         menu_code ASC; -- 아무것도 안 적음 = 기본값이 오름차순 -- 같은 가격이면 메뉴 코드 오름차순으로 정렬하라(이 줄에서 알려줌)



-- 가격 오름차순, 같으면 이름 오름차순
SELECT menu_code,
       menu_name,
       menu_price
FROM tbl_menu
ORDER BY menu_price ASC,
         menu_name ASC,
         menu_code DESC; --  같으면 CODE 내림차순으로 정렬하겠다는 뜻

/*
-- ORDER BY 절에는 컬럼명 외
연산 결과, 별칭, 컬럼 순서 등을 이용할 수 있다.
*/

-- 컬럼 순서 사용 추천 x
-- SELECT 절의 컬럼 순서는 언제든지 바뀔 수 있음
SELECT
       7+3 AS 더하기, -- 이게 1번이 되어버림
       menu_code,
       menu_name,
       menu_price
FROM tbl_menu -- 결과에는 RESULT SET 보임
ORDER BY
    2 DESC; -- RESULT SET 중 2번째 컬럼(menu_name) 내림차순 정렬

-- 한 컬럼만 조회할 때 많이 씀

-- 연산 결과를 이용한 정렬
SELECT
    menu_code,
    menu_price,
    menu_code * menu_price
FROM tbl_menu
ORDER BY menu_code * menu_price DESC; -- DESC 앞에 컬럼명 뿐만 아니라 연산도 쓸 수 있음


-- 별칭 이용하여 정렬
/*
(중요) ORDER BY 절은 SELECT 해석 이후에 적용된다
서브쿼리 사용할 때 많이사용
*/

SELECT
    menu_code AS '메뉴코드', -- ' ' 안에 들어간게 별칭
    menu_price AS '메뉴가격',
    menu_code * menu_price AS '연산 결과' -- 2번 코드,가격,결과 해석
FROM tbl_menu -- 1번
ORDER BY
    `연산 결과` DESC; -- 3번 연산 결과라고 똑같이 적으면 됨. ` ` 백틱으로 써야함

-- `` (백틱) 문자열 모양을 그대로 인식


/*
    DB에서 NULL == "빈칸" 을 의미!!
*/
-- NULLL  값의 정렬 방식
SELECT * FROM tbl_category; -- null 빈칸


/*

ASC 정렬 시 NULL은 무조건 위쪽
DESC 정렬 시 NULL은 무조건 아래쪽

ORDER BY 대상 컬럼명 앞에 - 추가 시
정렬 방향이 반대로 바뀜

*/

SELECT
    category_code,
    category_name,
    ref_category_code

FROM tbl_category
ORDER BY
    -- ref_category_code ASC; -- NULL이 위쪽 오름차순
    -- -ref_category_code ASC; -- NULL이 위쪽 내림차순
    -- ref_category_code DESC ; -- NULL이 아래쪽 내림차순
    -ref_category_code DESC ; -- NULL이 아래쪽, 오름차순

/*
field(찾을 값, 목록1, 목록2, ...) 함수
    - 찾을 값이 목록에 존재하면 해당 위치(숫자)를 반환
    - 목록에 일치하는 값이 없다면 0 반환
*/
SELECT FIELD('A', 'A', 'B', 'C'); -- 1
SELECT FIELD('B', 'A', 'B', 'C');  -- 'B' 뒤에 순서대로 1 2 3  --2
SELECT FIELD('C', 'A', 'B', 'C'); -- 3
SELECT FIELD('D', 'A', 'B', 'C'); -- 0


-- field() 함수를 이용해 정렬하기
SELECT
    menu_name,
    orderable_status,
    FIELD(orderable_status, 'Y', 'N') -- orderable_status에 Y가 몇번째에 존재 1 // 1, 2

FROM
    tbl_menu -- ctrl 클릭하면 자세하게 보임
    order by FIELD(orderable_status, 'Y', 'N')  ASC; -- 정렬 순서 정리