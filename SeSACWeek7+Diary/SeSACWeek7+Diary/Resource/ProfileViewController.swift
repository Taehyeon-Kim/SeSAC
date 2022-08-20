//
//  ProfileViewController.swift
//  SeSACWeek7+Diary
//
//  Created by taekki on 2022/08/18.
//

import UIKit

extension NSNotification.Name {
    
    // - 보통 이렇게 관리함.
    
    static let saveButton = NSNotification.Name("saveButtonNotification")
}

class ProfileViewController: UIViewController {
    
    let saveButton: UIButton = {
        let view = UIButton()
        view.setTitle("저장", for: .normal)
        view.backgroundColor = .black
        return view
    }()
    
    let nameTextField: UITextField = {
        let view = UITextField()
        view.placeholder = "이름을 입력하세요."
        view.backgroundColor = .brown
        view.textColor = .white
        return view
    }()
    
    var saveButtonActionHandler: ((String) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .yellow
        configure()
        saveButton.addTarget(self, action: #selector(saveButtonClicked), for: .touchUpInside)
    }
    
    func addObservers() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(saveButtonNotificationObserver),
            name: Notification.Name("Test"),
            object: nil
        )
    }
    
    func configure() {
        [saveButton, nameTextField].forEach { view.addSubview($0) }
        
        nameTextField.snp.makeConstraints {
            $0.leading.trailing.equalTo(view).inset(50)
            $0.top.height.equalTo(50)
        }
        
        saveButton.snp.makeConstraints {
            $0.width.height.equalTo(100)
            $0.center.equalTo(view)
        }
    }
    
    @objc func saveButtonClicked() {
        
        Notification.Name.name.post(
            object: nil,
            userInfo: ["name": nameTextField.text!, "value": 123456]
        )

        // 값 전달 기능 실행 => 클로저 구문 활용
//        guard let text = nameTextField.text else { return }
//        print("1")
//        saveButtonActionHandler?(text)
        
        // 화면 dismiss
        dismiss(animated: true)
    }
    
    @objc func saveButtonNotificationObserver(_ notification: NSNotification) {
        print(#function)
        if let name = notification.userInfo?["name"] as? String {
            print(name)
            self.nameTextField.text = name
        }
    }
}
