//
//  tests.swift
//  dateClass
//
//  Created by Семён on 04.03.2026.
//  Copyright © 2026 Семён. All rights reserved.
//

import Foundation

func Tests() {
    let d1 = Date(12, 10, 2000)
    
    // Проверка на корректность добавления даты
    d1.addDay(321)
    d1.addMonth(12)
    d1.addYear(123)
    
    // Присваиваем данные переменным (для удобства отладки)
    var d = d1.getDay()
    var m = d1.getMonth()
    var y = d1.getYear()
    
    // Если дата не совпадает, программа завершается
    assert(d == 23, "Неверный день")
    assert(m == 8, "Неверный месяц")
    assert(y == 2125, "Неверный год")
    
    // Проверка на корректность определения високосного дня
    d1.setMonth(2)
    d1.setYear(2001)
    d1.setDay(29)   // День задаётся последним, ведь нужна проверка месяца и года
    
    d = d1.getDay()
    
    // Если выдаёт 29 число, программа завершается
    assert(d == 666, "Невисокосный год")
    
    // Проверка на максимальное кол-во месяцев
    d1.setMonth(13)
    
    m = d1.getMonth()
    
    // Если выдаёт 13 месяц, программа завершается
    assert(m == 1000)

    d1.setMonth(10)
    d1.setYear(2000)
    d1.setDay(20)
    
    d = d1.getDay()
    m = d1.getMonth()
    y = d1.getYear()
    
    // Проверка на выдачу правильной даты на экран
    assert(d1.dateString() == "\(d).\(m).\(y)")
}
