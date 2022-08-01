//
//  UserDefaultsHelper.swift
//  NetworkBasic
//
//  Created by taekki on 2022/08/01.
//

import Foundation

// UserDefaults랑 같은 형태로 맞추는 형태로 class로 선언
// struct에서 싱글톤패턴 가능하지 않음
class UserDefaultsHelper {
    
    // shared or standard or default
    static let standard = UserDefaultsHelper()
    let userDefaults = UserDefaults.standard // singleton pattern
    // 자기 자신의 인스턴스를 타입 프로퍼티 형태로 가지고 있음
    
    private init() {}
    
    enum Key: String {
        case nickname, age
    }
    
    var nickname: String {
        get {
            return userDefaults.string(forKey: Key.nickname.rawValue) ?? "대장"
        }
        set { // 연산 프로퍼티 parameter
            userDefaults.set(newValue, forKey: Key.nickname.rawValue)
        }
    }
    
    var age: Int {
        get {
            // defaults가 0이라 nil이 아님
            return userDefaults.integer(forKey: Key.age.rawValue)
        }
        set {
            userDefaults.set(newValue, forKey: Key.age.rawValue)
        }
    }
}
