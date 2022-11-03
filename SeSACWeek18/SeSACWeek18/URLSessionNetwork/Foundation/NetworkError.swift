//
//  NetworkError.swift
//  SeSACWeek18
//
//  Created by taekki on 2022/11/03.
//

import Foundation

enum NetworkError: LocalizedError {
    case unknownError
    case invalidHTTPStatusCode(Int)
    case components
    case urlRequest(Error)
    case parsing(Error)
    case emptyData
    case decodeError

    var errorDescription: String? {
        switch self {
        case .unknownError: return "❌ 알 수 없는 에러"
        case .invalidHTTPStatusCode: return "❌ 상태 코드 200 ~ 299 아님"
        case .components: return "❌ URLComponents 생성 에러"
        case .urlRequest: return "❌ URLRequest 관련 에러 발생"
        case .parsing: return "❌ 데이터 Parsing 중 에러 발생"
        case .emptyData: return "❌ 비어있는 데이터"
        case .decodeError: return "❌ 디코딩 에러 발생"
        }
    }
}
