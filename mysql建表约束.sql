-- mysql建表约束


-- 主键约束

-- 它能够唯一确定一张表中的一条记录，也就是我们通过给某个字段添加约束，就可以使得该字段不重复且不为空

CREATE TABLE user (
   id INT PRIMARY KEY,
   name VARCHAR(20)
);

mysql> INSERT INTO user VALUES(1, '张三');
Query OK, 1 row affected (0.01 sec)

mysql> INSERT INTO user VALUES(1, '张三');
ERROR 1062 (23000): Duplicate entry '1' for key 'user.PRIMARY'

-- 联合主键：由多个字段组成的主键，每个字段都不可以为空
-- 只要联合的主键值加起来不重复就可以
CREATE TABLE user2 (
   id INT,
   name VARCHAR(20),
   passward VARCHAR(20),
   PRIMARY KEY(id, name)
);

INSERT INTO user2 VALUES(1, '张三', '123');

mysql> INSERT INTO user2 VALUES(2, '张三', '123');
Query OK, 1 row affected (0.00 sec)

INSERT INTO user2 VALUES(NULL, '张三', '123');
ERROR 1048 (23000): Column 'id' cannot be null


-- 自增约束

CREATE TABLE user3 (
   id INT PRIMARY KEY auto_increment,
   name VARCHAR(20)
);

mysql> INSERT INTO user3 (name) VALUES('ZHANGSAN');
Query OK, 1 row affected (0.01 sec)

mysql> select * from user3;
+----+----------+
| id | name     |
+----+----------+
|  1 | ZHANGSAN |
+----+----------+
1 row in set (0.00 sec)

mysql> INSERT INTO user3 (name) VALUES('ZHANGSAN');
Query OK, 1 row affected (0.00 sec)

mysql> select * from user3;
+----+----------+
| id | name     |
+----+----------+
|  1 | ZHANGSAN |
|  2 | ZHANGSAN |
+----+----------+
2 rows in set (0.00 sec)


-- 在创建表后，添加/删除主键约束

CREATE TABLE user4 (
   id INT,
   name VARCHAR(20)
);

mysql> desc user4;
+-------+-------------+------+-----+---------+-------+
| Field | Type        | Null | Key | Default | Extra |
+-------+-------------+------+-----+---------+-------+
| id    | int         | YES  |     | NULL    |       |
| name  | varchar(20) | YES  |     | NULL    |       |
+-------+-------------+------+-----+---------+-------+
2 rows in set (0.00 sec)

-- 修改表结构，添加主键
ALTER TABLE user4 ADD PRIMARY KEY (id);

mysql> desc user4;
+-------+-------------+------+-----+---------+-------+
| Field | Type        | Null | Key | Default | Extra |
+-------+-------------+------+-----+---------+-------+
| id    | int         | NO   | PRI | NULL    |       |
| name  | varchar(20) | YES  |     | NULL    |       |
+-------+-------------+------+-----+---------+-------+
2 rows in set (0.00 sec)

-- 删除主键
ALTER TABLE user4 DROP PRIMARY KEY;

mysql> DESC user4
    -> ;
+-------+-------------+------+-----+---------+-------+
| Field | Type        | Null | Key | Default | Extra |
+-------+-------------+------+-----+---------+-------+
| id    | int         | NO   |     | NULL    |       |
| name  | varchar(20) | YES  |     | NULL    |       |
+-------+-------------+------+-----+---------+-------+
2 rows in set (0.01 sec)

-- 使用modify，修改字段，添加约束
ALTER TABLE user4 MODIFY id INT PRIMARY KEY;

mysql> DESC user4;
+-------+-------------+------+-----+---------+-------+
| Field | Type        | Null | Key | Default | Extra |
+-------+-------------+------+-----+---------+-------+
| id    | int         | NO   | PRI | NULL    |       |
| name  | varchar(20) | YES  |     | NULL    |       |
+-------+-------------+------+-----+---------+-------+
2 rows in set (0.00 sec)


-- 唯一约束
-- 约束修饰的字段的值不可以重复

CREATE TABLE user5 (
   id int,
   name varchar(20)
);

mysql> alter table user5 add unique(name);
Query OK, 0 rows affected (0.00 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> desc user5;
+-------+-------------+------+-----+---------+-------+
| Field | Type        | Null | Key | Default | Extra |
+-------+-------------+------+-----+---------+-------+
| id    | int         | YES  |     | NULL    |       |
| name  | varchar(20) | YES  | UNI | NULL    |       |
+-------+-------------+------+-----+---------+-------+
2 rows in set (0.00 sec)

mysql> insert into user5 values(1, 'zhangsan');
Query OK, 1 row affected (0.00 sec)

mysql> insert into user5 values(1, 'zhangsan');
ERROR 1062 (23000): Duplicate entry 'zhangsan' for key 'user5.name'

mysql> insert into user5 values(1, 'lisi');
Query OK, 1 row affected (0.00 sec)


CREATE TABLE user6 (
   id int,
   name varchar(20),
   unique(name)
);


CREATE TABLE user7 (
   id int,
   name varchar(20) unique
);

-- unique(id, name) 表示两个键在一起不重复就行
CREATE TABLE user8 (
   id int,
   name varchar(20),
   unique(id, name)
);

mysql> desc user8;
+-------+-------------+------+-----+---------+-------+
| Field | Type        | Null | Key | Default | Extra |
+-------+-------------+------+-----+---------+-------+
| id    | int         | YES  | MUL | NULL    |       |
| name  | varchar(20) | YES  |     | NULL    |       |
+-------+-------------+------+-----+---------+-------+
2 rows in set (0.00 sec)

insert into user8 values(1, 'zhangsan');

-- 删除唯一约束
mysql> alter table user7 drop index name;
Query OK, 0 rows affected (0.01 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> desc user7;
+-------+-------------+------+-----+---------+-------+
| Field | Type        | Null | Key | Default | Extra |
+-------+-------------+------+-----+---------+-------+
| id    | int         | YES  |     | NULL    |       |
| name  | varchar(20) | YES  |     | NULL    |       |
+-------+-------------+------+-----+---------+-------+
2 rows in set (0.00 sec)

-- 通过modify添加unique约束
mysql> alter table user7 modify name varchar(20) unique;
Query OK, 0 rows affected (0.01 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> desc user7;
+-------+-------------+------+-----+---------+-------+
| Field | Type        | Null | Key | Default | Extra |
+-------+-------------+------+-----+---------+-------+
| id    | int         | YES  |     | NULL    |       |
| name  | varchar(20) | YES  | UNI | NULL    |       |
+-------+-------------+------+-----+---------+-------+
2 rows in set (0.00 sec)

-- 总结
-- 1. 建表的时候添加约束
-- 2. 使用alter... add...
-- 3. alter... modify...
-- 4. 删除：alter... drop...


-- 非空约束
-- 修饰的字段不能为空NULL

create table user9 (
   id int,
   name varchar(20) not null
);

mysql> desc user9;
+-------+-------------+------+-----+---------+-------+
| Field | Type        | Null | Key | Default | Extra |
+-------+-------------+------+-----+---------+-------+
| id    | int         | YES  |     | NULL    |       |
| name  | varchar(20) | NO   |     | NULL    |       |
+-------+-------------+------+-----+---------+-------+
2 rows in set (0.00 sec)

mysql> insert into user9 (id) values(1);
-- ERROR 1364 (HY000): Field 'name' doesn't have a default value

mysql> insert into user9 (name) values('lisi');
Query OK, 1 row affected (0.00 sec)

mysql> select * from user9;
+------+------+
| id   | name |
+------+------+
| NULL | lisi |
+------+------+
1 row in set (0.00 sec)

-- 默认约束
-- 当我们插入字段的值时，如果没有传值，就会使用默认值

create table user10 (
   id int,
   name varchar(20),
   age int default 10
);

mysql> desc user10;
+-------+-------------+------+-----+---------+-------+
| Field | Type        | Null | Key | Default | Extra |
+-------+-------------+------+-----+---------+-------+
| id    | int         | YES  |     | NULL    |       |
| name  | varchar(20) | YES  |     | NULL    |       |
| age   | int         | YES  |     | 10      |       |
+-------+-------------+------+-----+---------+-------+
3 rows in set (0.00 sec)

insert into user10 (id, name) values(1, 'zhangsan');

mysql> select * from user10;
+------+----------+------+
| id   | name     | age  |
+------+----------+------+
|    1 | zhangsan |   10 |
+------+----------+------+
1 row in set (0.00 sec)

-- 传了值就不会使用默认值


-- 外键约束
-- 涉及到两个表：父表，子表
-- 主表，副表

-- 班级
create table classes(
   id int primary key,
   name varchar(20)
);

-- 学生表
create table students(
   id int primary key,
   name varchar(20),
   class_id int,
   foreign key(class_id) references classes(id)
);

mysql> desc students;
+----------+-------------+------+-----+---------+-------+
| Field    | Type        | Null | Key | Default | Extra |
+----------+-------------+------+-----+---------+-------+
| id       | int         | NO   | PRI | NULL    |       |
| name     | varchar(20) | YES  |     | NULL    |       |
| class_id | int         | YES  | MUL | NULL    |       |
+----------+-------------+------+-----+---------+-------+
3 rows in set (0.00 sec)

insert into classes values (1,'1');
insert into classes values (2,'2');
insert into classes values (3,'3');
insert into classes values (4,'4');

mysql> select * from classes;
+----+------+
| id | name |
+----+------+
|  1 | 1    |
|  2 | 2    |
|  3 | 3    |
|  4 | 4    |
+----+------+
4 rows in set (0.00 sec)

insert into students values(1001, '张三', 1);
insert into students values(1002, '张三', 2);
insert into students values(1003, '张三', 3);
insert into students values(1004, '张三', 4);

mysql> insert into students values(1005, 'lisi', 5);
ERROR 1452 (23000): Cannot add or update a child row: a foreign key constraint fails (`test`.`students`, CONSTRAINT `students_ibfk_1` FOREIGN KEY (`class_id`) REFERENCES `classes` (`id`))

-- 1 主表classes中没有的数据值，在副表中，是不可以使用的。
-- 2 主表中的记录被附表引用，是不可以被删除的

delete from classes where id=4;

mysql> delete from classes where id=4;
ERROR 1451 (23000): Cannot delete or update a parent row: a foreign key constraint fails (`test`.`students`, CONSTRAINT `students_ibfk_1` FOREIGN KEY (`class_id`) REFERENCES `classes` (`id`))
