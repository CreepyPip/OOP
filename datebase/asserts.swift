//
//  asserts.swift
//  datebase
//
//  Created by Семён Зайцев on 24.05.2026.
//

import Foundation

func tests() {
    let testdb = DB()
    var testusers: [User] = []
    _ = testdb.connect("test")
    
    _ = testdb.createTable()
    _ = testdb.insert(1, "Tecтов", "Тест", "Тестович", 1234)
    
    testusers = testdb.select()
    
    var first = testusers.first
    assert("\(first!.surname) \(first!.name) \(first!.secondname) \(first!.age)" == "Tecтов Тест Тестович 1234")

    // Нужно добавить удаление и получение данные с другой части таблицы
    _ = testdb.delete(1)
    
    
    testusers = testdb.select()
    first = testusers.first
    assert("\(first?.surname) \(first?.name) \(first?.secondname) \(first?.age)" == "nil nil nil nil")
}
