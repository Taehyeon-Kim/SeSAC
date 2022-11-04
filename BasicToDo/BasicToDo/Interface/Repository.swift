//
//  Repository.swift
//  BasicToDo
//
//  Created by taekki on 2022/11/05.
//

import Foundation

protocol Repository {
    func load() -> [ToDo]
    func save(todos: [ToDo])
}
