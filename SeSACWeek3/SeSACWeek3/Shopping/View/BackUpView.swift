//
//  BackUpView.swift
//  SeSACWeek3
//
//  Created by taekki on 2022/08/25.
//

import UIKit

import SnapKit
import Then


final class BackUpView: UIView {
    
    lazy var backUpButton = UIButton()
    lazy var restoreButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configureUI() {
        self.backgroundColor = .systemBackground
        
        backUpButton.do {
            $0.backgroundColor = .black
            $0.setTitle("백업하기", for: .normal)
            $0.setTitleColor(.white, for: .normal)
            $0.layer.cornerRadius = 8
        }
        
        restoreButton.do {
            $0.backgroundColor = .black
            $0.setTitle("복구하기", for: .normal)
            $0.setTitleColor(.white, for: .normal)
            $0.layer.cornerRadius = 8
        }
    }
    
    func configureLayout() {
        addSubview(backUpButton)
        addSubview(restoreButton)
        
        backUpButton.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.centerY.equalToSuperview().offset(-40)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        restoreButton.snp.makeConstraints {
            $0.top.equalTo(backUpButton.snp.bottom).offset(20)
            $0.height.equalTo(50)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
    }
}
