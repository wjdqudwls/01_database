/*
    03_where
    - 테이블에서 특정 조건에 맞는 레코드(행, row)만 선택하는 구문
    - 조건을 나타내기 위한 각종 연산자를 사용
*/

-- 1) 비교 연산자(=, !=, <>, <, >, <=, >=)
SELECT
    menu_code
     , menu_name
     , orderable_status
FROM tbl_menu;

-- [=] : 값이 일치하는지 확인
SELECT /*3*/
    menu_code
     , menu_name
     , orderable_status
From /*1*/
    tbl_menu
WHERE /*2*/
    orderable_status = 'Y'
ORDER BY /*4*/
    menu_name;

-- 이름이 '붕어빵초밥'인 메뉴 조회
SELECT
    *
FROM
    tbl_menu
WHERE
    menu_name = '붕어빵초밥';

SELECT
    menu_name,
    menu_price

FROM
    tbl_menu
WHERE
    menu_price = 13000
ORDER BY
    menu_name DESC;

SELECT
    menu_code,
    menu_name,
    orderable_status
FROM
    tbl_menu
WHERE
    -- orderable_status != 'Y'
       orderable_status <> 'Y'

ORDER BY
    menu_name ASC;


SELECT
    menu_name,
    menu_price
FROM
    tbl_menu
WHERE
    menu_price > '20000'
ORDER BY
    menu_code DESC;

SELECT
    menu_name,
    menu_price
FROM
    tbl_menu
WHERE
    menu_price >= '20000'
ORDER BY
    menu_code DESC;

SELECT
    menu_name,
    menu_price
FROM
    tbl_menu
WHERE
    menu_price < '20000'
ORDER BY
    menu_code DESC;

SELECT
    menu_name,
    menu_price
FROM
    tbl_menu
WHERE
    menu_price <= '20000'
ORDER BY
    menu_code DESC;

/*
    2) 논리 연산자
    - 논리란? 참(TRUE), 거짓(FALSE)을 나타내는 값

*/

-- A AND B : A 와 B 모두 참(TRUE)인 경우 결과가 TRUE
--           나머진 모두 거짓(FALSE)

-- 주문가능한 상태이며, 카테고리 코드가 10에 해당하는 메뉴만 조회

SELECT
    *
FROM
    tbl_menu
WHERE
    orderable_status = 'Y'
AND
    category_code = '10';


SELECT
    menu_code,
    menu_name,
    category_code
FROM
    tbl_menu
WHERE
    menu_price > 5000
AND
    category_code = 10
ORDER BY
    menu_code ASC;

SELECT
    menu_name,
    menu_price
FROM
    tbl_menu
WHERE
    menu_price >= 5000
AND
    menu_price < 20000
ORDER BY
    menu_price ASC;

SELECT
    menu_name,
    menu_price,
    category_code
FROM
    tbl_menu
WHERE
    (menu_price >= 5000 AND menu_price < 20000)
AND
    category_code = 10
ORDER BY
    menu_price ASC;

-- AND 는 여러개를 사용할 수 있음. 여깃 주의할 점 ) 꼭 순서대로 시작해야함.

/* A OR B 연산자
   - 둘 다 FALSE 인 경우에만 결과가 FALSE
   - 하나라도 TRUE 이면 TRUE
*/

SELECT
    *
FROM
    tbl_menu
WHERE
    orderable_status = 'Y'
OR
    category_code = 10;

SELECT
    menu_name,
    menu_price
FROM
    tbl_menu
WHERE
    menu_price < 5000
OR
    menu_price >= 20000
ORDER BY
    category_code ASC;


/*
    AND, OR 연산 중 우선순위
    AND 가 높다 !
    * 우선순위 문제 해결 시 () 이용
*/

SELECT
    *
FROM
    tbl_menu
WHERE
    category_code = 4
OR
    menu_price = 9000
AND
    menu_code > 10;

SELECT
    *
FROM
    tbl_menu
WHERE
    menu_price = 9000
AND
    menu_code > 10;

SELECT
    *
FROM
    tbl_menu
WHERE
    (category_code = 4
OR
    menu_price = 9000)
  AND
    menu_code > 6;


-- BETWEEN A AND B : A 이상 B 이하  범위 지정
-- NOT BETWEEN A AND B : A 이상 B 이하 범위가 아닌 것 지정
SELECT
    *
FROM
    tbl_menu
where
    -- menu_price < 10000 OR menu_price > 25000
    -- menu_price BETWEEN 10000 AND 25000
    menu_price BETWEEN 10000 AND 25000
ORDER BY
    menu_price ASC;

-- ----------------------------------------------------
/* LIKE 연산자
 - 와일드카드를 이용해 문자열 패턴이 일치하면 조회
 - % : 포함
 - _ : 글자 개수
*/
-- %문자열 : 해당 문자열로 끝남
SELECT
    menu_name
FROM tbl_menu
WHERE menu_name LIKE '%아메리카노';

-- %문자열 : 해당 문자열로 끝남
SELECT
    menu_name
FROM tbl_menu
WHERE menu_name LIKE '죽%';

-- %문자열% : 해당 문자열이 포함(처음, 중간, 끝 관계 없음)
SELECT
    menu_name
FROM tbl_menu
WHERE menu_name LIKE '%마늘%';

-- _ : 글자 개수
SELECT
    menu_name
FROM tbl_menu
WHERE menu_name LIKE '_____'; -- 5글자 메뉴명만 조회

-- 마늘 앞에 꼭 한글자, 뒤에는 관계없음
SELECT
    menu_name
FROM tbl_menu
WHERE menu_name LIKE '_마늘%';

-- NOT LIKE : 문자열 패턴이 일치하지 않는 데이터만 조회

SELECT
    menu_name
FROM tbl_menu
WHERE menu_name NOT LIKE '_마늘%';

/*
    _, % 와일드카드 사용 시
    문자열인지, 와일드카드 인지 구분해서 사용하는 방법
    1) ESCAPE OPTION
    2) \(백슬레시) ESCAPE 문자
*/
SELECT *
FROM tbl_temp
WHERE temp_email LIKE '____#'; -- 문제 발생

-- ESCAPE OPTION
SELECT
    *
FROM
    tbl_temp
WHERE
    temp_email LIKE '___#_%' ESCAPE '#';

-- \(백슬레시) ESCAPE 문자
SELECT *
FROM tbl_temp
WHERE temp_email LIKE '___\_%';

CREATE TABLE IF NOT EXISTS tbl_temp
(
    temp_code    INT AUTO_INCREMENT COMMENT '임시코드',
    temp_email    VARCHAR(30) NOT NULL COMMENT '이메일',
    PRIMARY KEY (temp_code)
) ENGINE=INNODB COMMENT '임시테이블';

INSERT INTO tbl_temp VALUES(1, 'sun_di@greedy.com');
INSERT INTO tbl_temp VALUES(2, 'song_jk@greedy.com');
INSERT INTO tbl_temp VALUES(3, 'no_oc@greedy.com');
INSERT INTO tbl_temp VALUES(4, 'song_eh@greedy.com');
INSERT INTO tbl_temp VALUES(5, 'yoo_js@greedy.com');

COMMIT;

-- ----------------------------------------------------------------------------

/* IN / NOT IN
   - 찾는 값이 () 안에 있으면 결과에 포함
    == OR 연산을 연달아 작성하는 효과
*/

SELECT *
FROM tbl_category
WHERE category_code
OR category_code = 4
OR category_code = 5
OR category_code = 6
OR category_code = 10
ORDER BY category_code ASC;

SELECT *
FROM tbl_menu
WHERE category_code IN (4, 5, 6, 10);

SELECT *
FROM tbl_menu
WHERE category_code NOT IN (4, 5, 6, 10);

/* NULL 관련 연산
   - NULL == 빈칸(값 x)
    --> 비교 연산이 불가능하다 !!!
*/

SELECT *
FROM tbl_category
WHERE ref_category_code = NULL; -- 비교 연산 불가

-- IS NULL : 해당 컬럼의 값이 NULL(빈칸)이면 TRUE -> 결과 포함

SELECT *
FROM tbl_category
WHERE ref_category_code IS NULL;

-- IS NULL : 해당 컬럼의 값이 NULL(빈칸)아니면 TRUE -> 결과 포함
SELECT *
FROM tbl_category
WHERE ref_category_code IS NOT NULL;