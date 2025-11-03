-- 새로운 계정 생성
CREATE USER 'swcamp'@'%' IDENTIFIED BY 'swcamp';

SHOW DATABASES;

-- mysql 데이터베이스를 사용 -> 사용자(user) 정보 확인
USE mysql;

-- 새로 생성한 계정 확인
SELECT * FROM USER;

-- DB 생성
-- 2) DB생성 후 계정에 권한 부여(root)
CREATE DATABASE menudb;

-- menudb DB생성 확인
SHOW DATABASES ;

-- swcamp 계정에 권한 확인
SHOW GRANTS FOR 'swcamp'@'%';

-- swcamp 계정에 menudb DB의 모든 권한 부여
GRANT ALL PRIVILEGES ON menudb.* TO 'swcamp'@'localhost' IDENTIFIED BY 'swcamp' WITH GRANT OPTION;


USE menudb;