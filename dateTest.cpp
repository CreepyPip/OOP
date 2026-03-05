#include "dateClass.cpp"
#include <cassert>

void Tests() {
	Date dt(12, 10, 2000);
    
    dt.addDay(321);
    dt.addMonth(12);
    dt.addYear(123);
    
    unsigned short d = dt.getDay();
    unsigned short m = dt.getMonth();
    unsigned short y = dt.getYear();
    
    assert(d == 23);
    assert(m == 8);
    assert(y == 2125);

    dt.setMonth(2);
    dt.setYear(2001);
    dt.setDay(29);

    d = dt.getDay();

    assert(d == 0);
}