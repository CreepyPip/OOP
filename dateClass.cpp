#include "dateClass.hpp"

// Основной контроллер с заданными данными
Date::Date(): day(1), month(1), year(0) {}


// Контроллер, пользователь может вводить день
Date::Date(unsigned short day): month(1), year(0) 
{
	setDay(day);
}

// Контроллер, пользователь может вводить день и месяц
Date::Date(unsigned short day, unsigned short month): year(0) 
{
	setMonth(month);
	setDay(day);
}

// Контроллер, пользователь может вводить день, месяц и год
Date::Date(unsigned short day, unsigned short month, unsigned short year) 
{

	setMonth(month);
	setYear(year);
	setDay(day);
}


// Выдаёт день (+1 выдаёт из-за того, что система начинает счёт от нуля)
unsigned short Date::getDay() const{
	return day + 1;
}

// Выдаёт месяц (+1 выдаёт из-за того, что система начинает счёт от нуля)
unsigned short Date::getMonth() const{
	return month + 1;
}

// Выдаёт год
unsigned short Date::getYear() const{
	return year;
}


// Выставляет день
// Принимает количество дней от пользователя
// -1 из-за того, что система начинает счёт от нуля
void Date::setDay(unsigned short newDay){
	
	if ((newDay <= 28) && month == 1 && !leapyear(year))
	{
		cout << month << leapyear(year) << endl;
		day = newDay - 1;
	}
	else if (month == 1 && leapyear(year) && (newDay <= 29))
	{
		day = newDay - 1;
	}
	else if ((month == 3 || month == 5 || month == 8 || month == 10) && (newDay <= 30))
	{
		day = newDay - 1;
	}
	else if ((month == 0 || month == 2 || month == 4 || month == 6 || month == 7 || month == 9 || month == 11) && newDay <= 31)
	{
		day = newDay - 1;
	}
	else
	{
    	day = -1;
	}
}

// Выставляет месяц
// Принимает количество месяцев от пользователя
void Date::setMonth(unsigned short newMonth){
	if (newMonth > 12 || newMonth < 0){
        month = -1;
	}
    else 
{
    month = newMonth - 1;
}
}

// Выставляет год
// Принимает количество лет от пользователя
void Date::setYear(unsigned short newYear){
	year = newYear;

}


// Добавляет заданное количество дней
// Принимает количество дней от пользователя
void Date::addDay(unsigned short newDay){
	if (month == 1 && !leapyear(year))
	{
		addMonth(((day + newDay) / 29));
		day = (day + newDay) % 29;
	}
	else if (month == 1 && leapyear(year))
	{
		addMonth(((day + newDay) / 28));
		day = (day + newDay) % 28;
	}
	else if (month == 3 || month == 5 || month == 8 || month == 10)
	{
		addMonth(((day + newDay) / 30));
		day = (day + newDay) % 30;
	}
	else
	{
		addMonth(((day + newDay) / 31));
		day = (day + newDay) % 31;
	}
	
}

// Добавляет заданное количество месяцев
// Принимает количество месяцев от пользователя
void Date::addMonth(unsigned short newMonth){
	addYear((month + newMonth) / 12);
	month = (month + newMonth) % 12;
}

// Добавляет заданное количество лет
// Принимает количество лет от пользователя
void Date::addYear(unsigned short newYear){
	year = (year + newYear);
}


// Выдаёт дату в текстовом формате
string Date::DateString() const{
	return format("{:02d}.{:02d}.{:04d}", day + 1, month + 1, year);
}