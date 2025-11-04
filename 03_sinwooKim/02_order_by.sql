/*
02. ORDER BY
    - RESULT SET을 정렬하는 구문
        -> RESULT SET: SELECT문의 결과 집합
    - 보통 SELECT문 마지막에 작성
    - 정렬방식
        1) 오름차순: ASC
        2) 내림차순: DESC
*/

-- 오름차순
SELECT menu_code,menu_name,menu_price FROM tbl_menu ORDER BY menu_price ASC;

-- 내림차순
SELECT menu_code,menu_name,menu_price FROM tbl_menu ORDER BY menu_price DESC;

-- 문자열 컬럼 기준 오름/내림차순
SELECT menu_name FROM tbl_menu ORDER BY menu_name ASC ;
SELECT menu_name FROM tbl_menu ORDER BY menu_name DESC ;

-- 가격 내림차순, 같으면 이름 오름차순
SELECT menu_code, menu_name, menu_price
FROM tbl_menu
ORDER BY menu_price DESC, menu_name ASC;

-- 가격 오름차순, 같으면 이름 오름차순
SELECT menu_code, menu_name, menu_price
FROM tbl_menu
ORDER BY menu_price ASC, menu_name ASC;

-- ORDER BY절에는 컬럼명 외에 연산 결과, 별칭, 컬럼 순서 등을 이용할 수 있다.

-- 컬럼 순서 사용(추천 x) -> SELECT절의 컬럼 순서는 언제든지 바뀔 수 있다.
SELECT menu_code, menu_name, menu_price
FROM tbl_menu
ORDER BY 2 DESC;
-- RESULT SET중 두번째 column을 내림차순 정렬

-- 연산 결과를 이용한 정렬
SELECT menu_code, menu_price, menu_code * menu_price
FROM tbl_menu
ORDER BY menu_code * menu_price ASC;

-- 별칭을 이용한 정렬
-- (중요) ORDER BY절은 SELECT 해석 이후에 적용된다!!
SELECT menu_code AS '메뉴 코드', menu_price AS '메뉴 가격', menu_code * menu_price AS '연산 결과'
FROM tbl_menu
ORDER BY `연산 결과` DESC;

-- DB에서 NULL은 "빈칸"을 의미한다!!!
-- NULL 값의 정렬 방식
/*
ASC 정렬 시 NULL은 무조건 윗쪽
DESC 정렬 시 NULL은 무조건 아래쪽

ORDER BY 대상 컬럼명 앞에 '-' 추가 시 정렬 방향이 반대로 바뀜.
*/
SELECT *
FROM tbl_category;

SELECT *
FROM tbl_category
ORDER BY ref_category_code ASC ; -- NULL값이 위에 존재, 오름차순

SELECT *
FROM tbl_category
ORDER BY ref_category_code DESC ; -- NULL값이 아래 존재, 내림차순

SELECT *
FROM tbl_category
ORDER BY -ref_category_code ASC ; -- NULL값이 위에 존재, 내림차순

SELECT *
FROM tbl_category
ORDER BY -ref_category_code DESC ; -- NULL값이 위에 존재, 오름차순

/*
field(찾을 값, 목록 1, 목록 2, .....) 함수
    - 찾을 값이 목록에 존재하면 해당 위치(숫자)를 반환
    - 목록에 일치하는 값이 없다면 '0'을 반환한다
*/
SELECT FIELD('A','A','B','C'); -- 1
SELECT FIELD('B','A','B','C'); -- 2
SELECT FIELD('C','A','B','C'); -- 3
SELECT FIELD('D','A','B','C'); -- 0

-- field() 함수를 이용해 정렬하기
-- --> 정렬 우선 순위 적용
SELECT menu_name, orderable_status, FIELD(orderable_status, 'Y', 'N')
FROM tbl_menu
ORDER BY FIELD(orderable_status, 'Y', 'N') ASC;

