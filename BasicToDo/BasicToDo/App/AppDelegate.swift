//
//  AppDelegate.swift
//  BasicToDo
//
//  Created by taekki on 2022/11/04.
//

import UIKit
import Swinject

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    let container = Container()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        container.register(Repository.self) { _ in
            UserDefaultRepository()
        }
        
        container.register(ToDoService.self) { c in
            let repository = c.resolve(Repository.self)!
            return ToDoServiceImpl(repository: repository)
        }
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}

func Inject<Service>(_ serviceType: Service.Type) -> Service? {
    (UIApplication.shared.delegate as? AppDelegate)?.container.resolve(serviceType)
}

