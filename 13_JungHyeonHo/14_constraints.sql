/* 14_CONSTRAINTS (제약조건)
   a) 테이블의 데이터(컬럼 값)가 입력 또는 수정 될 때의 규칙
        a-ex) 특정 형태의 데이터만 삽입 가능, 꼭 값이 있어야됨.
   b) 데이터베이스 무결성 보장*/

-- 1) NOT NULL
--      - NULL(빈칸) 허용 X 제약조건
--          == 무조건 값이 들어가야 한다
--      - NOT NULL 제약조건은 컬럼 레벨만 가능하다!!
DROP TABLE IF EXISTS user_notnull;
CREATE TABLE IF NOT EXISTS user_notnull
(
    user_no   INT          NOT NULL, -- 컬럼 레벨 제약 조건
    user_id   VARCHAR(255) NOT NULL,
    user_pwd  VARCHAR(255) NOT NULL,
    user_name VARCHAR(255) NOT NULL,
    gender    VARCHAR(3),
    phone     VARCHAR(255) NOT NULL,
    email     VARCHAR(255)
) ENGINE = INNODB;

INSERT
INTO user_notnull
    (user_no, user_id, user_pwd, user_name, gender, phone, email)
VALUES (1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@gmail.com'),
       (2, 'user02', 'pass02', '유관순', '여', '010-777-7777', 'yu77@gmail.com');

SELECT *
FROM user_notnull;

-- INSERT 테스트(NOT NULL 제약 조건 위배)
INSERT
INTO user_notnull
    (user_no, user_id, user_pwd, user_name, gender, phone, email)
VALUES (3, 'user03', null, '이순신', '남', '010-222-2222', 'lee222@gmail.com');

/*
 2. UNIQUE
    - UNIQUE 제약 조건이 설정된 컬럼 내에 동일한 값(중복 값)을
        허용하지 않는 제약 조건

    - NULL은 중복 안된다
 */

 DROP TABLE IF EXISTS user_unique;
CREATE TABLE IF NOT EXISTS user_unique (
    user_no INT NOT NULL,
    user_id VARCHAR(255) NOT NULL,
    user_pwd VARCHAR(255) NOT NULL,
    user_name VARCHAR(255) NOT NULL,
    gender VARCHAR(3),
    phone VARCHAR(255) NOT NULL UNIQUE, -- 컬럼 정의 행에 적었기 때문에, 컬럼 레벨 제약 조건
    email VARCHAR(255)
    ,UNIQUE (phone) -- 테이블 레벨 제약 조건
) ENGINE=INNODB;

DESC user_unique; -- KEY값에 PRI는 PK거나 NOT NULL,UNIQUE
INSERT
  INTO user_unique
(user_no, user_id, user_pwd, user_name, gender, phone, email)
VALUES
(1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@gmail.com'),
(2, 'user02', 'pass02', '유관순', '여', '010-777-7777', 'yu77@gmail.com');

SELECT * FROM user_unique;

-- INSERT 테스트 (UNIQUE 제약 조건 위배)
INSERT
  INTO user_unique
(user_no, user_id, user_pwd, user_name, gender, phone, email)
VALUES
(3, 'user03', 'pass03', '이순신', '남', '010-777-7777', 'lee222@gmail.com');
-- Duplicate entry '010-777-7777' for key 'phone'

/* 3. PRIMARY KEY
    -테이블의 각 행을 구분하ㅏ는 식별자 역할의 제약 조건
    -테이블당 1개만 존재 가능
     (여러 컬럼을 묶어서 하나의 PK로 설정 가능 == 복합키)

   - UNIQUE(중복 X) + NOT NULL(빈칸 X)
     (효과가 같다는 의미, 진짜 PK가 되지 않는다.)
 */
DROP TABLE IF EXISTS user_primarykey;
CREATE TABLE IF NOT EXISTS user_primarykey (
--     user_no INT PRIMARY KEY, -- 컬럼 레벨 제약 조건
    user_no INT,
    user_id VARCHAR(255) NOT NULL,
    user_pwd VARCHAR(255) NOT NULL,
    user_name VARCHAR(255) NOT NULL,
    gender VARCHAR(3),
    phone VARCHAR(255) NOT NULL,
    email VARCHAR(255),
    PRIMARY KEY (user_no) -- 테이블 레벨 제약 조건
) ENGINE=INNODB;

INSERT
  INTO user_primarykey
(user_no, user_id, user_pwd, user_name, gender, phone, email)
VALUES
(1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@gmail.com'),
(2, 'user02', 'pass02', '유관순', '여', '010-777-7777', 'yu77@gmail.com');

SELECT * FROM user_primarykey;

-- INSERT 테스트 (PK 제약 조건 위배)
INSERT
  INTO user_primarykey
(user_no, user_id, user_pwd, user_name, gender, phone, email)
VALUES
(1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@gmail.com'),
(2, 'user02', 'pass02', '유관순', '여', '010-777-7777', 'yu77@gmail.com');

/* 4. FOREIGN KEY(외래키)_
    - 참조 제약 조건
    - 참조 무걀성을 위배하지 않기 위해 사용
        (참조하는 고셍 존재하는 데이터인지 검사)
    - 참조(REFERENCES)된 테이블에서 제공되는 값만 사용 가능

    - FK 제약 조건이 설정되면
      두 테이블 간의 관계(Relationship)가 형성됨
      (RDBMS에서 제일 중요한 개념)

    - 다른 테이블에서 제공되는 값 외에 NULL 사용 가능
      (단, FK, NOT NULL 같이 적용 시 NULL 허용 X)
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
    FOREIGN KEY (grade_code)
		REFERENCES user_grade (grade_code) -- 테이블 레벨 제약 조건
) ENGINE=INNODB;


INSERT
  INTO user_foreignkey1
(user_no, user_id, user_pwd, user_name, gender, phone, email, grade_code)
VALUES
(1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@gmail.com', 10),
(2, 'user02', 'pass02', '유관순', '여', '010-777-7777', 'yu77@gmail.com', 20);

SELECT * FROM user_foreignkey1;


-- INSERT (FK 제약 조건 위배)
INSERT
  INTO user_foreignkey1
(user_no, user_id, user_pwd, user_name, gender, phone, email, grade_code)
VALUES
(3, 'user03', 'pass03', '이순신', '남', '010-777-7777', 'lee222@gmail.com', 50);
-- Cannot add or update a child row: a foreign key constraint fails (`menudb`.`user_foreignkey1`
-- , CONSTRAINT `user_foreignkey1_ibfk_1` FOREIGN KEY (`grade_code`) REFERENCES `user_grade` (`grade_code`))

-- INSERT (grade_code=null인 레코드를 INSERT하니 가능, 해당 레코드는 참조중이 아님)
INSERT
  INTO user_foreignkey1
(user_no, user_id, user_pwd, user_name, gender, phone, email, grade_code)
VALUES
(3, 'user03', 'pass03', '이순신',
 '남', '010-777-7777', 'lee222@gmail.com', null);

-- DELETE (FK 삭제 제약 조건 RESTRICT에 의한 위배)
DELETE
FROM user_grade
WHERE grade_code = 10;  -- 현재 user_grade.grade_code는 user_foreignkey1.grade_code에서 참조 중이다
-- Cannot delete or update a parent row:
-- a foreign key constraint fails (`menudb`.`user_foreignkey1`, CONSTRAINT `user_foreignkey1_ibfk_1` FOREIGN KEY (`grade_code`) REFERENCES `user_grade` (`grade_code`))

/*
 두 테이블 간의 관계 형성 시 (FK 설정)
 - 부모 테이블 : 참조를 당하는 테이블(참조할 값을 제공)
 - 자식 테이블 : 참조를 하는 테이블(제공 받은 값을 이용)
 */

-- FK 삭제 룰 중 'SET NULL' 적용
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
        ON UPDATE SET NULL  -- UPDATE 조건 설정
        ON DELETE SET NULL  -- DELETE 조건 설정
) ENGINE=INNODB;

INSERT
  INTO user_foreignkey2
(user_no, user_id, user_pwd, user_name, gender, phone, email, grade_code)
VALUES
(1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@gmail.com', 10),
(2, 'user02', 'pass02', '유관순', '여', '010-777-7777', 'yu77@gmail.com', 20);

SELECT * FROM user_foreignkey2;

-- SET NULL 삭제 옵션 테스트
-- (중요) user_foreignkey1 테이블 삭제 후 테스트 수행
-- WHY? 삭제 안하면 user_grade 수정/삭제 시
-- user_foreignkey1 테이블과의 관계로 인해 오휴 발생
DROP TABLE IF EXISTS user_foreignkey1;

UPDATE user_grade
   SET grade_code = null
 WHERE grade_code = 10;

-- 자식 테이블의 grade_code가 10이 었던 회원의 grade_code값이 NULL이 된 것을 확인
SELECT * FROM user_foreignkey2;

-- 부모 테이블(user_grade) 에서
--  grade_code가 20인 행을 삭제했을 때
--  ON DELETE SET NULL 옵션 동작 확인
DELETE
FROM user_grade
WHERE grade_code=20;


/* 5. CHECK 제약 조건
   - 해당 컬럼 조건에 맞는 값만 삽입/수정할 수 있도록 확인하는 제약 조건
   - SELECT의 WHERE절에 사용했던 조건식을 똑같이 사용
     EX) 비교연산자, IN, NOT IN, LIKE, NOT LIKE ....
 */
 DROP TABLE IF EXISTS user_check;
CREATE TABLE IF NOT EXISTS user_check (
    user_no INT AUTO_INCREMENT PRIMARY KEY,
    user_name VARCHAR(255) NOT NULL,
    gender VARCHAR(3) CHECK(gender IN ('남','여')),
    age INT CHECK(age >= 19)
) ENGINE=INNODB;

-- 정상 INSERT
INSERT
  INTO user_check
VALUES
(null, '홍길동', '남', 25),
(null, '이순신', '남', 33),
(null, '이순신', NULL, 33);

SELECT * FROM user_check;

-- CHECK 제약 조건 위배
INSERT
  INTO user_check
VALUES
(null, '홍길동', '포크레인', 25);

/* 6. DEFAULT (기본 값)
   - 일반적으로 현재 시간, 날짜를 기록할 때 쓰인다
   - INSERT/UPDATE 수행 시
     컬럼에 NULL을 삽입/수정하면 대신 들어갈 기본 값을 설정
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

INSERT
  INTO tbl_country
# VALUES (null, default, default, default, default);

values(null, null ,null, null, null);
-- null값만 들어감
SELECT * FROM tbl_country;

UPDATE tbl_country
SET
    country_name=DEFAULT,
    population=DEFAULT,
    add_day=DEFAULT,
    add_time=DEFAULT;