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
    return (y % 4 == 0 || y == 0)
}

func checkday(d:Int, m:Int, y:Int) -> Bool{
    if m == 1 && !leapyear(y: y) && d <= 28 {   // Февраль (невисокосный год)
        return true
    } else if m == 1 && leapyear(y: y) && d <= 29 { // Февраль (високосный год)
        return true
    } else if ((m == 3 || m == 5 || m == 8 || m == 10) && d <= 30) { // Месяцы по 30 дней
        return true
    } else if d <= 31 {
        return true
    } else {
        return false
    }
}

func checkmonth(m:Int) -> Bool {
    if m <= 12 || m >= 0 {
        return true
    } else {
        return false
    }
}

