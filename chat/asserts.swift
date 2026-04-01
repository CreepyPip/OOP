//
//  asserts.swift
//  chat
//
//  Created by Семён on 28.03.2026.
//  Copyright © 2026 Семён. All rights reserved.
//

import Foundation

func test() {
    // Создаю объект
    let b1 = Bot("test", "test")
    
    // Тест на верность подсчёта
    let t = b1.InOut("123-12*2+10")
    assert(t == "Ответ: 109.0")
    
    // Тест на обработку фраз
    let text = b1.InOut("Привет")
    assert(text == "Привет, test" || text == "Приветствую, test")
}

