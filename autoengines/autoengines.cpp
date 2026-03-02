//
//  autoengines.cpp
//  autoengines
//
//  Created by Семён on 21.02.2026.
//  Copyright © 2026 Семён. All rights reserved.
//

#include "autoengines.h"

// Конструктор с заданными по умолчанию данными
engines::engines(): level(0), displacement(1), weight(1), consumption(1), horsepower(1) {}

// Конструктор, пользователь вводит все данные
engines::engines(unsigned short level, unsigned short displacement, unsigned short weight, unsigned short consumption, unsigned short horsepower){
    setLevel(level);
    setDisplacement(displacement);
    setWeight(weight);
    setConsumption(consumption);
    setHP(horsepower);
}

// Геттеры
unsigned short engines::getLevel() const {  // Топливо
    return level;
}
unsigned short engines::getDisplacement() const {   // Объём бака
    return displacement;
}
unsigned short engines::getWeight() const { // Вес
    return weight;
}
unsigned short engines::getHP() const { // Лошадинные силы
    return horsepower;
}
unsigned short engines::getConsumption() const {    // Расход
    return consumption;
}

// Сеттеры
void engines::setLevel(unsigned short newLevel){
    if (newLevel <= displacement) {
        level = newLevel;
    }
}

void engines::setDisplacement(unsigned short newDisplacement){
    displacement = newDisplacement;
}

void engines::setWeight(unsigned short newWeight){
    weight = newWeight;
}

void engines::setHP(unsigned short newHP){
    horsepower = newHP;
}

void engines::setConsumption(unsigned short newConsumption){
    consumption = newConsumption;
}

// Пользователь добавляет уровень топлива(заряда)
void engines::refuel(unsigned short newLevel){
    if (level + newLevel <= displacement) {
        level = level + newLevel;
    } else
    {
        level = displacement;
    }
}

// Заполняет уровень топлива до максимума (до объёма бака)
void engines::refuelFull(){
    level = displacement;
}

// Отдаёт пробег на полном баке
double engines::maxDistance(){
    return displacement * consumption;
};

// Отдаёт пробег при заданном количестве топлива
double engines::fuelDistance(){
    return level * consumption;
};

// Контроллер ДВС, выдаёт заданное по умолчанию количество цилиндров
ICE::ICE(): cylinders(1){};

// Контроллер ДВС, выдаёт введённое пользователем количество цилиндров
ICE::ICE(unsigned short cylinders, unsigned short level, unsigned short displacement, unsigned short weight, unsigned short consumption, unsigned short horsepower){
    setCylinders(cylinders);
    setLevel(level);
    setDisplacement(displacement);
    setWeight(weight);
    setConsumption(consumption);
    setHP(horsepower);
}

// Выдаёт объём бака в виде текста с единицей измерения
string ICE::getDisplacementString() const {
    return to_string(displacement) + " " + measureGasoline;
}

// Выдаёт количество топлива в виде текста с единицей измерения
string ICE::getLevelString() const {
    return to_string(level) + " " + measureGasoline;
}

// Выставляет количество цилиндров
void ICE::setCylinders(unsigned short newCylinders){
    cylinders = newCylinders;
}

// Выдаёт количество цилиндров
unsigned short ICE::getCylinders() const{
    return cylinders;
}

// Контроллер электродвигателя, вводит введённое пользователем данные из engine
electric::electric(unsigned short level, unsigned short displacement, unsigned short weight, unsigned short consumption, unsigned short horsepower){
    setLevel(level);
    setDisplacement(displacement);
    setWeight(weight);
    setConsumption(consumption);
    setHP(horsepower);
}

// Выдаёт объём батареи в виде текста с единицей измерения
string electric::getDisplacementString() const {
    return to_string(displacement) + " " + measureElectric;
}

// Выдаёт заряд в виде текста с единицей измерения
string electric::getLevelString() const {
    return to_string(level) + " " + measureElectric;
}

// Контроллер гибрида, вводит заданное по умолчанию количество цилиндров и тип гибрида
hybrid::hybrid():type("parallel"){
}

// Контроллер гибрида, вводит введённое пользователем количество цилиндров и тип гибрида
hybrid::hybrid(string type){
    setCylinders(cylinders);
    setType(type);
}

// Контроллер гибрида, вводит введённое пользователем количество цилиндров, тип гибрида и данные из engines
hybrid::hybrid(unsigned short cylinders, string type, unsigned short level, unsigned short displacement, unsigned short weight, unsigned short consumption, unsigned short horsepower){
    setCylinders(cylinders);
    setType(type);
    setLevel(level);
    setDisplacement(displacement);
    setWeight(weight);
    setConsumption(consumption);
    setHP(horsepower);
}

// Выдаёт тип гибрида (последовательный или параллельный)
void hybrid::setType(string newType){
    type = newType;
}

// Выдаёт количество цилиндров
unsigned short hybrid::getCylinders() const{
    return cylinders;
}

// Выставляет количество цилиндров
void hybrid::setCylinders(unsigned short newCylinders){
    cylinders = newCylinders;
}

// Выдаёт условные объём бака и батареи в виде текста с единицами измерения
string hybrid::getDisplacementString() const{
    return format("{:.3f}", getDisplacement() * 0.7) + " " + measureGasoline + ", " + format("{:.3f}", getDisplacement() * 0.3) + " " + measureElectric;}
    
// Выдаёт условные количество топлива и батареи в виде текста с единицей измерения
string hybrid::getLevelString() const{
    return format("{:.3f}", getLevel() * 0.7) + " " + measureGasoline + ", " + format("{:.3f}", getLevel() * 0.3) + " " + measureElectric;}

// Выдаёт тип гибрида
string hybrid::getType() const{
    return type;
}
