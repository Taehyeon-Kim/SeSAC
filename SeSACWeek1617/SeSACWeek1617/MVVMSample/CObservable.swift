//
//  CObservable.swift
//  SeSACWeek1617
//
//  Created by taekki on 2022/10/20.
//

import Foundation

class CObservable<T> {
    typealias Listener = ((T) -> Void)
    
    private var listener: Listener?
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(_ closure: @escaping (T) -> Void) {
        closure(value)
        listener = closure
    }
}
