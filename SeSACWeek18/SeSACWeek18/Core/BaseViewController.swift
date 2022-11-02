//
//  BaseViewController.swift
//  SeSACWeek18
//
//  Created by taekki on 2022/11/02.
//

import UIKit

import RxSwift

class BaseViewController: UIViewController {
    
    var disposeBag = DisposeBag()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        attributes()
        hierarchy()
        constraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func attributes() {}
    func hierarchy() {}
    func constraints() {}
}
