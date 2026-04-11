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
        // Применяем к переменной time форматирование даты и времени
        let time = DateFormatter()
        // Оставляю только час и минуту
        time.timeStyle = .short
        // Убираю дату
        time.dateStyle = .none
        // Функция Date() выдаёт дату и время в данный момент
        message.append("Вы:  \(text) || \(time.string(from: Date()))")
        text = bot.InOut(text)
        message.append("Бот: \(text) || \(time.string(from: Date()))")
        
        if text == "Сохраняю" {
            _ = "Переписка.txt"
            
        }
        
        // На случай, если пользователь решил завершить чат
        if text == "Прощайте" {
            // Работает с задержкой в 2 секунды
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                exit(0)
            }
        }
    }
    
    // Поле ввода текста пользователя
    @IBOutlet weak var Field: NSTextField!
    // Поле сохраняющее сообщения пользователя и бота
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
    
    // Добавляет поля
    func numberOfRows(in tableView: NSTableView) -> Int {
        return message.count
    }
    
    // Добавляет текст в поля
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let cellIdentifier = NSUserInterfaceItemIdentifier("MessageCell")
        
        if let cell = tableView.makeView(withIdentifier: cellIdentifier, owner: self) as? NSTableCellView {
            cell.textField?.stringValue = message[row]
            return cell
        }
        
        return nil
    }
    
    // Прокрутка до конца текста, при появлении новых сообщений
    func scrollToBottom() {
        DispatchQueue.main.async {
            let numberOfRows = self.MessagesTable.numberOfRows
            if numberOfRows > 0 {
                self.MessagesTable.scrollRowToVisible(numberOfRows - 1)
            }
        }
    }
}

