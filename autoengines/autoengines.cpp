//
//  autoengines.cpp
//  autoengines
//
//  Created by Семён on 21.02.2026.
//  Copyright © 2026 Семён. All rights reserved.
//

#include "autoengines.h"

// Конструктор с заданными по умолчанию данными
engine::engine(): level(0), displacement(1), weight(1), consumption(1), horsepower(1) {}

// Конструктор, пользователь вводит все данные
engine::engine(unsigned short level, unsigned short displacement, unsigned short weight, unsigned short consumption, unsigned short horsepower){
    setLevel(level);
    setDisplacement(displacement);
    setWeight(weight);
    setConsumption(consumption);
    setHP(horsepower);
}

// Геттеры
unsigned short engine::getLevel() const {  // Топливо
    return level;
}
unsigned short engine::getDisplacement() const {   // Объём бака
    return displacement;
}
unsigned short engine::getWeight() const { // Вес
    return weight;
}
unsigned short engine::getHP() const { // Лошадинные силы
    return horsepower;
}
unsigned short engine::getConsumption() const {    // Расход
    return consumption;
}

// Сеттеры
void engine::setLevel(unsigned short newLevel){ // Топливо
    if (newLevel <= displacement) {
        level = newLevel;
    }
}

void engine::setDisplacement(unsigned short newDisplacement){ // Объём бака
    displacement = newDisplacement;
}

void engine::setWeight(unsigned short newWeight){ // Вес
    weight = newWeight;
}

void engine::setHP(unsigned short newHP){ // Лошадинные силы
    horsepower = newHP;
}

void engine::setConsumption(unsigned short newConsumption){ // Расход
    consumption = newConsumption;
}

// Пользователь добавляет уровень топлива(заряда)
void engine::refuel(unsigned short newLevel){
    if (level + newLevel <= displacement) {
        level = level + newLevel;
    } else
    {
        level = displacement;
    }
}

// Заполняет уровень топлива до максимума (до объёма бака)
void engine::refuelFull(){
    level = displacement;
}

// Отдаёт пробег на полном баке
double engine::maxDistance(){
    return displacement * consumption;
};

// Отдаёт пробег при заданном количестве топлива
double engine::fuelDistance(){
    return level * consumption;
};

// Конструктор ДВС, выдаёт заданное по умолчанию количество цилиндров
ICE::ICE(): cylinders(1){};

// Конструктор ДВС, выдаёт введённое пользователем количество цилиндров
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

// Конструктор электродвигателя
electric::electric(): wear(100){}

// Конструктор электродвигателя, вводит введённое пользователем данные из engine
electric::electric(unsigned short wear, unsigned short level, unsigned short displacement, unsigned short weight, unsigned short consumption, unsigned short horsepower){
    setWear(wear);
    setLevel(level);
    setDisplacement(displacement);
    setWeight(weight);
    setConsumption(consumption);
    setHP(horsepower);
}

// Выставляет износ батареи
void electric::setWear(unsigned short newWear) {
    if (newWear <=100) {
        wear = newWear;
    }
    else
        wear = 100;
}

// Выдаёт износ батареи
unsigned short electric::getWear() const {
    return wear;
}

// Выставляет уровень заряда (только для электрических)
void electric::setLevel(unsigned short newLevel) {
    double dWear = getWear();
    if (newLevel <= displacement * dWear/100) {
        level = newLevel;
    }
    else
        level = displacement * dWear/100;
}

// Пользователь добавляет уровень заряда
void electric::refuel(unsigned short newLevel){
    double dWear = getWear();
    if (level + newLevel <= displacement * dWear/100) {
        level = level + newLevel;
    } else
        level = displacement * dWear/100;
}

// Заполняет уровень заряда до максимума (до объёма батареи)
void electric::refuelFull(){
    double dWear = getWear();
    level = displacement * dWear/100;
}

// Выдаёт объём батареи в виде текста с единицей измерения
string electric::getDisplacementString() const {
    double dWear = getWear();
    return format("{:.3f}", displacement * dWear/100) + " " + measureElectric;
}

// Выдаёт заряд в виде текста с единицей измерения
string electric::getLevelString() const {
    return to_string(level) + " " + measureElectric;
};

// Конструктор гибрида, вводит заданное по умолчанию количество цилиндров и тип гибрида
hybrid::hybrid():type("parallel"){
}

// Конструктор гибрида, вводит введённое пользователем количество цилиндров и тип гибрида
hybrid::hybrid(string type){
    setCylinders(cylinders);
    setType(type);
}

// Конструктор гибрида, вводит введённое пользователем количество цилиндров, тип гибрида и данные из engines
hybrid::hybrid(unsigned short cylinders, string type, unsigned short wear, unsigned short level, unsigned short displacement, unsigned short weight, unsigned short consumption, unsigned short horsepower){
    electric(wear, level, displacement, weight, consumption, horsepower);
    setCylinders(cylinders);
    setType(type);
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

// Выдаёт условные объём бака и батареи в виде текста с единицами измерения и износом батареи
string hybrid::getDisplacementString() const{
    double dWear = getWear();
    return format("{:.3f}", getDisplacement() * 0.7) + " " + measureGasoline + ", " + format("{:.3f}", getDisplacement() * 0.3 * dWear/100) + " " + measureElectric;}
    
// Выдаёт условные количество топлива и батареи в виде текста с единицей измерения
string hybrid::getLevelString() const{
    return format("{:.3f}", getLevel() * 0.7) + " " + measureGasoline + ", " + format("{:.3f}", getLevel() * 0.3) + " " + measureElectric;}

// Выдаёт тип гибрида
string hybrid::getType() const{
    return type;
}
