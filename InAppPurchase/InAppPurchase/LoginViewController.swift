//
//  LoginViewController.swift
//  InAppPurchase
//
//  Created by taekki on 2022/11/29.
//

import UIKit

final class LoginViewController: UIViewController {
    
    @IBOutlet weak var descLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        descLabel.accessibilityIdentifier = "descLabel"
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        descLabel.text = "로그인 버튼을 눌렀습니다."
    }
}

extension LoginViewController {
    
}
