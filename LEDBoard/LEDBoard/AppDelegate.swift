//
//  AppDelegate.swift
//  LEDBoard
//
//  Created by taehy.k on 2022/07/06.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // 사용자 정보 체크
        // 데이터 체크
        // 업데이트 최신화 확인
        
        // 위험할 수 있다. (이 시간 동안 어떤 로직도 수행되지 않는다. 그렇기에 로직이 복잡하면 지양하는 것이 좋다.)
        sleep(2)
        
        return true
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // 앱이 백그라운드 상태로 들어갈 때
        // Melon, Youtube - 만약에 사용자가 프리미엄 결제자이면 백그라운드에서 돌아가도록(play) 하고, 그게 아니라면 중단(stop)시키라고 분기 처리 가능
    }
    
    // ❗️ 예시가 너무 흥미롭다.
    func applicationWillEnterForeground(_ application: UIApplication) {
        // 프리미엄 결제자가 아닌 유저에게 결제 유도 팝업을 띄울 때 사용할 수 있다. (Background -> Active)
        // 카카오톡 사용 시 - 백그라운드에서 앱 사용 상태로 다시 돌아올 때 잠금 화면을 띄우는 상황
        // 금융 앱 사용 시 - 백그라운드에 있을 때, 화면이 안 보이도록 처리 (화면 하나를 위쪽에 씌우는 식으로 처리, 그리고 실제 앱이 실행되면 화면을 걷어내는 식으로 관리 가능)
    }

    // MARK: UISceneSession Lifecycle
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

