#include "dateClass.hpp"

Date::Date(): day(1), month(1), year(0) {}

Date::Date(unsigned short day): month(1), year(0) 
{
	setDay(day);
}

Date::Date(unsigned short day, unsigned short month): year(0) 
{
	setDay(day);

	setMonth(month);
}

Date::Date(unsigned short day, unsigned short month, unsigned short year): 
{
	setDay(day);

	setMonth(month);

	setYear(year);
}
