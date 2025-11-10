/*DROP TABLE IF EXISTS member_info;
DROP TABLE IF EXISTS team_info;

CREATE TABLE IF NOT EXISTS team_info(
    team_code INT AUTO_INCREMENT    COMMENT '소속코드',
    team_name VARCHAR(100) NOT NULL COMMENT '소속명',
    team_detail VARCHAR(500)        COMMENT '소속상세정보',
    use_yn char(2) NOT NULL DEFAULT 'Y' COMMENT '사용여부',
    PRIMARY KEY (team_code),
    check (use_yn IN ('Y', 'N') )
) ENGINE = INNODB COMMENT '소속정보';

CREATE TABLE IF NOT EXISTS member_info(
    member_code INT AUTO_INCREMENT      COMMENT '회원코드',
    member_name varchar(70)     NOT NULL    COMMENT '회원이름',
    birth_date  date                    COMMENT '생년월일',
    division_code CHAR(2)               COMMENT '구분코드',
    detail_info VARCHAR(500)    NOT NULL   COMMENT '상세정보',
    contact VARCHAR(50)         NOT NULL COMMENT '소속코드',
    active_status CHAR(2)       NOT NULL DEFAULT 'Y' COMMENT '활동상태',

    Primary Key (member_code),
    FOREIGN KEY (team_code)
        REFERENCES team_info(team_code),
    CHECK ( active_status IN ('Y', 'N', 'H') )
) ENGINE INNODB COMMENT '소속정보';
*/

--

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

/*
Q3.
단합을 위한 사내 체육대회를 위하여 팀을 꾸리는 중입니다. 기술지원부의 대리, 인사관리부
의 사원, 영업부(팀명에 ‘영업’이 포함되면 영업부로 봄)의 부장을 한 팀으로 묶으려고 합니
다. 이때, 이 팀의 팀원 수를 출력하세요.
단, UNION과 SUBQUERY를 활용하여 출력하세요
*/
select * from EMPLOYEE;
select * from DEPARTMENT;
select * from JOB;
select * from LOCATION;
select * from NATIONAL;
select * from SAL_GRADE;


SELECT
    COUNT(EMP_ID)
FROM
(
SELECT E1.EMP_ID
FROM EMPLOYEE E1
         JOIN DEPARTMENT D1 ON (E1.DEPT_CODE = D1.DEPT_ID)
         JOIN JOB J1 ON (E1.JOB_CODE = J1.JOB_CODE)
WHERE D1.DEPT_TITLE = '기술지원부'
  AND J1.JOB_NAME = '대리'

UNION

SELECT E1.EMP_ID
FROM EMPLOYEE E1
         JOIN DEPARTMENT D1 ON (E1.DEPT_CODE = D1.DEPT_ID)
         JOIN JOB J1 ON (E1.JOB_CODE = J1.JOB_CODE)
WHERE D1.DEPT_TITLE = '인사관리부'
  AND J1.JOB_NAME = '사원'

UNION

SELECT E1.EMP_ID
FROM EMPLOYEE E1
         JOIN DEPARTMENT D1 ON (E1.DEPT_CODE = D1.DEPT_ID)
         JOIN JOB J1 ON (E1.JOB_CODE = J1.JOB_CODE)
WHERE D1.DEPT_TITLE LIKE '%영업%'
  AND J1.JOB_NAME = '부장' ) as SUB;
