//
//  BaseViewController.swift
//  Movie
//
//  Created by taekki on 2022/08/19.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialUI()
        configureLayout()
    }
    
    func initialUI() {}
    func configureLayout() {}
}
