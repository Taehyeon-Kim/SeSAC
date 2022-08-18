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
    }
    
    func configure() {
        view.addSubview(nameButton)
        
        nameButton.snp.makeConstraints {
            $0.width.height.equalTo(200)
            $0.center.equalTo(view)
        }
    }
    
    @objc func nameButtonClicked() {
        let controller = ProfileViewController()
        controller.saveButtonActionHandler = { name in
            print("2")
            self.nameButton.setTitle(name, for: .normal)
        }
        present(controller, animated: true)
    }
}
