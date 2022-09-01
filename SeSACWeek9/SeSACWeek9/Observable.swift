//
//  Observable.swift
//  SeSACWeek9
//
//  Created by taekki on 2022/08/31.
//

import Foundation

/*
 - 데이터를 담아주는 역할
 
 - 지금까지는 데이터가 달라지면 어떻게 해라 A -> B 단방향 구조로 만들었음.
 - 역의 관계도 이루어질 수 있다는 것을 확인해보자.
 */
class Observable<T> {  // 양방향 바인딩
    
    private var listener: ((T) -> Void)?
    
    var value: T {
        didSet {
            print("didSet", value)
            listener?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(_ closure: @escaping (T) -> Void) {
        print(#function)
        closure(value)
        listener = closure
    }
}
