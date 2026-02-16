#pragma once // Перенос модулей в программу обращающуюся к этому модулю
#include <cstdlib>
#include <iostream> // Основной модуль C++
#include <format>
#include <cmath> // Для sqrt, abs
#include <cassert> // для assert
#include <cfloat> // Для FLT_EPSILON
#include <fstream> // Для работы с файлами
#include <stdexcept>
#include <vector>

using namespace std; // std нужно для cout, cin

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

namespace ns
{
//Случайный ввод значений массива
double* RandomMas(int n)
{

	vector<double> a(n);

	for(int i = 0; i < n; i++)
	{
		a[i] = (rand() % 1000 - 1000)/10;
	}
	return &a.data();
}

//Ввод значений массива из файла
double* FileMas(int n)
{

	ifstream F("f136.txt");

	F >> n;
	double *a = new double[n];

    	for (int i = 0; i < n; i++) {
    	    F >> a[i];
    	}
    
    	F.close();
    
	return a;
}

//Ввод значений массива в файл
void FileMasIn(int n, vector<double> vec(a))
{
	ofstream F("f136.txt");
    
    for (int i = 0; i < n; i++) {
        F << a[i] << " ";
    }
    
    F.close();
    cout << ("Данные введены в файл");
}

//Ввод значений массива
double* InMas(int n)
{

	vector<double> a(n);

	for (int i = 0;i<n;i++)
	{
		cout <<format("Введите значение")<<endl;	
		cin >> a[i];
	}

	return &a.data();
}

//Вывод каждого значения массива
void OutMas(int n, vector<double> vec(a))
{

	cout <<("Значения:")<< endl;
	for (int i = 0;i<n;i++)
	{
		cout <<(i+1);	
		cout <<format(" - '{:.1f}'; ", a[i]);	
	}

}

//Вывод итогового ответа
float ResMas(int n, vector<double> vec(a))
{
	float sum = 0;
	for (int i = 0;i<n;i++)
	{
		sum = sum + a[i];
	}

	return sin(abs(sum*(M_PI/180))); // Перевод из радиан в градусы
}}