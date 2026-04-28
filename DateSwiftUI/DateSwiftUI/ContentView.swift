//
//  ContentView.swift
//  DateSwiftUI
//
//  Created by Семён Зайцев on 12.04.2026.
//

import SwiftUI
import Foundation

/// Основное окно
struct ContentView: View {
    // Создаётся объект
    let date = Date()
    // Переменная для вывода даты
    // @State для автоматичской замены данных при записи данных в переменную
    @State private var datesave = "01.01.00"
    // Переменная для ввода дня
    @State private var nn1 = ""
    // Переменная для ввода месяца
    @State private var nn2 = ""
    // Переменная для ввода года
    @State private var nn3 = ""
    // Интерфейс
    var body: some View {
        // Элементы располагаются по вертикали
        VStack {
            // Text - текстовое поле
            Text("Дата:")
            // Дата (изменяется с переменной)
            Text(datesave)
                // Расстояние до следующего элемента
                .padding(.bottom, 10)
            // Элементы располагаются по горизонтали
            // spacing - расстояние между элементами
            HStack(spacing: 40){
                Text("День")
                    // Размеры окна
                    .frame(width: 50, height: 40)
                    .padding(.bottom, -20)
                Text("Месяц")
                    .frame(width: 50, height: 40)
                    .padding(.bottom, -20)
                Text("Год")
                    .frame(width: 60, height: 40)
                    .padding(.bottom, -20)
            }
            HStack(spacing: 40){
                // TextField - поле ввода
                // Принимает первоначальный текст и переменную для данных
                TextField("",text: $nn1)
                    .frame(width: 50, height: 40)
                TextField("",text: $nn2)
                    .frame(width: 50, height: 40)
                TextField("",text: $nn3)
                    .frame(width: 60, height: 40)
            }
            
            Text("")
            HStack(spacing: 100){
                // Кнопка
                // Принимает текст на кнопке
                // Активирует функцию прописанную дальше
                Button("Выставить") {
                    if (nn1 != "")&&(nn2 != "")&&(nn3 != "") {
                        date.setMonth(Int(nn2)!)
                        date.setYear(Int(nn3)!)
                        date.setDay(Int(nn1)!)
                        datesave = date.dateString()
                        nn1 = ""
                        nn2 = ""
                        nn3 = ""
                    }
                }
                .accentColor(.blue)
                Button("Добавить") {
                    if nn2 != "" {
                        date.addMonth(Int(nn2)!)
                    }
                    if nn3 != "" {
                        date.addYear(Int(nn3)!)
                    }
                    if nn1 != "" {
                        date.addDay(Int(nn1)!)
                    }
                    datesave = date.dateString()
                    nn1 = ""
                    nn2 = ""
                    nn3 = ""
                }
            }
            Button("Выставить сегодняшнюю дату") {
                let time = DateFormatter()
                time.dateFormat = "m"
                date.setMonth(Int(time.string(from: Foundation.Date()))!-19)
                time.dateFormat = "y"
                date.setYear(Int(time.string(from: Foundation.Date()))!)
                time.dateFormat = "d"
                date.setDay(Int(time.string(from: Foundation.Date()))!)
                datesave = date.dateString()
            }
        }
        .padding()
    }
}

/// Блок отвечающий за запуск программы
struct ContentView_Previews: PreviewProvider {
    // Поле отвечающее за запуск окон
    static var previews: some View {
        // Запуск главного окна
        ContentView()
    }
}
