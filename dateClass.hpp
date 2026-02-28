#include "mod.cpp"

class Date
{
	// Переменные (можно использовать только внутри класса)
	unsigned short day;	// unsigned short - тип данных, хранит только целые положительные числа

    unsigned short month;

    unsigned short year;

// Методы, которые можно использовать вне класса
public:

	Date();

	Date(unsigned short day);

	Date(unsigned short day, unsigned short month);

	Date(unsigned short day, unsigned short month, unsigned short year);
	
	unsigned short getDay() const;
	unsigned short getMonth() const;
	unsigned short getYear() const;

	void setDay(unsigned short newDay);
	void setMonth(unsigned short newMonth);
	void setYear(unsigned short newYear);

	void addDay(unsigned short newDay);
	void addMonth(unsigned short newMonth);
	void addYear(unsigned short newYear);
	
	string DateString() const;

};