show databases;
use mysql;
SELECT *FROM USER;

USE mysql;

CREATE DATABASE menudb;

SHOW DATABASES;

CREATE USER 'swcamp'@'%' IDENTIFIED BY  'swcamp';

SHOW DATABASES;

USE mysql;

SELECT * FROM USER;

CREATE DATABASE menudb;

SHOW DATABASES;

SHOW GRANTS FOR 'swcamp'@'%';

GRANT ALL PRIVILEGES ON menudb.* TO 'swcamp'@'%';

SHOW GRANTS FOR 'swcamp'@'%';

USE menudb;

SHOW DATABASES;

USE menudb;

SELECT * FROM USER;

USE mysql;

SELECT * FROM USER;

USE menudb;

USE mysql;
GRANT ALL PRIVILEGES ON menudb.* TO 'swcamp'@'localhost' IDENTIFIED BY 'swcamp' WITH GRANT OPTION;

USE menudb;
