show tables;
CREATE USER 'swcamp'@'%' IDENTIFIED By 'swcamp';
drop user 'swcamp'@'%';

use mysql;
select * from user;
CREATE DATABASE menudb;

SHOW DATABASES;
SHOW GRANTS FOR 'swcamp'@'%';

GRANT ALL PRIVILEGES ON menudb.* TO 'swcamp'@'%';
GRANT ALL PRIVILEGES ON menudb.* TO 'swcamp'@'localhost' IDENTIFIED BY 'swcamp' WITH GRANT OPTION;

SHOW GRANTS FOR 'swcamp'@'%';

use menudb;

show databases;



