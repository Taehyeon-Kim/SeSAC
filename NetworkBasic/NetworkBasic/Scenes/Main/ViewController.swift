//
//  ViewController.swift
//  NetworkBasic
//
//  Created by taekki on 2022/07/27.
//

import UIKit

class ViewController: UIViewController, ViewPresentable {
    static var identifier: String = "TITLE"
    var navigationTitleString: String = "대장님의 다마고치"
    var backgroundColor: UIColor = .blue

    func configureView() {
        self.backgroundColor = .yellow
        self.view.backgroundColor = backgroundColor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
        
        UserDefaultsHelper.standard.nickname = "고래밥"
        title = UserDefaultsHelper.standard.nickname
        UserDefaultsHelper.standard.age = 24
        
        print(UserDefaultsHelper.standard.age)
    }
}

extension ViewController {

}

