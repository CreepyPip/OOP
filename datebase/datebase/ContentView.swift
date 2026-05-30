//
//  ContentView.swift
//  datebase
//
//  Created by Семён Зайцев on 12.05.2026.
//

import SwiftUI
let db = DB()

// Наблюдаемый класс
class AddDate: ObservableObject {
    // Переменная передачи данных
    static let Share = AddDate()
    // Массив структур
    @Published var users: [User] = []
    
    // Передающиеся переменные
    var ID = 0
    var ShareSurName = ""
    var ShareName = ""
    var ShareSecondName = ""
    var ShareAge = 0
    
    // Конструктор для передачи
    private init () {}
    
    // Обновление таблицы
    func refresh() {
        if db.connect("lib") {
            _ = db.createTable()
            self.users = db.select()
        }
    }
}

// Контроллер первого окна
struct ContentView: View {
    @ObservedObject var shared = AddDate.Share
    @State private var selectedUserId: Int?
    @State private var sort = [KeyPathComparator(\User.id)]
    var j = 1
    
    var body: some View {
        VStack {
            Table(shared.users.sorted(using: sort), selection: $selectedUserId) {
                TableColumn("id") { user in
					Text("\(user.id)")}
                .width(15)
                TableColumn("Фамилия") { user in
                    Text("\(user.surname)")}
                TableColumn("Имя") { user in
                    Text("\(user.name)")}
                TableColumn("Отчество") { user in
                    Text("\(user.secondname)")}
                TableColumn("Возраст") { user in
                    Text("\(user.age)")}
                .width(50)
            }
            Text("Сортировать по:")
            HStack{
                Button("id") {
                    sort = [KeyPathComparator(\User.id)]
					shared.refresh()
                }
                Button("Фамилия") {
                    sort = [KeyPathComparator(\User.surname)]
					shared.refresh()
                }
                Button("Имя") {
                    sort = [KeyPathComparator(\User.name)]
					shared.refresh()
                }
                Button("Отчество") {
                    sort = [KeyPathComparator(\User.secondname)]
					shared.refresh()
                }
                Button("Возраст") {
                    sort = [KeyPathComparator(\User.age)]
					shared.refresh()
                }
            }
            Text("")
            HStack(spacing: 50){
                Button("Добавить") {
                    if db.connect("lib") {
                        AddView().openInWindow(title: "Запись", sender: nil)
                    }
                }
                Button("Удалить") {
                    if db.connect("lib") {
                        _ = db.delete(selectedUserId ?? -1)
                        shared.refresh()
                    }
                }
            }
        }
        .padding()
        .onAppear {
            _ = db.createTable()
            shared.refresh()
        }
    }
}

// Контроллер второго окна
struct AddView: View {
    @State private var SurName = ""
    @State private var Name = ""
    @State private var SecondName = ""
    @State private var Age = ""
    var body: some View {
        VStack {
            Text("Фамилия")
            TextField("", text: $SurName)
            Text("Имя")
            TextField("", text: $Name)
            Text("Отчество")
            TextField("", text: $SecondName)
            Text("Возраст")
            TextField("", text: $Age)
            Button("Добавить") {
                AddDate.Share.ID = db.getid()
                AddDate.Share.ShareSurName = SurName
                AddDate.Share.ShareName = Name
                AddDate.Share.ShareSecondName = SecondName
                AddDate.Share.ShareAge = Int(Age)!
                
                if db.connect("lib") {
                    _ = db.insert(
                        AddDate.Share.ID,
                        AddDate.Share.ShareSurName,
                        AddDate.Share.ShareName,
                        AddDate.Share.ShareSecondName,
                        AddDate.Share.ShareAge
                    )
                        
                    AddDate.Share.refresh()
                }
                
                NSApp.keyWindow?.close()
            }
        }
            .padding()
    }
}

// Превью UI
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        AddView()
    }
}

// Функция открытия окна
extension View {
    func openInWindow(title: String, sender: Any?) {
        let controller = NSHostingController(rootView: self)
        let window = NSWindow(contentViewController: controller)
        window.title = title
        window.makeKeyAndOrderFront(sender)
    }
}

