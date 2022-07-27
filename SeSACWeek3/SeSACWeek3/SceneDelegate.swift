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
            let sb = UIStoryboard(name: "Trend", bundle: nil)
            guard let vc = sb.instantiateViewController(withIdentifier: "BucketlistTableViewController") as? BucketlistTableViewController else { return }
            self.window?.rootViewController = vc // 어떤 뷰 컨트롤러를 보여주겠다.
        } else {
            let sb = UIStoryboard(name: "Search", bundle: nil)
            guard let vc = sb.instantiateViewController(withIdentifier: "SearchTableViewController") as? SearchTableViewController else { return }
            self.window?.rootViewController = UINavigationController(rootViewController: vc)
        }

        self.window?.makeKeyAndVisible()     // Window가 뷰 컨트롤러를 화면에 비춰주는 역할
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

