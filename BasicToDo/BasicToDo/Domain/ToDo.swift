//
//  ToDo.swift
//  BasicToDo
//
//  Created by taekki on 2022/11/05.
//

import Foundation

struct ToDo: Identifiable, Codable {
    let id: String
    let title: String
    var done: Bool
    let createdAt: Date
}
