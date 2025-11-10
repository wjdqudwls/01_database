
CREATE TABLE phone (
    phone_code INT PRIMARY KEY,
    phone_name VARCHAR(100),
    phone_price DECIMAL(10, 2)
);

INSERT
  INTO phone (phone_code , phone_name , phone_price )
VALUES
(1, 'galaxyS23', 1200000),
(2, 'iPhone14pro', 1433000),
(3, 'galaxyZfold3', 1730000);

SELECT * FROM phone;
EXPLAIN select * from phone;

CREATE INDEX idx_name ON phone (phone_name);
EXPLAIN SELECT * FROM phone WHERE phone_name = 'galaxyS23';

drop index idx_name on phone;
EXPLAIN SELECT * FROM phone WHERE phone_name = 'galaxyS23';

explain
select *
from tbl_menu a
    join tbl_category b
on a.category_code = b.category_code
where category_name = (select category_name
                       from tbl_category
                       where a.category_code = 4);

select *
from information_schema.STATISTICS
where TABLE_SCHEMA = 'memudb';

