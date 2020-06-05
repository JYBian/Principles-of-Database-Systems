-- 数据库的三大设计范式

-- 1.第一范式
-- 1NF

-- 数据表中的所有字段都是不可分割的原子值

create table student2 (
   id int primary key,
   name varchar(20),
   address varchar(30)
);

insert into student2 values(1, 'zhangsan', '中国上海闵行区东川路100号');
insert into student2 values(2, 'lisi', '中国上海闵行区东川路200号');
insert into student2 values(3, 'wangwu', '中国上海徐汇区西川路300号');

   mysql> select * from student2;
   +----+----------+--------------------------------------+
   | id | name     | address                              |
   +----+----------+--------------------------------------+
   |  1 | zhangsan | 中国上海闵行区东川路100号            |
   |  2 | lisi     | 中国上海闵行区东川路200号            |
   |  3 | wangwu   | 中国上海徐汇区西川路300号            |
   +----+----------+--------------------------------------+
   3 rows in set (0.00 sec)

-- 字段值还可以继续拆分，就不满足第一范式
create table student3 (
   id int primary key,
   name varchar(20),
   country varchar(30),
   provience varchar(30),
   city varchar(30),
   details varchar(30)
);

insert into student3 values(1, 'zhangsan', '中国','上海','闵行区','东川路100号');
insert into student3 values(2, 'lisi', '中国','上海','闵行区','东川路200号');
insert into student3 values(3, 'wangwu', '中国','上海','徐汇区','西川路300号');

   mysql> select * from student3;
   +----+----------+---------+-----------+-----------+-----------------+
   | id | name     | country | provience | city      | details         |
   +----+----------+---------+-----------+-----------+-----------------+
   |  1 | zhangsan | 中国    | 上海      | 闵行区    | 东川路100号     |
   |  2 | lisi     | 中国    | 上海      | 闵行区    | 东川路200号     |
   |  3 | wangwu   | 中国    | 上海      | 徐汇区    | 西川路300号     |
   +----+----------+---------+-----------+-----------+-----------------+
   3 rows in set (0.00 sec)

-- 范式设计的越详细，对于某些实际操作可能更好，但是不一定都是好处。


-- 2. 第二范式
-- 必须是满足第一范式的前提下，第二范式要求，除主键外的每一列都必须完全依赖与主键。
-- 如果出现不完全依赖，只可能发生在联合主键的情况下。

-- 订单表
create table myorder(
   product_id int,
   customer_id int,
   product_name varchar(20),
   customer_name varchar(20),
   primary key(product_id,customer_id)
);

-- 问题在于，除主键以外的其他列只依赖于逐渐的部分字段，需要拆表

create table myorder(
   order_id int primary key,
   product_id int,
   customer_id int
);

create table product(
   id int primary key,
   name varchar(20)
);

create table customer(
   id int primary key,
   name varchar(20)
);

-- 分成三个表之后，就满足了第二范式的设计


-- 3. 第三范式
-- 必须先满足第二范式，除开主键列的其他列之间不能有传递依赖关系。

create table myorder(
   order_id int primary key,
   product_id int,
   customer_id int，
   customer_phone varchar(15) -- 除了和order_id外还和customer_id有关，冗余
);
