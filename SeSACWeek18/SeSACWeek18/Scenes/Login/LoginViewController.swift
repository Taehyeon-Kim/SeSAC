//
//  LoginViewController.swift
//  SeSACWeek18
//
//  Created by taekki on 2022/11/02.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit
import Then

final class LoginViewController: BaseViewController, Bindable {

    typealias ViewModelType = LoginViewModel

    enum Metric {
        static let directionalHorizontalMargin = 24.0
        static let messageLabelTopMargin = 120.0
        static let vStackViewTopMargin = 20.0
        static let stackViewSpacing = 10.0
        static let loginButtonRadius = 4.0
    }
    
    // MARK: - UI
    
    private let messageLabel = UILabel()
    private lazy var vStackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, loginButton])
    private let emailTextField = UITextField()
    private let passwordTextField = UITextField()
    private let loginButton = UIButton()
    
    // MARK: - Properties
    
    var viewModel: LoginViewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
    }
    
    override func attributes() {
        view.backgroundColor = .systemBackground
        
        messageLabel.do {
            $0.text = "Login to your Account"
        }
        
        vStackView.do {
            $0.axis = .vertical
            $0.distribution = .fillEqually
            $0.spacing = Metric.stackViewSpacing
        }
        
        emailTextField.do {
            $0.placeholder = "Email"
            $0.borderStyle = .roundedRect
        }
        
        passwordTextField.do {
            $0.placeholder = "Password"
            $0.borderStyle = .roundedRect
        }
        
        loginButton.do {
            $0.setTitle("Log In", for: .normal)
            $0.setTitleColor(.white, for: .normal)
            $0.backgroundColor = .blue
            $0.layer.cornerRadius = Metric.loginButtonRadius
        }
    }
    
    override func hierarchy() {
        view.addSubview(messageLabel)
        view.addSubview(vStackView)
    }
    
    override func constraints() {
        messageLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(Metric.messageLabelTopMargin)
            $0.directionalHorizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(Metric.directionalHorizontalMargin)
        }
        
        vStackView.snp.makeConstraints {
            $0.top.equalTo(messageLabel.snp.bottom).offset(Metric.vStackViewTopMargin)
            $0.directionalHorizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(Metric.directionalHorizontalMargin)
        }
        
        [emailTextField, passwordTextField, loginButton].forEach {
            $0.snp.makeConstraints {
                $0.height.equalTo(50)
            }
        }
    }
}

extension LoginViewController {
    
    func bind() {
        let input = LoginViewModel.Input(
            emailText: emailTextField.rx.text,
            passwordText: passwordTextField.rx.text,
            loginButtonTap: loginButton.rx.tap
        )
        let output = viewModel.transform(input: input)
        
        output.isEnabled
            .bind(to: loginButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        output.isEnabled
            .map { $0 ? UIColor.green : UIColor.red  }
            .bind(to: loginButton.rx.backgroundColor)
            .disposed(by: disposeBag)
        
        output.doLogin
            .withUnretained(self)
            .subscribe()
            .disposed(by: disposeBag)
        
        output.result
            .bind { result in
                print("🕹 성공 시 :: \(result) :: 화면전환하자")
                // TODO: 화면전환코드 작성
            }.disposed(by: disposeBag)
        
        output.error
            .withUnretained(self)
            .bind { vc, error in
                print("✂️ 실패 시 :: \(error)")
                vc.presentAlert(with: error)
                
            }.disposed(by: disposeBag)
    }
    
    private func presentAlert(with title: String) {
        let alertController = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .cancel)
        alertController.addAction(okAction)
        present(alertController, animated: true)
    }
}
