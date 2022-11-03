//
//  DataEncoder.swift
//  SeSACWeek18
//
//  Created by taekki on 2022/11/03.
//

import Foundation

protocol DataEncoder {
    func encode<T: Encodable>(_ value: T) throws -> Data
}
