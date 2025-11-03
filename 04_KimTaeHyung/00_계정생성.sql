show databases;

-- root 계정 접속
-- 계정 생성 후 데이터베이스 활용

-- 1) 새로운 swcamp 계정 만들기
CREATE USER 'swcamp'@'%' IDENTIFIED BY  'swcamp'; -- 'localhost' 대신 '%'를 쓰면 외부 ip로 접속 가능하다.

-- 현재 존재하는 데이터베이스 확인
SHOW DATABASES;

-- mysql 데이터베이스를 사용 -> 사용자(user) 정보 확인
USE mysql;

-- swcamp 계정 생성 확인
SELECT * FROM USER;

-- 데이터베이스 == 데이터가 저장되는 곳(파일)

-- 2) 데이터베이스 생성 후 계정에 권한 부여 (root)
CREATE DATABASE menudb;

-- menudb 데이터베이스(==스키마) 생성 확인
SHOW DATABASES;

-- swcamp 계정에 권한 확인
SHOW GRANTS FOR 'swcamp'@'%';

-- swcamp 계정에 menudb database 모든 권한 부여
GRANT ALL PRIVILEGES ON menudb.* TO 'swcamp'@'%';

-- swcamp 계정에 권한 추가 확인
SHOW GRANTS FOR 'swcamp'@'%';

-- menudb 데이터 베이스 사용하기
USE menudb;

