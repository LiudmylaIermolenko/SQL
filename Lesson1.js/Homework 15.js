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