-- 1. 모든 사원의 모든 컬럼 조회
SELECT
    *
FROM
    employee;

-- 2. 사원들의 사번
SELECT
    EMP_NO
FROM
    employee;



-- 3. 201번 사번의 사번 및 이름 조회
SELECT
    EMP_NO,
    EMP_NAME
FROM
    employee
WHERE
    emp_id = 201;
 --    EMP_NO = '201';


-- 4. 부서 코드가 'D9'인 사원의 이름과 부서코드 조회
SELECT
    EMP_NAME,
    DEPT_CODE
FROM
    employee
WHERE
DEPT_CODE = 'D9';
 --   DEPT_CODE = D9;
    --    DEPT_CODE IN (D9);

-- 5. 직급 코드가 'J1'인 사원 조회
SELECT
    EMP_NAME,
    DEPT_CODE
FROM
    employee
WHERE
DEPT_CODE = 'J1';
-- 왜 공백이냐

-- 6. 급여가 300만원 이상(>=)인 사원의 사번, 이름, 급여를 조회
SELECT
    employee.DEPT_CODE,
    employee.EMP_NAME,
    SALARY
FROM
    employee
WHERE
  SAL_LEVEL
 --   SALARY = 3000000;
 --   SAL_GRADE >= 3000000;
 --   SAL_LEVEL = S4;
--

-- 7. 부서코드가 'D6'이고 급여를 300만원보다 많이 받는 사원의 이름, 급여 조회


-- 8. 보너스를 받지 않는 사원의 사번, 이름, 급여, 보너스 조회



-- 9. 'D9' 부서에서 근무하지 않는 사원의 사번, 이름 조회


-- 10. 퇴사 여부가 N인 직원의 사번, 이름, 입사일 조회 (별칭 사용)


-- 11. 급여가 350만원 이상 550만원 이하를 받는 직원의 사번, 이름, 급여 조회


-- 12. '성이 김씨'인 직원의 사번, 이름, 입사일 조회


-- 13. '성이 김씨'가 아닌 직원의 사번, 이름, 입사일 조회


-- 14. 이름에 '하' 문자가 포함된 직원의 이름, 주민번호, 부서코드 조회


-- 15. 'J2'직급이거나 'J7'직급인 직원들 중 급여가 200만원 이상인 직원의 이름, 급여 조회


-- 16. 급여가 높은 순서대로 사원의 이름, 급여 조회 (상위 5명만)


-- 17. 중복된 급여 범위를 제거하고 급여 조회


-- 18. 사원들의 이름을 사전 순서대로 정렬하고 상위 10명 조회

