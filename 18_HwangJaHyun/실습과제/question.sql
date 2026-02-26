/*
    DAY 3
*/

/*
Q1. 부서별 직원 급여의 총합 중 가장 큰 액수를 출력하세요.
*/
SELECT
    DEPT_CODE, AVG(SALARY)
FROM
    employee
GROUP BY
    DEPT_CODE
ORDER BY
    AVG(SALARY) DESC
LIMIT 0,1;

/*
    Q2. 서브쿼리를 이용하여 영업부인 직원들의 사원번호, 직원명, 부서코드, 급여를 출력하세요.
    참고. 영업부인 직원은 부서명에 ‘영업’이 포함된 직원임
 */
SELECT
    employee.EMP_ID,
    employee.EMP_NAME,
    employee.DEPT_CODE,
    employee.SALARY
FROM
    employee
WHERE employee.DEPT_CODE IN(
    (
        SELECT DEPT_ID
        FROM department
        WHERE DEPT_TITLE
        LIKE '%영업%'
    )
);


/*
    Q3. 서브쿼리와 JOIN을 이용하여 영업부인 직원들의 사원번호, 직원명, 부서명, 급여를 출력하세요.
*/
SELECT
    e.EMP_ID,
    e.EMP_NAME,
    d.DEPT_TITLE,
    e.SALARY
FROM
    employee E
JOIN
    department D ON (E.DEPT_CODE = D.DEPT_ID)
WHERE
    E.DEPT_CODE IN(
        (SELECT DEPT_ID
         FROM department
         WHERE DEPT_TITLE
         LIKE '%영업%'));

/*
    Q4.
        1. JOIN을 이용하여 부서의 부서코드, 부서명, 해당 부서가 위치한
            지역명, 국가명을 추출하는 쿼리를 작성하세요.
        2. 위 1에서 작성한 쿼리를 서브쿼리로 활용하여 모든 직원의
            사원번호, 직원명, 급여, 부서명, (부서의) 국가명을 출력하세요.
        단, 국가명 내림차순으로 출력되도록 하세요.
*/
SELECT
    D.DEPT_ID,
    D.DEPT_TITLE,
    L.LOCAL_NAME,
    N.NATIONAL_NAME
FROM department D
JOIN location L ON (D.LOCATION_ID = L.LOCAL_CODE)
JOIN national N ON (L.NATIONAL_CODE = N.NATIONAL_CODE);


SELECT
    E.EMP_ID,
    E.EMP_NAME,
    E.SALARY,
    DEPT.DEPT_TITLE,
    DEPT.NATIONAL_NAME
FROM
    employee E
JOIN (
        SELECT
            D.DEPT_ID,
            D.DEPT_TITLE,
            N.NATIONAL_NAME
        FROM department D
        JOIN location L ON (D.LOCATION_ID = L.LOCAL_CODE)
        JOIN national N ON (L.NATIONAL_CODE = N.NATIONAL_CODE)
        ) AS DEPT ON (E.DEPT_CODE = DEPT.DEPT_ID)
ORDER BY DEPT.NATIONAL_NAME;

/*
    Q5.
        러시아에서 발발한 전쟁으로 인해 정신적 피해를 입은 직원들에게 위로금을 전달하려고 합
        니다. 위로금은 각자의 급여에 해당 직원의 급여 등급에 해당하는 최소 금액을 더한 금액으로
        정했습니다.
        Q4에서 작성한 쿼리를 활용하여 해당 부서의 국가가 ‘러시아’인 직원들을 대상으로, 직원의
        사원번호, 직원명, 급여, 부서명, 국가명, 위로금을 출력하세요.
        단, 위로금 내림차순으로 출력되도록 하세요.
*/

SELECT
    E.EMP_ID,
    E.EMP_NAME,
    E.SALARY,
    DEPT.DEPT_TITLE,
    DEPT.NATIONAL_NAME,
    (SAL.MIN_SAL + E.SALARY) AS '위로금'
FROM
    employee E
JOIN (
        SELECT
            D.DEPT_ID,
            D.DEPT_TITLE,
            N.NATIONAL_NAME
        FROM department D
        JOIN location L ON (D.LOCATION_ID = L.LOCAL_CODE)
        JOIN national N ON (L.NATIONAL_CODE = N.NATIONAL_CODE)
        WHERE N.NATIONAL_NAME = '러시아'
        ) AS DEPT ON (E.DEPT_CODE = DEPT.DEPT_ID)
JOIN
    (
        SELECT
            S.SAL_LEVEL,
            S.MIN_SAL
        FROM
            sal_grade S
    ) AS SAl ON (E.SAL_LEVEL = SAL.SAL_LEVEL)
ORDER BY 위로금 DESC;

/*
    DAY 4
*/
-- 다음 논리ERD와 물리ERD를 참고하여, 아래 조건을 만족하는 테이블을 생성하는 DDL 구문을 작성하세요.
/*
    Q1에서 생성한 TEAM_INFO 테이블과 MEMBER_INFO 테이블에 아래와 같이 데이터를
    INSERT하는 쿼리를 작성하세요.
    단, 삽입 대상 컬럼명은 반드시 명시해야 합니다.
*/
DROP TABLE IF EXISTS team_info;
DROP TABLE IF EXISTS member_info;


CREATE TABLE IF NOT EXISTS team_info(
    team_code INT AUTO_INCREMENT COMMENT '소속코드',
    team_name VARCHAR(100) NOT NULL COMMENT '소속명',
    team_detail VARCHAR(500) COMMENT '소속상세여부',
    use_yn CHAR(2) DEFAULT 'Y' NOT NULL COMMENT '사용여부',
    PRIMARY KEY (team_code),
    CHECK(use_yn IN('Y', 'N'))
) ENGINE = INNODB COMMENT '소속정보';
-- INNODB :

CREATE TABLE IF NOT EXISTS member_info(
    member_code INT AUTO_INCREMENT COMMENT '회원정보',
    member_name VARCHAR(70) NOT NULL COMMENT '회원이름',
    birth_date DATE COMMENT '생년월일',
    division_code CHAR(2) COMMENT '구분코드',
    detail_info VARCHAR(500) COMMENT '상세정보',
    contact VARCHAR(50) NOT NULL COMMENT '연락처',
    team_code INT NOT NULL COMMENT '소속코드',
    active_status CHAR(2) DEFAULT 'Y' NOT NULL COMMENT '활동상태',
    PRIMARY KEY (member_code),
    FOREIGN KEY (team_code)
            REFERENCES team_info(team_code),
    CHECK (active_status IN ('Y', 'N', 'H'))
) ENGINE = INNODB COMMENT '회원정보';


/*
Q1에서 생성한 TEAM_INFO 테이블과 MEMBER_INFO 테이블에 아래와 같이 데이터를
INSERT하는 쿼리를 작성하세요.
단, 삽입 대상 컬럼명은 반드시 명시해야 합니다.
*/

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
단합을 위한 사내 체육대회를 위하여 팀을 꾸리는 중입니다. 기술지원부의 대리, 인사관리부
의 사원, 영업부(팀명에 ‘영업’이 포함되면 영업부로 봄)의 부장을 한 팀으로 묶으려고 합니
다. 이때, 이 팀의 팀원 수를 출력하세요.
단, UNION과 SUBQUERY를 활용하여 출력하세요.
*/
SELECT COUNT(*)
FROM (
    SELECT
        EMP_ID
    FROM
        employee E
    JOIN
        department D ON(E.DEPT_CODE = D.DEPT_ID)
    JOIN
        job J ON (E.JOB_CODE = J.JOB_CODE)
    WHERE
        D.DEPT_TITLE = '기술지원부'
    AND
        J.JOB_NAME = '대리'
    UNION
    SELECT
        EMP_ID
    FROM
        employee E
    JOIN
        department D ON(E.DEPT_CODE = D.DEPT_ID)
    JOIN
        job J ON (E.JOB_CODE = J.JOB_CODE)
    WHERE
        D.DEPT_TITLE = '인사관리부'
    AND
        J.JOB_NAME = '사원'
    UNION
    SELECT
        EMP_ID
    FROM
        employee E
    JOIN
        department D ON(E.DEPT_CODE = D.DEPT_ID)
    JOIN
        job J ON (E.JOB_CODE = J.JOB_CODE)
    WHERE
        D.DEPT_TITLE LIKE '%영업%'
    AND
        J.JOB_NAME = '부장'
 ) AS A;


/*
(
        SELECT
            D.DEPT_ID,
            D.DEPT_TITLE,
            N.NATIONAL_NAME
        FROM department D
        JOIN location L ON (D.LOCATION_ID = L.LOCAL_CODE)
        JOIN national N ON (L.NATIONAL_CODE = N.NATIONAL_CODE)
        ) AS DEPT ON (E.DEPT_CODE = DEPT.DEPT_ID)
ORDER BY DEPT.NATIONAL_NAME;
*/

/*
    DAY 5
*/
/*
전화번호가 010으로 시작하는 직원의 직원명과 전화번호를 다음과 같이 출력하세요.
출력한 결과집합 헤더의 명칭은 각각 ‘EMP_NAME’, ‘PHONE’이어야 함
전화번호는 ‘010-0000-0000’ 형식으로 출력해야 함
*/
SELECT
    e.EMP_NAME,
    CONCAT_WS(
            '-',
            SUBSTRING(e.PHONE,1,3),
            SUBSTRING(e.PHONE,4,4),
            SUBSTRING(e.PHONE,8,4)
    ) AS PHONE
FROM
    employee e
WHERE
    e.PHONE LIKE '010%';
-- SUBSTRING(phone,1,3) = '010';

/*
근속 일수가 20년 이상인 직원의 직원명, 입사일, 급여를 다음과 같이 출력하세요.
단, 입사한 순서대로 출력하고 입사일이 같으면 급여가 높은 순서로 출력되도록 하세요.
출력한 결과집합 헤더의 명칭은 각각 ‘직원명’, ‘입사일’, ‘급여’여야 함
입사일은 ‘0000년 00월 00일’ 형식으로 출력해야 함
급여는 천 단위로 , 를 찍어 출력해야 함
HINT 1 CONCAT
HINT 2 FORMAT
HINT 3 DATE 관련 함수
HING 4 YEAR, MONTH, DAY
*/
SELECT
    e.emp_name AS 직원명,
    CONCAT(
            YEAR(e.HIRE_DATE),'년 ',
            MONTH(e.HIRE_DATE),'월 ',
            DAY(e.HIRE_DATE),'일'
    ) AS 입사일,
    FORMAT(e.SALARY, 0) AS '급여'
FROM
    employee e
WHERE
    e.HIRE_DATE <= SUBDATE(CURDATE(), INTERVAL 20 YEAR)
ORDER BY
    e.HIRE_DATE ASC,
    e.SALARY DESC;

/*
    DATEDIFF
    -> 결과 일 수로 반환
    윤년이 있어서 권장 X

    ADDDATE, SUBDATE
    -> 알아서 윤년까지 계산해줌!
*/
SELECT SUBDATE(CURDATE(), INTERVAL 20 YEAR);
SELECT '1990-01-06' <= SUBDATE(CURDATE(), INTERVAL 20 YEAR);


/*
모든 직원의 직원명, 급여, 보너스, 급여에 보너스를 더한 금액을 다음과 같이 출력하세요.
단, 급여에 보너스를 더한 금액이 높은 순으로 출력되도록 하세요.
출력한 결과집합 헤더의 명칭은 각각 ‘EMP_NAME’, ‘SALARY’, ‘BONUS’,
‘TOTAL_SALARY’여야 함
보너스를 더한 급여는 소수점이 발생할 경우 반올림 처리함
급여와 보너스를 더한 급여는 천 단위로 , 를 찍어 출력해야 함
보너스는 백분율로 출력해야 함

HINT 1
급여에 보너스를 더한 금액을 구하고자 할 때, 보너스가 0이라면 원하는 값이 나오지 않
을 겁니다. 수업 시간에 다루지 않았지만 NULL 값을 다른 값으로 대체하는 내장함수가
있습니다. 해당 함수를 찾아서 사용해 보세요🙂
HINT 2 - FORMAT
HINT 3 - CONCAT
HINT 4 - TRUNCATE
HINT 5 - ROUND
*/
SELECT
    e.EMP_NAME,
    FORMAT(e.SALARY,0) AS SALARY,
    CONCAT(CAST(e.BONUS * 100 AS SIGNED INTEGER),'%') AS BONUS,
    FORMAT(e.SALARY * (1 + nvl(e.BONUS,1)),0) AS TOTAL_SALARY
FROM
    employee e
ORDER BY e.SALARY * (1 + nvl(e.BONUS,1)) DESC;




/*
직원의 직원명과 이메일을 다음과 같이 출력하세요.
출력한 결과집합 헤더의 명칭은 각각 ‘EMP_NAME’, ‘EMAIL’이어야 함
이메일의 도메인 주소인 greedy.com 은 모두 동일하므로, 해당 문자열이 맞춰질 수 있
도록 이메일의 앞에 공백을 두고 출력해야 함
HINT 1 - LPAD
HINT 2 - MAX
HINT 3 - 서브쿼리
*/
SELECT
    E.EMP_NAME,
    LPAD(E.EMAIL,(SELECT CHAR_LENGTH(MAX(EMAIL)) FROM employee), ' ') AS 'EMAIL'
FROM
    employee E;
/*
+@ (심화)
이메일의 도메인 주소가 모두 다르다고 가정할 때, @의 위치를 한 줄로 맞추고 싶은 경
우에는 어떻게 수정할 수 있을까?
답안
 */
SELECT
    E.EMP_NAME,
    CONCAT_WS('@',
            LPAD(SUBSTRING_INDEX(E.EMAIL, '@', 1),
                 (SELECT MAX(
                        CHAR_LENGTH(
                            SUBSTRING_INDEX(S.EMAIL, '@', 1)
                        )
                 ) FROM employee S), ' '
            ),SUBSTRING_INDEX(E.EMAIL, '@', -1)
    ) AS 'EMAIL'
FROM
    employee E;

SELECT
    E.EMP_NAME,
    CONCAT_WS('@',
            LPAD(SUBSTRING_INDEX(E.EMAIL, '@', 1),
                 (SELECT MAX(INSTR(S.EMAIL,'@') - 1 ) FROM employee S), ' '
            ),SUBSTRING_INDEX(E.EMAIL, '@', -1)
    ) AS 'EMAIL'
FROM
    employee E;
/*
Q5.

사내 행사 준비를 위해 직원 목록을 출력하려고 합니다. 직원 목록을 다음과 같이 출력하세
요.
단, 관리자의 이름순으로 정렬하여 출력되도록 하세요.
직원명, 직급명, 주민등록번호, 부서가 있는 국가, 부서명, 해당 직원의 관리자 직원명을
출력해야 함

DAY5: Question 6
출력한 결과집합 헤더의 명칭은 각각 ‘NAME_TAG’, ‘EMP_NO’, ‘BELONG’,
‘MANAGER_NAME’이어야 하며 출력 형식은 각각 아래와 같아야 함
NAME_TAG : (직원명) (직급명)님
EMP_NO : (생년월일6자리)-(뒷자리 한 자리를 제외하고는 *로 표시)
BELONG : (부서의 국가)지사 (부서명) 소속
HINT 1 - JOIN
HINT 2 - CONCAT
HINT 3 - RPAD
HINT 4 - SUBSTRING
 */
/*
 1. 스칼라 서브쿼리
*/
SELECT
    CONCAT(E.EMP_NAME,' ',J.JOB_NAME,'님') AS NAME_TAG,
    RPAD(SUBSTRING(E.EMP_NO,1,7),13,'*') AS EMP_NO,
    CONCAT(N.NATIONAL_NAME,'지사 ',D.DEPT_TITLE,' 소속') AS BELONG,
    (SELECT S.EMP_NAME
     FROM employee S
     WHERE S.EMP_ID = E.MANAGER_ID
    ) AS MANAGER_NAME
FROM
    employee E
JOIN job J ON(E.JOB_CODE = J.JOB_CODE)
JOIN department D ON(E.DEPT_CODE = D.DEPT_ID)
JOIN location L ON(D.LOCATION_ID = L.LOCAL_CODE)
JOIN national N ON(L.NATIONAL_CODE = N.NATIONAL_CODE);

/*
    2. inner join
*/
SELECT * FROM employee E
INNER JOIN employee S ON (S.EMP_ID = E.MANAGER_ID);


SELECT
    CONCAT(E.EMP_NAME,' ',J.JOB_NAME,'님') AS NAME_TAG,
    RPAD(SUBSTRING(E.EMP_NO,1,7),13,'*') AS EMP_NO,
    CONCAT(N.NATIONAL_NAME,'지사 ',D.DEPT_TITLE,' 소속') AS BELONG,
    S.EMP_NAME
FROM
    employee E
JOIN job J ON(E.JOB_CODE = J.JOB_CODE)
JOIN department D ON(E.DEPT_CODE = D.DEPT_ID)
JOIN location L ON(D.LOCATION_ID = L.LOCAL_CODE)
JOIN national N ON(L.NATIONAL_CODE = N.NATIONAL_CODE)
INNER JOIN employee S ON (S.EMP_ID = E.MANAGER_ID);

