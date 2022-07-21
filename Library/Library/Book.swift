//
//  Book.swift
//  Library
//
//  Created by taekki on 2022/07/21.
//

import Foundation

struct Book {
    let bookTitie: String
    let bookRate: String
    let bookImageURL: String = ""
}

extension Book {
    static let sampleData: [Book] = [
        Book(bookTitie: "책 1", bookRate: "7.7"),
        Book(bookTitie: "책 2", bookRate: "9.88"),
        Book(bookTitie: "책 3", bookRate: "5.6"),
        Book(bookTitie: "책 1", bookRate: "7.7"),
        Book(bookTitie: "책 2", bookRate: "9.88"),
        Book(bookTitie: "책 3", bookRate: "5.6"),
        Book(bookTitie: "책 1", bookRate: "7.7"),
        Book(bookTitie: "책 2", bookRate: "9.88"),
        Book(bookTitie: "책 3", bookRate: "5.6"),
    ]
}
