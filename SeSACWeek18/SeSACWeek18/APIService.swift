//
//  APIService.swift
//  SeSACWeek18
//
//  Created by taekki on 2022/11/02.
//

import Foundation

import Alamofire

class APIService {
    static let shared = APIService()
    private init() {}
    
    struct Login: Codable {
        let token: String
    }
    
    struct User: Decodable {
        let user: UserInfo
        
        struct UserInfo: Decodable {
            let photo: String
            let email: String
            let username: String
            let id: String
        }
    }
    
    func singup() {
        let url = "http://api.memolease.com/api/v1/users/signup"
        let header: HTTPHeaders = ["Content-Type": "application/x-www-form-urlencoded"]
        let parameter: [String: String] = [
            "userName": "testJack99",
            "email": "testJack99@testJack.com",
            "password": "12345678",
        ]
        
        AF.request(url, method: .post, parameters: parameter, headers: header)
            .responseString { response in
                print(response.response?.statusCode)
            }
    }
    
    func login() {
        let url = "http://api.memolease.com/api/v1/users/login"
        let header: HTTPHeaders = ["Content-Type": "application/x-www-form-urlencoded"]
        let parameter: [String: String] = [
            "userName": "testJack99",
            "email": "testJack99@testJack.com",
            "password": "12345678",
        ]
        
        AF.request(url, method: .post, parameters: parameter, headers: header)
            .validate(statusCode: 200...299)
            .responseDecodable(of: APIService.Login.self) { response in
                switch response.result {
                case let .success(data):
                    print("🎉 Login success!! Fetching the token :: \(data.token)")
                    UserDefaults.standard.set(data.token, forKey: "token")
                case let .failure(error):
                    print("\(response.response?.statusCode ?? 0) fail :: \(error.localizedDescription)")
                }
            }
    }
    
    func profile() {
        let url = "http://api.memolease.com/api/v1/users/me"
        let header: HTTPHeaders = [
            "Content-Type": "application/x-www-form-urlencoded",
            "Authorization": "Bearer \(UserDefaults.standard.string(forKey: "token") ?? "")"
        ]
        
        AF.request(url, method: .get, headers: header)
            .validate(statusCode: 200...299)
            .responseDecodable(of: APIService.User.self) { response in
                switch response.result {
                case let .success(data):
                    print("🎉 \(data.user.username)님, 환영합니다")
                case let .failure(error):
                    print("\(response.response?.statusCode ?? 0) fail :: \(error.localizedDescription)")
                }
            }
    }
}
