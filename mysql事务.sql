-- mysql事务

-- MySQL中，事务其实是一个最小的不可分割的工作单元。事务能够保证一个业务的完整性。
-- 比如银行转账：
-- a -> b: 100
update user set money=money-100 where name='a';
update user set money=money+100 where name='b';
-- 实际程序中，如果只有一条语句执行成功了，而另外一条没有执行成功，则会出现数据前后不一致。
update user set money=money-100 where name='a';
update user set money=money+100 where name='b';
-- 多条sql语句，可能会有同时成功的要求，要么就同时失败


-- mysql中控制事务的方法
-- 1. mysql默认是开启事务的(自动提交)
mysql> select @@autocommit;
+--------------+
| @@autocommit |
+--------------+
|            1 |
+--------------+
1 row in set (0.00 sec)

-- 默认事务开启的作用是：当我们执行一个sql语句时，效果会立即体现出来，且不能回滚。

create database bank;

create table user (
   id int primary key,
   name varchar(20),
   money int
);

insert into user values(1, 'a', 1000);

-- 事务回滚：撤销sql语句执行效果
mysql> rollback;
Query OK, 0 rows affected (0.00 sec)

mysql> select * from user;
+----+------+-------+
| id | name | money |
+----+------+-------+
|  1 | a    |  1000 |
+----+------+-------+
1 row in set (0.00 sec)

-- 设置mysql自动提交为false

mysql> set autocommit=0;
Query OK, 0 rows affected (0.00 sec)

mysql> select @@autocommit;
+--------------+
| @@autocommit |
+--------------+
|            0 |
+--------------+
1 row in set (0.00 sec)

-- 上面的操作，关闭了mysql的自动提交（commit）

mysql> insert into user values(2, 'b', 1000);
Query OK, 1 row affected (0.00 sec)

mysql> select* from user;
+----+------+-------+
| id | name | money |
+----+------+-------+
|  1 | a    |  1000 |
|  2 | b    |  1000 |
+----+------+-------+
2 rows in set (0.00 sec)

mysql> rollback;
Query OK, 0 rows affected (0.00 sec)

mysql> select* from user;
+----+------+-------+
| id | name | money |
+----+------+-------+
|  1 | a    |  1000 |
+----+------+-------+
1 row in set (0.00 sec)

-- 再一次插入数据
mysql> insert into user values(2, 'b', 1000);
Query OK, 1 row affected (0.00 sec)

-- 手动提交数据
mysql> commit;
Query OK, 0 rows affected (0.00 sec)

-- 再撤销，是不可以撤销的（事务的持久性）
mysql> rollback;
Query OK, 0 rows affected (0.00 sec)

mysql> select* from user;
+----+------+-------+
| id | name | money |
+----+------+-------+
|  1 | a    |  1000 |
|  2 | b    |  1000 |
+----+------+-------+
2 rows in set (0.00 sec)

-- 事务自动提交 @@autocommit=1
-- 事务手动提交 commit;
-- 事务回滚 rollback;
-- 如果说这个时候转账：
mysql> update user set money=money-100 where name='a';
Query OK, 1 row affected (0.01 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> update user set money=money+100 where name='b';
Query OK, 1 row affected (0.00 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> select * from user;
+----+------+-------+
| id | name | money |
+----+------+-------+
|  1 | a    |   900 |
|  2 | b    |  1100 |
+----+------+-------+
2 rows in set (0.00 sec)

mysql> rollback;
Query OK, 0 rows affected (0.00 sec)

mysql> select * from user;
+----+------+-------+
| id | name | money |
+----+------+-------+
|  1 | a    |  1000 |
|  2 | b    |  1000 |
+----+------+-------+
2 rows in set (0.00 sec)

-- 事务提供了返回的机会。

mysql> set autocommit=1;
Query OK, 0 rows affected (0.00 sec)

begin;
-- 或者
start transaction;
-- 都可以手动开启一个事物

mysql> update user set money=money-100 where name='a';
Query OK, 1 row affected (0.00 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> update user set money=money+100 where name='b';
Query OK, 1 row affected (0.01 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> select * from user;
+----+------+-------+
| id | name | money |
+----+------+-------+
|  1 | a    |   900 |
|  2 | b    |  1100 |
+----+------+-------+
2 rows in set (0.00 sec)

-- 事务回滚
mysql> rollback;
Query OK, 0 rows affected (0.00 sec)

-- 没有被撤销
mysql> select * from user;
+----+------+-------+
| id | name | money |
+----+------+-------+
|  1 | a    |   900 |
|  2 | b    |  1100 |
+----+------+-------+
2 rows in set (0.00 sec)

-- 手动开启事务 方法1
mysql> begin;
Query OK, 0 rows affected (0.00 sec)

mysql> update user set money=money-100 where name='a';
Query OK, 1 row affected (0.00 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> update user set money=money+100 where name='b';
Query OK, 1 row affected (0.00 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> select * from user;
+----+------+-------+
| id | name | money |
+----+------+-------+
|  1 | a    |   800 |
|  2 | b    |  1200 |
+----+------+-------+
2 rows in set (0.00 sec)

mysql> rollback;
Query OK, 0 rows affected (0.00 sec)

mysql> select * from user;
+----+------+-------+
| id | name | money |
+----+------+-------+
|  1 | a    |   900 |
|  2 | b    |  1100 |
+----+------+-------+
2 rows in set (0.00 sec)

-- 手动开启事务 方法2
mysql> start transaction;
Query OK, 0 rows affected (0.00 sec)

mysql> update user set money=money-100 where name='a';
Query OK, 1 row affected (0.00 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> update user set money=money+100 where name='b';
Query OK, 1 row affected (0.00 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> select * from user;
+----+------+-------+
| id | name | money |
+----+------+-------+
|  1 | a    |   800 |
|  2 | b    |  1200 |
+----+------+-------+
2 rows in set (0.00 sec)

mysql> rollback;
Query OK, 0 rows affected (0.00 sec)

mysql> select * from user;
+----+------+-------+
| id | name | money |
+----+------+-------+
|  1 | a    |   900 |
|  2 | b    |  1100 |
+----+------+-------+
2 rows in set (0.00 sec)

-- 事务开启之后，一旦commit提交，便不可再回滚（事务已经结束）

mysql> start transaction;
Query OK, 0 rows affected (0.00 sec)

mysql> update user set money=money-100 where name='a';
Query OK, 1 row affected (0.00 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> update user set money=money+100 where name='b';
Query OK, 1 row affected (0.00 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> commit;
Query OK, 0 rows affected (0.00 sec)

mysql> rollback;
Query OK, 0 rows affected (0.00 sec)

mysql> select * from user;
+----+------+-------+
| id | name | money |
+----+------+-------+
|  1 | a    |   800 |
|  2 | b    |  1200 |
+----+------+-------+
2 rows in set (0.00 sec)

-- 事务的四大特征
-- A 原子性：事务是最小的单位，不可以再分割。
-- C 一致性：事务要求，同一事务中的sql语句，必须保证同时成功或者同时失败。
-- I 隔离性：事务1和事务2之间是具有隔离性的。
-- D 持久性：事务一旦结束（commit，rollback），就不可以返回。

-- 事务开启：
-- 1. 修改默认提交 set sutocommit = 0;
-- 2. begin开启
-- 3. start transaction;

-- 事务手动提交：
-- commit;

-- 事务手动回滚：
-- rollback;


-- 事务的隔离性
-- 1. read uncommitted; 读未提交的
-- 2. read committed;   读已经提交的
-- 3. repeatable read;   可以重复读
-- 4. serializable;     串行化

-- read uncommitted
-- 如果有事务a和事务b，a事务对数据进行操作，在操作的过程中，事务没有被提交，但是b可以看见a操作的结果。
-- e.g.bank数据库中的user表
insert into user values(3, 'c', 1000);
insert into user values(4, 'd', 1000);

   mysql> select * from user;
   +----+------+-------+
   | id | name | money |
   +----+------+-------+
   |  1 | a    |   800 |
   |  2 | b    |  1200 |
   |  3 | c    |  1000 |
   |  4 | d    |  1000 |
   +----+------+-------+
   4 rows in set (0.00 sec)

-- 查看数据库的隔离级别
mysql 8.0:
-- 系统级别的
select @@global.transaction_isolation;
-- 会话级别的
select @@transaction_isolation;

-- mysql默认隔离级别
+--------------------------------+
| @@global.transaction_isolation |
+--------------------------------+
| REPEATABLE-READ                |
+--------------------------------+
1 row in set (0.00 sec)

mysql 5.x;
select @@global.tx_isolation;
select @@tx_isolation;

-- 修改隔离级别

mysql> set global transaction isolation level read uncommitted;
Query OK, 0 rows affected (0.00 sec)

mysql> select @@global.transaction_isolation;
+--------------------------------+
| @@global.transaction_isolation |
+--------------------------------+
| READ-UNCOMMITTED               |
+--------------------------------+
1 row in set (0.00 sec)

-- 转账：c在d买东西花费800块钱，
-- c在国外，银行转账
-- d在国内，银行查账

start transaction;
update user set money = money-800 where name = 'c';
update user set money = money+800 where name = 'd';

   mysql> select * from user;
   +----+------+-------+
   | id | name | money |
   +----+------+-------+
   |  1 | a    |   800 |
   |  2 | b    |  1200 |
   |  3 | c    |   200 |
   |  4 | d    |  1800 |
   +----+------+-------+
   4 rows in set (0.00 sec)

-- c给d打电话，让d去查是否到账
-- d在国内查账（开启另一个终端）
mysql> select * from user;
+----+------+-------+
| id | name | money |
+----+------+-------+
|  1 | a    |   800 |
|  2 | b    |  1200 |
|  3 | c    |   200 |
|  4 | d    |  1800 |
+----+------+-------+
4 rows in set (0.00 sec)

-- 发货

-- c在国外rollback

mysql> rollback;
Query OK, 0 rows affected (0.00 sec)

mysql> select * from user;
+----+------+-------+
| id | name | money |
+----+------+-------+
|  1 | a    |   800 |
|  2 | b    |  1200 |
|  3 | c    |  1000 |
|  4 | d    |  1000 |
+----+------+-------+
4 rows in set (0.00 sec)


-- d晚上花费1800元吃饭
-- 结账时，发现钱不够

mysql> select * from user;
+----+------+-------+
| id | name | money |
+----+------+-------+
|  1 | a    |   800 |
|  2 | b    |  1200 |
|  3 | c    |  1000 |
|  4 | d    |  1000 |
+----+------+-------+
4 rows in set (0.00 sec)

-- 如果两个不同的地方，都在进行操作，如果事务a开启之后，他的数据可以被其他事务读取到
-- 这样会出现 脏读（一个事务中，读到了另外一个事务中没有提交的数据）
-- 实际开发是不允许脏读出现的。


-- 2. read committed 读已提交的
-- 修改隔离级别为 READ-COMMITTED
mysql> set global transaction isolation level read committed;
Query OK, 0 rows affected (0.00 sec)

mysql> select @@global.transaction_isolation;
+--------------------------------+
| @@global.transaction_isolation |
+--------------------------------+
| READ-COMMITTED                 |
+--------------------------------+
1 row in set (0.00 sec)

-- e.g.bank数据库 user表：
-- 小明是银行的会计
start transaction;
mysql> select * from user;
+----+------+-------+
| id | name | money |
+----+------+-------+
|  1 | a    |   800 |
|  2 | b    |  1200 |
|  3 | c    |  1000 |
|  4 | d    |  1000 |
+----+------+-------+
4 rows in set (0.00 sec)
-- 小明去上厕所
-- 小王：
start transaction;
insert into user values(5, 'e', 100);
commit;

mysql> select * from user;
+----+------+-------+
| id | name | money |
+----+------+-------+
|  1 | a    |   800 |
|  2 | b    |  1200 |
|  3 | c    |  1000 |
|  4 | d    |  1000 |
|  5 | e    |   100 |
+----+------+-------+
5 rows in set (0.00 sec)

-- 小明上厕所回来
mysql> select avg(money) from user;
+------------+
| avg(money) |
+------------+
|   820.0000 |
+------------+
1 row in set (0.00 sec)

-- money 的平均值不是1000

-- 虽然我只能读到另外一个事务提交的数据，但还是会出现问题：读取同一个表的数据，发现前后不一致。
-- 这个现象叫做不可重复读现象（read committed）；


-- 3. Repeatable write 可重复读
mysql> set global transaction isolation level repeatable read;
Query OK, 0 rows affected (0.00 sec)

mysql> select @@global.transaction_isolation;
+--------------------------------+
| @@global.transaction_isolation |
+--------------------------------+
| REPEATABLE-READ                |
+--------------------------------+
1 row in set (0.00 sec)

-- 在repeatable write隔离级别下，会出现的问题
mysql> select * from user;
+----+------+-------+
| id | name | money |
+----+------+-------+
|  1 | a    |   800 |
|  2 | b    |  1200 |
|  3 | c    |  1000 |
|  4 | d    |  1000 |
|  5 | e    |   100 |
+----+------+-------+
5 rows in set (0.00 sec)

-- 张全蛋 国外
start transaction;

-- 王尼玛 国内
start transaction;

-- 张全蛋 国外
insert into user values(6, 'f', 1000);
commit;

-- 王尼玛 国内
mysql> select * from user;
+----+------+-------+
| id | name | money |
+----+------+-------+
|  1 | a    |   800 |
|  2 | b    |  1200 |
|  3 | c    |  1000 |
|  4 | d    |  1000 |
|  5 | e    |   100 |
+----+------+-------+
5 rows in set (0.00 sec)

mysql> insert into user values(6, 'f', 1000);
ERROR 1062 (23000): Duplicate entry '6' for key 'user.PRIMARY'

-- 插入6号时会报错，但查询时没有6号
-- 这种现象叫做 幻读
-- 两个事务a和事务b同时操作一张表，事务a提交的数据，也不能被事务b读到，就可以造成幻读。


-- 4. serializable 串行化
-- 修改隔离级别为串行化
mysql> set global transaction isolation level serializable;
Query OK, 0 rows affected (0.00 sec)

mysql> select @@global.transaction_isolation;
+--------------------------------+
| @@global.transaction_isolation |
+--------------------------------+
| SERIALIZABLE                   |
+--------------------------------+
1 row in set (0.00 sec)

-- 张全蛋 国外
start transaction;

-- 王尼玛 国内
start transaction;

-- 张全蛋 国外
insert into user values(7, 'g', 1000);

   mysql> commit;
   Query OK, 0 rows affected (0.00 sec)

   mysql> select * from user;
   +----+------+-------+
   | id | name | money |
   +----+------+-------+
   |  1 | a    |   800 |
   |  2 | b    |  1200 |
   |  3 | c    |  1000 |
   |  4 | d    |  1000 |
   |  5 | e    |   100 |
   |  6 | f    |  1000 |
   |  7 | g    |  1000 |
   +----+------+-------+
   7 rows in set (0.00 sec)

-- 王尼玛
mysql> select * from user;
+----+------+-------+
| id | name | money |
+----+------+-------+
|  1 | a    |   800 |
|  2 | b    |  1200 |
|  3 | c    |  1000 |
|  4 | d    |  1000 |
|  5 | e    |   100 |
|  6 | f    |  1000 |
|  7 | g    |  1000 |
+----+------+-------+
7 rows in set (0.00 sec)

-- 张全蛋 国外
start transaction;
insert into user values(8, 'h', 1000);

-- 语句卡住了
mysql> insert into user values(8, 'h', 1000);
-- 当user表被另外一个事务操作的时候，其他事务里面的写操作，是不可以进行的。
-- 进入排队状态（串行化），直到王尼玛事务结束之后，张全蛋的写入操作才会执行，前提是在没有等待超时的情况下。

-- 串行化问题是，性能很差，性能排序：
READ-UNCOMMITTED > READ-COMMITTED > REPEATABLE-READ > SERIALIZABLE;
-- 隔离级别越高，性能越差，mysql默认隔离级别是REPEATABLE-READ
