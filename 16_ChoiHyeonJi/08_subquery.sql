-- 서브쿼리 예시

-- '민트 미역국'과 같은 카테고리의 메뉴를 모두 조회하시오

-- 1) '민트미역국'의 카테고리 코드 찾기
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

-- 3) SUBQUERY를 이용해서 한 번에 SQL 실행으로 결과 찾기 // BASE 2번

SELECT
    menu_name,
    category_code
FROM
    tbl_menu
WHERE
    category_code = (
            SELECT
                category_code
            FROM
                tbl_menu
            WHERE
                menu_name = '민트미역국'
        );


/*

    08_SUBQUERY
    - 메인 쿼리 (SQL) 내에서 실행되는 보조 쿼리 (SELECT)
    - 단일행 단일열, 다중행, 다중열, 단중행 단중열(행 여러개 열도 여러개), 스칼라, 상관, 인라인뷰
    - 서브쿼리를 위한 연산자 : EXISTS

*/