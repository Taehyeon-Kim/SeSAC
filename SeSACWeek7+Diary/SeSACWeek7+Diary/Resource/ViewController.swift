//
//  ViewController.swift
//  SeSACWeek7+Diary
//
//  Created by taekki on 2022/08/16.
//

import UIKit
import SeSACUIFramework

class ViewController: UIViewController {
    
    lazy var nameButton: UIButton = {
        let view = UIButton()
        view.setTitle("닉네임", for: .normal)
        view.setTitleColor(UIColor.black, for: .normal)
        view.backgroundColor = .blue
        view.addTarget(self, action: #selector(nameButtonClicked), for: .touchUpInside)
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(sendButtonNotificationObserver),
            name: Notification.Name("saveButtonNotification"),
            object: nil
        )
    }
    
    func configure() {
        view.addSubview(nameButton)
        
        nameButton.snp.makeConstraints {
            $0.width.height.equalTo(200)
            $0.center.equalTo(view)
        }
    }
    
    @objc func nameButtonClicked() {
        
        NotificationCenter.default.post(
            name: Notification.Name("Test"),
            object: nil,
            userInfo: ["name": "\(Int.random(in: 1...100))"]
        )
        
        let controller = ProfileViewController()
        controller.addObservers()
        controller.saveButtonActionHandler = { name in
            print("2")
            self.nameButton.setTitle(name, for: .normal)
        }
        present(controller, animated: true)
    }
    
    /*
     userInfo: [AnyHashable: Any]
     - value 자리는 Any 타입이기 때문에 원하는 상황에 적절한 타입으로 사용하고 싶다면 다운 캐스팅을 해주어야 한다.
     */
    @objc func sendButtonNotificationObserver(_ notification: NSNotification) {
        if let name = notification.userInfo?["name"] as? String {
            print(name)
            self.nameButton.setTitle(name, for: .normal)
        }
    }
}
