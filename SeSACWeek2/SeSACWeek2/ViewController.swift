//
//  ViewController.swift
//  SeSACWeek2
//
//  Created by taekki on 2022/07/11.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var purpleView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        purpleView.layer.cornerRadius = 20
        purpleView.clipsToBounds = false
    }
}

