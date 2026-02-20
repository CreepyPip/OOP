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


    @IBAction func SetButton(_ sender: NSButton) {
        let day = DayField.stringValue
        let month = MonthField.stringValue
        let year = YearField.stringValue
        
        guard let dayint = Int(day),
            let monthint = Int(month),
            let yearint = Int(year) else {
                return
        }
        
        let date = Date()
        date.setDay(dayint)
        date.setMonth(monthint)
        date.setYear(yearint)
        
        DataLabel.stringValue = date.dateString()
    }
    @IBAction func AddButton(_ sender: NSButton) {
        let day = DayField.stringValue
        let month = MonthField.stringValue
        let year = YearField.stringValue
        
        guard let dayint = Int(day),
            let monthint = Int(month),
            let yearint = Int(year) else {
                return
        }
        
        let date = Date()
        
        date.addDay(dayint)
        date.addMonth(monthint)
        date.addYear(yearint)
        
        DataLabel.stringValue = date.dateString()
        
        
    }




}

