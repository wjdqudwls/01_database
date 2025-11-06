/*
    해석 순서
    SELECT -> 3. 어떤 컬럼
    FROM -> 1. 어떤 테이블
    WHERE -> 2. 어떤 행
    ORDER BY -> 4. 정렬 순서

    03_where
    테이블에서 특정 조건에 맞는 레코드(행, row)만 선택하는 구문
    조건을 나타내기 위한 각종 연산자 사용
*/

-- 1) 비교 연산자(=, !=, <>, <, >, <=, >=)

-- [ = ] : 값 일치 여부 확인
SELECT /*3*/
    menu_code,
    menu_name,
    orderable_status
FROM /*1*/
    tbl_menu
WHERE /*2*/
    orderable_status = 'Y'
ORDER BY /*4*/
    menu_name ASC;

-- 이름이 '붕어빵초밥'인 메뉴 조회
SELECT
    *
FROM
    tbl_menu
WHERE
    menu_name = '붕어빵초밥';

-- 메뉴 가격이 13000원인 메뉴의
-- 메뉴 명과 가격
-- 메뉴명 내림차순으로 조회
SELECT
    menu_name,
    menu_price
FROM
    tbl_menu
WHERE
    menu_price = 13000
ORDER BY
    menu_name DESC;

-- [!=, <>] 같지 않음
-- 주문가능상태가 'Y'가 아닌 메뉴의
-- 메뉴코드, 메뉴명, 주문가능상태를
-- 메뉴명 오름차순으로 조회

SELECT
    menu_code,
    menu_name,
    orderable_status
FROM
    tbl_menu
WHERE
    orderable_status != 'Y'
#    orderable_status <> 'Y'
ORDER BY
    menu_name;

-- [>, <, >=, <=] 대소비교
-- 초과 미만 이상 이하
-- 이상 <-> 미만
-- 이하 <-> 초과

-- 메뉴 가격이 20000원 초과인 메뉴의
-- 메뉴명, 가격을
-- 메뉴코드 내림차순으로 조회

SELECT
    menu_name,
    menu_price
FROM
    tbl_menu
WHERE
    menu_price > 20000
ORDER BY
    menu_code DESC;
-- caching (메모리에 기억중,,)이어서 menu_code순 가능

-- 메뉴 가격이 20000원 이하인 메뉴의
-- 메뉴명, 가격을
-- 메뉴코드 내림차순으로 조회

SELECT
    menu_name,
    menu_price
FROM
    tbl_menu
WHERE
    menu_price >= 20000
ORDER BY
    menu_code DESC;

SELECT
    menu_name,
    menu_price
FROM
    tbl_menu
WHERE
    menu_price < 20000
ORDER BY
    menu_code DESC;

/*
    2) 논리 연산자
    논리: 참(TRUE), 거짓(FALSE)을 나타내는 값
*/

-- A AND B : A와 B 모두 참(TRUE)인 경우 결과가 TRUE
--           나머진 전부 거짓(FALSE)
/*
    A   B
    T   T   T
    T   F   F
    F   T   F
    F   F   F
*/

-- 주문 가능한 상태이며, 카테고리 코드가 10에 해당하는 메뉴만 조회
SELECT
    *
FROM
    tbl_menu
WHERE
    orderable_status = 'Y'
AND
    category_code = 10;
-- cursor라는 친구가 한 열씩 검사해서 WHERE절에 해당하는 열만 출력

-- 메뉴가격이 5000원 초과이면서
-- 카테고리코드가 10인 메뉴
-- 메뉴코드, 메뉴명, 카테고리코드
-- 메뉴코드 오름차순으로 조회
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

-- 메뉴가격이 5000원 이상, 20000원 미만인
-- 메뉴의 메뉴명, 메뉴가격
-- 메뉴가격 오름차순으로 조회
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
    menu_price;


-- 메뉴가격이 5000원 이상, 20000원 미만,
-- 카테고리코드가 10인
-- 메뉴의 메뉴명, 메뉴가격, 카테고리코드
-- 메뉴가격 오름차순으로 조회
SELECT
    menu_name,
    menu_price,
    category_code
FROM
    tbl_menu
WHERE
    (menu_price >= 5000 AND menu_price < 20000) AND category_code = 10
/*
    menu_price >= 5000
    AND
    menu_price < 20000
    AND
    category_code = 10
*/
ORDER BY
    menu_price;
/*
    (t) t = t
*/


/*
    A or B
    둘 다 FALSE인 경우에만 결과가 FALSE
    하나라도 TRUE면  TRUE
    A   B
    T   T   T
    F   T   T
    T   F   T
    F   F   F
*/

-- 주문가능한 상태이거나
-- 카테고리코드가 10인 메뉴를 모두 조회
SELECT
    *
FROM
    TBL_MENU
WHERE
    orderable_status = 'Y'
OR
    category_code = 10;

-- 메뉴가격이 5000원 미만 또는 20000원 이상인
-- 메뉴의 메뉴명, 메뉴가격을
-- 메뉴가격 오름차순으로 조회
SELECT
    *
FROM
    TBL_MENU
WHERE
    menu_price < 5000
OR
    menu_price >= 20000
ORDER BY
    menu_price;

/*
AND, OR 연산 중 우선순위는
AND가 높다

우선순위 문제 해결 시 () 이용
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
    (category_code = 4
OR
    menu_price = 9000)
AND
    menu_code > 10;


/*
BETWEEN A AND B
A이상 B이하 범위 지정
*/
SELECT
    *
FROM
    tbl_menu
WHERE
    -- menu_price >= 10000 AND menu_price <= 25000
    menu_price BETWEEN  10000 AND 25000
ORDER BY
    menu_price ASC;

/*
NOT BETWEEN A AND B
A이상 B이하 범위가 아닌 것 지정
*/
SELECT
    *
FROM
    tbl_menu
WHERE
    -- menu_price < 10000 OR menu_price > 25000
    menu_price NOT BETWEEN 10000 AND 25000
ORDER BY
    menu_price ASC;

/*
    LIKE 연산자
    와일드카드를 이용해 문자열 패턴이 일치하면 조회
    [ % ] : 포함
    [ _ ] : 글자 개수
*/

-- %문자열 : 해당 문자열로 끝남
SELECT
    menu_name
FROM
    tbl_menu
WHERE
    menu_name LIKE '%아메리카노';

-- 문자열% : 해당 문자열로 시작함
SELECT
    menu_name
FROM
    tbl_menu
WHERE
    menu_name LIKE '흑%';

-- %문자열% : 해당 문자열이 포함
SELECT
    menu_name
FROM
    tbl_menu
WHERE
    menu_name LIKE '%마늘%';

-- _ : 글자 개수
SELECT
    menu_name
FROM
    tbl_menu
WHERE
    menu_name LIKE '_____';
-- 5글자 메뉴만 조회

SELECT
    menu_name
FROM
    tbl_menu
WHERE
    menu_name LIKE '_마늘%';
-- 마늘 앞에 꼭 한글자, 뒤에는 관계 X



/*
    NOT LIKE 연산자
    문자열 패턴이 일치하지 않는 데이터만 조회
*/
SELECT
    menu_name
FROM
    tbl_menu
WHERE
    menu_name NOT LIKE '_마늘%';
-- 마늘 앞에 꼭 한글자, 뒤에는 관계 X

/*
    _, % 와일드카드 사용 시
    문자열인지 와일드카드인지 구분해서 사용하는 방법
    1) ESCAPE OPTION
    2) \(백슬래시) ESCAPE 문자
 */

    CREATE TABLE IF NOT EXISTS tbl_temp
    (
        temp_code  INT AUTO_INCREMENT COMMENT '임시코드',
        temp_email VARCHAR(30) NOT NULL COMMENT '이메일',
        PRIMARY KEY (temp_code)
    ) ENGINE = INNODB COMMENT '임시테이블';

    INSERT INTO tbl_temp
    VALUES (1, 'sun_di@greedy.com');
    INSERT INTO tbl_temp
    VALUES (2, 'song_jk@greedy.com');
    INSERT INTO tbl_temp
    VALUES (3, 'no_oc@greedy.com');
    INSERT INTO tbl_temp
    VALUES (4, 'song_eh@greedy.com');
    INSERT INTO tbl_temp
    VALUES (5, 'yoo_js@greedy.com');

    COMMIT;

    -- sun_di@gmail.com
    -- song_jk@gmail.com
    -- ....
    -- ***_ < 형태인 아이디만 찾고싶음

    -- 문제발생
    SELECT * FROM tbl_temp WHERE temp_email LIKE '____%';

    -- ESCAPE OPTION을 이용, 와일드카드에서 문자열로 탈출
    SELECT * FROM tbl_temp WHERE temp_email LIKE '___#_%' ESCAPE '#';

    -- \(백슬래시) ESCAPE 문자
    SELECT * FROM tbl_temp WHERE temp_email LIKE '___\_%';

/*
    IN / NOT IN
    찾는 값이 () 안에 있으면 결과에 포함
    == OR 연산을 연달아 작성하는 효과
*/
SELECT
    *
FROM
    tbl_menu
WHERE
    category_code = 4
OR
    category_code = 5
OR
    category_code = 6
OR
    category_code = 10
ORDER BY
    category_code ASC;

SELECT
    *
FROM
    tbl_menu
WHERE
    category_code IN(4,5,6,10)
ORDER BY
    category_code ASC;

-- NOT : 부정
SELECT
    *
FROM
    tbl_menu
WHERE
    category_code NOT IN(4,5,6,10)
ORDER BY
    category_code ASC;

/*
    NULL 관련 연산
    NULL == 빈칸 (값 X)
    --> 비교 연산이 불가능하다.
*/

-- NULL 비교연산 불가능
SELECT
    *
FROM
    tbl_category
WHERE
    ref_category_code = NULL;

-- IS NULL: 해당 컬럼의 값이 NULL(빈칸)이면 TRUE -> 결과 포함
SELECT
    *
FROM
    tbl_category
WHERE
    ref_category_code IS NULL;

-- IS NOT NULL: 해당 컬럼의 값이 NULL(빈칸)이 아니면 TRUE -> 결과 포함
SELECT
    *
FROM
    tbl_category
WHERE
    ref_category_code IS NOT NULL;

