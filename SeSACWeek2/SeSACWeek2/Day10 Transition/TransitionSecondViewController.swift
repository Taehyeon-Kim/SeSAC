//
//  TransitionSecondViewController.swift
//  SeSACWeek2
//
//  Created by taekki on 2022/07/15.
//

import UIKit

class TransitionSecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("TransitionSecondViewController", #function)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("TransitionSecondViewController", #function)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("TransitionSecondViewController", #function)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("TransitionSecondViewController", #function)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("TransitionSecondViewController", #function)
    }
    
    deinit {
        print("TransitionSecondViewController - deinit")
    }
}
