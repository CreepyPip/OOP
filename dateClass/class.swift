//
//  class.swift
//  dateClass
//
//  Created by Семён on 20.02.2026.
//  Copyright © 2026 Семён. All rights reserved.
//

import Foundation

class Date {
    
    private var day: Int
    private var month: Int
    private var year: Int
    
    // Присваивает начальные значения
    init() {
        self.day = 1
        self.month = 1
        self.year = 0
    }
    
    convenience init(_ day: Int) {
        self.init()
        setDay(day)
    }
    
    convenience init(_ day: Int, _ month: Int) {
        self.init()
        setDay(day)
        setMonth(month)
    }
    
    convenience init(_ day: Int, _ month: Int, _ year: Int) {
        self.init()
        setDay(day)
        setMonth(month)
        setYear(year)
    }
    
    // Выдаёт день
    func getDay() -> Int {
        return day + 1
    }
    
    // Выдаёт месяц
    func getMonth() -> Int {
        return month + 1
    }
    
    // Выдаёт год
    func getYear() -> Int {
        return year
    }
    
    // Выставляет день
    func setDay(_ newDay: Int){
        if month == 1 && !leapyear(y: year) && newDay <= 29 {   // Февраль (невисокосный год)
            day = newDay - 1
        } else if month == 1 && leapyear(y: year) && newDay <= 30 { // Февраль (високосный год)
            day = newDay - 1
        } else if ((month == 3 || month == 5 || month == 8 || month == 10) && newDay <= 31) { // Месяцы по 30 дней
            day = newDay - 1
        } else if day <= 32 && (month == 0 || month == 2 || month == 4 || month == 6 || month == 7 || month == 9 || month == 11) {
            day = newDay - 1
        } else {
            day = 30
        }
    }
    
    // Выставляет месяц
    func setMonth(_ newMonth: Int){
        if newMonth > 12 || newMonth <= 0 {
           month = 0
        }
        month = newMonth - 1
    }
    
    // Выставляет год
    func setYear(_ newYear: Int) {

        year = newYear
    }
    
    // Добавляет день (и дополнительно месяц)
    func addDay(_ newDay: Int) {
        if month == 1 && !leapyear(y: year) {   // Февраль (невисокосный год)
            addMonth((day + newDay) / 28)
            day = (day + newDay) % 28
        } else if month == 1 && leapyear(y: year) { // Февраль (високосный год)
            addMonth((day + newDay) / 29)
            day = (day + newDay) % 29
        } else if month == 2 || month == 4 || month == 7 || month == 9 { // Месяцы по 30 дней
            addMonth((day + newDay) / 30)
            day = (day + newDay) % 30
        } else {
            addMonth((day + newDay) / 31)   // Месяцы по 31 день
            day = (day + newDay) % 31
        }
    }
    
    // Добавляет месяц (и дополнительно год)
    func addMonth(_ newMonth: Int) {
        month = month + newMonth
        addYear(month / 12)
        month = month % 12
    }
    
    
    // Добавляет год
    func addYear(_ newYear: Int) {
        year = year + newYear
    }
    
    // Выдаёт полную дату в виде текста
    func dateString() -> String {
        return String(format: "%02d.%02d.%02d", day + 1, month + 1, year)
    }
    
}
