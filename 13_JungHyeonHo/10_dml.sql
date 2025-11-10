/*
 DML : DATA MANIPULATION LANGUAGE

 데이터 조작 언어

- 테이블에 값을 삽입(`INSERT`), 수정(`ALTER`), 삭제(`DELETE`)하는 SQL의 한 부분
- DB 내의 데이터를 조작
 */

/* 1. INSERT : 새로운 행을 삽입(추가)
   INSERT INTO 테이블명 VALUES(컬럼1값, 컬럼2값, 컬럼3값,...)
*/

INSERT
INTO tbl_menu
VALUES ( NULL, '바나나해장국'
       , 8500, 4
       , 'Y');

SELECT *
FROM tbl_menu;

INSERT
INTO tbl_menu
    (orderable_status, menu_price, menu_name, category_code)
VALUES ('Y', 5500, '파인애플탕', 4);

INSERT
INTO tbl_menu
( menu_name, menu_price
, category_code, orderable_status)
VALUES ( '초콜릿죽', 6500
       , 7, 'Y');
/* MULTI INSERT
   [작성법]
   INSERT
   INTO 테이블명
   VALUES
   (COL1, COL2, COL3, ...)
   (COL1, COL2, COL3, ...)
   (COL1, COL2, COL3, ...)
 */
INSERT
INTO tbl_menu
VALUES (null, '참치맛아이스크림', 1700, 12, 'Y'),
       (null, '멸치맛아이스크림', 1500, 11, 'Y'),
       (null, '소시지맛커피', 2500, 8, 'Y');

/*
 2) UPDATE

- 테이블에 기록된 컬럼 값을 수정
    - 선택된 행, 열의 컬럼 값을 수정
    - 수정 결과 행의 개수는 0 ~ n

## 작성법

```sql
UPDATE 테이블명
SET
수정할컬럼1 = 수정값1,
수정할컬럼2 = 수정값2,
...
WHERE 행 선택 조건식

```
 */
SELECT *
FROM tbl_menu;

UPDATE tbl_menu
SET menu_name     = "딸기맛붕어빵",
    category_code = 7
WHERE menu_code = 30;

-- 서브쿼리 이용한 수정
UPDATE tbl_menu
SET category_code = (
    SELECT category_code
    FROM tbl_menu
    WHERE menu_name='죽방멸치튀김우동'
    )
WHERE menu_code = (SELECT menu_code
                   FROM tbl_menu
                   WHERE menu_name = '초콜릿죽');

SELECT * FROM tbl_menu WHERE menu_code = 25;

/*
 # 3. DELETE

- 테이블 행을 삭제하는 구문

## 3. 1. 작성법

```sql
DELETE
FROM 테이블명
WHERE 조건
ORDER BY 정렬기준
LIMIT 삭제할 개수
```
 */
SELECT * FROM tbl_menu;
 DELETE
 FROM tbl_menu
 WHERE menu_code = 30;

/* Tx모드 자동 -> 수동*/

-- LIMIT을 이용한 삭제
DELETE
FROM tbl_menu
ORDER BY menu_price
LIMIT 2;

SELECT * FROM tbl_menu;

-- 전체 행 삭제
DELETE
FROM tbl_menu
WHERE menu_code > 0; -- -> 쓰는 이유 : INDEX 조회 속도는 PK를 언급만 해도 굉장히 빨라지는 효과
SELECT * FROM tbl_menu;


/*
 4. REPLACE
 */

 INSERT INTO tbl_menu VALUES (17, '참기름소주', 5000, 10, 'Y'); -- 에러 발생
# REPLACE INTO tbl_menu VALUES (17, '참기름소주', 5000, 10, 'Y');

-- WHERE 절 없이도 PK(menu_code) 값이 일치하는 행을 찾아서 REPLACE 진행
UPDATE tbl_menu
    SET menu_code = 2
      , menu_name = '우럭쥬스'
      , menu_price = 2000
      , category_code = 9
      , orderable_status = 'N';

REPLACE tbl_menu
    SET menu_code = 2
      , menu_name = '우럭쥬스'
      , menu_price = 2000
      , category_code = 9
      , orderable_status = 'N';

SELECT * FROM tbl_menu;