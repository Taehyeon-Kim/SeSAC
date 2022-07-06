//
//  ViewController.swift
//  Movie
//
//  Created by taehy.k on 2022/07/06.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var posterImageViews: [UIImageView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        posterImageViews.forEach {
            $0.layer.cornerRadius = $0.frame.width / 2
            $0.layer.borderWidth = 2.0
            $0.layer.borderColor = UIColor.systemGray3.cgColor
        }
    }
}

