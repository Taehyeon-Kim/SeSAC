//
//  UserDefaultRepository.swift
//  BasicToDo
//
//  Created by taekki on 2022/11/05.
//

import Foundation

final class UserDefaultRepository: Repository {
    
    private let toDoKey = "todos"
    private var database: UserDefaults { UserDefaults.standard }
    
    func load() -> [ToDo] {
        guard let json = UserDefaults.standard.string(forKey: toDoKey),
              let data = json.data(using: .utf8) else {
            return []
        }
        return (try? JSONDecoder().decode([ToDo].self, from: data)) ?? []
    }
    
    func save(todos: [ToDo]) {
        guard let data = try? JSONEncoder().encode(todos),
              let json = String(data: data, encoding: .utf8) else {
            return
        }
        UserDefaults.standard.set(json, forKey: toDoKey)
    }
}
