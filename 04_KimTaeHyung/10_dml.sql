/* 10_DML(Data Manipulation Language)
   - 데이터 조작 언어
   - 테이블에 값(Data)을 삽입(INSERT), 수정(UPDATE), 삭제(DELETE)하는 SQL
*/

/* 1. INSERT : 새로운 행을 삽입(추가)

   [작성법]
   INSERT INTO 테이블명 VALUES(col1 값, col2 값, ...);
   (테이블 컬럼 순서대로 모든 컬럼값을 values에 작성)
*/

INSERT
INTO tbl_menu
VALUES (NULL,
        '바나나 해장국',
        8500,
        4,
        'Y');

-- AUTO_INCREMENT : NULL 허용 PK 컬럼에 NULL 삽입 시 자동으로 증가된 숫자 삽입

-- INSERT 수행 후 결과
-- -> 1 (삽입된 행의 개수를 반환)

SELECT *
FROM tbl_menu;


/* INSERT 시 컬럼 지정

   [작성법]
   INSERT INTO 테이블명(COL1, COL2, COL3, ...)
   VALUES(COL1 값, COL2 값, COL3 값, ...)

*/

INSERT
INTO tbl_menu(menu_name,
              menu_price,
              category_code,
              orderable_status)
VALUES ('초콜릿죽',
        6500,
        7,
        'Y');


INSERT
INTO tbl_menu
    (orderable_status,
     menu_price,
     menu_name,
     category_code)
VALUES ('Y',
        5500,
        '파인애플탕',
        4);


/* MULTI INSERT
   [작성법]
    INSERT INTO 테이블명 VALUES
    (COL1 값, COL2 값, ...),
    (COL1 값, COL2 값, ...),
    (COL1 값, COL2 값, ...),
    (COL1 값, COL2 값, ...);
*/

INSERT
  INTO tbl_menu
VALUES
(null, '참치맛아이스크림', 1700, 12, 'Y'),
(null, '멸치맛아이스크림', 1500, 11, 'Y'),
(null, '소시지맛커피', 2500, 8, 'Y');



/* UPDATE : 테이블에 기록된 컬럼 값을 수정
    - 선택된 행, 열의 컬럼 값을 수정
    - 수정 결과 행의 개수는 0 ~ N

   [작성법]
   UPDATE 테이블명
   SET
   수정할 컬럼1 = 수정 값1,
   수정할 컬럼2 = 수정 값2,
   ...
   WHERE 행 선택 조건식;
*/

UPDATE tbl_menu
SET
    menu_name = '딸기맛붕어빵',
    category_code = 7
WHERE
    menu_code = 24;

UPDATE tbl_menu
SET
    category_code = (
        SELECT  category_code
        FROM tbl_menu
        WHERE menu_name = '죽방멸치튀김우동'
        )
WHERE
    menu_code = (
        SELECT menu_code
        FROM tbl_menu
        WHERE menu_name = '초콜릿죽'
        );

SELECT * FROM tbl_menu
WHERE menu_code = 23;

/* DELETE : 테이블의 행을 삭제하는 구문

    [작성법]
    DELETE
    FROM 테이블명
    WHERE 행 필터링 조건
    ORDER BY 정렬 기준
    LIMIT 삭제할 개수
*/

-- 24번 존재 확인 --> O
SELECT
    *
FROM
    tbl_menu
WHERE
    menu_code = 24;

-- 24번 삭제
DELETE
FROM
    tbl_menu
WHERE
    menu_code = 24;

-- 24번 존재 확인 --> X
SELECT
    *
FROM
    tbl_menu
WHERE
    menu_code = 24;

/* Tx 모드 --> 수동으로 변경 후 진행 */

-- LIMIT을 이용한 삭제

DELETE
FROM tbl_menu
ORDER BY menu_price
LIMIT 2;

SELECT *
FROM tbl_menu
ORDER BY menu_price;


-- 전체 행 삭제
DELETE
FROM tbl_menu
WHERE menu_code > 0;

SELECT * FROM tbl_menu;



/* REPLACE : 중복된 데이터를 덮어쓸 수 있음
    - INSERT, UPDATE 진행 시 PK, UNIQUE 설정 컬럼 값이 같으면 에러 발생
    - REPLACE는 에러를 무시하고 덮어씌움
*/
SELECT * FROM tbl_menu;

INSERT INTO tbl_menu
VALUES (17, '참기름소주', 5000, 10, 'Y'); -- 에러 발생

REPLACE INTO tbl_menu
VALUES (17, '참기름소주', 5000, 10, 'Y');


-- WHERE 절 없이도 PK(menu_code) 값이 일치하는 행을찾아서 REPLACE 진행
REPLACE tbl_menu
    SET menu_code = 2
      , menu_name = '우럭쥬스'
      , menu_price = 2000
      , category_code = 9
      , orderable_status = 'N';