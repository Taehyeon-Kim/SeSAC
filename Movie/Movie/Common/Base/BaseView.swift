//
//  BaseView.swift
//  Movie
//
//  Created by taekki on 2022/08/19.
//

import UIKit

class BaseView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initialUI()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initialUI() {}
    func configureLayout() {}
}
