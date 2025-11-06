/* swcamp 계정 사용 */
select * from tbl_menu;
select * from tbl_category;

select
    a.menu_name, a.menu_price, b.category_name
from
    tbl_menu a
inner join
        tbl_category b
            on a.category_code = b.category_code;

/* practice 계정으로 변경 */
select * from employee;
select * from department;

select
    *
from employee e
inner join
    department d
        on e.DEPT_CODE = d.DEPT_ID
where e.EMP_ID < 210;

/* oracle 방식 join */
select
    *
from
    employee e, department d
where
    e.DEPT_CODE = d.DEPT_ID;

select
    EMP_NAME
from
    employee;

select
    DEPT_ID, DEPT_TITLE
from
    department;

select
    *
from
    employee e
left join department d
    on e.DEPT_CODE = d.DEPT_ID;

select
    *
from
    employee e
right join department d
    on e.DEPT_CODE = d.DEPT_ID;

select
    *
from
    employee a
LEFT JOIN employee b
    on a.MANAGER_ID = b.EMP_ID;

