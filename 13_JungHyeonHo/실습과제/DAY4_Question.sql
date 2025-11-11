# DAY4: Question
# Q1.
# 다음 논리ERD와 물리ERD를 참고하여, 아래 조건을 만족하는 테이블을 생성하는 DDL 구
# 문을 작성하세요.
# - 조건 -
# TEAM_INFO 테이블의 PRIMARY KEY와 MEMBER_INFO 테이블의 PRIMARY
# KEY는 AUTO_INCREMENT 설정을 해 값이 자동 채번되도록 한다.
# TEAM_INFO 테이블의 USE_YN 컬럼의 기본값은 ‘Y’이며, ‘Y’또는 ‘N’의 데이터만 삽
# 입할 수 있다.
CREATE TABLE IF NOT EXISTS TEAM_INFO
(
    TEAM_CODE   INT AUTO_INCREMENT COMMENT '소속코드',
    TEAM_NAME   VARCHAR(100) COMMENT '소속명',
    TEAM_DETAIL VARCHAR(500) COMMENT '소속상세정보',
    USE_YN      CHAR(2) COMMENT '사용여부',
    PRIMARY KEY (TEAM_CODE),
    CHECK (USE_YN IN ('Y', 'N'))
);

CREATE TABLE IF NOT EXISTS MEMBER_INFO
(
    MEMBER_CODE   INT AUTO_INCREMENT COMMENT '회원코드',
    MEMBER_NAME   VARCHAR(70) COMMENT '회원이름',
    BIRTH_DATE    DATE COMMENT '생년월일',
    DIVISION_CODE CHAR(2) COMMENT '구분코드',
    DETAIL_INFO   VARCHAR(500) COMMENT '상세정보',
    CONTACT       VARCHAR(50) COMMENT '연락처',
    TEAM_CODE     INT COMMENT '소속코드',
    ACTIVE_STATUS CHAR(2) DEFAULT 'Y' COMMENT '활동상태',
    PRIMARY KEY (MEMBER_CODE),
    FOREIGN KEY (TEAM_CODE) REFERENCES TEAM_INFO (TEAM_CODE),
    CHECK (ACTIVE_STATUS IN ('Y', 'N', 'H'))
);
DESC TEAM_INFO;
DESC MEMBER_INFO;
DROP TABLE IF EXISTS TEAM_INFO;
DROP TABLE IF EXISTS MEMBER_INFO;

# Q2.
# Q1에서 생성한 TEAM_INFO 테이블과 MEMBER_INFO 테이블에 아래와 같이 데이터를
# INSERT하는 쿼리를 작성하세요.
# 단, 삽입 대상 컬럼명은 반드시 명시해야 합니다.
# 답안1 (TEAM_INFO INSERT구문)
INSERT
INTO TEAM_INFO(TEAM_CODE, TEAM_NAME, TEAM_DETAIL, USE_YN)
VALUES (NULL, '음악감상부', '클래식 및 재즈 음악을 감상하는 사람들의 모임', 'Y'),
       (NULL, '맛집탐방부', '맛집을 찾아다니는 사람들의 모임', 'N'),
       (NULL, '행복찾기부', NULL, 'Y');
SELECT *
FROM TEAM_INFO;

# 답안2 (MEMBER_INFO INSERT구문)
INSERT
INTO MEMBER_INFO(MEMBER_CODE, MEMBER_NAME, BIRTH_DATE, DIVISION_CODE, DETAIL_INFO, CONTACT, TEAM_CODE, ACTIVE_STATUS)
VALUES (NULL, '송가인', '1999-01-30', 1, '안녕하세요 송가인입니다~', '010-9494-9494', 1, 'H'),
       (NULL, '임영웅', '1992-05-03', NULL, '국민아들 임영웅입니다~', 'hero@trot.com', 1, 'Y'),
       (NULL, '태진아', NULL, NULL, NULL, '(1급 기밀)', 3, 'Y');
SELECT *
FROM MEMBER_INFO;
# Q3.
# 단합을 위한 사내 체육대회를 위하여 팀을 꾸리는 중입니다.
# 기술지원부의 대리, 인사관리부의 사원, 영업부(팀명에 ‘영업’이 포함되면 영업부로 봄)의 부장
# 을 한 팀으로 묶으려고 합니다.
# 이때, 이 팀의 팀원 수를 출력하세요.
# 단, UNION과 SUBQUERY를 활용하여 출력하세요.
SELECT COUNT(*) 팀원수
FROM (WITH EDJ AS (SELECT E.EMP_ID, D.DEPT_TITLE, J.JOB_NAME
                   FROM employee E
                            JOIN department D ON E.DEPT_CODE = D.DEPT_ID
                            JOIN job J ON E.JOB_CODE = J.JOB_CODE)
      SELECT *
      FROM EDJ
      WHERE EDJ.JOB_NAME = '대리'
        AND EDJ.DEPT_TITLE = '기술지원부'
            UNION
      SELECT *
      FROM EDJ
      WHERE EDJ.JOB_NAME = '사원'
        AND EDJ.DEPT_TITLE = '인사관리부'
            UNION
      SELECT *
      FROM EDJ
      WHERE EDJ.JOB_NAME = '부장'
        AND EDJ.DEPT_TITLE LIKE '%영업%') AS TEAM;
