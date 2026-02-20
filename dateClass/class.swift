//
//  class.swift
//  dateClass
//
//  Created by Семён on 20.02.2026.
//  Copyright © 2026 Семён. All rights reserved.
//

import Foundation

class Date {
    
    private var day: Int = 0
    private var month: Int = 0
    private var year: Int = 0
    
    init() {
        self.day = 0
        self.month = 0
        self.year = 0
    }
    
    convenience init(day: Int) throws {
        self.init()
        setDay(day)
    }
    
    convenience init(day: Int, month: Int) throws {
        self.init()
        setDay(day)
        setMonth(month)
    }
    
    convenience init(day: Int, month: Int, year: Int) {
        self.init()
        setDay(day)
        setMonth(month)
        setYear(year)
    }
    
    func getDay() -> Int {
        return day + 1
    }
    
    func getMonth() -> Int {
        return month + 1
    }
    
    func getYear() -> Int {
        return year
    }
    
    func setDay(_ newDay: Int){
        if newDay > 31 || newDay < 1 {
            day = 0
        }
        day = newDay - 1
    }
    
    func setMonth(_ newMonth: Int){
        if newMonth > 12 || newMonth < 1 {
           month = 0
        }
        month = newMonth - 1
    }
    
    func setYear(_ newYear: Int) {

        year = newYear
    }
    
    func addDay(_ newDay: Int) {
        if month == 1 && !leapyear(y: year) {
            addMonth((day + newDay) / 28)
            day = (day + newDay) % 28
        } else if month == 1 && leapyear(y: year) {
            addMonth((day + newDay) / 29)
            day = (day + newDay) % 29
        } else if month == 3 || month == 5 || month == 8 || month == 10 {
            addMonth((day + newDay) / 30)
            day = (day + newDay) % 30
        } else {
            addMonth((day + newDay) / 31)
            day = (day + newDay) % 31
        }
    }
    
    func addMonth(_ newMonth: Int) {
        month = month + newMonth
        addYear(month / 12)
        month = month % 12
    }
    
    func addYear(_ newYear: Int) {
        year = year + newYear
    }
    
    func dateString() -> String {
        return String(format: "%02d.%02d.%02d", day + 1, month + 1, year)
    }
    
}
