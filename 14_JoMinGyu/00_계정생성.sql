show databases;

CREATE USER 'swcamp'@'%' IDENTIFIED BY 'swcamp';

show databases;

USE mysql;

select * from user;

CREATE DATABASE menudb;

show databases;

show grants for 'swcamp'@'%';

grant all privileges on menudb.* to 'swcamp'@'%';

show grants for 'swcamp'@'%';

use menudb;