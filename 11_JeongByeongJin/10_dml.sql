/* 10_DNL(Data Manipulation Language)
   - 데이터 조작 언어
   - 테이블에 값(Data)Dmf 삽입(), 수정(), 삭제()하는 SQL
*/

/* 1. INSERT : 새로운 행을 삽입(추가)

   [작성법]
   INSERT INTO 테이블명 VALUES(col1 값, col2 값, ...);
   (테이블 컬럼 순ㄴ서대로 모든 컬럼 값을 values에 작성)
*/

INSERT
INTO tbl_menu
VALUES (NULL,
        '바나나 해장국,',
        8500,
        4,
        'Y');

-- AUTO_INCREMENT :
-- NULL 허용, PK 컬럼에 NULL 삽입 시 자동으로 증가된 숫자 삽입

-- INSERT 수행 후 결과
-- -> 1 (삽입된 행의 개수를 반환)

SELECT *
FROM tbl_menu;

/*

[작성법]
INSERT INTO 테이블명(COL1, COL2, COL3, ...)
*/

INSERT
INTO tbl_menu
( menu_name, menu_price
, category_code, orderable_status)
VALUES ( '초콜릿죽', 6500
       , 7, 'Y');

INSERT
INTO tbl_menu
    (orderable_status, menu_price, menu_name, category_code)
VALUES ('Y', 5500, '파인애플탕', 4);

/* MULTI INSERT
   [작성법]
   INSERT INTO 테이블명 VALUES
   (COL1값, COL2값, ...);
   (COL1값, COL2값, ...);
   (COL1값, COL2값, ...);
   (COL1값, COL2값, ...); -> 행 복사 == cmd + d
*/

INSERT
INTO tbl_menu
VALUES (null, '참치맛아이스크림', 1700, 12, 'Y'),
       (null, '멸치맛아이스크림', 1500, 11, 'Y'),
       (null, '소시지맛커피', 2500, 8, 'Y');


/* UPDATE : 테이블에 기록된 컬럼 값을 수정
   - 선택된 행, 열의 컬럼 값를 수정
   - 수정 결과 행의 개수는 0 ~ n 까지 나타날 수 있음

   [작성법]
   UPDATE 테이블명
   SET
   수정할컬럼1 = 수정 값1,
   수정할컬럼2 = 수정 값2,
   ...
   WHERE 행 선택 조건식;
*/

UPDATE tbl_menu
SET menu_name     = '딸기맛붕어빵',
    category_code = 7
WHERE menu_code = 24;
-- 결과 값 확인
SELECT *
FROM tbl_menu
WHERE menu_code = 24; -- 수정했던 행만 확인


UPDATE
    tbl_menu
SET category_code = 7
WHERE menu_code = (SELECT menu_code
                   FROM tbl_menu
                       WHERE menu_name = '초콜릿죽');

UPDATE tbl_menu
SET category_code = (
    SELECT category_code
    FROM tbl_menu
    WHERE menu_name = '죽방멸치튀김우동'
    )
WHERE menu_code = (SELECT menu_code
                   FROM tbl_menu
                   WHERE menu_name = '초콜릿죽');

SELECT *
FROM tbl_menu;

/* DELETE : 테이블의 행을 삭제하는 구문

   [작성법]
   DELETE
   FROM 테이블명
   WHERE 행 필터링 조건
   ORDER BY 정렬기준
   LIMIT 삭제할 개수;

*/
-- 24버 존재 확인 --> O
SELECT
FROM tbl_menu
WHERE menu_code = 24;
-- 24번 삭제
DELETE
FROM tbl_menu
WHERE menu_code = 24;
-- 24번 존재 확인 --> X
SELECT *
FROM tbl_menu
WHERE menu_code = 24;

/* Tx mode -> 수동으로 변경 후 진행 */

-- limit을 이용한 삭제

-- 삭제할 내용 확인
SELECT *
FROM tbl_menu
ORDER BY menu_price
LIMIT 2;

-- 삭젝할 내용 SELECT * 을 DELETE 로 변경
DELETE
FROM tbl_menu
ORDER BY menu_price
LIMIT 2;

SELECT *
FROM tbl_menu
ORDER BY menu_price;

-- 전체 행 삭제
DELETE
FROM tbl_menu;

/* REPLACE : 중복된 데이터를 덮어쓸 수 있음
   - INSERT 진행 시 PK, UNIQUE 설정 컬럼 값이 같으면 에러 발생
   - REPLACE는 에러르 무시하고 덮어씌움
*/

SELECT * FROM tbl_menu;

INSERT INTO tbl_menu VALUES (17, '참기름소주', 5000, 10, 'Y'); -- 에러 발생

REPLACE INTO tbl_menu VALUES (17, '참기름소주', 5000, 10, 'Y');

-- 업데이트 시 업데이트 사용하면 오류 뜸
UPDATE tbl_menu
SET menu_code = 2
  , menu_name = '우럭쥬스'
  , menu_price = 2000
  , category_code = 9
  , orderable_status = 'N';

-- WHERE절 없이도 PK(menu_code) 값이 일치하는 행을 찾아서 REPLACE 진행
REPLACE tbl_menu
SET menu_code = 2
  , menu_name = '우럭쥬스'
  , menu_price = 2000
  , category_code = 9
  , orderable_status = 'N';


