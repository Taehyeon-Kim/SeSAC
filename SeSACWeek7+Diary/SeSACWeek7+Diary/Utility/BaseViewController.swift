//
//  BaseViewController.swift
//  SeSACWeek7+Diary
//
//  Created by taekki on 2022/08/19.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        configure()
    }
    
    func configure() {}
    
    func showAlertMessage(title: String, buttonTitle: String) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let ok = UIAlertAction(title: buttonTitle, style: .cancel)
        alert.addAction(ok)
        present(alert, animated: true)
    }
}
