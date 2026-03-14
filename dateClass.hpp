#include "mod.cpp"


// Класс даты
// Выводит дату, есть возможность выставить, добавить количество дней (месяцев, лет) к текущей дате
class Date
{
	// Переменные (можно использовать только внутри класса)
	unsigned short day;	// unsigned short - тип данных, хранит только целые положительные числа

    unsigned short month;

    unsigned short year;

// Методы, которые можно использовать вне класса
public:

	// Основной конструктор с заданными данными
	Date();	

	// Конструктор, пользователь может вводить день
	Date(unsigned short day);

	// Конструктор, пользователь может вводить день и месяц
	Date(unsigned short day, unsigned short month);

	// Конструктор, пользователь может вводить день, месяц и год
	Date(unsigned short day, unsigned short month, unsigned short year);
	
	// Геттеры
	unsigned short getDay() const;
	unsigned short getMonth() const;
	unsigned short getYear() const;

	// Сеттеры
	void setDay(unsigned short newDay);
	void setMonth(unsigned short newMonth);
	void setYear(unsigned short newYear);

	// Добавление к дате
	void addDay(unsigned short newDay);
	void addMonth(unsigned short newMonth);
	void addYear(unsigned short newYear);
	
	// Выдаёт дату в текстовом формате
	string DateString() const;

};