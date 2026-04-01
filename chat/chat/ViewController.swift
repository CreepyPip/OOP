//
//  ViewController.swift
//  chat
//
//  Created by Семён on 14.03.2026.
//  Copyright © 2026 Семён. All rights reserved.
//
import Cocoa

// Класс для сохранения данных между окнами
class UserData {
    // Переменная для передачи данных
    static let ShareNames = UserData()
    // Переменная для сохранения имени пользователя
    var nbot = "Бот"
    // Переменная для сохранения имени бота
    var n = "Человек"
    // Функция позволяющая выводить данные из класса
    private init() {}
}

// Класс окна ввода имени
class NameView: NSViewController {
    
    // Функция открывающая окно, принимает id Window Controller
    func openWindow(_ id: String) {
        let sb = NSStoryboard(name: "Main", bundle: nil)
        
        self.chatWindowController = sb.instantiateController(withIdentifier: id) as? NSWindowController
        self.chatWindowController!.showWindow(nil)
    }
    
    // Переменная Window Controller чата
    var chatWindowController: NSWindowController?
    
    // Переменная поля ввода имени пользователя
    @IBOutlet weak var Name: NSTextField!
    // Переменная поля ввода имени бота
    @IBOutlet weak var BotName: NSTextField!
    
    // Функция срабатывающая при нажатии кнопки
    @IBAction func ButtonB(_ sender: Any) {
        // Передаёт данные с поля ввода имени пользователя
        UserData.ShareNames.nbot = BotName.stringValue
        // Передаёт данные с поля ввода имени бота
        UserData.ShareNames.n = Name.stringValue
        // Открывает окно чата
        openWindow("ChatWindow")
        // Закрывает текущее окно (view controller и window controller)
        self.view.window?.close()
    }
}

// Класс главного окна (окна с чатом)
class ViewController: NSViewController, NSTableViewDataSource, NSTableViewDelegate {
    // Принимает имя пользователя
    let nbot = UserData.ShareNames.nbot
    // Принимает имя бота
    let n = UserData.ShareNames.n
    // Создаёт объект
    lazy var bot = Bot(nbot, n)
    
    // Функция принимающая фразу пользователя и выдающая ответ бота
    func BotControl(_ t: String) {
        var text = t
        message.append("Вы:  \(text)")
        
        text = bot.InOut(text)
        message.append("Бот: \(text)")
    }
    
    // Поле ввода текста пользователя
    @IBOutlet weak var Field: NSTextField!
    //
    @IBOutlet weak var MessagesTable: NSTableView!
    
    // Массив
    var message: [String] = []

    // Функция принимающая данные из поля ввода и выдающая текст пользователя и бота на стол
    @IBAction func Button(_ sender: Any) {
        // Запись данных с поля ввода в переменную
        let text = Field.stringValue
        // Проверка на пустое поле
        if text != "" {
                // Функция фраза/ответ
                BotControl(text)
        
                // Очищение поля ввода
                Field.stringValue = ""
                // Обновление стола переписки после обновления массива
                MessagesTable.reloadData()
                // Функция пролистывания до низа переписки
                scrollToBottom()
        }
    }
    
    // Функция изменения пользователем элементов UI
    override func viewDidLoad() {
        test()
        super.viewDidLoad()
        // Изменение стола переписки
        MessagesTable.dataSource = self
        MessagesTable.delegate = self
    }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return message.count
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let cellIdentifier = NSUserInterfaceItemIdentifier("MessageCell")
        
        if let cell = tableView.makeView(withIdentifier: cellIdentifier, owner: self) as? NSTableCellView {
            cell.textField?.stringValue = message[row]
            return cell
        }
        
        return nil
    }
    
    func scrollToBottom() {
        DispatchQueue.main.async {
            let numberOfRows = self.MessagesTable.numberOfRows
            if numberOfRows > 0 {
                self.MessagesTable.scrollRowToVisible(numberOfRows - 1)
            }
        }
    }
}

