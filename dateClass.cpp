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

Date::Date(unsigned short day, unsigned short month, unsigned short year) 
{
	setDay(day);

	setMonth(month);

	setYear(year);
}

unsigned short Date::getDay() const{
	return day + 1;
}

unsigned short Date::getMonth() const{
	return month + 1;
}

unsigned short Date::getYear() const{
	return year;
}

void Date::setDay(unsigned short newDay){
	if (newDay > 31 || newDay < 1)
        throw invalid_argument("1 <= newDay <= 31");
    day = newDay - 1;
}

void Date::setMonth(unsigned short newMonth){
	if (newMonth > 12 || newMonth < 1)
        throw invalid_argument("1 <= newMonth <= 12");
    month = newMonth - 1;
}

void Date::setYear(unsigned short newYear){
	year = newYear;

}

void Date::addDay(unsigned short newDay){
	if (month == 2 && !leapyear(year))
	{
		addMonth(((day + newDay) / 29));
		day = (day + newDay) % 29;
	}
	else if (month == 2 && leapyear(year))
	{
		addMonth(((day + newDay) / 28));
		day = (day + newDay) % 28;
	}
	else if (month == 4 || month == 6 || month == 9 || month == 11)
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

void Date::addMonth(unsigned short newMonth){
	addYear((month + newMonth) / 12);
	month = (month + newMonth) % 12;
}

void Date::addYear(unsigned short newYear){
	year = (year + newYear);
}

string Date::DateString() const{
	return format("{:02d}.{:02d}.{:02d}", day + 1, month + 1, year);
}