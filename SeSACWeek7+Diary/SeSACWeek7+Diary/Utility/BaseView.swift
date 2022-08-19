//
//  BaseView.swift
//  SeSACWeek7+Diary
//
//  Created by taekki on 2022/08/19.
//

import UIKit

class BaseView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
        setConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {}
    func setConstraints() {}
}
