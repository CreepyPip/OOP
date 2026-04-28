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
    let b1 = Bot("test", "test", false, false)
    
    // Тест на верность подсчёта
    var t = b1.InOut("123-12*2+10")
    assert(t == "Ответ: 109.0")
    
    // Тест на верность подсчёта по фразе
    t = b1.InOut("Сложи 123.4 и 321.6")
    assert(t == "Ответ: 445.0")
    
    // Тест на обработку фраз
    var text = b1.InOut("привет")
    assert(text == "Привет, test" || text == "Приветствую, test")
    
    // Тест на regex
    text = b1.InOut("ПрИв")
    assert(text == "Привет, test" || text == "Приветствую, test")
}

