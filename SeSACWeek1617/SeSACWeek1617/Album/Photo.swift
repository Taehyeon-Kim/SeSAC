//
//  Photo.swift
//  SeSACWeek1617
//
//  Created by taekki on 2022/10/26.
//

import Foundation

struct Photo: Identifiable, Hashable {
    let id = UUID()
    let imagePath: String
}

extension Photo {
    static func dummy() -> [Photo] {
        return [
            Photo(imagePath: ""),
            Photo(imagePath: ""),
            Photo(imagePath: ""),
            Photo(imagePath: ""),
            Photo(imagePath: ""),
            Photo(imagePath: ""),
            Photo(imagePath: ""),
            Photo(imagePath: ""),
            Photo(imagePath: ""),
            Photo(imagePath: ""),
            Photo(imagePath: ""),
            Photo(imagePath: ""),
        ]
    }
}
