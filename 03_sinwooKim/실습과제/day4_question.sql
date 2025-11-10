DROP TABLE IF EXISTS member_info;
DROP TABLE IF EXISTS team_info;


CREATE TABLE IF NOT EXISTS team_info(
    team_code   INT AUTO_INCREMENT          COMMENT '소속코드',
    team_name   VARCHAR(100) NOT NULL       COMMENT '소속명',
    team_detail VARCHAR(500)                COMMENT '소속상세정보',
    use_yn      CHAR(2)      NOT NULL  DEFAULT 'Y'  COMMENT '사용여부',
    PRIMARY KEY (team_code),
    CHECK ( use_yn IN ('Y','N') )
) ENGINE = INNODB COMMENT '소속정보';


CREATE TABLE IF NOT EXISTS member_info(
    member_code INT AUTO_INCREMENT       COMMENT '회원코드',
    member_name VARCHAR(70)     NOT NULL COMMENT '회원이름',
    birth_date  DATE                     COMMENT '생년월일',
    division_code CHAR(2)                COMMENT '구분코드',
    detail_info VARCHAR(500)             COMMENT '상세정보',
    contact VARCHAR(50)         NOT NULL COMMENT '연락처',
    team_code INT               NOT NULL COMMENT '소속코드',
    active_status CHAR(2)       NOT NULL DEFAULT 'Y' COMMENT '활동상태',
    PRIMARY KEY (member_code),
    FOREIGN KEY (team_code)
        REFERENCES team_info(team_code),
    CHECK (active_status IN ('Y', 'N', 'H'))
) ENGINE = INNODB COMMENT '회원정보';

-- Q2
INSERT INTO TEAM_INFO(TEAM_NAME, TEAM_DETAIL, USE_YN)
VALUES ('음악감상부','클래식 재즈 및 음악을 감상하 사람들의 모임','Y'),
       ('맛집탐방부','맛집을 찾아다니는 사람들의 모임','N'),
       ('행복찾기부',NULL,'Y');

INSERT INTO MEMBER_INFO(MEMBER_NAME, BIRTH_DATE, DIVISION_CODE, DETAIL_INFO, CONTACT, TEAM_CODE, ACTIVE_STATUS)
VALUES ('송가인','1990-01-30',1,'안녕하세요 송가인입니다~','010-9494-9494',1,'H'),
       ('임영웅','1992-05-03',NULL,'국민아들 임영웅입니~','hero@trot.com',1,'Y'),
       ('태진아',NULL,NULL,NULL,'(1급 기밀)',3,'Y');

-- Q3
SELECT COUNT(T.EMP_ID) 팀원수
FROM (
-- 기술지원부 대리
         SELECT E.EMP_ID
         FROM EMPLOYEE E
                  JOIN DEPARTMENT D ON E.DEPT_CODE = D.DEPT_ID
                  JOIN JOB J ON E.JOB_CODE = J.JOB_CODE
         WHERE D.DEPT_ID = (SELECT DEPT_ID
                            FROM DEPARTMENT
                            WHERE DEPT_TITLE LIKE '기술지원부')
           AND J.JOB_CODE = (SELECT JOB_CODE
                             FROM JOB
                             WHERE JOB_NAME = '대리')
         UNION
-- 인사관리부 사원
         SELECT E.EMP_ID
         FROM EMPLOYEE E
                  JOIN DEPARTMENT D ON E.DEPT_CODE = D.DEPT_ID
                  JOIN JOB J ON E.JOB_CODE = J.JOB_CODE
         WHERE D.DEPT_ID = (SELECT DEPT_ID
                            FROM DEPARTMENT
                            WHERE DEPT_TITLE LIKE '인사관리부')
           AND J.JOB_CODE = (SELECT JOB_CODE
                             FROM JOB
                             WHERE JOB_NAME = '사원')
         UNION
-- 영업부 부장
         SELECT E.EMP_ID
         FROM EMPLOYEE E
                  JOIN DEPARTMENT D ON E.DEPT_CODE = D.DEPT_ID
                  JOIN JOB J ON E.JOB_CODE = J.JOB_CODE
         WHERE D.DEPT_ID IN (SELECT DEPT_ID
                             FROM DEPARTMENT
                             WHERE DEPT_TITLE LIKE '%영업%')
           AND J.JOB_CODE = (SELECT JOB_CODE
                             FROM JOB
                             WHERE JOB_NAME = '부장')
) AS T;
