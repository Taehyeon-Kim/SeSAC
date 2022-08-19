//
//  SignUpView.swift
//  Movie
//
//  Created by taekki on 2022/08/19.
//

import UIKit

import SnapKit
import Then

final class SignUpView: BaseView {
    
    private let titleLabel = UILabel().then {
        $0.text = "NETFLIX"
        $0.textColor = .orange
        $0.font = .boldSystemFont(ofSize: 30)
    }

    private lazy var inputFieldVStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 12
        $0.distribution = .fillEqually
    }
    
    private lazy var signUpButton = UIButton().then {
        $0.configuration = .netflixStyle(title: "회원가입")
    }
    
    private lazy var infoButton = UIButton().then {
        $0.setTitle("추가 정보 입력", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 13)
    }
    
    private let toggleSwitch = UISwitch().then {
        $0.isOn = false
        $0.onTintColor = .red
        $0.thumbTintColor = .white
        $0.backgroundColor = .gray
        $0.layer.cornerRadius = $0.bounds.height / 2
    }

    
    override func initialUI() {
        configureUserInputTextFields()
    }

    override func configureLayout() {
        self.addSubview(titleLabel)
        self.addSubview(inputFieldVStackView)
        self.addSubview(signUpButton)
        self.addSubview(infoButton)
        self.addSubview(toggleSwitch)
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).inset(20)
            $0.centerX.equalToSuperview()
        }

        inputFieldVStackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(40)
            $0.height.equalToSuperview().dividedBy(4)
            $0.centerY.equalToSuperview().offset(-20)
        }
        
        signUpButton.snp.makeConstraints {
            $0.top.equalTo(inputFieldVStackView.snp.bottom).offset(12)
            $0.leading.trailing.equalTo(inputFieldVStackView)
            $0.height.equalTo(44)
        }
        
        infoButton.snp.makeConstraints {
            $0.top.equalTo(signUpButton.snp.bottom).offset(12)
            $0.leading.equalTo(signUpButton.snp.leading)
        }
        
        toggleSwitch.snp.makeConstraints {
            $0.top.equalTo(signUpButton.snp.bottom).offset(12)
            $0.trailing.equalTo(signUpButton.snp.trailing)
        }
    }
    
    private func configureUserInputTextFields() {
        ["이메일 주소 또는 전화번호", "비밀번호", "닉네임", "위치", "추천 코드 입력"].forEach {
            let textField = UserInputTextField()
            textField.placeholderText = $0
            inputFieldVStackView.addArrangedSubview(textField)
        }
    }
}
