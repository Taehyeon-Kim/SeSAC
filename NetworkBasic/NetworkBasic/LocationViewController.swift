//
//  LocationViewController.swift
//  NetworkBasic
//
//  Created by taekki on 2022/07/29.
//

import UIKit

class LocationViewController: UIViewController {

    // Notification 1. 인스턴스 생성
    let notificationCenter = UNUserNotificationCenter.current()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func notificationButtonClicked(_ sender: UIButton) {
        self.requestAuthorization()
    }
    
    // Notification 2. 권한 요청
    func requestAuthorization() {
        let authorizationOptions = UNAuthorizationOptions(arrayLiteral: .alert, .badge, .sound)
        self.notificationCenter.requestAuthorization(options: authorizationOptions) { success, error in
            
            if success {
                self.sendNotification()
            }
        }
    }
    
    // Notification 3. 권한 허용한 사용자에게 알림 요청(언제? 어떤 컨텐츠?)
    // iOS 시스템에서 알림을 담당(총괄) > 알림을 등록하는 과정이 필요
    /*
     - 뱃지 제거
     - 노티 제거
     - 포그라운드 실행 : 기본적으로 백그라운드 시점에 알림이 온다. (기본 정책)
     */
    func sendNotification() {
        let notificationContent = UNMutableNotificationContent() // UNNotificationContent: uneditable한 contents도 있음
        notificationContent.title = "다마고치를 키워보세요."
        notificationContent.body = "오늘 행운의 숫자는 \(Int.random(in: 1...100))입니다."
        notificationContent.badge = 40
        
        // 언제 보낼 것인가?
        // 1. 시간 간격, 2. 캘린더, 3. 위치에 따라 설정 가능.
        // 시간 간격은 60초 이상 설정해야 반복 가능
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        var dateComponent = DateComponents()
        dateComponent.minute = 18
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponent, repeats: true)
        
        // 알림 요청
        // identifier:
        // 만약 알림 관리 할 필요 X -> 알림 클릭하면 앱을 켜주는 정도.
        // 만약 알림 관리 할 필요 O -> +1, 고유 이름, 규칙 등
        let request = UNNotificationRequest(identifier: "req", content: notificationContent, trigger: trigger)
        
        notificationCenter.add(request)
    }
}
