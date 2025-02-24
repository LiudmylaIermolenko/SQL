use gt081024;
use homeworks;
select * from emp_test;
create table emp_test(
	id int primary key auto_increment, 
    full_name varchar(255),
    email varchar(128),
    age int
);

insert into emp_test(full_name, email, age)
values ('boB broWn', 'bobby1@gmail.com', 23),
		('john smith  ', 'jsmith@yahoo.com', 43),
        (' DEN HAMPSON', 'denny5@gmail.com', 22),
        ('lola jamesoN', 'lolajamson@mail.ru', 40),
        ('mIkE lOgAn', 'logan_mike@hotmail.com', 20);
  select * from emp_test;
  select full_name, concat(upper(left(trim(full_name), 1)), lower(substring((substring_index(trim(full_name), ' ', 1)), 2))) as name,
concat(upper(left(substring_index(trim(full_name), ' ', -1), 1)), lower(substring(substring_index(trim(full_name), ' ', -1), 2))) as surname,
concat(upper(left(trim(full_name), 1)), -- первая буква имени
		lower(substring((substring_index(trim(full_name), ' ', 1)), 2)), -- остальные буквы
		' ', 
		upper(left(substring_index(trim(full_name), ' ', -1), 1)), -- первая буква фамилии
		lower(substring(substring_index(trim(full_name), ' ', -1), 2))) as new_full_name -- остальные
from emp_test;

set sql_safe_updates = 0;
update emp_test
set full_name = concat(upper(left(trim(full_name), 1)), -- первая буква имени
						lower(substring((substring_index(trim(full_name), ' ', 1)), 2)), -- остальные буквы
						' ', 
						upper(left(substring_index(trim(full_name), ' ', -1), 1)), -- первая буква фамилии
						lower(substring(substring_index(trim(full_name), ' ', -1), 2)));
select * from emp_test;

-- Задание 2: Необходимо извлечь и вывести доменное имя (часть адреса электронной почты после символа '@', но до '.') из столбца email в таблице emp_test.
select email, substring_index(substring_index(email, '@', -1), '.', 1) as domen_name
from emp_test;

-- Задание 3: Необходимо извлечь инициалы сотрудников из столбца full_name и вывести их в формате 'И.И.' (первые буквы имени и фамилии с точками). 
select full_name, concat(left(full_name, 1), '.', left(substring_index(full_name, ' ', -1), 1), '.') as initials
from emp_test;

-- Функция CASE

-- CASE
--     WHEN условие_1 THEN результат_1
--     WHEN условие_2 THEN результат_2
--     .................................
--     WHEN условие_N THEN результат_N
--     [ELSE альтернативный_результат]
-- END

create table phones (
	id int primary key auto_increment,
    product_name varchar(128),
    product_count int,
    product_price int
);
insert into phones (product_name, product_count, product_price)
values ('iphone 15', 15, 700),
		('iphone 15 pro', 19, 750),
        ('samsung A11', 25, 600),
        ('xiaomi redmi 10', 8, 450),
        ('iphone 16', 1, 800),
        ('iphone 16 pro', 0, 900),
        ('iphone 16 pro max', 50, 1000),
        ('xiaomi redmi 11', 0, 650),
        ('sony xperia z3', 13, 720);
	select*from phones;
        
        -- Вывести название продукта, кол/во проданных продуктов, стоимость и посчитать общую сумму заказов(product_count*product_price)
 select product_name, product_count, product_price, product_count*product_price as total_sum
 from phones; -- where product_count > 0;
 
 -- Вывести название продукта, кол/во проданных продуктов, стоимость и 
 -- посчитать общую сумму заказов и вывести 'null', если кол/во(product_count) = 0, 
 -- и вывести сумму, если кол/во(product_count) больше 0 
 
 select product_name, product_count, product_price, 
		 case 
			when product_count > 0 then product_count*product_price
            when product_count = 0 then 'null'
		 end as total_sum
 from phones;
 
 select product_name, product_count, product_price, product_count*product_price
 from phones
 where product_count > 0;
 
 -- Вывести название продукта, кол/во товаров в наличии(product_count) и новое поле count_info, со значениями:
 -- Товар заканчивается, если кол/во меньше 2.
 -- Мало товара, если кол/во меньше 5.
 -- Есть в наличии, если кол/во меньше 15.
 -- Много товара, в остальных случаях.
 select product_name, product_count,
		case
			when product_count = 0 then 'Нет в наличии'
			when product_count < 2 then 'Товар заканчивается'
            when product_count < 5 then 'Мало товара'
            when product_count < 15 then 'Есть в наличии'
            else 'Много товара'
        end as count_info
        from phones;
        
        alter table phones
        add column count_info varchar(255);
        
        select * from phones;
        
        set sql_safe_updates = 0;
        
        update phones
set count_info = case
					when product_count = 0 then 'Нет в наличии'
                    when product_count < 2 then 'Товар заканчивается'
                    when product_count < 5 then 'Мало товара'
                    when product_count < 15 then 'Есть в наличии'
                    else 'Много товара'
				 end;

select * from phones;

alter table phones
rename column product_price to starting_price;
select * from phones;
-- Вывести product_name, starting_price и новое поле tax 
-- Заполнить поле tax:
-- Если начальная цена меньше/равно 700, tax = null,
-- если больше 700 и меньше 850, tax = 15,
-- если больше или равно 850, tax = 25
select product_name, starting_price, 
		case
			when starting_price <= 700 then null
            when starting_price < 850 then 15
            else 25
        end as tax
from phones;
-- Создать новое поле tax целое число
-- Заполнить поле tax:
-- Если начальная цена меньше/равно 700, tax = null,
-- если больше 700 и меньше 850, tax = 15,
-- если больше или равно 850, tax = 25
alter table phones
add column tax int;

update phones
set tax = case
				when starting_price <= 700 then null
				when starting_price < 850 then 15
				else 25
			end;
            
select * from phones;
ALTER TABLE phones
MODIFY COLUMN tax INT;
select * from phones;

-- Посчитать конечную цену и представить его как final_price
-- final_price = (starting_price + starting_price * tax / 100)
-- Вывести product_name, starting_price, tax, final_price
select product_name, starting_price, tax, (starting_price + starting_price * tax / 100) as final_price
from phones;

select product_name, starting_price, tax, 
		case
			when tax is null then starting_price
            else (starting_price + starting_price * tax / 100)
		end as final_price
from phones;

-- COALESCE

-- COALESCE(выражение_1, выражение_2, выражение_N) -- возвращает первое из них, которое не равно NULL

-- coalesce('string', 0, '', null, 5) -- 'string'
-- coalesce(10 + 20 * null, round(20 / 3 * null), 'string') -- 'string'

select product_name, starting_price, tax, coalesce(starting_price + starting_price * tax / 100, starting_price) as final_price
from phones;

-- IF

-- IF(условие, значение_1, значение_2) 
-- Если условие, передаваемое в качестве первого параметра, верно, то возвращается первое значение, 
-- иначе возвращается второе значение.

-- IFNULL

-- IFNULL(выражение, значение)
-- Функция IFNULL проверяет значение некоторого выражения.
--  Если оно равно NULL, то функция возвращает значение, которое передается в качестве второго параметра
use homeworks;
-- 1. Повысить зарплаты для отдела sales на 20%, для finance 15%, для shipping 10%, 
-- для marketing 25%, для HR 20% и для IT 35%. Записать данные в новое поле new_salary.
 -- Поле создавать не нужно, используем AS. 
-- 2. Создать поле new_salary типа numeric(7, 2)
-- 3. Заполнить поле: повысить зарплаты для отдела sales на 20%, для finance 15%, 
-- для shipping 10%, для marketing 25%, для HR 20% и для IT 35%.
-- 4. Вывести из таблицы employees first_name как user_name, last_name как surname и 
-- новое поле full_name, которое состоит из имен и фамилий сотрудников.
create table employees(
 	employee_id int primary key auto_increment,
 	first_name varchar(128) not null,
 	last_name varchar(128) not null,
 	email varchar(128) not null,
 	salary int, 
	department varchar(128) not null
 );
 insert into employees(first_name, last_name, email, salary, department) values("Steven","King",	"SKING", 24000, "Sales");
insert into employees(first_name, last_name, email, salary, department) values("Neena" , "Kochhar" , "NKOCHHAR" , 17000 , "Sales");
insert into employees(first_name, last_name, email, salary, department) values("Lex" , "De Haan" , "LDEHAAN" , 17000 , "Sales");
insert into employees(first_name, last_name, email, salary, department) values("Alexander" , "Hunold" , "AHUNOLD" , 9000 , "Finance");
insert into employees(first_name, last_name, email, salary, department) values("Bruce" , "Ernst" , "BERNST" , 6000 , "Finance");
insert into employees(first_name, last_name, email, salary, department) values("Valli" , "Pataballa" , "VPATABAL" , 4800 , "Finance");
insert into employees(first_name, last_name, email, salary, department) values("Diana" , "Lorentz" , "DIANALO" , 8800 , "Finance");
insert into employees(first_name, last_name, email, salary, department) values("Nancy" , "Greenberg" , "NGREENBE" , 12008 , "Shipping");
insert into employees(first_name, last_name, email, salary, department) values("Daniel" , "Faviet" , "DFAVIET" , 9000 , "Shipping");
insert into employees(first_name, last_name, email, salary, department) values("Jose Manuel" , "Urman" , "JMURMAN" , 7800 , "Shipping");
insert into employees(first_name, last_name, email, salary, department) values("Luis" , "Popp" , "LPOPP" , 6900 , "Shipping");
insert into employees(first_name, last_name, email, salary, department) values("Den" , "Raphaely" , "DRAPHEAL" , 11000 , "Marketing");
insert into employees(first_name, last_name, email, salary, department) values("Alexander" , "Khoo" , "AKHOO" , 3100 , "Marketing");
insert into employees(first_name, last_name, email, salary, department) values("Shelli" , "Baida" , "SBAIDA" , 2900 , "Marketing");
insert into employees(first_name, last_name, email, salary, department) values("Sigal" , "Tobias" , "STOBIAS" , 2800 , "Marketing");
insert into employees(first_name, last_name, email, salary, department) values("Matthew" , "Weiss" , "MWEISS" , 8000 , "Human Resources");
insert into employees(first_name, last_name, email, salary, department) values("Adam" , "Fripp" , "AFRIPP" , 8200 , "Human Resources");
insert into employees(first_name, last_name, email, salary, department) values("Payam" , "Kaufling" , "PKAUFLIN" , 7900 , "Human Resources");
insert into employees(first_name, last_name, email, salary, department) values("Shanta" , "Vollman" , "SVOLLMAN" , 6500 , "Human Resources");
insert into employees(first_name, last_name, email, salary, department) values("Kevin" , "Mourgos" , "KMOURGOS" , 5800 , "Human Resources");
insert into employees(first_name, last_name, email, salary, department) values("Julia" , "Nayer" , "JNAYER" , 3200 , "Human Resources");
insert into employees(first_name, last_name, email, salary, department) values("Adam" , "Markle" , "SMARKLE" , 2200 , "Human Resources");
insert into employees(first_name, last_name, email, salary, department) values("Laura" , "Bissot" , "LBISSOT" , 3300 , "Human Resources");
insert into employees(first_name, last_name, email, salary, department) values("Mozhe" , "Atkinson" , "MATKINSO" , 2800 , "Human Resources");
insert into employees(first_name, last_name, email, salary, department) values("Joshua" , "Patel" , "JPATEL" , 2500 , "Human Resources");
insert into employees(first_name, last_name, email, salary, department) values("Trenna" , "Rajs" , "TRAJS" , 3500 , "Human Resources");
insert into employees(first_name, last_name, email, salary, department) values("John" , "Russell" , "JRUSSEL" , 14000 , "IT");
insert into employees(first_name, last_name, email, salary, department) values("Karen" , "Partners" , "KPARTNER" , 13500 , "IT");
insert into employees(first_name, last_name, email, salary, department) values("Alberto" , "Errazuriz" , "AERRAZUR" , 12000 , "IT");
insert into employees(first_name, last_name, email, salary, department) values("Gerald" , "Cambrault" , "GCAMBRAU" , 11000 , "IT");
insert into employees(first_name, last_name, email, salary, department) values("Eleni" , "Zlotkey" , "EZLOTKEY" , 10500 , "IT");
insert into employees(first_name, last_name, email, salary, department) values("Adam" , "Vargas" , "PVARGAS" , 2500 , "Human Resources");
insert into employees(first_name, last_name, email, salary, department) values("Laura" , "Errazuriz" , "AERRAZUR" , 12000 , "IT");
select*from employees;
-- 1. Повысить зарплаты для отдела sales на 20%, для finance 15%, для shipping 10%, для marketing 25%, для Human Resources 20% и для IT 35%. Записать данные в новое поле new_salary. Поле создавать не нужно, используем AS. 
select department, salary, 
		case
			when department in ('Human Resources', 'Sales') then salary + salary * 20 /100
            when department = 'Finance' then salary + salary * 15 /100
            when department = 'Shipping' then salary + salary * 10 /100
            when department = 'Marketing' then salary + salary * 25 /100
            when department = 'IT' then salary + salary * 35 /100
        end as new_salary
from employees;

-- 2. Создать поле new_salary типа numeric(7, 2)
alter table employees
add column new_salary numeric(7, 2);
-- 3. Заполнить поле: повысить зарплаты для отдела sales на 20%, для finance 15%, для shipping 10%, для marketing 25%, для HR 20% и для IT 35%.
update employees
set new_salary = case
					when department in ('Human Resources', 'Sales') then salary + salary * 20 /100
					when department = 'Finance' then salary + salary * 15 /100
					when department = 'Shipping' then salary + salary * 10 /100
					when department = 'Marketing' then salary + salary * 25 /100
					when department = 'IT' then salary + salary * 35 /100
				end;

select * from employees;

-- 4. Вывести из таблицы employees first_name как user_name, last_name как surname и новое поле full_name, которое состоит из имен и фамилий сотрудников.
select first_name as user_name, last_name as surname, concat(first_name, ' ', last_name) as full_name
from employees;
-- 5. Вывести новое поле commission, которое будет null, 
-- если зарплата сотрудника меньше 3000, будет 10, если зарплата меньше 6000, 
-- будет 15, если зарплата меньше 9000, и будет 20, если зарплата больше/равно 9000.
SELECT 
    employee_id, 
    first_name, 
    last_name, 
    salary,
    CASE 
        WHEN salary < 3000 THEN NULL
        WHEN salary < 6000 THEN 10
        WHEN salary < 9000 THEN 15
        ELSE 20
    END AS commission
FROM employees;

-- 6. Создать новое поле commission и соответственно заполнить.
alter table employees
add column commission int;
UPDATE employees
SET commission = CASE 
    WHEN salary < 3000 THEN NULL
    WHEN salary < 6000 THEN 10
    WHEN salary < 9000 THEN 15
    ELSE 20
END;
select * from employees;

-- 7. Создать поле final_salary и заполнить формулой salary + salary * commission / 100. Проверить commission на null, 
-- так чтобы в случае неопределенности final_salary принимал значение salary. 
ALTER TABLE employees 
ADD COLUMN final_salary NUMERIC(10,2);
UPDATE employees
SET final_salary = salary + COALESCE(salary * commission / 100, 0);
select * from employees;

-- 8. Вывести поле email в нижнем регистре.
SELECT LOWER(email) AS email_lowercase 
FROM employees;
select * from employees;
-- 9. Создать новое поле chk_email типа varchar(128).
ALTER TABLE employees 
ADD COLUMN chk_email VARCHAR(128);
select * from employees;
-- 10. Заполнить поле chk_email. Если длина email меньше 3, значением chk_email будет 'Введите больше символов', 
-- если длина email больше/равно 3 и меньше 7,  значением chk_email будет
 -- 'Кол/во символов совпадает', если длина email больше/равно 7,  значением chk_email будет 'Введите меньше символов'
 UPDATE employees
SET chk_email = CASE 
    WHEN LENGTH(email) < 3 THEN 'Введите больше символов'
    WHEN LENGTH(email) >= 3 AND LENGTH(email) < 7 THEN 'Кол/во символов совпадает'
    ELSE 'Введите меньше символов'
END;
select * from employees;
use gt081024;
CREATE TABLE Staff1 (
    id INTEGER PRIMARY KEY AUTO_INCREMENT,
    firstname VARCHAR(64) NOT NULL,
    lastname VARCHAR(64) NOT NULL,
    position VARCHAR(128),
    age INTEGER,
    has_child CHAR(1),
    username VARCHAR(128)
  );
select * from staff1;
INSERT INTO Staff(firstname, lastname, position, age, has_child, username) VALUES 
        ('Anna'
        , 'Daniels'
        , 'Senior Teacher'
        , 22
        , 'N'
        , 'annakhach5'
        );
        
INSERT INTO Staff(firstname, lastname, position, age, has_child, username) VALUES 
        ('Tom'
        , 'Austin'
        , 'Junior Blogger'
        , 25
        , 'Y'
        , 'tom12345'
        );
INSERT INTO Staff(firstname, lastname, position, age, has_child, username) VALUES 
        ('Bill'
        , 'Lorentz'
        , 'Junior Web Developer'
        , 40
        , 'Y'
        , null
        );        
INSERT INTO Staff(firstname, lastname, position, age, has_child, username) VALUES 
        ('Lily'
        , 'May'
        , 'Junior Backend Developer'
        , 25
        , 'Y'
        , 'lil12'
        );
INSERT INTO Staff(firstname, lastname, position, age, has_child, username) VALUES 
        ('Nona'
        , 'Lucky'
        , 'Junior Teacher'
        , 20
        , 'N'
        , 'LuckyNona'
        ); 
INSERT INTO Staff(firstname, lastname, position, age, has_child, username) VALUES 
        ( 'Nancy'
        , 'Greenberg'
        , 'Middle UI Designer'
        , 32
        , 'Y'
        , 'nancy1'
        );        
INSERT INTO Staff(firstname, lastname, position, age, has_child, username) VALUES 
        ('Daniel'
        , 'Faviet'
        , 'Senior UX Designer'
        , 43
        , 'Y'
        , 'favietD'
        );        
INSERT INTO Staff(firstname, lastname, position, age, has_child, username) VALUES 
        ('Ally'
        , 'Austin'
        , 'Junior UI Designer'
        , 28
        , 'N'
        , 'ally1'
        );        
INSERT INTO Staff(firstname, lastname, position, age, has_child, username) VALUES 
        ('Lily'
        , 'Chen'
        , 'Senior Teacher'
        , 25
        , 'Y'
        , null
        );        
INSERT INTO Staff(firstname, lastname, position, age, has_child, username) VALUES 
        ('Anna'
        , 'Austin'
        , 'Middle Teacher'
        , 34
        , 'Y'
        , 'anna28'
        );        
INSERT INTO Staff(firstname, lastname, position, age, has_child, username) VALUES 
        ('Alexander'
        , 'Lorentz'
        , 'Junior Backend Developer'
        , 25
        , 'N'
        , 'alex12345'
        );        
INSERT INTO Staff(firstname, lastname, position, age, has_child, username) VALUES 
        ('Ashley'
        , 'Lorentz'
        , 'Junior UX Designer'
        , 18
        , 'N'
        , 'lorentz99'
        );        
INSERT INTO Staff(firstname, lastname, position, age, has_child, username) VALUES 
        ('Tom'
        , 'Lucky'
        , 'Middle Blogger'
        , 34
        , 'Y'
        , 'lucky78'
        );        
INSERT INTO Staff(firstname, lastname, position, age, has_child, username) VALUES 
        ('Ashley'
        , 'Weiss'
        , 'Junior Blogger'
        , 18
        , 'N'
        , 'weiss11'
        );
INSERT INTO Staff(firstname, lastname, position, age, has_child, username) VALUES 
        ('Tom'
        , 'Weiss'
        , 'Junior UI Designer'
        , 18
        , 'N'
        , 'tom222'
        );   
INSERT INTO Staff(firstname, lastname, position, age, has_child, username) VALUES 
        ('Anna'
        , 'Bloom'
        , 'Middle UX Designer'
        , 20
        , 'N'
        , 'bloom5'
        );   
INSERT INTO Staff(firstname, lastname, position, age, has_child, username) VALUES 
        ('Tom'
        , 'Berg'
        , 'Middle Teacher'
        , 34
        , 'N'
        , 'tommy1'
        );   
INSERT INTO Staff(firstname, lastname, position, age, has_child, username) VALUES 
        ('Ashley'
        , 'Berg'
        , 'Senior Teacher'
        , 37
        , 'N'
        , 'ash89'
        );
INSERT INTO Staff(firstname, lastname, position, age, has_child, username) VALUES 
        ('Lily'
        , 'Weiss'
        , 'Middle Blogger'
        , 45
        , 'N'
        , 'lilyW1'
        );   
INSERT INTO Staff(firstname, lastname, position, age, has_child, username) VALUES 
        ('Anna'
        , 'Lorentz'
        , 'Senior UX Designer'
        , 31
        , 'N'
        , null
        );   
INSERT INTO Staff(firstname, lastname, position, age, has_child, username) VALUES 
        ('Ashley'
        , 'Weiss'
        , 'Middle UX Designer'
        , 18
        , 'N'
        , 'weiss1'
        );       
INSERT INTO Staff(firstname, lastname, position, age, has_child, username) VALUES 
        ('Anna'
        , 'Keren'
        , 'Junior UX Designer'
        , 34
        , 'N'
        , 'annaK1'
        );  
        DROP TABLE Staff;
        CREATE TABLE Staff (
    id INTEGER PRIMARY KEY AUTO_INCREMENT,
    firstname VARCHAR(64) NOT NULL,
    lastname VARCHAR(64) NOT NULL,
    position VARCHAR(128),
    age INTEGER,
    has_child CHAR(1),
    username VARCHAR(128)
  );
  INSERT INTO Staff(firstname, lastname, position, age, has_child, username) VALUES 
        ('Anna', 'Daniels', 'Senior Teacher', 22, 'N', 'annakhach5');

INSERT INTO Staff(firstname, lastname, position, age, has_child, username) VALUES 
        ('Tom', 'Austin', 'Junior Blogger', 25, 'Y', 'tom12345');

INSERT INTO Staff(firstname, lastname, position, age, has_child, username) VALUES 
        ('Bill', 'Lorentz', 'Junior Web Developer', 40, 'Y', NULL);

INSERT INTO Staff(firstname, lastname, position, age, has_child, username) VALUES 
        ('Lily', 'May', 'Junior Backend Developer', 25, 'Y', 'lil12');

INSERT INTO Staff(firstname, lastname, position, age, has_child, username) VALUES 
        ('Nona', 'Lucky', 'Junior Teacher', 20, 'N', 'LuckyNona');

INSERT INTO Staff(firstname, lastname, position, age, has_child, username) VALUES 
        ('Nancy', 'Greenberg', 'Middle UI Designer', 32, 'Y', 'nancy1');

INSERT INTO Staff(firstname, lastname, position, age, has_child, username) VALUES 
        ('Daniel', 'Faviet', 'Senior UX Designer', 43, 'Y', 'favietD');

INSERT INTO Staff(firstname, lastname, position, age, has_child, username) VALUES 
        ('Ally', 'Austin', 'Junior UI Designer', 28, 'N', 'ally1');

INSERT INTO Staff(firstname, lastname, position, age, has_child, username) VALUES 
        ('Lily', 'Chen', 'Senior Teacher', 25, 'Y', NULL);

INSERT INTO Staff(firstname, lastname, position, age, has_child, username) VALUES 
        ('Anna', 'Austin', 'Middle Teacher', 34, 'Y', 'anna28');

INSERT INTO Staff(firstname, lastname, position, age, has_child, username) VALUES 
        ('Alexander', 'Lorentz', 'Junior Backend Developer', 25, 'N', 'alex12345');

INSERT INTO Staff(firstname, lastname, position, age, has_child, username) VALUES 
        ('Ashley', 'Lorentz', 'Junior UX Designer', 18, 'N', 'lorentz99');

INSERT INTO Staff(firstname, lastname, position, age, has_child, username) VALUES 
        ('Tom', 'Lucky', 'Middle Blogger', 34, 'Y', 'lucky78');

INSERT INTO Staff(firstname, lastname, position, age, has_child, username) VALUES 
        ('Ashley', 'Weiss', 'Junior Blogger', 18, 'N', 'weiss11');

INSERT INTO Staff(firstname, lastname, position, age, has_child, username) VALUES 
        ('Tom', 'Weiss', 'Junior UI Designer', 18, 'N', 'tom222');

INSERT INTO Staff(firstname, lastname, position, age, has_child, username) VALUES 
        ('Anna', 'Bloom', 'Middle UX Designer', 20, 'N', 'bloom5');

INSERT INTO Staff(firstname, lastname, position, age, has_child, username) VALUES 
        ('Tom', 'Berg', 'Middle Teacher', 34, 'N', 'tommy1');

INSERT INTO Staff(firstname, lastname, position, age, has_child, username) VALUES 
        ('Ashley', 'Berg', 'Senior Teacher', 37, 'N', 'ash89');

INSERT INTO Staff(firstname, lastname, position, age, has_child, username) VALUES 
        ('Lily', 'Weiss', 'Middle Blogger', 45, 'N', 'lilyW1');

INSERT INTO Staff(firstname, lastname, position, age, has_child, username) VALUES 
        ('Anna', 'Lorentz', 'Senior UX Designer', 31, 'N', NULL);

INSERT INTO Staff(firstname, lastname, position, age, has_child, username) VALUES 
        ('Ashley', 'Weiss', 'Middle UX Designer', 18, 'N', 'weiss1');

INSERT INTO Staff(firstname, lastname, position, age, has_child, username) VALUES 
        ('Anna', 'Keren', 'Junior UX Designer', 34, 'N', 'annaK1');
        select * from staff;
 -- 1. Создать новое поле experience_level и заполнить его значением:
ALTER TABLE Staff ADD COLUMN experience_level VARCHAR(10);
	-- 	'Junior', если возраст меньше 25 лет.
	-- 	'Middle', если возраст от 25 до 35 лет.
	-- 	'Senior', если возраст больше 35 лет.       
set sql_safe_updates = 0;
UPDATE Staff
SET experience_level = 
  CASE
    WHEN age < 25 THEN 'Junior'
    WHEN age BETWEEN 25 AND 35 THEN 'Middle'
    WHEN age > 35 THEN 'Senior'
  END;
  select * from staff;
-- 2. Создать новое поле family_status и заполнить его значением:
ALTER TABLE Staff ADD COLUMN family_status VARCHAR(20);
	-- 'Has children', если has_child равно 'Y'.
	-- 'No children', если has_child равно 'N'.
UPDATE Staff
SET family_status = 
  CASE
    WHEN has_child = 'Y' THEN 'Has children'
    WHEN has_child = 'N' THEN 'No children'
  END;
  select * from staff;
-- 3. Вывести фамилии всех сотрудников в верхнем регистре.
SELECT UPPER(lastname) AS upper_lastname FROM Staff;
-- 4. Вывести имена всех сотрудников в нижнем регистре.
SELECT LOWER(firstname) AS lower_firstname FROM Staff;
-- 5. Создать новое поле fullname и заполнить его объединением имени и фамилии (например, "Anna Daniels").
ALTER TABLE Staff ADD COLUMN fullname VARCHAR(150);
UPDATE Staff
SET fullname = CONCAT(firstname, ' ', lastname);
select * from staff;
-- 6. Вычислить длину имени каждого сотрудника и вывести как новое поле firstname_length.
SELECT firstname, LENGTH(firstname) AS firstname_length FROM Staff;
ALTER TABLE Staff ADD COLUMN firstname_length INT;
UPDATE Staff SET firstname_length = LENGTH(firstname);
select * from staff;
-- 7. Найти сотрудников, у которых длина фамилии больше 6 символов.
SELECT * FROM Staff
WHERE LENGTH(lastname) > 6;
-- 8. Создать новое поле child_bonus и заполнить его значением:
ALTER TABLE Staff ADD COLUMN child_bonus INT;
	-- 	500, если has_child равно 'Y'.
	-- 	0, если has_child равно 'N'.
UPDATE Staff
SET child_bonus = CASE 
    WHEN has_child = 'Y' THEN 500 
    WHEN has_child = 'N' THEN 0 
END;
select * from staff;
-- 9. Вывести возраст всех сотрудников, увеличенный на 5 лет.
SELECT firstname, lastname, age, age + 5 AS age_in_5_years FROM Staff;
-- 10.Создать новое поле salary_category и заполнить его значением:
ALTER TABLE Staff ADD COLUMN salary_category VARCHAR(10);
	-- 	'High', если возраст больше 30 и has_child равно 'Y'.
	-- 	'Medium', если возраст больше 30 и has_child равно 'N'.
	-- 	'Low' для остальных.
UPDATE Staff
SET salary_category = CASE 
    WHEN age > 30 AND has_child = 'Y' THEN 'High' 
    WHEN age > 30 AND has_child = 'N' THEN 'Medium' 
    ELSE 'Low' 
END;
select * from staff;
-- 11. Найти сотрудников, у которых в фамилии есть символ 's'.
SELECT * FROM Staff
WHERE lastname LIKE '%s%';
-- 12. Создать новое поле position_rank и заполнить его значением:
ALTER TABLE Staff ADD COLUMN position_rank VARCHAR(10);
	-- 	'Teacher', если должность содержит слово 'Teacher'.
	-- 	'Designer', если должность содержит слово 'Designer'.
	-- 	'Other' для остальных.
UPDATE Staff
SET position_rank = CASE 
    WHEN position LIKE '%Teacher%' THEN 'Teacher'
    WHEN position LIKE '%Designer%' THEN 'Designer'
    ELSE 'Other' 
END;
select * from staff;
-- 13. Найти сотрудников, чьи имена заканчиваются на 'y'.
SELECT * FROM Staff
WHERE firstname LIKE '%y';
-- 14. Найти сотрудников, у которых фамилии начинаются с 'A' или 'L'.
SELECT * FROM Staff
WHERE lastname LIKE 'A%' OR lastname LIKE 'L%';
-- 15. Создать новое поле username_default и заполнить его значением:
ALTER TABLE Staff ADD COLUMN username_default VARCHAR(128);
	-- 	username, если имя пользователя указано.
	-- 	'unknown', если имя пользователя не указано.
UPDATE Staff
SET username_default = CASE 
    WHEN username IS NOT NULL THEN username 
    ELSE 'unknown' 
END;
select * from staff;














        
        INSERT INTO Staff(firstname, lastname, position, age, has_child, username) VALUES          ('Bill', 'Lorentz', 'Junior Web Developer', 40, 'Y', NULL)
