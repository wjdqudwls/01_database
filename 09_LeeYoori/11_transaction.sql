/*
    11. transaction
    - Database에서 한 번에 수행되는 작업(dml 대상으로)의 단위
    - 기본적으로 mariaDB(mysql)는 auto commit이 활성화 된 상태
    > 비활성화 후  작업
*/

set autocommit = 1; -- autocommit activate
set autocommit = on;    -- autocommit on

set autocommit = 0;     -- autocommit nonactivate
set autocommit  = off;  -- autocommit nonactivate

-- 트랜잭션 관리 시작 > 이후에 실행되는 dml이 트랜잭션에 쌓임
start transaction;
SELECT * FROM tbl_menu;
INSERT INTO tbl_menu VALUES (null, '바나나해장국', 8500, 4, 'Y');
UPDATE tbl_menu SET menu_name = '수정된 메뉴' WHERE menu_code = 5;
DELETE FROM tbl_menu WHERE menu_code = 7;

-- Tcl 명령어 입력 시 트랜잭션 반영(commit) 또는 삭제 (rollback)
-- COMMIT;
ROLLBACK;
select * from tbl_menu;
update tbl_menu set menu_code = 7 where menu_code = 29;
insert into tbl_menu values(null, '민트미역국', 15000,4,'Y')


