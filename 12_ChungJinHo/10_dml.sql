/* 10_DML ( DATA MANIPULATION LANGUAGE )
   - 데이터 조작 언어
   - 테이블에 값(Data)을 삽입(INSERT), 수정(UPDATE), 삭제(DELETE)하는 SQL
*/

/* 1. INSERT : 새로운 행을 삽입(추가)

   [작성법]
   INSERT INTO 테이블명 VALUES(컬럼1값, 컬럼2값, 컬럼3값,...)
   테이블 컬럼 순서대로 모든 컬럼 값을 values에 작성
*/
insert
into tbl_menu
values (null,'바나나 해장국',8500,4,'Y');

-- AUTO INCREMENT :
-- NULL 허용 PK 컬럼에 NULL 삽입 시 자동으로 증가된 숫자 삽입
-- -> 1 (삽입된 행의 갯수를 반환)

/* INSERT 시 컬럼 명시

   [작성법]
   INSERT INTO 테이블명(컬럼1, 컬럼2, 컬럼3) VALUES(컬럼1값, 컬럼2값, 컬럼3값)
   명시 순서에 따라 들어감
*/

INSERT
  INTO tbl_menu
(
  menu_name, menu_price
, category_code, orderable_status
)
VALUES
(
  '초콜릿죽', 6500
, 7, 'Y'
);

INSERT
  INTO tbl_menu
(orderable_status, menu_price, menu_name, category_code)
VALUES
('Y', 5500, '파인애플탕', 4);

SELECT * FROM tbl_menu;

/* MULTI INSERT
    INSERT INTO 테이블 VALUES
   (col1 data, col2 data,...),
   (col1 data, col2 data,...),
   (col1 data, col2 data,...),
   (col1 data, col2 data,...),
 */

INSERT
  INTO tbl_menu
VALUES
(null, '참치맛아이스크림', 1700, 12, 'Y'),
(null, '멸치맛아이스크림', 1500, 11, 'Y'),
(null, '소시지맛커피', 2500, 8, 'Y');

/* UPDATE : 테이블 기존 컬럼 안에 있던 데이터값을 수정하는 구문
   - 선택된 컬럼의 데이터값만 수정
   - 전체 행 갯수에는 변화 X
*/
UPDATE tbl_menu
   SET category_code = 7
     , menu_name = '딸기맛붕어빵'
 WHERE menu_code = 24;

-- 서브쿼리 활용 UPDATE
UPDATE tbl_menu
   SET category_code = 6
 WHERE menu_code = (SELECT menu_code
                      FROM tbl_menu
                     WHERE menu_name = '파인애플탕');

UPDATE tbl_menu
   SET category_code = 6
 WHERE menu_code = (SELECT menu_code
                      FROM tbl_menu
                     WHERE menu_name = '초콜릿죽');

/* DELETE : 테이블의 행을 삭제

   [작성법]
   DELETE
     FROM 테이블
    WHERE 행 필터링 조건
    ORDER BY 정렬기준
    LIMIT 삭제할 개수;
*/

SELECT * FROM tbl_menu;

DELETE FROM tbl_menu
 where menu_code = 24;

-- tx 모드 : manual


DELETE FROM tbl_menu
ORDER BY menu_price
LIMIT 2;

SELECT * FROM tbl_menu ORDER BY menu_price limit 2;

-- 전체 행 삭제
DELETE FROM tbl_menu;

/* REPLACE : 중복된 데이터를 덮어쓸 수 있음
  - INSERT 진행 시 PK, UNIQUE 설정 컬럼 값이 같으면 에러 발생
  - REPLACE는 에러를 무시하고 덮어씌움
*/

 -- 에러 발생
# INSERT INTO tbl_menu VALUES (17, '참기름소주', 5000, 10, 'Y');

REPLACE INTO tbl_menu VALUES (17, '참기름소주', 5000, 10, 'Y');

select * from tbl_menu;

-- INTO는 생략가능
REPLACE tbl_menu VALUES (17, '참기름소주', 6500, 10, 'Y');

-- WHERE 절 없이도 PK 값이 일치하는 행을 찾아서 REPLACE 진행
REPLACE tbl_menu
    SET menu_code = 2
      , menu_name = '우럭쥬스'
      , menu_price = 2000
      , category_code = 9
      , orderable_status = 'N';