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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("ViewController - viewWillAppear")
    }

    @IBAction func profileButtonTapped(_ sender: UIButton) {
        let viewController = ProfileViewController()
        present(viewController, animated: true)
    }
    
    @IBAction func settingButtonTapped(_ sender: UIButton) {
        let viewController = SettingViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
}

final class ProfileViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("ProfileViewController - viewWillAppear")
    }
}

final class SettingViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkGray
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("SettingViewController - viewWillAppear")
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

extension UIViewController {
    
    class func swizzleMethod() {
        
        let origin = #selector(viewWillAppear)
        let change = #selector(changeViewWillAppear)
        
        guard
            let originMethod = class_getInstanceMethod(UIViewController.self, origin),
            let changeMethod = class_getInstanceMethod(UIViewController.self, change)
        else {
            print("함수를 찾을 수 없거나 오류 발생")
            return
        }
        
        method_exchangeImplementations(originMethod, changeMethod)
    }
    
    @objc func changeViewWillAppear() {
        print("swizzle ~~ 👀")
    }
}
