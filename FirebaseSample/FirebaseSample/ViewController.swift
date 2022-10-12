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

extension UIViewController {
    
    var topViewController: UIViewController? {
        return self.topViewController(of: self)
    }
    
    // 최상위 뷰 컨트롤러를 판단해주는 메서드
    // 1) 탭바컨트롤러와 관련 화면
    // 2) 네비게이션컨트롤러와 관련 화면
    // 3) push 되어있는 화면
    // 3) 그 외 화면
    private func topViewController(of currentViewController: UIViewController) -> UIViewController {
        if let tabBarController = currentViewController as? UITabBarController,
           let selectedViewController = tabBarController.selectedViewController {
            return self.topViewController(of: selectedViewController)
            
        } else if let navigationController = currentViewController as? UINavigationController,
                  let visibleViewController = navigationController.visibleViewController {
            return self.topViewController(of: visibleViewController)
            
        } else if let presentedViewController = currentViewController.presentedViewController {
            return self.topViewController(of: presentedViewController)
            
        } else {
            return currentViewController
        }
    }
}
