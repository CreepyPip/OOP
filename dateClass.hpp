#include "mod.cpp"

class Date
{
	unsigned short day;

    unsigned short month;

    unsigned short year;

public:

	Date();

	Date(unsigned short day);

	Date(unsigned short day, unsigned short month);

	Date(unsigned short day, unsigned short month, unsigned short year);
	
	unsigned short getDay() const;
	unsigned short getMonth() const;
	unsigned short getYear() const;

	void Date::setDay(unsigned short newDay);
	void Date::setMonth(unsigned short newMonth);
	void Date::setYear(unsigned short newYear);

	

};