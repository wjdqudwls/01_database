-- 주석 : 해석되지 않는 문장, 문자열, 라인
show database;

-- root 계정 접속

-- 계정 생성 후 데이터베이스 활용

-- 1) 새로운 swcamp 계정 만들기
CREATE USER 'swcamp'@'%' IDENTIFIED BY  'swcamp'; -- 'localhost' 대신 '%'를 쓰면 외부 ip로 접속 가능하다.

-- 현재 존재하는 데이터베이스 확인
                                                  show databases;

-- ㅡmysql 데이터베이스를 사용 -> 사용자(user) 정보확인
use mysql;

-- swcamp 계정 생성 확인
select * from user;

-- 데이터베이스 == 데이터가 저장되는 곳(파일)

-- 2. 데이터베이스 생성 후 계정에 권한 부여 (root)
create database menudb;

-- menudb 데이터베이스(==스키마) 생성 확인
show databases;

-- swcamp 계정에 권한 확인
show grants for 'swcamp'@'%';

-- swcamp 계정에 menudb database 모든 권한 부여
grant all privileges on menudb.* to 'swcamp'@'%';

-- swcamp 계정에 권한 추가 확인
show grants for 'swcamp'@'%';

-- menudb 데이터 베이스 사용하기
use menudb;

DROP USER IF EXISTS 'practice'@'localhost';
CREATE USER 'practice'@'localhost' IDENTIFIED BY 'practice';
GRANT ALL PRIVILEGES ON employeedb.* TO 'practice'@'localhost';
