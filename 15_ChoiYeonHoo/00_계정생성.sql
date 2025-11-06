-- "--" : 주석 처리

show databases;

-- root 계정 접속
-- 계정 생성 후 데이터베이스 활용

-- 1) 새로운 swcamp 계정 만들기
CREATE USER 'swcamp'@'%' IDENTIFIED BY  'swcamp'; -- 'localhost' 대신 '%'를 쓰면 외부 ip로 접속 가능하다. 뒤 초록색 swcamp 는 비밀번호

-- 현재 존재하는 데이터 베이스 확인
show databases;

-- mysql 데이터베이스로 계정 정보 확인하기 -> 사용자 (user ) 정보 확인
use mysql;
-- 진행 후 스키마 탐색

-- 계정 생성 확인
select * from USER;

-- 데이터 베이스 == 데이터가 저장되는 곳

-- 2) 데이터 베이스 생성 후, 계정에 권한 부여 (root)
create database menudb;

-- menudb 데이터베이스(스키마) 생성 확인
show databases;

-- swcamp 계정에 권한 확인
show grants for 'swcamp'@'%';
-- 결과 : 아무 권한 없음
-- GRANT USAGE ON *.* TO `swcamp`@`%` IDENTIFIED BY PASSWORD '*79E90CE019B4B08AC1D2DBC22BECE6B3E6A682F7'

-- swcamp 계정에 menudb 데이터 베이스 모든 권한을 부여
grant all privileges on menudb.* to 'swcamp'@'%';

-- swcamp 계정에 권한 추가 확인
show grants for 'swcamp'@'%';
-- 결과 : menudb에 대하 swcamp가 모든 권한을 가짐
-- GRANT USAGE ON *.* TO `swcamp`@`%` IDENTIFIED BY PASSWORD '*79E90CE019B4B08AC1D2DBC22BECE6B3E6A682F7'
-- GRANT ALL PRIVILEGES ON `menudb`.* TO `swcamp`@`%`

-- menudb 데이터베이스 사용하기
use menudb;