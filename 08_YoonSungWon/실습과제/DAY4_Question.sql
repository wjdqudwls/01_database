/*
DAY4: Question
Q1.
다음 논리ERD와 물리ERD를 참고하여, 아래 조건을 만족하는 테이블을 생성하는 DDL 구
문을 작성하세요.
논리ERD
물리ERD
- 조건 -
TEAM_INFO 테이블의 PRIMARY KEY와 MEMBER_INFO 테이블의 PRIMARY
KEY는 AUTO_INCREMENT 설정을 해 값이 자동 채번되도록 한다.
TEAM_INFO 테이블의 USE_YN 컬럼의 기본값은 ‘Y’이며, ‘Y’또는 ‘N’의 데이터만 삽
입할 수 있다.
DAY4: Question 2
MEMBER_INFO 테이블의 ACTIVE_STATUS 컬럼의 기본값은 ‘Y’이며, 활동 중을 의
미하는 ‘Y’, 휴식 중을 의미하는 ‘N’, 잠정적 활동 상태인 ‘H’만 삽입할 수 있다.
*/

DROP TABLE IF EXISTS TEAM_INFO;
DROP TABLE IF EXISTS MEMBER_INFO;

    CREATE TABLE IF NOT EXISTS TEAM_INFO (
        TEAM_CODE INT PRIMARY KEY AUTO_INCREMENT                            COMMENT '소속코드',
        TEAM_NAME VARCHAR(100) NOT NULL                                     COMMENT '소속명',
        TEAM_DETAIL VARCHAR(500)                                            COMMENT '소속상세정보',
        USE_YN CHAR(2) NOT NULL DEFAULT 'Y'                                 COMMENT '사용여부',
        CHECK(USE_YN IN ('Y', 'N'))
    );

    CREATE TABLE IF NOT EXISTS MEMBER_INFO (
        MEMBER_CODE INT PRIMARY KEY AUTO_INCREMENT                          COMMENT '회원코드',
        MEMBER_NAME VARCHAR(70) NOT NULL                                    COMMENT '회원이름',
        BIRTH_DATE DATE                                                     COMMENT '생년월일',
        DIVISION_CODE CHAR(2)                                               COMMENT '구분코드',
        DETAIL_INFO VARCHAR(500)                                            COMMENT '상세정보',
        CONTACT VARCHAR(50) NOT NULL                                        COMMENT '연락처',
        TEAM_CODE INT NOT NULL                                              COMMENT '소속코드',
        ACTIVE_STATUS VARCHAR(2) NOT NULL  DEFAULT 'Y'                      COMMENT '활동상태',
        FOREIGN KEY (TEAM_CODE)
            REFERENCES TEAM_INFO(TEAM_CODE),
            CHECK(ACTIVE_STATUS IN ('Y','N','H'))
    );

/*
Q2.
Q1에서 생성한 TEAM_INFO 테이블과 MEMBER_INFO 테이블에 아래와 같이 데이터를
INSERT하는 쿼리를 작성하세요.
단, 삽입 대상 컬럼명은 반드시 명시해야 합니다.
TEAM_INFO 테이블 삽입 후 조회 결과
MEMBER_INFO 테이블 삽입 후 조회 결과
답안1 (TEAM_INFO INSERT구문)
답안2 (MEMBER_INFO INSERT구문)
*/
    INSERT INTO TEAM_INFO (TEAM_CODE, TEAM_NAME, TEAM_DETAIL, USE_YN) VALUES (1,'음악감상부','클래식 및 재즈 음악을 감상하는 사람들의 모임', 'Y');
    INSERT INTO TEAM_INFO (TEAM_CODE, TEAM_NAME, TEAM_DETAIL, USE_YN) VALUES (2,'맛집탐방부','맛집을 찾아다니는 사람들의 모임', 'N');
    INSERT INTO TEAM_INFO (TEAM_CODE, TEAM_NAME, TEAM_DETAIL, USE_YN) VALUES (3,'행복찾기부',NULL, 'Y');

    INSERT  INTO MEMBER_INFO (MEMBER_CODE,MEMBER_NAME, BIRTH_DATE, DIVISION_CODE, DETAIL_INFO, CONTACT, TEAM_CODE, ACTIVE_STATUS) VALUES (NULL,'송가인','1990-01-30',1,'안녕하세요 송가인입니다.','010-9494-9494',1,'H');
    INSERT  INTO MEMBER_INFO (MEMBER_CODE,MEMBER_NAME, BIRTH_DATE, DIVISION_CODE, DETAIL_INFO, CONTACT, TEAM_CODE, ACTIVE_STATUS) VALUES (NULL,'임영웅','1992-05-03',NULL,'국민아들 임영웅입니다.','010-9494-9494',1,'Y');
    INSERT  INTO MEMBER_INFO (MEMBER_CODE,MEMBER_NAME, BIRTH_DATE, DIVISION_CODE, DETAIL_INFO, CONTACT, TEAM_CODE, ACTIVE_STATUS) VALUES (NULL,'태진아',NULL,NULL,NULL,'(1급 비밀)',3,'Y');

    SELECT * FROM TEAM_INFO;
    SELECT * FROM MEMBER_INFO;
/*
Q3.
# 단합을 위한 사내 체육대회를 위하여 팀을 꾸리는 중입니다. 기술지원부의 대리, 인사관리부
의 사원, 영업부(팀명에 ‘영업’이 포함되면 영업부로 봄)의 부장을 한 팀으로 묶으려고 합니
다. 이때, 이 팀의 팀원 수를 출력하세요.
단, UNION과 SUBQUERY를 활용하여 출력하세요.
*/

SELECT
    COUNT(*)
FROM (
        -- 기술지원부 대리
        SELECT e.EMP_ID FROM employee e
        JOIN department d ON (e.DEPT_CODE = d.DEPT_ID)
        JOIN job j ON (e.JOB_CODE = j.JOB_CODE)
        WHERE d.DEPT_TITLE = '기술지원부'
        AND j.JOB_NAME = '대리'

        UNION

        -- 인사관리부 사원
        SELECT e.EMP_ID FROM employee e
        JOIN department d ON (e.DEPT_CODE = d.DEPT_ID)
        JOIN job j ON (e.JOB_CODE = j.JOB_CODE)
        WHERE d.DEPT_TITLE = '인사관리부'
        AND j.JOB_NAME = '사원'

        UNION

        -- 영업부 부장
        SELECT e.EMP_ID FROM employee e
        JOIN department d ON (e.DEPT_CODE = d.DEPT_ID)
        JOIN job j ON (e.JOB_CODE = j.JOB_CODE)
        WHERE d.DEPT_TITLE LIKE '%영업%'
        AND j.JOB_NAME = '부장'

     ) empDetail



