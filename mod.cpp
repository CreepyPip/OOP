#pragma once // Перенос модулей в программу обращающуюся к этому модулю
#include <cstdlib> // Модуль основных функций из C
#include <iostream> // Основной модуль C++
#include <format>
#include <cmath> // Для sqrt, abs
#include <cassert> // для assert
#include <cfloat> // Для FLT_EPSILON
#include <fstream> // Для работы с файлами
#include <stdexcept> // Для обработки ошибок
#include <vector>
#include <string> 
#include <cstdbool>

using namespace std; // std нужно для cout, cin

namespace mean
{
// Среднее арифметическое
float AritMean (float a, float b)
{
	float res1=0;
	res1 = (a + b)/2;

return res1;
}

// Среднее геометрическое
float GeomMean (float a, float b)
{
	float res2=0;
	res2 = sqrt(abs(a) + abs(b));

return res2;
}
}

namespace FileSpace{
//Взятие количества значений из файла
/*
Принимает наименование файла sf
Берёт первое значение из заданного пользователем файла (F >> n)
*/
int nFile(const string &sf)
{

	int n;

        ifstream F(sf);
        F >> n;
        
        if (n <= 0) {
            throw invalid_argument("Количество элементов должно быть больше 0");
        }
        
        F.close();
    
    
	return n;
}

//Заполнение массива из файла
/*
Принимает наименование файла sf
Первое значение из заданного пользователем файла 
отвечает за количество значений,
выводится в прошлой функции(nFile).
Следующие значения вводятся в массив через цикл
*/
double* FileMas(const string &sf)
{

	ifstream F(sf);

	int n = nFile(sf);
	F >> n;			// передать n по ссылке
	double *a = new double[n];

    	for (int i = 0; i < n; i++) {
    	    F >> a[i];
    	}
    
    	F.close();
    
	return a;
}

//Заполнение массива в файл
/*
Принимает количество значений n, массив a, и наименование файла sf
Первым вводится n, как количество значений в массиве(F<<n<<' ')
Дальше через пробел значения из массива вводятся 
в заданный пользователем файл (F<<a[i]<<' ')
*/
template<typename fid>
void FileMasIn(int n, fid *a, const string &sf)
{
	ofstream F(sf);
    
    F << n << " ";
    for (int i = 0; i < n; i++) {
        F << a[i] << " ";
    }
    
    F.close();
    cout << ("Данные введены в файл");
}
}

namespace UserMas{
//Случайное заполнение массива
/*
Принимает только количество значений
Выводит случайные числа в заданном диапазоне
*/
double* RandomMas(int n)
{

	int l = 0, m = 0;
	double *a = new double[n];

	cout <<"Введите диапазон генерации"<<endl;
	cout <<"Минимальное: ";
	cin >> l;
	cout <<"Максимальное: ";
	cin >> m;

	for(int i = 0; i < n; i++)
	{
		// a[i] = l + (m-l) * rand()* 1.0 / RAND_MAX + 1.0;
		a[i] = l + rand() % (m-l);
	}
	return a;
}

//Заполнение массива
/*
Функция заполненяет массив через цикл, принимая количество значений n
*/
double* InMas(int n)
{

	double *a = new double[n];

	for (int i = 0;i<n;i++)
	{
		cout <<format("Введите значение")<<endl;	
		cin >> a[i];
	}

	return a;
}

//Вывод каждого значения массива
/*
Процедура выводит каждое значение, принимая количество значений n и массив a
*/
template<typename fid>
void OutMas(int n, fid *a)
{

	cout <<("Значения:")<< endl;
	for (int i = 0;i<n;i++)
	{
		cout <<(i+1);	
		cout <<format(" - '{:.1f}'; ", a[i]) << endl;	
	}

}

//Вывод итогового ответа
/*
Функция принимает количество значений n и массив a
Цикл только складывает значения массива
return выдаёт полный ответ возводя число в модуль и синус
*/
template<typename fid>
float ResMas(int n, fid *a)
{
	float sum = 0;
	for (int i = 0;i<n;i++)
	{
		sum = sum + a[i];
	}

	return sin(abs(sum*(M_PI/180))); // Перевод из радиан в градусы
}

template<typename fid>
bool leapyear(fid y)
{
	if (y % 4 || y = 0)
	{
		return 1;
	}
	else
	{
		return 0;
	}
}

}
