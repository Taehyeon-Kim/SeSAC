//
//  AppDelegate.swift
//  NetworkBasic
//
//  Created by taekki on 2022/07/27.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // 노티 제거
//        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
        // 이미 도착한 노티만 제거한다.
        // 특정 노티만 제거 - ex. 특정 채팅방만 제거, 구분해서 몇 가지의 노티만 제거할 때, 특가 알림
        // ㄴ identifier의 관리 필요
        
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().delegate = self
        // 노티피케이션은 예약을 한다.
        // 예약된(받을 예정인) 노티도 모두 제거하고 싶다.
        // 알람 앱, 미리 알림 스케줄 할 일 목록 > 하루 전 알림 30분전 알림
        
        return true
    }
    
    // 포그라운드 가보자~~
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        // iOS 14.0 list, banner <-> alert
//        completionHandler([.list, .banner, .badge, .sound])
        completionHandler([.list])
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

