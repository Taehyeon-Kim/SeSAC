//
//  AppDelegate.swift
//  FirebaseSample
//
//  Created by taekki on 2022/10/05.
//

import UIKit

import FirebaseCore
import FirebaseMessaging
import RealmSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let config = Realm.Configuration(schemaVersion: 3) { migration, oldSchemaVersion in
            
            if oldSchemaVersion < 1 {   // DetailTodo, List 추가
                
            }
            
            if oldSchemaVersion < 2 {   // EmbeddedObject 추가
            
            }
            
            if oldSchemaVersion < 3 {   // DetailTodo에 deadline 추가
            
            }
        }
        
        Realm.Configuration.defaultConfiguration = config
        
        // aboutRealmMigration()
        UIViewController.swizzleMethod()
        FirebaseApp.configure()
        
        if #available(iOS 10.0, *) {
          // For iOS 10 display notification (sent via APNS)
          UNUserNotificationCenter.current().delegate = self

          let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
          UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions,
            completionHandler: { _, _ in }
          )
        } else {
          let settings: UIUserNotificationSettings =
            UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
          application.registerUserNotificationSettings(settings)
        }

        application.registerForRemoteNotifications()
        
        // 메시지 대리자 설정
        Messaging.messaging().delegate = self
        
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

extension AppDelegate: UNUserNotificationCenterDelegate {
    
    func application(application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
      Messaging.messaging().apnsToken = deviceToken
    }
    
    // 포그라운드 알림 수신: 로컬/푸시 동일
    // .banner, .list: iOS14+ (= .alert 옵션)
    // 카카오톡: 특정 푸시마다 설정, 화면마다 설정
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        // 세팅 화면에 있다면 포그라운드 푸시 띄우지 마라
        guard let
                viewController = (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.window?.rootViewController?.topViewController
        else { return }
        
        if viewController is SettingViewController {
            completionHandler([])
        } else {
            completionHandler([.badge, .sound, .banner, .list])
        }
    }
    
    // 푸시 클릭: 호두과자 장바구니 담는 화면
    // 유저가 푸시를 클릭했을때에만 수신 확인 가능
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        print("사용자가 푸시를 클릭했습니다.")
        
        print(response.notification.request.content.body)
        print(response.notification.request.content.userInfo)
        
        let userInfo = response.notification.request.content.userInfo
        
        if userInfo[AnyHashable("sesac")] as? String == "project" {
            print("프로젝트 화면으로 이동")
        } else {
            print("Nothing")
        }
        
        // 화면 전환
        guard let
                viewController = (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.window?.rootViewController?.topViewController
        else { return }
        
        if viewController is ViewController {
            viewController.navigationController?.pushViewController(SettingViewController(), animated: true)
        }
        
        else if viewController is ProfileViewController {
            viewController.dismiss(animated: true)
        }
        
        else if viewController is SettingViewController {
            viewController.navigationController?.popViewController(animated: true)
        }
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        print("APN Receive")
        
        let state = application.applicationState
        
        switch state {
        case .active:
            print("active")
        case .inactive:
            print("inactive")
        case .background:
            print("background")
            application.applicationIconBadgeNumber = application.applicationIconBadgeNumber + 1
        @unknown default:
            fatalError()
        }
    }
}

extension AppDelegate: MessagingDelegate {
    
    // 토큰 갱신 모니터링: 토큰 정보가 언제 바뀌는지 모니터링
    // - 기기를 변경하면 토큰도 변경되지 않을까?
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
      print("Firebase registration token: \(String(describing: fcmToken))")

      let dataDict: [String: String] = ["token": fcmToken ?? ""]
      NotificationCenter.default.post(
        name: Notification.Name("FCMToken"),
        object: nil,
        userInfo: dataDict
      )
      // TODO: If necessary send token to application server.
      // Note: This callback is fired at each app startup and whenever a new token is generated.
    }
}

extension AppDelegate {
    
    private func aboutRealmMigration() {
        // deleteRealmIfMigrationNeeded: 마이그레이션이 필요한 경우 기존 Realm 삭제
        // Realm Browser 닫고 다시 열기
        // let config = Realm.Configuration(schemaVersion: 0, deleteRealmIfMigrationNeeded: true)
        
        let config = Realm.Configuration(schemaVersion: 6) { migration, oldSchemaVersion in
            
            // if ~ else 블록이 아니라 if 블록을 사용해야 함
            // 순차적으로 버전을 체크하면서 반영해야 함
            if oldSchemaVersion < 1 {
                
            }
            
            // 컬럼, 테이블 단순 추가, 삭제의 경우에는 별도 코드 필요 없음
            if oldSchemaVersion < 2 {
                
            }
            
            if oldSchemaVersion < 3 {
                migration.renameProperty(onType: Todo.className(), from: "importance", to: "favorite")
            }
            
            if oldSchemaVersion < 4 {
                migration.enumerateObjects(ofType: Todo.className()) { oldObject, newObject in
                    guard let oldObject else { return }
                    guard let newObject else { return }
                    
                    // 초기값을 넣는거라면 단순히 값을 부여해주면 됨
                    newObject["userDescription"] = "\(oldObject["title"]!)의 중요도는 \(oldObject["favorite"]!)입니다."
                }
            }
            
            if oldSchemaVersion < 5 {
                migration.enumerateObjects(ofType: Todo.className()) { _, newObject in
                    guard let newObject else { return }
                    // 초기값 부여
                    newObject["count"] = 100
                }
            }
            
            // Int -> Double
            if oldSchemaVersion < 6 {
                migration.enumerateObjects(ofType: Todo.className()) { oldObject, newObject in
                    guard let oldObject else { return }
                    guard let newObject else { return }
                    
                    // 단순 타입 변경
                    // new required, old optional
                    newObject["favorite"] = oldObject["favorite"]
                    
                    // new optional, old optional
                    // newObject["favorite"] = oldObject["favorite"]
                }
            }
            
            // Int -> Double
            if oldSchemaVersion < 7 {
                migration.enumerateObjects(ofType: Todo.className()) { oldObject, newObject in
                    guard let oldObject else { return }
                    guard let newObject else { return }
                    
                    // 단순 타입 변경
                    // new required, old optional
                    newObject["count"] = oldObject["count"]
                }
            }
        }
        
        Realm.Configuration.defaultConfiguration = config
    }
}
