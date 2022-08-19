//
//  NewSignUpViewController.swift
//  Movie
//
//  Created by taekki on 2022/08/19.
//

import UIKit

final class NewSignUpViewController: BaseViewController {
    
    let signUpView = SignUpView()
    
    override func loadView() {
        self.view = signUpView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func initialUI() {
        view.backgroundColor = .black
    }
}
