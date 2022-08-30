//
//  Person.swift
//  SeSACWeek9
//
//  Created by taekki on 2022/08/30.
//

import Foundation

struct Person: Codable {
    let page, totalPages, totalResults: Int
    let results: [Results]
    
    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

struct Results: Codable {
    let knownForDepartment, name: String
    
    enum CodingKeys: String, CodingKey {
        case knownForDepartment = "known_for_department"
        case name
    }
}
