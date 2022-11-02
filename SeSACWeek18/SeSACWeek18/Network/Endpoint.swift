//
//  Endpoint.swift
//  SeSACWeek18
//
//  Created by taekki on 2022/11/02.
//

import Foundation
import Alamofire

enum SeSACAPI {
    case signup(String, String, String)
    case login(String, String)
    case profile
}

extension SeSACAPI {
    var baseURL: String {
        return "http://api.memolease.com/api/v1"
    }
    
    var path: String {
        switch self {
        case .signup:
            return "/users/signup"
        case .login:
            return "/users/login"
        case .profile:
            return "/users/me"
        }
    }
    
    var url: URL {
        return URL(string: baseURL + path)!
    }
    
    var headers: HTTPHeaders {
        switch self {
        case .signup, .login:
            return ["Content-Type": "application/x-www-form-urlencoded"]
        case .profile:
            return [
                "Content-Type": "application/x-www-form-urlencoded",
                "Authorization": "Bearer \(UserDefaults.standard.string(forKey: "token") ?? "")"
            ]
        }
    }
    
    var parameters: [String: String]? {
        switch self {
        case let .signup(username, email, password):
            return [
                "userName": username,
                "email": email,
                "password": password,
            ]
        case let .login(email, password):
            return [
                "email": email,
                "password": password,
            ]
        case .profile:
            return nil
        }
    }
}
