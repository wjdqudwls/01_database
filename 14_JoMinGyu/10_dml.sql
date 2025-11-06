INSERT INTO tbl_menu
values
    (
     null, '바나나해장국',
     8500, 4,
     'Y'
    );

insert into tbl_menu
values
    (
     null,
     '바나나해장국',
     8500,
     4,
     'Y'
    );

select *
from tbl_menu;

insert into tbl_menu
    (menu_name, menu_price, category_code, orderable_status)
values
    ('초콜릿죽', 6500, 7, 'Y');

INSERT
  INTO tbl_menu
(orderable_status, menu_price, menu_name, category_code)
VALUES
('Y', 5500, '파인애플탕', 4);

INSERT
  INTO tbl_menu
VALUES
(null, '참치맛아이스크림', 1700, 12, 'Y'),
(null, '멸치맛아이스크림', 1500, 11, 'Y'),
(null, '소시지맛커피', 2500, 8, 'Y');

UPDATE tbl_menu
set
    menu_name = '딸기맛붕어빵',
    category_code = 7
where menu_code = 23;

update tbl_menu
set
    category_code = 6
where menu_name = '초콜릿죽';

update tbl_menu
set
    category_code = (select category_code
                     from tbl_menu
                     where menu_name = '흑마늘아메리카노')
where menu_name = '초콜릿죽';

delete from tbl_menu
where menu_code = 24
limit 2;

delete
from tbl_menu
order by menu_price
limit 2;

delete
from tbl_menu
where 1=1;

replace into tbl_menu
values (
        17, '참기름소주', 5000, 10,'Y'
       );

REPLACE tbl_menu
    SET menu_code = 2
      , menu_name = '우럭쥬스'
      , menu_price = 2000
      , category_code = 9
      , orderable_status = 'N';