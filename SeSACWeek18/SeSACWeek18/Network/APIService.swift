//
//  APIService.swift
//  SeSACWeek18
//
//  Created by taekki on 2022/11/02.
//

import Foundation

import Alamofire
import RxSwift

final class APIService {
    
    static let shared = APIService()
    private init() {}
    
    struct LoginResponse: Codable {
        let token: String
    }
    
    struct UserResponse: Decodable {
        let user: UserInfo
        
        struct UserInfo: Decodable {
            let photo: String
            let email: String
            let username: String
            let id: String
        }
    }
    
    func singup(username: String, email: String, password: String) {
        let signupEndpoint = SeSACAPI.signup(username, email, password)
        let url = signupEndpoint.url
        let header: HTTPHeaders = signupEndpoint.headers
        let parameter: [String: String]? = signupEndpoint.parameters
        
        AF.request(url, method: .post, parameters: parameter, headers: header)
            .responseString { response in
                print(response.response?.statusCode ?? 0)
            }
    }
    
    func login(email: String, password: String) -> Single<LoginResponse> {
        return Single.create { observer in
            let loginEndpoint = SeSACAPI.login(email, password)
            let url = loginEndpoint.url
            let header: HTTPHeaders = loginEndpoint.headers
            let parameter: [String: String]? = loginEndpoint.parameters
            
            AF.request(url, method: .post, parameters: parameter, headers: header)
                .validate(statusCode: 200...299)
                .responseDecodable(of: APIService.LoginResponse.self) { response in
                    switch response.result {
                    case let .success(data):
                        UserDefaults.standard.set(data.token, forKey: "token")
                        observer(.success(data))
                    case let .failure(error):
                        observer(.failure(error))
                    }
                }
            
            return Disposables.create()
        }
    }
    
    func profile() {
        let url = SeSACAPI.profile.url
        let header: HTTPHeaders = SeSACAPI.profile.headers
        
        AF.request(url, method: .get, headers: header)
            .validate(statusCode: 200...299)
            .responseDecodable(of: APIService.UserResponse.self) { response in
                switch response.result {
                case let .success(data):
                    print("🎉 \(data.user.username)님, 환영합니다")
                case let .failure(error):
                    print("\(response.response?.statusCode ?? 0) fail :: \(error.localizedDescription)")
                }
            }
    }
}
