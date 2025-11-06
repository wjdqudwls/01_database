/*
    연봉 계산법 : 월급 * (1 + 보너스) * 12 로 수행하시면 됩니다.
    참고로 보너스 컬럼 값이 null인 경우 연산 결과도 null이 나옵니다.
    null 처리 함수 → 내장 함수 챕터에서 학습할 예정이지만 적용해보려면
    IFNULL(보너스, 0) 또는 NVL(보너스, 0) 과 같이 적용하면 null 인 경우 0 으로 취급되어 보너스 없이 계산이 수행 됩니다.
*/

-- 1. 이름에 '형'자가 들어가는 직원들의 사번, 사원명, 부서명을 조회하시오.(1행)
select e.EMP_ID `사번`
      ,e.EMP_NAME `사원명`
      ,d.DEPT_TITLE `부서명`
  from employee e
  left join department d
    on e.DEPT_CODE = d.DEPT_ID
 where e.EMP_NAME like '%형%';


-- 2. 해외영업팀에 근무하는 사원명, 직급명, 부서코드, 부서명을 조회하시오.(9행)
select e.EMP_NAME `사원명`
      ,j.JOB_NAME `직급명`
      ,d.DEPT_ID `부서코드`
      ,d.DEPT_TITLE `부서명`
  from employee e
  join department d
    on e.DEPT_CODE = d.DEPT_ID
  join job j
    on e.JOB_CODE = j.JOB_CODE
 where e.DEPT_CODE in ('D5','D6')
 order by e.EMP_NAME;


-- 3. 보너스포인트를 받는 직원들의 사원명, 보너스포인트, 부서명, 근무지역명을 조회하시오.(8행)
-- (INNER JOIN 결과)
select e.EMP_NAME `사원명`
      ,e.BONUS `보너스포인트`
      ,d.DEPT_TITLE `부서명`
      ,CONCAT(l.LOCAL_NAME,'-',l.NATIONAL_CODE) `근무지역명`
  from employee e
  join department d
    on e.DEPT_CODE = d.DEPT_ID
  join location l
    on d.LOCATION_ID = l.LOCAL_CODE
 where e.BONUS is not null
 order by e.EMP_NAME;


-- 4. 부서코드가 D2인 직원들의 사원명, 직급명, 부서명, 근무지역명을 조회하시오.(3행)
select e.EMP_NAME `사원명`
      ,j.JOB_NAME `직급`
      ,d.DEPT_TITLE `부서명`
      ,l.LOCAL_NAME `근무지역명`
  from employee e
  join job j
    on e.JOB_CODE = j.JOB_CODE
  join department d
    on e.DEPT_CODE = d.DEPT_ID
  join location l
    on d.LOCATION_ID = l.LOCAL_CODE
 where e.DEPT_CODE = 'D2'
 order by e.EMP_NAME;


-- 5. 급여 테이블의 등급별 최소급여(MIN_SAL)보다 많이 받는 직원들의
-- 사원명, 직급명, 급여, 연봉을 조회하시오.
-- 연봉에 보너스포인트를 적용하시오.(20행)
select e.EMP_NAME `사원명`
      ,j.JOB_NAME `직급`
      ,e.SALARY `급여`
      ,(e.SALARY * ( 1 + ifnull(e.BONUS,0) ) * 12) `연봉`
  from employee e
  join job j
    on e.JOB_CODE = j.JOB_CODE
  join sal_grade s
    on e.SAL_LEVEL = s.SAL_LEVEL
 where e.SALARY > s.MIN_SAL
 order by e.EMP_NAME;


-- 6. 한국(KO)과 일본(JP)에 근무하는 직원들의
-- 사원명, 부서명, 지역명, 국가명을 조회하시오.(15행)
select e.EMP_NAME `사원명`
      ,d.DEPT_TITLE `부서명`
      ,l.LOCAL_NAME `지역명`
      ,n.NATIONAL_NAME `국가명`
  from employee e
  join department d
    on e.DEPT_CODE = d.DEPT_ID
  join location l
    on d.LOCATION_ID = l.LOCAL_CODE
  join national n
    on l.NATIONAL_CODE = n.NATIONAL_CODE
 where l.NATIONAL_CODE in ('KO','JP')
 order by e.EMP_NAME;


-- 7. 보너스포인트가 없는 직원들 중에서 직급코드가 J4와 J7인 직원들의 사원명, 직급명, 급여를 조회하시오.
-- 단, join과 IN 사용할 것(8행)
select e.EMP_NAME `사원명`
      ,j.JOB_NAME `직급`
      ,e.SALARY `급여`
  from employee e
  join job j
    on e.JOB_CODE = j.JOB_CODE
 where e.BONUS is null
   and e.JOB_CODE in ('J4','J7')
 order by e.EMP_NAME;

-- 8. 직급이 대리이면서 아시아 지역(ASIA1, ASIA2, ASIA3 모두 해당)에 근무하는 직원 조회(2행)
-- 사번(EMPLOYEE.EMP_ID), 이름(EMPLOYEE.EMP_NAME), 직급명(JOB.JOB_NAME), 부서명(DEPARTMENT.DEPT_TITLE),
-- 근무지역명(LOCATION.LOCAL_NAME), 급여(EMPLOYEE.SALARY)를 조회하시오.
-- (해당 컬럼을 찾고, 해당 컬럼을 지닌 테이블들을 찾고, 테이블들을 어떤 순서로 조인해야 하는지 고민하고 SQL문을 작성할 것)
select e.EMP_ID `사번`
      ,e.EMP_NAME `이름`
      ,j.JOB_NAME `직급명`
      ,d.DEPT_TITLE `부서명`
      ,l.LOCAL_NAME `근무지역명`
      ,e.SALARY `급여`
  from employee e
  join job j
    on e.JOB_CODE = j.JOB_CODE
  join department d
    on e.DEPT_CODE = d.DEPT_ID
  join location l
    on d.LOCATION_ID = l.LOCAL_CODE
 where j.JOB_NAME = '대리'
   and l.LOCAL_NAME like 'ASIA%'
 order by e.EMP_NAME;


-- 9. 각 부서별 평균 급여와 직원 수를 조회하시오. (NULL 급여는 제외)
-- 평균 급여가 높은 순으로 정렬하시오. (6행)
select d.DEPT_TITLE `부서명`
      ,avg(ifnull(e.SALARY,0)) `평균 급여`
      ,count(*) `직원 수`
  from employee e
  join department d
    on e.DEPT_CODE = d.DEPT_ID
 group by d.DEPT_TITLE
 order by `평균 급여` desc;


-- 10. 직원 중 보너스를 받는 직원들의 연봉 총합이 1억 원을
-- 초과하는 부서의 부서명과 연봉 총합을 조회하시오. (1행)
-- 10. 직원 중 보너스를 받는 직원들의 연봉 총합이 1억 원을 초과하는 부서명과 연봉 총합
select d.dept_title `부서명`,
       sum(e.salary * (1 + ifnull(e.bonus, 0)) * 12) `연봉 총합`
  from employee e
  join department d
    on e.dept_code = d.dept_id
 where e.bonus is not null  -- 보너스를 받는 직원만
 group by d.dept_title
having sum(e.salary * (1 + ifnull(e.bonus, 0)) * 12) > 100000000;



-- 11. 국내 근무하는 직원들 중 평균 급여 이상을 받는
-- 직원들의 사원명, 급여, 부서명을 조회하시오. (서브쿼리 사용) (4행)
select e.EMP_NAME `사원명`
      ,e.SALARY `급여`
      ,d.DEPT_TITLE `부서명`
  from employee e
  join department d
    on e.DEPT_CODE = d.DEPT_ID
  join location l
    on d.LOCATION_ID = l.LOCAL_CODE
 where l.NATIONAL_CODE = 'KO'
   and e.SALARY > ( select avg(SALARY) from employee)
 order by e.SALARY;


-- 12. 모든 부서의 부서명과 해당 부서에 소속된 직원 수를 조회하시오.
-- 직원이 없는 부서도 함께 표시하시오. (9행)
select d.DEPT_TITLE `부서명`
     , COUNT(e.EMP_ID) `직원 수`
  from department d
       left join employee e
         on d.DEPT_ID = e.DEPT_CODE
 group by d.DEPT_TITLE
 order by `부서명`;


-- 13. 차장(J4) 이상 직급을 가진 직원과 사원(J7) 직급을 가진
-- 직원들의 급여 합계를 비교하여 결과를 출력하시오. (SET OPERATOR 사용) (2행)
select '차장 이상' `직급`
      ,sum(e.SALARY) `급여 합계`
  from employee e
 where e.JOB_CODE <= 'J4'

union

select '사원' `직급`
      ,sum(e.SALARY) `급여 합계`
  from employee e
 where e.JOB_CODE = 'J7';

