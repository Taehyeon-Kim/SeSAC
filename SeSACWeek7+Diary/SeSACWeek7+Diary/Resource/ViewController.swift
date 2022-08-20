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
        
        Notification.Name.name.addObserver { notification in
            if let name = notification.userInfo?["name"] as? String {
                print(name)
                self.nameButton.setTitle(name, for: .normal)
            }
        }
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
}
