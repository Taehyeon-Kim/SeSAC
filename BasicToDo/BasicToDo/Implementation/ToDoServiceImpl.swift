//
//  ToDoServiceImpl.swift
//  BasicToDo
//
//  Created by taekki on 2022/11/05.
//

import Foundation

final class ToDoServiceImpl: ToDoService {
    
    private let repository: Repository
    
    private var todoItems: [ToDo] = []
    
    init(repository: Repository) {
        self.repository = repository
        todoItems = repository.load()   // repository load 메서드 접근
    }
    
    func create(withTitle title: String) {
        let todo = ToDo(id: UUID().uuidString, title: title, done: false, createdAt: Date())
        todoItems.append(todo)
        save()
    }
    
    private func save() {
        repository.save(todos: todoItems)
    }
    
    func count() -> Int {
        return todoItems.count
    }
    
    func item(at index: Int) -> ToDo {
        return todoItems[index]
    }
}
