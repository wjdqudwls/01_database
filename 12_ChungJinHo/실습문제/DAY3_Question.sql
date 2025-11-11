# /*DAY3: Question
# Q1.
# 부서별 직원 급여의 총합 중 가장 큰 액수를 출력하세요.
# 답안
SELECT MAX(dept_total) max_total_salary
FROM (
    SELECT dept_code ,SUM(SALARY) dept_total
    FROM employee
    GROUP BY DEPT_CODE
) t;


# Q2.
# 서브쿼리를 이용하여 영업부인 직원들의 사원번호, 직원명, 부서코드, 급여를 출력하세요.
# 참고. 영업부인 직원은 부서명에 ‘영업’이 포함된 직원임
# 답안
select EMP_ID
      ,EMP_NAME
      ,DEPT_CODE
      ,SALARY
  from employee
 where DEPT_CODE in (
                    select DEPT_ID
                      from department
                     where DEPT_TITLE like '%영업%'
                    );


# Q3.
# 서브쿼리와 JOIN을 이용하여 영업부인 직원들의 사원번호, 직원명, 부서명, 급여를 출력하
# 세요.
# 답안
select e.emp_id
      ,e.emp_name
      ,d.dept_title
      ,e.salary
  from employee e
  join department d
    on e.dept_code = d.dept_id
 where e.dept_code in (
                      select dept_id
                        from department
                       where dept_title like '%영업%'
                      )


# Q4.
# 1. JOIN을 이용하여 부서의 부서코드, 부서명, 해당 부서가 위치한 지역명, 국가명을 추출
# 하는 쿼리를 작성하세요.
select d.DEPT_ID
      ,d.DEPT_TITLE
      ,l.LOCAL_NAME
      ,n.NATIONAL_NAME
  from department d
  join location l
    on d.LOCATION_ID = l.LOCAL_CODE
  join national n
    on l.NATIONAL_CODE = n.NATIONAL_CODE;

# 2. 위 1에서 작성한 쿼리를 서브쿼리로 활용하여 모든 직원의 사원번호, 직원명, 급여, 부서
# 명, (부서의) 국가명을 출력하세요.
# 단, 국가명 내림차순으로 출력되도록 하세요.
# 답
select e.EMP_ID 사번
      ,e.EMP_NAME 사원명
      ,e.SALARY 급여
      ,dln.DEPT_TITLE 부서명
      ,dln.LOCAL_NAME 지역명
      ,dln.NATIONAL_NAME 국가명
  from employee e
  left join
       (
           select d.DEPT_ID
                 ,d.DEPT_TITLE
                 ,l.LOCAL_NAME
                 ,n.NATIONAL_NAME
             from department d
             join location l
              on d.LOCATION_ID = l.LOCAL_CODE
             join national n
              on l.NATIONAL_CODE = n.NATIONAL_CODE
       ) dln
 on e.DEPT_CODE = dln.DEPT_ID
 order by dln.NATIONAL_NAME desc, e.DEPT_CODE;

# Q5.
# 러시아에서 발발한 전쟁으로 인해 정신적 피해를 입은 직원들에게 위로금을 전달하려고 합
# 니다. 위로금은 각자의 급여에 해당 직원의 급여 등급에 해당하는 최소 금액을 더한 금액으로
# 정했습니다.
# Q4에서 작성한 쿼리를 활용하여 해당 부서의 국가가 ‘러시아’인 직원들을 대상으로, 직원의
# 사원번호, 직원명, 급여, 부서명, 국가명, 위로금을 출력하세요.
# 단, 위로금 내림차순으로 출력되도록 하세요.
# */
select e.EMP_ID 사원번호
      ,e.EMP_NAME 사원명
      ,e.SALARY 급여
      ,dln.DEPT_TITLE 부서명
      ,dln.LOCAL_NAME 지역명
      ,dln.NATIONAL_NAME 국가명
      ,e.SALARY + s.MIN_SAL 위로금

  from employee e
  left join
       (
           select d.DEPT_ID
                 ,d.DEPT_TITLE
                 ,l.LOCAL_NAME
                 ,n.NATIONAL_NAME
             from department d
             join location l
              on d.LOCATION_ID = l.LOCAL_CODE
             join national n
              on l.NATIONAL_CODE = n.NATIONAL_CODE
       ) dln
 on e.DEPT_CODE = dln.DEPT_ID
  join sal_grade s
    on e.SAL_LEVEL = s.SAL_LEVEL
 where dln.NATIONAL_NAME = '러시아'
 order by 위로금 desc, dln.NATIONAL_NAME desc, e.DEPT_CODE;