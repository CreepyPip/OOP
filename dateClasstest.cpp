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
    cout << ("Данные введены в файл") << endl;


    // Создание динамического объекта
    Date* dynamic = new Date(12, 11, 2011);

    // Проверка работы динамического объекта
    dynamic -> addDay(12);
    cout << "День: " << dynamic -> getDay() << endl;

    delete dynamic;


    // Создание массива статических объектов
    Date dm[3] = {
    	Date(12, 12, 2012),
    	Date(29, 02, 2016),
    	Date(13, 03, 2026),
    };

    for (int i = 0; i < 3; ++i)
    {
    	cout << "День: " << dm[i].getDay() << endl;
    };


    // Создание массива динамических объектов
    Date* ddm[3];
    	ddm[0] = new Date(13, 03, 2026);
    	ddm[1] = new Date(29, 02, 2016);
    	ddm[2] = new Date(12, 12, 2012);

    for (int i = 0; i < 3; ++i)
    {
    	cout << "Mecяц: " << ddm[i] -> getMonth() << endl;
    	delete ddm[i];
    };
}