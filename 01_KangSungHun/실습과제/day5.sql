-- Q1. 전화 번호가 010으로 시작하는

SELECT EMP_NAME,
       CONCAT_WS(
               '-',
               SUBSTRING(phone, 1, 3),
               SUBSTRING(phone, 4, 4),
               SUBSTRING(phone, 8, 4)
       ) AS PHONE
FROM EMPLOYEE
WHERE SUBSTRING(phone, 1, 3) = '010';

/*
-- Q2. 근속 일수가 20년 이상인 직원의 직원명, 입사일, 급여를 다음과 같이 출력하세요.
-- 단, 입사한 순서대로 출력하고 입사일이 같으면 급여가 높은 순서로 출력되도록 하세요.

   출력한 결과집합 헤더의 명칭은 각각 '직원명', 입사일, '급여'여야 함
   입사일은 '0000년 00월 00일' 형식으로 출력해야 함
   급여는 천 단위로 ,를 찍어 출력해야 함
   Hint. CONCAT, FROMAT, DATE 관련 함수, YEAR, MONTH< DAY

*/

SELECT emp_name                    AS '직원명',
       CONCAT(YEAR(hire_date), '년',
              MONTH(hire_date), '월',
              DAY(hire_date), '일') AS '입사일',
       FORMAT(salary, 0)           AS '급여'
FROM employee
WHERE hire_date <= SUBDATE(CURDATE(), INTERVAL 20 YEAR)
ORDER BY hire_date ASC, salary DESC;

/* Q3
   모든 직원의 직업명, 급여, 보너스, 급여에 보너스를 더한 금액을 다음과 같이 출력하세요.
   단, 급여에 보너스를 더한 금액이 높은 순으로 출력되도록 하세요.

   1. 출력한 결과집합 헤더의 명칭은 각각 'EMP_NAME','SALARY','BONUS','TOTAL_SALARY'여야 함
   2. 보너스를 더한 급여는 소수점이 발생할 경우 반올림 처리함
   3. 급여와 보너스를 더한 급여는 천 단위로 , 를 찍어 출력해야 함
   4. 보너스는 백분율로 출력해야 함
   Hint.
급여에 보너스를 더한 금액을 구하고자 할 때, 보너스가 0이라면 원하는 값이 나오지 않
을 겁니다. 수업 시간에 다루지 않았지만 NULL 값을 다른 값으로 대체하는 내장함수가
있습니다. 해당 함수를 찾아서 사용해 보세요

   FORMAT, CONCAT, TRUNCATE, ROUND
 */
SELECT E.EMP_NAME                                              AS 'EMP_NAME',
       FORMAT(E.SALARY, 0)                                     AS 'SALARY',
       CASE
           WHEN E.BONUS IS NULL THEN NULL -- 표시: NULL은 그대로
           ELSE CONCAT(ROUND(E.BONUS * 100, 0), '%') -- 0.30 → 30%
           END                                                 AS 'BONUS',
       FORMAT(ROUND(E.SALARY * (1 + COALESCE(E.BONUS, 1))), 0) AS 'TOTAL_SALARY'
-- 계산: NULL이면 1(=100%)로 대체 → 급여×(1+1)=급여×2
FROM EMPLOYEE E
ORDER BY (E.SALARY * (1 + COALESCE(E.BONUS, 1))) DESC;

/* Q4.
   직원의 직원명과 이메일을 다음과 같이 출력하세요.

   출력한 결과집합 헤더의 명칭은 각각 'EMP_NAME','EMAIL'이어야 함
   이메일의 도메인 주소인 greedy.com 은 모두 동일하므로, 해당 문자열이 맞춰질 수 있도록 이메일의 앞에 공백을 두고 출력해야 함

   힌트. LPAD, MAX, 서브쿼리, +@
 */

SELECT EMP_NAME AS 'EMP_NAME',
       CONCAT(
       LPAD(
       SUBSTRING_INDEX(EMAIL, '@', 1), -- '@' 앞부분만 추출
       (SELECT MAX(LENGTH(SUBSTRING_INDEX(EMAIL, '@', 1))) FROM EMPLOYEE), -- 가장 긴 아이디 길이
        ' ' -- 남는 칸은 공백으로 채우기
               ),
               ' @greedy.com' -- 도메인 붙이기
       )        AS 'EMAIL'
FROM EMPLOYEE;