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
        requestBlog(query: "Swift")
    }

    
    // - Alamofire + SwiftyJSON
    // - 검색 키워드
    // - 인증키
    func requestBlog(query: String) {
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        let url = EndPoint.blog.requestURL + query
        
        let headers: HTTPHeaders = [
            "Authorization": "KakaoAK \(APIKey.kakao)"
        ]
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

