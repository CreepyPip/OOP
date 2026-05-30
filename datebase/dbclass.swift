//
//  dbclass.swift
//  datebase
//
//  Created by Семён Зайцев on 23.05.2026.
//

import Foundation
import SQLite

struct User: Identifiable {
	let id: Int
	let surname: String
	let name: String
	let secondname: String
	let age: Int
}

class DB {    
	// Переменная проверки подключения
	var db: Connection?
	
	// Подключение к базе данных
	func connect(_ name: String) -> Bool {
		do {
			let path = URL(fileURLWithPath: "/Users/ananas/Documents/OOP-main/datebase")
			let fileURL = path.appendingPathComponent("\(name).db")
			
			self.db = try Connection(fileURL.path)
			return true
		} catch {
			return false
		}
	}
	
	// Создание таблицы(если не создана)
	func createTable() -> Bool {
		let req = """
		CREATE TABLE IF NOT EXISTS "db" (
		  "id" integer PRIMARY KEY,
		  "surname" text,
		  "name" text,
		  "second_name" text,
		  "age" integer
		);
		"""
		
		guard let connect = db else {return false}
		do{
			try connect.execute(req)
			return true
		} catch {
			return false
		}
	}
	
	// Добавить данные в таблицу
	func insert(_ id: Int,_ surname: String,_ name: String,_ secondname: String,_ age: Int) -> Bool {
		let req = """
		INSERT INTO "db" VALUES
		(\(id), '\(surname)', '\(name)', '\(secondname)', \(age));
		"""
		
		guard let connect = db else {return false}
		do{
			try connect.execute(req)
			return true
		} catch {
			return false
		}
	}
	
	// Получить данные с таблицы
	func select() -> [User]{
		let req = """
		SELECT id, surname, name, second_name, age FROM db;
		"""
		var users: [User] = []
		guard let connect = db else {return []}
		do{
			for i in try connect.prepare(req) {
				let id = Int(i[0] as? Int64 ?? 0)
				let surname = i[1] as? String ?? ""
				let name = i[2] as? String ?? ""
				let secondName = i[3] as? String ?? ""
				let age = Int(i[4] as? Int64 ?? 0)
				
				users.append(User(id: id, surname: surname, name: name, secondname: secondName, age: age))
			}
		} catch {
			return []
		}
		return users
	}
	
	func getid() -> Int {
		let req = """
		SELECT id FROM db;
		"""
		var index: Int = 0
		guard let connect = db else {return 0}
		do{
			for i in try connect.prepare(req) {
				let id = Int(i[0] as? Int64 ?? 0)
				index = id
			}
		} catch {
			return 0
		}
		return index + 1
	}
	
	// Удаление строки
	func delete(_ id: Int) -> Bool{
		let req = """
		DELETE FROM db
		WHERE id = \(id);
		"""
		
		guard let connect = db else {return false}
		do{
			try connect.execute(req)
			return true
		} catch {
			return false
		}
	}
}
