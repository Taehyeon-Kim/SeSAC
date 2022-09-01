//
//  LoginViewController.swift
//  SeSACWeek9
//
//  Created by taekki on 2022/09/01.
//

import UIKit

final class LoginViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    let viewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    // ViewController Role 2. 데이터를 전달하는 역할
    @IBAction func nameTextFieldChanged(_ sender: UITextField) {
        viewModel.name.value = sender.text!
        viewModel.checkValidation()
    }
    
    @IBAction func passwordTextFieldChanged(_ sender: UITextField) {
        viewModel.password.value = sender.text!
        viewModel.checkValidation()
    }
    
    @IBAction func emailTextFieldChanged(_ sender: UITextField) {
        viewModel.email.value = sender.text!
        viewModel.checkValidation()
    }
    
    @IBAction func loginButtonClicked(_ sender: UIButton) {
        viewModel.signIn {
            // 화면 전환 코드
        }
    }
}

extension LoginViewController {
    
    // ViewController Role 1. 받아온 데이터를 보여주는 역할
    private func bind() {
        
        // 추후 다른 처리가 발생하면 다른 값을 화면에 출력해줄 수 있기 때문에 다음과 같이 연결
        viewModel.name.bind { text in
            self.nameTextField.text = text
        }

        viewModel.password.bind { text in
            self.passwordTextField.text = text
        }

        viewModel.email.bind { text in
            self.emailTextField.text = text
        }
        
        viewModel.isValid.bind { isValid in
            self.loginButton.isEnabled = isValid
            self.loginButton.backgroundColor = isValid ? .red : .lightGray
        }
    }
}


/*
 
 ViewModel
 
 - id
 - password
 - name
 - email
 
 이메일 유효성 검증, 닉네임 중복 이슈, id 제한(숫자, 대문자) 등 실시간 판단이 필요한 검증이 있다.
 이를 우리는 비즈니스 로직이라고 부른다.
 
 이것을 ViewController에서 처리해줄 수 있지만 그 책임을 덜고
 ViewModel로 분리해서 처리하는 방식을 가져가고 싶다.
 
 */
