//
//  ChatBot.swift
//  chat
//
//  Created by Семён on 16.03.2026.
//

import Foundation

/* Класс бота: принимает фразу пользователя,
 обдумывает ответ, считает, обрабатывпает игру
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
    
    /// Словарь ответов бота на тип фразы пользователя
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
        // На непонятые фразы
        "other":
        ["Я не знаю что ответить", "Возможно, за это отвечает другая команда"]
    ]
    
    /// Публичный метод принимающий фразу пользователя text и выдающая соответсвующий ответ
    
    func InOut(_ text: String) -> String {
        var result = ""
        let op = regex("[-+*/]")
        
        /// Если пользователь выбрал игру в предыдущей фразе, запускается метод обработки игр
        if inGame {
            result = PlayingGame(text)
        } else
        /// Если пользователь предложил сыграть в игру, после следующей фразы запустится метод обработки игр
        /// lowercased - убирает высокие регистры (ПрИмЕр -> пример)
        if text.lowercased() == "сыграем в игру" ||
           text.lowercased() == "давай в игру" {
            inGame = true
            result = "В какую?"
        } else
        
        // Проверка на "+", "-", "*", "/" и запуск метода подсчёта
        if op.matches(text) {
            result = "Ответ: \(calculate(text))"
        } else
            /// Если всё предыдущее не подошло обращается к методу определения разговорных фраз и подбирает случайный ответ
        {
            result = (res[botresponce(text)]?.randomElement())!
        }
        /// Возвращает ответ
        return result
    }
    
    /// Метод подсчёта (принимает фразу text целиком)
    private func calculate(_ text: String) -> String {
        let op = "+-*/"
        var b: [Double] = []
        var j = 0
        
        /// replacingOccurrences заменяет пробелы на пустоту (удаляет)
        let num = text.replacingOccurrences(of: " ", with: "")
        /// firstIndex ищет место, где находится "+-*/"
        // Идет по каждому
        var opindex = num.firstIndex(where: { op.contains($0) })
        /// Опеределяет знак (принимает значение в том месте, индекс которого определён ранее)
        var opp: [String] = [String(num[opindex!])]
        
        /// Определяет значение до знака
        // Записывает от начальной точки до места, индекс которого определён ранее в opindex
        b.append(Double(num[num.startIndex..<opindex!])!)
        /// Определяет значение после знака
        // Записывает все от места, индекс которого определён ранее в opindex
        var bs = num[num.index(after: opindex!)...]
        opindex = bs.firstIndex(where: { op.contains($0) })
        
        /// Пока bs не пуст
        while (bs != "") {
            /// Определяет количество действий в задаче
            j = j + 1
            /// Если
            if bs.contains("+") || bs.contains("-") || bs.contains("*") || bs.contains("/"){
                /// Добавляется знак
                opp.append(String(bs[opindex!]))
                /// Значение перед знаком
                b.append(Double(bs[bs.startIndex..<opindex!])!)
            } else {
                /// Последнее значение
                b.append(Double(bs)!)
                /// Завершает цикл
                break
            }
            /// Убирает то что уже добавлено в массив
            bs = bs[bs.index(after: opindex!)...]
            /// Определяет расстояние до знака
            opindex = bs.firstIndex(where: { op.contains($0) })
        }
        
        /// Цикл подсчёта
        // Повторяется столько раз, сколько знаков во фразе
        for _ in 0...j-1 {
            /// Цикл проверки массива со знаками на приоритетные
            for k in 0...j-1 {
                /// Если найдено, производится действие
                if opp[k] == "*" {
                    /// Само действие (Умножение текущего значения с последующим)
                    b[k] = b[k] * b[k+1]
                    /// Удаление последующего элемента и смещение
                    b.remove(at: k+1)
                    /// Удаление знака
                    opp.remove(at: k)
                    /// Уменьшение кол-ва иттераций
                    j = j-1
                }
            }
            /// Проверка на пустой массив знаков (Если конечный ответ получен)
            if opp.isEmpty {
                /// Завершение цикла
                break
            }
            for k in 0...j-1 {
                if opp[k] == "/" {
                    b[k] = b[k] / b[k+1]
                    b.remove(at: k+1)
                    opp.remove(at: k)
                    j = j-1
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
                }
            }
            if opp.isEmpty {
                break
            }
        }
        
        /// Возвращает конечный результат
        return String(b[0])
    }
    
    /// Приватный метод определения ответа бота на разговор
    /// Принимает фразу пользователя text и возвращает тип ответа в текстовом виде
    private func botresponce(_ text: String) -> String {
        if text.lowercased() == "привет" {
            return "greetings"
        }else if text.lowercased() == "как дела?" ||
            text.lowercased() == "как ты?" {
            return "how_are_you"
        }else if text.lowercased() == "как тебя зовут?" ||
            text.lowercased() == "кто ты?" {
            return "what_your_name"
        }else if text.lowercased() == "что ты можешь?" ||
            text.lowercased() == "что ты умеешь?"{
            return "what_can_you_do"
        }
        /// Если не подошёл ни один из вариантов, возвращает ответ с непониманием
        return "other"
    }
    
    /// Приватный метод определения игры
    /// Принимает фразу text, возвращает вопрос по игре или ответ
    private func PlayingGame(_ text: String) -> String {
        
        var result = ""
        /// Если была выбрана игра (Камень, ножницы, бумага)
        /// Запускает метод PaperStone
        if PaperStoneGame == true {
            result = PaperStone(text)
        }
        
        /// Если пользователь предложил (кости), запускается метод Dice
        if text.lowercased() == "кости" {
            DiceGame = true
            result = Dice()
        }
        
        /// Если пользователь предложил (Камень, ножницы, бумага), бот будет в состоянии игры в камень, ножницы, бумага
        if text.lowercased() == "камень, ножницы, бумага" {
            result = "Выбирайте (Камень, ножницы или бумага)"
            PaperStoneGame = true
        }
        
        /// Возвращает ответ по игре
        return result
    }
    
    
    private func Dice() -> String {
        let a = String(Int.random(in: 2...12))
        let b = String(Int.random(in: 2...12))
        var result = ""
        
        DiceGame = false
        inGame = false
        
        if Int(a)! > Int (b)! {
            result = "Вам выпало \(a), а мне \(b). Вы победили!"
        } else if Int(a)! < Int (b)!{
            result = "Вам выпало \(a), а мне \(b). Я победил!!!"
        } else {
            result = "Вам выпало \(a), а мне \(b). Ничья :-("
        }
        
        return result
    }
    
    private func PaperStone(_ text: String) -> String {
        
        PaperStoneGame = false
        inGame = false
        
        let SCP: [String] = ["камень", "ножницы", "бумага"]
        var result = ""
        let qq = SCP.randomElement() ?? "Ответа нет"
        
        if (text.lowercased() == "камень" && qq == "ножницы") ||
            (text.lowercased() == "ножницы" && qq == "бумага") ||
            (text.lowercased() == "бумага" && qq == "камень"){
            result = "У вас \(text), у меня \(qq). Вы победили!"
        }
        else if (text.lowercased() == "камень" && qq == "бумага") ||
            (text.lowercased() == "ножницы" && qq == "камень") ||
            (text.lowercased() == "бумага" && qq == "ножницы"){
                result = "У вас \(text), у меня \(qq). Я победил!!!"
        }
        else if (text.lowercased() == "камень" && qq == "камень") ||
            (text.lowercased() == "ножницы" && qq == "ножницы") ||
            (text.lowercased() == "бумага" && qq == "бумага"){
            result = "У вас \(text), у меня \(qq). Ничья :-("
        } else {
            result = "Вы написали что-то не то"
        }
        
        return result
    }
    
}
