//
//  ViewController.swift
//  SeSACWeek7+Diary
//
//  Created by taekki on 2022/08/16.
//

import UIKit
import SeSACUIFramework

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func testOpen() {
        //
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // 스토리보드와 클래스를 엮어주는 작업 자체가 없어짐
        let vc = CodeViewController()
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
        
        // open(o) / internal, fileprivate, private(x)
//        testOpen()
        
        // public(o)
//        showSeSACAlert(title: "테스트 얼럿", message: "테스트 메시지", buttonTitle: "저장") { _ in
//            self.view.backgroundColor = .blue
//        }
        
//        let image = UIImage(systemName: "star.fill")!
//        let shareURL = "https://www.apple.com"
//        let shareText = "Hello, world"
//        sesacShowActivityViewController(shareImage: image, shareURL: shareURL, shareText: shareText)
        
        OpenWebView.presentWebViewController(self, url: "https://www.apple.com", transitionStyle: .present)
    }
}
