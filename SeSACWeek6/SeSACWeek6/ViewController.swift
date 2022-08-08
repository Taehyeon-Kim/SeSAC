//
//  ViewController.swift
//  SeSACWeek6
//
//  Created by taekki on 2022/08/08.
//

import UIKit

import Alamofire
import SwiftyJSON

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(#function, "START")
        requestBlog(query: "Swift")
        print(#function, "END")
    }

    
    // - Alamofire + SwiftyJSON
    // - 검색 키워드
    // - 인증키
    func requestBlog(query: String) {
        print(#function)
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        let url = EndPoint.blog.requestURL + query
        
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
                
                self.requestCafe(query: "고래밥")
                
            case .failure(let error):
                print(error)
            }
        }
    }

    func requestCafe(query: String) {
        print(#function)
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        let url = EndPoint.cafe.requestURL + query
        
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
                
            case .failure(let error):
                print(error)
            }
        }
    }
}

