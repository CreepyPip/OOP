//
//  ViewController.swift
//  dateClass
//
//  Created by Семён on 20.02.2026.
//  Copyright © 2026 Семён. All rights reserved.
//

import Cocoa
class ViewController: NSViewController {
    @IBOutlet weak var DayField: NSTextField!
    @IBOutlet weak var MonthField: NSTextField!
    @IBOutlet weak var YearField: NSTextField!
    @IBOutlet weak var DataLabel: NSTextField!
    @IBOutlet weak var SaveDay: NSTextField!
    @IBOutlet weak var SaveMonth: NSTextField!
    @IBOutlet weak var SaveYear: NSTextField!
    
    // Выставить дату
    @IBAction func SetButton(_ sender: NSButton) {
        // Принимает значения из полей
        let day = DayField.stringValue
        let month = MonthField.stringValue
        let year = YearField.stringValue
        
        // Перевод в int
        guard let dayint = Int(day),
            let monthint = Int(month),
            let yearint = Int(year) else {
                return
        }
        
        let date = Date()
        
        // Вывод на экран даты с дополнительной проверкой (кроме самого класса)
        if checkday(d: dayint, m: monthint, y: yearint) && checkmonth(m: monthint) {
                
                date.setDay(dayint)
                date.setMonth(monthint)
                date.setYear(yearint)
            
                // Запоминание даты программой
                DataLabel.stringValue = date.dateString()
                SaveDay.stringValue = day
                SaveMonth.stringValue = month
                SaveYear.stringValue = year
        
        } else {
            DataLabel.stringValue = "Ошибка"
        }
    }
    
    // Добавление к существующей дате
    @IBAction func AddButton(_ sender: NSButton) {
        // Принимает значения из полей
        let day = DayField.stringValue
        let month = MonthField.stringValue
        let year = YearField.stringValue
        
        // Перевод в int
        guard let dayint = Int(day),
            let monthint = Int(month),
            let yearint = Int(year) else {
                return
        }
        
        let date = Date()
        
        // 
        let loadday = SaveDay.stringValue
        let loadmonth = SaveMonth.stringValue
        let loadyear = SaveYear.stringValue
        
        guard let ldint = Int(loadday),
            let lmint = Int(loadmonth),
            let lyint = Int(loadyear) else {
                return
        }
        
        date.setDay(ldint)
        date.setMonth(lmint)
        date.setYear(lyint)
        
        date.addDay(dayint)
        date.addMonth(monthint)
        date.addYear(yearint)
        
        DataLabel.stringValue = date.dateString()
        
        SaveDay.stringValue = String(dayint + ldint)
        SaveMonth.stringValue = String(monthint + lmint)
        SaveYear.stringValue = String(yearint + lyint)
        
    }
}

