select
    menu_code,
    menu_name,
    orderable_status
from
    tbl_menu
where orderable_status = 'Y'

select
    menu_name, menu_price
from
    tbl_menu
where menu_price=13000
order by menu_name desc

select
    menu_code, menu_name, orderable_status
from
    tbl_menu
where
    orderable_status != 'Y'
order by
    menu_name

select
    menu_name, menu_price
from
    tbl_menu
where
    menu_price>20000
order by
    menu_code desc

select *
from tbl_menu
where orderable_status = 'Y' and category_code = 10

select
    *
from
    tbl_menu
where
    menu_price not between 10000 and 25000
order by
    menu_price

select
    menu_name
from
    tbl_menu
where
    menu_name like '%아%'

select
    menu_name
from
    tbl_menu
where
    menu_name not like '%국%'

CREATE TABLE IF NOT EXISTS tbl_temp
(
    temp_code    INT AUTO_INCREMENT COMMENT '임시코드',
    temp_email    VARCHAR(30) NOT NULL COMMENT '이메일',
    PRIMARY KEY (temp_code)
) ENGINE=INNODB COMMENT '임시테이블';

INSERT INTO tbl_temp VALUES(1, 'sun_di@greedy.com');
INSERT INTO tbl_temp VALUES(2, 'song_jk@greedy.com');
INSERT INTO tbl_temp VALUES(3, 'no_oc@greedy.com');
INSERT INTO tbl_temp VALUES(4, 'song_eh@greedy.com');
INSERT INTO tbl_temp VALUES(5, 'yoo_js@greedy.com');

COMMIT;

select
    *
from
    tbl_temp
where temp_email like '___\_%'

select
    *
from
    tbl_menu
where
    category_code in (4, 5, 6)

select
    *
from
    tbl_category
where
    ref_category_code is not null
