//
//  ViewController.swift
//  SeSACWeek18
//
//  Created by taekki on 2022/11/02.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        APIService.shared.login()
    }
}
