//
//  leapyear.swift
//  dateClass
//
//  Created by Семён on 20.02.2026.
//  Copyright © 2026 Семён. All rights reserved.
//

import Foundation

// Проверка на високосный год
func leapyear(y:Int) -> Bool{
    if y % 4 == 0 || y == 0 {
        return true
    }else{
        return false}
}

// Проверка дня на корректность
func checkday(d:Int, m:Int, y:Int) -> Bool{
    if m == 2 && !leapyear(y: y) && d <= 28 {   // Февраль (невисокосный год)
        return true
    } else if m == 2 && leapyear(y: y) && d <= 29 { // Февраль (високосный год)
        return true
    } else if ((m == 4 || m == 6 || m == 9 || m == 11) && d <= 30) { // Месяцы по 30 дней
        return true
    } else if d <= 31 && (m == 1 || m == 3 || m == 5 || m == 7 || m == 8 || m == 10 || m == 12) {
        return true
    } else {
        return false
    }
}

// Проверка месяца на корректность
func checkmonth(m:Int) -> Bool {
    if m <= 12 || m > 0 {
        return true
    } else {
        return false
    }
}

