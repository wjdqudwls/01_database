
-- Q1.
SELECT
    EMP_NAME,
    CONCAT_WS('-', SUBSTRING(phone,1,3), SUBSTRING(phone,4,4), SUBSTRING(phone,8,4)) AS PHONE
FROM
    employee
WHERE
    SUBSTRING(phone,1,3) = '010';


-- Q2.
SELECT
    EMP_NAME AS '직원명',
    HIRE_DATE '입사일',
    CONCAT(YEAR(HIRE_DATE),'년',
           MONTH(HIRE_DATE),'월',
           DAY(HIRE_DATE), '일'),
    FORMAT(SALARY, 0) AS '급여'
FROM
    employee
WHERE
    HIRE_DATE <= SUBDATE(CURDATE(), INTERVAL 20 YEAR)
ORDER BY
    HIRE_DATE ASC, SALARY DESC;

SELECT '1990-02-06' <= SUBDATE(CURDATE(), INTERVAL 20 YEAR);


/* Q3. 모든 직원의 직원명, 급여, 보너스, 급여에 보너스를 더한 금액을 다음과 같이 출력하세요.
단, 급여에 보너스를 더한 금액이 높은 순으로 출력되도록 하세요.
출력한 결과집합 헤더의 명칭은 각각 ‘EMP_NAME’, ‘SALARY’, ‘BONUS’,
‘TOTAL_SALARY’여야 함
보너스를 더한 급여는 소수점이 발생할 경우 반올림 처리함
급여와 보너스를 더한 급여는 천 단위로 , 를 찍어 출력해야 함
보너스는 백분율로 출력해야 함 */

SELECT
    E.EMP_NAME AS EMP_NAME,
    FORMAT(E.SALARY,0) AS SALARY,
    CONCAT(TRUNCATE(IFNULL(E.BONUS, 0) * 100, 0), '%') AS BONUS,
    FORMAT(ROUND(E.SALARY + (E.SALARY * IFNULL(E.BONUS, 1))), 0) AS TOTAL_SALARY
FROM
    employee E
ORDER BY
    (E.SALARY + (E.SALARY * IFNULL(E.BONUS, 1))) DESC;



/* Q4. */
SELECT
    E.EMP_NAME,
    LPAD(
        E.EMAIL,
        (
            SELECT MAX(LENGTH(E1.EMAIL) - LENGTH('@greedy.com'))
            FROM employee E1
        ) + LENGTH('@greedy.com'),
        ' '
    ) AS EMAIL
FROM
    employee E;


-- Q5
SELECT
    *
FROM
    employee;

SELECT
    CONCAT(E.EMP_NAME, ' ', J.JOB_NAME , '님') AS NAME_TAG,
    CONCAT(
        SUBSTRING(E.EMP_NO, 1, 8),
        RPAD('', LENGTH(E.EMP_NO) - 8, '*')
    ) AS EMP_NO,
    CONCAT(N.NATIONAL_NAME, ' ', D.DEPT_TITLE) AS BELONG,
    E1.EMP_NAME AS MANGER_NAME
FROM
    employee E
JOIN
    JOB J ON(E.JOB_CODE = J.JOB_CODE)
JOIN
    department D ON (E.DEPT_CODE = D.DEPT_ID)
JOIN
    location L ON (D.LOCATION_ID = L.LOCAL_CODE)
JOIN
    national N ON (N.NATIONAL_CODE = L.NATIONAL_CODE)
LEFT JOIN
    employee E1 ON (E.MANAGER_ID = E1.EMP_ID)
ORDER BY
    E1.EMP_NAME ASC;





