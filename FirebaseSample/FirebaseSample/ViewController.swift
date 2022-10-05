//
//  ViewController.swift
//  FirebaseSample
//
//  Created by taekki on 2022/10/05.
//

import UIKit
import FirebaseAnalytics

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Analytics.logEvent("share_image", parameters: [
          "name": "name",
          "full_text": "text",
        ])
        
        Analytics.setDefaultEventParameters([
          "level_name": "Caverns01",
          "level_difficulty": 4
        ])
    }


    @IBAction func crashClicked(_ sender: UIButton) {
    }
}

