//
//  ChatBot.swift
//  chat
//
//  Created by Семён on 16.03.2026.
//

import Foundation

class Bot {
    
    private let botname: String
    private let name: String
    private var inGame: Bool = false
    private var DiceGame: Bool = false
    private var PaperStoneGame: Bool = false
    
    init(_ botname: String = "", _ name: String) {
        self.botname = botname
        self.name = name
    }
    
    private lazy var res: [String: [String]] = [
        "greetings":
        ["Привет, \(name)", "Приветствую, \(name)"],
        "what_your_name":
        ["Меня зовут \(botname)"],
        "how_are_you":
        ["У бота всегда всё хорошо", "Отвратительно", "Пока сервер не обрублен, всё хорошо"],
        "what_can_you_do":
        ["Пару простейших задач", "Особо ничего"],
        "other":
        ["Я не знаю что ответить", "Возможно, за это отвечает другая команда"]
    ]
    
    func InOut(_ text: String) -> String {
        var result = ""
        
        if inGame {
            result = PlayingGame(text)
        } else
        
        if text == "Сыграем в игру" {
            inGame = true
            result = "В какую?"
        } else
        
        // Проверка на "+", "-", "*", "/"
        if text.contains("+") || text.contains("-") || text.contains("*") || text.contains("/") {
            result = "Ответ: \(calculate(text))"
        } else
        {
            result = res[botresponce(text)]?.randomElement() ?? "Ответа нет"
        }
        return result
    }
    
    private func calculate(_ text: String) -> String {
        let op = "+-*/"
        
        // replacingOccurrences удаляет пробелы
        let num = text.replacingOccurrences(of: " ", with: "")
        // firstIndex ищет место, где находится "+-*/"
        let opindex = num.firstIndex(where: { op.contains($0) })
        let opp = num[opindex!]
        var result = ""
        
        let a = Double(num[num.startIndex..<opindex!])!
        var bs = num[num.index(after: opindex!)...]
        
        if bs.contains("+") || bs.contains("-") || bs.contains("*") || bs.contains("/") {
            bs = Substring(calculate(String(bs)))
        }
        
        let b = Double(bs)!
        
        if opp == "+" {
            result = String(a+b)
        } else if opp == "-" {
            result = String(a-b)
        } else if opp == "*" {
            result = String(a*b)
        } else if opp == "/" {
            result = String(a/b)
        }
        
        return result
    }
    
    private func botresponce(_ text: String) -> String {
        if text == "Привет" ||
            text == "привет" {
            return "greetings"
        }else if text == "Как дела?" ||
            text == "Как ты?" ||
            text == "как дела?" ||
            text == "как ты?" {
            return "how_are_you"
        }else if text == "Как тебя зовут?" ||
            text == "Кто ты?" ||
            text == "как тебя зовут?" ||
            text == "кто ты?" {
            return "what_your_name"
        }else if text == "Что ты умеешь?" ||
            text == "что ты можешь?" ||
            text == "что ты умеешь?" ||
            text == "Что ты можешь?"{
            return "what_can_you_do"
        }
        return "other"
    }
    
    private func PlayingGame(_ text: String) -> String {
        
        var result = ""
        
        if PaperStoneGame == true {
            result = PaperStone(text)
        }
        
        if text == "Кости" {
            DiceGame = true
        }
        
        if text == "Камень, ножницы, бумага" {
            result = "Выбирайте (Камень, ножницы или бумага)"
            PaperStoneGame = true
        }
        
        if DiceGame == true {
            result = Dice()
        }
        
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
        
        if (text == "Камень" && qq == "ножницы") ||
            (text == "Ножницы" && qq == "бумага") ||
            (text == "Бумага" && qq == "камень"){
            result = "У вас \(text), у меня \(qq). Вы победили!"
        }
        else if (text == "Камень" && qq == "бумага") ||
            (text == "Ножницы" && qq == "камень") ||
            (text == "Бумага" && qq == "ножницы"){
                result = "У вас \(text), у меня \(qq). Я победил!!!"
        }
        else {
            result = "У вас \(text), у меня \(qq). Ничья :-("
        }
        
        return result
    }
    
}
