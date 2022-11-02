//
//  ViewModelType.swift
//  SeSACWeek18
//
//  Created by taekki on 2022/11/02.
//

import Foundation

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}
