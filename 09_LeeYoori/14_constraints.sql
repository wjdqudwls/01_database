/*
    14_constraints(제약조건)
    - 테이블의 데이터(컬럼 값)가 입력 또는 수정 될 때의 규칙
    ex) 특정 형태의 데이터만 삽입 가능, 꼭 값이 있어야 함
    - 데이터베이스 무결성 보장

    1. not null
    - 빈칸을 혀용하지 않는 제약조건
    == 무조건 해당 컬럼에는 값이 있어야 한다.
    - not null 제약조건은 컬럼 레벨만 가능

    2.
*/

DROP TABLE IF EXISTS user_notnull;
CREATE TABLE IF NOT EXISTS user_notnull (
                                user_no INT NOT NULL,               -- 컬럼을 정의할때 같이 적는 것을 컬럼 레벨 제약조건이라고 함
                                user_id VARCHAR(255) NOT NULL,
                                user_pwd VARCHAR(255) NOT NULL,
                                user_name VARCHAR(255) NOT NULL,
                                gender VARCHAR(3),
                                phone VARCHAR(255) NOT NULL,
                                email VARCHAR(255)
) ENGINE=INNODB;


INSERT
INTO user_notnull
(user_no, user_id, user_pwd, user_name, gender, phone, email)
VALUES
    (1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@gmail.com'),
    (2, 'user02', 'pass02', '유관순', '여', '010-777-7777', 'yu77@gmail.com');

SELECT * FROM user_notnull;

-- not null 제약조건 위배
-- null 삽입이 허용되지 않음
INSERT
INTO user_notnull
(user_no, user_id, user_pwd, user_name, gender, phone, email)
VALUES
    (3, 'user03', null, '이순신', '남', '010-222-2222', 'lee222@gmail.com');

/*
    2. unique : unique제약조건이 설정된 컬럼 내에 동일한 값(제약 조건)을 허용하지 않는 제약조건
    - null은 중복이 된다.(null은 값이 아니므로)
*/

DROP TABLE IF EXISTS user_unique;
CREATE TABLE IF NOT EXISTS user_unique (
                                           user_no INT NOT NULL,
                                           user_id VARCHAR(255) NOT NULL,
                                           user_pwd VARCHAR(255) NOT NULL,
                                           user_name VARCHAR(255) NOT NULL,
                                           gender VARCHAR(3),
                                           phone VARCHAR(255) NOT NULL /*UNIQUE*/,  -- 컬럼 레벨 제약조건
                                           email VARCHAR(255)
                                            , UNIQUE (phone)
) ENGINE=INNODB;    -- 괄호안에 있는 것을 테이블 레벨 제약조건이라고 한다.

desc user_unique;

-- 정상데이터 insert
INSERT
INTO user_unique
(user_no, user_id, user_pwd, user_name, gender, phone, email)
VALUES
    (1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@gmail.com'),
    (2, 'user02', 'pass02', '유관순', '여', '010-777-7777', 'yu77@gmail.com');

SELECT * FROM user_unique;

-- 오류데이터 insert(unique 제약조건 위배)
-- [23000][1062] (conn=108) Duplicate entry '010-777-7777' for key 'phone
INSERT
INTO user_unique
(user_no, user_id, user_pwd, user_name, gender, phone, email)
VALUES
    (3, 'user03', 'pass03', '이순신', '남', '010-777-7777', 'lee222@gmail.com');

/*
    3. primary key
    - 테이블의 각 행을 구분하는 식별자 역할의 제약조건
    - 테이블 당 하나만 가질 수 있음
    - 여러 컬럼을 묶어서 하나의 pk로 설정 가능 == 복합키
    - 중복을 허용하지 않음
    - not null
    - unique + not null > 효과가 같다는 뜻이지 unique랑 not null이 있다고해서 pk가 되는 것은 아님
    - 대표 역할
*/


DROP TABLE IF EXISTS user_primarykey;
CREATE TABLE IF NOT EXISTS user_primarykey (
--     user_no INT PRIMARY KEY, -- 컬럼 레벨 제약조건 설정
                                               user_no INT,
                                               user_id VARCHAR(255) NOT NULL,
                                               user_pwd VARCHAR(255) NOT NULL,
                                               user_name VARCHAR(255) NOT NULL,
                                               gender VARCHAR(3),
                                               phone VARCHAR(255) NOT NULL,
                                               email VARCHAR(255),
                                               PRIMARY KEY (user_no)    -- 테이블 레벨로 제약조건 설정
) ENGINE=INNODB;



INSERT
INTO user_primarykey
(user_no, user_id, user_pwd, user_name, gender, phone, email)
VALUES
    (1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@gmail.com'),
    (2, 'user02', 'pass02', '유관순', '여', '010-777-7777', 'yu77@gmail.com');

SELECT * FROM user_primarykey;

-- primary key 제약조건 에러발생(null값 적용)
INSERT
INTO user_primarykey
(user_no, user_id, user_pwd, user_name, gender, phone, email)
VALUES
    (null, 'user03', 'pass03', '이순신', '남', '010-777-7777', 'lee222@gmail.com');
-- 23000][1048] (conn=108) Column 'user_no' cannot be null

-- primary key 제약조건 에러 발생(중복값 적용)
INSERT
INTO user_primarykey
(user_no, user_id, user_pwd, user_name, gender, phone, email)
VALUES
    (2, 'user03', 'pass03', '이순신', '남', '010-777-7777', 'lee222@gmail.com');
-- [23000][1062] (conn=108) Duplicate entry '2' for key 'PRIMARY']


/* 4. Foreign key외래키';)

   - 참조 제약조건
   - 참조 무결성을 위배하지 않기 위해 사용
   - 참조하는 곳에 존재하는 데이터인지 검사
   - 참조 (reference) 된 테이블에서 제공되는 값만 사용 가능
   - fk 제약조건이 설정되면 두 테이블 간의 관계(relationship)가 형성됨
   (RDBMS에서 제일 중요한 개념)

   - 다른 테이블에서 제공되는 값 외에 null 사용가능한데 단,
   -- fk랑 not null 같이 적용 시 null 허용 안됨
   */

DROP TABLE IF EXISTS user_grade;
CREATE TABLE IF NOT EXISTS user_grade (
                                          grade_code INT UNIQUE,
                                          grade_name VARCHAR(255) NOT NULL
) ENGINE=INNODB;

INSERT
INTO user_grade
VALUES
    (10, '일반회원'),
    (20, '우수회원'),
    (30, '특별회원');

SELECT * FROM user_grade;

-- user_grade 테이블의 grade_code 값을 참조
DROP TABLE IF EXISTS user_foreignkey1;
CREATE TABLE IF NOT EXISTS user_foreignkey1 (
                                                user_no INT PRIMARY KEY,
                                                user_id VARCHAR(255) NOT NULL,
                                                user_pwd VARCHAR(255) NOT NULL,
                                                user_name VARCHAR(255) NOT NULL,
                                                gender VARCHAR(3),
                                                phone VARCHAR(255) NOT NULL,
                                                email VARCHAR(255),
                                                grade_code INT ,
                                                -- 테이블레벨 제약조건
                                                FOREIGN KEY (grade_code)
                                                    REFERENCES user_grade (grade_code)
) ENGINE=INNODB;

-- 정상 데이터 insert (grade_code 10,20 check)
INSERT
INTO user_foreignkey1
(user_no, user_id, user_pwd, user_name, gender, phone, email, grade_code)
VALUES
    (1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@gmail.com', 10),
    (2, 'user02', 'pass02', '유관순', '여', '010-777-7777', 'yu77@gmail.com', 20);

SELECT * FROM user_foreignkey1;

INSERT
INTO user_foreignkey1
(user_no, user_id, user_pwd, user_name, gender, phone, email, grade_code)
VALUES
    (3, 'user03', 'pass03', '이순신', '남', '010-777-7777', 'lee222@gmail.com', 50);

-- [23000][1452] (conn=108) Cannot add or update a child row: a foreign key constraint fails (`menudb`.`user_foreignkey1`, CONSTRAINT `user_foreignkey1_ibfk_1` FOREIGN KEY (`grade_code`) REFERENCES `user_grade` (`grade_code`)
select * from user_foreignkey1;

-- user_foreignkey1.grade_code 컬럼에 not null 제약조건설정x
INSERT
INTO user_foreignkey1
(user_no, user_id, user_pwd, user_name, gender, phone, email, grade_code)
VALUES
    (3, 'user03', 'pass03', '이순신', '남', '010-777-7777', 'lee222@gmail.com', null);

select * from user_grade;

-- restrict : 삭제 불가(못지우게 막음)
-- cascade : 종속관계 (부 테이블의 컬럼의 데이터가 지워지면 자 테이블의 데이터도 지워짐)
-- set null : 지워지면 null값 넣음
-- set default : 지워지면 기본값 넣음
-- no action : migration시 사용

-- 삭제룰이 설정되지 않은 경우(restrict)
DELETE
FROM user_grade
WHERE grade_code = 10;
-- [23000][1451] (conn=26) Cannot delete or update a parent row: a foreign key constraint fails (`menudb`.`user_foreignkey1`, CONSTRAINT `user_foreignkey1_ibfk_1` FOREIGN KEY (`grade_code`) REFERENCES `user_grade` (`grade_code`))
-- 참조를 다른 곳에서 하고있으므로 삭제를 할 수 없음



/*
    두 테이블 간의 관계 형성 시 (fk 설정)
    - 부모 테이블 : 참조를 당하는 테이블(참조할 값을 제공)
    - 자식 테이블 : 참조를 하는 테이블(제공받은 값을 이용)
*/

-- fk 삭제룰 중 'set null' 적용
DROP TABLE IF EXISTS user_foreignkey2;
CREATE TABLE IF NOT EXISTS user_foreignkey2 (
                                                user_no INT PRIMARY KEY,
                                                user_id VARCHAR(255) NOT NULL,
                                                user_pwd VARCHAR(255) NOT NULL,
                                                user_name VARCHAR(255) NOT NULL,
                                                gender VARCHAR(3),
                                                phone VARCHAR(255) NOT NULL,
                                                email VARCHAR(255),
                                                grade_code INT ,
                                                FOREIGN KEY (grade_code)
                                                    REFERENCES user_grade (grade_code)
                                                    ON UPDATE SET NULL  -- 부모 값이 바뀌면 참조하는 자식의 값을 null로 변경
                                                    ON DELETE SET NULL  -- 부모 값이 수정되면 참조하는 자식의 값을 null로 변경
) ENGINE=INNODB;

INSERT
INTO user_foreignkey2
(user_no, user_id, user_pwd, user_name, gender, phone, email, grade_code)
VALUES
    (1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@gmail.com', 10),
    (2, 'user02', 'pass02', '유관순', '여', '010-777-7777', 'yu77@gmail.com', 20);

SELECT * FROM user_foreignkey2;

-- set null 삭제 옵션 테스트
-- (중요) user_foreignkey1 테이블 삭제 후 테스트 수행
-- 삭제 안하면 user_grade 수정/삭제 시 user_foreignkey1 테이블과의 관계로 인해 오류 발생
DROP TABLE IF EXISTS user_foreignkey1;

select * from user_grade;

UPDATE user_grade
SET grade_code = null
WHERE grade_code = 10;

-- 자식 테이블의 grade_code가 10이 었던 회원의 grade_code값이 NULL이 된 것을 확인
SELECT * FROM user_foreignkey2;


-- 부모 테이블(user_grade)에서 grade_code가 20인 행을 삭제했을 때 on delete set null 옵션 동작 확인
delete from user_grade where grade_code = 20;

-- user_foreignkey2 테이블에서 20을 참조하던 컬럼값이 null로 변경되었는지 확인
select * from user_grade;
select * from user_foreignkey2;

/*
    5. check 제약조건
    - 해당 컬럼에 조건에 맞는 값만 삽입/수정 될 수 있도록 확인하는 제약조건
    - select의 where절에 사용했던 조건식을 똑같이 사용
    - ex) =, !=, >=, <=, >, <, in, not in, like, not like
*/

DROP TABLE IF EXISTS user_check;
CREATE TABLE IF NOT EXISTS user_check (
                                          user_no INT AUTO_INCREMENT PRIMARY KEY,
                                          user_name VARCHAR(255) NOT NULL,
                                          gender VARCHAR(3) CHECK(gender IN ('남','여')),
                                          age INT CHECK(age >= 19)
) ENGINE=INNODB;

INSERT
INTO user_check
VALUES
    (null, '홍길동', '남', 25),
    (null, '이순신', '남', 33);

SELECT * FROM user_check;

-- gender 컬럼의 check 제약조건 위배(남 > '남성')
INSERT
INTO user_check
VALUES (null, '안중근', '남성', 27);
-- [23000][4025] (conn=121) CONSTRAINT `user_check.gender` failed for `menudb`.`user_check

-- age 컬럼의 check 제약조건 위배
INSERT
INTO user_check
VALUES (null, '유관순', '여', 17);
-- [23000][4025] (conn=121) CONSTRAINT `user_check.age` failed for `menudb`.`user_check`

/*
    6. default : 기본값
    - insert/update 수행 시 컬럼에 null을 삽입/수정하면 대신 들어가는 기본값 설정
*/

DROP TABLE IF EXISTS tbl_country;
CREATE TABLE IF NOT EXISTS tbl_country (
                                           country_code INT AUTO_INCREMENT PRIMARY KEY,
                                           country_name VARCHAR(255) DEFAULT '한국',
                                           population VARCHAR(255) DEFAULT '0명',
                                           add_day DATE DEFAULT (current_date),
                                           add_time DATETIME DEFAULT (current_time)
) ENGINE=INNODB;

SELECT * FROM tbl_country;

insert into tbl_country values(null, default, default, default, default);

INSERT
INTO tbl_country
VALUES (null, default, default, default, default);

-- values(null, null ,null, null, null)
-- null값만 들어감
SELECT * FROM tbl_country;

update tbl_country set country_name = default
where country_code = 0;