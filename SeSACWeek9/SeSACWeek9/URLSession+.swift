//
//  URLSession+.swift
//  SeSACWeek9
//
//  Created by taekki on 2022/08/30.
//

import Foundation

extension URLSession {
    
    typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void
    
    @discardableResult
    func customDataTask(_ endpoint: URLRequest, completion: @escaping CompletionHandler) -> URLSessionDataTask {
        let task = dataTask(with: endpoint, completionHandler: completion)
        task.resume()
        return task
    }
    
    static func request<T: Decodable>(
        _ session: URLSession = .shared,
        endpoint: URLRequest,
        completion: @escaping (T?, APIError?) -> Void
    )
    {
        session.customDataTask(endpoint) { data, response, error in
            
            DispatchQueue.main.async {
                guard error == nil else {
                    completion(nil, .failedRequest)
                    return
                }
                
                guard let data = data else {
                    completion(nil, .noData)
                    return
                }

                guard let response = response as? HTTPURLResponse else {
                    completion(nil, .invaildResponse)
                    return
                }
                
                guard response.statusCode == 200 else {
                    completion(nil, .failedRequest)
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(T.self, from: data)
                    completion(result, nil)
                    
                } catch {
                    completion(nil, .invaildData)
                }
            }
        }
    }
}
