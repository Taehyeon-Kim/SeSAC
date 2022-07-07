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
    @IBOutlet weak var additionalInputButton: UIButton!
    @IBOutlet weak var toggleButton: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureLabel()
        self.configureTextField(emailTextField, placeholderText: "이메일 주소 또는 전화번호")
        self.configureTextField(passwordTextField, placeholderText: "비밀번호", isSecureTextEntry: true, forKeyboard: .numberPad)
        self.configureTextField(nicknameTextField, placeholderText: "닉네임")
        self.configureTextField(locationTextField, placeholderText: "위치")
        self.configureTextField(referralCodeTextField, placeholderText: "추천 코드 입력")
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
}
