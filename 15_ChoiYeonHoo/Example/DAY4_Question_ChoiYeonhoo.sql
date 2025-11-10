/*
Q1. 다음 논리ERD와 물리ERD를 참고하여, 아래 조건을 만족하는 테이블을 생성하는 DDL 구문을 작성하세요.

- 조건 -
1. TEAM_INFO 테이블의 PRIMARY KEY와 MEMBER_INFO 테이블의
    PRIMARY KEY는 AUTO_INCREMENT 설정을 해 값이 자동 채번되도록 한다.

2. TEAM_INFO 테이블의 USE_YN 컬럼의 기본값은 ‘Y’이며,
    ‘Y’또는 ‘N’의 데이터만 삽입할 수 있다.
3. MEMBER_INFO 테이블의 ACTIVE_STATUS 컬럼의 기본값은 ‘Y’이며,
    활동 중을 의미하는 ‘Y’, 휴식 중을 의미하는 ‘N’, 잠정적 활동 상태인 ‘H’만 삽입할 수 있다.
*/

-- 만약 테이블 존재하면 삭제
DROP TABLE IF EXISTS MEMBER_INFO;
DROP TABLE IF EXISTS TEAM_INFO;

-- MEMBER_INFO에서 FK로 TEAM_CODE 사용 중이니까 우선 TEAM_INFO TABLE 만듬
CREATE TABLE IF NOT EXISTS TEAM_INFO
(
    TEAM_CODE INT AUTO_INCREMENT                                    COMMENT '소속코드',
    TEAM_NAME VARCHAR(100) NOT NULL                                 COMMENT '소속명',
    TEAM_DETAIL VARCHAR(500)                                        COMMENT '소속상세정보',
    USE_YN CHAR(2) NOT NULL DEFAULT 'Y'                             COMMENT '사용여부',

    PRIMARY KEY (TEAM_CODE),
    CHECK (USE_YN IN('Y', 'N'))
)ENGINE = INNODB COMMENT '소속정보';

CREATE TABLE IF NOT EXISTS MEMBER_INFO
(
    MEMBER_CODE INT AUTO_INCREMENT                                              COMMENT '회원코드',
    MEMBER_NAME VARCHAR(70) NOT NULL                                            COMMENT '회원이름',
    BIRTH_DATE DATE                                                             COMMENT '생년월일',
    DIVISION_CODE CHAR(2)                                                       COMMENT '구분코드',
    DETAIL_INFO VARCHAR(500)                                                    COMMENT '상세정보',
    CONTACT VARCHAR(50) NOT NULL                                                COMMENT '연락처',
    TEAM_CODE INT NOT NULL                                                      COMMENT '소속코드',
    ACTIVE_STATUS CHAR(2)  NOT NULL DEFAULT 'Y'                                 COMMENT '활동 상태',

    PRIMARY KEY (MEMBER_CODE),
    FOREIGN KEY (TEAM_CODE) REFERENCES TEAM_INFO(TEAM_CODE),
    CHECK ( ACTIVE_STATUS IN ('Y','N','H') )
)ENGINE = INNODB COMMENT '회원정보';

/*
Q2. Q1에서 생성한 TEAM_INFO 테이블과 MEMBER_INFO 테이블에 아래와 같이 데이터를 INSERT하는 쿼리를 작성하세요.
단, 삽입 대상 컬럼명은 반드시 명시해야 합니다.
*/

-- 1. (TEAM_INFO INSERT 구문)
INSERT INTO TEAM_INFO
    (TEAM_CODE, TEAM_NAME, TEAM_DETAIL, USE_YN)
VALUES
(NULL,'음악감상부', '클래식 및 재즈 음악을 감상하는 사람들의 모임', 'Y'),
(NULL,'맛집탐방부', '맛집을 찾아다니는 사람들의 모임', 'N'),
(NULL,'행복찾기부', NULL, 'Y')
;


-- 2. (MEMBER_INFO INSERT 구문)
INSERT INTO MEMBER_INFO
    (MEMBER_CODE, MEMBER_NAME, BIRTH_DATE, DIVISION_CODE, DETAIL_INFO, CONTACT, TEAM_CODE, ACTIVE_STATUS)
VALUES
(NULL,'송가인', '1991-01-30', '1','안녕하세요 송가인입니다~', '010-9494-9494',1,'H'),
(NULL,'임영웅', '1992-05-03', NULL,'국민아들 임영웅입니다.~', 'hero@trot.com',1,'Y'),
(NULL,'태진아', NULL, NULL,NULL, '(1급 기밀)',3,'Y')
;

SELECT * FROM TEAM_INFO;
SELECT * FROM MEMBER_INFO;


/*
-- -------------------------------

INSERT INTO
    team_info(team_code, team_name, team_detail, use_yn)
VALUES
    (null, '음악감상부', '클래식 및 재즈 음악을 감상하는 사람들의 모임', 'Y');
INSERT INTO
    team_info(team_name, team_detail, use_yn)
VALUES
    ('맛집탐방부', '맛집을 찾아다니는 사람들의 모임', 'N');
INSERT INTO
    team_info(team_name)
VALUES
    ('행복찾기부');

INSERT INTO
    member_info(member_code, member_name, birth_date, division_code, detail_info, contact, team_code, active_status)
VALUES
    (null, '송가인', '1990-01-30', 1, '안녕하세요 송가인입니다~', '010-9494-9494', 1, 'H');
INSERT INTO
    member_info(member_name, birth_date, detail_info, contact, team_code, active_status)
VALUES
    ('임영웅', '1992-05-03', '국민아들 임영웅입니다~', 'hero@trot.com', 1, 'Y');
INSERT INTO
    member_info(member_name, contact, team_code)
VALUES
    ('태진아', '(1급 기밀)', 3);
*/

/*
Q3.단합을 위한 사내 체육대회를 위하여 팀을 꾸리는 중입니다. 기술지원부의 대리, 인사관리부의 사원, 영업부(팀명에 ‘영업’이 포함되면 영업부로 봄)의 부장을 한 팀으로 묶으려고 합니다.
    이때, 이 팀의 팀원 수를 출력하세요.
    단, UNION과 SUBQUERY를 활용하여 출력하세요
*/

-- UNION 활용할 곳 :  각 부서별로 팀원명 출력한 값을 합침
-- 서브 쿼리 : 이 큰테이블을 하나로


-- 기술지원부 대리 추출 한번 작성
WITH TEAM_COUNT AS
    (
    -- 기술지원부 대리
    SELECT
        d.DEPT_TITLE,
        j.JOB_NAME,
        e.EMP_NAME
    FROM employee e
        JOIN department d ON (e.DEPT_CODE = d.DEPT_ID)
        JOIN job j ON (e.JOB_CODE = j.JOB_CODE)
    WHERE j.JOB_NAME = '대리' AND d.DEPT_TITLE LIKE ('%기술%')

    UNION
    -- 인사관리부 사원 추출
    SELECT
        d.DEPT_TITLE,
        j.JOB_NAME,
        e.EMP_NAME
    FROM employee e
        JOIN department d ON (e.DEPT_CODE = d.DEPT_ID)
        JOIN job j ON (e.JOB_CODE = j.JOB_CODE)
    WHERE j.JOB_NAME = '사원' AND d.DEPT_TITLE LIKE ('%인사%')

    UNION
    -- 영업부 부장 추출
    SELECT
        d.DEPT_TITLE,
        j.JOB_NAME,
        e.EMP_NAME
    FROM employee e
        JOIN department d ON (e.DEPT_CODE = d.DEPT_ID)
        JOIN job j ON (e.JOB_CODE = j.JOB_CODE)
    WHERE j.JOB_NAME = '부장' AND d.DEPT_TITLE LIKE ('%영업%')
    )
SELECT
    COUNT(*)
FROM TEAM_COUNT
;