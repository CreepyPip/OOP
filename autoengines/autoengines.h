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
    void setLevel(unsigned short newLevel);
    void setDisplacement(unsigned short newDisplacement);
    void setWeight(unsigned short newWeight);
    void setConsumption(unsigned short newConsumption);
    void setHP(unsigned short newHP);
    
    unsigned short getLevel() const;
    unsigned short getDisplacement() const;
    unsigned short getWeight() const;
    unsigned short getConsumption() const;
    unsigned short getHP() const;
    
    void refuel(unsigned short newLevel);
    void refuelFull();
    
    double maxDistance();
    double fuelDistance();
};

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

class electric: virtual public engine {
protected:
    string measureElectric = "kWh"; // Единицы измерения атареи
    unsigned short wear = 100;  // Износ батареи
    
public:
    electric();
    electric(unsigned short wear, unsigned short level, unsigned short displacement, unsigned short weight, unsigned short consumption, unsigned short horsepower);
    void setWear(unsigned short newWear);
    string getDisplacementString() const;
    string getLevelString() const;
    unsigned short getWear() const;
    void setLevel(unsigned short newLevel);
    void refuel(unsigned short newLevel);
    void refuelFull();
};

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
