//
//  Constant.swift
//  NetworkBasic
//
//  Created by taekki on 2022/08/01.
//

import Foundation

struct APIKey {
    // key 값은 변하지 않기 때문에 타입 프로퍼티로 사용
    // 키 값을 강조하고 싶다라고 한다면 대문자로 사용해도 무방 (중요도 명시)
    static let WEATHER = "ac1e6a64754ccc0b228fe0e15fa9f76"
    static let BOXOFFICE = "ba371c92e519dd60e2a78ed1df301638"
    static let NAVER_ID = "Q4CAuMAnJyojkpya1jAM"
    static let NAVER_SECRET = "PnUraoqRVI"
    static let TMDB = "9db4966ed1e5f03c2140e027b6f44183"
}

struct EndPoint {
    static let boxOfficeURL = "http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?"
    static let lottoURL = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber"
    static let translateURL = "https://openapi.naver.com/v1/papago/n2mt"
}

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
