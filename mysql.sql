-- mysql

-- 关系型数据库


-- 一、使用终端操作数据库

-- 1. 登陆数据库服务器
bogon:~ bianjunyu$ mysql -u root -p

-- 2. 查询数据库服务器中所有的数据库
mysql> show databases;
+--------------------+
| Database           |
+--------------------+
| blog               |
| information_schema |
| mysql              |
| performance_schema |
| sys                |
+--------------------+
5 rows in set (0.00 sec)

-- 3. 选中某一个数据库进行操作

-- SQL语句中的查询
mysql> select * from blog;
ERROR 1046 (3D000): No database selected

mysql> use blog
Database changed

-- 退出数据库服务器
mysql> exit;
Bye

-- 在数据库服务器中创建数据库
mysql> create database test;
Query OK, 1 row affected (0.01 sec)

mysql> use test;
Database changed

-- 查看某个数据库中所有的数据表
mysql> show tables;
Empty set (0.00 sec)

-- 创建一个数据表
create table pet (
  name varchar(20),
  owner varchar(20),
  species varchar(20),
  sex char(1),
  birth date,
  death date
);

mysql> create table pet (
    ->   name varchar(20),
    ->   owner varchar(20),
    ->   species varchar(20),
    ->   sex char(1),
    ->   birth date,
    ->   death date
    -> );
Query OK, 0 rows affected (0.02 sec)

-- 查看是否创建成功
mysql> show tables;
+----------------+
| Tables_in_test |
+----------------+
| pet            |
+----------------+
1 row in set (0.01 sec)

-- 查看创建好的数据表的结构
mysql> describe pet;
+---------+-------------+------+-----+---------+-------+
| Field   | Type        | Null | Key | Default | Extra |
+---------+-------------+------+-----+---------+-------+
| name    | varchar(20) | YES  |     | NULL    |       |
| owner   | varchar(20) | YES  |     | NULL    |       |
| species | varchar(20) | YES  |     | NULL    |       |
| sex     | char(1)     | YES  |     | NULL    |       |
| birth   | date        | YES  |     | NULL    |       |
| death   | date        | YES  |     | NULL    |       |
+---------+-------------+------+-----+---------+-------+
6 rows in set (0.01 sec)

-- 查看数据表中的记录
mysql> select * from pet;
Empty set (0.01 sec)

-- 向表中添加数据记录
mysql> insert into pet
    -> values ('Puffball', 'Diane', 'hamster', 'f', '1999-03-30', NULL);
Query OK, 1 row affected (0.01 sec)

-- 再一次查询
mysql> select * from pet;
+----------+-------+---------+------+------------+-------+
| name     | owner | species | sex  | birth      | death |
+----------+-------+---------+------+------------+-------+
| Puffball | Diane | hamster | f    | 1999-03-30 | NULL  |
+----------+-------+---------+------+------------+-------+
1 row in set (0.00 sec)

mysql> insert into pet
    ->   values('旺财', '周星驰', '狗', '公', '1990-01-01', NULL);
Query OK, 1 row affected (0.00 sec)

mysql> select * from pet;
+----------+-----------+---------+------+------------+-------+
| name     | owner     | species | sex  | birth      | death |
+----------+-----------+---------+------+------------+-------+
| Puffball | Diane     | hamster | f    | 1999-03-30 | NULL  |
| 旺财     | 周星驰    | 狗      | 公   | 1990-01-01 | NULL  |
+----------+-----------+---------+------+------------+-------+
2 rows in set (0.00 sec)

-- mysql常用数据类型

-- 数值
-- TINYINT
-- SMALLINT
-- MEDIUMINT
-- INT/INTEGER
-- BIGINT
-- FLOAT
-- DOUBLE
CREATE TABLE testType(
   number TINYINT
);

INSERT INTO testType VALUES(127);

mysql> INSERT INTO testType VALUES(128);
ERROR 1264 (22003): Out of range value for column 'number' at row 1

-- 时间日期
-- DATE
-- TIME
-- YEAR
-- DATETIME
-- TIMESTAMP

-- 字符串
-- CHAR
-- VARCHAR
-- TINYBLOB
-- TINYTEXT
-- BLOB
-- TEXT
-- MEDIUBLOB
-- MEDIUMTEXT
-- LONGBLOB
-- LONGTEXT

-- 数据类型的选择
-- 日期选择按照格式，数值和字符串按照大小

-- 删除数据表中数据
mysql> DELETE FROM pet WHERE name='name';
Query OK, 0 rows affected (0.00 sec)

-- 修改数据表中数据
mysql> UPDATE pet SET name='旺旺财' WHERE name='旺财';
Query OK, 1 row affected (0.00 sec)
Rows matched: 1  Changed: 1  Warnings: 0

-- 总结：数据记录常见操作
-- 增加：INSERT
-- 删除：DELETE
-- 修改：UPDATE
-- 查询：SELECT


-- 二、使用可视化工具操作数据库

-- 三、使用编程语言操作数据库
