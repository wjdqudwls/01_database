/*
 11) transaction

- DB에서 한 번에 수행되는 작업(DML)의 단위
- 단계
    1. 시작
    2. 진행
    3. 종료
- 중간에 오류 발생시, 롤백
- 반영 원할 때, 커밋
    - MYSQL은 기본적으로 자동 커밋 설정
       추후에 롤백 원한다면 자동 커밋 설정 해제

 */

-- Auto-commit 활성화
SET AUTOCOMMIT = 1;
SET AUTOCOMMIT = ON;

SET AUTOCOMMIT = 0;
SET AUTOCOMMIT = OFF;
-- Tx 관리를 시작하겠다 -> 이후 실행되는 DML이 Tx에 쌓임
START TRANSACTION;

SELECT * FROM tbl_menu;
INSERT INTO tbl_menu VALUES (null, '바나나해장국', 8500, 4, 'Y');
UPDATE tbl_menu SET menu_name = '수정된 메뉴' WHERE menu_code = 5;
DELETE FROM tbl_menu WHERE menu_code = 7;

-- > TCL 명령어 입력 시 트랜잭션 반영(COMMIT) 또는 삭제(ROLLBACK)
-- COMMIT;
ROLLBACK;
SELECT *FROM tbl_menu;
