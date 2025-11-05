set autocommit = 1;

set autocommit = off;
-- ui에서 Tx 설정 안바뀔 수도 있으나, 실제로는 바뀜.

START TRANSACTION;

SELECT * FROM tbl_menu;
INSERT INTO tbl_menu VALUES (null, '바나나해장국', 8500, 4, 'Y');
UPDATE tbl_menu SET menu_name = '수정된 메뉴' WHERE menu_code = 5;
DELETE FROM tbl_menu WHERE menu_code = 7;

-- COMMIT;
ROLLBACK;
