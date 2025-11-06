-- 서브쿼리 예시

-- '민트미역국'과 같은 카테고리의 메뉴를 모두 조회하시오

-- 1) '민트미역국'의 카테고리코드 찾기
SELECT
    category_code
FROM
    tbl_menu
WHERE
    menu_name = '민트미역국'; -- 4


-- 2) 카테고리 코드가 4인 메뉴 모두 조회
SELECT
    menu_name,
    category_code
FROM
    tbl_menu
WHERE
    category_code = 4;


-- 3) 서브쿼리를 이용해서 한 번의 SQL 실행으로 결과 찾기
SELECT
    menu_name,
    category_code
FROM
    tbl_menu
WHERE
    category_code = (
        SELECT category_code
        FROM tbl_menu
        WHERE menu_name = '민트미역국'
        );


/*
    08_SUBQUERY
    - 메인 쿼리(SQL) 내에서 실행되는 보조 쿼리(SELECT)
    - 종류 : 단일행 단일열, 다중행, 다중열, 다중행 다중열, 스칼라, 상관, 인라인뷰
    - 서브쿼리를 위한 연산자 : EXISTS
*/