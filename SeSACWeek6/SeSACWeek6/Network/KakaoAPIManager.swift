//
//  KakaoAPIManager.swift
//  SeSACWeek6
//
//  Created by taekki on 2022/08/08.
//

import Alamofire
import SwiftyJSON

struct User {
    fileprivate let name = "고래밥"   // 같은 swift 파일 내에서 다른 클래스, 구조체에서 사용 가능, 다른 스위프트 파일은 X
    private let age = 11            // 같은 swift 파일 내에서 같은 타입에서만 접근 가능
}

extension User {
    
    func example() {
        print(self.name, self.age)
    }
}

struct Person {
    
    func example() {
        let user = User()
        user.name  // (O)
//        user.age    (X)
    }
}

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
