create database company_db;
use company_db;
create table employees(
	id INT PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR(50) NOT NULL,
	position VARCHAR(50) NOT NULL,
	salary DECIMAL(10,2) CHECK(salary > 0),
	hire_date VARCHAR(10) NOT NULL
    );
    alter table employees
    add column email varchar(128);
    
    select * from employees;
    
    alter table employees
    drop column hire_date;
    
    alter table employees
    rename column position to job_title;
    
    alter table employees
    modify column salary INTEGER not null;
    
    alter table employees
    add column department varchar(128) after job_title;
    
    insert into employees(name, job_title, department, salary, email)
    values ('Анна Иванова', 'Менеджер', 'Отдел продаж', 60000, 'anna.ivanova@example.ru'),
    ('Иван Смирнов', 'Разработчик', 'IT', 75000, 'ivan.smirnov@example.com'),
    ('Мария Петрова', 'Бухгалтер', 'Финансы', 50000, 'maria.petrova@example.com'),
	('Петр Васильев', 'Разработчик', 'IT', 80000, 'petr.vasiliev@example.ru'),
	('Екатерина Соколова', 'HR-специалист', 'HR', 55000, 'ekaterina.sokolova@example.com'),
	('Алексей Кузнецов', 'Менеджер по продажам', 'Отдел продаж', 65000, 'alexey.kuznetsov@example.ge'),
	('Ольга Морозова', 'Аналитик', 'Финансы', 70000, 'olga.morozova@example.com');
     select * from employees;
    
    select * from employees where department in ('IT', 'Финансы');
    select * from employees where name like ("% С%");
    select * from employees where email like ("%@example.com");
    select * from employees where salary between 60000 AND 75000;
    select * from employees where job_title LIKE '%Менеджер%';
    select * from employees where department != 'HR';
    select * from employees where salary > 70000 OR department = 'Финансы';
    select * from employees where email LIKE '%.ru' OR email LIKE '%.ge';
    select * from employees where name LIKE '% %ов%' OR name LIKE '% %ев%';
    select * from employees where salary < 55000 AND department != 'IT';
    select * from employees ORDER BY name ASC;
    select * from employees ORDER BY salary DESC;
    SELECT * FROM employees WHERE department IN ('IT', 'Финансы') ORDER BY salary DESC;
    SELECT * FROM employees WHERE salary > 60000 ORDER BY name ASC;
    SELECT DISTINCT department FROM employees;
    SELECT DISTINCT job_title FROM employees;
    DROP TABLE employees;
    