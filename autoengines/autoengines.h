//
//  autoengines.h
//  autoengines
//
//  Created by Семён on 21.02.2026.
//  Copyright © 2026 Семён. All rights reserved.
//

#pragma once
#include <stdio.h>
#include <string>
#include "format.h"

using namespace std;
using namespace my;

// Основной класс
// Даёт наследованным классам использовать методы, нет возможности использовать вне наследованных классов
// Есть возможность выставить (уровень топлива, объём бака, вес, расход, силы), заправить и высчитать расстояние на уровне топлива
class engine {

public:
    // Переменные, которые используются только в классе
    unsigned short level; // Уровень топлива или заряда
    unsigned short displacement;    // Объём бака
    unsigned short weight;  // Вес двигателя
    unsigned short consumption; // Расход
    unsigned short horsepower; // Лошадиные силы
  
protected:
    engine();
    engine(unsigned short level, unsigned short displacement, unsigned short weight, unsigned short consumption, unsigned short horsepower);
public:
    // virtual нужно для того, чтобы метод переопределялся в подклассах
    // Полиморфизм способность объектов с одинаковыми методами реализовывать различное поведение
    virtual void setLevel(unsigned short newLevel);
    void setDisplacement(unsigned short newDisplacement);
    void setWeight(unsigned short newWeight);
    void setConsumption(unsigned short newConsumption);
    void setHP(unsigned short newHP);
    
    unsigned short getLevel() const;
    unsigned short getDisplacement() const;
    unsigned short getWeight() const;
    unsigned short getConsumption() const;
    unsigned short getHP() const;
    
    virtual void refuel(unsigned short newLevel);
    virtual void refuelFull();
    
    double maxDistance();
    double fuelDistance();
};

// Класс (Двигатель внутреннего сгорания)
// Добавляет методы (выставить кол-во цилиндров) и получения уровня топлива и объёма бака с единицами измерения
class ICE: virtual public engine {
protected:
    unsigned short cylinders;
    string measureGasoline = "liters";
    
public:
    ICE();
    ICE(unsigned short cylinders, unsigned short level, unsigned short displacement, unsigned short weight, unsigned short consumption, unsigned short horsepower);
    string getDisplacementString() const;
    string getLevelString() const;
    void setCylinders(unsigned short newCylinders);
    unsigned short getCylinders() const;
};

// Класс (Электродвигатель)
// Добавляет методы (выставить износ батареи) и получения уровня заряда и объёма батареи с единицами измерения с учётом износа
// Переиспользует методы (refuel и setLevel)
class electric: virtual public engine {
protected:
    string measureElectric = "kWh"; // Единицы измерения батареи
    unsigned short wear = 100;  // Износ батареи
    
public:
    electric();
    electric(unsigned short wear, unsigned short level, unsigned short displacement, unsigned short weight, unsigned short consumption, unsigned short horsepower);
    void setWear(unsigned short newWear);
    string getDisplacementString() const;
    string getLevelString() const;
    unsigned short getWear() const;
    void setLevel(unsigned short newLevel) override;
    void refuel(unsigned short newLevel) override;
    void refuelFull() override;
};

// Наследует классы ICE и electric
// Также может использоваться с методами engines
// Появляются методы связанные с типами гибрида
class hybrid: public ICE, public electric {
private:
    string type;
    string measureElectric = "kWh";
    string measureGasoline = "liters";

    
public:
    hybrid();
    hybrid(string type);
    hybrid(unsigned short cylinders, string type, unsigned short wear, unsigned short level, unsigned short displacement, unsigned short weight, unsigned short consumption, unsigned short horsepower);
    void setType(string type);
    void setCylinders(unsigned short cylinders);
    unsigned short getCylinders() const;
    string getDisplacementString() const;
    string getLevelString() const;
    string getType() const;
};
