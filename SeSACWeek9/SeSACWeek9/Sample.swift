//
//  Sample.swift
//  SeSACWeek9
//
//  Created by taekki on 2022/09/01.
//

import Foundation

class User<T> {
    
    private var listener: ((T) -> Void)?
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(completionHandler: @escaping (T) -> Void) {
        completionHandler(value)             // 최초 한 번 실행
        listener = completionHandler         // 내부 클로저에 값을 담아줌
    }
}

