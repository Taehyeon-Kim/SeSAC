//
//  DataDecoder.swift
//  SeSACWeek18
//
//  Created by taekki on 2022/11/03.
//

import Foundation

protocol DataDecoder {
    func decode<T: Decodable>(_ value: T.Type, from data: Data) throws -> T
}
