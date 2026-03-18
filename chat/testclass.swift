//
//  testclass.swift
//  chat
//
//  Created by Семён on 16.03.2026.
//  Copyright © 2026 Семён. All rights reserved.
//

import Foundation

class ChatBot {
    
    // MARK: - Свойства
    
    /// Имя бота
    let name: String
    
    init(_ name: String = "Бот") {
        self.name = name
    }
    
    /// Словарь с ответами на различные категории вопросов
    private let responses: [String: [String]] = [
        "greeting": [
            "Привет!",
            "Здравствуй!",
            "Хэй! Как дела?",
            "Приветствую!"
        ],
        "how_are_you": [
            "У меня всё отлично, спасибо! А у тебя?",
            "Хорошо, как обычно. Расскажи о себе!",
            "Прекрасно! Чем могу помочь?",
            "Всё супер, работаю 😊"
        ],
        "who_are_you": [
            "Я простой чат-бот, созданный на Swift",
            "Меня зовут ЫПЫП. Я виртуальный помощник",
            "Я бот, который отвечает на вопросы и умеет считать!",
            "Я - калькулятор в чате 🤖"
        ],
        "capabilities": [
            "Я умею отвечать на простые вопросы",
            "Могу поддержать беседу, рассказать о себе",
            "Пока что я знаю не так много, но учусь!",
            "Я умею считать!"
        ],
        "farewell": [
            "Пока! Заходи ещё 👋",
            "До свидания!",
            "Удачи!",
            "Всего хорошего!"
        ],
        "calculation_result": [
            "Результат: %@",
            "Ответ: %@",
            "Получается %@",
            "Если я правильно посчитал, то %@",
            "Вот что вышло: %@"
        ],
        "calculation_error": [
            "Не могу посчитать это выражение. Попробуй ещё раз",
            "Что-то не так с примером 🤔",
            "Проверь правильность ввода",
            "Я понимаю только простые примеры (например: 2 + 2 * 3)"
        ],
        "default": [
            "Интересно... расскажи подробнее",
            "Я не совсем понял. Можешь перефразировать?",
            "Хм, давай поговорим о чём-то другом",
            "Извини, я ещё учусь и не всё понимаю"
        ]
    ]
    
    // MARK: - Публичные методы
    
    /// Получить ответ бота на сообщение пользователя
    func getResponse(to userMessage: String) -> String {
        let lowercasedMessage = userMessage.lowercased()
        
        // Проверяем, является ли сообщение математическим выражением
        if isMathExpression(lowercasedMessage) {
            return calculateExpression(userMessage)
        }
        
        // Определяем категорию сообщения
        let category = determineCategory(for: lowercasedMessage)
        
        // Получаем случайный ответ из соответствующей категории
        if let responsesForCategory = responses[category] {
            return getRandomResponse(from: responsesForCategory)
        }
        
        // Если категория не найдена, возвращаем ответ по умолчанию
        return getRandomResponse(from: responses["default"]!)
    }
    
    // MARK: - Приватные методы
    
    /// Определение категории сообщения пользователя
    private func determineCategory(for message: String) -> String {
        // Приветствия
        if message.contains("привет") ||
            message.contains("здравствуй") ||
            message.contains("здорово") ||
            message.contains("прив") ||
            message.contains("хай") ||
            message.contains("hello") ||
            message.contains("hi") {
            return "greeting"
        }
        
        // Вопросы о делах
        if message.contains("как дела") ||
            message.contains("как ты") ||
            message.contains("что нового") ||
            message.contains("how are you") ||
            message.contains("ты как") {
            return "how_are_you"
        }
        
        // Вопросы о личности
        if message.contains("кто ты") ||
            message.contains("ты кто") ||
            message.contains("твое имя") ||
            message.contains("как тебя зовут") ||
            message.contains("who are you") ||
            message.contains("what is your name") {
            return "who_are_you"
        }
        
        // Вопросы о возможностях
        if message.contains("что умеешь") ||
            message.contains("что можешь") ||
            message.contains("твои функции") ||
            message.contains("что делаешь") ||
            message.contains("what can you do") ||
            message.contains("capabilities") ||
            message.contains("калькулятор") ||
            message.contains("посчитать") ||
            message.contains("считать") {
            return "capabilities"
        }
        
        // Прощания
        if message.contains("пока") ||
            message.contains("до свидания") ||
            message.contains("до встречи") ||
            message.contains("увидимся") ||
            message.contains("bye") ||
            message.contains("goodbye") ||
            message.contains("чао") {
            return "farewell"
        }
        
        // Если ничего не подошло
        return "default"
    }
    
    /// Проверка, является ли сообщение математическим выражением
    private func isMathExpression(_ message: String) -> Bool {
        // Проверяем наличие цифр и математических операторов
        let mathOperators = ["+", "-", "*", "/", "^", "(", ")"]
        let hasNumbers = message.rangeOfCharacter(from: CharacterSet.decimalDigits) != nil
        
        if !hasNumbers {
            return false
        }
        
        // Проверяем наличие хотя бы одного оператора
        for operator_ in mathOperators {
            if message.contains(operator_) {
                return true
            }
        }
        
        return false
    }
    
    /// Вычисление математического выражения
    private func calculateExpression(_ expression: String) -> String {
        // Удаляем пробелы и лишние символы
        let cleanExpression = expression
            .replacingOccurrences(of: " ", with: "")
            .replacingOccurrences(of: ",", with: ".")
            .replacingOccurrences(of: "=", with: "")
            .replacingOccurrences(of: "?", with: "")
        
        do {
            // Создаём NSExpression для вычисления
            let expr = NSExpression(format: cleanExpression)
            
            if let result = expr.expressionValue(with: nil, context: nil) as? NSNumber {
                let number = result.doubleValue
                return formatResult(number)
            } else {
                return getRandomResponse(from: responses["calculation_error"]!)
            }
        } catch {
            print("Ошибка вычисления: \(error)")
            return getRandomResponse(from: responses["calculation_error"]!)
        }
    }
    
    /// Форматирование результата вычисления
    private func formatResult(_ number: Double) -> String {
        let resultString: String
        
        // Проверяем, является ли число целым
        if number.truncatingRemainder(dividingBy: 1) == 0 {
            resultString = String(format: "%.0f", number)
        } else {
            // Округляем до 2 знаков после запятой
            resultString = String(format: "%.2f", number)
        }
        
        // Получаем случайный шаблон ответа
        let template = getRandomResponse(from: responses["calculation_result"]!)
        
        // Подставляем результат в шаблон
        return String(format: template, resultString)
    }
    
    /// Получение случайного ответа из массива
    private func getRandomResponse(from responses: [String]) -> String {
        let randomIndex = Int.random(in: 0..<responses.count)
        return responses[randomIndex]
    }
    
    /// Получение всех доступных категорий
    func getAvailableCategories() -> [String] {
        return Array(responses.keys)
    }
}
