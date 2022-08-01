//
//  Constant.swift
//  NetworkBasic
//
//  Created by taekki on 2022/08/01.
//

import Foundation

//enum StoryboardName: String {
//    case Main
//    case Search
//    case Setting
//}

struct StoryboardName {
    
    // 접근 제어를 통해 초기화 방지
    private init() {}
    
    static let main = "Main"
    static let search = "Search"
    static let setting = "Setting"
}

/*
 1. struct type property vs enum type property => 인스턴스 생성 방지(열거형은 초기화 x)
 2. enum case vs enum static => 중복된 내용을 하드 코딩할 수 있나, case에는 제약이 존재(UIColor, UIImage 사용 x)
 */
//enum StoryboardName {
////    var nickname = "고래밥"  // 인스턴스를 만들지 못하기 때문에 저장 프로퍼티 사용 불가
//
//    // 타입 프로퍼티 사용 가능
//    static let main = "Main"
//    static let search = "Search"
//    static let setting = "Setting"
//}
