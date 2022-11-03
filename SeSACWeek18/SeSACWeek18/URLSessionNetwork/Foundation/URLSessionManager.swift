//
//  URLSessionManager.swift
//  SeSACWeek18
//
//  Created by taekki on 2022/11/03.
//

import Foundation
import RxSwift

protocol URLSessionManager: AnyObject {
    
    var baseURL: URL? { get }
    
    var encoder: DataEncoder { get }
    var decoder: DataDecoder { get }
    
    func request(forURL url: URL?) -> URLRequestBuilder
    func data(for: URLRequest, completion: @escaping (Result<Data, Error>) -> Void)
}

extension URLSessionManager {
    
    func request() -> URLRequestBuilder {
        self.request(forURL: nil)
    }
}
