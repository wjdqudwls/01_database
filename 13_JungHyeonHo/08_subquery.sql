/*
 08_SUBQUERY
 - 메인 쿼리(SQL) 내에서 실행되는 보조 쿼리(SELECT)
 - 종류 : 단일행 단일열, 다중행 단일열, 단일행 다중열, 다중행 다중열,
         스칼라, 상관(어려운 개념), 인라인뷰
 - 서브쿼리를 위한 연산자 : EXISTS

 */





-- 서브쿼리 예시

-- '민트미역국'과 같은 카테고리의 메뉴를 모두 조회하시오

-- 1) '민트미역국'의 카테고리 찾기
SELECT category_code
FROM tbl_menu
WHERE menu_name = '민트미역국';
--          ANS : 4

-- 2) 카테고리 코드가 4인 메뉴 모두 조회
SELECT menu_name, category_code
FROM tbl_menu
WHERE category_code = 4;

-- => 1) + 2) 한번에 해보자

-- 3) SUBQUERY를 이용해서, 한번에 원하는 RESULTSET을 얻어보자
SELECT menu_name, category_code
FROM tbl_menu
WHERE category_code IN (SELECT category_code
                       FROM tbl_menu
                       WHERE menu_name = '민트미역국');