//
//  SignUpViewController.swift
//  Movie
//
//  Created by taehy.k on 2022/07/07.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet var userInputTextFields: [UITextField]!
    @IBOutlet weak var additionalInputButton: UIButton!
    @IBOutlet weak var toggleButton: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLabel()
    }
    
    private func configureLabel() {
        titleLabel.text = "TAEFLIX"
        titleLabel.textColor = .red
        titleLabel.font = UIFont.boldSystemFont(ofSize: 30)
        titleLabel.textAlignment = .center
    }
}
