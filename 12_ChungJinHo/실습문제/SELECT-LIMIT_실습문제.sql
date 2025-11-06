-- 1. 모든 사원의 모든 컬럼 조회
select *
  from employee;


-- 2. 사원들의 사번(사원번호), 이름 조회
select EMP_ID `사번`
      ,EMP_NAME `이름`
  from employee;


-- 3. 201번 사번의 사번 및 이름 조회
select EMP_ID `사번`
      ,EMP_NAME `이름`
  from employee
 where EMP_ID = '201';


-- 4. 부서 코드가 'D9'인 사원의 이름과 부서코드 조회
select EMP_NAME `이름`
      ,DEPT_CODE `부서코드`
  from employee
 where DEPT_CODE = 'D9';


-- 5. 직급 코드가 'J1'인 사원 조회
select *
  from employee
 where JOB_CODE = 'J1';


-- 6. 급여가 300만원 이상(>=)인 사원의 사번, 이름, 급여를 조회
select EMP_ID `사번`
      ,EMP_NAME `이름`
      ,SALARY `급여`
  from employee
 where SALARY >= '3000000';


-- 7. 부서코드가 'D6'이고 급여를 300만원보다 많이 받는 사원의 이름, 급여 조회
select EMP_NAME `이름`
      ,SALARY `급여`
  from employee
 where DEPT_CODE = 'D6'
   and SALARY > '3000000';


-- 8. 보너스를 받지 않는 사원의 사번, 이름, 급여, 보너스 조회
select EMP_ID `사번`
      ,EMP_NAME `이름`
      ,SALARY `급여`
      ,BONUS `보너스`
  from employee
 where BONUS is null;


-- 9. 'D9' 부서에서 근무하지 않는 사원의 사번, 이름 조회
select EMP_ID `사번`
      ,EMP_NAME `이름`
  from employee
 where DEPT_CODE <> 'D9';


-- 10. 퇴사 여부가 N인 직원의 사번, 이름, 입사일 조회 (별칭 사용)
select EMP_ID `사번`
      ,EMP_NAME `이름`
      ,HIRE_DATE `입사일`
  from employee
 where ENT_YN = 'N';


-- 11. 급여가 350만원 이상 550만원 이하를 받는 직원의 사번, 이름, 급여 조회
select EMP_ID `사번`
      ,EMP_NAME `이름`
      ,SALARY `급여`
  from employee
 where SALARY between '3500000' and '5500000';

-- 12. '성이 김씨'인 직원의 사번, 이름, 입사일 조회
select EMP_ID `사번`
      ,EMP_NAME `이름`
      ,HIRE_DATE `입사일`
  from employee
 where EMP_NAME like '김%';


-- 13. '성이 김씨'가 아닌 직원의 사번, 이름, 입사일 조회
select EMP_ID `사번`
      ,EMP_NAME `이름`
      ,HIRE_DATE `입사일`
  from employee
 where EMP_NAME not like '김%';


-- 14. 이름에 '하' 문자가 포함된 직원의 이름, 주민번호, 부서코드 조회
select EMP_NAME `이름`
      ,EMP_NO `주민번호`
      ,DEPT_CODE `부서코드`
  from employee
 where EMP_NAME like '%하%';


-- 15. 'J2'직급이거나 'J7'직급인 직원들 중 급여가 200만원 이상인 직원의 이름, 급여 조회
select EMP_NAME `이름`
      ,SALARY `급여`
  from employee
 where JOB_CODE in ('J2','J7')
   and SALARY >= '2000000';


-- 16. 급여가 높은 순서대로 사원의 이름, 급여 조회 (상위 5명만)
select EMP_NAME `이름`
      ,SALARY `급여`
  from employee
 order
    by SALARY desc
 limit 5;


-- 17. 중복된 급여 범위를 제거하고 급여 조회
select distinct SALARY
  from          employee;


-- 18. 사원들의 이름을 사전 순서대로 정렬하고 상위 10명 조회
select *
  from employee
 order
    by EMP_NAME
 limit 10;

