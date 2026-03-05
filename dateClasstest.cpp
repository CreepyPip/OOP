//#include "dateClass.cpp"
#include "dateTest.cpp"

// Файл для проверки работы класса

int main()
{

	Tests();

	double n = 0;
	double d, m, y;

	Date d1(1, 1, 0);

	ifstream Fin("date.txt");

	Fin >> d;	
	Fin >> m;	
	Fin >> y;
    Fin.close();

	cout << d1.DateString() << endl;

	// Ввод данных для начальных значений
	cout << "День: ";
	cin >> d;
	cout << "Месяц: ";
	cin >> m;
	cout << "Год: ";
	cin >> y;

	// Присваиваем введённые данные
	d1.setMonth(m);
	d1.setYear(y);	
	d1.setDay(d);

	// Вывод на экран всей даты
	cout << d1.DateString() << endl;

	// Ввод даных для добавления
	cout << "День: ";
	cin >> d;
	cout << "Месяц: ";
	cin >> m;
	cout << "Год: ";
	cin >> y;

	// Добавление к существующей дате
	d1.addDay(d);
	d1.addMonth(m);
	d1.addYear(y);

	// Вывод на экран отдельно каждого элемента
	cout << "День: " << d1.getDay() << endl;
	cout << "Месяц: " << d1.getMonth() << endl;
	cout << "Год: " << d1.getYear() << endl;

	ofstream Fout("date.txt");
    
    Fout << d1.getDay() << endl;
    Fout << d1.getMonth() << endl;
    Fout << d1.getYear() << endl;
    Fout.close();
    cout << ("Данные введены в файл");
}