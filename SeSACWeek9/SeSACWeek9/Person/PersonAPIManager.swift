//
//  PersonAPIManager.swift
//  SeSACWeek9
//
//  Created by taekki on 2022/08/30.
//

/*
 KEY: 9db4966ed1e5f03c2140e027b6f44183
 */

import Foundation

final class PersonAPIManager {
    
    static func requestPerson(query: String, completion: @escaping ((Person?, APIError?) -> Void)) {

        let url = URL(string: "https://api.themoviedb.org/3/search/person?api_key=9db4966ed1e5f03c2140e027b6f44183&language=en-US&query=\(query)&page=1&include_adult=false&region=ko-KR")!

        let scheme = "https"
        let host = "api.themoviedb.org"
        let path = "/3/search/person"
        
        let language = "ko-KR"
        let key = "9db4966ed1e5f03c2140e027b6f44183"
        let query = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        var component = URLComponents()
        component.scheme = scheme
        component.host = host
        component.path = path
        component.queryItems = [
            URLQueryItem(name: "api_key", value: key),
            URLQueryItem(name: "query", value: query),
            URLQueryItem(name: "page", value: "1"),
            URLQueryItem(name: "region", value: language),
        ]
        
        URLSession.shared.dataTask(with: component.url!) { data, response, error in
            
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
                    let result = try JSONDecoder().decode(Person.self, from: data)
                    completion(result, nil)
                    
                } catch {
                    completion(nil, .invaildData)
                }
            }

        }.resume()
        
    }
}
