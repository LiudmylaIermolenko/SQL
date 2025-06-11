-- use gt081024;
/*1. Создать базу данных homeworks
2.  В этой базе создать таблицу staff с полями:
 • id – integer - уникальное значение, не пустое, с автозаполнением 
 • firstname - varchar - не пустое
 • lastname - varchar - не пустое
 • position - varchar
 • age - integer - от 0 до 110(вкл.)
 • has_child – char только один символ, по умолчанию 'N' 
 • username - varchar - уникальный
3. Добавить 5 строк.*/

create database homeworks;
use homeworks;

create table staff(
id int primary key auto_increment,
firstname varchar(100) not null,
lastname varchar(100) not null,
position varchar(100),
age int check(age between 0 and 110),
has_child  char(1) default "N" check(has_child in ("Y", "N")),
username  varchar(100) unique
);

insert into staff (firstname, lastname, position, age, has_child, username)
values ('Alice', 'Smith', 'Developer', 28, 'N', 'alicesmith'),
('Bob', 'Brown', 'Designer', 45, 'Y', 'bobbrown'),
('Jane', 'Davis', 'HR', 30, 'N', 'janedavis'),
('John', 'Doe', 'Manager', 35, 'Y', 'johndoe'),
('Tom', 'Wilson', 'Tester', 25, 'N', 'tomwilson'); 

select * from staff;
