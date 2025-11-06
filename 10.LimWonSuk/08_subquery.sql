-- 서브 쿼리 예시
-- '민트미역국'과 같은 카테고리의 메뉴를 모두 조회하시오

-- 1) '민트미역국'의 카테고리 코드 찾기
SELECT
    category_code
FROM
    tbl_menu
WHERE
    menu_price = '민트미역국'; -- 4

-- 2) 카테고리 코드가 4인 메뉴 모두 조회
SELECT
    *
FROM
    tbl_menu
WHERE
    category_code = 4; -- 1번, 2번 둘다해야 값이나옴

-- 3) SUBQUERY를 이용해서 한번의 SQL 실행으로 결과 찾기
SELECT
    *
FROM                            -- 2번에 (MAINQUERY)
    tbl_menu
WHERE
    category_code = (
        SELECT
    category_code
FROM                            -- 1번을 괄호에 넣음 (SUBQUERY)
    tbl_menu
WHERE
    menu_name = '민트미역국'
        );
/* 08_SUBQUERY
   - 메인 쿼리(SQL) 내에서 실행되는 보조 쿼리(SELECT)
   - 종류 : 단일행, 다중행, 다중열, 단일행, 단중열, 스칼라, 상관(어려움), 인라인뷰
   - SUBQUERY를 위한 연산자 : EXISTS
 */