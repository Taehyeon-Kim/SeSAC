//
//  ViewController.swift
//  SeSACWeek7+Diary
//
//  Created by taekki on 2022/08/16.
//

import UIKit
import SeSACUIFramework

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // open(o) / internal, fileprivate, private(x)
        testOpen()
        
        // public(o)
        showSeSACAlert(title: "테스트 얼럿", message: "테스트 메시지", buttonTitle: "저장") { _ in
            self.view.backgroundColor = .blue
        }
    }
}

