//
//  ViewController.swift
//  SeSACWeek2
//
//  Created by taekki on 2022/07/11.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presentAlert()
    }
    
    func presentAlert() {
//        let alert = UIAlertController(title: "타이틀", message: "여기는 메시지가 들어갑니다." , preferredStyle: .alert)
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        let webAction = UIAlertAction(title: "새 창으로 열기", style: .destructive, handler: nil)
        let copyAction = UIAlertAction(title: "복사", style: .default, handler: nil)
        
        alert.addAction(copyAction)
        alert.addAction(webAction)
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        
        self.present(alert, animated: true) {
            print("내부적인 처리/통계 등")
            print("Screen Shot Capture")
        }
    }
}

