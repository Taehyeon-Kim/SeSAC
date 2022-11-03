//
//  URLRequestBuilder.swift
//  SeSACWeek18
//
//  Created by taekki on 2022/11/03.
//

import Foundation
import RxSwift

struct URLRequestBuilder {
    
    let manager: URLSessionManager
    var request: URLRequest!
    
    init(manager: URLSessionManager, url: URL? = nil) {
        self.manager = manager
        self.request = URLRequest(url: url ?? URL(string: "/")!)
    }
    
    init(manager: URLSessionManager, builder: URLRequestBuilder) {
        self.manager = manager
        self.request = builder.request
    }
    
    /// path
    @discardableResult
    func add(path: String) -> Self {
        modify { $0.request.url?.appendPathComponent(path) }
    }
    
    /// query
    @discardableResult
    func add(queryItems: [URLQueryItem]) -> Self {
        modify {
            if let url = request.url,
               var components = URLComponents(url: url, resolvingAgainstBaseURL: false) {
                components.queryItems = (components.queryItems ?? []) + queryItems
                $0.request.url = components.url
            }
        }
    }
    
    /// query
    @discardableResult
    public func add(queryItems: [String:String?]) -> Self {
        add(queryItems: queryItems.map { URLQueryItem(name: $0, value: $1) })
    }
    
    /// headers
    @discardableResult
    public func add(value: String, forHeader field: String) -> Self {
        modify { $0.request.addValue(value, forHTTPHeaderField: field) }
    }
    
    /// headers
    @discardableResult
    func add(headers: [String: String]) -> Self {
        modify {
            let allHTTPHeaderFields = $0.request.allHTTPHeaderFields ?? [:]
            $0.request.allHTTPHeaderFields = headers.merging(allHTTPHeaderFields, uniquingKeysWith: { $1 })
        }
    }

    /// http methods
    @discardableResult
    public func method(_ method: HTTPMethod) -> Self {
        modify { $0.request.httpMethod = method.rawValue }
    }
    
    func data<T: Decodable>(type: T.Type, decoder: DataDecoder? = nil) -> Single<T> {
        
        return Single.create { single in
            manager.data(for: request) { response in
                switch response {
                case .success(let data):
                    let decoded = try! JSONDecoder().decode(T.self, from: data)
                    single(.success(decoded))
                case .failure(let error):
                    single(.failure(error))
                }
            }
            
            return Disposables.create()
        }
    }
}

extension URLRequestBuilder {
    
    func modify(_ transform: (inout Self) -> ()) -> Self {
        var request = self  // 빌더 패턴에서 사용할 법 하다.
        transform(&request) // 클로저 실행
        return request
    }
}

extension JSONEncoder: DataEncoder {}
extension PropertyListEncoder: DataEncoder {}

extension JSONDecoder: DataDecoder {}
extension PropertyListDecoder: DataDecoder {}
