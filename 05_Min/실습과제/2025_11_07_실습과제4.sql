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