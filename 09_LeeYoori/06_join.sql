

/*
    두 개 이상의 테이블을 관련 있는 컬럼을 통해 결합

    1) inner join
        - 두 테이블의 교집합 반환
        - on 키워드 : join에 사용할 두 테이블의 컬럼을 명시
*/

select
    menu_code,
    menu_name,
    menu_price
from tbl_menu;

select * from tbl_category;

-- inner join(ANSI)
select a.menu_name, a.menu_price, b.category_name
from tbl_menu a
inner join tbl_category b
on a.category_code = b.category_code;

select * from DEPARTMENT;
select * from EMPLOYEE;


select a.DEPT_TITLE from DEPARTMENT a join EMPLOYEE b
on a.DEPT_ID = b.DEPT_CODE
where EMP_NAME = '선동일';

select * from EMPLOYEE
select * from DEPARTMENT

-- join은 두 테이블에서 지정된 컬럼 값이 같은 행들의 결합으로 만들어진 큰 테이블



    select * from

/*
    practice 계정으로 변경 후 실습
*/
select *
from EMPLOYEE;

select *
from department;

-- inner join(ANSI)
select e.EMP_ID, e.EMP_NAME, d.DEPT_TITLE
from EMPLOYEE e
join DEPARTMENT d
on e.DEPT_CODE = d.DEPT_ID
where e.emp_id < 210
limit 10;

-- oracle 방식 join
select *
from tbl_menu a, tbl_category b
where a.category_code = b.category_code;

/*
    2. left outer join
    - join 구문 기준으로 왼쪽 테이블의 모든 레코드 행이 결과에 포함되도록 하는 join
    - join의 기준이 된 컬럼 값이 일치하지 않아도 결과 포함
*/
-- practice 계정
select EMP_NAME, DEPT_CODE
from EMPLOYEE;

select DEPT_ID, DEPT_TITLE
from DEPARTMENT;

select *
from EMPLOYEE e
join DEPARTMENT d
on e.DEPT_CODE = d.DEPT_ID;


select *
from EMPLOYEE e
left outer join
    DEPARTMENT d
on e.DEPT_CODE = d.DEPT_ID;

/*
    2. right outer join
    - join 구문 기준으로 오른쪽 테이블의 모든 레코드 행이 결과에 포함되도록 하는 join
    - join의 기준이 된 컬럼 값이 일치하지 않아도 결과 포함
*/

select *
from EMPLOYEE e
right outer join
    DEPARTMENT d
on e.DEPT_CODE = d.DEPT_ID;


/*
    4. cross join
    - 두 테이블의 가능한 모든 조합을 반환하는 join
*/
-- swcamp T
select
    a.menu_name,
    b.category_name
from tbl_menu a
cross join tbl_category b;

/*
    5. self join
    - 같은 T의 join
    - 같은 T의 행과 행 사이의 관계를 찾을 때 주로 사용
    - tip. 같은 모양의 서로 다른 T가 있고, 이들의 join을 생각하면 됨
*/

select *
from tbl_category;

select *
from tbl_category a
join tbl_category b -- left outer join사용하면 없어진 내역 다시 생성됨
on a.ref_category_code = b.category_code;
-- null은 비교연산이 안되므로 조인하면 사라짐

-- practice 계정
select *
from EMPLOYEE;

select a.EMP_ID as '사번', a.EMP_NAME as '이름', nvl(b.EMP_NAME, '없음') as '사수명'
from EMPLOYEE a
left join EMPLOYEE b
on a.MANAGER_ID = b.EMP_ID;


-- swcamp
/*
    using : join에 사용되는 컬럼이름이 같은 경우 사용 가능한 구문
    - join에 사용되는 컬럼을 실제로 하나로 합침
    - 장점 : join 결과 컬럼 개수 감소
    - 단점 : 다른 join, subquery, 연산 수행 시 어떤 테이블의 컬럼을 지시하려는 것인지 알 수 없음(애매모호함)
*/

select *
from tbl_menu a
join tbl_category b
-- on a.category_code = b.category_code
using(category_code);

select * from EMPLOYEE order by EMP_NAME ;

select * from EMPLOYEE where EMP_NAME not like '김%'

select * from tbl_category
