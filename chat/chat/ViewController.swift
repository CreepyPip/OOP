//
//  ViewController.swift
//  chat
//
//  Created by Семён on 14.03.2026.
//  Copyright © 2026 Семён. All rights reserved.
//
import Cocoa

var nbot = "Бот"
var n = "Человек"

class NameView: NSViewController {
    
    func openWindow(_ id: String) {
        let sb = NSStoryboard(name: "Main", bundle: nil)
        
        self.chatWindowController = sb.instantiateController(withIdentifier: id) as? NSWindowController
        self.chatWindowController!.showWindow(nil)
    }
    
    var chatWindowController: NSWindowController?
    
    @IBOutlet weak var Name: NSTextField!
    @IBOutlet weak var BotName: NSTextField!
    
    @IBAction func ButtonB(_ sender: Any) {
        nbot = BotName.stringValue
        n = Name.stringValue
        openWindow("ChatWindow")
        self.view.window?.close()
    }
}


class ViewController: NSViewController, NSTableViewDataSource {
    let bot = Bot(nbot, n)
    
    func InOut(_ t: String) -> String {
        var text = t
        
        text = bot.InOut(text)
        return text
    }
    
    @IBOutlet weak var Field: NSTextField!
    @IBOutlet weak var MessagesTable: NSTableView!
    
    //
    var message: [String] = []

    
    @IBAction func Button(_ sender: Any) {
        let text = Field.stringValue
        if text != "" {
                message.append("Вы:  \(text)")
        
                let out = InOut(text)
                message.append("Бот: \(out)")
        
                Field.stringValue = ""
                MessagesTable.reloadData()
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MessagesTable.dataSource = self
    }
    
    func tableView(_ tableView: NSTableView, objectValueFor tableColumn: NSTableColumn?, row: Int) -> Any? {
        return message[row]
    }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return message.count
    }
    
    func tableView(_ tableView: NSTableView, setObjectValue object: Any?, for tableColumn: NSTableColumn?, row: Int) {
        if let newText = object as? String {
            message[row] = newText
        }
    }
}

