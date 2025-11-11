
# 1. 부서별 직원 급여의 총합 중 가장 큰 액수 출력
select sum(SALARY) dept_salary
from employee
group by DEPT_CODE
order by dept_salary desc
limit 1;

# 2. 서브쿼리를 이용하여 영업부인 직원들의 사원번호, 직원명, 부서코드, 급여를 출력하세요.
# 참고. 영업부인 직원은 부서명에 ‘영업’이 포함된 직원임
select e.EMP_ID, e.EMP_NAME, e.DEPT_CODE, e.SALARY
from employee e
    join department d on e.DEPT_CODE = d.DEPT_ID
where d.DEPT_TITLE like '%영업%';

select e.EMP_ID, e.EMP_NAME, e.DEPT_CODE, e.SALARY
from employee e
where e.DEPT_CODE in (select d.DEPT_ID
                        from department d
                        where d.DEPT_TITLE like '%영업%');

# 3. 서브쿼리와 JOIN을 이용하여 영업부인 직원들의 사원번호, 직원명, 부서명, 급여를 출력
select e.EMP_ID, e.EMP_NAME, d.DEPT_TITLE, e.SALARY
from employee e
    join department d on e.DEPT_CODE = d.DEPT_ID
where e.DEPT_CODE in (select d.DEPT_ID
                        from department d
                        where d.DEPT_TITLE like '%영업%');

# 4-1. JOIN을 이용하여 부서의 부서코드, 부서명, 해당 부서가 위치한 지역명, 국가명을 추출
select d.DEPT_ID, d.DEPT_TITLE, l.LOCAL_NAME, n.NATIONAL_NAME
from department d
    join location l on d.LOCATION_ID = l.LOCAL_CODE
    join national n on l.NATIONAL_CODE = n.NATIONAL_CODE;


# 4-2. 이를 서브쿼리로 활용하여 모든 직원의 사원번호, 직원명, 급여, 부서명, (부서의) 국가명을 출력
select e.EMP_ID, e.EMP_NAME, e.SALARY, aff.DEPT_TITLE, aff.NATIONAL_NAME
from employee e
    join (select d.DEPT_ID, d.DEPT_TITLE, l.LOCAL_NAME, n.NATIONAL_NAME
        from department d
        join location l on d.LOCATION_ID = l.LOCAL_CODE
        join national n on l.NATIONAL_CODE = n.NATIONAL_CODE)
        aff on e.DEPT_CODE = aff.DEPT_ID
order by aff.NATIONAL_NAME desc;

# 5. 러시아에서 발발한 전쟁으로 인해 정신적 피해를 입은 직원들에게 위로금을 전달하려고 함.
# 위로금은 각자의 급여에 해당 직원의 급여 등급에 해당하는 최소 금액을 더한 금액으로 산정.
# Q4에서 작성한 쿼리를 활용하여 해당 부서의 국가가 ‘러시아’인 직원들을 대상으로,
# 직원의 사원번호, 직원명, 급여, 부서명, 국가명, 위로금을 출력하세요.
# 단, 위로금 내림차순으로 출력되도록 하세요.
select e.EMP_ID, e.EMP_NAME, e.SALARY, aff.DEPT_TITLE, aff.NATIONAL_NAME,
       (select e.SALARY + min(es.SALARY)
        from employee es
        where e.DEPT_CODE = es.DEPT_CODE) COMPENSATION
from employee e
    join (select d.DEPT_ID, d.DEPT_TITLE, n.NATIONAL_NAME
        from department d
            join location l on d.LOCATION_ID = l.LOCAL_CODE
            join national n on l.NATIONAL_CODE = n.NATIONAL_CODE
        where n.NATIONAL_NAME = '러시아')
        aff on e.DEPT_CODE = aff.DEPT_ID
order by COMPENSATION desc;



select *
from employee;