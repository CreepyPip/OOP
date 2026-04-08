//
//  ChatBot.swift
//  chat
//
//  Created by Семён on 16.03.2026.
//

import Foundation
import AppKit

/* Класс бота: принимает фразу пользователя,
 обдумывает ответ, считает, обрабатывпает игру, запускает несколько программ
 */
class Bot {
    // Имя бота
    private let botname: String
    // Имя пользователя
    private let name: String
    // Находится ли бот в состоянии игры
    private var inGame: Bool = false
    // Выбрал ли пользователь игру "Кости"
    private var DiceGame: Bool = false
    // Выбрал ли пользователь игру "Камень, ножницы, бумага"
    private var PaperStoneGame: Bool = false
    
    // Конструктор (принимает имя бота и имя пользователя)
    init(_ botname: String = "", _ name: String) {
        self.botname = botname
        self.name = name
    }
    
    // Словарь ответов бота на тип фразы пользователя
    private lazy var res: [String: [String]] = [
        // Приветствие
        "greetings":
        ["Привет, \(name)", "Приветствую, \(name)"],
        // Вопрос "Как тебя зовут"
        "what_your_name":
        ["Меня зовут \(botname)"],
        // Вопрос "Как дела"
        "how_are_you":
        ["У бота всегда всё хорошо", "Отвратительно", "Пока сервер не обрублен, всё хорошо"],
        // Вопрос "Что ты умеешь"
        "what_can_you_do":
        ["Пару простейших задач", "Особо ничего"],
        "open_app":
        ["Сейчас открою", "Будет сделано", "Ожидайте", "Открываю"],
        // На непонятые фразы
        "other":
        ["Я не знаю что ответить", "Возможно, за это отвечает другая команда"]
    ]
    
    /// Публичный метод принимающий фразу пользователя text и выдающая соответсвующий ответ
    func InOut(_ text: String) -> String {
        var result = ""
        let form = regex("\\d+[-+*/]\\d+")
        let calcphrasereg = regex("\\d+ .*? \\d+")
        let gamereg = regex("игр")
        let launchreg = regex("запус|откр|включи")
        let exitreg = regex("пока|прощай")
        let savereg = regex("сохрани переписку")
        
        // Если пользователь выбрал игру в предыдущей фразе, запускается метод обработки игр
        if inGame {
            result = PlayingGame(text)
        } else
        // Если пользователь предложил сыграть в игру, после следующей фразы запустится метод обработки игр
        // lowercased - убирает высокие регистры (ПрИмЕр -> пример)
        if gamereg.matches(text.lowercased()) {
            inGame = true
            result = "В какую?"
        } else
        // Запуск программы
        if launchreg.matches(text.lowercased()) {
            let l = launchApp(text)
            // Если программа заранее прописана, запускает и выдаёт подтверждающий ответ
            if l == "open_app"{
                return (res["open_app"]?.randomElement())!
            } else {
            // Выдаёт отрицательный ответ
                return l
            }
        } else
            
        // Проверка на "+", "-", "*", "/" и запуск метода подсчёта
        if form.matches(text) {
            result = "Ответ: \(expPreCalc(text))"
        } else
        if calcphrasereg.matches(text) {
            result = "Ответ: \(phrasePreCalc(text))"
        } else
        // Выход из программы
        if exitreg.matches(text.lowercased()) {
            return "Прощайте"
        } else
        // На случай, если пользователь просит сохранить переписку
        if savereg.matches(text.lowercased()) {
            return "Сохраняю"
        } else
        // Если всё предыдущее не подошло обращается к методу определения разговорных фраз и подбирает случайный ответ
        {
            result = (res[botresponce(text)]?.randomElement())!
        }
        // Возвращает ответ
        return result
    }
    
    /// Метод для чтения фразы (сложи, подели и т.д) и выдача параметров для просчёта
    /// Принимает фразу пользователя text
    private func phrasePreCalc(_ text: String) -> String {
        // Регулярные выражения
        let addreg = regex ("сложи")
        let multreg = regex ("умножь")
        let subtracreg = regex("вычти")
        let divreg = regex("подели")
        let opreg = regex("[А-Яа-я]")
        let numreg = regex("[0-9]")
        // Удаляем пробелы
        let phrase = text.replacingOccurrences(of: " ", with: "")
        // Массив для значений
        var a: [Double] = []
        // Знак действия
        var b = ""
        
        // Доходим до первого значения
        var opindex1 = phrase.firstIndex(where: { numreg.matches(String($0)) })
        // Убираем всё что перед ним
        var bs = phrase[opindex1!...]
        // Определяем конец первого значения
        let opindex2 = bs.firstIndex(where: { opreg.matches(String($0)) })
        // Добавляем его в массив
        a.append(Double(bs[bs.startIndex..<opindex2!])!)
        // Убираем всё до следующего слова
        bs = bs[opindex2!...]
        // Определяем начало следующего значения
        opindex1 = bs.firstIndex(where: { numreg.matches(String($0)) })
        // Убираем всё до значения
        bs = bs[opindex1!...]
        // Добавляем его
        a.append(Double(bs[bs.startIndex...])!)

        // Определяется действие
        if addreg.matches(text.lowercased()) {
            b = "+"
        } else
        if subtracreg.matches(text.lowercased()) {
            b = "-"
        } else
        if multreg.matches(text.lowercased()) {
            b = "*"
        } else
        if divreg.matches(text.lowercased()) {
            b = "/"
        }
        
        // Возвращает значение полученное после подсчёта
        return calculate(1, [b], a)
    }
    
    /// Метод на чтение и обработку математического выражения
    /// Принимает фразу пользователя text
    private func expPreCalc(_ text: String) -> String {
    
        let op = "+-*/"
        var b: [Double] = []
        var j = 0
        
        // replacingOccurrences заменяет пробелы на пустоту (удаляет)
        let num = text.replacingOccurrences(of: " ", with: "")
        // firstIndex ищет место, где находится "+-*/"
        // Идет по каждому
        var opindex = num.firstIndex(where: { op.contains($0) })
        // Опеределяет знак (принимает значение в том месте, индекс которого определён ранее)
        var opp: [String] = [String(num[opindex!])]
        
        // Определяет значение до знака
        // Записывает от начальной точки до места, индекс которого определён ранее в opindex
        b.append(Double(num[num.startIndex..<opindex!])!)
        // Определяет значение после знака
        // Записывает все от места, индекс которого определён ранее в opindex
        var bs = num[num.index(after: opindex!)...]
        opindex = bs.firstIndex(where: { op.contains($0) })
        
        // Пока bs не пуст
        while (bs != "") {
            // Определяет количество действий в задаче
            j = j + 1
            // Если
            if bs.contains("+") || bs.contains("-") || bs.contains("*") || bs.contains("/"){
                // Добавляется знак
                opp.append(String(bs[opindex!]))
                // Значение перед знаком
                b.append(Double(bs[bs.startIndex..<opindex!])!)
            } else {
                // Последнее значение
                b.append(Double(bs)!)
                // Завершает цикл
                break
            }
            // Убирает то что уже добавлено в массив
            bs = bs[bs.index(after: opindex!)...]
            // Определяет расстояние до знака
            opindex = bs.firstIndex(where: { op.contains($0) })
        }
        
        return calculate(j, opp, b)
    }
    
    /// Метод подсчёта
    /// Принимает кол-во иттераций i, массив знаков op в выражении и массив чисел a
    private func calculate(_ i: Int,_ op: [String],_ a: [Double]) -> String {
        
        var j = i
        var b = a
        var opp = op
        
        // Цикл подсчёта
        // Повторяется столько раз, сколько знаков во фразе
        for _ in 0...j-1 {
            // Цикл проверки массива со знаками на приоритетные
            for k in 0...j-1 {
                // Если найдено, производится действие
                if opp[k] == "*" {
                    // Само действие (Умножение текущего значения с последующим)
                    b[k] = b[k] * b[k+1]
                    // Удаление последующего элемента и смещение
                    b.remove(at: k+1)
                    // Удаление знака
                    opp.remove(at: k)
                    // Уменьшение кол-ва иттераций
                    j = j-1
                    break
                }
            }
            // Проверка на пустой массив знаков (Если конечный ответ получен)
            if opp.isEmpty {
                // Завершение цикла
                break
            }
            for k in 0...j-1 {
                if opp[k] == "/" {
                    b[k] = b[k] / b[k+1]
                    b.remove(at: k+1)
                    opp.remove(at: k)
                    j = j-1
                    break
                }
            }
            if opp.isEmpty {
                break
            }
            for k in 0...j-1 {
                if opp[k] == "-" {
                    b[k] = b[k] - b[k+1]
                    b.remove(at: k+1)
                    opp.remove(at: k)
                    j = j-1
                    break
                }
            }
            if opp.isEmpty {
                break
            }
            for k in 0...j-1 {
                if opp[k] == "+" {
                    b[k] = b[k] + b[k+1]
                    b.remove(at: k+1)
                    opp.remove(at: k)
                    j = j-1
                    break
                }
            }
            if opp.isEmpty {
                break
            }
        }
        
        // Возвращает конечный результат
        return String(b[0])
    }
    
    /// Приватный метод определения ответа бота на разговор
    /// Принимает фразу пользователя text и возвращает тип ответа в текстовом виде
    private func botresponce(_ text: String) -> String {
        // \\ - указывает на то, что второй символ "\" является частью фразы
        let greetreg = regex("\\bприв")
        let howreg = regex("\\bдела\\b")
        let doreg = regex("можешь\\b|умеешь\\b|делаешь\\b")
        
        if greetreg.matches(text.lowercased()){
            return "greetings"
        }else if howreg.matches(text.lowercased()) {
            return "how_are_you"
        }else if text.lowercased() == "как тебя зовут?" ||
            text.lowercased() == "кто ты?" {
            return "what_your_name"
        }else if doreg.matches(text.lowercased()){
            return "what_can_you_do"
        }
        // Если не подошёл ни один из вариантов, возвращает ответ с непониманием
        return "other"
    }
    
    /// Приватный метод определения игры
    /// Принимает фразу text, возвращает вопрос по игре или ответ
    private func PlayingGame(_ text: String) -> String {
        
        var result = ""
        // Если была выбрана игра (Камень, ножницы, бумага)
        // Запускает метод PaperStone
        if PaperStoneGame == true {
            result = PaperStone(text)
        }
        
        // Если пользователь предложил (кости), запускается метод Dice
        if text.lowercased() == "кости" {
            DiceGame = true
            result = Dice()
        }
        
        // Если пользователь предложил (Камень, ножницы, бумага), бот будет в состоянии игры в камень, ножницы, бумага
        if text.lowercased() == "камень, ножницы, бумага" {
            result = "Выбирайте (Камень, ножницы или бумага)"
            PaperStoneGame = true
        }
        
        // Возвращает ответ по игре
        return result
    }
    
    /// Метод для обработки игры "Кости"
    /// Ничего не принимает
    private func Dice() -> String {
        // "Бросок" пользователя
        let a = String(Int.random(in: 2...12))
        // "Бросок" бота
        let b = String(Int.random(in: 2...12))
        var result = ""
        
        // Завершает состояние "В игре"
        DiceGame = false
        inGame = false
        
        // Расчёт итога игры
        if Int(a)! > Int (b)! {
            result = "Вам выпало \(a), а мне \(b). Вы победили!"
        } else if Int(a)! < Int (b)!{
            result = "Вам выпало \(a), а мне \(b). Я победил!!!"
        } else {
            result = "Вам выпало \(a), а мне \(b). Ничья :-("
        }
        
        // Возвращает итог игры
        return result
    }
    
    /// Метод для обработки игры "Камень, ножницы, бумага"
    /// Принимает выбор игрока text
    private func PaperStone(_ text: String) -> String {
        
        // Завершает состояние "В игре"
        PaperStoneGame = false
        inGame = false
        // Массив выбора для бота
        let SCP: [String] = ["камень", "ножницы", "бумага"]
        let stone = regex("камень")
        let cut = regex("ножницы")
        let paper = regex("бумаг")
        var result = ""
        // Бот выбирает свой ответ
        let qq = SCP.randomElement()!
        var playtext = ""
        
        // Проверка того, что выбрал пользователь
        if (stone.matches(text.lowercased())) {
            playtext = "камень"
        } else
            if (cut.matches(text.lowercased())) {
                playtext = "ножницы"
            } else
                if (paper.matches(text.lowercased())) {
                    playtext = "бумага"
        }
        
        // Расчёт итога игры 
        if (playtext == "камень" && qq == "ножницы") ||
            (playtext == "ножницы" && qq == "бумага") ||
            (playtext == "бумага" && qq == "камень"){
            result = "У вас \(playtext), у меня \(qq). Вы победили!"
        }
        else if (playtext == "камень" && qq == "бумага") ||
            (playtext == "ножницы" && qq == "камень") ||
            (playtext == "бумага" && qq == "ножницы"){
                result = "У вас \(playtext), у меня \(qq). Я победил!!!"
        }
        else if (playtext == "камень" && qq == "камень") ||
            (playtext == "ножницы" && qq == "ножницы") ||
            (playtext == "бумага" && qq == "бумага"){
            result = "У вас \(playtext), у меня \(qq). Ничья :-("
        } else {
            result = "Вы написали что-то не то"
        }
        
        // Возвращает итог игры
        return result
    }
    
    // Эта функция будет открывать приложения
    // Возвращает ответ о состоянии и запускает программу
    private func launchApp(_ text: String) -> String{
        let Notesreg = regex("заметки")
        let Calcreg = regex("калькулятор")
        let Browserreg = regex("браузер|firefox")
        var AppId = ""
        
        // Выбор для запуска калькулятора
        if Calcreg.matches(text.lowercased()) {
            AppId = "Calculator"
        } else
        // Выбор для запуска заметок
        if Notesreg.matches(text.lowercased()) {
            AppId = "Notes"
        } else
        // Выбор для запуска браузера
            if Browserreg.matches(text.lowercased()) {
            AppId = "firefox"
        } else {
        // В случае, если программа не прописана
                return "Не знаю данной программы"
        }
        
        // Запуск выбранной программы
        // Данная функция находится в модуле AppKit
        NSWorkspace.shared.launchApplication(AppId)
        // Возвращает ответ (ключ словаря)
        return "open_app"
        
    }
    
}
