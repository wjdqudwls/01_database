-- 주석 : 해석되지 않는 문장, 문자열, 라인
show databases;

CREATE USER 'swcamp'@'%' IDENTIFIED BY  'swcamp'; -- 'localhost' 대신 '%'를 쓰면 외부 ip로 접속 가능하다.

show databases;

-- mysql 데이터베이스를 사용 -> 사용자(user) 정보 확인
USE mysql;

-- swcamp 계정 생성 확인
SELECT * FROM USER;

-- 데이터베이스 == 데이터가 저장되는 곳(파일)

-- 2) 데이터베이스 생성 후 계정에 권한 부여(root)
CREATE DATABASE menudb;

-- menudb 데이터베이스(==스키마) 생성 확인
show DATABASES;

-- swcamp 계정에 권한 확인
SHOW GRANTS FOR 'swcamp'@'%';

-- swcamp 계정에 menudb database 모든 권한 부여
GRANT ALL PRIVILEGES ON menudb.* TO 'swcamp'@'%';

-- swcamp 계정에 권한 추가 확인
SHOW GRANTS FOR 'swcamp'@'%';

-- menudb 데이터베이스 사용하기
USE menudb;




