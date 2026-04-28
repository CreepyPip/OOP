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
    // Переменные для параметров
    var think = false
    var briefly = true
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
    
    @IBAction func OptionsButton(_ sender: Any) {
        openWindow("OptionWindow")
    }
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

// Класс окна параметров
class OptionView: NSViewController {
    // Переменная краткого ответа
    var br = false
    // Переменная мышления
    var th = false
    // Не кнопки, а CheckBox
    @IBOutlet weak var ThinkButton: NSButton!
    @IBOutlet weak var BrieflyButton: NSButton!

    // Функция на применение параметров
    @IBAction func ApplyButton(_ sender: Any) {
        // Если чекбокс прожали, записывается в переменную
        br = BrieflyButton.state == .on
        th = ThinkButton.state == .on
        // Запись в память
        UserData.ShareNames.think = th
        UserData.ShareNames.briefly = br
        // Закрытие окна
        self.view.window?.close()
    }
}

// Класс главного окна (окна с чатом)
class ViewController: NSViewController, NSTableViewDataSource, NSTableViewDelegate {
    // Принимает имя пользователя
    let nbot = UserData.ShareNames.nbot
    // Принимает имя бота
    let n = UserData.ShareNames.n
    // Принимает параметр мышление LLM
    let th = UserData.ShareNames.think
    // Принимает параметр краткого ответа LLM
    let br = UserData.ShareNames.briefly
    // Создаёт объект
    lazy var bot = Bot(nbot, n, th, br)
    var new_line = ""
    
    // Функция для переноса
    // Принимает текст, выдаёт индекс, на котором можно перенести строку
    func isspace(_ text: String) -> Int {
        // Если текст не меньше 70 элементов
        if text.count >= 70 {
            // Отделаются первые 70 элементов
            let text1 = String(text.prefix(70))
            // Поиск переносов текста
            if let range = text1.range(of: "\\n") {
                let num = text1.distance(from: text1.startIndex, to: range.lowerBound)
                return num + 1
            }
            // Поиск элемента (\n)
            if let indexn = text1.firstIndex(of: "\n"){
                let num = text1.distance(from: text1.startIndex, to: indexn)
                return num + 1
            }
            // Поиск последнего пробела
            if let index = text1.lastIndex(of: " ") {
                let num = text1.distance(from: text1.startIndex, to: index)
                return num
            }
                
        }
        // Если текст меньше 70 элементов, возвращает максимум
        return 70
    }
    
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
        new_line = "Вы: \(text) || \(time.string(from: Date()))"
        
        // Индекс переноса
        var index = isspace(new_line)
        
        // Вывод на экран с переносами фразы пользователя
        while (new_line.count > index) {
                message.append(String(new_line.prefix(index)))
            new_line.removeFirst(index)
            index = isspace(String(new_line.prefix(70)))
        }
            message.append(new_line)

        // Получаем ответ от бота
        text = bot.InOut(text)

        // Передаём целый текст в переменную
        new_line = "Бот: \(text) || \(time.string(from: Date()))"
        
        index = isspace(new_line)
        
        // Вывод на экран с переносами фразы бота
        while (new_line.count > index) {
                message.append(String(new_line.prefix(index)))
            new_line.removeFirst(index)
            index = isspace(String(new_line.prefix(70)))
        }
            message.append(new_line)
        
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

