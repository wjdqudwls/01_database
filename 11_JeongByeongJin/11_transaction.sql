/* 11. TRANSACTION
   - 데이터베이스에서 한 번에 수행되는 작업(DML 쌓임)의 단위

   - 기본적으로 Mariadb(MySQL)는 Auto-Commit 활성화된 상태
    -> 비활성화 후 작업

*/
-- 오토커밋 ON / OFF
SET autocommit = ON; -- Auto-Commit 활성화
SET autocommit = OFF; -- Auto-Commit 비활성화


-- 트랜잭션 관리 시작 -> 이후에 실행되는 DML이 트랜잭션에 쌓임
START TRANSACTION;

SELECT * FROM tbl_menu;
INSERT INTO tbl_menu VALUES (null, '바나나해장국', 8500, 4, 'Y');
UPDATE tbl_menu SET menu_name = '수정된 메뉴' WHERE menu_code = 5;
DELETE FROM tbl_menu WHERE menu_code = 7;

SELECT * FROM tbl_menu;

-- TCL 명령어 입력 시 트랜잭션 반영(COMMIT) 또는 삭제(ROLLBACK)
ROLLBACK; -- : 트랜잭션 내 DML을 지워서 마지막 COMMIT 상태로 돌아감
-- COMMIT;-- : 트랜잭션 내 DML을 DB에 반영
