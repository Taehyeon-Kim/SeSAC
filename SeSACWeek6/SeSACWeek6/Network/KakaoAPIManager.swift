//
//  KakaoAPIManager.swift
//  SeSACWeek6
//
//  Created by taekki on 2022/08/08.
//

import Alamofire
import SwiftyJSON

final class KakaoAPIManager {
    
    static let shared = KakaoAPIManager()
    
    private init() {}
    
    func callRequest(type: EndPoint, query: String, completion: @escaping ((JSON) -> ())) {
        print(#function)
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        let url = type.requestURL + query
        
        let headers: HTTPHeaders = [
            "Authorization": "KakaoAK \(APIKey.kakao)"
        ]
        
        // Alamofire -> URLSession Framework -> 비동기 Request
        // completion handler에서 Alamofire가 알아서 메인 스레드로 바꿔줌
        AF.request(url, method: .get, headers: headers).validate().responseData { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                completion(json)
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
