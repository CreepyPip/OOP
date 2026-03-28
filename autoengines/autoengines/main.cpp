//
//  main.cpp
//  autoengines
//
//  Created by Семён on 21.02.2026.
//  Copyright © 2026 Семён. All rights reserved.
//

#include <iostream>
#include "autoengines.h"

using namespace std;

int main() {
    
    double a = 31;
    double b = 66;
    
    // Создаю объекты 3 классов
    ICE i1(4, 1, 30 , 1100, 5, 98);     // Задаю кол-во цилиндров, уровень топлива, объём бака, вес, расход и мощность
    electric e1(89, 1, 31, 1900, 2, 102);   // Задаю износ, уровень заряда, объём батареи, вес, расход и мощность
    hybrid h1("parallel");  // Задаю тип гибрида
    
    // Выставляю объём гибрида
    h1.setDisplacement(a);
    
    // Выставляю объём батареи для электроавто
    e1.setDisplacement(54);
    
    // Выставляю износ батареи для гибрида
    h1.setWear(77);
    
    // Заряжаю батарею на электроавто
    e1.refuel(b);
    
    // Полностью заправляю ДВС
    i1.refuelFull();
    
    // Вывод на экран уровень топлива
    cout << i1.getLevelString() << endl;
    
    // Вывод на экран уровень заряда электроавто и объём бака и батареи гибрида
    cout << e1.getLevelString() << endl << h1.getDisplacementString() << endl;
    
    // Вывод на экран типа гибрида и объём батареи электроавто
    cout << h1.getType() << endl << e1.getDisplacementString() << endl;
}
