/*
    11. Transaction
    데이터베이스에서 한 번에 수행되는 작업(DML)의 단위

    기본적으로 mariadb(mysql)은 Auto-commit 활성화된 상태
    -> 비활성화 후 작업
*/
SET AUTOCOMMIT = 1; -- Auto-Commit 활성화
SET AUTOCOMMIT = ON; -- Auto-Commit 활성화

SET AUTOCOMMIT = 0; -- Auto-Commit 비활성화
SET AUTOCOMMIT = OFF; -- Auto-Commit 비활성화

-- TRANSACTION 관리 시작 -> 이후에 실행되는 DML이 트랜잭션ㄴ에 쌓임
START TRANSACTION;

SELECT * FROM tbl_menu;
INSERT INTO tbl_menu VALUES (null, '바나나해장국', 8500, 4, 'Y');
UPDATE tbl_menu SET menu_name = '수정된 메뉴' WHERE menu_code = 5;
DELETE FROM tbl_menu WHERE menu_code = 7;

-- TCL 명령어 입력 시 트랜잭션 반영(COMMIT) 또는 삭제(ROLLBACK)
ROLLBACK;
-- COMMIT