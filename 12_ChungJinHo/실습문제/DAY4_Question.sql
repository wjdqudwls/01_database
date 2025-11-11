# DAY4: Question
# Q1.
# 다음 논리ERD와 물리ERD를 참고하여, 아래 조건을 만족하는 테이블을 생성하는 DDL 구
# 문을 작성하세요.
# - 조건 -
# TEAM_INFO 테이블의 PRIMARY KEY와 MEMBER_INFO 테이블의 PRIMARY
# KEY는 AUTO_INCREMENT 설정을 해 값이 자동 채번되도록 한다.
# TEAM_INFO 테이블의 USE_YN 컬럼의 기본값은 ‘Y’이며, ‘Y’또는 ‘N’의 데이터만 삽
# 입할 수 있다.
# MEMBER_INFO 테이블의 ACTIVE_STATUS 컬럼의 기본값은 ‘Y’이며, 활동 중을 의
# 미하는 ‘Y’, 휴식 중을 의미하는 ‘N’, 잠정적 활동 상태인 ‘H’만 삽입할 수 있다.
# 답안
-- TEAM_INFO 테이블 생성
CREATE TABLE TEAM_INFO (
    TEAM_CODE INT AUTO_INCREMENT PRIMARY KEY COMMENT '소속코드',
    TEAM_NAME VARCHAR(200) COMMENT '소속명',
    TEAM_DETAIL VARCHAR(500) COMMENT '소속상세정보',
    USE_YN CHAR(2) DEFAULT 'Y' COMMENT '사용여부',
    CHECK (USE_YN IN ('Y','N'))
) ENGINE=INNODB COMMENT='소속 정보 테이블';


-- MEMBER_INFO 테이블 생성
CREATE TABLE MEMBER_INFO (
    MEMBER_CODE INT AUTO_INCREMENT PRIMARY KEY COMMENT '회원코드',
    MEMBER_NAME VARCHAR(70) COMMENT '회원이름',
    BIRTH_DATE DATE COMMENT '생년월일',
    DIVISION_CODE CHAR(2) COMMENT '구분코드',
    DETAIL_INFO VARCHAR(500) COMMENT '상세정보',
    CONTACT VARCHAR(50) COMMENT '연락처',
    TEAM_CODE INT COMMENT '소속팀코드',
    ACTIVE_STATUS CHAR(2) DEFAULT 'Y' COMMENT '활동상태',
    CONSTRAINT FK_MEMBER_TEAM FOREIGN KEY (TEAM_CODE) REFERENCES TEAM_INFO(TEAM_CODE),
    CONSTRAINT CHK_ACTIVE_STATUS CHECK (ACTIVE_STATUS IN ('Y','N','H'))
) ENGINE=INNODB COMMENT='회원 정보 테이블';





# Q2.
# Q1에서 생성한 TEAM_INFO 테이블과 MEMBER_INFO 테이블에 아래와 같이 데이터를
# INSERT하는 쿼리를 작성하세요.
# 단, 삽입 대상 컬럼명은 반드시 명시해야 합니다.
# TEAM_INFO 테이블 삽입 후 조회 결과
    select * from TEAM_INFO;
# MEMBER_INFO 테이블 삽입 후 조회 결과
    select * FROM MEMBER_INFO;
# 답안1 (TEAM_INFO INSERT구문)
INSERT INTO TEAM_INFO VALUES
(null, '음악감상부','클래식 및 재즈 음악을 감상하는 사람들의 모임','Y')
,(null, '맛집탐방부','맛집을 찾아다니는 사람들의 모임','N'),
(null, '행복찾기부','','Y');

# 답안2 (MEMBER_INFO INSERT구문)
INSERT INTO MEMBER_INFO VALUES
(null,'송가인','1990-01-30',1,'안녕하세요 송가인입니다~','010-9494-9494',1,'H'),
(null,'임영웅','1992-05-03',null,'국민아들 임영웅입니다~','here@trot.com',1,null),
(null,'태진아',null,null,null,'(1급 기밀)',3,null);

# Q3.
# 단합을 위한 사내 체육대회를 위하여 팀을 꾸리는 중입니다. 기술지원부의 대리, 인사관리부
# 의 사원, 영업부(팀명에 ‘영업’이 포함되면 영업부로 봄)의 부장을 한 팀으로 묶으려고 합니
# 다. 이때, 이 팀의 팀원 수를 출력하세요.
# 단, UNION과 SUBQUERY를 활용하여 출력하세요.
SELECT COUNT(*) AS 팀원수
FROM (
    SELECT MEMBER_CODE
      FROM MEMBER_INFO m
      JOIN TEAM_INFO t ON m.TEAM_CODE = t.TEAM_CODE
     WHERE t.TEAM_NAME = '기술지원부' AND m.DIVISION_CODE = '대리'

    UNION

    SELECT MEMBER_CODE
      FROM MEMBER_INFO m
      JOIN TEAM_INFO t ON m.TEAM_CODE = t.TEAM_CODE
     WHERE t.TEAM_NAME = '인사관리부' AND m.DIVISION_CODE = '사원'

    UNION

    SELECT MEMBER_CODE
      FROM MEMBER_INFO m
      JOIN TEAM_INFO t ON m.TEAM_CODE = t.TEAM_CODE
     WHERE t.TEAM_NAME LIKE '%영업%' AND m.DIVISION_CODE = '부장'
) AS TEAM_UNION;
