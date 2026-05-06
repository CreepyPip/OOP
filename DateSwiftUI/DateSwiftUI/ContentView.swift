//
//  ContentView.swift
//  DateSwiftUI
//
//  Created by Семён Зайцев on 12.04.2026.
//

// Модуль интерфейса
import SwiftUI
// Модуль основных функций Swift
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
    @State private var color: Color = .black
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
            // Шрифт
            // расписать подробнее
                .font(.bold(.callout)())
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
                    // Проверка на пустоту полей
                    if (nn1 != "")&&(nn2 != "")&&(nn3 != "") {
                        // Выставляем дату
                        date.setYear(Int(nn3)!)
                        date.setMonth(Int(nn2)!)
                        date.setDay(Int(nn1)!)
                        // Выводим на экран
                        datesave = date.dateString()
                        // Очистка полей ввода
                        nn1 = ""
                        nn2 = ""
                        nn3 = ""
                        // Выставляем цвет для кнопки выставления сегодняшней даты
                        color = .black
                    }
                }
                Button("Добавить") {
                    // Добавляем к дате (месяц, год, день)
                    if nn2 != "" {
                        date.addMonth(Int(nn2)!)
                    }
                    if nn3 != "" {
                        date.addYear(Int(nn3)!)
                    }
                    if nn1 != "" {
                        date.addDay(Int(nn1)!)
                    }
                    // Выводим на экран
                    datesave = date.dateString()
                    // Очистка полей ввода
                    nn1 = ""
                    nn2 = ""
                    nn3 = ""
                    // Выставляем цвет для кнопки выставления сегодняшней даты
                    color = .black
                }
            }
            Button("Выставить сегодняшнюю дату") {
                // Переменная формата
                let time = DateFormatter()
                // Форматированние под месяц
                time.dateFormat = "M"
                // Выставляем месяц
                date.setMonth(Int(time.string(from: Foundation.Date()))!)
                // Форматированние под год
                time.dateFormat = "y"
                // Выставляем год
                date.setYear(Int(time.string(from: Foundation.Date()))!)
                // Форматированние под день
                time.dateFormat = "d"
                // Выставляем день
                date.setDay(Int(time.string(from: Foundation.Date()))!)
                // Выводим на экран
                datesave = date.dateString()
                // Выставляем цвет (неактивный)
                color = .gray
                // свой цвет
            }
            .foregroundColor(color) // Цвет шрифта
        }
        .padding() // Рамки программы
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
