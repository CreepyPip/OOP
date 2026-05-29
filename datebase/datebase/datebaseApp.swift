//
//  datebaseApp.swift
//  datebase
//
//  Created by Семён Зайцев on 12.05.2026.
//

import SwiftUI

@main
struct datebaseApp: App {
    init() {
        tests()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        
        WindowGroup {
            AddView()
        }
    }
}
