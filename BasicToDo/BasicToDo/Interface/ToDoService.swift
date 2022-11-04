//
//  ToDoService.swift
//  BasicToDo
//
//  Created by taekki on 2022/11/05.
//

import Foundation

protocol ToDoService {
    func create(withTitle title: String)
    func count() -> Int
    func item(at index: Int) -> ToDo
}
