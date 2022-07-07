//
//  SignUpViewController.swift
//  Movie
//
//  Created by taehy.k on 2022/07/07.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var nicknameTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var referralCodeTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var additionalInputButton: UIButton!
    @IBOutlet weak var toggleButton: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .black
        self.configureLabel()
        self.configureTextField(emailTextField, placeholderText: "이메일 주소 또는 전화번호")
        self.configureTextField(passwordTextField, placeholderText: "비밀번호", isSecureTextEntry: true, forKeyboard: .numberPad)
        self.configureTextField(nicknameTextField, placeholderText: "닉네임")
        self.configureTextField(locationTextField, placeholderText: "위치")
        self.configureTextField(referralCodeTextField, placeholderText: "추천 코드 입력")
        self.configureButton(signUpButton, title: "회원가입", titleColor: .black, backgroundColor: .white, cornerRadius: 8)
        self.configureButton(additionalInputButton, title: "추가 정보 입력", titleColor: .lightGray, backgroundColor: .clear)
        self.configureToggleButton()
    }
    
    private func configureLabel() {
        self.titleLabel.text = "TAEFLIX"
        self.titleLabel.textColor = .red
        self.titleLabel.font = UIFont.boldSystemFont(ofSize: 30)
        self.titleLabel.textAlignment = .center
    }
    
    private func configureTextField(
        _ textField: UITextField,
        placeholderText: String,
        isSecureTextEntry: Bool = false,
        forKeyboard keyboardType: UIKeyboardType = .default
    ) {
        textField.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: [.foregroundColor: UIColor.lightGray])
        textField.keyboardType = keyboardType
        textField.isSecureTextEntry = isSecureTextEntry
        textField.textColor = .white
        textField.textAlignment = .center
        textField.borderStyle = .none
        textField.layer.cornerRadius = 8
        textField.backgroundColor = .darkGray
    }
    
    private func configureButton(
        _ button: UIButton,
        title: String,
        titleColor: UIColor,
        backgroundColor: UIColor,
        cornerRadius: CGFloat = 0.0
    ) {
        button.setTitle(title, for: .normal)
        button.setTitleColor(titleColor, for: .normal)
        button.backgroundColor = backgroundColor
        button.layer.cornerRadius = cornerRadius
    }
    
    private func configureToggleButton() {
        self.toggleButton.onTintColor = .red
        self.toggleButton.thumbTintColor = .black
        self.toggleButton.backgroundColor = .white
        self.toggleButton.layer.cornerRadius = self.toggleButton.bounds.height / 2
    }
    
    @IBAction func tapGestureDidTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @IBAction func signUpButtonDidTapped(_ sender: UIButton) {
        view.endEditing(true)
    }
}
