// Из коллекции fruits вывести документы, где название Apple.
db.fruits.find({title: {$eq: 'Apple'}})
db.fruits.find({title: 'Apple'})
// Из коллекции fruits вывести документы, где стоимость 200.
db.fruits.find({price: 200})
db.fruits.find({price: {$eq: 200}})
// Из коллекции fruits вывести документы, где стоимость не 200.
db.fruits.find({price: {$ne: 200}})
// Из коллекции fruits вывести документы, где кол/во больше 5.
db.fruits.find({count: {$gt: 5}})
// Из коллекции fruits вывести документы, где кол/во больше равно 8.
db.fruits.find({count: {$gte: 8}})
// Из коллекции fruits вывести документы, где стоимость меньше 500.
db.fruits.find({price: {$lt: 500}})
// Из коллекции fruits вывести документы, где кол/во меньше равно 4.
db.fruits.find({count: {$lte: 4}})
// Из коллекции fruits вывести документы, где название Apple или Lime или Kiwi.
db.fruits.find({title: {$in: ['Apple', 'Lime', 'Kiwi']}})
// Из коллекции fruits вывести документы, где название не 'Lemon'.
db.fruits.find({title: {$ne: 'Lemon'}})
// Из коллекции fruits вывести документы, где кол/во или 3, или 8.
db.fruits.find({count: {$in: [3, 8]}})


// Пример документа
{
    id: 1,
    first_name: 'Ben',
    last_name: 'Jameson',
    skills: ['Teamworking', 'Creativity', 'Leadership'],
    date_of_hire: '28.05.2014',
    address: {
        country: 'Armenia',
        city: 'Yerevan',
        street: 'Stepanyan',
        building: 5
    }
}

// TASKS

// 1. В базе данных tasks создать пустую коллекцию employees.
use tasks

// Создание коллекции
// db.createCollection('collection_name')
db.createCollection('employees')

// 2. Заполнить коллекцию свойствами id, firstname, lastname, age, position, salary, skills.
    // 1. Inga Petrova, 27, Barista, 1500, ['preparing drinks', 'cleaning equipment'] 
    // 2. Boris Orlov, 36, Server, 2400, ['taking orders', 'suggesting meals', 'taking payments']
    // 3. Ivan Demidov, 32, Chef, 3200, ['preparing food', 'baking bread']
    // 4. Marina Sidorova, 22, Hostess, 1700, ['greeting guests', 'seating guests', 'answering phone calls']
    // 5. Olga Ivanova, 43, Sommelier, 2500, ['curating a wine list', 'creating wine pairings']
    db.employees.insertMany([
    {
        id: 1,
        firstname: 'Inga',
        lastname: 'Petrova',
        age: 27,
        position: "Barista",
        salary: 1500,
        skills: ['preparing drinks', 'cleaning equipment']
    },
    {
        id: 2,
        firstname: 'Boris',
        lastname: 'Orlov',
        age: 36,
        position: "Server",
        salary: 2400,
        skills: ['taking orders', 'suggesting meals', 'taking payments']
    },
    {
        id: 3,
        firstname: 'Ivan',
        lastname: 'Demidov',
        age: 32,
        position: "Chef",
        salary: 3200,
        skills: ['preparing food', 'baking bread']
    },
    {
        id: 4,
        firstname: 'Marina',
        lastname: 'Sidorova',
        age: 22,
        position: "Hostess",
        salary: 1700,
        skills: ['greeting guests', 'seating guests', 'answering phone call']
    },
    {
        id: 5,
        firstname: 'Olga',
        lastname: 'Ivanova',
        age: 43,
        position: "Sommelier",
        salary: 2500,
        skills: ['curating a wine list', 'creating wine pairings']
    }
])


// 3. Вывести коллекцию employees.
//show collections

db.employees.find()

// 4. Найти и исправить ошибку в коде:
 db.employee.insertOne(
    {
          id: 1,
          firstname: 'Lida',
          lastname: 'Petrova',
          age: 27,
          salary: 1500,
          skills: ['coding', 'team-working']
        }
    ) 

// 5. Найти и исправить ошибку в коде:
 db.employee.insertMany([
    {     id: 1,
          firstname: 'Lida',
          lastname: 'Petrova',
          age: 27,
          salary: 1500,
          skills: ['coding', 'team-working']
        }
    ])

// 6. Найти и исправить ошибки в коде:
db.students.insertMany([
	{
	     id: 1,
	     name: 'Amy',
	     avg_mark: 5		
	},
	{
	     id: 2,
	     name: 'Sam',
	     avg_mark: 3		
	},
	{
	     id: 3,
	     name: 'Ben',
	     avg_mark: 4.7		
	},
	{
	     id: 4,
	     name: 'Max',
	     avg_mark: 2		
	}
])

// 7. Создать бд shop
use shop

// 8. Создать коллекцию products1 и заполнить документами (6 штук) со следующими свойствами (id, title, price, count). Используйте следующие данные
  // 1 Велосипед 45000 12
  // 2 Самокат 1500 10
  // 3 Ролики 2000 20
  // 4 Лыжи 22000 15
  // 5 Скейт 19000 4
  // 6 Сноуборд 33000 17
  db.products1.insertMany([
	{
	     id: 1,
	     title: 'Велосипед',
	     price: 45000,
         count: 12		
	},
	{
	     id: 2,
	     name: 'Самокат',
	     price: 1500,
         count: 10		
	},
	{
	     id: 3,
	     name: 'Ролики',
	     price: 2000,
         count: 20		
	},
	{
	     id: 4,
	     name: 'Лыжи',
	     price: 19000,
         count: 15		
	},
    {
	     id: 5,
	     name: 'Скейт',
	     price: 19000,
         count: 4		
	},
    {
	     id: 6,
	     name: 'Сноуборд',
	     price: 33000,
         count: 17		
	}
])


// 9. Удалить коллекцию products1
db.products1.drop()

// 10. Удалить бд shop
db.dropDatabase()


// 1. Создать базу данных homeworks.
use homeworks
// 2. В базе данных homeworks создать коллекцию workers и заполнить документами со следующими свойствами: id, firstname, lastname, position, salary. 
// Используйте следующие данные:	
// 1 Петр Сергеев CEO 7000
// 2 Виктор Семенов Web-developer 5000
// 3 Никита Петров Assistant 3500
// 4 Инна Орлова Accountant 4500
db.workers.insertMany([
    {
        id: 1,
        firstname: 'Петр',
        lastname: 'Сергеев',
        position: 'CEO',
        salary: 7000
    },
    {
        id: 2,
        firstname: 'Виктор',
        lastname: 'Семенов',
        position: 'Web-developer',
        salary: 5000
    },
    {
        id: 3,
        firstname: 'Никита',
        lastname: 'Петров',
        position: 'Assistant',
        salary: 3500
    },
    {
        id: 4,
        firstname: 'Инна',
        lastname: 'Орлова',
        position: 'Accountant',
        salary: 4500
    }
])
// 3. Из коллекции workers вывести все документы.
db.workers.find()
// 4. Из коллекции workers вывести документы, где зарплата выше 4000.
db.workers.find({salary: {$gt: 4000}})
// 5. Из коллекции workers вывести документы, где имя сотрудника либо Иван, либо Инна, либо Петр.
db.workers.find({firstname: {$in: ['Иван', 'Инна', 'Петр']}})
// 6. Из коллекции workers вывести документы, где зарплата не равна 7000.
db.workers.find({salary: {$ne: 7000}})
// 7. Из коллекции workers вывести документы, где id меньше 3.
db.workers.find({id: {$lt: 3}})
// 8. Удалить коллекцию workers.
db.workers.drop()
// 9. Удалить базу данных homeworks.
db.dropDatabase()
// 10. Вывести все базы данных.
show databases

