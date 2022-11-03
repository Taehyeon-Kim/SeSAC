//
//  HTTPMethod.swift
//  SeSACWeek18
//
//  Created by taekki on 2022/11/03.
//

import Foundation

/// Swift의 URLRequest httpMethod 프로퍼티는 String이다.
/// default는 "GET"이다.
enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}
