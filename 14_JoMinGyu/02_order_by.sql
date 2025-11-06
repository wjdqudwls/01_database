/* 02. ORDER BY

*/

select menu_code, menu_name, menu_price
from tbl_menu
order by menu_price desc, menu_name

select menu_code, menu_name, menu_price
from tbl_menu
order by 2 desc

select
    menu_code as '메뉴 코드',
    menu_price as '메뉴 가격',
    menu_code*menu_price as '연산 결과'
from
    tbl_menu
order by
    `연산 결과`

select ref_category_code from tbl_category
order by -ref_category_code desc

select field('D', 'A', 'B', 'C')

select
    menu_name,
    orderable_status,
    field(orderable_status, 'Y', 'N')
from
    tbl_menu
order by
    field(orderable_status, 'Y', 'N') asc