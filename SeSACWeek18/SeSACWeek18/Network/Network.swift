//
//  Network.swift
//  SeSACWeek18
//
//  Created by taekki on 2022/11/03.
//

import Foundation

import Alamofire

final class Network {
    
    static let shared = Network()
    private init() {}
}

extension Network {
    func request<T: Decodable>(
        _ type: T.Type = T.self,
        url: URL,
        method: HTTPMethod = .get,
        parameters: [String: String]? = nil,
        headers: HTTPHeaders,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        AF.request(url, method: .get, parameters: parameters, headers: headers)
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let data):
                    completion(.success(data))
                case .failure:
                    guard let statusCode = response.response?.statusCode else { return }
                    guard let error = SeSACError(rawValue: statusCode) else { return }
                    
                    completion(.failure(error))
                }
            }
    }
}
