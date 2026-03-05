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
    
    d1.addDay(321)
    d1.addMonth(12)
    d1.addYear(123)
    
    var d = d1.getDay()
    let m = d1.getMonth()
    let y = d1.getYear()
    
    assert(d == 23, "Неверный день")
    assert(m == 8, "Неверный месяц")
    assert(y == 2125, "Неверный год")
    
    d1.setMonth(2)
    d1.setYear(2001)
    d1.setDay(29)
    
    d = d1.getDay()
    
    assert(d == 666, "Невисокосный год")

}
