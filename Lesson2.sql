use gt081024;
-- Table
-- type data: integer/int, numeric/decimal/dec, varchar(N)/cha(M)
-- decimal(N, M)  N- max k-vo cyfr(1-65), M -max(0-N) k-vo cyfr posle tochki 
-- po umolch: N=10 M =0 (10.0)

-- decimal(5, 2)
-- [-999.99-999.99]
create table products(
product_id int,
title varchar(100),
price decimal,
quantity int
);
-- wyvod table:
select * from products;

-- zapolnit table:
insert into products 
values (1, "Apple", 100, 6),
(2, "Orange", 150, 10),
(3, "Kiwi", 120, 4),
(4, "Banana", 150, 11),
(5, "Mango", 250, 15),
(6, "Grapes", 100, 12);

select * from products;

insert into products (product_id, title, quantity)
values (1, "Pear", 6),
(2, "Oranges", 10);
select * from products;

-- nul != 0
select * from products;

-- wywesty title from table
select title 
from products
where quantity > 10; 

-- "M"
select *
from products
where title like 'm%';
-- Ограничения/атрибуты таблиц 

-- unique - значения в поле должны быть уникальными 
-- not null - значения в поле не могут быть незаполненными (null)
-- primary key - not null + unique - в таблцие можно использовать только один раз
-- check(условие) - значение поле сответствует какому-либо условию 
-- default значение - у поля будет значение по умолчанию 
-- auto_increment - позволяет создавать уникальный номер автоматически, когда новая 
-- запись вставляется в таблицу. Часто это поле основного ключа, которое мы хотели бы создать 
-- автоматически каждый раз, когда будет вставлена новая запись.



select title 
from products
where title in ("Apple", "Mango", "Kiwi");

select title 
from products
where title = "Apple" or title = "Mango" or title = "Kiwi";

select title 
from products
where price between 100 and 150;

select * 
from products
where price between 100 and 150; 

-- title : price > 100 and
select title  
from products
where price > 100 and quantity < 10;
-- age >= 20 and age <= 30;

select * 
from products
where price > 100 and quantity < 10;
-- wyvesty product, where price is null/ is not null
select *
from products
where price is null;

-- Ограничения/атрибуты таблиц 

-- unique - значения в поле должны быть уникальными 
-- not null - значения в поле не могут быть незаполненными (null)
-- primary key - not null + unique - в таблцие можно использовать только один раз
-- check(условие) - значение поле сответствует какому-либо условию 
-- default значение - у поля будет значение по умолчанию 
-- auto_increment - позволяет создавать уникальный номер автоматически, когда новая 
-- запись вставляется в таблицу. Часто это поле основного ключа, которое мы хотели бы создать 
-- автоматически каждый раз, когда будет вставлена новая запись.

-- Создать таблицу students
-- id целое число, уникальное значение, не null, автозаполнение 
-- firstname varchar not null
-- lastname varchar not null
-- class integer от 1 до 10 (вкл)
-- subject_name varchar not null
-- mark integer от 0 до 5 (вкл)
-- school_no integer по умолч. 0
-- checked char(1) значение Y либо N

create table students(
	id int primary key auto_increment,
    firstname varchar(100) not null,
    lastname varchar(100) not null,
    class int check(class between 1 and 10),
    subject_name varchar(100) not null,
    mark int check(mark between 0 and 5),
    school_no int default 0,
    checked char(1) check(checked in ('Y', 'N'))
);
select * from students;

-- drop table students;
-- drop database gt081024;

insert into students (firstname, lastname, class, subject_name, mark, school_no, checked)
values ("John", "Smith", 5, "Math", 4, 120, "N"); 
select * from students;
drop table students;

insert into students (firstname, lastname, class, subject_name, mark, school_no, checked)
values ("John", "Smith", 5, "Math", 4, 120, "N"); 

create table students(
	id int primary key auto_increment,
    firstname varchar(100) not null,
    lastname varchar(100) not null,
    class int check(class between 1 and 10),
    subject_name varchar(100) not null,
    mark int check(mark between 0 and 5),
    school_no int default 0,
    checked char(1) check(checked in ('Y', 'N'))
);
select * from students;
insert into students (firstname, lastname, class, subject_name, mark, school_no, checked)
values ("John", "Smith", 5, "Math", 4, 120, "N"); 
select * from students;
-- Создать таблицу students
-- id целое число, уникальное значение, не null, автозаполнение 
-- firstname varchar not null
-- lastname varchar not null
-- class integer от 1 до 10 (вкл)
-- subject_name varchar not null
-- mark integer от 0 до 5 (вкл)
-- school_no integer по умолч. 0
-- checked char(1) значение Y либо N


