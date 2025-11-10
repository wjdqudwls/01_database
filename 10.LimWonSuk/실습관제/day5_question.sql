    SELECT * FROM employee;
    SELECT * FROM department;
    SELECT * FROM job;
    SELECT * FROM location;
    SELECT * FROM sal_grade;
    SELECT * FROM national;

# 1.

SELECT
    emp_name,phone,
    CONCAT_WS(
            '-',
               SUBSTRING(phone,1,3),
              SUBSTRING(phone,4,4),
     SUBSTRING(phone,8,4)

    ) AS PHONE
FROM
    employee
WHERE
    SUBSTRING(phone,1,3) = '010';


# phone Like '010%';

#     -- 근속 일수가 20년 이상인 직원의 직원명, 입사일, 급여를 다음과 같이 출력하세요.
# -- 단, 입사한 순서대로 출력하고 입사일이 같으면 급여가 높은 순서로 출력되도록 하세요.
# --   출력한 결과집합 헤더의 명칭은 각각 '직원명', '입사일', '급여'여야 함
# --   입사일은 '0000년 00월 00일' 형식으로 출력해야 함
# --   급여는 천 단위로, 를 찍어 출력해야 함
# --  HINT 1: CONCAT
# --  HINT 2: FORMAT
# --  HINT 3: DATE 관련 함수
# --  HING 4: YEAR, MONTH, DAY


SELECT
    emp_name AS '직원명',
    CONCAT( YEAR(hire_date), '년',
            MONTH(hire_date), '월',
            DAY(hire_date), '일') AS '입사일',
    FORMAT(salary,0) AS '급여'
FROM
    employee
WHERE
    hire_date <= SUBDATE(CURDATE(), INTERVAL 20 YEAR)
ORDER BY
    hire_date ASC, salary DESC;

/*SELECT
    EMP_NAME AS '직원명',
    HIRE_DATE AS '급여',
    CONCAT(YEAR(HIRE_DATE'년',
                MONTH(HIRE_DATE)'월',
                DAY(HIRE_DATE)'일'),
    FORMAT(SALARY,0) AS '급여'
FROM
    employee
WHERE
    HIRE_DATE
        ORDER BY
        employee.HIRE_DATE*/


-- 1990-02-06
SELECT '1990-02-06' <= SUBDATE(CURDATE(), INTERVAL 20 YEAR );

SELECT CURDATE();
SUBDATE
ADDDATE
