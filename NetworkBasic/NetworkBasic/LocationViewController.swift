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
     - 권한 허용 해야만 알림이 온다.
     - 권한 허용 문구 시스템적으로 최초 한 번만 뜬다.
     - 허용 안 된 경우 애플 설정으로 직접 유도하는 코드를 구성해야 한다.
     
     - 기본적으로 알림은 포그라운드에서 수신되지 않는다. (정책 상)
     - 60초 이상부터 반복이 가능하다. (로컬 알림에서는) / 갯수 제한 64개까지 받을 수 있다. (정책 상) -> 그래서 추가, 제거가 적절하게 필요하다.
     - 커스텀 사운드 30초 제한
     */
    
    /*
     - 1. 뱃지 제거 : Active 시점에 제거하는 것이 맞음(not foreground)
     - ㄴ 뱃지 제거도 생각보다 신경쓸 것이 정말 많다.
     
     - 2. 노티 제거 : 노티의 유효 기간은? - app launching, active, foreground
     - ㄴ 카카오톡은 노티를 하나만 클릭해서 확인해도 다른 노티를 전부 다 날린다.
     - ㄴ 잔디는 노티가 살아있다.
     
     - 3. 포그라운드 실행 : 기본적으로 백그라운드 시점에 알림이 온다. (기본 정책)
     - ㄴ 앱 사용중에도 알림이 오게 하려면 별도 코드가 필요
     
     +a
     - 노티는 앱 실행이 기본인데, 특정 노티르 클릭할 때 원하는 화면(특정 화면)으로 가고 싶다면?
     - 포그라운드 수신 > 카톡 시에도 다른 채팅방에서 온 알림만 옴.
     - ㄴ 특정 화면에서는 안받고 특정 조건에 대해서만 포그라운드 수신을 하고 싶다면?
     - iOS 15 집중모드 등 5~6 우선순위 존재! (집중 모드를 쓰고 있더라도, 몇 개의 알림은 보내겠다.)
     */
    func sendNotification() {
        let notificationContent = UNMutableNotificationContent() // UNNotificationContent: uneditable한 contents도 있음
        notificationContent.title = "다마고치를 키워보세요."
        notificationContent.subtitle = "오늘 행운의 숫자는 \(Int.random(in: 1...100))입니다."
        notificationContent.body = "저는 다마고치입니다."
        notificationContent.badge = 40
        
        // 언제 보낼 것인가?
        // 1. 시간 간격, 2. 캘린더, 3. 위치에 따라 설정 가능.
        // 시간 간격은 60초 이상 설정해야 반복 가능
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        
        var dateComponent = DateComponents()
        dateComponent.minute = 18
//        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponent, repeats: true)
        
        // 알림 요청
        // identifier:
        // 만약 알림 관리 할 필요 X -> 알림 클릭하면 앱을 켜주는 정도.
        // 만약 알림 관리 할 필요 O -> +1, 고유 이름, 규칙 등
        let request = UNNotificationRequest(identifier: "req", content: notificationContent, trigger: trigger)
        
        notificationCenter.add(request)
    }
}
