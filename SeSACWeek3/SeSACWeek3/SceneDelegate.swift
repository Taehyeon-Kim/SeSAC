//
//  SceneDelegate.swift
//  SeSACWeek3
//
//  Created by taekki on 2022/07/18.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    // 시작 화면을 연결하기 전에 해당 메서드에서 통제
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let scene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: scene)
        
        // 이 코드는 다른 화면에 배치해야 함.
        // 시작할때마다 저장.
        UserDefaults.standard.set(true, forKey: "First")
        
        // true이면 ViewController, false이면 SearchTableViewController
        if UserDefaults.standard.bool(forKey: "First") {
            let sb = UIStoryboard(name: "Shopping", bundle: nil)
            guard let vc = sb.instantiateViewController(withIdentifier: "ShoppingTableViewController") as? ShoppingTableViewController else { return }
            self.window?.rootViewController = UINavigationController(rootViewController: vc) // 어떤 뷰 컨트롤러를 보여주겠다.
        } else {
            let sb = UIStoryboard(name: "Search", bundle: nil)
            guard let vc = sb.instantiateViewController(withIdentifier: "SearchTableViewController") as? SearchTableViewController else { return }
            self.window?.rootViewController = UINavigationController(rootViewController: vc)
        }

        self.window?.makeKeyAndVisible()     // Window가 뷰 컨트롤러를 화면에 비춰주는 역할
    }
}

