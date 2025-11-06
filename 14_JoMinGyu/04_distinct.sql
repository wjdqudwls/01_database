select
    distinct ref_category_code
from
    tbl_category
where
    ref_category_code is not null

select
    distinct category_code, orderable_status
from
    tbl_menu