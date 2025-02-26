use gt081024;
select * from staff;
 -- 1. Создать новое поле experience_level и заполнить его значением:
alter table staff
add column experience_level varchar(64);

set sql_safe_updates = 0;

update staff
set experience_level = case
							when age < 25 then 'Junior'
                            when age between 25 and 35 then 'Middle'-- when age >= 25 and age <= 35 -- when age <=35
                            else 'Senior' -- when age > 35
						end;

select * from staff;
-- 9. Вывести возраст всех сотрудников, увеличенный на 5 лет.
select firstname, lastname, age, age+5 as new_age
from staff;
-- 14. Найти сотрудников, у которых фамилии начинаются с 'A' или 'L'.
select firstname, lastname
from staff
where lastname like 'A%' or lastname like 'L%';
-- 15. Создать новое поле username_default и заполнить его значением:

	-- 	username, если имя пользователя указано.
	-- 	'unknown', если имя пользователя не указано.
    
alter table staff
add column username_default varchar(128);
-- Вариант 1
update staff
set username_default = case
							when username is not null then username
                            else 'unknown'
						end;
                        
-- Вариант 2                    
update staff
set username_default = coalesce(username, 'unknown');

-- Вариант 3
update staff
set username_default = if(username is not null, username, 'unknown');

create database market1;

use market1;

create table user_bremen(
	id int primary key auto_increment,
    first_name varchar(128),
    last_name varchar(128),
    age int,
    email varchar(128),
    phone varchar(128)
);

create table user_berlin(
	id int primary key auto_increment,
    first_name varchar(128),
    last_name varchar(128),
    age int,
    email varchar(128)
);
insert into user_bremen(first_name, last_name, age, email, phone)
values ('John', 'Smith', 34, 'jsmith@gmail.com', '+1234890765'),
('Linda', 'Jonson', 23, 'ljonson@gmail.com', '+37412345676'),
        ('Barbarra', 'Thomas', 45, 'bthomas@gmail.com', '+13427774568'),
        ('Ben', 'King', 54, 'bking@gmail.com', '+1009456888');
        
insert into user_berlin(first_name, last_name, age, email)
values ('Carol', 'Robson', 35, 'crobson@gmail.com'),
('Bob', 'Brown', 54, 'bbrown@gmail.com'),
        ('Barbarra', 'Thomas', 45, 'bthomas@gmail.com'),
        ('Mellissa', 'Wans', 20, 'mwans@gmail.com'),
        ('Laura', 'Smith', 34, 'lsmith@gmail.com');
        select * from user_bremen;
		select * from user_berlin;
         
        -- Оператор UNION позволяет обединить две однотипных выборки. Эти выборки могут быть из разных таблиц или из одной и той же таблицы.
-- select поле1, поле2, ... from table1
-- union/union all
-- select поле1, поле2, ... from table2
select * from user_bremen
union
select * from user_berlin;
-- Error Code: 1222. The used SELECT statements have a different number of columns	0.016 sec

-- Вывести пользователей из Бремена и Берлина 
select first_name, last_name, age, email
from user_bremen
union 
select first_name, last_name, age, email
from user_berlin;
-- вывод - 8 строк

select first_name, last_name, age, email
from user_bremen
union all
select first_name, last_name, age, email
from user_berlin;
-- вывод - 9 строк

-- UNION - выводит уникальные значения после соединения
-- UNION ALL - выводит все данные после соединения
-- Логическая ошибка
select first_name, last_name, age, email
from user_bremen
union 
select first_name, last_name, email, age
from user_berlin;

-- Вывести имена, фамилии, эл. адреса и телефонные номера, где они указаны(если не указаны - null).
select first_name, last_name, email, phone
from user_bremen
union
select first_name, last_name, email, null as phone
from user_berlin;

select first_name, last_name, email, null as phone
from user_berlin
union
select first_name, last_name, email, phone
from user_bremen;
-- Barbara!!! not uniqe!'Barbarra', 'Thomas', 'bthomas@gmail.com', NULL
-- 'Barbarra', 'Thomas', 'bthomas@gmail.com', '+13427774568'

use gt081024;
-- Из таблиц students, employees, staff вывести имена и фамилии. 
select firstname, lastname
from students
union
select first_name, last_name
from employees
union all
select firstname, lastname
from staff;
-- Из таблиц emp_test, staff, employees вывести имена и фамилии сотрудников в одном поле fullname
select full_name
from emp_test
union
select concat(firstname, ' ', lastname) as full_name
from staff
union 
select concat(first_name, ' ', last_name) as full_name
from employees;

-- Выведите имена, фамилии и телефонные номера пользователей из таблицы user_bremen.
-- Дополнительно выведите временное поле tel_number_code, в котором:
	-- Значение "USA" устанавливается, если номер телефона начинается с +1.
	-- Значение "Armenia" устанавливается, если номер телефона начинается с +374.
    
use market1;

select first_name, last_name, phone, 
		case
			when phone like '+1%' then 'USA'
			when phone like '+374%' then 'Armenia'
			else 'Unknown'
        end as tel_number_code
from user_bremen;

select first_name, last_name, phone, 'USA' as tel_number_code
from user_bremen
where phone like '+1%'
union
select first_name, last_name, phone, 'Armenia' as tel_number_code
from user_bremen
where phone like '+374%'
union
select first_name, last_name, phone, 'Unknown' as tel_number_code
from user_bremen
where phone not like '+1%' and phone not like '+374%';

-- 1. Создать таблицу products1 с полями:
-- id (целое число, первичный ключ)
-- name (cтрока максимум 50 символов)
-- quantity (число больше 0 и меньше 10)
-- in_stock (один символ (Y/N))

-- Создать таблицу products2 с полями:
-- id (целое число, первичный ключ)
-- name (cтрока максимум 50 символов)
-- quantity (число больше 0 и меньше 10)
-- price (целое число, больше 0)
-- in_stock (один символ (Y/N))
CREATE TABLE products1 (
    id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    quantity INT CHECK (quantity > 0 AND quantity < 10),
    in_stock CHAR(1) CHECK (in_stock IN ('Y', 'N'))
);
select * from products1;

CREATE TABLE products2 (
    id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    quantity INT CHECK (quantity > 0 AND quantity < 10),
    price INT CHECK (price > 0),
    in_stock CHAR(1) CHECK (in_stock IN ('Y', 'N'))
);
select * from products2;
insert into products1
values (1, 'Велосипед', 2, 'Y'), 
		(2, 'Скейт', 4, 'Y'), 
		(3, 'Самокат', 2, 'Y'), 
		(4, 'Сноуборд', 7, 'N'), 
		(5, 'Санки', 1, 'Y'), 
		(6, 'Коньки', 3, 'N'), 
		(7, 'Ролики', 5, 'Y');
        select * from products1;

insert into products2
values (1, 'Тюбинг', 5, 1000, 'Y'), 
		(2, 'Санки', 2, 1500, 'Y'), 
		(3, 'Снегокат', 2, 900, 'Y'), 
		(4, 'Сноуборд', 7, 700, 'N'), 
		(5, 'Клюшка', 8, 300, 'Y'), 
		(6, 'Коньки', 3, 350, 'N'), 
		(7, 'Форма', 9, 450, 'Y');
        select * from products2;
        
        -- Вывести названия товаров из обеих таблиц без дубликатов.
select name
from products1
union
select name
from products2;
-- Вывести названия товаров из обеих таблиц без дубликатов.
select name from products1
union all
select name from products2;
 -- Объединить данные из двух таблиц, указав price, где это возможно, где нет - указать null.       
-- Объединить данные из двух таблиц, указав price, где это возможно, где нет - указать null.
select name, quantity, price, in_stock
from products2
union
select name, quantity, null as price, in_stock
from products1;

-- Вывести все товары из обеих таблиц и добавить дополнительное поле source,
-- которое будет содержать 'P1' для товаров из products1 и 'P2' для товаров из products2.
-- Вывести название и source
select name, 'P1' as source
from products1
union -- all
select name, 'P2' as source
from products2;




