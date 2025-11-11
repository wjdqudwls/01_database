/*
    연봉 계산법 : 월급 * (1 + 보너스) * 12 로 수행하시면 됩니다.
    참고로 보너스 컬럼 값이 null인 경우 연산 결과도 null이 나옵니다.
    null 처리 함수 → 내장 함수 챕터에서 학습할 예정이지만 적용해보려면
    IFNULL(보너스, 0) 또는 NVL(보너스, 0) 과 같이 적용하면 null 인 경우 0 으로 취급되어 보너스 없이 계산이 수행 됩니다.
*/

-- 1. 이름에 '형'자가 들어가는 직원들의 사번, 사원명, 부서명을 조회하시오.(1행)
    select
        e.EMP_id,
        e.EMP_NAME,
        d.DEPT_TITLE
    from EMPLOYEE e
    left join
        DEPARTMENT d on(e.DEPT_CODE = d.DEPT_ID)
    where
        e.EMP_NAME like '%형%';

-- 2. 해외영업팀에 근무하는 사원명, 직급명, 부서코드, 부서명을 조회하시오.(9행)

select * from EMPLOYEE;
select * from job;
select * from DEPARTMENT;

    select e.EMP_NAME, j.JOB_NAME, d.DEPT_ID, d.DEPT_TITLE
    from EMPLOYEE e
    join JOB j
    on (e.JOB_CODE = j.JOB_CODE)
    join DEPARTMENT d
    on(e.DEPT_CODE = d.DEPT_ID)
    where d.DEPT_TITLE like '%해외영업%';

-- 3. 보너스포인트를 받는 직원들의 사원명, 보너스포인트, 부서명, 근무지역명을 조회하시오.(8행)
-- (INNER JOIN 결과)
select * from EMPLOYEE;
select * from LOCATION;

    select e.EMP_NAME, e.BONUS, d.DEPT_TITLE, l.LOCAL_NAME
    from EMPLOYEE e
    join DEPARTMENT d
    on (e.DEPT_CODE = d.DEPT_ID)
    join LOCATION l
    on (d.LOCATION_ID = LOCAL_CODE)
    where e.BONUS is not null;


-- 4. 부서코드가 D2인 직원들의 사원명, 직급명, 부서명, 근무지역명을 조회하시오.(3행)
select * from LOCATION;
select * from EMPLOYEE;

    select e.EMP_NAME, j.JOB_NAME, d.DEPT_TITLE, l.LOCAL_NAME
    from EMPLOYEE e
    join DEPARTMENT d on (e.DEPT_CODE = d.DEPT_ID)
    join JOB j on (e.JOB_CODE = j.JOB_CODE)
    join LOCATION l on (d.LOCATION_ID = l.LOCAL_CODE)
    where e.DEPT_CODE = 'D2';

-- 5. 급여 테이블의 등급별 최소급여(MIN_SAL)보다 많이 받는 직원들의
-- 사원명, 직급명, 급여, 연봉을 조회하시오.
-- 연봉에 보너스포인트를 적용하시오.(20행)
select * from EMPLOYEE;
select * from SAL_GRADE;

    select e.EMP_NAME, j.JOB_NAME,
           (e.SALARY * (1 + nvl(e.BONUS, 0)) *12) as '연봉'
    from EMPLOYEE e
    join JOB j on (e.JOB_CODE = j.JOB_CODE)
    join SAL_GRADE s on (e.SAL_LEVEL = s.SAL_LEVEL)
    where e.SALARY > s.MIN_SAL;

-- 6. 한국(KO)과 일본(JP)에 근무하는 직원들의
-- 사원명, 부서명, 지역명, 국가명을 조회하시오.(15행)
select * from LOCATION;
select * from NATIONAL;

    select e.EMP_NAME, d.DEPT_TITLE, l.LOCAL_NAME, n.NATIONAL_NAME
    from EMPLOYEE e
    join DEPARTMENT d on(e.DEPT_CODE = d.DEPT_ID)
    join LOCATION l on(d.LOCATION_ID = l.LOCAL_CODE)
    join NATIONAL n on (l.NATIONAL_CODE = n.NATIONAL_CODE)
    where n.NATIONAL_CODE in('KO', 'JP');


-- 7. 보너스포인트가 없는 직원들 중에서 직급코드가 J4와 J7인 직원들의 사원명, 직급명, 급여를 조회하시오.
-- 단, join과 IN 사용할 것(8행)

    select e.EMP_NAME, j.JOB_NAME, e.SALARY
    from EMPLOYEE e
    join job j on(e.JOB_CODE = j.JOB_CODE)
    where e.BONUS is null
    and e.JOB_CODE in('j4', 'j7');

-- 8. 직급이 대리이면서 아시아 지역(ASIA1, ASIA2, ASIA3 모두 해당)에 근무하는 직원 조회(2행)
-- 사번(EMPLOYEE.EMP_ID), 이름(EMPLOYEE.EMP_NAME), 직급명(JOB.JOB_NAME), 부서명(DEPARTMENT.DEPT_TITLE),
-- 근무지역명(LOCATION.LOCAL_NAME), 급여(EMPLOYEE.SALARY)를 조회하시오.
-- (해당 컬럼을 찾고, 해당 컬럼을 지닌 테이블들을 찾고, 테이블들을 어떤 순서로 조인해야 하는지 고민하고 SQL문을 작성할 것)
select * from LOCATION;
select * from DEPARTMENT;

    select e.EMP_ID, e.EMP_NAME, j.JOB_NAME, d.DEPT_TITLE, l.LOCAL_NAME, e.SALARY
    from EMPLOYEE e
    join job j on (e.JOB_CODE = j.JOB_CODE)
    join DEPARTMENT d on(e.DEPT_CODE = d.DEPT_ID)
    join LOCATION l on(d.LOCATION_ID = l.LOCAL_CODE)
    where j.JOB_NAME = '대리'
    and l.LOCAL_NAME in('ASIA1', 'ASIA2', 'ASIA2');

select * from DEPARTMENT;
select *from LOCATION;

-- 9. 각 부서별 평균 급여와 직원 수를 조회하시오. (NULL 급여는 제외)
-- 평균 급여가 높은 순으로 정렬하시오. (6행)


    select d.DEPT_TITLE, avg(e.SALARY) as '평균', count(*) as '직원 수'
    from EMPLOYEE e
    join DEPARTMENT d
    on (e.DEPT_CODE = d.DEPT_ID)
    where e.SALARY is not null
    group by d.DEPT_TITLE
    order by '평균' desc;

-- 10. 직원 중 보너스를 받는 직원들의 연봉 총합이 1억 원을
-- 초과하는 부서의 부서명과 연봉 총합을 조회하시오. (1행)

    select d.DEPT_TITLE, sum((e.SALARY * (1 + nvl(e.BONUS, 0)) *12) ) as '총합'
    from EMPLOYEE e
    join DEPARTMENT d on(e.DEPT_CODE = d.DEPT_ID)
    where e.BONUS is not null
    group by d.DEPT_TITLE
    HAVING SUM(e.SALARY * (1 + NVL(e.BONUS, 0)) * 12) > 100000000;

-- 11. 국내 근무하는 직원들 중 평균 급여 이상을 받는
-- 직원들의 사원명, 급여, 부서명을 조회하시오. (서브쿼리 사용) (4행)
select * from LOCATION;
select * from EMPLOYEE;
select * from DEPARTMENT;
select * from NATIONAL;

    select e.EMP_NAME, e.SALARY, d.DEPT_TITLE
    from EMPLOYEE e
    join DEPARTMENT d on (e.DEPT_CODE = d.DEPT_ID)
    join LOCATION l on(d.LOCATION_ID = l.LOCAL_CODE)
    join NATIONAL n on(l.NATIONAL_CODE = n.NATIONAL_CODE)
    where n.NATIONAL_CODE = 'KO'
    AND e.SALARY >= (SELECT AVG(SALARY) FROM EMPLOYEE);


-- 12. 모든 부서의 부서명과 해당 부서에 소속된 직원 수를 조회하시오.
-- 직원이 없는 부서도 함께 표시하시오. (9행)

  select d.DEPT_TITLE, count(e.EMP_NAME)    -- count(*)로 작성할경우 행이 count되므로 0이 나오게 작성해야함
  from DEPARTMENT d
  left join EMPLOYEE e on (d.DEPT_ID = e.DEPT_CODE)
  group by d.DEPT_TITLE;

-- 13. 차장(J4) 이상 직급을 가진 직원과 사원(J7) 직급을 가진
-- 직원들의 급여 합계를 비교하여 결과를 출력하시오. (SET OPERATOR 사용) (2행)

select * from JOB;

    select  "차장이상" as "구분",sum(e.SALARY)
    from EMPLOYEE e
    where JOB_CODE in('J1','J2','J3','J4')
    union
    select "사원" as "구분",sum(e.SALARY)
    from EMPLOYEE e
    where JOB_CODE = 'J7';


-- 전체 평균 급여보다 높은 급여를 받는 직원들을 조회하세요.
select e.EMP_NAME, e.SALARY
from EMPLOYEE e
where SALARY > (select avg(SALARY) from EMPLOYEE);

<<<<<<< HEAD

select round(avg(SALARY)) from EMPLOYEE
=======
SHOW COLUMNS FROM NATIONAL;
>>>>>>> b5c4a7330b71aacc6fd820d772d4f2826ee4d8af
