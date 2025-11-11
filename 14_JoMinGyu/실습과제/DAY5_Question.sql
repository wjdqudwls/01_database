
# 1. 전화번호가 010으로 시작하는 직원의 직원명과 전화번호를 다음과 같이 출력하세요.
# 출력한 결과집합 헤더의 명칭은 각각 ‘EMP_NAME’, ‘PHONE’이어야 함
# 전화번호는 ‘010-0000-0000’ 형식으로 출력해야 함
select
    EMP_NAME,
    concat_ws('-',
        substring(phone, 1, 3),
        substring(phone, 4, 4),
        substring(phone, 8, 4)) phone
from
    employee
where
    substring(phone, 1, 3) = '010';

# 2. 근속 일수가 20년 이상인 직원의 직원명, 입사일, 급여를 다음과 같이 출력하세요.
# 단, 입사한 순서대로 출력하고 입사일이 같으면 급여가 높은 순서로 출력되도록 하세요.
# 출력한 결과집합 헤더의 명칭은 각각 ‘직원명’, ‘입사일’, ‘급여’여야 함
# 입사일은 ‘0000년 00월 00일’ 형식으로 출력해야 함
# 급여는 천 단위로 , 를 찍어 출력해야 함
select emp_name '직원명', date_format(HIRE_DATE, '%Y년 %m월 %d일') '입사일', format(SALARY,0) '급여'
from employee
where subdate(curdate(), interval 20 year) >= HIRE_DATE
order by HIRE_DATE, SALARY desc;

# 3. 모든 직원의 직원명, 급여, 보너스, 급여에 보너스를 더한 금액을 다음과 같이 출력하세요.
# 단, 급여에 보너스를 더한 금액이 높은 순으로 출력되도록 하세요.
# 출력한 결과집합 헤더의 명칭은 각각 ‘EMP_NAME’, ‘SALARY’, ‘BONUS’, ‘TOTAL_SALARY’
# 보너스를 더한 급여는 소수점이 발생할 경우 반올림 처리함
# 급여와 보너스를 더한 급여는 천 단위로 , 를 찍어 출력해야 함
# 보너스는 백분율로 출력해야 함
select EMP_NAME, format(SALARY,0) salary, concat(format(ifnull(BONUS, 0)*100,0),'%') bonus, format((1+ifnull(bonus, 0))*SALARY,0) total_salary
from employee;

# 4. 직원의 직원명과 이메일을 다음과 같이 출력하세요.
# 출력한 결과집합 헤더의 명칭은 각각 ‘EMP_NAME’, ‘EMAIL’이어야 함
# 이메일의 도메인 주소인 greedy.com 은 모두 동일하므로,
# 해당 문자열이 맞춰질 수 있도록 이메일의 앞에 공백을 두고 출력해야 함
select EMP_NAME, lpad(EMAIL, 18, ' ')
from employee;

# 4-1. 이메일의 도메인 주소가 모두 다르다고 가정할 때, @의 위치를 한 줄로 맞춰보자.
INSERT INTO employee VALUES (223, '유지태', '349021-4590419', 'yaho_yaho@naver.com', null, 'D2', 'J3', 'S5', 2700000, null, null, '1990-01-14', null, 'Y');
INSERT INTO employee VALUES (224, '유아인', '349021-4464219', 'ya_ya@navergood.com', null, 'D3', 'J5', 'S5', 2100000, null, null, '1995-01-14', null, 'Y');

select EMP_NAME, concat(lpad(substring_index(EMAIL, '@', 1), 10, ' '),
       '@',
       rpad(substring_index(EMAIL, '@', -1), 15, ' '))
from employee;

delete from employee where EMP_ID = 223;
delete from employee where EMP_ID = 224;

# 5. 사내 행사 준비를 위해 직원 목록을 출력하려고 합니다. 직원 목록을 다음과 같이 출력.
# 단, 관리자의 이름순으로 정렬하여 출력되도록 하세요.
# 직원명, 직급명, 주민등록번호, 부서가 있는 국가, 부서명, 해당 직원의 관리자 직원명을 출력
# 출력한 결과집합 헤더의 명칭은 각각 ‘NAME_TAG’, ‘EMP_NO’, ‘BELONG’, ‘MANAGER_NAME’
# NAME_TAG : (직원명) (직급명)님
# EMP_NO : (생년월일6자리)-(뒷자리 한 자리를 제외하고는 *로 표시)
# BELONG : (부서의 국가)지사 (부서명) 소속
select concat(e.EMP_NAME, ' ', j.JOB_NAME, '님') name_tag,
       concat(substr(e.EMP_NO, 1, 8), '*******') emp_no,
       concat(n.NATIONAL_NAME, '지사 ', d.DEPT_TITLE, ' 소속') belong,
       m.EMP_NAME manager_name
from employee e
    left join employee m on e.MANAGER_ID = m.EMP_ID
    join job j on e.JOB_CODE = j.JOB_CODE
    join department d on e.DEPT_CODE = d.DEPT_ID
    join location l on d.LOCATION_ID = l.LOCAL_CODE
    join national n on l.NATIONAL_CODE=n.NATIONAL_CODE
order by manager_name;


select *
from employee;

select *
from job;

select *
from department;

select *
from national;
