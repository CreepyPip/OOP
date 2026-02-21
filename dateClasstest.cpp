#include "dateClass.cpp"

int main()
{
	double n = 0;
	double d, m, y;

	cout << "День: ";
	cin >> d;
	cout << "Месяц: ";
	cin >> m;
	cout << "Год: ";
	cin >> y;

	Date d1(20, 2, 2026);

	d1.setDay(d);
	d1.setMonth(m);
	d1.setYear(y);	

	cout << d1.DateString() << endl;

	cout << "День: ";
	cin >> d;
	cout << "Месяц: ";
	cin >> m;
	cout << "Год: ";
	cin >> y;

	d1.addDay(d);
	d1.addMonth(m);
	d1.addYear(y);

	cout << "День: " << d1.getDay() << endl;
	cout << "Месяц: " << d1.getMonth() << endl;
	cout << "Год: " << d1.getYear() << endl;
}