//
//  LoginViewController.swift
//  InAppPurchase
//
//  Created by taekki on 2022/11/29.
//

import UIKit

final class LoginViewController: UIViewController {
    
    @IBOutlet weak var descLabel: UILabel!

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordCheckTextField: UITextField!
    
    var user = User(email: "", password: "", check: "")
    var validator = Validator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        descLabel.accessibilityIdentifier = "descLabel"
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        descLabel.text = "로그인 버튼을 눌렀습니다."

        user = User(
            email: emailTextField.text!,
            password: passwordTextField.text!,
            check: passwordCheckTextField.text!
        )
        
        if validator.isValid(email: user.email) &&
        validator.isValid(password: user.password) &&
        validator.isEqual(password: user.password, check: user.check) {
            print("로그인 성공")
        } else {
            print("로그인 실패")
        }

        // if isValidEmail() && isValidPassword() && isEqualPassword() {
        //     print("로그인 성공")
        // } else {
        //     print("로그인 실패")
        // }
    }
}

extension LoginViewController {
    
    func isValidEmail() -> Bool {
        guard let email = emailTextField.text else { return false }
        return email.contains("@") && email.count > 8
    }
    
    func isValidPassword() -> Bool {
        guard let password = passwordTextField.text else { return false }
        return password.count >= 6 && password.count < 12
    }
    
    func isEqualPassword() -> Bool {
        guard let password = passwordTextField.text,
              let passwordCheck = passwordCheckTextField.text
        else { return false }
        return password == passwordCheck
    }
}

final class Validator {
    
    func isValid(email: String) -> Bool {
        return email.contains("@") && email.count >= 8
    }
    
    func isValid(password: String) -> Bool {
        return password.count >= 6 && password.count < 12
    }
    
    func isEqual(password: String, check: String) -> Bool {
        return password == check
    }
}

struct User {
    let email: String
    let password: String
    let check: String
}
