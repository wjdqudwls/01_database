/*
    03_where
    - 테이블에서 특정 조건에 맞는 레코드(행, row)만 선택하는 구문
    - 조건을 나타내기 위한 각종 연산자를 사용
 */

 -- 1) 비교 연산자 (=, !=, <>, <, >, <=, >=)
 -- 컴퓨터에서 부정호(같지않다) = != 이다
    SELECT
        menu_code
        menu_name
        orderable_status
    FROM
        tbl_menu;

-- [ = ] : 값이 일치하는지 확인
    SELECT
    *
    FROM
       tbl_menu
    WHERE
        orderable_status = 'Y'
    ORDER BY
        menu_name ASC;

-- 이름이 '붕어빵초밥'인 메뉴 조합
SELECT
    *
FROM
    tbl_menu
WHERE
    menu_name = '붕어빵초밥';

-- 메뉴 가격이 13000인 메뉴의 메뉴명, 메뉴명을 내림차순으로 조회
/*
SELECT
    *
FROM
    tbl_menu
WHERE
    menu_price = '13000' ASC; -- 내가푼 공식 틀림
*/

SELECT
    *
FROM
    tbl_menu
WHERE
    menu_price = 13000
ORDER BY
    menu_name ASC;
-- [ !=, <> ] 같지 않음
-- 주문가능 상태가 'Y'가 아닌 메뉴의
-- 메뉴코드, 메뉴명, 주문가능 상태를
-- 메뉴명 오름파순으로 조회
SELECT
    menu_code,
    menu_name,
    orderable_status

FROM
    tbl_menu
WHERE
    orderable_status != 'Y'
ORDER BY
    menu_name ASC;

-- 대소비교 (초과, 미만 , 이상, 이하)
-- 메뉴 가격이 20000원 초과인 메뉴의
-- 메뉴명, 가격을
-- 메뉴코드 내림차순으로 조회
SELECT
    *

FROM
    tbl_menu
WHERE
    menu_price > 20000 -- >=, <= 같은 복합기호에서는 등호가 우측
ORDER BY
    menu_code DESC;
---

SELECT
    *

FROM
    tbl_menu
WHERE
    menu_price < 20000 -- 초과 ↔ 이하, 미만 ↔ 이상
ORDER BY
    menu_code DESC;

/*
    2) 논리 연산자
    - 논리란? 참(TRUE), 거짓(FALSE)을 나타내는 값
 */
-- A AND B : A와 B 모두 참(TRUE)인 경우 결과가 TRUE
--  그외 나머지는 모두 거짓 (FALSE)

-- 주문가능한 상태이며, 카테고리 코드가 10에 해당하는 메뉴만 조회
SELECT
    *
FROM
    tbl_menu
WHERE
    orderable_status = 'Y'
AND
    category_code = 10;

-- 메뉴 가격이 5000원 초과이면서
-- 카테고리 번호가 10인 메뉴의
-- 메뉴코드, 메뉴명, 카테고리 코드를
-- 메뉴코드 오름차순으로 조회
SELECT
    *
FROM
    tbl_menu
WHERE
    menu_price > 5000
AND
    category_code = 10
ORDER BY
    menu_code ASC;

-- 메뉴 가격이 5000원 이상 20000원 미만인
-- 메뉴의 메뉴명, 메뉴가격을
-- 메뉴 가격 오름 차순으로 조회
/*
SELECT
    *
FROM
    tbl_menu
WHERE
    5000<= menu_price < 20000 -- 이부분이 오답
ORDER BY
    menu_name DESC;

*/


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
    menu_name ASC;

-- 메뉴가격이 5000원 이상 20000만원 미만
-- 카테고리 코드가 10인
-- 메뉴의 메뉴명, 메뉴가격, 카테고리코드를
-- 메뉴가격 오름  차순으로 조회
SELECT
    menu_price,
    menu_name,
    category_code
FROM
    tbl_menu
WHERE
   (menu_price >= 5000 AND menu_price < 20000)
AND
    category_code = 10
ORDER BY
    menu_price ASC;

/* A OR B -- 둘다 FALSE인 경우에만 결과가 FALSE
-- 주문가능한 상태 이거나
-- 카테고리코드가 10인 메뉴를 모두 조회
 */
SELECT
    *
FROM
    tbl_menu
WHERE
    orderable_status = 'Y'
OR
    category_code = 10;

-- 범위
SELECT
    menu_price,
    menu_name
FROM
    tbl_menu
WHERE
--   (menu_price < 5000 OR menu_price >= 20000)
    menu_price < 5000
OR
    menu_price >= 20000

ORDER BY
    menu_price ASC;

/*
    AND, OR 연산 중 우선순위는
    AND가 높다 !!!
 */
 -- 흑마늘, 까나리
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

-- 우선순위 문제 해결시 () 이용 !!
-- 코드의 순서를 바꾸면 오히려 꼬일수있음
-- 코드 4번이며, 가격 9000원 그리고 6이상인애들
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

-- 7개
SELECT
     *
 FROM
     tbl_menu
 WHERE
     (category_code = 4
 OR
     menu_price = 9000);

-- BETWWN A TO B : A ~B (A이상 B이하) 범위 지정
SELECT
    *
FROM
    tbl_menu
WHERE
    -- menu_price >= 10000 AND menu_price <=25000
    menu_price >= 10000
AND
    menu_price <= 25000
ORDER BY
    menu_price ASC;

-- NOT BETWWN A TO B : A ~B (A이상 B이하)가 아닌 범위 지정
SELECT
    *
FROM
    tbl_menu
WHERE
    -- menu_price < 10000 OR menu_price > 25000
    -- menu_price < 10000 OR menu_price > 25000
    menu_price NOT BETWEEN 10000 AND 25000


ORDER BY
    menu_price ASC;

/* LIKE 연산자
   - 와일드카드를 이용해 문자열 패턴이 일치하면 조회
   - % : 포함
   - _:글자 개수
 */

--  %문자열 : 해당 문자열로 끝남
 SELECT
     tbl_menu.menu_name
 FROM
     tbl_menu
 WHERE
     menu_name LIKE '%아메리카노';

--  문자열% : 해당 문자열로 시작함
 SELECT
     tbl_menu.menu_name
 FROM
     tbl_menu
 WHERE
     menu_name LIKE '죽%';

--  %문자열% : 해당 문자가 포함된열 (위치상관x)
 SELECT
     tbl_menu.menu_name
 FROM
     tbl_menu
 WHERE
     menu_name LIKE '%마늘%';

--  _ : 글자 개수 ( _의 개수만큼 글자수 조회 )
 SELECT
     tbl_menu.menu_name
 FROM
     tbl_menu
 WHERE
     menu_name LIKE '_____';

--  _ : 글자 개수 ( _의 개수만큼 글자수 조회 )
 SELECT
     tbl_menu.menu_name
 FROM
     tbl_menu
 WHERE
     menu_name NOT LIKE '_마늘%';



/*
    _, % 와일드카드 사용 시
    문자열인지 와일드 카드 인지 구분해서 사용하는 방법
    1_ ESCAPE OPTION 을 이용해서 와일드카드 -> 문자열로 탈출
    2_ \(백슬래시) ESCAPE 문자
 */
    SELECT
        *
    FROM
        tbl_menu
    WHERE
        menu_name LIKE '____%';

--  NOT LIKE : 문자열 패턴이 일치하지 않는 데이터만 조회
 SELECT
     tbl_temp.menu_name
 FROM
     tbl_temp
 WHERE
     menu_name LIKE '___#_% ESCAPE '#';

-- / = 백슬래시 ESCAPE 문자
    SELECT
     tbl_temp.menu_name
     FROM
     tbl_temp
    WHERE
       temp_email LIKE '___\_%';


-- DISCORDE 자료

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

/*  IN / NOT IN
    - 찾는 값이 () 안에 있으면 결과에 포함
    == OR 연산을 연달아 작성하는 효과
 */

 SELECT
     *
 FROM
     tbl_menu
 WHERE
     category_code = 4
    OR
     category_code =- 5
  OR
     category_code =- 6
  OR
     category_code =- 7
    ORDER BY
        category_code ASC;

--  위에 코드가  OR 이 너무 많아 기니까 줄인다 IN 으로
 SELECT
     *
 FROM
     tbl_menu
 WHERE
     category_code IN (4,5,6,10)
    ORDER BY
        category_code ASC;

SELECT
     *
 FROM
     tbl_menu
 WHERE
     category_code NOT IN (4,5,6,10)
    ORDER BY
        category_code ASC;

/* NULL 관련 연산
    -NULL == 빈칸 (값 x)
    ---> 비교 연산이 불가능
 */
SELECT
    *
FROM
    tbl_category
WHERE
    ref_category_code = NULL;

-- IS NULL : 해당 컬럼의 값이 NULL(빈칸)이면 TRUE라면 -> 결과포함
SELECT
    *
FROM
    tbl_category
WHERE
    ref_category_code = IS NULL;

-- IS NOT NULL :  해당 컬럼의 값이 NULL(빈칸)이 아니면 -> 결과포함
SELECT
    *
FROM
    tbl_category
WHERE
    ref_category_code  IS NOT NULL;
