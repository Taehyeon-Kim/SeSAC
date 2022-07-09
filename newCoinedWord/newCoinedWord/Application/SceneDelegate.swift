//
//  SceneDelegate.swift
//  newCoinedWord
//
//  Created by taehy.k on 2022/07/09.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let searchViewController = UIStoryboard(name: "SearchViewController", bundle: nil).instantiateViewController(withIdentifier: "SearchViewController")
        
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = searchViewController
        window?.makeKeyAndVisible()
    }
}

