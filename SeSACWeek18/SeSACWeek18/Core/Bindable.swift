//
//  Bindable.swift
//  SeSACWeek18
//
//  Created by taekki on 2022/11/02.
//

import Foundation

protocol Bindable {
    associatedtype ViewModelType
    
    var viewModel: ViewModelType { get }
    func bind()
}
