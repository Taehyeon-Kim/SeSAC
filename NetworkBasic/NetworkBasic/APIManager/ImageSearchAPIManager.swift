//
//  ImageSearchAPIManager.swift
//  NetworkBasic
//
//  Created by taekki on 2022/08/05.
//

import UIKit

import Alamofire
import SwiftyJSON

// 클래스 싱글톤 패턴 vs 구조체 싱글톤 패턴
// - 왜 구조체는 싱글톤 패턴으로 사용하면 안될까?
final class ImageSearchAPIManager {
    
    static let shared = ImageSearchAPIManager()
    
    private init() {}
    
    typealias completionHandler = (Int, [String]) -> ()
    
    // non-escaping => @escaping: 밖에서 사용하겠다.
    func fetchImageData(query: String, startPage: Int, completionHandler: @escaping completionHandler) {
        let text = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = EndPoint.imageSearchURL + "query=\(text)&display=100&start=\(startPage)"
        let headers: HTTPHeaders = [
            "X-Naver-Client-Id": APIKey.NAVER_ID,
            "X-Naver-Client-Secret": APIKey.NAVER_SECRET
        ]
        
        AF.request(url, method: .get, headers: headers)
            .validate(statusCode: 200...500)
            .responseData(queue: .global()) { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")

                let totalCount = json["total"].intValue
                let list = json["item"].arrayValue.map { $0["thumbnail"].stringValue }
                
                completionHandler(totalCount, list)
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
