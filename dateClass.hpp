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
	
	unsigned short setDay() const;
	unsigned short setMonth() const;
	unsigned short setYear() const;

};