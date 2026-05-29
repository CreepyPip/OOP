//
//  ContentView.swift
//  datebase
//
//  Created by Семён Зайцев on 12.05.2026.
//

import SwiftUI
let db = DB()

// Наблюдаемый
class AddDate: ObservableObject {
    static let Share = AddDate()
    @Published var users: [User] = []
    
    var ID = 0
    var ShareSurName = ""
    var ShareName = ""
    var ShareSecondName = ""
    var ShareAge = 0
    
    private init () {}
    
    func refresh() {
        if db.connect("lib") {
            _ = db.createTable()
            self.users = db.select()
        }
    }
}

struct ContentView: View {
    @ObservedObject var shared = AddDate.Share
    @State private var selectedUserId: Int?
    var j = 1
    var body: some View {
        VStack {
            Table(shared.users, selection: $selectedUserId) {
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
