#include "mod.cpp"

//Зайцев Семён
/*Даны два действительных числа. Найти среднее арифметическое этих чисел и среднее геометрическое их модулей.*/

using namespace std; // std нужно для cout, cin
using namespace mean;

int main()
{
	float a = 0, b = 0, res1 = 0, res2 = 0;

	// Проверка функции AritMean
    assert(fabs(AritMean(4,6) - 5) < FLT_EPSILON); // assert - проверка работы функции
    assert(fabs(AritMean(3,7) - 5) < FLT_EPSILON);
    assert(fabs(AritMean(2,12) - 7) < FLT_EPSILON);

	// Проверка функции GeomMean
    assert(fabs(GeomMean(3,6) - 3) < FLT_EPSILON);
    assert(fabs(GeomMean(7,9) - 4) < FLT_EPSILON);
    assert(fabs(GeomMean(1,3) - 2) < FLT_EPSILON);

	// cout - ввод, cin - вывод и перенос на следующую строку
    cout << "Введите первое значение" << endl; // endl - перенос на следующую строку
    cin >> a;

    cout << "Введите второе значение" << endl;
    cin >> b;
    
    res1 = AritMean (a, b); // Среднее арифметическое
    cout << format("Среднее арифметическое = {:.3f}", res1) << endl;

    res2 = GeomMean (a, b); // Среднее геометрическое
    cout << format("Среднее геометрическое = {:.3f}", res2) << endl;

	return 0;
}